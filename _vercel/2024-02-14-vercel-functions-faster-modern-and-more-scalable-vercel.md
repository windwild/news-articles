---
render_with_liquid: false
title: "Vercel Functions: Faster, modern, and more scalable - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/evolving-vercel-functions"
date: "2024-02-14"
scraped_at: "2026-03-02T09:48:10.240005162+00:00"
language: "en-zh"
translated: true
description: "Our first major iteration of Vercel Functions with increased concurrency, longer durations, faster cold starts, streaming, and more."
---
render_with_liquid: false
render_with_liquid: false

Feb 14, 2024

2024 年 2 月 14 日

Faster, modern, and more scalable

更快、更现代、更具可扩展性

We’ve been building a new foundation for compute, built on top of Vercel’s Managed Infrastructure, for the past year.

过去一年中，我们一直在基于 Vercel 托管基础设施（Vercel’s Managed Infrastructure）构建全新的计算基础架构。

Today, we’d like to share our first major iteration of Vercel Functions:

今天，我们很高兴向大家介绍 Vercel Functions 的首个重要版本更新：

- [**Increased Concurrency:**](https://vercel.com/blog/evolving-vercel-functions#increased-concurrency) Now up to 100,000 concurrent invocations

- [**并发能力提升：**](https://vercel.com/blog/evolving-vercel-functions#increased-concurrency) 最高支持 100,000 个并发调用

- [**Web Standard APIs:**](https://vercel.com/blog/evolving-vercel-functions#web-standard-api-signature) New Function signature using Web `Request` and `Response`

- [**Web 标准 API 支持：**](https://vercel.com/blog/evolving-vercel-functions#web-standard-api-signature) 新增基于 Web 标准的函数签名，使用 `Request` 和 `Response` 对象

- [**Zero-Config Streaming:**](https://vercel.com/blog/evolving-vercel-functions#zero-config-function-streaming) Stream responses with the full power of Node.js

- [**零配置流式响应：**](https://vercel.com/blog/evolving-vercel-functions#zero-config-function-streaming) 充分利用 Node.js 的全部能力，实现开箱即用的流式响应

- [**Long Running Functions:**](https://vercel.com/blog/evolving-vercel-functions#long-running-functions) Up to 5 minutes on Pro and 15 minutes on Enterprise

- [**长时间运行函数：**](https://vercel.com/blog/evolving-vercel-functions#long-running-functions) Pro 计划最高支持 5 分钟，Enterprise 计划最高支持 15 分钟

- [**Faster Cold Starts:**](https://vercel.com/blog/evolving-vercel-functions#faster-cold-starts) Both runtime and framework improvements

- [**冷启动速度提升：**](https://vercel.com/blog/evolving-vercel-functions#faster-cold-starts) 运行时与框架层面双重优化

- [**Automatic Regional Failover:**](https://vercel.com/blog/evolving-vercel-functions#automatic-regional-failover) Increased resiliency for Enterprise teams

- [**自动区域故障转移：**](https://vercel.com/blog/evolving-vercel-functions#automatic-regional-failover) 显著增强企业团队的服务弹性

Get started with Vercel Functions today or continue reading to learn more about how we’ve improved the foundations of our compute platform.

今天即可开始使用 Vercel Functions，或继续阅读，了解我们如何改进了计算平台的基础架构。

## Increased Concurrency

## 并发能力提升

Vercel Functions 现在具备更优的[自动并发伸缩](https://vercel.com/docs/functions/serverless-functions/runtimes#automatic-concurrency-scaling)能力：Pro 计划支持最高 30,000 个函数并行运行，Enterprise 计划则支持高达 100,000 个，并可选配扩展并发能力。

这确保您的项目即使在流量峰值期间也能自动伸缩。我们针对流量模式不规则的客户（例如[新闻类网站](https://vercel.com/customers/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news)和[电商网站](https://vercel.com/customers)）专门设计了这些改进。

Vercel 的基础设施会根据实际需求自动伸缩。

上述并发能力提升默认适用于 Hobby 和 Pro 计划；Enterprise 计划还可支持更高的并发量。这些改进现已全面可用，且无需修改您的应用代码。

## Web Standard API Signature

## Web 标准 API 签名

我们首次发布 Vercel Functions 时，Node.js 的 [request](https://nodejs.org/api/http.html#class-httpincomingmessage) / [response](https://nodejs.org/api/http.html#class-httpserverresponse) 对象是创建 API 端点的标准接口。这种类似 Express 的语法，既启发了 [Next.js Pages Router](https://nextjs.org/docs/pages/building-your-application/routing/api-routes)，也影响了 Vercel 上独立函数的设计。

api/hello.js

```javascript
export default function handler(request, response) {

2  res.status(200).json({ message: 'Hello Vercel!' });

2  res.status(200).json({ message: 'Hello Vercel!' });

3}
```

3}
```

The Node.js inspired signature for Vercel Functions

Vercel 函数受 Node.js 启发的函数签名

With the release of Node.js 18 and improvements to the Web platform, Node.js now supports the Web standard `Request` and `Response` APIs. To simplify Vercel Functions, we now support a unified function interface that accepts a `Request` and produces a `Response`:

随着 Node.js 18 的发布以及 Web 平台的持续改进，Node.js 现已支持 Web 标准的 `Request` 和 `Response` API。为简化 Vercel 函数，我们现在支持一种统一的函数接口：该接口接收一个 `Request` 对象，并返回一个 `Response` 对象：

api/hello.ts

api/hello.ts

```tsx
export async function GET(request: Request) {

```tsx
export async function GET(request: Request) {

2  const res = await fetch('https://api.vercel.app/blog', { ... } )

2  const res = await fetch('https://api.vercel.app/blog', { ... } )

3  const data = await res.json()



3  const data = await res.json()



5  return Response.json({ data })

5  return Response.json({ data })

6}



export async function POST(request: Request) {

9  // Can also define other HTTP methods like PUT, PATCH, DELETE, HEAD, and OPTIONS

10}
```

Vercel Functions now support a unified, isomorphic signature

Vercel Functions 现在支持统一的、同构的函数签名。

This API interface is similar to Next.js Route Handlers. You can read cookies, headers, and other information from the incoming request using Web APIs. The Web API signature enables you to use MDN, ChatGPT, or other Large Language Models (LLMs) to easily create APIs based on a common standard.

该 API 接口与 Next.js 的路由处理器（Route Handlers）类似。你可以使用 Web 标准 API 从传入的请求中读取 Cookie、请求头（headers）及其他信息。这种基于 Web API 的函数签名，使你能够借助 MDN 文档、ChatGPT 或其他大型语言模型（LLM），依据通用标准便捷地构建 API。

api/hello.ts

```tsx
export async function GET(request: Request) {

2  // Read headers

2  // 读取请求头

3  const token = await getToken(request.headers);

3  const token = await getToken(request.headers);

4  // Set cookies

4  // 设置 Cookie

5  return new Response('Hello Vercel!', {

5  return new Response('Hello Vercel!', {

6    status: 200,

6    status: 200,

7    headers: { 'Set-Cookie': `token=${token.value}` },

7    headers: { 'Set-Cookie': `token=${token.value}` },

8  });

8  });

9}

9}

Learn the Web standard APIs and reuse your knowledge across frameworks

学习 Web 标准 API，并在不同框架间复用您的知识

The existing APIs for Serverless and Edge Functions are still supported and **do not require changes**. To start using the new signature:

现有的 Serverless 和 Edge Functions API 依然受支持，且**无需任何修改**。如需开始使用新签名，请执行以下操作：

- Ensure you are using [Node.js 18 (default)](https://vercel.com/docs/functions/runtimes/node-js#node.js-version)

- 确保您正在使用 [Node.js 18（默认版本）](https://vercel.com/docs/functions/runtimes/node-js#node.js-version)

- Ensure you are on the [latest Vercel CLI version](https://vercel.com/docs/cli)  
- 请确保您已安装 [最新版本的 Vercel CLI](https://vercel.com/docs/cli)

## Zero-Config Function Streaming  

## 零配置函数流式响应

[Earlier this year](https://vercel.com/blog/streaming-for-serverless-node-js-and-edge-runtimes-with-vercel-functions), we launched support for HTTP response streaming for Vercel Functions.  
今年早些时候，我们推出了对 Vercel Functions 的 HTTP 响应流式传输支持。

Support for streaming responses has enabled [building chat interfaces on top of LLMs](https://sdk.vercel.ai/docs), [improving initial page load performance](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) by [deferring slower or non-critical until after the first paint](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming), and much more.  
响应流式传输功能已助力实现：[在大语言模型（LLM）之上构建聊天界面](https://sdk.vercel.ai/docs)、[通过将较慢或非关键内容延迟至首次绘制（first paint）之后再加载，从而提升页面首屏加载性能](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model)，以及更多应用场景。

![Comparison between a non-streaming and streaming HTTP response ](images/vercel-functions-faster-modern-and-more-scalable-vercel/img_001.jpg)![Comparison between a non-streaming and streaming HTTP response ](images/vercel-functions-faster-modern-and-more-scalable-vercel/img_002.jpg)Comparison between a non-streaming and streaming HTTP response  
![非流式与流式 HTTP 响应对比图](images/vercel-functions-faster-modern-and-more-scalable-vercel/img_001.jpg)![非流式与流式 HTTP 响应对比图](images/vercel-functions-faster-modern-and-more-scalable-vercel/img_002.jpg)非流式与流式 HTTP 响应对比

Vercel Functions support streaming for both Node.js and Edge runtimes with zero additional configuration. This includes the new Web API signature.  
Vercel Functions 对 Node.js 和 Edge 运行时均原生支持流式响应，无需任何额外配置——包括对全新 Web API 签名的支持。

Learn more about [streaming on the web](https://vercel.com/blog/an-introduction-to-streaming-on-the-web), view our [streaming documentation](https://vercel.com/docs/functions/streaming), or explore [templates for streaming](https://vercel.com/templates/next.js/partial-prerendering-nextjs) with frameworks like Next.js, SvelteKit, Remix, and more.  
深入了解 [Web 上的流式传输技术](https://vercel.com/blog/an-introduction-to-streaming-on-the-web)，查阅我们的 [流式响应文档](https://vercel.com/docs/functions/streaming)，或探索基于 Next.js、SvelteKit、Remix 等框架的 [流式响应模板](https://vercel.com/templates/next.js/partial-prerendering-nextjs)。

## Long Running Functions  

## 长时运行函数

Pro customers can now run Vercel Functions for **up to 5 minutes**.  
Pro 计划用户现在可让 Vercel Functions 最长运行 **5 分钟**。

api/hello.ts  
api/hello.ts

```tsx
export const maxDuration = 300; // 5 minutes



export async function GET(request: Request) {

4  // ...

5}
```

```tsx
export const maxDuration = 300; // 5 分钟



export async function GET(request: Request) {

4  // ...

5}
```

You can run functions for up to five minutes on Pro

在 Pro 计划中，函数最长可运行五分钟。

We recently also improved the [default function duration](https://vercel.com/changelog/serverless-functions-can-now-run-up-to-5-minutes) to prevent unintentional usage, as well as launched [new spend management controls](https://vercel.com/changelog/spend-management-now-available-for-pro-users) to receive SMS notifications or trigger webhooks when you pass a given spend amount on your function usage.

我们近期还优化了[函数默认执行时长](https://vercel.com/changelog/serverless-functions-can-now-run-up-to-5-minutes)，以防止意外的资源消耗；同时推出了[全新的消费管理控制功能](https://vercel.com/changelog/spend-management-now-available-for-pro-users)，当您的函数调用费用超过设定阈值时，即可接收短信通知或触发 Webhook。

Further, with the launch of [Vercel Cron Jobs](https://vercel.com/changelog/vercel-cron-jobs-are-now-generally-available), you can run any task on a schedule which calls your Vercel Function.

此外，随着 [Vercel Cron Jobs](https://vercel.com/changelog/vercel-cron-jobs-are-now-generally-available) 的正式发布，您现在可以按计划定时执行任意任务——这些任务将调用您的 Vercel 函数。

Learn more about [configuring the maximum duration](https://vercel.com/docs/functions/configuring-functions/duration) for Vercel Functions.

了解更多关于如何[配置 Vercel 函数的最大执行时长](https://vercel.com/docs/functions/configuring-functions/duration)的信息。

## Faster Cold Starts

## 更快的冷启动

Vercel Functions now have faster cold boots, with improvements to our Managed Infrastructure for all frameworks and open-source optimizations for Next.js.

Vercel Functions 现在拥有更快的冷启动速度，我们已针对所有框架优化了托管基础设施，并为 Next.js 提供了开源层面的性能改进。

The Next.js App Router bundles server code used for APIs and dynamic pages together. We’ve improved the heuristics for smart bundling of external dependencies and the server runtime, as well as reducing the total size of the server runtime.

Next.js App Router 将用于 API 和动态页面的服务器端代码统一打包。我们优化了外部依赖项与服务器运行时的智能打包策略，并进一步减小了服务器运行时的整体体积。

When comparing Next.js 13 versus the latest Next.js 14 changes, we’ve seen **twice as fast** **cold boot times** as well as smaller function bundles.

对比 Next.js 13 与最新版 Next.js 14 的变更，我们观察到冷启动时间**提升达两倍**，同时函数包体积也更小。

Further, Runtime Logs on Vercel now show detailed [request metrics](https://vercel.com/changelog/metrics-for-outgoing-requests) giving you visibility into how long individual `fetch` requests take. This is often the source of a slow to respond function, and not necessarily the function startup time.

此外，Vercel 的运行时日志（Runtime Logs）现已支持展示详细的[请求指标](https://vercel.com/changelog/metrics-for-outgoing-requests)，帮助您清晰了解每个 `fetch` 请求的实际耗时。函数响应缓慢的根源往往在于这些外部请求，而非函数本身的启动时间。

For Next.js users, [upgrade to the latest version](https://nextjs.org/docs/app/building-your-application/upgrading). If you are using the App Router, there is no configuration required. For the Pages Router, you’ll need to use the `experimental.bundlePagesExternal` flag.

对于 Next.js 用户，请[升级至最新版本](https://nextjs.org/docs/app/building-your-application/upgrading)。若您使用的是 App Router，则无需额外配置；若使用 Pages Router，则需启用 `experimental.bundlePagesExternal` 标志。

## Automatic Regional Failover

## 自动区域故障转移

Vercel's [Edge Network](https://vercel.com/docs/edge-network/overview) is resilient to regional outages by automatically rerouting traffic for static assets. We are enhancing this further with support for Vercel Functions.

Vercel 的[边缘网络（Edge Network）](https://vercel.com/docs/edge-network/overview)已具备应对区域性中断的能力——静态资源流量可自动重定向。现在，我们进一步将该能力扩展至 Vercel Functions。

Vercel Functions with the Node.js runtime can now automatically failover to a new region in the instance of regional downtime. Failover regions are also supported through [Vercel Secure Compute](https://vercel.com/docs/security/secure-compute), which allows you to create private connections between your databases and other private infrastructure.

采用 Node.js 运行时的 Vercel Functions 现可在发生区域性服务中断时，自动故障转移到其他可用区域。故障转移区域同样可通过[Vercel Secure Compute](https://vercel.com/docs/security/secure-compute) 实现，该功能支持您在数据库及其他私有基础设施之间建立私有连接。

[Learn more about this feature](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover) or about how [Vercel helps improve your resiliency](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends).

[详细了解此功能](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover)，或了解 [Vercel 如何助您提升系统韧性](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends)。

## Increased Logging Limits

## 日志记录限额提升

Serverless Functions now support increased log lengths, enabling better observability into your application when investigating function logs.  
无服务器函数现已支持更长的日志长度，从而在排查函数日志时显著提升应用的可观测性。

Previously, there was a 4KB log limit per function invocation, which could lead to truncated logs when debugging. With this change, it’s now easier to debug errors that include large stack traces.  
此前，每次函数调用的日志上限为 4 KB，调试过程中常导致日志被截断。此次更新后，包含大型堆栈跟踪（stack trace）的错误将更易于排查。

![Quickly identify the root cause of persistent errors and customer issues with Logs.](images/vercel-functions-faster-modern-and-more-scalable-vercel/img_003.jpg)![Quickly identify the root cause of persistent errors and customer issues with Logs.](images/vercel-functions-faster-modern-and-more-scalable-vercel/img_004.jpg)Quickly identify the root cause of persistent errors and customer issues with Logs.  
![借助日志快速定位持续性错误及客户问题的根本原因。](images/vercel-functions-faster-modern-and-more-scalable-vercel/img_003.jpg)![借助日志快速定位持续性错误及客户问题的根本原因。](images/vercel-functions-faster-modern-and-more-scalable-vercel/img_004.jpg)借助日志快速定位持续性错误及客户问题的根本原因。

Learn more about [Runtime Logs](https://vercel.com/docs/observability/runtime-logs) on Vercel.  
了解更多关于 Vercel 上的[运行时日志（Runtime Logs）](https://vercel.com/docs/observability/runtime-logs)。

## Conclusion

## 总结

We're continuing to evolve our compute products at Vercel. This is the first of many more improvements planned to help you have low latency, instantly scalable, cost effective compute through Vercel Functions.  
我们正持续推进 Vercel 计算产品的发展演进。本次更新是系列优化中的首项——后续还将推出更多改进，助您通过 Vercel Functions 实现低延迟、即时弹性伸缩且高性价比的计算能力。