---
title: "Mistral Large 3 now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/mistral-large-3-now-available-on-vercel-ai-gateway"
date: "2025-12-02"
scraped_at: "2026-03-02T09:24:31.098997397+00:00"
language: "en-zh"
translated: true
description: "You can now access Mistral's latest model, Mistral Large 3, on Vercel AI Gateway with no other provider accounts required."
---
{% raw %}

Dec 2, 2025

2025 年 12 月 2 日

You can now access Mistral's latest model Mistral Large 3 via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.  
您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 Mistral 最新模型 Mistral Large 3，无需另行注册其他服务商账户。

Mistral Large 3 is Mistral's most capable model to date. It has a sparse mixture-of-experts architecture with 41B active parameters (675B total), and is Mistral’s first mixture-of-experts model since the Mixtral series.  
Mistral Large 3 是 Mistral 至今为止能力最强的模型。它采用稀疏混合专家（sparse mixture-of-experts）架构，拥有 410 亿活跃参数（总参数量达 6750 亿），也是自 Mixtral 系列以来 Mistral 首款混合专家模型。

To use Mistral Large 3, set `model` to `mistral/mistral-large-3` in the [AI SDK](https://ai-sdk.dev/).  
如需使用 Mistral Large 3，请在 [AI SDK](https://ai-sdk.dev/) 中将 `model` 参数设为 `mistral/mistral-large-3`。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'mistral/mistral-large-3',

5  prompt: 'What are the most important things to consider when using OSS models?',

6});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.  
AI Gateway 提供统一 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于单个服务商的可用性（uptime）。它内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试功能的智能 [服务商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use the model directly in our [model playground](https://vercel.com/ai-gateway/models/mistral-large-3).

阅读[文档](https://vercel.com/docs/ai-gateway)，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或直接在我们的[模型 Playground](https://vercel.com/ai-gateway/models/mistral-large-3)中使用该模型。

[**AI Gateway: Track top AI models by usage**  
**AI Gateway：按使用量追踪顶级 AI 模型**  

The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.  
AI Gateway 模型排行榜根据通过 Gateway 的全部流量所产生的总 Token 量，对各模型的历史使用量进行排序。榜单定期更新。  

View the leaderboard](https://vercel.com/ai-gateway/leaderboards)  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
{% endraw %}
