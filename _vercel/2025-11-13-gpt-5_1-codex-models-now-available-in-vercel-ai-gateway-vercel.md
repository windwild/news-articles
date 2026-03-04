---
title: "GPT 5.1 Codex models now available in Vercel AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-1-codex-models-now-available-in-vercel-ai-gateway"
date: "2025-11-13"
scraped_at: "2026-03-02T09:25:42.656150976+00:00"
language: "en-zh"
translated: true
description: "You can now access the two GPT 5.1 Codex models with Vercel's AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Nov 13, 2025

2025 年 11 月 13 日

You can now access OpenAI's latest Codex models, GPT-5.1 Codex and GPT-5.1 Codex mini with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required. These Codex models are optimized for long-running, agentic coding tasks and are able to maintain context and reasoning over longer sessions without degradation.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 OpenAI 最新的 Codex 模型——GPT-5.1 Codex 和 GPT-5.1 Codex mini，无需另行注册其他服务商账号。这些 Codex 模型专为长时间运行、具备自主代理能力（agentic）的编程任务而优化，可在更长会话中持续保持上下文连贯性与逻辑推理能力，且性能不会随会话延长而下降。

To use these models with the [AI SDK](https://ai-sdk.dev/), set the model to `openai/gpt-5.1-codex` or `openai/gpt-5.1-codex-mini`:

如需在 [AI SDK](https://ai-sdk.dev/) 中使用这些模型，请将 `model` 参数设为 `openai/gpt-5.1-codex` 或 `openai/gpt-5.1-codex-mini`：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5.1-codex',

5  prompt:

6    `Create a command-line tool that reads a text file,

7     counts word frequencies, and prints the ten most common
```

8     words with counts. Use standard libraries only.`

8     包含词频统计的单词列表。仅使用标准库。`

9});
```

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于服务商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试功能的智能[服务商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.1-codex).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/gpt-5.1-codex) 中亲自体验。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪主流 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型在一段时间内的使用热度进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)