---
title: "Vercel Blob is now generally available: Cost-efficient, durable storage - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-blob-now-generally-available"
date: "2025-05-21"
scraped_at: "2026-03-02T09:33:31.317496316+00:00"
language: "en-zh"
translated: true
description: "Vercel Blob is now generally available, providing durable object storage that's integrated with Vercel's application delivery network."
---

render_with_liquid: false
May 21, 2025

2025 年 5 月 21 日

Vercel Blob 现已正式发布（General Availability），提供与 Vercel 应用交付网络深度集成的持久化存储服务。

Storage should be simple to set up, globally available, and built to last, without slowing you down or adding complexity. It should feel native to your app.

存储理应开箱即用、全球可达、持久可靠，既不拖慢开发节奏，也不增加系统复杂度；它应当如原生组件一般自然融入您的应用。

That's why we built [Vercel Blob](https://vercel.com/docs/vercel-blob): Amazon S3-backed storage that's deeply integrated with Vercel's global application delivery and automated caching, with predictable pricing to serve public assets cost-efficiently at scale.

这正是我们构建 [Vercel Blob](https://vercel.com/docs/vercel-blob) 的原因：以 Amazon S3 为底层支撑的存储服务，深度集成 Vercel 全球应用交付网络与自动化缓存机制，并采用可预测的定价模型，助力您在大规模场景下高效、低成本地分发公共资源。

Vercel Blob is now generally available. It's already storing and serving over 400 million files, and powers production apps like v0 and the Vercel Dashboard.

Vercel Blob 现已正式发布。目前，它已存储并分发超 4 亿个文件，并为 v0 和 Vercel 控制台（Vercel Dashboard）等生产级应用提供核心存储支持。

![v0 leverages Blob to store millions of files, with many for each generation.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_001.jpg)![v0 leverages Blob to store millions of files, with many for each generation.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_002.jpg)![v0 leverages Blob to store millions of files, with many for each generation.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_003.jpg)![v0 leverages Blob to store millions of files, with many for each generation.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_004.jpg)v0 leverages Blob to store millions of files, with many for each generation.

![v0 利用 Blob 存储数百万个文件，每次生成过程均产生多个文件。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_001.jpg)![v0 利用 Blob 存储数百万个文件，每次生成过程均产生多个文件。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_002.jpg)![v0 利用 Blob 存储数百万个文件，每次生成过程均产生多个文件。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_003.jpg)![v0 利用 Blob 存储数百万个文件，每次生成过程均产生多个文件。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_004.jpg)v0 利用 Blob 存储数百万个文件，每次生成过程均产生多个文件。

## Built for performance, durability, and efficiency

## 为高性能、高持久性与高效率而设计

Vercel Blob is built for high-volume workloads, whether you’re storing a few profile pictures or terabytes of media.

无论您仅需存储几张用户头像，还是海量媒体文件（达 TB 级别），Vercel Blob 均专为高吞吐量工作负载而优化。

Vercel Blob introduces [Blob Data Transfer](https://vercel.com/docs/vercel-blob#blob-data-transfer), a new high-volume delivery strategy separate from Fast Data Transfer, that leverages alternative infrastructure to deliver assets at optimized cost. Blob Data Transfer is volume-optimized infrastructure (18 hubs) to deliver assets at optimized cost, while Fast Data Transfer remains latency-optimized (94 cities) for ultra-low latency.

Vercel Blob 推出全新数据分发机制——[Blob Data Transfer](https://vercel.com/docs/vercel-blob#blob-data-transfer)，该机制独立于 Fast Data Transfer，依托差异化基础设施，在保障成本效益的前提下实现高吞吐资产分发。Blob Data Transfer 采用容量优化型架构（覆盖全球 18 个枢纽节点），专注实现规模化分发的成本最优；而 Fast Data Transfer 则持续聚焦低延迟优化（覆盖全球 94 座城市），确保极致响应速度。

Blob is powered by Amazon's S3 infrastructure, ensuring 99.999999999% of reliability. To put this into context, even with one billion objects stored, you could go 100 years without losing a single one. Blob is built to be always available, resistant to failures, and instantly accessible.

Blob 依托 Amazon S3 基础设施构建，可靠性高达 99.999999999%（即“十一九”）。举例而言：即使存储十亿个对象，平均百年内也不会丢失单个对象。Blob 从设计之初便致力于实现永续可用、容错抗灾与即时访问。

![Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_005.jpg)  
![Fast Data Transfer 是为低延迟优化的，而 Blob Data Transfer 则为大容量数据传输优化。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_005.jpg)  

![Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_006.jpg)  
![Fast Data Transfer 是为低延迟优化的，而 Blob Data Transfer 则为大容量数据传输优化。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_006.jpg)  

![Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_007.jpg)  
![Fast Data Transfer 是为低延迟优化的，而 Blob Data Transfer 则为大容量数据传输优化。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_007.jpg)  

![Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_008.jpg)  
![Fast Data Transfer 是为低延迟优化的，而 Blob Data Transfer 则为大容量数据传输优化。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_008.jpg)  

Fast Data Transfer is optimized for low latency, while Blob Data Transfer is optimized for large volume.

Fast Data Transfer 是为低延迟优化的，而 Blob Data Transfer 则为大容量数据传输优化。

## Caching that just works

## 开箱即用的缓存机制

Vercel Blob’s deep integration with Vercel’s caching infrastructure abstracts away management and configuration, handling data transfer as part of the standard request lifecycle.

Vercel Blob 与 Vercel 缓存基础设施深度集成，自动屏蔽了缓存管理与配置的复杂性，将数据传输无缝纳入标准请求生命周期中处理。

When a request for a Blob asset is made:

当发起对某个 Blob 资源的请求时：

1. The request is routed to the nearest Vercel Region, like any standard Vercel Edge Request

   1. 请求被路由至地理上最近的 Vercel 区域（Region），方式与任意标准的 Vercel Edge 请求一致。

2. The Region identifies it as a Blob request and queries the Vercel cache

   2. 该区域识别出这是一个 Blob 请求，并查询 Vercel 缓存：

   - On a cache `HIT`, it’s served directly from the cache

     - 若发生缓存 `HIT`，则直接从缓存中返回资源；

   - On a cache `MISS`, the asset is fetched from Blob storage using [Fast Origin Transfer](https://vercel.com/docs/edge-network/manage-usage#fast-origin-transfer) and stored in the cache

     - 若发生缓存 `MISS`，则通过 [Fast Origin Transfer](https://vercel.com/docs/edge-network/manage-usage#fast-origin-transfer) 从 Blob 存储中拉取资源，并将其存入缓存。

3. The response is returned to the user, incurring Blob Data Transfer

   3. 响应返回给用户，此过程产生 Blob Data Transfer 流量。

By unifying storage and delivery inside Vercel’s network, Blob Data Transfer and the Vercel CDN deliver industry-leading cost-performance efficiency, no separate CDN required.

通过在 Vercel 网络内部统一存储与分发能力，Blob Data Transfer 与 Vercel CDN 共同实现了业界领先的成本-性能效率，无需额外部署独立 CDN。

![Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_009.jpg)  
![Vercel Blob 的请求利用具备区域感知能力的 Blob Data Transfer 及 Vercel CDN 缓存，为资源分发提供性能与成本之间的良好平衡。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_009.jpg)  

![Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_010.jpg)  
![Vercel Blob 的请求利用具备区域感知能力的 Blob Data Transfer 及 Vercel CDN 缓存，为资源分发提供性能与成本之间的良好平衡。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_010.jpg)  

![Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_011.jpg)  
![Vercel Blob 的请求利用具备区域感知能力的 Blob Data Transfer 及 Vercel CDN 缓存，为资源分发提供性能与成本之间的良好平衡。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_011.jpg)  

![Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_012.jpg)  
![Vercel Blob 的请求利用具备区域感知能力的 Blob Data Transfer 及 Vercel CDN 缓存，为资源分发提供性能与成本之间的良好平衡。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_012.jpg)  

Requests to Vercel Blob use region-aware Blob Data Transfer the Vercel CDN's caching, providing a balanced mix of performance and cost for asset delivery.

Vercel Blob 的请求利用具备区域感知能力的 Blob Data Transfer 及 Vercel CDN 缓存，为资源分发提供性能与成本之间的良好平衡。

## How Blob fits into your app

## Blob 如何融入您的应用

Vercel provides an [SDK](https://vercel.com/docs/vercel-blob/using-blob-sdk) to make file uploads easy. Installing `@vercel/blob` makes uploading a file to Blob a single function call. This example creates a Vercel Function that accepts a file and returns a public URL:

Vercel 提供了一个 [SDK](https://vercel.com/docs/vercel-blob/using-blob-sdk)，让文件上传变得轻而易举。安装 `@vercel/blob` 后，只需一次函数调用即可将文件上传至 Blob。以下示例创建了一个 Vercel Function，它接收一个文件并返回其公开可访问的 URL：

```javascript
import { put } from '@vercel/blob';



export async function PUT(request: Request) {

4  const form = await request.formData();

5  const file = form.get('file') as File;

6  const blob = await put(file.name, file, { access: 'public', addRandomSuffix: true });



8  return Response.json(blob);
```

9}
```

Vercel Blob supports large [uploads up to 5TB](https://vercel.com/changelog/5tb-file-transfers-with-vercel-blob-multipart-uploads) with built-in support for [multi-part uploads](https://vercel.com/changelog/5tb-file-transfers-with-vercel-blob-multipart-uploads), resumability, retries, and concurrency, enabled by the [Vercel Blob SDK](https://vercel.com/docs/vercel-blob/using-blob-sdk). You can [track progress from the client](https://vercel.com/changelog/vercel-blob-now-supports-file-upload-progress) and handle large media or user-generated content without workarounds.

Vercel Blob 支持高达 5TB 的大文件上传，内置支持 [分段上传（multi-part uploads）](https://vercel.com/changelog/5tb-file-transfers-with-vercel-blob-multipart-uploads)，并具备断点续传、自动重试和并发上传能力，这些功能均由 [Vercel Blob SDK](https://vercel.com/docs/vercel-blob/using-blob-sdk) 提供支持。您可 [在客户端实时追踪上传进度](https://vercel.com/changelog/vercel-blob-now-supports-file-upload-progress)，轻松处理大型媒体文件或用户生成内容，无需任何变通方案。

Once uploaded, the file is immediately publicly available and cached across [Vercel’s delivery network](https://vercel.com/docs/edge-cache). Each upload can be traced back to its storage location, as every file in Blob uses a structured path format.

文件上传完成后，将立即公开可访问，并自动缓存至 [Vercel 的边缘分发网络（delivery network）](https://vercel.com/docs/edge-cache)。每次上传均可追溯至其实际存储位置，因为 Blob 中的每个文件均采用结构化路径格式。

![Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_013.jpg)![Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_014.jpg)![Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_015.jpg)![Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_016.jpg)Vercel Blob URLs use a standardized format to easily trace objects back to their storage locations.

![Vercel Blob URL 采用标准化格式，便于轻松追溯对象至其存储位置。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_013.jpg)![Vercel Blob URL 采用标准化格式，便于轻松追溯对象至其存储位置。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_014.jpg)![Vercel Blob URL 采用标准化格式，便于轻松追溯对象至其存储位置。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_015.jpg)![Vercel Blob URL 采用标准化格式，便于轻松追溯对象至其存储位置。](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_016.jpg)Vercel Blob URL 采用标准化格式，便于轻松追溯对象至其存储位置。

As with all assets, Vercel Blob integrates directly with Vercel [Image Optimization](https://vercel.com/docs/image-optimization), allowing you to store and optimize images within the same workflow. Instead of serving static images from traditional storage, Blob URLs can be used in framework-native image optimization, like `next/image` in Next.js, enabling transformations such as resizing, format conversion, and compression automatically.

与所有静态资源一样，Vercel Blob 原生集成 Vercel [图片优化（Image Optimization）](https://vercel.com/docs/image-optimization) 功能，让您可在同一工作流中完成图片的存储与优化。相比从传统存储服务提供静态图片，您可直接在框架原生的图片优化组件（例如 Next.js 中的 `next/image`）中使用 Blob URL，从而自动实现尺寸缩放、格式转换、压缩等图像变换操作。

```javascript
import Image from 'next/image';



export default function Profile() {

4  return (

5    <Image

6      src="https://ce0rcu23vrrdzqap.public.blob.vercel-storage.com/profiles/user-abcde-NoOVGDVcqSPc7VYCUAGnTzLTG2qEM2.png"

6      src="https://ce0rcu23vrrdzqap.public.blob.vercel-storage.com/profiles/user-abcde-NoOVGDVcqSPc7VYCUAGnTzLTG2qEM2.png"

7      width={200}

7      width={200}

8      height={200}

8      height={200}

9      alt="User profile"

9      alt="用户头像"

10    />

10    />

11  );

11  );

12}
```

12}
```

You can also browse and manage files directly in the Vercel dashboard.

您还可以直接在 Vercel 控制台中浏览和管理文件。

## How it's priced

## 定价方式

Storage should be fast, reliable, and built for scale with a transparent pricing model, whether you’re storing a few files or serving terabytes of media.

存储服务应具备高速、可靠、可大规模扩展等特性，并采用透明的定价模式——无论您仅需存储少量文件，还是需要分发海量媒体内容（达数太字节级别）。

[Vercel Blob pricing](https://vercel.com/docs/vercel-blob/usage-and-pricing) is usage-based and in line with what developers already understand, with regional pricing for Pro and Enterprise customers.

[Vercel Blob 定价](https://vercel.com/docs/vercel-blob/usage-and-pricing) 采用按用量计费模式，与开发者已熟知的定价逻辑一致，并为 Pro 和 Enterprise 用户提供区域化定价。

| **Usage Metric** | **Free Hobby included** | **Pro included** | **Pro/Ent on-demand price** |
| --- | --- | --- | --- |
| **Storage** | 1 GB per month | 5 GB per month | $0.023 per GB per month |
| **Simple API operations (e.g. Reads)** | 10,000 per month | 100,000 per month | $0.40 per 1 million |
| **Advanced operations (e.g. Uploads)** | 2,000 per month | 10,000 per month | $5.00 per 1 million |
| **Blob Data Transfer** | 10 GB per month | 100 GB per month | Starts at $0.050 per GB |

| **用量指标** | **Free（Hobby）套餐包含** | **Pro 套餐包含** | **Pro/Enterprise 按需价格** |
| --- | --- | --- | --- |
| **存储空间（Storage）** | 每月 1 GB | 每月 5 GB | 每 GB 每月 $0.023 |
| **基础 API 操作（例如：读取）** | 每月 10,000 次 | 每月 100,000 次 | 每百万次 $0.40 |
| **高级操作（例如：上传）** | 每月 2,000 次 | 每月 10,000 次 | 每百万次 $5.00 |
| **Blob 数据传输（Blob Data Transfer）** | 每月 10 GB | 每月 100 GB | 起价 $0.050 每 GB |

Storage and operation pricing are identical to Amazon S3. Blob Data Transfer is 3x more cost-efficient than Fast Data Transfer on average, thanks to its region-optimized architecture. Free data transfer allotments have doubled since beta.

存储与操作定价与 Amazon S3 完全一致。得益于其面向区域优化的架构，Blob 数据传输平均成本效率比 Fast 数据传输高出 3 倍。自 Beta 版本以来，免费数据传输额度已翻倍。

Requests using Image Optimization, whether the images are stored in Blob or elsewhere, continue to use Fast Data Transfer because images are key to FCP/LCP and benefit from the latency-optimized network. Combined with format and size optimization, this could reduce costs compared to serving unoptimized images over Blob Data Transfer.

无论图片是存储在 Blob 中还是其他位置，凡使用图片优化（Image Optimization）功能的请求，仍通过 Fast 数据传输进行——因为图片对首屏内容绘制（FCP）和最大内容绘制（LCP）至关重要，且能从延迟优化的网络中显著获益。结合格式与尺寸优化，该方案相比直接通过 Blob 数据传输分发未经优化的图片，可进一步降低成本。

### New: Blob Observability Tab

### 新增：Blob 可观测性标签页

The Observability dashboard [now includes a dedicated tab](https://vercel.com/changelog/vercel-blob-insights-now-available-in-observability) for Vercel Blob, which provides visibility into how Blob stores are used across your applications.

可观测性（Observability）控制台[现已新增专属标签页](https://vercel.com/changelog/vercel-blob-insights-now-available-in-observability)，专用于 Vercel Blob，助您全面了解 Blob 存储在各应用中的实际使用情况。

![](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_017.jpg)![](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_018.jpg)

![](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_017.jpg)![](images/vercel-blob-is-now-generally-available-cost-efficient-durable-storage-vercel/img_018.jpg)

At the team level, you can see total data transfer, download volume, cache activity, and API operations. You can also drill into activity by user agent, Vercel region, and client IP.

在团队层级，您可查看总数据传输量、下载量、缓存活动及 API 操作统计；还可按用户代理（User Agent）、Vercel 区域（Region）和客户端 IP 进一步下钻分析具体活动。

This allows you to understand real-world usage patterns, identify inefficiencies, and optimize how your application stores and serves assets.

这有助于您掌握真实世界中的使用模式，识别低效环节，并持续优化应用在资产存储与分发方面的策略。

## What's next for Vercel Blob

## Vercel Blob 的后续规划

Blob 是生产就绪的，目前已为高规模应用提供支持。我们仍在持续迭代，以响应开发者最迫切的需求；即将推出的特性包括：支持认证请求的私有 Blob（具备作用域访问控制）以及数据驻留控制功能，让您自主选择数据存储的地理位置。此外，我们也在持续优化本地开发体验，提供更完善的离线与本地开发工具。

Blob 是专为 Web 构建的存储服务：速度快、全球分布式部署，并原生集成于 Vercel 平台。它可直接连接您的前端应用和工作流，非常适合存储用户生成内容、媒体资源或静态文件。Blob 在不牺牲性能与成本效益的前提下，极大简化了存储管理。

Vercel Blob is storage built for the web: fast, globally distributed, and natively integrated into the Vercel platform.

Vercel Blob 是专为 Web 构建的存储服务：速度快、全球分布式部署，并原生集成于 Vercel 平台。

It connects directly to your frontend apps and workflows, making it ideal for user-generated content, media assets, or static files.

它可直接连接您的前端应用和工作流，非常适合存储用户生成内容、媒体资源或静态文件。

Blob simplifies storage without sacrificing performance or cost.

Blob 在不牺牲性能与成本效益的前提下，极大简化了存储管理。