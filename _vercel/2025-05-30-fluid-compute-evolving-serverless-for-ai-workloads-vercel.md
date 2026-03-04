---
render_with_liquid: false
title: "Fluid compute: Evolving serverless for AI workloads - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/fluid-compute-evolving-serverless-for-ai-workloads"
date: "2025-05-30"
scraped_at: "2026-03-02T09:32:55.113078544+00:00"
language: "en-zh"
translated: true
description: "Fluid, our newly announced compute model, eliminates wasted compute by maximizing resource efficiency. Instead of launching a new function for every request, it intelligently reuses available capacity..."
---
render_with_liquid: false
render_with_liquid: false

May 30, 2025

2025 年 5 月 30 日

AI’s rapid evolution is reshaping the tech industry and app development. Traditional serverless computing was designed for quick, stateless web app transactions. LLM interactions require a different sustained compute and continuous execution patterns.

AI 的迅猛演进正在重塑科技行业与应用开发格局。传统无服务器（serverless）计算模型专为快速、无状态的 Web 应用事务而设计；而大语言模型（LLM）交互则需要一种截然不同的、可持续的计算能力与持续执行模式。

This design mismatch presents an opportunity for a new compute model tailored for AI workloads.

这种设计上的错配，恰恰为面向 AI 工作负载量身定制的新一代计算模型创造了契机。

### LLM interactions: A sequence, not a single request

### LLM 交互：一个序列过程，而非单次请求

Engaging with an LLM is more than just sending a request and receiving a response. Unlike traditional web apps, where most requests are processed in milliseconds, LLM workloads involve extended execution times and periods of inactivity.

与 LLM 交互远不止“发送请求—接收响应”这般简单。不同于传统 Web 应用中绝大多数请求可在毫秒级内完成，LLM 工作负载往往耗时更长，且常伴随显著的空闲等待期。

Each interaction follows a multi-step process:

每一次交互均遵循多步骤流程：

- **Serverless function is invoked:** The function initializes and prepares to process the LLM request

- **无服务器函数被调用**：该函数完成初始化，并准备处理 LLM 请求

- **Function sends request to LLM API:** At this stage, the function is actively consuming compute resources

- **函数向 LLM API 发送请求**：此阶段，函数正主动占用并消耗计算资源

- **Function enters idle state waiting for response:** This can take several seconds to minutes, but the function remains running, accumulating billable time despite doing no useful work

- **函数进入空闲状态，等待响应**：这一等待过程可能持续数秒至数分钟；但函数仍保持运行状态，持续计费，却未执行任何有效计算任务

- **LLM completes processing and returns response to function:** The response is received by the waiting function (if still active)

- **LLM 完成处理并将响应返回函数**：响应由处于等待状态的函数（若其仍处于活跃状态）接收

- **Response is streamed back to the client:** If the function timed out during the wait, a new instance must be spun up to handle the response  
- **响应流式返回客户端：** 如果函数在等待过程中超时，则必须启动一个新实例来处理响应

- **Cycle repeats for subsequent requests:** Each new interaction typically spawns a new function instance, even though existing ones may still be available but underutilized  
- **该循环在后续请求中重复发生：** 每次新的交互通常都会触发一个新函数实例的创建，即使已有实例仍处于空闲或未充分利用状态

This sequence reveals how architectural assumptions differ between LLM interactions and traditional serverless:  
这一流程揭示了大语言模型（LLM）交互与传统无服务器架构在设计假设上的根本差异：

- **Transaction timing:** Instead of multi-second LLM processing times, traditional serverless was designed for millisecond responses  
- **事务时序：** 传统无服务器架构面向毫秒级响应而设计，而 LLM 处理往往耗时数秒甚至更长

- **Execution patterns:** Functions were built for single, isolated requests, rather than sequential LLM conversations  
- **执行模式：** 函数被设计用于处理单次、彼此隔离的请求，而非连续的 LLM 对话式交互

- **Resource lifecycle:** The traditional model assumes quick completion over sustained interactions  
- **资源生命周期：** 传统模型假设任务快速完成，而非支持长时间持续交互

- **Scaling model:** Horizontal scaling was optimized for short bursts of activity, not continuous AI workloads  
- **伸缩模型：** 水平扩展针对短时突发性负载进行了优化，而非面向持续运行的 AI 工作负载

Traditional serverless computing excels at its intended use case: quick, stateless web transactions. LLM interactions simply represent a different computational paradigm that requires purpose-built infrastructure.  
传统无服务器计算在其预设场景中表现出色：即快速、无状态的 Web 事务。而 LLM 交互则代表了一种截然不同的计算范式，需要专为该场景构建的基础设施。

## **Fluid compute for AI workloads**  
## **面向 AI 工作负载的弹性计算**

Fluid, [our new compute model](https://vercel.com/blog/introducing-fluid-compute), reduces total compute consumption by utilizing existing resources before scaling new ones. Instead of launching a new function for every request, it intelligently reuses available capacity, ensuring that compute isn’t sitting idle. This means:  
Fluid 是我们推出的全新计算模型（[详见博客介绍](https://vercel.com/blog/introducing-fluid-compute)），它通过优先复用现有资源、再按需扩容的方式，显著降低整体计算资源消耗。它不再为每个请求都启动新函数，而是智能调度可用算力，避免计算资源闲置。这意味着：

- **优先利用现有资源，再创建新资源**：Fluid 首先在单个实例内部进行弹性伸缩（多对一），从而避免冷启动及额外的实例启动开销，降低总体成本。

- **伸缩发生在函数内部，而不仅限于实例之间**：计算资源动态共享，而非盲目启动大量新函数。

- **AI 对话持续流畅且成本高效**：用户获得无中断响应，开发者则显著减少基础设施层面的资源浪费。

A single instance can now process multiple AI inference requests simultaneously, reducing overhead and enabling more efficient scaling. By dynamically reallocating compute where needed, Fluid ensures your AI workloads run at peak performance with every resource actively contributing to processing.

单个实例如今可同时处理多个 AI 推理请求，从而降低系统开销，并实现更高效的弹性伸缩。通过按需动态重新分配算力，Fluid 确保您的 AI 工作负载始终以峰值性能运行——每一单位计算资源均积极参与实际处理任务。

![Fluid compute allows for more efficient compute usage than traditional serverless](images/fluid-compute-evolving-serverless-for-ai-workloads-vercel/img_001.jpg)![Fluid compute allows for more efficient compute usage than traditional serverless](images/fluid-compute-evolving-serverless-for-ai-workloads-vercel/img_002.jpg)![Fluid compute allows for more efficient compute usage than traditional serverless](images/fluid-compute-evolving-serverless-for-ai-workloads-vercel/img_003.jpg)![Fluid compute allows for more efficient compute usage than traditional serverless](images/fluid-compute-evolving-serverless-for-ai-workloads-vercel/img_004.jpg)

Fluid compute allows for more efficient compute usage than traditional serverless

Fluid 计算相比传统无服务器架构，可实现更高效的算力利用。

Additionally, Fluid strategically places resources in regions close to your data, optimizing for both performance and consistency while enabling efficient execution of resource-intensive AI workloads.

此外，Fluid 会战略性地将资源部署在靠近您数据所在的地理区域，兼顾性能与一致性，同时支持资源密集型 AI 工作负载的高效执行。

With Fluid compute, LLM workloads no longer have to choose between scalability and efficiency; they get both. AI apps remain secure and responsive, costs stay predictable, and every function invocation actively contributes to processing, not just waiting **.** Instead of paying for idle compute, Fluid compute ensures every second of function time is fully utilized.

借助 Fluid 计算，大语言模型（LLM）工作负载无需再在“可扩展性”与“效率”之间取舍——二者兼得。AI 应用保持安全与高响应性，成本可预测；每一次函数调用均切实参与处理任务，而非空转等待 **。** Fluid 计算杜绝为闲置算力付费，确保函数运行的每一秒都被充分利用。

[**See how Fluid compute works on Vercel**\\  
\\  
Fluid compute boosts serverless performance by reusing idle compute during LLM calls, keeping functions active and scaling dynamically.\\  
\\  
Learn more](https://vercel.com/blog/how-fluid-compute-works-on-vercel)

[**查看 Fluid 计算在 Vercel 上的工作原理**\\  
\\  
Fluid 计算通过在 LLM 调用期间复用闲置算力，提升无服务器性能，使函数持续活跃并实现动态伸缩。\\  
\\  
了解更多](https://vercel.com/blog/how-fluid-compute-works-on-vercel)

## Secure by default

## 默认安全

Beyond optimization, Fluid compute is built on a foundation of security and reliability for the demands of modern AI workloads.

在优化之外，Fluid Compute 以安全性和可靠性为基石，专为现代 AI 工作负载的严苛需求而构建。

- **Edge security with Vercel Firewall**: Requests are routed to the nearest Vercel Point of Presence (PoP) and inspected by the Vercel Firewall before reaching the [Vercel Functions router](https://vercel.com/blog/how-fluid-compute-works-on-vercel). This [Layer 7 protection](https://vercel.com/security/web-application-firewall) blocks most application-level threats, including DoS attacks, and filters suspicious traffic, ensuring that only legitimate requests reach your apps

- **基于 Vercel 防火墙的边缘安全**：请求首先被路由至最近的 Vercel 接入点（Point of Presence, PoP），并在抵达 [Vercel Functions 路由器](https://vercel.com/blog/how-fluid-compute-works-on-vercel) 前，由 Vercel 防火墙进行检查。该 [第七层防护](https://vercel.com/security/web-application-firewall) 可拦截绝大多数应用层威胁（包括 DDoS 攻击），并过滤可疑流量，确保仅合法请求可到达您的应用。

- **Secure instance architecture**: Fluid compute instances are never directly exposed to the internet. Instead, they connect to the Vercel Functions router through secure, persistent TCP tunnels. All communication, including function invocations and responses, flows through this controlled channel, ensuring strong isolation and precise workload management

- **安全的实例架构**：Fluid Compute 实例从不直接暴露于互联网。相反，它们通过安全、持久的 TCP 隧道连接至 Vercel Functions 路由器。所有通信（包括函数调用与响应）均经由此受控通道传输，从而保障强隔离性与精准的工作负载管理。

- **Enhanced reliability and availability**: Fluid automatically fails over across multiple availability zones within a region. For Enterprise customers, [Fluid also has multi-region failover capabilities](https://vercel.com/fluid). These safeguards help ensure uptime and keep your apps resilient in the face of localized disruptions

- **增强的可靠性与可用性**：Fluid 可在单个区域内的多个可用区（Availability Zones）间自动故障转移。对于企业客户，[Fluid 还支持跨区域故障转移能力](https://vercel.com/fluid)。这些保护机制有助于保障服务正常运行时间，并使您的应用在遭遇局部中断时仍保持韧性。

This layered security model ensures that Fluid delivers performance and efficiency without compromising the protection required for sensitive AI workloads.

这一分层安全模型确保 Fluid 在提供卓越性能与效率的同时，绝不牺牲敏感 AI 工作负载所必需的安全防护。

## **Start building with AI**

## **立即使用 AI 开始构建**

AI workloads require more than just scale. They require efficiency and security **.** Fluid compute ensures full resource utilization, ultimately reducing costs while delivering secure, high-performance execution.

AI 工作负载所需远不止规模扩展——更需效率与安全。Fluid Compute 实现资源的充分利用，在保障安全、高性能执行的同时，最终降低计算成本。

It’s the infrastructure AI teams have been looking for: fast, adaptive, and built to support real-time inference and background tasks. [Fluid compute is now the default for new projects](https://vercel.com/changelog/fluid-compute-is-now-the-default-for-new-projects), and can be [enabled for existing projects](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings).

这正是 AI 团队一直在寻找的基础设施：快速、自适应，专为实时推理与后台任务而设计。[Fluid Compute 现已成为新项目的默认选项](https://vercel.com/changelog/fluid-compute-is-now-the-default-for-new-projects)，您也可[为现有项目启用该功能](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)。

[**Deploy an AI-powered app with Fluid compute today**\\
\\
Optimize your AI applications with Fluid compute and maximize your compute. \\
\\
Get started](https://vercel.com/templates/ai)

[**今日即用 Fluid Compute 部署 AI 应用**\\
\\
借助 Fluid Compute 优化您的 AI 应用，充分释放计算潜力。\\
\\
立即开始](https://vercel.com/templates/ai)