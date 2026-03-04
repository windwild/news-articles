---
title: "Cline now runs on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/cline-on-ai-gateway"
date: "2025-12-16"
scraped_at: "2026-03-02T09:23:54.665966082+00:00"
language: "en-zh"
translated: true
description: "Cline scales its open source coding agent with Vercel AI Gateway, delivering global performance, transparent pricing, and enterprise reliability."
---
&#123;% raw %}

Dec 16, 2025

2025 年 12 月 16 日

Cline, the leading open-source coding agent built for developers and teams, now runs on the Vercel AI Gateway.

Cline 是面向开发者与团队打造的领先开源编程智能体，现已接入 Vercel AI 网关。

With more than 1 million developers and 4 million installations, Cline brings an AI coding partner directly into the development environment, grounded in the values of openness and transparency.

凭借超 100 万开发者用户与 400 万次安装量，Cline 将一位 AI 编程伙伴直接带入开发环境，始终秉持开放与透明的核心价值观。

To support that mission at scale, the team needed infrastructure that matched those principles: fast, reliable, and built on open standards.

为大规模践行这一使命，团队需要一套与之理念一致的基础设施：高速、可靠，并基于开放标准构建。

When you open Cline in your IDE and select its provider, your request doesn’t go straight to an AI model. It first routes through Cline’s infrastructure, and now through the Vercel AI Gateway.

当你在 IDE 中启动 Cline 并选择其提供商时，你的请求并不会直接发送至 AI 模型；而是首先经由 Cline 自身的基础设施路由，如今更进一步通过 Vercel AI 网关进行中转。

![](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_001.jpg)![](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_002.jpg)![](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_003.jpg)![](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_004.jpg)

### Built on Vercel’s global network

### 基于 Vercel 全球网络构建

Vercel AI Gateway itself runs on the same global infrastructure that powers millions of applications and handles trillions of requests on Vercel. Every request first hits one of more than a hundred points of presence around the world, where Vercel’s CDN terminates the TCP connection.

Vercel AI 网关本身即运行于支撑 Vercel 上数百万应用、处理数万亿请求的同一套全球基础设施之上。每个请求首先抵达全球百余个边缘节点（Points of Presence）之一，由 Vercel 的 CDN 在此终止 TCP 连接。

![AI Gateway routes requests from Cline through Vercel’s global delivery network for faster responses and low-latency in-cloud routing.](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_005.jpg)![AI Gateway routes requests from Cline through Vercel’s global delivery network for faster responses and low-latency in-cloud routing.](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_006.jpg)![AI Gateway routes requests from Cline through Vercel’s global delivery network for faster responses and low-latency in-cloud routing.](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_007.jpg)![AI Gateway routes requests from Cline through Vercel’s global delivery network for faster responses and low-latency in-cloud routing.](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_008.jpg)AI Gateway routes requests from Cline through Vercel’s global delivery network for faster responses and low-latency in-cloud routing.

![AI 网关将来自 Cline 的请求经由 Vercel 全球分发网络进行路由，从而实现更快响应与低延迟的云内路由。](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_005.jpg)![AI 网关将来自 Cline 的请求经由 Vercel 全球分发网络进行路由，从而实现更快响应与低延迟的云内路由。](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_006.jpg)![AI 网关将来自 Cline 的请求经由 Vercel 全球分发网络进行路由，从而实现更快响应与低延迟的云内路由。](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_007.jpg)![AI 网关将来自 Cline 的请求经由 Vercel 全球分发网络进行路由，从而实现更快响应与低延迟的云内路由。](images/cline-now-runs-on-vercel-ai-gateway-vercel/img_008.jpg)AI 网关将来自 Cline 的请求经由 Vercel 全球分发网络进行路由，从而实现更快响应与低延迟的云内路由。

The request travels across Vercel’s private, congestion-free backbone to the nearest Vercel region. This ensures that developers anywhere in the world see sub-20ms overhead for interacting with models through Cline.

该请求随后经由 Vercel 私有、无拥塞的骨干网，传输至地理上最近的 Vercel 区域。这确保了全球任意位置的开发者通过 Cline 调用模型时，额外延迟均低于 20 毫秒。

Unlike custom proxies or single-region setups, this system doesn’t rely on a single cloud region or datacenter. Traffic dynamically routes through the healthiest paths available. For in-cloud workloads, most of the path from IDE to inference provider stays within Vercel’s managed network.

与自定义代理或单区域部署不同，该系统不依赖于单一云区域或数据中心。流量会动态地经由当前最健康的路径进行路由。对于云内工作负载，从 IDE 到推理服务提供商的大部分链路都保留在 Vercel 托管网络内部。

This architecture supports lower round-trip times for interactive tools like Cline, especially during long streaming responses where network variance is noticeable.

该架构可降低 Cline 等交互式工具的往返延迟，尤其在长流式响应期间——此时网络波动尤为明显。

To understand how much it would matter in real usage, Cline ran controlled tests against their existing proxy.

为了评估其在真实使用场景中的实际影响，Cline 针对其现有代理开展了受控对比测试。

## A measurable improvement in Cline’s performance

## Cline 性能的可量化提升

Over a week of live A/B testing, splitting production traffic between their previous AI router and Vercel AI Gateway, Cline saw immediate gains in both speed and reliability. These results came from real coding interactions across their global user base.

在为期一周的线上 A/B 测试中，Cline 将生产流量均分至其原有 AI 路由器与 Vercel AI 网关之间，结果立即观察到速度与可靠性的双重提升。这些数据源自其全球用户群体的真实编码交互行为。

### P99 streaming latency improved by 10–14% across Cline’s most-used models

### Cline 最常用模型的 P99 流式延迟降低 10–14%

The slowest 1 percent of requests, also known as P99, represent those moments when an AI agent thinks or pauses mid-stream. Improving this long tail means developers experience fewer stalls, smoother reasoning chains, and more consistent token streaming, especially during complex multi-step tasks.

请求耗时最长的 1%（即 P99）代表 AI 智能体在流式响应中途思考或暂停的时刻。优化这一“长尾”延迟，意味着开发者遭遇卡顿更少、推理链条更流畅、Token 流式输出更稳定——尤其在执行复杂多步骤任务时。

### API error rates dropped by 43.8%

### API 错误率下降 43.8%

For a coding agent, fewer errors translate directly into fewer broken generations and retries. It means the agent “just works” more often, even when running longer workflows.

对编程智能体而言，错误减少直接意味着生成中断和重试次数减少。这意味着该智能体“开箱即用”的成功率更高，即使在运行更长的工作流时亦是如此。

### Notable model-specific improvements:

### 显著的模型级性能提升：

- Grok Code Fast 1 实现了 **P95 延迟降低 9%** 和 **P99 延迟降低 13.7%**，显著提升了典型场景与最差场景下的性能表现。

- Minimax M2 实现了 **P99 延迟降低 14.4%**，同时通过更高效的路由策略带来了切实可观的成本下降。

这些改进并非纸上谈兵，而是切实改变了 Cline 在日常使用中的实际体验。一个编码智能体只有在“最慢时刻”也变得更快时，才会真正让人感觉迅捷——而这正是 Cline 所验证的事实。

Cline 已成为 AI Gateway 榜单上用户主动启用规模最大的应用。自 Cline 将全部流量切换至 AI Gateway 起，它便立即跃居使用量榜首，这清晰地表明：广大开发者已广泛依赖 Cline 支持其日常编码工作流。

[**AI Gateway 榜单**  
\\  
追踪 AI 领域的最新趋势。了解哪些模型与应用正引领流量高峰，以及使用模式随时间如何演变。  
\\  
查看榜单](https://vercel.com/ai-gateway/leaderboards)

## 共同聚焦性能与透明度

Cline 社区期待每一层都保持清晰可溯，包括成本结构。借助 Vercel 的 AI Gateway，开发者只需支付模型提供商针对推理所收取的确切费用：直连请求不加价，自带密钥（BYOK）模式亦不加价。通过 Gateway，模型提供商标示的价格，就是你最终支付的价格——就是如此简单直接。

除价格透明外，Gateway 还为 Cline 提供深度、实时的运维可见性。遥测数据、健康检查及逐请求洞察，助力团队快速诊断问题、持续跟踪系统可靠性，并随用户规模增长科学规划容量。

可预测的经济模型与清晰的可观测性相结合，正呼应了 Cline 自身的技术哲学：构建快速、可理解、且对其行为诚实坦率的系统。

## 迎接开源 AI 的企业级时代

Cline’s shift to AI Gateway is part of a larger trend: open source AI tools maturing into everyday engineering utilities. As more developers rely on these tools for real production work, the underlying infrastructure has to be fast, predictable, and transparent.

Cline 转向 AI Gateway 是更大趋势的一部分：开源 AI 工具正逐步成熟，演变为日常工程实践中的实用工具。随着越来越多开发者将这些工具用于真实的生产环境，其底层基础设施必须具备高速、可预测与高透明度等特性。

The integration gives Cline the consistency it needed with lower latency variance, fewer failures, and clearer pricing without changing its open, extensible model. It improves the experience for individual developers today and supports the needs of teams adopting Cline at larger scale.

此次集成在不改变 Cline 开放、可扩展架构的前提下，为其带来了所需的稳定性——包括更低的延迟波动、更少的故障发生率，以及更清晰透明的定价机制。它不仅提升了当前个体开发者的使用体验，也更好地支撑了大规模采用 Cline 的团队需求。

The story here isn’t about infrastructure for its own sake. It’s about helping an open source tool perform the way developers expect, everywhere they use it.

这里的故事并非单纯聚焦于基础设施本身，而是关于如何助力一款开源工具，在开发者所使用的每一个场景中，都能如其所期地稳定运行。
&#123;% endraw %}
