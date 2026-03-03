---
title: "AI Gateway: Production-ready reliability for your AI apps - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-gateway-is-now-generally-available"
date: "2025-08-21"
scraped_at: "2026-03-02T09:29:51.583492371+00:00"
language: "en-zh"
translated: true
description: "AI Gateway, now generally available, ensures availability when a provider fails, avoiding low rate limits and providing consistent reliability for AI workloads."
---

Aug 21, 2025

2025 年 8 月 21 日

Building an AI app can now take just minutes. With developer tools like the [AI SDK](https://ai-sdk.dev/), teams can build both AI frontends and backends that accept prompts and context, reason with an LLM, call actions, and stream back results.

构建一个 AI 应用现在仅需数分钟。借助 [AI SDK](https://ai-sdk.dev/) 等开发者工具，团队可快速搭建支持接收提示词（prompt）与上下文、调用大语言模型（LLM）进行推理、执行操作（actions），并流式返回结果的 AI 前端与后端。

But going to production requires reliability and stability at scale. Teams that connect directly to a single LLM provider for inference create a fragile dependency: if that provider goes down or hits rate limits, so does the app. As AI workloads become mission-critical, the focus shifts from integration to reliability and consistent model access. Fortunately, there's a better way to run.

但迈向生产环境，需要的是大规模下的可靠性与稳定性。若团队直接对接单一 LLM 服务商进行推理，则会形成一种脆弱依赖：一旦该服务商宕机或触发速率限制，整个应用也将随之中断。随着 AI 工作负载日益成为核心业务，关注重点正从“能否集成”转向“是否可靠”与“能否持续稳定访问模型”。幸运的是，我们已有更优的运行方式。

[AI Gateway](https://vercel.com/ai-gateway), now generally available, ensures availability when a provider fails, avoiding low rate limits and providing consistent reliability for AI workloads. It's the same system that has powered [v0.app](https://v0.app/) for millions of users, now battle-tested, stable, and ready for production for our customers.

[AI Gateway](https://vercel.com/ai-gateway) 现已全面开放（Generally Available），可在任一服务商故障时保障服务可用性，规避严苛的速率限制，并为 AI 工作负载提供始终如一的可靠性。它正是支撑 [v0.app](https://v0.app/) 服务数百万用户的同一套系统——历经实战检验、稳定可靠，现已全面就绪，可供客户投入生产环境使用。

## The case for flexibility

## 灵活性的必要性

AI capabilities have grown and changed with incredible speed. Reasoning, barely a concept a year ago, is now a standard capability across models. Tool use and the Model Context Protocol (MCP) went from experiments to widely adopted standards in under a year.

AI 能力正以惊人的速度演进与迭代：一年前尚属概念雏形的“推理能力”（reasoning），如今已成为各主流模型的标准功能；工具调用（tool use）与模型上下文协议（Model Context Protocol, MCP）也在不到一年内，从实验性探索迅速发展为被广泛采纳的行业标准。

An essential tool for success in AI is staying flexible and adapting to the new frontier. Whether AI native or leveraging AI integrations, teams want the ability to use the best model available at any given time while keeping systems composable and avoiding lock-in.

在 AI 领域取得成功的关键工具之一，便是保持灵活性，主动适应前沿变化。无论团队原生构建 AI 应用，还是通过集成方式引入 AI 能力，其共同诉求都是：在任意时刻都能选用当下最优的模型，同时确保系统具备良好的可组合性（composability），并避免厂商锁定（vendor lock-in）。

Building in the flexibility to switch between models requires sophisticated engineering. APIs can fail without warning, rate limits vary by provider, and keys must be managed and secured per vendor. Even tracking spend means juggling multiple dashboards with different top-up programs and spend controls. Engineering around these failure modes is time-consuming and slows teams down.

为实现模型间的灵活切换，需投入复杂的工程实践：API 可能毫无征兆地失效，各服务商的速率限制千差万别，密钥需按供应商分别管理与安全加固；甚至连成本追踪也意味着需在多个控制台间来回切换——每个平台拥有不同的充值机制与支出管控策略。围绕这些故障模式开展工程设计，既耗时费力，又严重拖慢团队交付节奏。

AI Gateway handles this complexity for you so you can scale confidently and quickly.

AI Gateway 为您接管这一系列复杂性，助您自信而高效地实现规模化扩展。

## Great developer experience, trusted infrastructure

## 卓越的开发者体验，值得信赖的基础设施

The AI SDK now sees more than 2 million downloads per week and powers apps like Browserbase and Perplexity. While AI SDK standardized provider APIs and made switching as simple as a single line of code, the harder problem is ensuring availability when a provider fails. The AI Gateway brings the same developer experience together with globally available, production-grade infrastructure.

AI SDK 目前每周下载量已超过 200 万次，为 Browserbase 和 Perplexity 等应用提供支持。尽管 AI SDK 统一了各供应商的 API 接口，使切换供应商仅需一行代码即可完成，但更棘手的问题在于：当某供应商服务中断时，如何保障服务的持续可用性。AI Gateway 将一致的开发者体验与全球可用、面向生产环境的基础设施融为一体。

Swap a model string and you’re testing a new provider in seconds:

只需替换一个模型字符串，几秒钟内即可开始测试新的供应商：

```jsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'xai/grok-4', // defaults to Vercel AI Gateway

5  prompt: 'How does Vercel AI Gateway have no markup on tokens?'

6})
```

```jsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'xai/grok-4', // 默认使用 Vercel AI Gateway

5  prompt: 'Vercel AI Gateway 为何在 token 上不添加任何标记？'

6})
```

AI Gateway supports hundreds of models, you can [view the library here](https://vercel.com/ai-gateway/models).

AI Gateway 支持数百种模型，您可[在此查看完整模型库](https://vercel.com/ai-gateway/models)。

With AI Gateway you can use any vendor, any model, through a single API. Built on AI SDK 5, it supports hundreds of models today without requiring you to manage API keys, rate limits, or provider accounts. The Gateway handles authentication, usage tracking, failover, billing, and more.

借助 AI Gateway，您可通过单一 API 调用任意供应商、任意模型。基于 AI SDK 5 构建，AI Gateway 当前已原生支持数百种模型，无需您自行管理 API 密钥、速率限制或供应商账户。网关自动处理身份认证、用量追踪、故障转移、计费等各项任务。

Developers want speed, reliability, and choice. AI Gateway is built for teams creating AI apps, agents, RAG systems, or search and chat experiences who:

开发者追求速度、可靠性与选择权。AI Gateway 专为构建 AI 应用、智能体（agents）、检索增强生成（RAG）系统，以及搜索与对话体验的团队而设计，适用于以下场景：

- Evaluate or swap models dynamically  
- 动态评估或切换模型

- Need higher rate limits than a single vendor can provide  
- 需要超出单一供应商所能提供的更高调用速率限制

- Want access to new frontier models as soon as they launch  
- 希望在前沿新模型发布后第一时间接入使用

- Can’t afford a single point of failure  
- 无法承受单点故障风险

- Need visibility into model usage and cost without juggling several dashboards  
- 需要清晰掌握模型调用量与成本，无需在多个仪表盘之间来回切换

## Zero markup, high reliability

## 零加价，高可靠性

And all this with zero markup: bring your own keys and contracts, with no added markup on model prices.

上述所有能力均不收取任何加价费用：您可自带 API 密钥与商业合同，模型价格完全按原始定价执行，无额外加成。

Just as CDNs transformed networking with redundancy, failover, and optimization, AI Gateway will transform inference reliability for your apps. Vercel's CDN powers trillions of requests a year[\[1\]](https://vercel.com/blog/ai-gateway-is-now-generally-available#note-trillions-of-requests), and sits at the core of AI Gateway providing sub-20ms latency.

正如内容分发网络（CDN）通过冗余部署、故障自动转移与网络优化彻底改变了网络服务架构，AI Gateway 也将从根本上提升您应用的推理服务可靠性。Vercel 的 CDN 每年处理数万亿次请求[\[1\]](https://vercel.com/blog/ai-gateway-is-now-generally-available#note-trillions-of-requests)，并作为 AI Gateway 的核心基础设施，提供低于 20 毫秒的端到端延迟。

## Getting started with AI Gateway

## 开始使用 AI Gateway

The AI Gateway is now [generally available](https://vercel.com/changelog/ai-gateway-is-now-generally-available). [Try it for free](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys%3Futm_source%3Dai_gateway_landing_page&title=Get+an+API+Key), or [browse the model library](https://vercel.com/ai-gateway/models) to see supported providers and chat with a model of your choice.

AI 网关现已正式发布（[General Availability](https://vercel.com/changelog/ai-gateway-is-now-generally-available)）。[免费试用](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys%3Futm_source%3Dai_gateway_landing_page&title=Get+an+API+Key)，或[浏览模型库](https://vercel.com/ai-gateway/models)，查看当前支持的模型提供商，并与您选择的模型直接对话。

Through the AI Gateway, we want to help you build fast, stay reliable, and keep up with the rapid pace of AI innovation without being slowed down by infrastructure, or locked into any one model or provider.

借助 AI 网关，我们希望助您快速构建应用、保持系统稳定可靠，并紧跟 AI 创新步伐——无需被基础设施拖慢脚步，也无需绑定于某一个特定模型或服务提供商。

## Frequently Asked Questions

## 常见问题（FAQ）

Can I try the AI Gateway for free?

我可以免费试用 AI 网关吗？

How is the AI Gateway priced?

AI 网关如何计费？

Do you have any rate limits?

是否有调用频率限制（rate limits）？

What models do you support?

目前支持哪些模型？

## Notes

## 备注

2. [↑](https://vercel.com/blog/ai-gateway-is-now-generally-available#trillions-of-requests) https://vercel.com/blog/gartner-mq-visionary-2025 - 115B weekly requests served by Vercel

2. [↑](https://vercel.com/blog/ai-gateway-is-now-generally-available#trillions-of-requests) https://vercel.com/blog/gartner-mq-visionary-2025 — Vercel 每周处理请求量达 1150 亿次。