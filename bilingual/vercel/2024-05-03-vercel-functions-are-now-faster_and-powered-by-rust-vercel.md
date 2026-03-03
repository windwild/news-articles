---
title: "Vercel Functions are now faster—and powered by Rust - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust"
date: "2024-05-03"
scraped_at: "2026-03-02T09:45:25.349237325+00:00"
language: "en-zh"
translated: true
description: "Learn about how we've improved startup performance with our Rust-powered functions."
---

May 3, 2024

2024 年 5 月 3 日

Vercel Functions 按需运行代码，无需您自行管理基础设施、配置服务器或升级硬件——其底层现已由 Rust 驱动。

我们正逐步将这些改进部署至新项目中，所有客户将在未来几周内全面迁移到基于 Rust 的新函数平台。您无需执行任何操作。

我们的新系统目前已处理了 **数十亿次调用**，执行速度更快，成本也略有降低。通过向 Rust 迁移，我们已实现：

- 小型工作负载的冷启动速度提升 **30%**

- 大型工作负载的平均响应时间缩短 **80 毫秒**，P99 响应时间缩短 **500 毫秒**

我们希望进一步分享此次技术演进背后的考量，以及我们如何构建一个面向未来性能与可靠性提升的新基础架构。

## 为何选择 Rust？

多年来，我们为 Vercel Functions 不断添加新功能，而这些功能要求我们扩展底层基础设施的基本能力。例如：函数支持 [流式响应（streaming responses）](https://vercel.com/docs/functions/streaming/streaming-examples)，采用基于 [Web API 的函数签名（Web API-based signatures）](https://vercel.com/docs/functions/functions-api-reference)，具备 [自动递归防护（automatic recursion protection）](https://vercel.com/changelog/automatic-recursion-protection-for-vercel-serverless-functions)，等等。

在过去一年中，我们持续对函数性能进行剖析与优化，发现大量可显著缩短启动时间的机会。其中首要举措，便是将函数初始化阶段（即启动时）和调用阶段（即处理请求时）重写为使用比 JavaScript 更底层的语言实现。

![Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.](images/vercel-functions-are-now-faster_and-powered-by-rust-vercel/img_001.jpg)  
![通过将逻辑从 Node.js 迁移至全新的 Rust 驱动核心，大型工作负载的平均响应速度提升高达 80ms（平均值），p99 延迟降低高达 500ms。](images/vercel-functions-are-now-faster_and-powered-by-rust-vercel/img_001.jpg)  

![Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.](images/vercel-functions-are-now-faster_and-powered-by-rust-vercel/img_002.jpg)  
![通过将逻辑从 Node.js 迁移至全新的 Rust 驱动核心，大型工作负载的平均响应速度提升高达 80ms（平均值），p99 延迟降低高达 500ms。](images/vercel-functions-are-now-faster_and-powered-by-rust-vercel/img_002.jpg)  

![Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.](images/vercel-functions-are-now-faster_and-powered-by-rust-vercel/img_003.jpg)  
![通过将逻辑从 Node.js 迁移至全新的 Rust 驱动核心，大型工作负载的平均响应速度提升高达 80ms（平均值），p99 延迟降低高达 500ms。](images/vercel-functions-are-now-faster_and-powered-by-rust-vercel/img_003.jpg)  

![Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.](images/vercel-functions-are-now-faster_and-powered-by-rust-vercel/img_004.jpg)  
![通过将逻辑从 Node.js 迁移至全新的 Rust 驱动核心，大型工作负载的平均响应速度提升高达 80ms（平均值），p99 延迟降低高达 500ms。](images/vercel-functions-are-now-faster_and-powered-by-rust-vercel/img_004.jpg)  

Up to 80ms faster (average) and 500ms faster (p99) for larger workloads by moving logic from Node.js to the new Rust-powered core.  

通过将逻辑从 Node.js 迁移至全新的 Rust 驱动核心，大型工作负载的平均响应速度提升高达 80ms（平均值），p99 延迟降低高达 500ms。

While moving to Rust is _not_ a silver bullet, it can greatly improve performance and memory management for certain workloads. After some early experiments, it was clear moving to Rust could produce significant performance wins. The following parts of our function "bridge" are now optimized with Rust:

尽管迁移到 Rust 并非“万能良方”，但它确实能显著提升特定工作负载的性能与内存管理效率。在早期实验中，我们已明确证实：采用 Rust 可带来可观的性能提升。目前，我们函数“桥接层”（function “bridge”）中的以下部分均已使用 Rust 进行了优化：

- 读取并注入环境变量（Reading and attaching environment variables）  
- 启动 Node.js 进程（Spawning the Node.js process）  
- 流式传输并加密分块响应（Streaming and encrypting chunked responses）  
- 在函数调用完成前使用 `waitUntil` 等 API（Using APIs like `waitUntil` before completing the function invocation）

## How much faster are Vercel Functions?

## Vercel 函数提速效果如何？

We tested our initial hypothesis with a synthetic function benchmark that returned a "hello world" response in US East (running every 15 minutes). This was enough time for the function to become cold (and the response was not cached).

我们通过一项合成函数基准测试验证了初始假设：该测试在美东地区（US East）每 15 分钟执行一次，返回一个“Hello World”响应。这一间隔足以使函数进入冷启动状态（且响应未被缓存）。

**Vercel Functions, now powered by Rust, were 150ms faster on average** in comparison with our previous version. However, to see if this would really work, we started to validate with a subset of production traffic for vercel.com.

**得益于 Rust 的加持，Vercel 函数的平均响应延迟较此前版本降低了 150ms。** 然而，为验证该优化在真实场景下的有效性，我们进一步在 vercel.com 的部分生产流量中开展了验证测试。

As mentioned above, when a function has a cold start, it goes through two phases: initialization and invocation. When testing with real-world workloads, we saw improvements up to **80ms faster** (average) and **500ms faster** (p99) for larger workloads by moving logic from Node.js to Rust.

如前所述，函数发生冷启动时需经历两个阶段：初始化（initialization）与调用执行（invocation）。在真实工作负载测试中，我们将逻辑从 Node.js 迁移至 Rust 后，大型工作负载的响应速度最高提升了 **80ms（平均值）**，p99 延迟最高降低了 **500ms**。

When streaming, functions connect to the nearest Vercel Edge Network region from your function. Now powered by Rust, this process was **47% faster** (21ms to 11ms, average) and **77% faster** (120ms to 27ms, p99) for the time to connect.

流式传输时，函数会连接至距离您的函数最近的 Vercel 边缘网络区域。如今该过程已由 Rust 驱动，连接耗时平均缩短了 **47%**（从 21 毫秒降至 11 毫秒），p99 延迟更是大幅降低 **77%**（从 120 毫秒降至 27 毫秒）。

As a result, the duration customers are billed for is now slightly shorter. This means you'll pay slightly less for the same workloads (since it's faster). This _also_ means all Next.js App Router workloads are faster, which stream by default. This includes other frameworks that produce streaming responses, as well as standalone Vercel Functions.

因此，客户被计费的时长现在略有缩短——这意味着您执行相同工作负载所需支付的费用将略微减少（因为整体更快）。这也意味着所有默认启用流式传输的 Next.js App Router 工作负载均获得提速。此外，其他支持流式响应的框架，以及独立部署的 Vercel Functions，同样受益于此优化。

We also made improvements to our regional routing, which reduced latency further for invocations, especially for new deployments. The result is that you should see consistently faster startups for Vercel Functions. In addition, you can now more easily select different [CPU and memory options](https://vercel.com/changelog/manage-your-vercel-functions-cpu-and-memory-in-the-dashboard) from the dashboard.

我们还优化了区域路由机制，进一步降低了函数调用的延迟，尤其对新部署效果显著。结果是：Vercel Functions 的冷启动速度更稳定、更快速。此外，您现在可通过控制台更便捷地选择不同的 [CPU 和内存配置](https://vercel.com/changelog/manage-your-vercel-functions-cpu-and-memory-in-the-dashboard)。

## What's next?

## 下一步是什么？

Vercel Functions give you predictable CPU performance, the ability to run dynamic workloads in [multiple regions](https://vercel.com/docs/functions/configuring-functions/region), [automatic SSL and encryption](https://vercel.com/docs/security/encryption), [integrated CI/CD into your Git workflow](https://vercel.com/docs/deployments/git), [preview environments](https://vercel.com/products/dx-platform), [instant rollbacks](https://vercel.com/docs/deployments/instant-rollback), and more—and you can get started for free!

Vercel Functions 提供可预测的 CPU 性能、在 [多个区域](https://vercel.com/docs/functions/configuring-functions/region) 运行动态工作负载的能力、[自动 SSL 与加密](https://vercel.com/docs/security/encryption)、[与 Git 工作流深度集成的 CI/CD](https://vercel.com/docs/deployments/git)、[预览环境](https://vercel.com/products/dx-platform)、[即时回滚](https://vercel.com/docs/deployments/instant-rollback) 等诸多功能——而且您可以完全免费开始使用！

These function improvements will soon be live for all customers. And we're just getting started with performance improvements for our compute products.

这些函数性能改进即将面向所有客户正式上线。而针对我们的计算类产品，性能优化才刚刚拉开序幕。

In the coming weeks, we'll also share more about automatic optimizations we're making to user code, and ways that we're enhancing concurrency for all functions using I/O bound workloads. [Tune into Vercel Ship](https://vercel.com/ship) to hear more about this, as well.

在接下来的几周内，我们还将详细介绍针对用户代码的自动优化措施，以及如何通过提升 I/O 密集型工作负载的并发能力，全面增强所有函数的性能。欢迎关注 [Vercel Ship](https://vercel.com/ship)，获取更多相关信息。

[Learn more about Vercel Functions](https://vercel.com/docs/functions) or get started [building your first site](https://vercel.com/templates).

[深入了解 Vercel Functions](https://vercel.com/docs/functions)，或立即着手 [构建您的首个网站](https://vercel.com/templates)。