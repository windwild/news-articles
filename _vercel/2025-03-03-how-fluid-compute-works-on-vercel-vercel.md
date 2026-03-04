---
title: "How Fluid compute works on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-fluid-compute-works-on-vercel"
date: "2025-03-03"
scraped_at: "2026-03-02T09:35:32.487712482+00:00"
language: "en-zh"
translated: true
description: "See how Fluid combines server efficiency and serverless flexibility by reusing compute before creating new resources, reducing cold starts, and running in unconstrained environments while staying secu..."
---
{% raw %}

Mar 3, 2025

2025 年 3 月 3 日

[Fluid compute（流式计算）是 Vercel 的下一代计算模型](https://vercel.com/blog/introducing-fluid-compute)，专为应对现代工作负载而设计，具备实时扩缩容、成本效益高及开销极低等特性。传统无服务器架构虽针对快速执行进行了优化，但在处理需长时间等待外部模型或 API 响应的请求时表现乏力，导致大量计算资源被浪费。

为解决此类低效问题，[Fluid compute（流式计算）](https://vercel.com/fluid) 能够根据实时流量需求动态调整，优先复用现有资源，仅在必要时才分配新资源。Fluid 架构的核心是 Vercel Functions 路由器（Vercel Functions Router），它统一编排函数执行流程，以最大限度减少冷启动、提升并发能力，并优化资源利用率。该路由器会动态将函数调用路由至已预热或正在运行的实例，从而确保低延迟执行。

通过高效管理计算资源分配，该路由器可避免不必要的冷启动，并仅在真正需要时才扩展容量。接下来，我们将深入探讨它是如何智能地管理函数执行的。

## 协调函数执行

Vercel Functions 路由器应用 Fluid 的核心原则来优化执行过程：它基于实时指标（如负载、可用性及请求类型）动态将请求分配至相应实例。

与此同时，Fluid 实例能够并行处理多个请求，显著减少空闲计算周期，保障工作负载的高效分发。这种“智能路由”与“灵活执行”的协同机制，使 Fluid compute 能够响应式地弹性伸缩——既维持低延迟性能，又防止资源过度配置及性能下降。

这一优化依托于一套安全的基础设施设计：所有实例仅通过持久化 TCP 隧道与路由器通信，不直接接收外部流量。实例主动与函数路由器建立双向连接，既可接收传入的调用数据，又能同步回传响应数据流。

该架构模式不仅提升了安全性，还使 Vercel Functions 路由器得以对工作负载分发与扩缩容决策实施精准控制。

![](images/how-fluid-compute-works-on-vercel-vercel/img_001.jpg)![](images/how-fluid-compute-works-on-vercel-vercel/img_002.jpg)![](images/how-fluid-compute-works-on-vercel-vercel/img_003.jpg)![](images/how-fluid-compute-works-on-vercel-vercel/img_004.jpg)

### **Vercel Functions router: Efficient request management**

### **Vercel Functions 路由器：高效的请求管理**

The router optimizes every request in real time—routing efficiently, selecting the best compute, and scaling dynamically with the following process:

路由器实时优化每个请求——高效路由、智能选择最优计算资源，并通过以下流程实现动态扩缩容：

**1\. Routing, security, and caching** The moment a [user presses enter](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-OS1LtjaoEhdWhzd2MOICP), their request is routed to the nearest Vercel Point of Presence (PoP) via Anycast for the lowest possible latency. Before moving forward:

**1. 路由、安全与缓存** 当用户[按下回车键](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter-OS1LtjaoEhdWhzd2MOICP)的瞬间，其请求即通过 Anycast 技术被路由至地理上最近的 Vercel 接入点（Point of Presence, PoP），以实现最低可能的延迟。在请求继续向下流转前：

- The **Vercel Firewall** inspects traffic, blocking threats like DDoS attacks and suspicious patterns  
- **Vercel 防火墙**对流量进行深度检测，拦截 DDoS 攻击及可疑行为等安全威胁  

- If cached at the edge, the response is served instantly  
- 若响应已在边缘节点缓存，则立即返回结果  

- If execution is required, the request moves to the router  
- 若需实际执行，请求将交由路由器进一步处理  

**2\. Compute selection and execution** Vercel Functions router determines the optimal execution region based on proximity, load, and availability. It then selects the best compute instance:

**2. 计算资源选择与执行** Vercel Functions 路由器依据地理位置邻近性、当前负载及可用性，确定最优执行区域，并从中选取最合适的计算实例：

- **In-flight instances (active)** are prioritized for efficiency  
- 优先调度**正在运行中的实例（活跃实例）**，以提升执行效率  

- **Proactively spawned, pre-warmed instances (currently idle)** minimizes cold starts, while [bytecode caching](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions) reduces their start time  
- **主动预启动并预热的空闲实例**可最大限度减少冷启动延迟；同时，[字节码缓存（bytecode caching）](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions) 进一步缩短其实例启动时间  

**3\. Processing and response optimization**  

**3. 请求处理与响应优化**

With an instance assigned, the function begins execution—running logic, querying databases, or calling APIs. If streaming is enabled, responses start flowing immediately as data becomes available, improving Time to First Byte (TTFB).

实例分配完成后，函数即开始执行——运行业务逻辑、查询数据库或调用 API。若启用流式响应（streaming），则数据一旦可用，响应便会立即返回，从而显著缩短首字节时间（Time to First Byte, TTFB）。

**4\. Adaptive scaling and resource efficiency**  
**4. 自适应扩缩容与资源高效利用**

To maintain performance and avoid wasting compute, Fluid continuously:  
为保障性能并避免计算资源浪费，Fluid 持续执行以下操作：

- Monitors traffic patterns, instance health, and workload fluctuations in real time  
- 实时监控流量模式、实例健康状态及工作负载波动  

- Proactively scales new instances during surges  
- 在流量激增时主动扩容新实例  

- Gracefully scales down idle instances to optimize resource use  
- 平滑缩容空闲实例，以优化资源使用  

From keystroke to response, Fluid dynamically optimizes execution, intelligently handling every request with speed and efficiency.  
从用户敲下第一个键到最终响应返回，Fluid 动态优化整个执行流程，以速度与效率智能处理每一个请求。

## **Reducing costs with Fluid**  
## **借助 Fluid 降低成本**

Because Fluid prioritizes existing resources with idle capacity, projects with Fluid enabled have **cut compute costs by up to 85%.**  
由于 Fluid 优先调度具备空闲容量的现有资源，启用 Fluid 的项目**最高可降低 85% 的计算成本**。

Fluid compute is not just about better scaling, it is about smarter resource usage. By dynamically adjusting to traffic and eliminating idle compute time, Fluid compute ensures you only pay for the compute you actually use.  
Fluid 计算能力不仅关乎更优的扩缩容机制，更在于更智能的资源使用方式。通过动态适配流量变化、消除闲置计算时间，Fluid 计算确保您只为实际使用的算力付费。

## **Enable Fluid compute on Vercel today**  
## **今日起，在 Vercel 上启用 Fluid 计算能力**

Enable Fluid compute in [your Project Settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions) today—no migrations needed. Available on all plans.

今天即刻在[您的项目设置](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions)中启用 Fluid 计算——无需任何迁移。所有套餐均支持。

[**Enable Fluid compute today**\\
\\
Fluid is our fast, cost-efficient compute, available today.\\
\\
Enable Now](https://vercel.com/docs/functions/fluid-compute#how-to-enable-fluid-compute)

[**立即启用 Fluid 计算**\\
\\
Fluid 是我们快速、高性价比的计算服务，现已正式上线。\\
\\
立即启用](https://vercel.com/docs/functions/fluid-compute#how-to-enable-fluid-compute)

Once enabled, visit [your Observability tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability) to track function performance and compute savings.

启用后，请访问[您的可观测性（Observability）标签页](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability)，以监控函数性能及计算成本节省情况。

Learn more about Fluid in the [changelog](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute) and [documentation](https://vercel.com/docs/functions/fluid-compute).

更多关于 Fluid 的信息，请参阅[更新日志](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute)和[文档](https://vercel.com/docs/functions/fluid-compute)。
{% endraw %}
