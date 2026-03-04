---
render_with_liquid: false
title: "How we made global routing faster with Bloom filters - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-made-global-routing-faster-with-bloom-filters"
date: "2025-09-19"
scraped_at: "2026-03-02T09:28:06.176723240+00:00"
language: "en-zh"
translated: true
description: "We replaced slow JSON path lookups with Bloom filters in our global routing service, cutting memory usage by 15% and reducing 99th percentile lookup times from hundreds of milliseconds to under 1 ms. ..."
---
render_with_liquid: false
render_with_liquid: false

Sep 19, 2025

2025 年 9 月 19 日

Recently, we shipped an optimization to our global routing service that reduced its memory usage by 15%, improved time-to-first-byte (TTFB) from the 75th percentile and above by 10%, and significantly improved routing speeds for websites with many static paths.

近期，我们对全球路由服务实施了一项优化：内存占用降低了 15%，第 75 百分位及更高分位的首字节时间（TTFB）提升了 10%，并显著加快了拥有大量静态路径的网站的路由速度。

A small number of websites, with hundreds of thousands of static paths, were creating a bottleneck that slowed down our entire routing service. By replacing a slow JSON parsing operation with a Bloom filter, we brought path lookup latency down to nearly zero and improved performance for everyone.

少数几个网站拥有数十万条静态路径，由此形成了性能瓶颈，拖慢了整个路由服务。我们以布隆过滤器（Bloom filter）替代了低效的 JSON 解析操作，将路径查找延迟降至近乎为零，从而提升了所有用户的性能表现。

## The path lookup operation

## 路径查找操作

When you make a request to a Vercel deployment, our routing service first checks whether the requested path exists before attempting to serve it. This prevents unnecessary requests to storage and protects against [enumeration attacks](https://www.upguard.com/blog/what-is-an-enumeration-attack), where attackers try to discover hidden files by guessing URLs.

当你向 Vercel 部署发起请求时，我们的路由服务会首先检查所请求的路径是否存在，再决定是否提供服务。此举可避免向存储系统发送不必要的请求，并防范[枚举攻击（enumeration attacks）](https://www.upguard.com/blog/what-is-an-enumeration-attack)——即攻击者通过猜测 URL 来发现隐藏文件的行为。

We do this by generating a JSON file on build that contains a tree of every path in your project's [build outputs](https://vercel.com/docs/build-output-api), including static assets, pages, API routes, webpack chunks, and Next.js route segments.

我们通过在构建阶段生成一个 JSON 文件来实现该功能，该文件包含项目[构建输出（build outputs）](https://vercel.com/docs/build-output-api)中所有路径组成的树状结构，涵盖静态资源、页面、API 路由、webpack 代码块以及 Next.js 路由片段等。

Before serving a request, the routing service consults this JSON file and checks if the path exists. If it doesn't, we immediately return a 404. This early check ensures we only fetch documents from storage when we're sure they exist.

在响应请求前，路由服务会查询该 JSON 文件，校验路径是否存在；若不存在，则立即返回 404 状态码。这一前置检查机制确保我们仅在确认文档存在的情况下才从存储系统中读取数据。

![How the routing service checks if a requested path exists before serving it.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_001.jpg)![How the routing service checks if a requested path exists before serving it.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_002.jpg)![How the routing service checks if a requested path exists before serving it.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_003.jpg)![How the routing service checks if a requested path exists before serving it.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_004.jpg)如何在提供服务前，由路由服务检查所请求路径是否存在。

In most cases, this works great:

在大多数情况下，该机制运行良好：

- The majority of apps generate small path lookups that parse in under a millisecond  
- 绝大多数应用生成的路径查找数据量较小，JSON 解析耗时低于 1 毫秒

- 90th percentile lookups take on average 4 milliseconds

- 第90百分位的查找平均耗时为4毫秒

- There's no noticeable impact on performance

- 对性能没有明显影响


But some websites generate massive path lists:

但某些网站会生成海量的路径列表：

- E-commerce sites with large product catalogs

- 商品目录庞大的电商平台

- Documentation sites with thousands of pages

- 拥有数千页内容的文档网站

- Applications with dynamic routing

- 采用动态路由的应用程序


These sites can create 1.5+ megabyte lookup files that take dramatically longer to parse. At the 99th percentile, parsing this JSON file takes about 100 milliseconds; at the 99.9th percentile, it takes about 250 milliseconds.

这类网站可能生成超过1.5兆字节的查找文件，解析耗时显著增加：在第99百分位，解析该JSON文件约需100毫秒；在第99.9百分位，则需约250毫秒。

Given that our routing service is single-threaded, parsing this JSON file also blocks the event loop. This means that for those websites whose path lookups take 250 milliseconds to parse, it literally takes 250 milliseconds longer to serve the website while we wait for the operation to finish.

鉴于我们的路由服务是单线程的，解析该JSON文件还会阻塞事件循环。这意味着，对于那些路径查找需耗时250毫秒来解析的网站，我们在等待该操作完成期间，网站响应实际会延迟250毫秒。

## Enter Bloom filters!

## 引入布隆过滤器（Bloom filters）！

A Bloom filter is a probabilistic data structure that can be used to test whether an element, or key, is a member of a set. To insert a key, it is hashed multiple times, and the indices corresponding to each hash are set to 1. To query, you hash the key like above and check each index. If any are 0, the key is not in the Bloom filter.

布隆过滤器是一种概率型数据结构，可用于判断某个元素（或键）是否属于一个集合。插入一个键时，需对该键进行多次哈希运算，并将每次哈希结果所对应的索引位置置为1；查询时，同样对键进行多次哈希，并检查所有对应索引位置的值——若其中任意一个为0，则可确定该键不在布隆过滤器中。

![How a Bloom filter inserts and queries keys using multiple hash functions.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_005.jpg)  
![布隆过滤器如何使用多个哈希函数插入和查询键。](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_005.jpg)  

![How a Bloom filter inserts and queries keys using multiple hash functions.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_006.jpg)  
![布隆过滤器如何使用多个哈希函数插入和查询键。](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_006.jpg)  

![How a Bloom filter inserts and queries keys using multiple hash functions.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_007.jpg)  
![布隆过滤器如何使用多个哈希函数插入和查询键。](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_007.jpg)  

![How a Bloom filter inserts and queries keys using multiple hash functions.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_008.jpg)  
![布隆过滤器如何使用多个哈希函数插入和查询键。](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_008.jpg)  

How a Bloom filter inserts and queries keys using multiple hash functions.  

布隆过滤器如何使用多个哈希函数插入和查询键。

Bloom filters can return false positives, but never false negatives. For path lookups, this property is valuable. If the Bloom filter says a path does not exist, we can safely return a 404; if it says a path might exist, we fall back to checking the build outputs.  

布隆过滤器可能产生误报（false positives），但绝不会产生漏报（false negatives）。这一特性对路径查找非常有价值：若布隆过滤器判定某路径不存在，我们可安全返回 404；若它判定该路径“可能存在”，则回退至检查构建产物以进一步确认。

This makes Bloom filters a good match for the problem:  

这使得布隆过滤器成为该问题的理想解决方案：

- We can't afford false negatives (returning 404 for valid pages), and Bloom filters guarantee this won't happen  
- 我们无法承受漏报（即对有效页面返回 404），而布隆过滤器能严格保证不发生此类情况  

- False positives just trigger an extra storage request to find the file doesn't exist  
- 误报仅会触发一次额外的存储请求，用于确认目标文件确实不存在  

- Bloom filters are dramatically smaller and faster than storing the actual path list  
- 布隆过滤器的体积显著更小、查询速度显著更快，远优于直接存储完整路径列表  

## How the new path lookup optimization works  

## 新路径查找优化的工作原理  

The main challenge was coordinating Bloom filter implementations across two services written in different languages:  

主要挑战在于协调两种不同编程语言编写的服务之间布隆过滤器的实现：

- **Build service**: Generates Bloom filter from all deployment paths  
- **构建服务（Build service）**：基于所有部署路径生成布隆过滤器  

- **Routing service**: Queries Bloom filter for incoming requests  
- **路由服务（Routing service）**：针对每个入站请求查询布隆过滤器

Both needed identical Bloom filter logic to ensure compatibility. We implemented matching Bloom filter algorithms in both codebases.

为确保兼容性，双方都需要完全相同的布隆过滤器逻辑。我们在两个代码库中实现了匹配的布隆过滤器算法。

### The deploy process

### 部署流程

The build service now uploads a JSON Lines (JSONL) file, which looks like this:

构建服务现在上传一个 JSON Lines（JSONL）文件，格式如下：

```json
1{"version":"test","bloom":{"n":10,"p":1e-7,"m":336,"k":23,"s":0}}

2"0kxC4anU4awVOYSs54vsAL7gBNGK/PrLjKrAJRil64mMxmiig1S+jqyC"
```

The first line is a JSON object containing the Bloom filter parameters:

第一行是一个 JSON 对象，包含布隆过滤器的各项参数：

- `n`: number of elements in the Bloom filter  
- `n`：布隆过滤器中预期插入的元素数量  

- `p`: desired error rate  
- `p`：期望的误判率（假阳性率）  

- `m`: size of the bit array  
- `m`：位数组的大小（以比特为单位）  

- `k`: number of hash functions  
- `k`：哈希函数的数量

- `s`: seed for the first hash function

- `s`: 第一个哈希函数的种子值

The second line is the Bloom filter buffer encoded as Base64. Even Base64 encoded, this Bloom filter is 70–80% smaller than the previous JSON file, which makes it faster to upload during builds and to parse in our routing service.

第二行为以 Base64 编码的布隆过滤器（Bloom filter）缓冲区。即使经过 Base64 编码，该布隆过滤器的体积仍比此前的 JSON 文件小 70–80%，从而显著加快了构建过程中的上传速度，以及在路由服务中的解析速度。

### Serving routes

### 路由分发

Our routing service now fetches the paths file, creates a Bloom filter, and checks membership against the requested path.

我们的路由服务现在会获取路径文件，构建一个布隆过滤器，并针对请求的路径执行成员资格检查。

Although the Bloom filter is represented in the file as a Base64 string, we don’t actually want to treat it as a string. String operations are expensive, and they’re the reason why the previous approach is so slow. The goal of this optimization is precisely to avoid them.

尽管该布隆过滤器在文件中以 Base64 字符串形式表示，但我们实际上并不希望将其当作字符串来处理。字符串操作开销较大，而这正是此前方案性能极低的根本原因。本次优化的目标，正是彻底规避此类字符串操作。

Instead, we can ignore the double quotes and treat the Base64 data as the Bloom filter directly. Then, when checking membership, we can decode each byte as needed.

相反，我们可以忽略双引号，直接将 Base64 数据视作布隆过滤器本身；在执行成员资格检查时，再按需逐字节解码即可。

```lua
1-- Fast lookup table for translating Base64 characters to their values

2-- This is used to decode the Base64 encoded bit array in the Bloom filter

local b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local decode_table = ffi.new 'uint8_t[256]'
```

```lua
1-- 用于将 Base64 字符快速映射为其对应数值的查找表

2-- 该表用于解码布隆过滤器中经 Base64 编码的位数组

local b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local decode_table = ffi.new 'uint8_t[256]'
```

```lua
for i = 1, #b64 do

for i = 1 到 #b64（b64 字符串长度）循环执行：

6  decode_table[str_byte(b64, i)] = i - 1 -- Base64 values start from 0

6  decode_table[str_byte(b64, i)] = i - 1 -- Base64 数值从 0 开始

end

end


function BloomFilter:has(key)

function BloomFilter:has(key)

10  local ptr = self.ptr -- uint8_t* pointer to start of Base64 string

10  local ptr = self.ptr -- 指向 Base64 字符串起始位置的 uint8_t* 指针

11  for byte_offset, bit_offset in self:iterator(key) do

11  for byte_offset, bit_offset in self:iterator(key) do（遍历 key 对应的字节偏移与比特偏移）

12    local sextet = decode_table[ptr[byte_offset]]

12    local sextet = decode_table[ptr[byte_offset]]

13    if band(sextet, lshift(1, bit_offset)) == 0 then

13    if band(sextet, lshift(1, bit_offset)) == 0 then（若 sextet 在指定比特位上为 0）

14      return false

14      return false
```

15    end

15    结束

16  end

16  结束

17  return true

17  返回 true

end

end

This means the speed at which we can create a Bloom filter is bound by file reading, which is orders of magnitude faster than string creation, so we can create very large Bloom filters nearly instantly.

这意味着我们构建布隆过滤器（Bloom filter）的速度受限于文件读取，而文件读取速度比字符串创建快几个数量级，因此我们可以近乎瞬时地构建非常大的布隆过滤器。

## Near-zero latency and 10% faster routing

## 接近零延迟，路由性能提升 10%

With the Bloom filter in place, the 99th percentile duration for path lookup is about 0.5 milliseconds, which is 200x faster than the JSON parsing approach; and the 99.9th percentile duration is 2.4 milliseconds, which is about 100x faster than the previous approach.

在布隆过滤器就位后，路径查找（path lookup）的第 99 百分位耗时约为 0.5 毫秒，比原先基于 JSON 解析的方法快约 200 倍；第 99.9 百分位耗时为 2.4 毫秒，比此前方法快约 100 倍。

This is amazing for our heaviest websites, which were previously bottlenecked by path lookup. But this improvement has also had ripple effects across our entire routing service.

这对我们的流量最重的网站而言堪称飞跃——这些网站此前正受困于路径查找这一性能瓶颈。但这项改进的影响远不止于此，它还对整个路由服务产生了广泛的积极连锁效应。

It turns out that path lookup for those few heavy websites was disproportionately hogging our routing service’s memory and CPU, which was making it run more slowly across the board. Once we shipped this improvement to path lookup, the heap size and memory usage of the routing service dropped by 15%.

事实证明，那少数几个高负载网站的路径查找操作不成比例地占用了路由服务的内存与 CPU 资源，导致整个服务运行变慢。而在我们将该路径查找优化上线后，路由服务的堆内存大小和整体内存使用量下降了 15%。

![Heap and memory usage reductions after Bloom filter rollout.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_009.jpg)堆内存与内存使用量在布隆过滤器上线后的下降情况。

The reduced heap size relieved garbage collection pressure, a primary bottleneck in JSON parsing, so parsing the old path lookup file (which is still done for projects that haven’t deployed since we rolled out the Bloom filter) also sped up dramatically at all percentiles.

堆内存减小缓解了垃圾回收压力——而垃圾回收正是 JSON 解析过程中的主要瓶颈。因此，解析旧的路径查找文件（对于尚未在我们上线布隆过滤器后重新部署的项目，该操作仍在进行）在所有百分位上也显著加速。

![P50 to P99.9 latencies improved following the switch to Bloom filters.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_010.jpg)  
![切换至布隆过滤器后，P50 至 P99.9 延迟得到改善。](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_010.jpg)  
P50 to P99.9 latencies improved following the switch to Bloom filters.  
切换至布隆过滤器后，P50 至 P99.9 延迟得到改善。

All this culminated in the TTFB from 75th to 99th percentile across all requests served by our routing service becoming 10% faster.

上述所有优化最终使我们的路由服务所处理的所有请求中，第 75 至第 99 百分位的首字节时间（TTFB）提升了 10%。

![P75 and P99 TTFB improved after Bloom filter rollout.](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_011.jpg)  
![布隆过滤器上线后，P75 和 P99 的 TTFB 得到改善。](images/how-we-made-global-routing-faster-with-bloom-filters-vercel/img_011.jpg)  
P75 and P99 TTFB improved after Bloom filter rollout.  
布隆过滤器上线后，P75 和 P99 的 TTFB 得到改善。

By bringing the duration of the path lookup operation down to effectively zero, we’ve eliminated an entire class of memory and CPU intensive processes when we serve websites, which makes it faster for everyone and dramatically faster for our heaviest websites.

通过将路径查找操作的耗时降至近乎零，我们在提供网站服务时彻底消除了一类高内存与高 CPU 消耗的处理流程。这不仅让所有用户访问更快，更使我们负载最重的网站获得极为显著的性能提升。