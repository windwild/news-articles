---
title: "Moonshot AI's Kimi K2 Thinking models are now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/moonshot-ai-kimi-k2-thinking-and-kimi-k2-thinking-turbo-are-now-available"
date: "2025-11-06"
scraped_at: "2026-03-02T09:26:05.987620946+00:00"
language: "en-zh"
translated: true
description: "You can now access Moonshot AI's Kimi K2 Thinking and Kimi K2 Thinking Turbo with Vercel's AI Gateway with no other provider accounts required."
---

Nov 6, 2025

2025 年 11 月 6 日

You can now access Moonshot AI's latest and most powerful thinking models, Kimi K2 Thinking and Kimi K2 Thinking Turbo, using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway)，无需注册其他服务商账号，直接调用 Moonshot AI 最新、最强大的推理模型：Kimi K2 Thinking 和 Kimi K2 Thinking Turbo。

Kimi K2 Thinking is oss and excels at deep reasoning, handling up to 200–300 sequential tool calls, and achieves top results on benchmarks for reasoning and coding. Kimi K2 Thinking Turbo is a high speed version of Kimi K2 Thinking and is best suited for scenarios requiring both deep reasoning and low latency.

Kimi K2 Thinking 是开源模型（OSS），擅长深度推理，可连续处理多达 200–300 次工具调用，在推理与编程类基准测试中表现卓越。Kimi K2 Thinking Turbo 是 Kimi K2 Thinking 的高速版本，专为同时要求深度推理能力与低延迟响应的场景而优化。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher-than-provider-average uptime.

AI 网关（AI Gateway）支持通过统一、一致的 API 调用模型，仅需修改一个字符串即可切换模型；同时提供用量与费用追踪功能，并支持配置性能优化、重试机制及故障转移策略，从而实现远超单个服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK](https://ai-sdk.dev/), set the model to `moonshotai/kimi-k2-thinking` or `moonshotai/kimi-k2-thinking-turbo`:

如需在 [AI SDK](https://ai-sdk.dev/) 中使用该模型，请将 `model` 参数设为 `moonshotai/kimi-k2-thinking` 或 `moonshotai/kimi-k2-thinking-turbo`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "moonshotai/kimi-k2-thinking",

5  prompt: "Please help me generate a technology and economic news report"
```

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

包含内置的[可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能[提供商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway) or try it in our [model playground](https://vercel.com/ai-gateway/models/kimi-k2-thinking).

进一步了解[AI Gateway](https://vercel.com/docs/ai-gateway)，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway)，或在我们的[模型游乐场（Model Playground）](https://vercel.com/ai-gateway/models/kimi-k2-thinking)中亲自体验。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶级 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对随时间推移使用最频繁的模型进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)