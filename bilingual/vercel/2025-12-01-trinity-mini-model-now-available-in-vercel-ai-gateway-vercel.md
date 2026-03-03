---
title: "Trinity Mini model now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/trinity-mini-model-now-available-in-vercel-ai-gateway"
date: "2025-12-01"
scraped_at: "2026-03-02T09:25:20.346121903+00:00"
language: "en-zh"
translated: true
description: "You can now access the newest Arcee AI model Trinity Mini in Vercel AI Gateway with no other provider accounts required."
---

Dec 1, 2025

2025 年 12 月 1 日

You can now access Arcee AI's latest model Trinity Mini via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. Trinity Mini is an open weight MoE reasoning model with 26B parameters (3B active) trained end-to-end in the U.S.

您现在可通过 Vercel 的 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 直接调用 Arcee AI 最新模型 Trinity Mini，无需另行注册其他服务商账号。Trinity Mini 是一款开源权重的混合专家（MoE）推理模型，总参数量为 260 亿（其中每次激活约 30 亿），全程在美国端到端训练完成。

To use Trinity Mini, set `model` to `arcee-ai/trinity-mini` in the [AI SDK](https://ai-sdk.dev/).

如需使用 Trinity Mini，请在 [AI SDK](https://ai-sdk.dev/) 中将 `model` 参数设为 `arcee-ai/trinity-mini`。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'arcee-ai/trinity-mini',

5  prompt:

6  `Generate a full reasoning chain that reconstructs how an unknown machine

7   operates solely from its final outputs, inferring internal mechanisms,

8   intermediate states, and causal links step by step.`,

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化，从而实现高于模型提供商自身可用性的服务等级。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试能力的智能[提供商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use the model directly in our [model playground](https://vercel.com/ai-gateway/models/trinity-mini).

请查阅[文档](https://vercel.com/docs/ai-gateway)，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或直接在我们的[模型 Playground](https://vercel.com/ai-gateway/models/trinity-mini) 中使用该模型。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶级 AI 模型**\\
\\
AI Gateway 模型排行榜根据通过网关的所有流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)