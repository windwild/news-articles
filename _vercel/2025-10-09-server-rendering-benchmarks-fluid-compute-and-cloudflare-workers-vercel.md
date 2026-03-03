---
title: "Server rendering benchmarks: Fluid Compute and Cloudflare Workers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/fluid-compute-benchmark-results"
date: "2025-10-09"
scraped_at: "2026-03-02T09:27:16.831684725+00:00"
language: "en-zh"
translated: true
description: "Fluid Compute outperforms Cloudflare Workers by 1.2x–5x in server-side rendering benchmarks, offering faster, more consistent response times through an optimized in-region architecture."
---

Oct 9, 2025

2025年10月9日

独立开发者 [Theo Browne](https://x.com/theo) 近期发布了[全面的性能基准测试报告](https://github.com/t3dotgg/cf-vs-vercel-bench/blob/main/readme.md)，对比了 [Fluid compute](https://vercel.com/fluid) 与 Cloudflare Workers 在服务端渲染（SSR）场景下的性能表现。测试覆盖 Next.js、React、SvelteKit 等多个主流框架，每项测试均执行 100 次迭代。

测试结果表明：在计算密集型任务中，Fluid compute 的执行速度比 Cloudflare Workers 快 1.2 至 5 倍，且响应时间更为稳定。

## What the benchmarks measured  
## 基准测试的测量内容

测试采用各平台典型的生产环境配置：Cloudflare Workers 使用标准限制（共享 CPU、128MB 内存），而 Fluid compute 则启用性能函数（2 个 vCPU、4GB 内存）。这两种配置体现了截然不同的架构设计思路——Cloudflare Workers 的资源约束使其天然适配全球边缘部署；而 Fluid compute 则运行于云内环境，资源可按需灵活配置。

**各框架性能对比**

|     |     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- | --- |
| **Framework** | **Platform** | **Mean** | **Min** | **Max** | **Variability** | **Performance** |
| **框架** | **平台** | **平均值** | **最小值** | **最大值** | **波动范围** | **性能提升** |
| **Next.js** | Fluid compute | 0.534s | 0.343s | 1.442s | 1.098s | **快 3.55 倍** |
|  | Cloudflare | 1.895s | 0.800s | 3.971s | 3.171s |  |
| **React SSR** | Fluid compute | 0.138s | 0.059s | 0.635s | 0.576s | **快 3.45 倍** |
|  | Cloudflare | 0.476s | 0.227s | 1.383s | 1.156s |  |
| **SvelteKit** | Fluid compute | 0.113s | 0.058s | 0.552s | 0.494s | **快 2.59 倍** |
|  | Cloudflare | 0.292s | 0.078s | 1.038s | 0.960s |  |
| **Math operations** | Fluid compute | 0.702s | 0.463s | 1.136s | 0.673s | **快 2.09 倍** |
|  | Cloudflare | 1.469s | 0.751s | 3.387s | 2.636s |  |
| **Vanilla JS** | Fluid compute | 0.208s | 0.119s | 0.743s | 0.624s | **快 1.06 倍** |
|  | Cloudflare | 0.220s | 0.104s | 0.620s | 0.516s |  |

在上述各类工作负载中，Fluid compute 的平均性能为 Cloudflare Workers 的 2.55 倍。“波动范围”（Variability）一栏表示单次请求最快与最慢响应时间之间的差值。例如，在 Next.js 场景下，Cloudflare 的响应时间跨度达 3.171 秒（从 0.800 秒到 3.971 秒），而 Fluid compute 仅为 1.098 秒（从 0.343 秒到 1.442 秒）。

单次运行结果还揭示了异常值现象：在 Next.js 和 SvelteKit 场景中，约五分之一的 Cloudflare 请求耗时超过 10 秒——尽管其任务平均耗时仅约 1.2 秒。这意味着同一页面加载，可能某次瞬间完成，而另一次却令人沮丧地缓慢。

用户感知的是每一次具体请求，而非统计平均值。对生产级应用而言，性能的一致性往往比单纯的“平均更快”更为关键。

## How Fluid compute works

## Fluid compute 的工作原理

Fluid compute is the default runtime on Vercel. The architecture makes specific trade-offs to optimize server-side rendering workloads.

Fluid compute 是 Vercel 上的默认运行时。该架构在设计上进行了特定取舍，以专门优化服务端渲染（SSR）类工作负载。

### In-region deployment

### 同区域部署

Server-rendered applications typically make database queries and API calls during request processing. An application making five database queries per request spends far more time waiting for data than rendering components.

服务端渲染应用通常在请求处理过程中执行数据库查询和 API 调用。一个每请求执行五次数据库查询的应用，其等待数据返回所花费的时间远超渲染组件本身所需时间。

Fluid compute deploys in the same cloud region as your infrastructure. When your database runs in AWS US-East-1, Fluid functions can deploy to AWS US-East-1. This co-location reduces network latency for database queries and API calls. For applications making multiple database queries per request, network proximity affects total request time. JSON serialization, schema validation, API calls to external services, and database queries all involve I/O operations where deployment location matters.

Fluid compute 与您的基础设施部署在同一云区域。例如，当您的数据库运行在 AWS us-east-1 区域时，Fluid 函数也可部署至 AWS us-east-1。这种同区域共置显著降低了数据库查询与 API 调用的网络延迟。对于每请求需执行多次数据库查询的应用而言，网络距离直接影响整体请求耗时。JSON 序列化、模式校验、对外部服务的 API 调用以及数据库查询等操作均属于 I/O 密集型任务，其性能高度依赖部署位置。

### Full runtime compatibility

### 完整的运行时兼容性

Cloudflare Workers run a custom JavaScript runtime that approximates Node.js behavior. You cannot use `performance.now()` on Cloudflare. The API is frozen due to Spectre mitigation in the isolate model. When Workers run code in an isolate instead of a VM, you share memory with other workers. Security constraints limit which APIs work.

Cloudflare Workers 运行在一个自定义的 JavaScript 运行时之上，该运行时仅近似模拟 Node.js 行为。例如，在 Cloudflare 上无法使用 `performance.now()`；由于隔离（isolate）模型中为缓解 Spectre 漏洞而冻结了部分 API，其能力受到严格限制。当 Workers 在隔离环境中（而非虚拟机中）运行代码时，多个 Worker 实例会共享内存空间，安全约束进一步限制了可用 API 的范围。

Fluid compute runs standard Node.js and Python. You can specify Node.js 24 or any version. The entire npm ecosystem works without compatibility layers. Frameworks like Next.js, Remix, and SvelteKit assume they're running in Node.js. When the runtime only approximates Node.js, compatibility issues emerge. Packages may not work as expected. Edge cases break. Debugging is harder when the runtime behaves differently than documented Node.js behavior.

Fluid compute 运行标准的 Node.js 和 Python 环境。您可自由指定 Node.js 24 或任意其他受支持版本。整个 npm 生态系统均可原生运行，无需任何兼容层。Next.js、Remix 和 SvelteKit 等主流框架均假设自身运行于标准 Node.js 环境中。一旦运行时仅“近似”Node.js 行为，兼容性问题便会浮现：第三方包可能无法按预期工作，边界场景容易出错，且当运行时行为与官方文档中定义的 Node.js 行为不一致时，调试难度将显著增加。

### Concurrency and resource configuration

### 并发处理与资源配置

Fluid compute processes multiple function invocations concurrently on the same environment. Combined with [scale to 1](https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts), this approach maintains warm instances and enables efficient resource usage for server-side rendering.

Fluid compute 可在同一运行环境中并发处理多个函数调用。结合 [“缩放至 1”（Scale to One）](https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts) 技术，该方案能持续维持实例“常驻热态”，从而为服务端渲染提供高效、低开销的资源利用能力。

Resources are configurable from 1-4 vCPU and up to 4GB RAM. This flexibility lets you optimize for your workload. Lightweight operations like middleware run efficiently with minimal resources. Compute-intensive operations like server rendering or AI inference can scale up. Both Fluid compute and Cloudflare Workers use CPU-based pricing where you pay for actual compute time.

资源可配置为 1–4 个 vCPU，内存最高可达 4 GB。这种灵活性使您能够针对自身工作负载进行优化。中间件等轻量级操作可在极少资源下高效运行；而服务器端渲染或 AI 推理等计算密集型操作则可按需扩容。Fluid compute 和 Cloudflare Workers 均采用基于 CPU 的计费模式——您只为实际消耗的计算时间付费。

## Workload flexibility

## 工作负载灵活性

Edge deployment works well for specific use cases. Serving static assets from the edge is fast because assets are cached close to users. Simple routing logic or header manipulation works at the edge because these operations don't need database access or heavy computation.

边缘部署在特定用例中表现优异。从边缘节点提供静态资源速度很快，因为资源被缓存在离用户更近的位置。简单的路由逻辑或请求头（header）处理也可在边缘执行，因为这些操作无需访问数据库，也不涉及繁重的计算。

Fluid compute handles both lightweight and compute-intensive workloads on the same platform. High concurrency runs middleware and simple APIs efficiently. Configurable resources handle server rendering and complex application logic. The platform adapts to your workload instead of forcing your workload to adapt to platform constraints.

Fluid compute 在同一平台上同时支持轻量级与计算密集型工作负载：高并发场景下，中间件和简单 API 可高效运行；通过可配置的资源，亦可胜任服务器端渲染及复杂应用逻辑。该平台主动适配您的工作负载，而非要求您迁就平台的固有限制。

## View the benchmarks

## 查看基准测试结果

The complete benchmark implementation and raw results [are available on GitHub](https://github.com/t3dotgg/cf-vs-vercel-bench). The repository includes test code, detailed results, and methodology documentation.

完整的基准测试实现与原始数据结果 [已在 GitHub 上开源](https://github.com/t3dotgg/cf-vs-vercel-bench)。该仓库包含测试代码、详尽的结果数据以及方法论说明文档。

Deployment architecture determines performance characteristics. For server rendering workloads that query databases and perform compute operations, in-region deployment with full runtime compatibility provides measurable advantages.

部署架构决定了性能特征。对于需要查询数据库并执行计算操作的服务器端渲染工作负载，具备完整运行时兼容性的同区域（in-region）部署可带来可衡量的性能优势。