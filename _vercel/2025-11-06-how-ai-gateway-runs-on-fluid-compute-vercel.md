---
render_with_liquid: false
title: "How AI Gateway runs on Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-ai-gateway-runs-on-fluid-compute"
date: "2025-11-06"
scraped_at: "2026-03-02T09:26:02.318443799+00:00"
language: "en-zh"
translated: true
description: "The AI Gateway is a simple application deployed on Vercel, but it achieves scale, efficiency, and resilience by running on Fluid compute and leveraging Vercel’s global infrastructure."
---
render_with_liquid: false
render_with_liquid: false

Nov 6, 2025

2025 年 11 月 6 日

AI Gateway is a Node.js service for connecting to hundreds of AI models through a single interface. It processes billions of tokens per day. The secret behind that scale is Fluid.

AI Gateway 是一款基于 Node.js 的服务，可通过单一接口连接数百种 AI 模型。它每日处理数十亿个 token。支撑如此大规模运行的关键技术，正是 Fluid。

![](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_001.jpg)![](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_002.jpg)![](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_003.jpg)![](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_004.jpg)

When we [announced its general availability](https://vercel.com/blog/ai-gateway-is-now-generally-available), we highlighted how AI Gateway scales efficiently, routes requests securely, and simplifies connecting to multiple AI providers.

当我们[宣布 AI Gateway 正式发布（General Availability）](https://vercel.com/blog/ai-gateway-is-now-generally-available)时，我们重点介绍了它如何高效地实现弹性伸缩、安全地路由请求，以及简化对接多家 AI 服务商的过程。

We looked at data from the first month of availability. AI Gateway handled roughly 16,000 total runtime hours, but only 1,200 of those hours involved actual CPU work (processing requests, routing logic, streaming responses). The remaining 14,800 hours were spent waiting for AI providers to respond.

我们分析了正式发布首月的运行数据：AI Gateway 总共运行约 16,000 小时，但其中仅约 1,200 小时用于实际 CPU 计算（如处理请求、执行路由逻辑、流式返回响应），其余 14,800 小时均处于等待 AI 服务商响应的状态。

Traditional serverless platforms bill you for wall clock time. Every millisecond your function is alive, you pay. With Fluid and Active CPU Pricing, you only pay CPU rates when the CPU is actually running. The rest of the time (when AI Gateway is waiting on OpenAI or Anthropic) you pay a lower memory-only rate. For AI Gateway, that means paying CPU rates for less than 8% of runtime instead of 100%.

传统无服务器平台按“挂钟时间”（wall clock time）计费——函数每存活一毫秒，您就要付费。而借助 Fluid 及其“活跃 CPU 计费”（Active CPU Pricing）机制，您仅在 CPU 实际执行计算时才需支付 CPU 费用；其余时间（例如 AI Gateway 正在等待 OpenAI 或 Anthropic 响应时），则仅按更低的纯内存占用费率计费。对 AI Gateway 而言，这意味着 CPU 计费时间不足总运行时间的 8%，而非传统模式下的 100%。

By pairing AI Gateway's model abstraction with Fluid's fast, cost-efficient infrastructure, Vercel removes the hardest parts of building AI features. Teams ship faster without worrying about provider plumbing or underlying compute.

通过将 AI Gateway 的模型抽象能力与 Fluid 快速、高性价比的基础设施相结合，Vercel 消除了构建 AI 功能中最困难的部分。团队得以更快交付产品，无需操心 AI 服务商的对接细节或底层计算资源的运维。

## How we build Vercel with Vercel

## 我们如何用 Vercel 构建 Vercel

At a high level, AI Gateway is a Node.js app deployed on Vercel using Next.js, though you could build something similar with any backend framework that serves REST APIs.

从宏观角度看，AI Gateway 是一款基于 Next.js 部署在 Vercel 上的 Node.js 应用；当然，您也可使用任何支持提供 REST API 的后端框架来构建类似服务。

Despite this straightforward architecture, AI Gateway handles traffic at global scale with extremely low latency. The application runs across the Vercel distributed infrastructure in multiple AWS regions, using the same premium networking, global regions, and compute model available to every Vercel customer.

尽管架构简洁明了，AI Gateway 却能以极低延迟承载全球规模的流量。该应用运行于 Vercel 分布式基础设施之上，部署在多个 AWS 区域中，并采用与所有 Vercel 客户共享的高性能网络、全球区域节点及统一计算模型。

When a user connects to AI Gateway from outside Vercel, their requests take an accelerated path into our network. For users deploying within AWS, the connection is already local, giving them consistently low latency through in-cloud routing.

当用户从 Vercel 外部连接到 AI Gateway 时，其请求将通过一条加速路径进入我们的网络。对于在 AWS 内部署的用户，连接本身已是本地化，因此可通过云内路由持续获得低延迟体验。

Within the product, AI Gateway is just a standard Vercel project without any special infrastructure or privileged access. The application uses the same framework-defined infrastructure, zero-config deployment, observability, and security available to you.

在产品层面，AI Gateway 仅是一个标准的 Vercel 项目，无需特殊基础设施，也不具备特权访问权限。该应用所使用的基础设施、零配置部署能力、可观测性及安全性，均与您日常使用的框架定义能力完全一致。

## Under the hood: Global delivery network

## 底层原理：全球交付网络

When a request enters AI Gateway, the request is first received by the Vercel global delivery network, a globally distributed system that combines Anycast routing, Points of Presence (PoPs), and private backbone connectivity to minimize latency.

当请求进入 AI Gateway 时，首先由 Vercel 全球交付网络接收——这是一个全球分布式系统，融合了任播（Anycast）路由、边缘接入点（Points of Presence, PoPs）以及私有骨干网连接，以最大限度降低延迟。

The network continuously evaluates the health and congestion of each endpoint, routing requests to the optimal PoP based on proximity and live performance telemetry. From there, traffic is handed off to the nearest compute-capable region, where the request runs within the same global infrastructure that powers every Vercel deployment.

该网络持续评估各端点的健康状态与拥塞情况，并基于地理位置邻近性及实时性能遥测数据，将请求智能调度至最优边缘接入点（PoP）。随后，流量被转交至最近的支持计算能力的区域，在该区域内，请求将在支撑所有 Vercel 部署的同一套全球基础设施中执行。

![AI Gateway routes requests across Vercel’s global delivery network for faster responses and low-latency in-cloud routing.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_005.jpg)![AI Gateway routes requests across Vercel’s global delivery network for faster responses and low-latency in-cloud routing.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_006.jpg)![AI Gateway routes requests across Vercel’s global delivery network for faster responses and low-latency in-cloud routing.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_007.jpg)![AI Gateway routes requests across Vercel’s global delivery network for faster responses and low-latency in-cloud routing.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_008.jpg)AI Gateway routes requests across Vercel’s global delivery network for faster responses and low-latency in-cloud routing.

![AI Gateway 通过 Vercel 全球交付网络路由请求，以实现更快响应和低延迟的云内路由。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_005.jpg)![AI Gateway 通过 Vercel 全球交付网络路由请求，以实现更快响应和低延迟的云内路由。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_006.jpg)![AI Gateway 通过 Vercel 全球交付网络路由请求，以实现更快响应和低延迟的云内路由。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_007.jpg)![AI Gateway 通过 Vercel 全球交付网络路由请求，以实现更快响应和低延迟的云内路由。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_008.jpg)AI Gateway 通过 Vercel 全球交付网络路由请求，以实现更快响应和低延迟的云内路由。

The delivery network ensures high-throughput, low-latency movement of data between users, network region locations, and AI providers. Each hop, from client ingress to provider response, remains within Vercel managed boundaries, avoiding unpredictable public internet routes.

该交付网络确保用户、网络区域位置与 AI 服务提供商之间数据传输的高吞吐量与低延迟。从客户端请求接入到 AI 提供商返回响应的每一跳（hop），均严格限定在 Vercel 托管边界之内，从而规避不可预测的公共互联网路径。

This architecture delivers consistent performance globally, keeping round-trip times to single-digit milliseconds for most customers while maintaining full visibility through edge request metrics.

该架构可在全球范围内提供一致的性能表现，使大多数客户的往返延迟稳定保持在个位数毫秒级别，同时依托边缘请求指标实现全程可观测性。

Once routed, the request reaches AI Gateway's application layer and executes within a Vercel Function running on Fluid compute. The function authenticates using OIDC tokens for Vercel-hosted apps or API keys for external integrations. The function verifies quotas through in-region Redis and prepares the payload for the target AI provider. After forwarding the request, the function streams responses back through the same low-latency network path.

完成路由后，请求抵达 AI Gateway 的应用层，并在基于 Fluid Compute 运行的 Vercel Function 中执行。该函数针对托管于 Vercel 的应用使用 OIDC Token 进行身份验证，针对外部集成则使用 API Key；通过区域内的 Redis 实例校验配额，并为指定 AI 服务提供商准备请求载荷；在转发请求后，再经由同一条低延迟网络路径将响应流式回传。

```javascript
import { generateText } from 'ai';
```

```javascript
const { text } = await generateText({

4  model: 'anthropic/claude-sonnet-4',

5  prompt: 'Explain how request routing works',

6});
```

```javascript
const { text } = await generateText({

4  model: 'anthropic/claude-sonnet-4',

5  prompt: '解释请求路由的工作原理',

6});
```

Example using AI Gateway with the AI SDK

使用 AI SDK 与 AI Gateway 的示例

## Under the hood: Powered by Fluid compute

## 底层原理：由 Fluid 计算驱动

AI Gateway 运行在 Fluid 计算平台之上——这是我们专为高并发、网络密集型工作负载打造的下一代运行时。Fluid 的行为类似于一个动态的、生命周期极短的服务器：它既保留了无服务器（serverless）架构所具备的弹性与部署模型，又能在多次调用之间复用底层云资源，从而实现类似传统服务器的高效性。

AI Gateway 运行在 Fluid 计算平台之上——这是我们专为高并发、网络密集型工作负载打造的下一代运行时。Fluid 的行为类似于一个动态的、生命周期极短的服务器：它既保留了无服务器（serverless）架构所具备的弹性与部署模型，又能在多次调用之间复用底层云资源，从而实现类似传统服务器的高效性。

Traditional serverless models require a separate instance for every invocation. Even if pre-warmed, each traditional serverless instance starts with no memory or state.

传统的无服务器模型要求每次调用都启动一个独立实例。即使经过预热，每个传统无服务器实例在启动时仍不携带任何内存或状态。

Fluid changes this by not just reusing instances across invocations when they're done running, but while they're running as well, through [in-function concurrency](https://vercel.com/blog/serverless-servers-node-js-with-in-function-concurrency). This allows in-memory data, open sockets, and runtime caches to persist throughout an instance's lifecycle. When one invocation pauses to wait for a provider's response, another can execute immediately within the same instance.

Fluid 彻底改变了这一范式：它不仅在实例执行完毕后跨调用复用实例，更进一步支持**函数内并发**（[in-function concurrency](https://vercel.com/blog/serverless-servers-node-js-with-in-function-concurrency)）——即在实例仍在运行过程中就接纳新的调用。这使得内存中的数据、已打开的套接字（sockets）以及运行时缓存均可在整个实例生命周期中持续存在。当某次调用因等待上游服务响应而暂停时，另一次调用可立即在同一实例内执行。

This concurrency model keeps CPU utilization high and costs low. With Active CPU Pricing, you only pay for the milliseconds when your code is actively running.

这种并发模型可保持高 CPU 利用率，同时降低成本。借助“活跃 CPU 计费”（Active CPU Pricing），您仅需为代码实际运行的毫秒数付费。

![AI Gateway requests run on Fluid compute, combining the scalability of serverless with the concurrency of a server to reduce network overhead across invocations.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_009.jpg)![AI Gateway requests run on Fluid compute, combining the scalability of serverless with the concurrency of a server to reduce network overhead across invocations.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_010.jpg)![AI Gateway requests run on Fluid compute, combining the scalability of serverless with the concurrency of a server to reduce network overhead across invocations.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_011.jpg)![AI Gateway requests run on Fluid compute, combining the scalability of serverless with the concurrency of a server to reduce network overhead across invocations.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_012.jpg)AI Gateway requests run on Fluid compute, combining the scalability of serverless with the concurrency of a server to reduce network overhead across invocations.

![AI Gateway 请求在 Fluid 计算平台上运行，融合了无服务器架构的弹性扩展能力与传统服务器的高并发处理能力，从而降低各次调用间的网络开销。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_009.jpg)![AI Gateway 请求在 Fluid 计算平台上运行，融合了无服务器架构的弹性扩展能力与传统服务器的高并发处理能力，从而降低各次调用间的网络开销。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_010.jpg)![AI Gateway 请求在 Fluid 计算平台上运行，融合了无服务器架构的弹性扩展能力与传统服务器的高并发处理能力，从而降低各次调用间的网络开销。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_011.jpg)![AI Gateway 请求在 Fluid 计算平台上运行，融合了无服务器架构的弹性扩展能力与传统服务器的高并发处理能力，从而降低各次调用间的网络开销。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_012.jpg)AI Gateway 请求在 Fluid 计算平台上运行，融合了无服务器架构的弹性扩展能力与传统服务器的高并发处理能力，从而降低各次调用间的网络开销。

Because Fluid instances are reused, these instances can store small, short-lived caches of frequently accessed data such as provider routes, credentials, or quota snapshots directly in memory. This reduces redundant Redis lookups and minimizes latency on the hot path. When traffic spikes, Fluid scales instantly. When traffic quiets down, instances retire gracefully. Infrastructure stays elastic like serverless but performs like a tuned, [always-warm server.](https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts)

由于 Fluid 实例会被复用，这些实例可直接在内存中缓存少量、生命周期较短的高频访问数据（例如供应商路由、凭据或配额快照）。此举减少了冗余的 Redis 查询，在关键路径上显著降低了延迟。当流量激增时，Fluid 可瞬时扩容；当流量回落时，实例则优雅退出。基础设施既保有无服务器架构般的弹性伸缩能力，又具备经过调优的、[始终处于预热状态的服务器](https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts)般的性能表现。

## State, caching, and global coordination

## 状态管理、缓存与全局协调

AI Gateway uses Redis, configured via the Vercel Marketplace, for global consistency and quota tracking, paired with Fluid for ephemeral in-memory caching for local speed. Frequently accessed credentials, provider metadata, and quota counters are stored in instance memory for sub-millisecond access.

AI Gateway 使用通过 Vercel Marketplace 配置的 Redis 实现全局一致性与配额追踪，同时结合 Fluid 提供短暂的内存内缓存以提升本地响应速度。高频访问的凭据、供应商元数据及配额计数器均驻留在实例内存中，实现亚毫秒级访问。

We refresh values in Redis asynchronously in the background, minimizing impact to live traffic. Writes and usage increments are batched and written back to Redis after responses complete.

我们通过后台异步方式刷新 Redis 中的值，最大限度降低对实时流量的影响。写入操作与用量递增操作均被批量处理，并在响应完成后再统一回写至 Redis。

Each Vercel region maintains its own Redis cluster to keep quota verification and usage updates local. That regional isolation keeps latency predictable even at global scale.

每个 Vercel 区域均维护独立的 Redis 集群，确保配额校验与用量更新均在本地完成。这种区域隔离机制即使在全局规模下也能保障延迟的可预测性。

## Monitoring from the inside out

## 由内而外的监控体系

Each Fluid instance continuously feeds the AI Gateway monitoring service with live metrics from two complementary systems: frequent health checks and in-memory statistics.

每个 Fluid 实例持续向 AI Gateway 监控服务推送来自两个互补系统的实时指标：高频健康检查与内存内统计信息。

Health checks continuously measure core metrics like error rates, time to first token (TTFT), and throughput in tokens per second. In parallel, every Fluid instance maintains its own set of real-time counters tracking active invocations, memory utilization, and provider latency. These two sources create a self-correcting feedback loop. The monitoring system compares in-memory telemetry against global health checks and uses that data to adjust routing, scale instances, or shift traffic between regions automatically.

健康检查持续采集核心指标，例如错误率、首 Token 延迟（TTFT）以及每秒 Token 吞吐量。与此同时，每个 Fluid 实例各自维护一组实时计数器，用于追踪活跃调用数、内存使用率及供应商延迟。这两类数据源共同构成一个自校正的反馈闭环：监控系统将内存内遥测数据与全局健康检查结果进行比对，并基于该比对结果自动调整路由策略、扩缩容实例，或在不同区域之间调度流量。

![Continuous checks are performed by both in-memory services and a global system, relaying feedback of provider and model performance to the entire network.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_013.jpg)  
![连续检查由内存内服务和全局系统共同执行，将供应商及模型性能的反馈实时传递至整个网络。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_013.jpg)

![Continuous checks are performed by both in-memory services and a global system, relaying feedback of provider and model performance to the entire network.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_014.jpg)  
![连续检查由内存内服务和全局系统共同执行，将供应商及模型性能的反馈实时传递至整个网络。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_014.jpg)

![Continuous checks are performed by both in-memory services and a global system, relaying feedback of provider and model performance to the entire network.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_015.jpg)  
![连续检查由内存内服务和全局系统共同执行，将供应商及模型性能的反馈实时传递至整个网络。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_015.jpg)

![Continuous checks are performed by both in-memory services and a global system, relaying feedback of provider and model performance to the entire network.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_016.jpg)  
![连续检查由内存内服务和全局系统共同执行，将供应商及模型性能的反馈实时传递至整个网络。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_016.jpg)

Continuous checks are performed by both in-memory services and a global system, relaying feedback of provider and model performance to the entire network.  

连续检查由内存内服务和全局系统共同执行，将供应商及模型性能的反馈实时传递至整个网络。

If one provider region starts returning slower responses, AI Gateway reroutes new requests to a healthier provider without human intervention or application changes. This system ensures reliability and resilience even as underlying model APIs fluctuate.  

若某一供应商区域开始返回响应变慢，AI Gateway 将自动将新请求重定向至更健康的供应商，全程无需人工干预或修改应用程序。该机制确保了系统在底层模型 API 性能波动时仍具备高可靠性与强韧性。

AI Gateway can route requests across multiple providers for the same model, and now, even fall back to other models in the event of an error, context size mismatch, or other incompatibility issue.  

AI Gateway 可针对同一模型，将请求路由至多个供应商；如今更支持在发生错误、上下文长度不匹配或其他兼容性问题时，自动降级（fallback）至其他模型。

For example, Claude Sonnet 4 is available through Anthropic, Amazon Bedrock, and Google Vertex AI. You can control which providers are used and in what order:  

例如，Claude Sonnet 4 可通过 Anthropic、Amazon Bedrock 和 Google Vertex AI 获取。您可以自主指定所用供应商及其优先级顺序：

```javascript
import { streamText } from 'ai';



const result = streamText({

4  model: 'anthropic/claude-sonnet-4',

5  prompt: 'Write a technical explanation',

6  providerOptions: {
```

```
7    gateway: {

8      order: ['vertex', 'bedrock', 'anthropic'],

9    },

10  },

11});
```

```
7    gateway: {

8      order: ['vertex', 'bedrock', 'anthropic'],

9    },

10  },

11});
```

If the primary provider is unavailable, AI Gateway automatically retries with the next one. Every response includes detailed metadata describing which provider served the request, any fallback attempts, latency, and total token cost. This fallback system improves reliability without requiring any changes to your application code.

如果主服务提供商不可用，AI 网关将自动尝试下一个提供商。每个响应均包含详细的元数据，说明由哪个提供商处理了该请求、是否发生过回退重试、延迟时间以及总 Token 消耗成本。这一回退机制可在无需修改应用程序代码的前提下，显著提升系统可靠性。

Vercel provides native visibility into AI Gateway activity through Vercel Observability, giving developers detailed metrics on latency, provider health, token counts, and costs in real time.

Vercel 通过 Vercel Observability 为 AI 网关活动提供原生可观测性，使开发者能够实时获取延迟、服务商健康状态、Token 使用量及费用等详细指标。

![Vercel Observability provides native visibility into every model call, including overall request volume, spend, and performance.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_017.jpg)![Vercel Observability provides native visibility into every model call, including overall request volume, spend, and performance.](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_018.jpg)Vercel Observability provides native visibility into every model call, including overall request volume, spend, and performance.

![Vercel Observability 提供对每次模型调用的原生可观测性，涵盖总体请求量、费用支出与性能表现。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_017.jpg)![Vercel Observability 提供对每次模型调用的原生可观测性，涵盖总体请求量、费用支出与性能表现。](images/how-ai-gateway-runs-on-fluid-compute-vercel/img_018.jpg)Vercel Observability 提供对每次模型调用的原生可观测性，涵盖总体请求量、费用支出与性能表现。

## Why Fluid compute is the right fit

## 为何流式计算（Fluid Compute）是理想选择

AI Gateway spends most of its time waiting, not computing. Routing requests, verifying credentials, and checking quotas takes milliseconds. Waiting for OpenAI or Anthropic to stream back a response takes seconds. This is a network-bound workload, not a compute-intensive one.

AI 网关大部分时间处于等待状态，而非执行计算任务。路由请求、验证凭据、检查配额等操作仅需数毫秒；而等待 OpenAI 或 Anthropic 流式返回响应则需数秒。这本质上是一种受网络延迟制约的工作负载，而非计算密集型任务。

Active CPU Pricing matches the actual work pattern. During those seconds of waiting, you pay only for memory provisioning, not full CPU rates. For workloads like AI Gateway, where most time is spent waiting on network responses, this pricing model eliminates unnecessary costs.

按需 CPU 定价模式精准匹配实际工作负载模式。在那些等待的秒级时间内，您仅需为内存配置付费，而无需承担全量 CPU 费用。对于 AI Gateway 这类大部分时间都在等待网络响应的工作负载而言，该定价模型可有效消除不必要的开支。

## Building with Vercel

## 借助 Vercel 构建

By using Fluid’s concurrency model and Vercel’s distributed network, AI Gateway demonstrates what modern infrastructure looks like when serverless evolves beyond simple functions. It's still instant and elastic, but now intelligent, efficient, and self-optimizing. The same architecture that powers AI Gateway is available to every developer building the next generation of AI-powered applications on Vercel.

通过结合 Fluid 的并发模型与 Vercel 的分布式网络，AI Gateway 展现了无服务器架构在超越简单函数之后的现代基础设施形态：它依然具备即时响应与弹性伸缩能力，同时更进一步实现了智能化、高效率与自优化。驱动 AI Gateway 的同一套架构，现已向所有在 Vercel 上构建下一代 AI 应用的开发者开放。