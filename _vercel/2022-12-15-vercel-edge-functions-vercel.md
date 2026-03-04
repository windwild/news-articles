---
render_with_liquid: false
title: "Vercel Edge Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/edge-functions-generally-available"
date: "2022-12-15"
scraped_at: "2026-03-02T09:57:31.209707670+00:00"
language: "en-zh"
translated: true
description: "Vercel Edge Functions are now generally available for fast, efficient compute."
---
render_with_liquid: false
render_with_liquid: false

Dec 15, 2022

2022 年 12 月 15 日

Faster, cheaper, more flexible compute for your workloads.

面向您工作负载的更快、更低成本、更灵活的计算能力。

Access to fast, global compute can give developers more flexibility to build rich experiences, regardless of their users' physical location or network speed. Vercel's Edge Functions aim to bring this capability into every developer's toolkit for building on the Web.

快速、全球化的计算资源，可赋予开发者更大灵活性，以构建丰富多样的用户体验——无论其用户身处何地或网络速度如何。Vercel 的 Edge Functions 致力于将这一能力纳入每位 Web 开发者的工具箱。

This past summer, alongside our GA of Edge Middleware, we released Edge Functions to Public Beta. During our beta period, our Edge Network has seen over 30 _billion_ Edge Function invocations.

今年夏天，我们随 Edge Middleware 正式发布（GA）一并推出了 Edge Functions 公开测试版（Public Beta）。在测试期间，Vercel 边缘网络已累计执行超过 300 亿次 Edge Function 调用。

Since launching, we’ve made Edge Functions **faster**, more **flexible**, and **capable of even larger workloads**:

自正式发布以来，我们已将 Edge Functions 打造得更加 **迅捷**、更加 **灵活**，并具备处理 **更大规模工作负载** 的能力：

- Major infrastructure optimizations for improved performance  
- 面向性能提升的重大基础设施优化  

- Support for `cache-control` [standard](https://vercel.com/docs/concepts/functions/edge-functions/edge-caching) for function responses  
- 支持函数响应的 `cache-control` [标准规范](https://vercel.com/docs/concepts/functions/edge-functions/edge-caching)  

- Added ability to express [region preference](https://vercel.com/blog/edge-functions-generally-available#regional-edge-functions)  
- 新增 [区域偏好设置](https://vercel.com/blog/edge-functions-generally-available#regional-edge-functions) 功能  

- Added support for [WebAssembly workloads](https://vercel.com/blog/edge-functions-generally-available#support-for-webassembly)  
- 新增对 [WebAssembly 工作负载](https://vercel.com/blog/edge-functions-generally-available#support-for-webassembly) 的支持  

- [Increased function size limits](https://vercel.com/blog/edge-functions-generally-available#increased-workload-size-and-improved-infrastructure) for Enterprise and Pro teams  
- [提升函数大小限制](https://vercel.com/blog/edge-functions-generally-available#increased-workload-size-and-improved-infrastructure)，适用于 Enterprise（企业版）与 Pro（专业版）团队

Now, we’re excited to announce that beginning today, Edge Functions are now generally available (GA) for all customers.

现在，我们很高兴地宣布：即日起，Edge Functions 已面向所有客户正式发布（General Availability，GA）。

## What are Edge Functions?

## 什么是 Edge Functions？

Vercel Edge Functions are JavaScript, TypeScript, or WebAssembly functions that are generally more efficient and faster than traditional Serverless compute, since they operate within a much leaner runtime. Deployed globally by default, Edge Functions run in the region closest to the request for the lowest latency possible.

Vercel Edge Functions 是使用 JavaScript、TypeScript 或 WebAssembly 编写的函数，通常比传统的无服务器（Serverless）计算更高效、更快，因为它们运行在一个精简得多的运行时环境中。Edge Functions 默认在全球范围内部署，并在距离用户请求地理位置最近的区域中执行，从而实现尽可能低的延迟。

pages/api/hello.ts

```javascript
export const config = {

2  runtime: 'edge'

3}



export default function handler(req: Request) {

6  return new Response("Hello World");
```

7}
```

A hello world Edge Function in Next.js. Edge Functions are natively available in Next.js, SvelteKit, Astro, and Nuxt or as a standalone function. runtime: 'edge' can be leveraged with Vercel CLI 28.9.0 and above.

一个在 Next.js 中运行的 “Hello World” 边缘函数（Edge Function）。边缘函数原生支持 Next.js、SvelteKit、Astro 和 Nuxt，也可作为独立函数使用。`runtime: 'edge'` 需搭配 Vercel CLI 28.9.0 或更高版本使用。

Unlike Edge Middleware, Functions run _after_ the cache, and therefore can both cache and return responses, making them great for data fetching or rewrites.

与边缘中间件（Edge Middleware）不同，边缘函数在缓存**之后**执行，因此既能缓存响应，也能直接返回响应，非常适合数据获取（data fetching）或 URL 重写（rewrites）。

> “We’ve been using an Edge API Route to proxy requests to our backend and rewrite headers on the fly. The lightweight nature of the Edge Runtime and the ability to stream responses ensures that response times stay fast. Additionally, the switch from regular API Routes reduced our costs significantly. We’ve been using an Edge API Route to proxy requests to our backend and rewrite headers on the fly. The lightweight nature of the Edge Runtime and the ability to stream responses ensures that response times stay fast. Additionally, the switch from regular API Routes reduced our costs significantly. We’ve been using an Edge API Route to proxy requests to our backend and rewrite headers on the fly. The lightweight nature of the Edge Runtime and the ability to stream responses ensures that response times stay fast. Additionally, the switch from regular API Routes reduced our costs significantly. ”
>
> “我们一直使用边缘 API 路由（Edge API Route）将请求代理至后端，并实时重写响应头。边缘运行时（Edge Runtime）轻量高效，且支持流式响应（streaming responses），从而确保响应速度始终迅捷。此外，从传统 API 路由切换至边缘 API 路由，显著降低了我们的运营成本。”
>
> ![](images/vercel-edge-functions-vercel/img_001.png)
>
> **Connor Bär,** Senior Frontend Engineer  
> **康纳·贝尔（Connor Bär）**，高级前端工程师

Vercel Edge Functions are natively supported by Next.js, and many other frameworks like [Nuxt](https://nuxt-on-the-edge.vercel.app/), [Astro](https://astro-on-the-edge.vercel.app/), and [SvelteKit](https://sveltekit-on-the-edge.vercel.app/). Edge Functions can also be created as a standalone function in Vercel CLI.

Vercel 边缘函数原生支持 Next.js，同时也被众多其他框架原生支持，例如 [Nuxt](https://nuxt-on-the-edge.vercel.app/)、[Astro](https://astro-on-the-edge.vercel.app/) 和 [SvelteKit](https://sveltekit-on-the-edge.vercel.app/)。此外，您还可通过 Vercel CLI 创建独立的边缘函数。

In Next.js, set your app’s default runtime to `edge`, or select the runtime for an individual function.

在 Next.js 中，您可将整个应用的默认运行时设为 `edge`，也可为单个函数单独指定运行时。

## Maximum speed, minimum cost

## 极致性能，极致成本效益

Edge Functions use the lightweight Edge Runtime, which is built on the V8 engine used by the Chrome browser and doesn’t run within a MicroVM, making Edge Functions generally faster and more cost-effective than traditional serverless.

边缘函数采用轻量级的边缘运行时（Edge Runtime），该运行时基于 Chrome 浏览器所用的 V8 引擎构建，且不依赖 MicroVM（微型虚拟机），因此整体上比传统无服务器（serverless）函数更快、成本更低。

Vercel's own open-source [OG Image Generation project](https://vercel.com/docs/concepts/functions/edge-functions/og-image-generation) now leverages Edge Functions for global, fast compute. By moving to the Edge, these APIs return almost 40% faster than a hot Serverless Function at a fraction of the cost.

Vercel 自研的开源项目 [OG 图像生成（OG Image Generation）](https://vercel.com/docs/concepts/functions/edge-functions/og-image-generation) 已全面采用边缘函数，实现全球范围内的快速计算。迁移至边缘后，这些 API 的响应速度比处于“热启动”状态的传统无服务器函数快近 40%，而成本仅为后者的极小一部分。

This efficiency means that generating a million images with OG Image Generation running in Edge Functions costs nearly 15x less than the cost of generating those same million images in Serverless Functions.

这种效率提升意味着：使用运行在边缘函数上的 OG 图像生成服务生成一百万张图像，其成本比在传统无服务器函数中完成同等任务的成本低近 15 倍。

## What's changed: Even more flexibility

## 更新内容：更强大的灵活性

### Regional Edge Functions

### 区域化边缘函数（Regional Edge Functions）

Vercel now gives you the option to [express a region preference](https://vercel.com/blog/regional-execution-for-ultra-low-latency-rendering-at-the-edge) for Edge Functions, close to your data source.

Vercel 现在允许您为边缘函数（Edge Functions）[指定首选区域](https://vercel.com/blog/regional-execution-for-ultra-low-latency-rendering-at-the-edge)，使其尽可能靠近您的数据源。

Edge Functions are deployed globally by default, so compute happens in the region closest to the user making the request. For tasks that don't require a database, like our OG Image Generation tool, this reduces latency between function and user, reinforcing the benefit of fast, global compute.

边缘函数默认在全球范围内部署，因此计算将在最靠近发起请求用户的区域执行。对于无需访问数据库的任务（例如我们的 OG 图像生成工具），这种方式可显著降低函数与用户之间的延迟，进一步凸显全球快速计算的优势。

However, for functions that need to query a database, global compute could mean the request takes _longer_ because the request could come in from a region far from the database. That additional latency may mean that the benefits of Edge Functions get outweighed by the length of that request.

然而，对于需要查询数据库的函数而言，全局部署可能导致请求耗时反而**更长**——因为请求可能来自距离数据库非常遥远的区域。这部分额外延迟，可能抵消甚至超过边缘函数本身带来的性能优势。

With Regional Edge Functions, you can bind a function to a specific region, close to your database. This ensures that the benefit of fast compute isn't negated by additional latency.

借助区域化边缘函数，您可以将函数绑定至特定区域（例如紧邻数据库所在的区域）。这确保了快速计算的优势不会被额外的网络延迟所削弱。

With millions of files in Sanity, **Keystone Education Group, in partnership with** **NoA Ignite** relies on fast, efficient data fetching from the headless CMS to power Keystone's site. Running those API Routes efficiently is a priority for their development team, so compute co-location is crucial. At this scale, the team can save money and deliver an improved experience for their Sanity-based content by leveraging the leaner runtime.

Sanity 中存储着数百万个文件，**Keystone 教育集团**（与 **NoA Ignite** 合作）高度依赖该无头 CMS 实现快速、高效的数据获取，以支撑 Keystone 官网的运行。对其开发团队而言，高效运行这些 API 路由至关重要，因此计算资源与数据源的地理共置（compute co-location）尤为关键。在如此庞大的数据规模下，团队可通过采用更轻量的运行时环境，在降低成本的同时，显著提升基于 Sanity 的内容交付体验。

> “We shifted Keystone's API Routes incrementally from Serverless to Edge Functions and couldn't be happier. It was very straightforward for us to make the change on Vercel, and as a result, we've been able to reduce costs and we've seen our compute efficiency drastically improve. We shifted Keystone's API Routes incrementally from Serverless to Edge Functions and couldn't be happier. It was very straightforward for us to make the change on Vercel, and as a result, we've been able to reduce costs and we've seen our compute efficiency drastically improve.  
> We shifted Keystone's API Routes incrementally from Serverless to Edge Functions and couldn't be happier. It was very straightforward for us to make the change on Vercel, and as a result, we've been able to reduce costs and we've seen our compute efficiency drastically improve.”  
>  
> “我们将 Keystone 的 API 路由逐步从无服务器函数（Serverless）迁移至边缘函数，对此我们感到无比满意。在 Vercel 平台上完成这一变更非常简单直接；结果是，我们成功降低了成本，并显著提升了计算效率。我们将 Keystone 的 API 路由逐步从无服务器函数（Serverless）迁移至边缘函数，对此我们感到无比满意。在 Vercel 平台上完成这一变更非常简单直接；结果是，我们成功降低了成本，并显著提升了计算效率。  
> 我们将 Keystone 的 API 路由逐步从无服务器函数（Serverless）迁移至边缘函数，对此我们感到无比满意。在 Vercel 平台上完成这一变更非常简单直接；结果是，我们成功降低了成本，并显著提升了计算效率。”  
>  
> ![](images/vercel-edge-functions-vercel/img_002.png)  
>  
> **Tormod Ulsberg,** Principal Architect  
>  
> **托尔莫德·乌尔斯贝格（Tormod Ulsberg）**，首席架构师

### Support for WebAssembly

### WebAssembly 支持

Because Vercel’s Edge Functions run in a lightweight execution environment built on the [V8 JavaScript Engine](https://v8.dev/), we were able to [add support for WebAssembly, or Wasm](https://vercel.com/blog/introducing-support-for-webassembly-at-the-edge), a language similar to Assembly language that’s commonly supported as a low-level language by browsers.

由于 Vercel 的边缘函数运行于基于 [V8 JavaScript 引擎](https://v8.dev/) 构建的轻量级执行环境中，我们得以[新增对 WebAssembly（简称 Wasm）的支持](https://vercel.com/blog/introducing-support-for-webassembly-at-the-edge)。WebAssembly 是一种类似于汇编语言的底层编程语言，目前已被主流浏览器广泛支持。

WebAssembly lets you take a function written in a different language—like C or Rust—and use that directly in Edge Functions. This lets you move many existing libraries to Edge Functions just by recompiling for Wasm. Complex, computationally heavy workloads often run twice as fast in WebAssembly as they do when written in JavaScript.

WebAssembly（Wasm）允许你将用其他语言（例如 C 或 Rust）编写的函数直接用于 Edge Functions。只需将现有库重新编译为 Wasm，即可轻松将其迁移至 Edge Functions。对于复杂且计算密集型的工作负载，其在 WebAssembly 中的运行速度通常是纯 JavaScript 实现的两倍。

Moving Vercel’s [OG Image Generation](https://vercel.com/blog/introducing-vercel-og-image-generation-fast-dynamic-social-card-images) to Wasm and Edge Functions, Image Generation became **5x faster** in P99 TTFB.

我们将 Vercel 的 [OG 图像生成](https://vercel.com/blog/introducing-vercel-og-image-generation-fast-dynamic-social-card-images) 迁移至 Wasm 和 Edge Functions 后，图像生成在 P99 首字节时间（TTFB）上实现了 **5 倍提速**。

### Increased workload size and improved infrastructure

### 工作负载容量提升与基础设施优化

Pro and Enterprise customers can now use larger Edge Functions. We’ve increased the size limit for Edge Functions to 2 MB for Pro customers and 4 MB for Enterprise customers. That’s 2x and 4x bigger than before, respectively.

Pro 和 Enterprise 用户现在可使用更大体积的 Edge Functions。我们已将 Edge Functions 的大小限制分别提升至：Pro 用户 2 MB（为此前的 2 倍），Enterprise 用户 4 MB（为此前的 4 倍）。

We’ve also significantly improved our routing for Edge Functions, massively reducing the time it takes to start executing a function.

我们还大幅优化了 Edge Functions 的路由机制，显著缩短了函数启动执行所需的时间。

## The future of Edge Functions

## Edge Functions 的未来展望

We’re excited to continue improving our compute products—both Edge and Serverless Functions.

我们非常期待持续优化我们的计算类产品——包括 Edge Functions 和 Serverless Functions。

First, we’re improving the compatibility between Edge Functions and Serverless Functions. Our goal is for the Edge Runtime to be a proper subset of the Node.js API. We want users to be able to choose their execution environment based on performance and cost characteristics, not the API.

首先，我们正着力提升 Edge Functions 与 Serverless Functions 之间的兼容性。我们的目标是让 Edge Runtime 成为 Node.js API 的一个严格子集。我们希望用户能基于性能和成本特性来选择执行环境，而非受限于 API 差异。

We’re also improving the observability and error reporting for functions, starting with Vercel Logs and Monitoring. We want to make it easier for you to understand how your functions are executing and how and when they encounter errors. We want to make understanding how your functions work on Vercel clearer and troubleshooting problems simpler.

我们还在增强函数的可观测性与错误报告能力，首期将从 Vercel Logs（日志）和 Monitoring（监控）着手。我们希望帮助你更清晰地了解函数的执行状态，以及它们在何时、因何原因发生错误；让函数在 Vercel 上的运行逻辑更透明，问题排查更简单。

We're working towards a goal of seamless interoperability with a great developer experience, both locally and in production, across all our compute products.

我们正致力于实现所有计算类产品之间无缝互操作的目标——无论是在本地开发环境还是生产环境中，均提供卓越的开发者体验。

## Pricing and Limits

## 定价与用量限制

Edge Functions 按每次调用所消耗的 CPU 时间计费，计费单位为 50 毫秒，称为“执行单元”（execution units）。CPU 时间指实际执行计算所花费的时间，不包括等待数据获取（例如数据库查询或 API 调用）所耗费的时间。这意味着：即使你调用的是响应较慢的后端服务（例如 AI 推理服务），你在等待数据返回期间也不会产生费用。

Hobby（入门版）用户每月可免费使用 **50 万** 个 Edge Function 执行单元；Pro（专业版）和 Enterprise（企业版）团队每月则可免费使用 100 万个执行单元，并可[按需增购额外用量](https://vercel.com/pricing)。

你可以在账户控制台（account dashboard）中查看 Edge Functions 的调用次数、执行单元消耗量以及 CPU 时间使用情况。

## Next steps

## 下一步

要开始使用 Vercel，请[部署一个 Edge Function](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fexamples%2Ftree%2Fmain%2Fedge-api-routes%2Fhello-world-next&project-name=next-edge-api-route&repository-name=next-edge-api-route)，或查阅我们的[文档](https://vercel.com/docs/concepts/functions/edge-functions)快速上手。