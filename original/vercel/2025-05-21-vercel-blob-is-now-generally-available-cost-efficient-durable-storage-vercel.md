---
title: "Vercel Blob is now generally available: Cost-efficient, durable storage - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-blob-now-generally-available"
date: "2025-05-21"
scraped_at: "2026-03-02T09:33:31.317496316+00:00"
language: "en"
translated: false
description: "Vercel Blob is now generally available, providing durable object storage that's integrated with Vercel's application delivery network."
---




May 21, 2025

Vercel Blob is now generally available, providing durable storage that's integrated with Vercel's application delivery network

Storage should be simple to set up, globally available, and built to last, without slowing you down or adding complexity. It should feel native to your app.

That's why we built [Vercel Blob](https://vercel.com/docs/vercel-blob): Amazon S3-backed storage that's deeply integrated with Vercel's global application delivery and automated caching, with predictable pricing to serve public assets cost-efficiently at scale.

Vercel Blob is now generally available. It's already storing and serving over 400 million files, and powers production apps like v0 and the Vercel Dashboard.

![v0 leverages Blob to store millions of files, with many for each generation.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_001.jpg)![v0 leverages Blob to store millions of files, with many for each generation.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_002.jpg)![v0 leverages Blob to store millions of files, with many for each generation.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_003.jpg)![v0 leverages Blob to store millions of files, with many for each generation.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_004.jpg)v0 leverages Blob to store millions of files, with many for each generation.

## Built for performance, durability, and efficiency

Vercel Blob is built for high-volume workloads, whether you’re storing a few profile pictures or terabytes of media.

Vercel Blob introduces [Blob Data Transfer](https://vercel.com/docs/vercel-blob#blob-data-transfer), a new high-volume delivery strategy separate from Fast Data Transfer, that leverages alternative infrastructure to deliver assets at optimized cost. Blob Data Transfer is volume-optimized infrastructure (18 hubs) to deliver assets at optimized cost, while Fast Data Transfer remains latency-optimized (94 cities) for ultra-low latency.

Blob is powered by Amazon's S3 infrastructure, ensuring 99.999999999% of reliability. To put this into context, even with one billion objects stored, you could go 100 years without losing a single one. Blob is built to be always available, resistant to failures, and instantly accessible.

![Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_005.jpg)![Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_006.jpg)![Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_007.jpg)![Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_008.jpg)Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.

## Caching that just works

Vercel Blob’s deep integration with Vercel’s caching infrastructure abstracts away management and configuration, handling data transfer as part of the standard request lifecycle.

When a request for a Blob asset is made:

1. The request is routed to the nearest Vercel Region, like any standard Vercel Edge Request

2. The Region identifies it as a Blob request and queries the Vercel cache

   - On a cache `HIT`, it’s served directly from the cache

   - On a cache `MISS`, the asset is fetched from Blob storage using [Fast Origin Transfer](https://vercel.com/docs/edge-network/manage-usage#fast-origin-transfer) and stored in the cache
3. The response is returned to the user, incurring Blob Data Transfer


By unifying storage and delivery inside Vercel’s network, Blob Data Transfer and the Vercel CDN deliver industry-leading cost-performance efficiency, no separate CDN required.

![Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_009.jpg)![Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_010.jpg)![Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_011.jpg)![Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_012.jpg)Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.

## How Blob fits into your app

Vercel provides an [SDK](https://vercel.com/docs/vercel-blob/using-blob-sdk) to make file uploads easy. Installing `@vercel/blob` makes uploading a file to Blob a single function call. This example creates a Vercel Function that accepts a file and returns a public URL:

```javascript
import { put } from '@vercel/blob';



export async function PUT(request: Request) {

4  const form = await request.formData();

5  const file = form.get('file') as File;

6  const blob = await put(file.name, file, { access: 'public', addRandomSuffix: true });



8  return Response.json(blob);

9}
```

Vercel Blob supports large [uploads up to 5TB](https://vercel.com/changelog/5tb-file-transfers-with-vercel-blob-multipart-uploads) with built-in support for [multi-part uploads](https://vercel.com/changelog/5tb-file-transfers-with-vercel-blob-multipart-uploads), resumability, retries, and concurrency, enabled by the [Vercel Blob SDK](https://vercel.com/docs/vercel-blob/using-blob-sdk). You can [track progress from the client](https://vercel.com/changelog/vercel-blob-now-supports-file-upload-progress) and handle large media or user-generated content without workarounds.

Once uploaded, the file is immediately publicly available and cached across [Vercel’s delivery network](https://vercel.com/docs/edge-cache). Each upload can be traced back to its storage location, as every file in Blob uses a structured path format.

![Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_013.jpg)![Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_014.jpg)![Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_015.jpg)![Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_016.jpg)Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.

As with all assets, Vercel Blob integrates directly with Vercel [Image Optimization](https://vercel.com/docs/image-optimization), allowing you to store and optimize images within the same workflow. Instead of serving static images from traditional storage, Blob URLs can be used in framework-native image optimization, like `next/image` in Next.js, enabling transformations such as resizing, format conversion, and compression automatically.

```javascript
import Image from 'next/image';



export default function Profile() {

4  return (

5    <Image

6      src="https://ce0rcu23vrrdzqap.public.blob.vercel-storage.com/profiles/user-abcde-NoOVGDVcqSPc7VYCUAGnTzLTG2qEM2.png"

7      width={200}

8      height={200}

9      alt="User profile"

10    />

11  );

12}
```

You can also browse and manage files directly in the Vercel dashboard.

## How it's priced

Storage should be fast, reliable, and built for scale with a transparent pricing model, whether you’re storing a few files or serving terabytes of media.

[Vercel Blob pricing](https://vercel.com/docs/vercel-blob/usage-and-pricing) is usage-based and in line with what developers already understand, with regional pricing for Pro and Enterprise customers.

| **Usage Metric** | **Free Hobby included** | **Pro included** | **Pro/Ent on-demand price** |
| --- | --- | --- | --- |
| **Storage** | 1 GB per month | 5 GB per month | $0.023 per GB per month |
| **Simple API operations (e.g. Reads)** | 10,000 per month | 100,000 per month | $0.40 per 1 million |
| **Advanced operations (e.g. Uploads)** | 2,000 per month | 10,000 per month | $5.00 per 1 million |
| **Blob Data Transfer** | 10 GB per month | 100 GB per month | Starts at $0.050 per GB |

Storage and operation pricing are identical to Amazon S3. Blob Data Transfer is 3x more cost-efficient than Fast Data Transfer on average, thanks to its region-optimized architecture. Free data transfer allotments have doubled since beta.

Requests using Image Optimization, whether the images are stored in Blob or elsewhere, continue to use Fast Data Transfer because images are key to FCP/LCP and benefit from the latency-optimized network. Combined with format and size optimization, this could reduce costs compared to serving unoptimized images over Blob Data Transfer.

### New: Blob Observability Tab

The Observability dashboard [now includes a dedicated tab](https://vercel.com/changelog/vercel-blob-insights-now-available-in-observability) for Vercel Blob, which provides visibility into how Blob stores are used across your applications.

![](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_017.jpg)![](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_018.jpg)

At the team level, you can see total data transfer, download volume, cache activity, and API operations. You can also drill into activity by user agent, Vercel region, and client IP.

This allows you to understand real-world usage patterns, identify inefficiencies, and optimize how your application stores and serves assets.

## What's next for Vercel Blob

Blob is production-ready and already powering high-scale apps. We’re still iterating based on what developers need most with upcoming features that include private Blobs with scoped access for authenticated requests and data residency controls to let you choose where your data is stored. We’re also continuing to improve the local developer experience with better tooling for offline and local development.

Vercel Blob is storage built for the web: fast, globally distributed, and natively integrated into the Vercel platform. It connects directly to your frontend apps and workflows, making it ideal for user-generated content, media assets, or static files. Blob simplifies storage without sacrificing performance or cost.