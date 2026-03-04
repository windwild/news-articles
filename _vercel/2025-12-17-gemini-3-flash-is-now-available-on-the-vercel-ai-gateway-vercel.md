---
title: "Gemini 3 Flash is now available on the Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gemini-3-flash-is-now-available-on-the-vercel-ai-gateway"
date: "2025-12-17"
scraped_at: "2026-03-02T09:23:45.183982528+00:00"
language: "en-zh"
translated: true
description: "You can now access the Gemini 3 Flash model on Vercel's AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Dec 17, 2025

2025 年 12 月 17 日

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接调用 Google 最新 Gemini 模型 —— Gemini 3 Flash，无需注册其他服务商账号。

Gemini 3 Flash 是 Google 当前最智能的模型，专为极致速度而优化：它融合了 Gemini 3 级别的专业级推理能力，同时具备“Flash”级别的低延迟、高效率与低成本优势。相较于上一代 Gemini 2.5 系列模型，Gemini 3 Flash 在绝大多数基准测试中均显著超越 Gemini 2.5 Pro，同时 token 消耗减少 30%，响应速度提升 3 倍，且成本仅为原先的一小部分。

如需在 [AI SDK](https://ai-sdk.dev/) 中使用 Gemini 3 Flash，请将 `model` 参数设为 `google/gemini-3-flash`：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3-flash',

5  prompt:

6    `Produce a step-by-step analysis that solves a novel

7     problem, exposes intermediate logic, and delivers a final answer

7     问题，揭示中间推理逻辑，并以最少的 token 数量和最高的推理密度输出最终答案。

8     using minimal tokens and maximal inference density.`

8     使用最少的 token 数量和最高的推理密度。`

9  providerOptions: {

9  providerOptions: {

10    google: {

10    google: {

11      thinkingLevel: 'high',

11      thinkingLevel: 'high',

12      includeThoughts: true

12      includeThoughts: true

13    },

13    },

14  },

14  },

15});

15});

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化，从而实现高于单个模型提供商的可用性（uptime）。

It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

它内置了[可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及支持自动重试的智能[提供商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gemini-3-flash).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/gemini-3-flash) 中亲自体验。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶尖 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由 Gateway 流入的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
&#123;% endraw %}
