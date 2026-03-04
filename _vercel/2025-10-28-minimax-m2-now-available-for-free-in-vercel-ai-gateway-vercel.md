---
render_with_liquid: false
title: "MiniMax M2 now available for free in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/minimax-m2-now-available-in-vercel-ai-gateway"
date: "2025-10-28"
scraped_at: "2026-03-02T09:26:34.569444893+00:00"
language: "en-zh"
translated: true
description: "You can now access MiniMax M2 with Vercel's AI Gateway for free with no other provider accounts required."
---
render_with_liquid: false
render_with_liquid: false

Oct 28, 2025

2025 年 10 月 28 日

You can now access MiniMax's latest open source model, MiniMax M2 using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. The model is free to use until Nov 7th, 2025. Focused on agentic use, Minimax M2 is very efficient to serve, with only 10B active parameters per forward pass.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接调用 MiniMax 最新开源模型 MiniMax M2，无需注册其他服务商账号。该模型免费使用至 2025 年 11 月 7 日。MiniMax M2 专为智能体（agentic）场景优化，服务效率极高，每次前向推理仅需激活 100 亿（10B）参数。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 提供统一、一致的 API 接口，仅需修改一个字符串即可快速切换模型；支持用量与费用追踪，并可灵活配置性能优化策略、重试机制及故障转移方案，从而实现高于服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK](https://ai-sdk.dev/), set the model to `minimax/minimax-m2:`

如需在 [AI SDK](https://ai-sdk.dev/) 中使用该模型，请将 `model` 参数设为 `minimax/minimax-m2:`

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "minimax/minimax-m2",

5  prompt: "What is the future of open source LLM models?"

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

包含内置的[可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能[供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway) or try it in our [model playground](https://vercel.com/ai-gateway/models/minimax-m2).

了解更多关于[AI Gateway](https://vercel.com/docs/ai-gateway)的信息，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway)，或在我们的[模型游乐场（Model Playground）](https://vercel.com/ai-gateway/models/minimax-m2)中亲自体验。

[**AI Gateway: Track top AI models by usage**  
\\  
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.  
\\  
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶级 AI 模型**  
\\  
AI Gateway 模型排行榜根据通过网关的所有流量所产生的总 Token 量，对不同时期使用最频繁的模型进行排名。榜单定期更新。  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)