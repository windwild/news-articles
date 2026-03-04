---
title: "Nova 2 Lite now available on Vercel AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/nova-2-lite-now-available-on-vercel-ai-gateway"
date: "2025-12-03"
scraped_at: "2026-03-02T09:24:46.838894618+00:00"
language: "en-zh"
translated: true
description: "You can now access Amazon's latest model Nova 2 Lite on Vercel AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Dec 3, 2025

2025 年 12 月 3 日

You can now access Amazon's latest model Nova 2 Lite via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. Nova 2 Lite is a reasoning model for everyday workloads that can process text, images, and videos to generate text.

您现在可通过 Vercel 的 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 直接调用 Amazon 最新模型 Nova 2 Lite，无需另行注册其他服务商账号。Nova 2 Lite 是一款面向日常工作任务的推理模型，可处理文本、图像和视频，并生成文本输出。

To use Nova 2 Lite, set `model` to `amazon/nova-2-lite` in the [AI SDK](https://ai-sdk.dev/). Extending thinking is disabled by default. To enable reasoning for this model, set `maxReasoningEffort` in the `providerOptions`. The reasoning content is redacted and displays as such, but users are still charged for these tokens.

如需使用 Nova 2 Lite，请在 [AI SDK](https://ai-sdk.dev/) 中将 `model` 参数设为 `amazon/nova-2-lite`。该模型默认禁用“扩展思考（extending thinking）”功能；如需启用其推理能力，请在 `providerOptions` 中设置 `maxReasoningEffort` 参数。推理过程中的中间内容将被屏蔽（显示为脱敏内容），但用户仍需为这些 token 付费。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'amazon/nova-2-lite',

5  prompt:

6  `Derive a correct, optimal algorithm to detect all unique cycles in

7   a directed graph, explaining each logical step and validating edge cases.`,
```

8  providerOptions: {

9    bedrock: {

10      reasoningConfig: {

11        maxReasoningEffort: 'medium' // 可接受的取值：'low'、'medium' 或 'high'

12      },

13    },

14  },

15});
```

AI Gateway 提供统一 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于单个服务商的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及智能的[服务商路由](https://vercel.com/docs/ai-gateway/provider-options)，并支持自动重试。

请查阅[文档](https://vercel.com/docs/ai-gateway)，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或直接在我们的[模型 Playground](https://vercel.com/ai-gateway/models/nova-2-lite) 中使用该模型。

[**AI Gateway: Track top AI models by usage**  
**AI Gateway：按使用量追踪顶级 AI 模型**

The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.  
AI Gateway 模型排行榜根据通过该网关的所有流量的总 Token 量，对不同时期使用最频繁的模型进行排序。榜单定期更新。

[View the leaderboard](https://vercel.com/ai-gateway/leaderboards)  
[查看排行榜](https://vercel.com/ai-gateway/leaderboards)