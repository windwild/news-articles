---
title: "Introducing Fluid compute: The power of servers, in serverless form - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-fluid-compute"
date: "2025-02-04"
scraped_at: "2026-03-02T09:37:15.696218322+00:00"
language: "en-zh"
translated: true
description: "Fluid compute on Vercel combines serverless efficiency with server-like flexibility, reducing cold starts and cutting compute costs by up to 85%. Scale intelligently, minimize latency, and optimize pe..."
---

Feb 4, 2025

2025 年 2 月 4 日

虽然专用服务器能提供高效性与始终在线的可用性，但往往导致资源过度配置、扩展困难以及运维开销增加。无服务器计算（serverless computing）通过自动扩缩容和按需付费模式改善了这一状况，但也可能遭遇冷启动问题，并在空闲时段造成资源利用低效。

是时候采用一种全新且更均衡的方案了。[**Fluid compute（弹性计算）**](https://vercel.com/fluid) 在无服务器架构基础上进一步演进，摒弃单次调用式函数，转而采用高性能微型服务器（mini-servers）。该模型已帮助数千名早期用户大幅提升资源利用效率、显著降低冷启动频率，并将计算成本**最高降低 85%**。

## **什么是 Fluid compute（弹性计算）？**

## **什么是弹性计算？**

Fluid compute（弹性计算）是一种面向 Web 应用程序基础设施的全新计算模型。其核心是一套旨在优化性能与成本、并前瞻性应对当今动态 Web 需求的设计原则：

- 计算资源仅在真正需要时才被触发  
- 实时扩缩容：从零流量无缝扩展至峰值流量  
- 优先复用现有资源，仅在必要时才扩容新资源  
- 按实际计算使用量计费，最大限度减少资源浪费  
- 预热实例可降低延迟，彻底规避冷启动

- Supports advanced tasks like streaming and post-response processing  
- 支持流式传输（streaming）和响应后处理（post-response processing）等高级任务  

All with zero configuration and zero maintenance overhead.  
所有功能均无需任何配置，也无需运维维护开销。

![Fluid compute allows for more efficient compute usage than traditional serverless](images/introducing-fluid-compute-the-power-of-servers-in-serverless-form-vercel/img_001.jpg)![Fluid compute allows for more efficient compute usage than traditional serverless](images/introducing-fluid-compute-the-power-of-servers-in-serverless-form-vercel/img_002.jpg)![Fluid compute allows for more efficient compute usage than traditional serverless](images/introducing-fluid-compute-the-power-of-servers-in-serverless-form-vercel/img_003.jpg)![Fluid compute allows for more efficient compute usage than traditional serverless](images/introducing-fluid-compute-the-power-of-servers-in-serverless-form-vercel/img_004.jpg)

Fluid compute allows for more efficient compute usage than traditional serverless  
流体计算（Fluid compute）相比传统无服务器架构（serverless），可实现更高效的计算资源利用。

## **The evolution of Vercel Functions**  
## **Vercel Functions 的演进**

Fluid delivers measurable improvements across a variety of use cases, from ecommerce to AI applications. Its unique execution model combines serverless efficiency with server-like flexibility, providing real benefits for modern web applications.  
Fluid 在多种应用场景中（从电商到 AI 应用）均带来可量化的性能提升。其独特的执行模型融合了无服务器架构的高效性与传统服务器的灵活性，为现代 Web 应用提供了切实优势。

### Smarter scaling with higher ceilings and better cost efficiency  
### 更智能的扩缩容：更高的上限与更优的成本效益

Vercel Functions with Fluid compute prioritize existing resources before creating new instances, eliminating hard scaling limits and leveraging warm compute for faster, more efficient scaling. By scaling functions before instances, Fluid shifts to a [many-to-one model](https://vercel.com/blog/serverless-servers-node-js-with-in-function-concurrency) that can handle tens of thousands of concurrent invocations.  
采用 Fluid 计算的 Vercel Functions 优先复用现有资源，而非立即创建新实例，从而消除了硬性扩缩容限制，并借助“预热计算资源”（warm compute）实现更快、更高效的扩缩容。Fluid 将扩缩容粒度从“按实例”升级为“按函数”，转向一种 [多对一模型（many-to-one model）](https://vercel.com/blog/serverless-servers-node-js-with-in-function-concurrency)，可同时支持数以万计的并发调用。

At the same time, Fluid mitigates the risks of uncontrolled execution that can drive up costs. Functions waiting on backend responses can process additional requests instead of sitting idle, reducing wasted compute. Built-in recursion protection prevents infinite loops before they spiral into excessive usage.  
与此同时，Fluid 有效缓解了失控执行带来的成本激增风险。当函数正在等待后端响应时，它可转而处理其他请求，而非空闲等待，从而显著减少计算资源浪费。内置的递归防护机制可在无限循环演变为过度资源消耗前及时拦截。

### Cold start prevention for reduced latency  
### 冷启动预防：降低延迟

Fluid minimizes the effects of cold starts by greatly reducing their frequency and softening their impact. When cold starts do happen, a [Rust-based runtime](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust) with full Node.js and Python support accelerates initialization. [Bytecode caching](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions) further speeds up invocation by pre-compiling function code, reducing startup overhead.

Fluid 通过大幅降低冷启动发生频率并弱化其影响，从而最小化冷启动带来的负面效应。当冷启动确实发生时，一个[基于 Rust 的运行时](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust)（全面支持 Node.js 和 Python）可加速初始化过程。[字节码缓存](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions)则通过预先编译函数代码进一步加快调用速度，显著减少启动开销。

### Support for advanced tasks

### 对高级任务的支持

Vercel Functions with Fluid compute extend the lifecycle of an invocation, enabling function executions to extend beyond when the final response is sent back to a client.

启用 Fluid 计算的 Vercel Functions 延长了单次调用的生命周期，使函数执行可延续至最终响应返回客户端之后。

With [`waitUntil`](https://vercel.com/changelog/waituntil-is-now-available-for-vercel-functions), tasks like logging, analytics, and database updates can continue to run in the background of a compute function to reduce time to response. For AI workloads, this means managing post-response tasks like model training updates without impacting real-time performance.

借助 [`waitUntil`](https://vercel.com/changelog/waituntil-is-now-available-for-vercel-functions)，日志记录、数据分析和数据库更新等任务可在计算函数后台持续运行，从而缩短响应时间。对于 AI 工作负载而言，这意味着可在不影响实时性能的前提下，异步处理响应返回后的任务（例如模型训练更新）。

### Dense global compute and multi-region failover

### 密集型全球计算与多区域故障转移

Vercel Functions with Fluid compute support a dense global compute model, running compute closer to where your data already lives instead of attempting unrealistic replication across every edge location. Rather than forcing widespread data distribution, this approach ensures your compute is placed in regions that align with your data, optimizing for both performance and consistency.

启用 Fluid 计算的 Vercel Functions 支持密集型全球计算模型：将计算资源部署在更靠近您现有数据所在地的区域，而非不切实际地尝试在每个边缘节点复制全部数据。该方案避免强制进行大规模数据分发，确保计算资源部署在与您的数据地理位置相匹配的区域，兼顾性能与数据一致性。

Dynamic requests are routed to the nearest healthy compute region—among your designated locations—ensuring efficient and reliable execution. In addition to standard [multi-availability zone failover](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends), for enterprise customers, multi-region failover is now the default when activating Fluid.

动态请求将被路由至您指定位置中最近且健康的计算区域，保障执行的高效性与可靠性。除标准的[多可用区故障转移](https://vercel.com/blog/effortless-high-availability-for-dynamic-frontends)外，企业客户在启用 Fluid 后，多区域故障转移现已默认启用。

### Open, portable, and fully supported

### 开放、可移植且获得完整支持

Vercel Functions run without proprietary code, ensuring full portability across any provider that supports standard function execution. Developers don’t need to write functions explicitly for the infrastructure—workloads are inferred and automatically provisioned.

Vercel Functions 不依赖专有代码，确保其可在任何支持标准函数执行的平台间完全可移植。开发者无需为特定基础设施专门编写函数——工作负载将被自动推断并按需自动配置。

With full Node.js and Python runtime support, including native modules and the standard library, Fluid ensures seamless compatibility with existing applications and frameworks—without runtime constraints.

Fluid 全面支持 Node.js 和 Python 运行时（包括原生模块及标准库），确保与现有应用和框架无缝兼容，且不受运行时限制。

## Enable Fluid compute on Vercel today

## 今日在 Vercel 启用 Fluid 计算能力

Fluid compute is available for all users today. Go to the [Functions tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions) in your Project Settings to activate—no migrations or application code changes required.

Fluid 计算能力现已面向所有用户开放。请前往项目设置中的 [Functions（函数）标签页](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions) 启用——无需迁移，也无需修改应用代码。

[**Enable Fluid compute today**\\
\\
Fluid is our fast, cost-efficient compute, available today.\\
\\
Enable Now](https://vercel.com/docs/functions/fluid-compute#how-to-enable-fluid-compute)

[**立即启用 Fluid 计算能力**\\
\\
Fluid 是我们全新推出的快速、高性价比的计算服务，现已正式可用。\\
\\
立即启用](https://vercel.com/docs/functions/fluid-compute#how-to-enable-fluid-compute)

After Fluid is enabled, you can monitor your performance in the [Observability tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability) to track metrics like function performance and compute savings.

启用 Fluid 后，您可在 [Observability（可观测性）标签页](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability) 中监控运行表现，追踪函数性能、计算成本节省等关键指标。

Learn more in the [changelog](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute) and [documentation](https://vercel.com/docs/functions/fluid-compute).

更多详情，请参阅 [更新日志](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute) 和 [官方文档](https://vercel.com/docs/functions/fluid-compute)。

_Acknowledgments: While Fluid is a new compute model, it builds on previous work in the community. We'd like to acknowledge products like Google Cloud Run, and other autoscaling server infrastructure, which has approached solving these problems in similar ways._

_致谢：尽管 Fluid 是一种全新的计算模型，但它建立在社区已有工作的基础之上。我们特别感谢 Google Cloud Run 等产品，以及其它支持自动扩缩容的服务器基础设施——它们以类似方式探索并解决了此类问题。_