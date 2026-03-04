---
title: "Grok 4.1 Fast models now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/grok-4-1-fast-models-now-available-on-vercel-ai-gateway"
date: "2025-11-20"
scraped_at: "2026-03-02T09:25:25.348202013+00:00"
language: "en-zh"
translated: true
description: "You can now access xAI's Grok 4.1 models in Vercel AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Nov 20, 2025

2025 年 11 月 20 日

You can now access xAI's latest models, Grok 4.1 Fast Reasoning and Grok 4.1 Fast Non-Reasoning, via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. These models have a 2M context window and are designed for agentic tool calling.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接调用 xAI 最新发布的模型 —— Grok 4.1 Fast Reasoning 和 Grok 4.1 Fast Non-Reasoning，无需另行注册其他服务商账号。这两款模型均支持 200 万 token 上下文窗口，专为智能体（agentic）工具调用场景设计。

Grok 4.1 Fast Reasoning is best suited for structured reasoning and agentic operations that require high accuracy, whereas Grok 4.1 Fast Non-Reasoning is tailored to speed.

Grok 4.1 Fast Reasoning 更适用于对准确性要求较高的结构化推理与智能体操作；而 Grok 4.1 Fast Non-Reasoning 则针对响应速度进行了专门优化。

To use the Grok 4.1 Fast models in AI Gateway with the [AI SDK](https://ai-sdk.dev/), set `model` to `xai/grok-4.1-fast-reasoning` or `xai/grok-4.1-fast-non-reasoning`.

如需在 AI Gateway 中通过 [AI SDK](https://ai-sdk.dev/) 使用 Grok 4.1 Fast 系列模型，请将 `model` 参数设为 `xai/grok-4.1-fast-reasoning` 或 `xai/grok-4.1-fast-non-reasoning`。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'xai/grok-4.1-fast-reasoning',

5  prompt:

6  `Take the uploaded report and extract the most relevant financial trends.
```

7   Note any outliers and provide a detailed analysis with citations.`,

8});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI 网关（AI Gateway）提供统一的 API，用于调用模型、追踪使用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于模型提供商自身的服务可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试功能的智能[供应商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/grok-4.1-fast-non-reasoning).

了解更多关于[AI 网关](https://vercel.com/docs/ai-gateway)的信息，查看[AI 网关模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的[模型游乐场](https://vercel.com/ai-gateway/models/grok-4.1-fast-non-reasoning)中亲自体验。

[**AI Gateway: Track top AI models by usage**\\  
\\  
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\  
\\  
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI 网关：按使用量追踪主流 AI 模型**\\  
\\  
AI 网关模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
&#123;% endraw %}
