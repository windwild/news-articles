---
title: "Bun runtime on Vercel Functions - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/bun-runtime-on-vercel-functions"
date: "2025-10-28"
scraped_at: "2026-03-02T09:26:57.939056726+00:00"
language: "en-zh"
translated: true
description: "Vercel Functions now supports the Bun runtime, giving developers faster performance options and greater flexibility for optimizing JavaScript workloads."
---

render_with_liquid: false
Oct 28, 2025

2025 年 10 月 28 日

We now support [Bun](https://bun.com/) as a [runtime option for Vercel Functions](https://vercel.com/docs/functions/runtimes/bun), available in Public Beta. You can choose between Node.js and Bun for your project, configuring runtime behavior based on workload. We're working closely with the Bun team to bring this capability to production.

我们现已支持将 [Bun](https://bun.com/) 作为 [Vercel Functions 的运行时选项](https://vercel.com/docs/functions/runtimes/bun)，目前处于公开测试（Public Beta）阶段。您可在项目中自由选择 Node.js 或 Bun 作为运行时，并根据工作负载特性灵活配置运行时行为。我们正与 Bun 团队紧密合作，加速该功能迈向正式生产环境。

This flexibility allows you to choose what works best for your use case. Use Node.js for maximum compatibility or switch to Bun for compute-intensive applications that benefit from faster execution.

这种灵活性使您能为具体应用场景选择最合适的方案：若追求最大兼容性，请使用 Node.js；若面向计算密集型应用并希望获得更快的执行速度，则可切换至 Bun。

Through internal testing, we've found that Bun reduced average latency by 28% in CPU-bound Next.js rendering workloads compared to Node.js.

通过内部测试，我们发现：在 CPU 密集型的 Next.js 渲染工作负载场景下，Bun 相较于 Node.js 将平均延迟降低了 28%。

These gains come from Bun's runtime architecture, built in Zig with optimized I/O and scheduling that reduce overhead in JavaScript execution and data handling.

这些性能提升源于 Bun 的运行时架构——其使用 Zig 语言编写，具备经过优化的 I/O 和调度机制，从而显著降低了 JavaScript 执行及数据处理过程中的运行开销。

## How to use the Bun runtime

## 如何使用 Bun 运行时

The [Bun](https://bun.com/) runtime is currently supported for [Next.js](https://nextjs.org/), [Express](https://expressjs.com/), [Hono](https://hono.dev/), and [Nitro](https://nitro.build/), with support for additional frameworks coming soon.

目前，[Bun](https://bun.com/) 运行时已支持 [Next.js](https://nextjs.org/)、[Express](https://expressjs.com/)、[Hono](https://hono.dev/) 和 [Nitro](https://nitro.build/)；对更多框架的支持也即将推出。

To enable Bun for your entire project, add the `bunVersion` setting to your `vercel.json` file:

如需为整个项目启用 Bun，请在 `vercel.json` 文件中添加 `bunVersion` 配置项：

vercel.json

vercel.json

```json
1{

2  "bunVersion": "1.x"

3}
```

在 `vercel.json` 中添加 `bunVersion` 字段，以在您的应用中启用 Bun 运行时支持。

通过此配置，Bun 将应用于您的整个部署，并自动与 Vercel 的可观测性、日志记录和监控基础设施集成。

Bun 对 TypeScript 提供零配置支持。以下是一个使用 Hono 创建简单 API 的示例：

`src/index.ts`

```typescript
import { Hono } from 'hono';



const app = new Hono();
```

```js
app.get('/', (c) => {

6  return c.text(`Hello from Hono on Bun ${process.versions.bun}!`);

7});



export default app;
```

```js
app.get('/', (c) => {

6  return c.text(`Hello from Hono on Bun ${process.versions.bun}!`);

7});



export default app;
```

Hello World endpoint in Hono with the Bun runtime on Vercel

在 Vercel 上使用 Bun 运行时的 Hono “Hello World” 端点

You can also get started by using one of our starter templates:

您也可以通过使用我们的任一入门模板快速开始：

- [Express on Bun](https://vercel.com/templates/backend/express-on-bun)

- [Express on Bun](https://vercel.com/templates/backend/express-on-bun)

- [Hono on Bun](https://vercel.com/templates/backend/hono-on-bun)

- [Hono on Bun](https://vercel.com/templates/backend/hono-on-bun)

The Bun runtime runs on [Fluid compute](https://vercel.com/fluid), which handles multiple concurrent requests on the same instance. [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) means you pay for time spent executing code, not wall-clock time waiting on responses. If your function is waiting for a database query or an API call, you're not being charged for that wait time.

Bun 运行时运行于 [Fluid 计算平台（Fluid compute）](https://vercel.com/fluid)，该平台可在同一实例上处理多个并发请求。[主动 CPU 计费（Active CPU pricing）](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) 意味着您仅需为代码实际执行所消耗的 CPU 时间付费，而非为等待响应的挂钟时间（wall-clock time）付费。如果您的函数正在等待数据库查询或外部 API 调用完成，则此等待时间不会产生费用。

## Why runtime choice matters

## 为何运行时选择至关重要

Applications handle different kinds of workloads. Some perform heavy computation, others handle high request volume or stream large responses. Choosing the right runtime for your application lets you optimize for what matters most.

应用程序处理不同类型的负载：有些以密集计算为主，有些则需应对高并发请求或流式传输大体积响应。为您的应用选择合适的运行时，可让您针对最关键的指标进行优化。

Bun delivers low-latency performance, efficient streaming, and robust built-in APIs through a safety-focused systems language, while Node.js offers unparalleled ecosystem maturity and broad compatibility for every use case. The choice depends on your application's priorities.

Bun 基于一门注重安全性的系统编程语言，提供低延迟性能、高效的流式处理能力以及健壮的内置 API；而 Node.js 则凭借其无与伦比的生态系统成熟度和广泛的兼容性，适用于各种使用场景。具体选择取决于您应用的核心需求。

Because Vercel runs native Node.js and Bun runtimes, code runs exactly as it does locally. No emulation or compatibility layers, just full access to each runtime's native capabilities. Switching between them is a configuration change in `vercel.json`.

由于 Vercel 原生支持 Node.js 和 Bun 运行时，代码在生产环境中的行为与本地完全一致——无需模拟层或兼容性适配层，即可直接调用各运行时的原生能力。在两者间切换仅需修改 `vercel.json` 中的一处配置。

## Benchmark results

## 基准测试结果

Recently, independent developer [Theo Browne](https://x.com/theo) published [comprehensive benchmarks](https://github.com/t3dotgg/cf-vs-vercel-bench) testing CPU performance across server-side rendering (Next.js, React, SvelteKit) and computational workloads, comparing Cloudflare Workers and Vercel Functions. We analyzed the results in [our previous post](https://vercel.com/blog/fluid-compute-benchmark-results).

近期，独立开发者 [Theo Browne](https://x.com/theo) 发布了 [一套全面的基准测试](https://github.com/t3dotgg/cf-vs-vercel-bench)，在服务端渲染（Next.js、React、SvelteKit）及计算密集型任务等场景下，对比评估了 Cloudflare Workers 与 Vercel Functions 的 CPU 性能表现。我们在 [此前的博客文章](https://vercel.com/blog/fluid-compute-benchmark-results) 中对这些结果进行了深入分析。

We want to thank Theo for this work. Efforts like these surface valuable insights into runtime performance, and healthy competition helps push the entire ecosystem forward, benefiting everybody.

我们衷心感谢 Theo 的这项工作。此类努力有助于揭示运行时性能的关键洞见；良性的竞争亦能推动整个生态持续进步，最终惠及所有开发者。

Following the initial benchmarks, improvements were made across the ecosystem. Cloudflare optimized their scheduling algorithm and V8 garbage collection tuning, and [proposed a PR](https://github.com/nodejs/node/pull/60153) to Node.js enabling a V8 flag that improves math operations. Work on OpenNext improved Next.js performance across alternative hosting environments. We profiled our infrastructure and identified bottlenecks in Node.js web streams implementation.

在首轮基准测试之后，整个生态体系陆续推出多项优化：Cloudflare 改进了其调度算法并调优了 V8 垃圾回收机制；同时向 Node.js 提交了 [一项 PR](https://github.com/nodejs/node/pull/60153)，启用一个可提升数学运算性能的 V8 标志位；OpenNext 项目也提升了 Next.js 在各类替代托管环境下的运行性能；此外，我们还对自身基础设施进行了性能剖析，并定位到 Node.js Web Streams 实现中存在的性能瓶颈。

### What we measured when profiling

### 性能剖析中我们测量的内容

The original benchmarks measured time-to-first-byte (TTFB), which captures when the server begins sending a response but not the full cost of generating and transmitting it. The benchmarks were updated to measure total request duration (time-to-last-byte). For server rendering workloads, this more accurately represents what users experience, as it includes the complete work of rendering and streaming the response.

最初的基准测试采用“首字节时间”（TTFB）作为核心指标，该指标仅反映服务器开始发送响应的时间点，却未涵盖生成与完整传输响应所需的全部开销。后续测试已更新为测量“总请求耗时”（即“末字节时间”，Time-to-Last-Byte）。对于服务端渲染类负载而言，这一指标更能真实反映终端用户的实际体验，因为它完整包含了页面渲染与响应流式传输的全部过程。

We deployed to Vercel with 1 vCPU/2GB in `iad1` (`us-east-1`) and ran the benchmark client from a VM in the same AWS region to minimize network variability.

我们在 `iad1`（即 `us-east-1`）区域以 1 vCPU / 2 GB 配置将应用部署至 Vercel，并在同一 AWS 区域内的虚拟机上运行基准测试客户端，以最大限度降低网络延迟波动。

The benchmarks focused on server-side rendering, the process of generating HTML from React components on the server before sending it to the browser. This differs from client-side rendering, where the browser receives JavaScript and builds the page itself.

本次基准测试聚焦于服务端渲染（Server-Side Rendering, SSR），即在服务器端将 React 组件生成 HTML 后再发送至浏览器的过程。这与客户端渲染（Client-Side Rendering, CSR）不同——后者中浏览器接收 JavaScript 并自行构建页面。

Platform overhead is the time spent in infrastructure code before reaching your application. In these tests, platform overhead accounted for only a small fraction of total request time. Nearly all execution occurred inside the application runtime.

平台开销（Platform Overhead）指请求进入你的应用程序之前，在基础设施代码中所消耗的时间。在本次测试中，平台开销仅占总请求时间的极小部分；几乎全部执行时间均发生在应用运行时内部。

Profiling showed that the main bottleneck in Node.js came from its Web Streams implementation and transform operations, where buffer scanning and data conversions added measurable CPU cost. Garbage collection also consumed a significant share of total processing time under heavy load.

性能分析表明，Node.js 的主要瓶颈源于其 Web Streams 实现及转换操作（transform operations）：缓冲区扫描（buffer scanning）与数据格式转换带来了可观的 CPU 开销；而在高负载下，垃圾回收（Garbage Collection）也占据了相当一部分总处理时间。

![Benchmark results measuring full TTLB with 1 vCPU/2GB](images/bun-runtime-on-vercel-functions-vercel/img_001.jpg)![Benchmark results measuring full TTLB with 1 vCPU/2GB](images/bun-runtime-on-vercel-functions-vercel/img_002.jpg)Benchmark results measuring full TTLB with 1 vCPU/2GB

![使用 1 vCPU/2GB 配置测得的完整 TTLB 基准测试结果](images/bun-runtime-on-vercel-functions-vercel/img_001.jpg)![使用 1 vCPU/2GB 配置测得的完整 TTLB 基准测试结果](images/bun-runtime-on-vercel-functions-vercel/img_002.jpg)使用 1 vCPU/2GB 配置测得的完整 TTLB（Time to Last Byte）基准测试结果

For Next.js workloads, Bun cut latency by 28% compared to Node.js. Performance was similar across platforms for React SSR, SvelteKit, and vanilla JavaScript benchmarks. The Next.js performance gains come from Bun's optimized handling of web streams and reduced garbage collection overhead. We expect the numbers for React SSR will improve further once we integrate Bun's optimized `react-dom/server` implementation.

对于 Next.js 工作负载，Bun 相比 Node.js 将延迟降低了 28%。在 React 服务端渲染（SSR）、SvelteKit 及原生 JavaScript 基准测试中，各平台性能表现相近。Next.js 的性能提升主要得益于 Bun 对 Web Streams 的优化实现以及更低的垃圾回收开销。待我们集成 Bun 优化版的 `react-dom/server` 实现后，React SSR 的性能数据预计将进一步提升。

The complete benchmark implementation is [available on GitHub](https://github.com/t3dotgg/cf-vs-vercel-bench).

完整的基准测试实现代码已在 [GitHub 上开源](https://github.com/t3dotgg/cf-vs-vercel-bench)。

## Performance characteristics and tradeoffs

## 性能特征与权衡取舍

Each runtime has distinct strengths. Bun delivers clear speed improvements for server rendering workloads, while Node.js remains the most compatible and battle-tested environment.

每种运行时均有其独特优势：Bun 在服务端渲染类工作负载中展现出显著的速度优势；而 Node.js 则仍是兼容性最佳、经生产环境长期验证最充分的运行环境。

The table below summarizes their key differences:

下表总结了二者的关键差异：

|     |     |     |
| --- | --- | --- |
| **Category** | **Bun** | **Node.js** |
| **类别** | **Bun** | **Node.js** |
| **Performance** | Faster for CPU-intensive and streaming workloads | Reliable and consistent across workload types |
| **性能** | 在 CPU 密集型和流式工作负载下更快 | 在各类工作负载下均表现稳定可靠 |
| **Cold starts** | Slower than Node.js due to runtime initialization overhead | Mature and well-optimized |
| **冷启动** | 因运行时初始化开销，冷启动速度慢于 Node.js | 成熟且经过充分优化 |
| **Compatibility** | Implements Node.js APIs with growing coverage; edge-case differences may exist | Full ecosystem compatibility |
| **兼容性** | 正逐步实现 Node.js API，覆盖范围持续扩大；某些边缘场景下行为可能存在差异 | 全生态兼容 |
| **Ecosystem maturity** | Rapidly evolving; smaller community | Stable and widely supported across frameworks and libraries |
| **生态成熟度** | 快速演进中；社区规模相对较小 | 稳定可靠，广泛支持各类框架与库 |
| **Best use** | Performance-critical applications | Default for broad compatibility and production stability |
| **适用场景** | 对性能要求严苛的应用 | 追求广泛兼容性与生产环境稳定性的默认选择 |

Test your dependencies under Bun before migrating production traffic to confirm expected behavior. While Bun implements Node.js APIs, some edge cases may behave differently.

请在将生产流量迁移至 Bun 前，先在 Bun 环境下测试您的依赖项，以确认其行为符合预期。尽管 Bun 实现了 Node.js API，但部分边缘场景下的行为仍可能存在差异。

## Deploy Bun on Vercel

## 在 Vercel 上部署 Bun

The [Bun runtime is now available](https://vercel.com/changelog/bun-runtime-now-in-public-beta-for-vercel-functions) in Public Beta.

[Bun 运行时现已上线](https://vercel.com/changelog/bun-runtime-now-in-public-beta-for-vercel-functions)，进入公开测试阶段（Public Beta）。

We're continuing to expand framework support and optimize performance across both Node.js and Bun. If you hit performance issues or have benchmarks to share, we want to see them.

我们正持续扩展对各类框架的支持，并同步优化 Node.js 与 Bun 的整体性能。若您遇到性能问题，或有基准测试结果可供分享，我们非常期待收到您的反馈。

[**Try the Bun runtime on Vercel Functions**\\
\\
Switch between Node.js and Bun with a single configuration change. Available in Public Beta.\\
\\
Deploy with Bun](https://vercel.com/changelog/bun-runtime-now-in-public-beta-for-vercel-functions)

[**在 Vercel Functions 中试用 Bun 运行时**\\
\\
仅需一次配置更改，即可在 Node.js 与 Bun 之间自由切换。当前处于公开测试阶段（Public Beta）。\\
\\
使用 Bun 部署](https://vercel.com/changelog/bun-runtime-now-in-public-beta-for-vercel-functions)