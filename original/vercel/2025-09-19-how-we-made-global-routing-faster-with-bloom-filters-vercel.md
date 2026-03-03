---
title: "How we made global routing faster with Bloom filters - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-made-global-routing-faster-with-bloom-filters"
date: "2025-09-19"
scraped_at: "2026-03-02T09:28:06.176723240+00:00"
language: "en"
translated: false
description: "We replaced slow JSON path lookups with Bloom filters in our global routing service, cutting memory usage by 15% and reducing 99th percentile lookup times from hundreds of milliseconds to under 1 ms. ..."
---




Sep 19, 2025

Recently, we shipped an optimization to our global routing service that reduced its memory usage by 15%, improved time-to-first-byte (TTFB) from the 75th percentile and above by 10%, and significantly improved routing speeds for websites with many static paths.

A small number of websites, with hundreds of thousands of static paths, were creating a bottleneck that slowed down our entire routing service. By replacing a slow JSON parsing operation with a Bloom filter, we brought path lookup latency down to nearly zero and improved performance for everyone.

## The path lookup operation

When you make a request to a Vercel deployment, our routing service first checks whether the requested path exists before attempting to serve it. This prevents unnecessary requests to storage and protects against [enumeration attacks](https://www.upguard.com/blog/what-is-an-enumeration-attack), where attackers try to discover hidden files by guessing URLs.

We do this by generating a JSON file on build that contains a tree of every path in your project's [build outputs](https://vercel.com/docs/build-output-api), including static assets, pages, API routes, webpack chunks, and Next.js route segments.

Before serving a request, the routing service consults this JSON file and checks if the path exists. If it doesn't, we immediately return a 404. This early check ensures we only fetch documents from storage when we're sure they exist.

![How the routing service checks if a requested path exists before serving it.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_001.jpg)![How the routing service checks if a requested path exists before serving it.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_002.jpg)![How the routing service checks if a requested path exists before serving it.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_003.jpg)![How the routing service checks if a requested path exists before serving it.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_004.jpg)How the routing service checks if a requested path exists before serving it.

In most cases, this works great:

- The majority of apps generate small path lookups that parse in under a millisecond

- 90th percentile lookups take on average 4 milliseconds

- There's no noticeable impact on performance


But some websites generate massive path lists:

- E-commerce sites with large product catalogs

- Documentation sites with thousands of pages

- Applications with dynamic routing


These sites can create 1.5+ megabyte lookup files that take dramatically longer to parse. At the 99th percentile, parsing this JSON file takes about 100 milliseconds; at the 99.9th percentile, it takes about 250 milliseconds.

Given that our routing service is single-threaded, parsing this JSON file also blocks the event loop. This means that for those websites whose path lookups take 250 milliseconds to parse, it literally takes 250 milliseconds longer to serve the website while we wait for the operation to finish.

## Enter Bloom filters!

A Bloom filter is a probabilistic data structure that can be used to test whether an element, or key, is a member of a set. To insert a key, it is hashed multiple times, and the indices corresponding to each hash are set to 1. To query, you hash the key like above and check each index. If any are 0, the key is not in the Bloom filter.

![How a Bloom filter inserts and queries keys using multiple hash functions.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_005.jpg)![How a Bloom filter inserts and queries keys using multiple hash functions.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_006.jpg)![How a Bloom filter inserts and queries keys using multiple hash functions.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_007.jpg)![How a Bloom filter inserts and queries keys using multiple hash functions.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_008.jpg)How a Bloom filter inserts and queries keys using multiple hash functions.

Bloom filters can return false positives, but never false negatives. For path lookups, this property is valuable. If the Bloom filter says a path does not exist, we can safely return a 404; if it says a path might exist, we fall back to checking the build outputs.

This makes Bloom filters a good match for the problem:

- We can't afford false negatives (returning 404 for valid pages), and Bloom filters guarantee this won't happen

- False positives just trigger an extra storage request to find the file doesn't exist

- Bloom filters are dramatically smaller and faster than storing the actual path list


## How the new path lookup optimization works

The main challenge was coordinating Bloom filter implementations across two services written in different languages:

- **Build service**: Generates Bloom filter from all deployment paths

- **Routing service**: Queries Bloom filter for incoming requests


Both needed identical Bloom filter logic to ensure compatibility. We implemented matching Bloom filter algorithms in both codebases.

### The deploy process

The build service now uploads a JSON Lines (JSONL) file, which looks like this:

```json
1{"version":"test","bloom":{"n":10,"p":1e-7,"m":336,"k":23,"s":0}}

2"0kxC4anU4awVOYSs54vsAL7gBNGK/PrLjKrAJRil64mMxmiig1S+jqyC"
```

The first line is a JSON object containing the Bloom filter parameters:

- `n`: number of elements in the Bloom filter

- `p`: desired error rate

- `m`: size of the bit array

- `k`: number of hash functions

- `s`: seed for the first hash function


The second line is the Bloom filter buffer encoded as Base64. Even Base64 encoded, this Bloom filter is 70-80% smaller than the previous JSON file, which makes it faster to upload during builds and to parse in our routing service.

### Serving routes

Our routing service now fetches the paths file, creates a Bloom filter, and checks membership against the requested path.

Although the Bloom filter is represented in the file as a Base64 string, we don’t actually want to treat it as a string. String operations are expensive, and they’re the reason why the previous approach is so slow. The goal of this optimization is precisely to avoid them.

Instead, we can ignore the double quotes and treat the Base64 data as the Bloom filter directly. Then, when checking membership, we can decode each byte as needed.

```lua
1-- Fast lookup table for translating Base64 characters to their values

2-- This is used to decode the Base64 encoded bit array in the Bloom filter

local b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local decode_table = ffi.new 'uint8_t[256]'

for i = 1, #b64 do

6  decode_table[str_byte(b64, i)] = i - 1 -- Base64 values start from 0

end



function BloomFilter:has(key)

10  local ptr = self.ptr -- uint8_t* pointer to start of Base64 string

11  for byte_offset, bit_offset in self:iterator(key) do

12    local sextet = decode_table[ptr[byte_offset]]

13    if band(sextet, lshift(1, bit_offset)) == 0 then

14      return false

15    end

16  end

17  return true

end
```

This means the speed at which we can create a Bloom filter is bound by file reading, which is orders of magnitude faster than string creation, so we can create very large Bloom filters nearly instantly.

## Near-zero latency and 10% faster routing

With the Bloom filter in place, the 99th percentile duration for path lookup is about 0.5 milliseconds, which is 200x faster than the JSON parsing approach; and the 99.9th percentile duration is 2.4 milliseconds, which is about 100x faster than the previous approach.

This is amazing for our heaviest websites, which were previously bottlenecked by path lookup. But this improvement has also had ripple effects across our entire routing service.

It turns out that path lookup for those few heavy websites was disproportionately hogging our routing service’s memory and CPU, which was making it run more slowly across the board. Once we shipped this improvement to path lookup, the heap size and memory usage of the routing service dropped by 15%.

![Heap and memory usage reductions after Bloom filter rollout.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_009.jpg)Heap and memory usage reductions after Bloom filter rollout.

The reduced heap size relieved garbage collection pressure, a primary bottleneck in JSON parsing, so parsing the old path lookup file (which is still done for projects that haven’t deployed since we rolled out the Bloom filter) also sped up dramatically at all percentiles.

![P50 to P99.9 latencies improved following the switch to Bloom filters.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_010.jpg)P50 to P99.9 latencies improved following the switch to Bloom filters.

All this culminated in the TTFB from 75th to 99th percentile across all requests served by our routing service becoming 10% faster.

![P75 and P99 TTFB improved after Bloom filter rollout.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_011.jpg)P75 and P99 TTFB improved after Bloom filter rollout.

By bringing the duration of the path lookup operation down to effectively zero, we’ve eliminated an entire class of memory and CPU intensive processes when we serve websites, which makes it faster for everyone and dramatically faster for our heaviest websites.