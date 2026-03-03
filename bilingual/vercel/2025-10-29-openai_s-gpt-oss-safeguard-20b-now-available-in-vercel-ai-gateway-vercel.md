---
title: "OpenAI's GPT-OSS-Safeguard-20B now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openai-gpt-oss-safeguard-20b-now-available-in-vercel-ai-gateway"
date: "2025-10-29"
scraped_at: "2026-03-02T09:26:36.672616450+00:00"
language: "en-zh"
translated: true
description: "You can now access OpenAI's GPT-OSS-Safeguard-20B with Vercel's AI Gateway with no other provider accounts required."
---

Oct 29, 2025

2025 年 10 月 29 日

You can now access OpenAI's latest open source model, GPT-OSS-Safeguard-20B using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接调用 OpenAI 最新开源模型 GPT-OSS-Safeguard-20B，无需另行注册其他服务商账户。

GPT-OSS-Safeguard-20B is a fine-tuned version of its general-purpose GPT-OSS model, designed for developers to implement custom, policy-driven content moderation.

GPT-OSS-Safeguard-20B 是通用型 GPT-OSS 模型的微调版本，专为开发者设计，用于实现定制化、策略驱动的内容审核。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 提供统一、一致的 API 接口，仅需一行字符串配置即可调用该模型；同时支持用量与成本追踪，并可灵活配置性能优化、重试机制及故障转移策略，从而实现高于服务商平均水平的可用性。

To use it with the [AI SDK](https://ai-sdk.dev/), set the model to `openai/gpt-oss-safeguard-20b`:

如需在 [AI SDK](https://ai-sdk.dev/) 中使用该模型，请将 `model` 参数设为 `openai/gpt-oss-safeguard-20b`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-oss-safeguard-20b",

5  prompt: "Why are safety classification models important?"
```

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

包含内置的[可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及具备自动重试机制的智能[提供商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-oss-safeguard-20b).

进一步了解[AI Gateway](https://vercel.com/docs/ai-gateway)，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway)，或在我们的[模型游乐场（Model Playground）](https://vercel.com/ai-gateway/models/gpt-oss-safeguard-20b)中亲自体验。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶尖 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用量进行排序，定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)