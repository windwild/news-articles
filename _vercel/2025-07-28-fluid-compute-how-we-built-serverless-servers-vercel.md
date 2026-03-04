---
title: "Fluid compute: How we built serverless servers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/fluid-how-we-built-serverless-servers"
date: "2025-07-28"
scraped_at: "2026-03-02T09:30:43.614286307+00:00"
language: "en-zh"
translated: true
description: "Fluid Compute cuts cold starts and compute costs by up to 95%, scaling I/O-bound and AI workloads efficiently across 45B+ weekly requests."
---
&#123;% raw %}

Jul 28, 2025

2025 年 7 月 28 日

A few months ago, we announced [Fluid compute](https://vercel.com/blog/introducing-fluid-compute), an approach to serverless computing that uses resources more efficiently, minimizes cold starts, and significantly reduces costs. More recently at [Vercel Ship 2025](https://vercel.com/blog/vercel-ship-2025-recap), we introduced [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) for even more cost-effective compute on Vercel.

几个月前，我们宣布了 [Fluid compute](https://vercel.com/blog/introducing-fluid-compute) —— 一种更高效的无服务器计算范式，它能更充分地利用计算资源、最大限度减少冷启动，并显著降低成本。最近，在 [Vercel Ship 2025](https://vercel.com/blog/vercel-ship-2025-recap) 大会上，我们进一步推出了 [Active CPU 定价模式](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)，使 Vercel 上的计算资源使用更加经济高效。

Fluid compute with Active CPU pricing powers over 45 billion weekly requests, saving customers up to 95% and never charging CPU rates for idle time.

启用 Active CPU 定价的 Fluid compute 每周支撑超 450 亿次请求，为客户节省高达 95% 的成本，且绝不对空闲时间收取 CPU 费用。

Behind the scenes, it took over two years to build the required infrastructure to make this possible.

幕后，构建支撑这一能力所需的基础设施耗时逾两年。

## It all started with a simple idea

## 一切始于一个简单的构想

In 2020, the React team started working on [React Server Components (RSC)](https://react.dev/blog/2020/12/21/data-fetching-with-react-server-components). RSCs allow requests rendered server-side to stream back parts of the UI as they become available. The [Next.js](https://nextjs.org/) team strongly believed in this model and began building the [App Router](https://nextjs.org/blog/next-13) on top of RSCs to enable streaming capabilities.

2020 年，React 团队开始研发 [React Server Components（RSC）](https://react.dev/blog/2020/12/21/data-fetching-with-react-server-components)。RSC 允许服务端渲染的请求在 UI 各部分就绪时即刻以流式方式返回。[Next.js](https://nextjs.org/) 团队高度认同这一模型，并基于 RSC 开始构建 [App Router](https://nextjs.org/blog/next-13)，以原生支持流式响应能力。

Vercel Functions run on AWS Lambda, which at the time, didn’t allow streaming responses ( [it does now](https://aws.amazon.com/blogs/compute/introducing-aws-lambda-response-streaming/), with some limitations). We had to find a way to support HTTP streaming. That work became the foundation for what would later power Fluid compute.

Vercel Functions 运行于 AWS Lambda 之上；而彼时的 Lambda 尚不支持流式响应（[如今已支持](https://aws.amazon.com/blogs/compute/introducing-aws-lambda-response-streaming/)，但仍存在部分限制）。我们必须找到一种支持 HTTP 流式传输的方法——这项工作最终成为 Fluid compute 的技术基石。

## Building a new transport

## 构建一种新型传输机制

AWS Lambda has a simple execution model. You send it a request (input), it runs, and then returns a response (output). After that, the function instance pauses and waits for another request to come in. If no other requests come in within a certain time frame, the function instance shuts down automatically.

AWS Lambda 采用一种简洁的执行模型：你向其发送一个请求（输入），它执行运算，然后返回一个响应（输出）；此后，该函数实例进入暂停状态，等待下一个请求到来；若在特定时间窗口内未收到新请求，该实例将自动终止。

Under the hood, those inputs and outputs are simple string blobs inside which we used to encode the HTTP request and response, respectively. We wondered, how could we return a proper chunk-by-chunk streamed response, instead of a single blob?

在底层实现中，这些输入与输出原本只是简单的字符串数据块（string blobs），我们曾分别用它们来编码 HTTP 请求与响应。我们不禁思考：如何才能返回真正按块（chunk-by-chunk）流式传输的响应，而非单一的数据块？

The answer was to introduce a new secure transport outside of Lambda's simple event-response model, that securely connects each instance back to our infrastructure.  
答案是：在 AWS Lambda 简单的“事件-响应”模型之外，引入一种全新的安全传输机制，使每个函数实例都能安全地反向连接至我们的基础设施。

In other words, we create a tunnel between Vercel and AWS Lambda functions.  
换言之，我们在 Vercel 与 AWS Lambda 函数之间建立一条隧道。

We built a secure TCP-based protocol, with different packet types transmitted from Lambda to our infrastructure.  
我们构建了一种基于 TCP 的安全协议，定义了多种数据包类型，用于从 Lambda 向我们的基础设施发送信息。

For example, to return an HTTP response, we would send one `ResponseStarted`, one or multiple `ResponseBody` packets, and one final `ResponseEnd` packet.  
例如，为返回一个 HTTP 响应，我们会依次发送一个 `ResponseStarted` 包、一个或多个 `ResponseBody` 包，以及一个最终的 `ResponseEnd` 包。

Now, instead of just a single blob, the Vercel Function Router can receive these packets through the tunnel, reconstruct a normal HTTP response, and stream it back to the client chunk-by-chunk.  
如今，Vercel 函数路由器不再仅接收单一的响应数据块（blob），而是可通过该隧道接收这些分段数据包，将其重组为标准 HTTP 响应，并以分块（chunk-by-chunk）方式流式传输回客户端。

![System architecture showing our custom transport layer with TCP tunnels connecting Lambda functions to the Vercel Function Router for streaming responses](images/fluid-compute-how-we-built-serverless-servers-vercel/img_001.jpg)![System architecture showing our custom transport layer with TCP tunnels connecting Lambda functions to the Vercel Function Router for streaming responses](images/fluid-compute-how-we-built-serverless-servers-vercel/img_002.jpg)![System architecture showing our custom transport layer with TCP tunnels connecting Lambda functions to the Vercel Function Router for streaming responses](images/fluid-compute-how-we-built-serverless-servers-vercel/img_003.jpg)![System architecture showing our custom transport layer with TCP tunnels connecting Lambda functions to the Vercel Function Router for streaming responses](images/fluid-compute-how-we-built-serverless-servers-vercel/img_004.jpg)

System architecture showing our custom transport layer with TCP tunnels connecting Lambda functions to the Vercel Function Router for streaming responses  
系统架构图：展示我们自研的传输层——通过 TCP 隧道将 Lambda 函数与 Vercel 函数路由器相连，实现响应流式传输

To handle this communication securely and across runtimes, we built a [Rust-based core](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust) that serves as the glue between our infrastructure and the user code.  
为确保该通信在各类运行时环境中的安全性与兼容性，我们开发了一个基于 [Rust 的核心组件](https://vercel.com/blog/vercel-functions-are-now-faster-and-powered-by-rust)，作为连接我们基础设施与用户代码的桥梁。

It communicates via HTTP to the language process (Node.js or Python), and via our TCP-based protocol to the Vercel Function Router.  
该核心组件通过 HTTP 协议与语言运行进程（如 Node.js 或 Python）通信，同时通过我们自研的 TCP 协议与 Vercel 函数路由器通信。

Each response chunk from the language process gets transformed into its respective packet type and sent back to our infrastructure.  
语言运行进程输出的每一个响应分块，都会被转换为对应的数据包类型，并发回我们的基础设施。

Extending this protocol outside of simple HTTP response packets allowed us to quickly ship features like [`waitUntil`](https://vercel.com/changelog/waituntil-is-now-available-for-vercel-functions), [request metrics](https://vercel.com/changelog/metrics-for-outgoing-requests), [session tracing](https://vercel.com/changelog/session-tracing-now-available), [larger logs](https://vercel.com/changelog/updated-logging-limits-for-vercel-functions), and more.  
将该协议的能力拓展至基础 HTTP 响应包之外，使我们得以快速上线一系列新功能，例如 [`waitUntil`](https://vercel.com/changelog/waituntil-is-now-available-for-vercel-functions)、[出站请求指标（request metrics）](https://vercel.com/changelog/metrics-for-outgoing-requests)、[会话追踪（session tracing）](https://vercel.com/changelog/session-tracing-now-available)、[更长的日志限制（larger logs）](https://vercel.com/changelog/updated-logging-limits-for-vercel-functions) 等等。

Each of those feature is simply a new packet type in our protocol.  
上述每一项功能，本质上都只是我们协议中新增的一种数据包类型。

## A revelation leading to new possibilities

## 一次顿悟，开启全新可能

While building this, we had a thought. This transport allows us to send back any kind of information from a Lambda to our infrastructure, but what if we also send data from our infrastructure to a Lambda?  
在构建该系统的过程中，我们产生了一个想法：当前这套传输机制允许我们将任意类型的信息从 Lambda 发送回我们的基础设施；但如果反过来——由我们的基础设施主动向 Lambda 发送数据呢？

For example, what if we could send an additional HTTP request for a Lambda to process?  
例如，能否向同一个 Lambda 实例再发送一个额外的 HTTP 请求，供其处理？

![Architecture diagram illustrating how the transport layer enables multiplexing multiple concurrent requests to the same Lambda instance, breaking the traditional one-invocation-per-instance model](images/fluid-compute-how-we-built-serverless-servers-vercel/img_005.jpg)![Architecture diagram illustrating how the transport layer enables multiplexing multiple concurrent requests to the same Lambda instance, breaking the traditional one-invocation-per-instance model](images/fluid-compute-how-we-built-serverless-servers-vercel/img_006.jpg)![Architecture diagram illustrating how the transport layer enables multiplexing multiple concurrent requests to the same Lambda instance, breaking the traditional one-invocation-per-instance model](images/fluid-compute-how-we-built-serverless-servers-vercel/img_007.jpg)![Architecture diagram illustrating how the transport layer enables multiplexing multiple concurrent requests to the same Lambda instance, breaking the traditional one-invocation-per-instance model](images/fluid-compute-how-we-built-serverless-servers-vercel/img_008.jpg)

Architecture diagram illustrating how the transport layer enables multiplexing multiple concurrent requests to the same Lambda instance, breaking the traditional one-invocation-per-instance model  
架构示意图：展示该传输层如何支持将多个并发请求复用至同一 Lambda 实例，从而打破传统“一次调用对应一个实例”的模型

This was a great idea, but it ended up being more challenging to implement correctly (and safely) than we initially expected. Let’s walk through what made this idea so attractive.

这个想法非常棒，但实际落地（且安全地）实现起来，比我们最初预想的要困难得多。接下来，让我们梳理一下这一构想为何如此具有吸引力。

AWS Lambda has a strict invocation scaling model:

AWS Lambda 采用严格的调用伸缩模型：

- Each function invocation (an HTTP request for us) is always handled by one instance  
- 每次函数调用（对我们而言即一次 HTTP 请求）始终由一个实例处理  

- One instance always handles one invocation at a time  
- 一个实例在同一时间仅能处理一次调用  

- You pay for each of those functions, regardless of what they're doing  
- 无论函数在执行什么操作，您都需要为每一次调用付费  

As soon as you introduce any I/O (like querying a database, calling an API or an LLM), the function instance is idle most of the time, but you traditionally still have to pay for the full wall time. This became particularly problematic with LLMs taking longer to reason and reply, and for high-traffic sites where most of the function instances are idle.

一旦引入任何 I/O 操作（例如查询数据库、调用 API 或调用大语言模型 LLM），函数实例在大部分时间内都处于空闲状态；但传统计费模式下，您仍需为整个挂钟时间（wall time）付费。当 LLM 推理与响应耗时变长，或网站流量激增导致绝大多数函数实例长期空闲时，这一问题尤为突出。

Reusing an already opened tunnel to send more traffic to idle function instances would allow us to avoid wasting resources, reduce cold starts, and ultimately reduce costs for I/O-bound workloads with any requests concurrency higher than one. With the same resources, we can fit more work while improving performance, and break free from the one-invocation-per-instance model.

复用已建立的隧道，将更多请求路由至空闲的函数实例，可帮助我们避免资源浪费、减少冷启动次数，并最终降低 I/O 密集型工作负载的成本——只要请求并发度大于 1 即可受益。借助相同的基础设施资源，我们不仅能承载更多任务、提升整体性能，还能突破“单实例单调用”的固有模型限制。

## -began) The work (and challenges) began

## ——工作（及挑战）就此展开

In order to send more traffic to a given function, we first have to know which functions are currently running, and where they're running.

为了将更多流量导向某个特定函数，我们首先需要掌握：哪些函数当前正在运行？它们又分别部署在哪些位置？

Each of the 19 Vercel regions has many different replicas of the Vercel Proxy and Vercel Function Router running, and a given Vercel Function could be invoked by any of those pods.

Vercel 全球 19 个区域中，每个区域均运行着大量 Vercel Proxy 和 Vercel Function Router 的副本；而任意一个 Vercel 函数，都有可能被其中任一 Pod 调用。

![Multiple regions each contain distributed Proxy and Function Router replicas, creating a coordination challenge for routing requests to reuse existing connections.](images/fluid-compute-how-we-built-serverless-servers-vercel/img_009.jpg)  
![多个区域各自包含分布式的 Proxy 和 Function Router 副本，为请求路由以复用现有连接带来了协调难题。](images/fluid-compute-how-we-built-serverless-servers-vercel/img_009.jpg)  

![Multiple regions each contain distributed Proxy and Function Router replicas, creating a coordination challenge for routing requests to reuse existing connections.](images/fluid-compute-how-we-built-serverless-servers-vercel/img_010.jpg)  
![多个区域各自包含分布式的 Proxy 和 Function Router 副本，为请求路由以复用现有连接带来了协调难题。](images/fluid-compute-how-we-built-serverless-servers-vercel/img_010.jpg)  

![Multiple regions each contain distributed Proxy and Function Router replicas, creating a coordination challenge for routing requests to reuse existing connections.](images/fluid-compute-how-we-built-serverless-servers-vercel/img_011.jpg)  
![多个区域各自包含分布式的 Proxy 和 Function Router 副本，为请求路由以复用现有连接带来了协调难题。](images/fluid-compute-how-we-built-serverless-servers-vercel/img_011.jpg)  

![Multiple regions each contain distributed Proxy and Function Router replicas, creating a coordination challenge for routing requests to reuse existing connections.](images/fluid-compute-how-we-built-serverless-servers-vercel/img_012.jpg)  
![多个区域各自包含分布式的 Proxy 和 Function Router 副本，为请求路由以复用现有连接带来了协调难题。](images/fluid-compute-how-we-built-serverless-servers-vercel/img_012.jpg)  

Multiple regions each contain distributed Proxy and Function Router replicas, creating a coordination challenge for routing requests to reuse existing connections.  

多个区域各自包含分布式的 Proxy 和 Function Router 副本，为请求路由以复用现有连接带来了协调难题。

This means the larger the region, the more Vercel Function Router pods we have running, and the fewer chances we have of a request coming into a Vercel Function Router pod that has at least one already running request to the same function. To put it differently, at least one already opened TCP connection to the same function that we could reuse to send more work.  

这意味着：区域规模越大，我们运行的 Vercel Function Router Pod 就越多；而一个请求进入某个 Vercel Function Router Pod 时，该 Pod 恰好已存在至少一个针对同一函数的正在运行请求的概率就越低。换言之，即该 Pod 上恰好已存在一条可复用于发送更多任务的、已建立的 TCP 连接。

Our solution was to build a new service called `compute-resolver`, which serves as a DNS-like resolver for Vercel Proxy pods to resolve to a Vercel Function Router pod. It keeps track of where previous requests were routed for a given function ID in order to increase the chances of reusing an already opened TCP connection to send more traffic to a function. It also takes care of not hot-spotting Vercel Function Router pods, which would be catastrophic if a customer gets a sudden spike in traffic on a route.  

我们的解决方案是构建一个名为 `compute-resolver` 的新服务——它充当一种类 DNS 解析器，供 Vercel Proxy Pod 用以解析并定位到合适的 Vercel Function Router Pod。该服务会持续追踪指定函数 ID（function ID）的历史请求被分发到了哪些 Function Router Pod，从而提升复用已有 TCP 连接向该函数发送更多流量的概率。同时，它还负责避免 Vercel Function Router Pod 出现热点（hot-spotting）：若某客户在某条路由上突发大量流量，而所有请求都集中打到单个 Pod 上，将导致灾难性后果。

This service handles >100K RPS at peak and resolves in sub-millisecond at p99.99. On average, more than 99% of requests get routed to a Vercel Function Router pod that may already have a request on the same function ID running, significantly improving the effectiveness of Fluid compute.  

该服务峰值处理能力超过 10 万 RPS（每秒请求数），且在 99.99 分位（p99.99）下解析耗时低于 1 毫秒。平均而言，超过 99% 的请求会被路由至一个可能已运行着同函数 ID 请求的 Vercel Function Router Pod，从而显著提升了 Fluid Compute 的执行效率。

## Keeping functions healthy  

## 保障函数健康运行  

There was one remaining challenge: we also cannot blindly send more traffic to a function instance. It has a fixed amount of vCPUs and RAM, so throwing it too many requests would exhaust its resources and result in increased TTFB, latency, or worse, out of memory (OOMs) errors and crashes. We had to build a system that would know, at any point in time, if a given function instance can currently accept more traffic, which is a hard question to answer. For example:  

还有一个尚未解决的挑战：我们不能盲目地向某个函数实例持续增加流量。每个实例拥有固定的 vCPU 和内存资源，若涌入过多请求，将迅速耗尽其资源，导致首字节时间（TTFB）上升、延迟增加，甚至更严重地引发内存溢出（OOM）错误或进程崩溃。我们必须构建一套系统，使其能在任意时刻准确判断：某一特定函数实例当前是否仍有余力接纳更多流量——而这本身就是一个极难回答的问题。例如：

- What’s the current CPU and memory usage? Is the CPU throttled?  

- 当前 CPU 与内存使用率是多少？CPU 是否已被限频（throttled）？

- Does the instance have enough lifetime remaining to handle more requests?  

- 该实例剩余生命周期是否足以处理更多请求？

- Are we close to the file descriptor limit?  

- 我们是否已接近文件描述符（file descriptor）数量上限？

- Did any previous requests error or time out?  
- 此前的请求是否发生过错误或超时？

The requirements are similar to a typical Kubernetes deployment: you want to use resources efficiently and handle bursty workloads, all without downgrading performance.  
这类需求与典型的 Kubernetes 部署类似：你希望高效利用资源、从容应对突发性工作负载，同时不牺牲性能。

However, not all workloads are equivalent: some will happily use 99% of available memory on purpose, some will slow down during bursts of event loop latency, and you eventually end up manually tweaking your `HorizontalPodAutoscaler` (HPA) configuration for each workload.  
然而，并非所有工作负载都相同：有些会主动占用高达 99% 的可用内存；有些则在事件循环延迟激增时明显变慢；最终，你不得不为每类工作负载手动调整 `HorizontalPodAutoscaler`（HPA）配置。

In comparison, our system adapts automatically to each instance's load profile several times per second, gathering various metrics to maintain an optimal resource-utilization to performance ratio.  
相比之下，我们的系统每秒多次自动适配每个实例的负载特征，持续采集多项指标，以维持资源利用率与性能之间的最优平衡。

Most of these heuristics are implemented in our Rust-based core, which wraps every Vercel Function and continuously sends back metrics in-band to Vercel Function Router.  
上述多数启发式策略均实现在我们基于 Rust 构建的核心中——该核心封装了每一个 Vercel Function，并持续通过带内（in-band）通道将指标回传至 Vercel Function Router。

This allows Vercel Function Router pods to be as optimistic as possible, backing off from sending more traffic to a function instance when one of the metrics crosses a specific threshold.  
这使得 Vercel Function Router 的 Pod 可以尽可能保持“乐观”调度策略：一旦任一指标越过预设阈值，即主动减少向该函数实例发送的新流量。

However, we cannot always trust the metrics state inside Vercel Function Router, which could be incorrect in the case of network latency spikes or other race conditions.  
但 Vercel Function Router 内部的指标状态并非始终可信——在网络延迟骤升或其他竞态条件下，这些指标可能失真。

To address this, the Rust-based core also maintains its own local metrics and can `nack` any additional request, signaling that it cannot currently handle more traffic.  
为此，基于 Rust 的核心还维护着自身的一套本地指标，并可在无法承载更多流量时对任意新增请求返回 `nack`（negative acknowledgment），明确表示当前不可用。

When the Vercel Function Router receives a `nack`, it updates its internal state for that instance, pauses further traffic to it until new healthy metrics are received, and then either forwards the request to another available instance or spins up a new one.  
当 Vercel Function Router 收到 `nack` 后，它会更新该实例的内部状态，暂停向其转发新请求，直至接收到新的健康指标；随后，它将请求转交给其他可用实例，或启动一个全新实例。

![Timeline showing request multiplexing with a nack response when the Lambda instance cannot handle additional traffic](images/fluid-compute-how-we-built-serverless-servers-vercel/img_013.jpg)![Timeline showing request multiplexing with a nack response when the Lambda instance cannot handle additional traffic](images/fluid-compute-how-we-built-serverless-servers-vercel/img_014.jpg)![Timeline showing request multiplexing with a nack response when the Lambda instance cannot handle additional traffic](images/fluid-compute-how-we-built-serverless-servers-vercel/img_015.jpg)![Timeline showing request multiplexing with a nack response when the Lambda instance cannot handle additional traffic](images/fluid-compute-how-we-built-serverless-servers-vercel/img_016.jpg)

Timeline showing request multiplexing with a nack response when the Lambda instance cannot handle additional traffic  
Lambda 实例无法处理额外请求时，请求复用与 `nack` 响应的时间线示意图

For a given request, a Vercel Function Router pod may have many in-flight function instances to choose from, and it will select the one with the most available resources and the fewest concurrent requests.  
对于任一请求，Vercel Function Router 的 Pod 往往拥有多个正在运行的函数实例可供选择；它将优先选取资源余量最大、并发请求数最少的那个实例。

We found this to be far more effective than a classic round-robin algorithm, as not all requests (even if hitting the same route) have the same impact on CPU and memory.  
我们发现，这种策略远比经典的轮询（round-robin）算法更有效——因为并非所有请求（即使访问同一路由）对 CPU 和内存的消耗都相同。

None of these heuristics are specific to Node.js, and are instead designed to be completely language agnostic.  
上述所有启发式策略均不依赖于 Node.js，而是被设计为完全语言无关（language-agnostic）。

Fluid compute also supports Python, with more languages coming soon.  
Fluid Compute 同样支持 Python，更多语言支持即将上线。

## Enabling an even more efficient pricing model  
## 推出更高效的计价模型

Fluid compute made many workloads significantly cheaper and more efficient, but there was still room to improve.  
Fluid Compute 已显著降低并优化了大量工作负载的成本与效率，但仍存在进一步提升空间。

If you had very little to no requests concurrency, your bill wouldn't change at all as we're not able to process those requests together, in the same instance.  
例如，若你的请求并发度极低甚至为零，账单将不会有任何变化——因为我们无法将这些请求合并至同一实例中处理。

Additionally, with the continuous increase in long-running but mostly-idle AI workloads like the Model Context Protocol (MCP), it could still be more expensive than what we wanted to run compute on Vercel.  
此外，随着 Model Context Protocol（MCP）等长时运行但大部分时间处于空闲状态的 AI 工作负载持续增长，当前方案的成本仍高于我们在 Vercel 上运行计算任务的理想预期。

Thanks to this revamped architecture, we were able to introduce [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) for Fluid compute to fill this gap. You're now only paying for the actual resources that you use:

得益于这一重构后的架构，我们推出了面向 Fluid Compute 的 [Active CPU 定价](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)，以填补这一空白。您现在只需为您实际使用的资源付费：

- The active CPU time used by each function instance, measured in milliseconds  
- Each 函数实例所消耗的活跃 CPU 时间，以毫秒为单位计量  

- And the provisioned memory used by each function instance, measured in GB-hrs  
- 以及每个函数实例所配置的内存，以 GB·小时（GB-hrs）为单位计量  

This brings an additional 90%+ savings for heavily I/O-bound workloads, on top of previous Fluid compute savings. This enables Vercel to be the ideal platform to ship any kind of application, from frontends to backends to AI apps.

这在原有 Fluid Compute 节省基础上，进一步为高 I/O 密集型工作负载带来额外 **90% 以上的成本节约**。这也使 Vercel 成为部署各类应用的理想平台——无论是前端、后端，还是 AI 应用。

Today, over 75% of all Vercel Function invocations are using Fluid compute, saving up to 95% on compute bills costs. Compute that uses resources more efficiently, and thanks to our new [Active CPU pricing](https://vercel.com/docs/fluid-compute/pricing), more cost-effectively. Fluid compute is the [default for new projects](https://vercel.com/changelog/fluid-compute-is-now-the-default-for-new-projects), and we recommend [enabling it on your existing projects](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings) if you haven’t already.

目前，**超过 75% 的 Vercel 函数调用**均已采用 Fluid Compute，最高可节省 **95% 的计算费用**。这种计算方式不仅资源利用更高效，而且依托我们全新的 [Active CPU 定价](https://vercel.com/docs/fluid-compute/pricing)，成本效益也更高。Fluid Compute 已成为 [新项目的默认选项](https://vercel.com/changelog/fluid-compute-is-now-the-default-for-new-projects)，若您尚未启用，我们强烈建议您 [在现有项目中开启该功能](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)。
&#123;% endraw %}
