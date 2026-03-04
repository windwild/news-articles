---
title: "Serverless servers: Efficient serverless Node.js with in-function concurrency - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/serverless-servers-node-js-with-in-function-concurrency"
date: "2024-10-03"
scraped_at: "2026-03-02T09:40:40.690743346+00:00"
language: "en-zh"
translated: true
description: "Building a compute layer that is highly-optimized for interactive workloads, server-rendering, and APIs"
---

render_with_liquid: false
Oct 3, 2024

2024 年 10 月 3 日

Building a compute layer that is highly-optimized for interactive workloads, server-rendering, and APIs

构建一个专为交互式工作负载、服务端渲染（server-rendering）和 API 高度优化的计算层

We’re sharing a first look at a new version of [Vercel Functions](https://vercel.com/docs/functions) with [support for **in-function concurrency**](https://vercel.com/changelog/in-function-concurrency-now-in-public-beta) that brings the best of servers to serverless functions.

我们正首次向大家展示新版 [Vercel Functions](https://vercel.com/docs/functions)，该版本已支持 **函数内并发（in-function concurrency）** ——[现已进入公开测试阶段](https://vercel.com/changelog/in-function-concurrency-now-in-public-beta)——将传统服务器的优势带入无服务器函数（serverless functions）之中。

We’ve been testing this new version with customers and are seeing a **20%-50% reduction in compute usage and respective cost reduction** without latency impact.

我们已与客户共同测试该新版本，观测到计算资源使用量及相应成本降低 **20%–50%**，且未对延迟造成任何影响。

It’s a serverless product optimized specifically for interactive workloads such as server-rendering of web pages, APIs, and AI applications. Vercel Functions continue to offer native Node.js support with [accelerated cold-start performance based on V8 bytecode](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions) and instance pre-warming for production workloads.

这是一款专为交互式工作负载（例如网页服务端渲染、API 及 AI 应用）优化的无服务器产品。Vercel Functions 持续提供原生 Node.js 支持，并借助 [基于 V8 字节码的冷启动加速技术](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions)，以及面向生产环境的工作负载实例预热能力。

[**Public beta: Enable in-function concurrency today**\\
\\
In-function concurrency, now in public beta, allows a single function instance to handle multiple calls simultaneously. This optimizes efficiency by leveraging idle time, potentially cutting costs by up to 50%.\\
\\
Enable Now](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings)

[**公开测试版：立即启用函数内并发功能**\\
\\
函数内并发（in-function concurrency）现已开放公开测试，允许单个函数实例同时处理多个调用。该机制通过充分利用空闲时间提升效率，最高可降低 50% 的成本。\\
\\
立即启用](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings)

## History of serverless for interactive workloads

## 面向交互式工作负载的无服务器技术发展简史

When AWS Lambda introduced "functions as a service," it revolutionized batch workloads by mapping one function instance to one invocation.

当 AWS Lambda 推出“函数即服务（Functions-as-a-Service）”时，它通过“一个函数实例对应一次调用”的映射方式，彻底变革了批处理类工作负载。

However, this model struggles with interactive, dynamic workloads, where single user requests are tied to one function instance which sit idle when the compute is waiting for the backend to respond. These inefficiencies become even more apparent with AI models and other IO-heavy applications that can take seconds to respond.

然而，该模型在应对交互式、动态型工作负载时表现乏力：每个用户请求被绑定至单一函数实例，而当计算等待后端响应时，该实例便处于空闲状态。此类低效问题在 AI 模型及其他 I/O 密集型应用中尤为突出——这些应用的响应往往需要数秒时间。

With in-function concurrency, Vercel Functions breaks away from Lambda’s one-to-one mapping—from invocation to compute—leading to substantial efficiency wins.

借助函数内并发能力，Vercel Functions 打破了 Lambda 所采用的“调用—计算”一对一映射范式，从而实现显著的效率提升。

## The journey to in-function concurrency

## 通往函数内并发的旅程

### Part 1: Establishing a streaming connection

### 第一部分：建立流式连接

In 2022, we [released Next.js 13](https://nextjs.org/blog/next-13) with streaming for React server-side rendering. Vercel’s serverless functions, previously a relatively _thin wrapper_ around AWS Lambda, faced limitations as Lambda didn’t support streaming, so we explored alternatives for our customers.

2022 年，我们[发布了支持流式渲染的 Next.js 13](https://nextjs.org/blog/next-13)，用于 React 服务端渲染。Vercel 的无服务器函数此前本质上只是对 AWS Lambda 的一层_轻量封装_；但由于 Lambda 本身不支持流式响应，这一架构很快遇到了瓶颈，因此我们开始为用户探索替代方案。

![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_001.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_002.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_003.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_004.jpg)

Our idea was to have the function open up a secure TCP socket back to the “function invocation service” and use that socket to stream back responses, even if the actual Lambda invocation doesn’t support streaming.

我们的构想是：让函数主动向“函数调用服务”发起一条安全的 TCP 套接字连接，并通过该套接字流式返回响应——即使底层的 Lambda 调用本身并不支持流式传输。

Once deployed, we realized: _a bidirectional stream to all functions could enable much, much more_—like giving them additional work.

上线后我们意识到：_若所有函数均具备双向流式通道，其潜力将远不止于流式响应——例如，还可动态为其分派额外任务。_

### Part 2: Rust-powered functions

### 第二部分：由 Rust 驱动的函数

With the idea in mind, we got a prototype to work, but there were a few things we needed to address first. Keeping the behavior consistent with the expectations of serverless environments was tough. To solve this, we shifted focus to the function runtime and began rewriting Vercel Functions' runtime in Rust.

在明确这一构想后，我们快速实现了原型，但仍需先解决若干关键问题。其中一大挑战在于：如何确保行为与用户对无服务器环境的预期保持一致。为此，我们将重心转向函数运行时（runtime），并启动了 Vercel Functions 运行时的 Rust 重写工程。

[The rewrite itself unlocked several performance improvements](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust) and better debuggability of the system for users. You can essentially think of the runtime as the ultra-stable in-function [hypervisor](https://aws.amazon.com/what-is/hypervisor/) that orchestrates the workload even if a single function invocation gets into trouble.

[此次重写本身即带来了多项性能提升](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust)，并显著增强了系统对用户的可调试性。你可以将该运行时理解为一种高度稳定的、内置于函数之中的[虚拟机监控程序（hypervisor）](https://aws.amazon.com/what-is/hypervisor/)——即便单次函数调用出现异常，它仍能稳健地协调整体工作负载。

### Part 3: Putting it together

### 第三部分：整合落地

Finally, we had all the building blocks in place to start shipping in-function concurrency for Vercel Functions (for real). The new architecture looks like this:

最后，我们已具备所有必要组件，正式为 Vercel Functions 推出函数内并发（in-function concurrency）功能（这次是真正落地了）。新架构如下所示：

![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_005.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_006.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_007.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_008.jpg)

As traffic reaches our data center, it's routed through a function load balancer to the function invocation service. This service manages connections ranging from a single function instance up to 100,000 instances per function.

当流量抵达我们的数据中心后，会先经由函数负载均衡器（function load balancer）路由至函数调用服务（function invocation service）。该服务可管理从单个函数实例到每个函数最多 100,000 个实例的连接规模。

It ensures traffic is routed to a function invocation service likely to have in-flight invocations for the desired function instances. When an invocation request arrives, the service checks for available instances, and if one exists, forwards the request to it.

它确保将流量路由至**最可能正在执行目标函数实例调用**的函数调用服务节点。当一个调用请求到达时，该服务会检查是否存在可用的函数实例；若存在，则立即将请求转发至该实例。

## Efficiency gains

## 效率提升

Our private beta customers have reported significant efficiency improvements, with some seeing up to a 50% reduction in compute usage. This means fewer gigabyte-hours billed for the same workload with no code changes. Results will vary depending on your backend communication and traffic volume, as the efficiency gains from concurrency apply best when a minimum number of requests is met.

参与私有 Beta 测试的客户反馈了显著的效率提升，部分客户观察到计算资源用量最高降低了 50%。这意味着：在**无需修改任何代码**的前提下，完成相同工作负载所需的计费 GB·小时数大幅减少。实际收益因您的后端通信模式与流量规模而异——并发带来的效率增益在请求量达到一定阈值时效果最为明显。

Here’s how these gains are achieved: Remember, in the traditional serverless model, each invocation is tied to a single function instance.

以下是这些效率提升的实现原理：请记住，在传统无服务器（serverless）模型中，每次函数调用都独占一个函数实例。

![Traditional serverless functions require separate instances for each function call, leaving compute underutilized.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_009.jpg)![Traditional serverless functions require separate instances for each function call, leaving compute underutilized.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_010.jpg)![Traditional serverless functions require separate instances for each function call, leaving compute underutilized.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_011.jpg)![Traditional serverless functions require separate instances for each function call, leaving compute underutilized.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_012.jpg)Traditional serverless functions require separate instances for each function call, leaving compute underutilized.

![传统无服务器函数每次调用都需要独立的实例，导致计算资源未被充分利用。](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_009.jpg)![传统无服务器函数每次调用都需要独立的实例，导致计算资源未被充分利用。](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_010.jpg)![传统无服务器函数每次调用都需要独立的实例，导致计算资源未被充分利用。](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_011.jpg)![传统无服务器函数每次调用都需要独立的实例，导致计算资源未被充分利用。](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_012.jpg)传统无服务器函数每次调用都需要独立的实例，导致计算资源未被充分利用。

Vercel’s new system, however, allows a single instance to handle multiple invocations by utilizing idle time spent waiting for backend responses.

而 Vercel 的新系统则不同：它允许**单个函数实例通过复用等待后端响应的空闲时间，同时处理多个调用**。

![With in-function concurrency, a single function instance can utilize already-available compute for new function calls.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_013.jpg)![With in-function concurrency, a single function instance can utilize already-available compute for new function calls.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_014.jpg)![With in-function concurrency, a single function instance can utilize already-available compute for new function calls.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_015.jpg)![With in-function concurrency, a single function instance can utilize already-available compute for new function calls.](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_016.jpg)With in-function concurrency, a single function instance can utilize already-available compute for new function calls.

![借助函数内并发，单个函数实例可复用已就绪的计算资源来处理新的函数调用。](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_013.jpg)![借助函数内并发，单个函数实例可复用已就绪的计算资源来处理新的函数调用。](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_014.jpg)![借助函数内并发，单个函数实例可复用已就绪的计算资源来处理新的函数调用。](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_015.jpg)![借助函数内并发，单个函数实例可复用已就绪的计算资源来处理新的函数调用。](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_016.jpg)借助函数内并发，单个函数实例可复用已就绪的计算资源来处理新的函数调用。

For example, let’s say a request takes 100ms, with 50ms spent on computation and 50ms waiting for a backend response.

例如，假设一个请求耗时 100 毫秒，其中 50 毫秒用于计算，另外 50 毫秒用于等待后端响应。

- **Old model**: Two requests would require a total of 200ms of compute time

- **旧模型**：两个请求总共需要 200 毫秒的计算时间

- **New model**: Two requests could be handled by one invocation, reducing the actual compute time to ~100ms

- **新模型**：两个请求可由一次函数调用处理，实际计算时间降低至约 100 毫秒

## Fulfilling the Node.js dream on serverless

## 在 Serverless 环境中实现 Node.js 的愿景

Node.js was created to handle asynchronous IO concurrently. While existing functions-as-a-service products could take advantage of this in the context of a _single_ invocation, they often don’t have the opportunity to use all the available CPU.

Node.js 诞生之初便旨在并发处理异步 I/O。尽管现有的函数即服务（FaaS）产品可在**单次调用**的上下文中利用这一特性，但它们往往无法充分利用所有可用的 CPU 资源。

With in-function concurrency, Vercel Functions can take full advantage of Node.js’ concurrency capabilities. As an example, whenever a function is stalled waiting for a backend to respond, it can handle a second request with the available CPU immediately. Respectively, the compute time is utilized rather than sitting idle, leading to substantial efficiency gains.

借助函数内并发（in-function concurrency），Vercel Functions 能够充分发挥 Node.js 的并发能力。举例来说，当某个函数因等待后端响应而阻塞时，它可立即利用空闲 CPU 处理第二个请求。相应地，计算时间被有效利用而非闲置，从而带来显著的效率提升。

## Trade-offs of the current implementation

## 当前实现的权衡取舍

During the beta phase, we’re limiting the maximum number of concurrent invocations dispatched to a single function instance. We’ll slowly increase these limits over the duration of the beta period, so we can monitor trade-offs between efficiency and latency.

在 Beta 测试阶段，我们限制了分发至单个函数实例的最大并发调用数。我们将随着 Beta 期的推进逐步提高该限制，以便持续监测效率与延迟之间的权衡关系。

While we’ve seen performance gains with all private beta customers, the mechanism may increase latency for purely CPU-bound workloads. We also expect our detection of unhelpful concurrency to substantially improve during the beta period, ensuring it's only used in the right situations.

尽管所有私有 Beta 用户均观察到了性能提升，但该机制可能增加纯 CPU 密集型工作负载的延迟。此外，我们预计在 Beta 期间对“无效并发”（unhelpful concurrency）的识别能力将大幅提升，确保该机制仅在适用场景下启用。

Finally, this mechanism inherently changes that a single Node.js process handles multiple invocations concurrently. As mentioned above, this is really how Node.js is typically being run in production. Therefore, while this is technically a backward-incompatible change (and opt-in), we expect the vast majority of workloads to work under the new semantics.

最后，该机制本质上改变了“单个 Node.js 进程并发处理多个调用”的行为。如前所述，这实际上正是 Node.js 在生产环境中惯常的运行方式。因此，尽管从技术角度看这是一个向后不兼容的变更（且需显式启用），我们仍预期绝大多数工作负载均可无缝适配新的语义。

## It’s still serverless

## 它依然是无服务器架构

While this new architecture substantially increases the [efficiency of Vercel Functions](https://vercel.com/blog/understanding-vercel-functions), it changes absolutely nothing about their serverless nature. Vercel Functions continue to:

虽然这一新架构大幅提升了 [Vercel Functions 的效率](https://vercel.com/blog/understanding-vercel-functions)，但它**丝毫未改变其无服务器本质**。Vercel Functions 依然具备以下特性：

- Scale automatically  
- 自动扩缩容  

- Never go into maintenance mode—all maintenance is handled automatically with no impact on users or availability  
- 永不进入维护模式——所有维护均由系统自动完成，对用户访问或服务可用性零影响  

- Transparently ship security updates for operating system and runtime without any downtime or work for you  
- 透明推送操作系统与运行时的安全更新，全程无需停机，也无需您手动干预  

### Real-world impact: Verse’s success with in-function concurrency

### 实际效果：Verse 借助函数内并发实现显著成效

After [Verse](https://madeonverse.com/) launched their internet bedroom website, traffic surged from hundreds of thousands to over 10 million visitors. At its peak, 15,000 users were online concurrently, creating a flood of requests—and potential idle time. This made it an ideal candidate for this new optimization.

[Verse](https://madeonverse.com/) 上线其“互联网卧室”网站后，流量从数十万激增至超 1000 万访客。峰值期间，同时在线用户达 15,000 人，引发大量请求洪流——同时也带来大量潜在的计算空闲时间。这使其成为本次新优化的理想试点场景。

With early access to in-function concurrency, their Vercel Functions cut GB-hours and **reduced costs by over 50%** through automated, smarter use of compute during idle times.

通过率先试用函数内并发（in-function concurrency），其 Vercel Functions 显著降低了 GB·小时用量，并借助空闲时段更智能、自动化的计算资源调度，**将成本降低逾 50%**。

> “Many of our API endpoints were lightweight and involved external requests, resulting in idle compute time. By leveraging in-function concurrency, we were able to share compute resources between requests, cutting costs by over 50% with zero code changes.”  
>  
> “我们的许多 API 端点负载较轻，且需发起外部请求，因而常处于计算空闲状态。借助函数内并发能力，我们得以在多个请求间共享计算资源，在零代码修改的前提下，成功将成本降低逾 50%。”  
>  
> ![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_017.jpg)  
>  
> **Aydan Gooneratne,** Lead Full Stack Developer at Verse  
>  
> **Aydan Gooneratne**，Verse 首席全栈开发工程师  

## Try it out today

## 立即体验

函数内并发（In-function concurrency）现已向所有 Pro 和 Enterprise 用户开放试用。该功能目前处于 Beta 测试阶段，但 Vercel 自身的多个线上业务以及参与私有 Beta 测试的多家客户已将其投入生产环境使用。

要启用该功能，请在项目设置的 **Functions**（函数）标签页中查找[新增选项](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings)。

![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_018.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_019.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_020.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_021.jpg)

我们还推出了更完善的函数使用情况可视化能力。通过项目中的全新 **Observability**（可观测性）标签页，您可直观查看函数成本节约效果，以及对关键性能指标（如延迟和首字节时间 TTFB）的影响：

![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_022.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_023.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_024.jpg)![](images/serverless-servers-efficient-serverless-node_js-with-in-function-concurrency-ver/img_025.jpg)

这是 Vercel Functions 演进历程中令人振奋的下一步。欢迎随时向我们反馈您的使用体验，以及您观察到的任何性能或效率提升。这仅是我们旅程的第一步——我们的目标是：让无服务器（serverless）架构的资源利用效率媲美传统服务器，同时始终保有 Vercel Functions 所特有的精炼、简洁的开发者体验（DX）。

## 致谢

Google Cloud Run 是全托管式容器并发能力的先行者，其公开预览版的 Functions 产品也具备类似的并发特性。放眼 Node.js 生态之外，Deno Deploy、Cloudflare Workers 以及我们自研的 Edge Functions 等产品，同样在面向类无服务器计算场景的并发调用机制上实现了创新突破。

## 公开 Beta：即刻启用函数内并发  
\\  
函数内并发（In-function concurrency）现已进入公开 Beta 阶段，允许单个函数实例同时处理多个请求。该机制通过充分利用函数实例的空闲时间来提升资源效率，最高可降低约 50% 的运行成本。  
\\  
立即启用  
[**立即启用**](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings)