---
title: "GPT 5.1 models now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-1-models-now-available-in-vercel-ai-gateway"
date: "2025-11-13"
scraped_at: "2026-03-02T09:25:39.097259508+00:00"
language: "en-zh"
translated: true
description: "You can now access the two GPT 5.1 models with Vercel's AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Nov 13, 2025

2025 年 11 月 13 日

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 OpenAI 最新模型 GPT-5.1 Instant 和 GPT-5.1 Thinking，无需另行注册其他服务商账号。

- GPT-5.1 Instant 在指令遵循能力、自适应推理能力方面均有提升，并能生成更自然、更具对话感的回复。

- GPT-5.1 Thinking 在 GPT-5 Thinking 基础上进一步升级，支持动态性能调优：对简单任务优先保障响应速度，对复杂任务则启用更深层次的推理能力。

如需在 [AI SDK](https://ai-sdk.dev/) 中使用这些模型，请将 `model` 参数设为 `openai/gpt-5.1-instant` 或 `openai/gpt-5.1-thinking`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-5.1-instant",

5  prompt: "What are the benefits to adaptive reasoning?"
```

6})
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于模型提供商自身的服务可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试能力的智能[提供商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.1-instant).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型体验平台](https://vercel.com/ai-gateway/models/gpt-5.1-instant) 中亲自试用。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪主流 AI 模型**  
\\  
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
&#123;% endraw %}
