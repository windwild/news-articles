---
title: "Colocate your edge to your data on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/regional-execution-for-ultra-low-latency-rendering-at-the-edge"
date: "2022-10-20"
scraped_at: "2026-03-02T09:59:59.883702208+00:00"
language: "en-zh"
translated: true
description: "At this year's P99 Conference, we discussed how edge computing can reduce latency for end users. See how regional Edge Functions can help."
---
&#123;% raw %}

Oct 20, 2022

2022年10月20日

As we work to make a faster Web, increasing speed typically looks like moving more towards the edge—but sometimes requests are served fastest when those computing resources are close to a data source.

在致力于构建更快速的 Web 的过程中，提升性能通常意味着将计算进一步推向边缘（edge）；但有时，当计算资源靠近数据源时，请求反而能获得最快的响应。

Today, we’re introducing [regional execution of Edge Functions](https://vercel.com/docs/concepts/edge-network/regions) to address this. Regional execution of Edge Functions allow you to specify the region your [Edge Function](https://vercel.com/features/edge-functions) executes in. This capability allows you to run your functions near your data to avoid high-latency waterfalls while taking advantage of the fast cold start times of Edge Functions and ensuring your users have the best experience possible.

今天，我们正式推出[边缘函数的区域化执行（regional execution of Edge Functions）](https://vercel.com/docs/concepts/edge-network/regions)，以应对这一挑战。边缘函数的区域化执行，使您能够指定您的[边缘函数（Edge Function）](https://vercel.com/features/edge-functions)所运行的具体地理区域。该能力让您可将函数部署在靠近数据源的位置，从而避免高延迟的“瀑布式请求链（waterfalls）”，同时充分利用边缘函数极快的冷启动速度，确保终端用户获得尽可能优质的体验。

## **Avoiding waterfalls with regional execution of Edge Functions**

## **借助边缘函数的区域化执行规避瀑布式请求链**

Vercel CTO Malte Ubl recently shared how to achieve ultra-low latency rendering at the edge at this year’s P99 Conference, a virtual event discussing Internet latency and performance. He outlined historic approaches to rendering sites and new challenges faced by bringing rendering to the edge.

Vercel 首席技术官 Malte Ubl 近日在今年的 P99 大会（一场聚焦互联网延迟与性能的线上会议）上，分享了如何在边缘实现超低延迟渲染。他回顾了网站渲染的传统方式，并剖析了将渲染任务迁移至边缘所面临的新挑战。

One important consideration Malte discussed was to avoid “waterfalls” in your rendering. A waterfall occurs when a rendering function needs to make multiple queries from a database. When that database is far away from the function, the latency from each request adds up. This results in a slow page for the user. While it may sound counterintuitive, it might be faster to move the function closer to the database rather than closer to the user when using Edge Functions.

Malte 特别强调的一个关键考量点，是避免渲染过程中的“瀑布式请求链”。所谓瀑布式请求链，是指一个渲染函数需向数据库发起多次查询；而当该数据库距离函数部署位置较远时，每次查询的网络延迟便会逐级叠加，最终导致用户页面加载缓慢。尽管这听起来有违直觉，但在使用边缘函数时，将函数部署得更靠近数据库（而非更靠近用户），反而可能带来更快的整体响应速度。

## **Moving to the cloud**

## **迈向云时代**

When the Web was first born in 1994, building the Web included running it on a server—not just writing code. Developers were responsible for taking care of upgrades, restarting the server when it crashed, and swapping out bad hard drives. Thankfully, we’ve since moved more of our infrastructure to the cloud. Developers first did this with virtual machines, which meant that we didn’t have to manage our own hardware anymore. They then adopted serverless functions, which freed them up to write functions without worrying about the underlying operating system and web server.

1994 年万维网诞生之初，“构建 Web”不仅意味着编写代码，更意味着亲自运维服务器。开发者需自行负责系统升级、服务器崩溃后的重启，以及故障硬盘的更换。值得庆幸的是，我们此后已将越来越多的基础设施迁移至云端：最初，开发者通过虚拟机（VM）实现这一转变，从而摆脱了对物理硬件的直接管理；随后，他们又采用无服务器函数（serverless functions），得以专注于业务逻辑开发，而无需操心底层操作系统与 Web 服务器的运维。

However, moving to the cloud wasn’t just an improvement for developers. It was a huge step forward for users, too. By moving sites out of small offices and into data centers with unparalleled network connectivity, users got much faster websites.

然而，迁移到云端带来的不仅是开发者体验的提升，更是用户体验的一次巨大飞跃。通过将网站从小型办公室迁移至具备卓越网络连接能力的数据中心，用户得以享受显著提速的网站访问体验。

Now it’s time for the next step forward: moving computing out of the data center entirely and onto the edge.

如今，是时候迈出下一步了：彻底将计算从数据中心中解放出来，全面推向边缘。

![With edge computing, there’s a copy of the content close to everyone. ](images/colocate-your-edge-to-your-data-on-vercel-vercel/img_001.jpg)![With edge computing, there’s a copy of the content close to everyone. ](images/colocate-your-edge-to-your-data-on-vercel-vercel/img_002.jpg)  
借助边缘计算，内容副本就近部署在每位用户附近。

## **边缘（The edge）**

## **边缘计算**

借助边缘计算，内容不再集中于一两个数据中心，而是复制到 Vercel 全球各地的边缘区域（Region），从而确保每位用户都能就近访问内容副本。用户只需连接至其附近的 Vercel 区域即可浏览网站，这相比传统计算方式显著降低了延迟。

边缘计算带来的优势不仅限于地理距离。为在边缘而非传统数据中心中运行，边缘函数（Edge Functions）需在一种名为 [Edge Runtime（边缘运行时）](https://vercel.com/blog/introducing-the-edge-runtime) 的轻量级环境中执行。Edge Runtime 专为高效执行 JavaScript、TypeScript 或 WebAssembly（Wasm）而设计。这种受限环境通常成本更低，且冷启动时间比无服务器函数（serverless functions）更快。

## **数据获取（Data fetching）**

## **数据获取**

将函数部署得更靠近用户，可显著降低渲染自包含内容（例如 [社交卡片图片（social card images）](https://vercel.com/blog/introducing-vercel-og-image-generation-fast-dynamic-social-card-images)）时的延迟。但若该函数需查询位于单一数据中心的数据源，则反而可能引入额外延迟。

假设您编写了一个边缘函数，用于查询位于美国东部（iad1）区域的数据库，并且该函数需执行 3 次数据库查询。再设想一位澳大利亚用户触发了该函数。如果此边缘函数以全局方式部署，该用户将连接至其最近的悉尼数据中心，而函数则需跨地域向美国东部数据库发起 3 次查询——整个数据库查询过程耗时将超过 1 秒。尽管理想情况下数据库应实现全球分布式部署，但现实是：目前许多数据库尚未做到，且在可预见的未来也未必能实现。

换一种思路：若您将边缘函数配置为仅在美国东部区域运行（因其最靠近您的数据库），那么来自澳大利亚用户的浏览器请求便需从悉尼传输至美国东部。一旦抵达，该区域中运行的函数即可在几毫秒内与数据库通信，而非耗时数百毫秒。虽然您仍在对同一数据库执行相同的三次查询，但网络层面仅需一次跨洲请求（悉尼 → 美国），而非三次。

![Regional Edge Functions provide users with the lowest latency. ](images/colocate-your-edge-to-your-data-on-vercel-vercel/img_003.jpg)![Regional Edge Functions provide users with the lowest latency. ](images/colocate-your-edge-to-your-data-on-vercel-vercel/img_004.jpg)  
区域性边缘函数（Regional Edge Functions）可为用户提供最低延迟体验。

区域性边缘函数让您可在两种部署模式间灵活选择：全局部署（global deployment），或就近用户部署（user-proximate deployment）。这一能力使您能够为用户提供最低延迟和最佳网站体验。

## **Setting your region**

## **设置您的区域**

To configure the region that your Edge Function runs in, you can edit your function’s configuration:

您可以编辑函数的配置，以指定您的 Edge Function 运行所在的区域：

```javascript
export const config = {

2  runtime: 'experimental-edge',

3  regions: ['syd1']

4};
```

Configuring regions for your Edge Functions requires [Next.js v12.3.2](https://nextjs.org/docs) or newer. If you don’t configure this, your Edge Function will continue to default to running globally.

为 Edge Function 配置区域需要使用 [Next.js v12.3.2](https://nextjs.org/docs) 或更高版本。若您未进行此项配置，您的 Edge Function 将继续默认在全球范围内运行。

## **Getting started with Edge Functions**

## **开始使用 Edge Functions**

To learn more about regional Edge Functions with Vercel, [check out the documentation](https://vercel.com/docs/concepts/edge-network/regions) or [explore a few examples](https://vercel.com/docs/concepts/edge-network/regions).

如需进一步了解 Vercel 提供的区域性 Edge Functions，请[查阅相关文档](https://vercel.com/docs/concepts/edge-network/regions)，或[浏览若干示例](https://vercel.com/docs/concepts/edge-network/regions)。
&#123;% endraw %}
