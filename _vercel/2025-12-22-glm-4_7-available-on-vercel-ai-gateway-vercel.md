---
render_with_liquid: false
title: "GLM-4.7 available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/glm-4-7-available-on-vercel-ai-gateway"
date: "2025-12-22"
scraped_at: "2026-03-02T09:24:01.908874999+00:00"
language: "en-zh"
translated: true
description: "You can now access the Z.ai GLM-4.7 model on Vercel's AI Gateway with no other provider accounts required."
---
render_with_liquid: false
render_with_liquid: false

Dec 22, 2025

2025 年 12 月 22 日

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接调用 Z.ai 最新模型 GLM-4.7，无需注册其他服务商账号。

GLM-4.7 在编程能力、工具调用及多步推理方面实现了显著提升，尤其适用于复杂的智能体（agentic）任务。该模型还具备更自然的对话语气，可提供更流畅的交互体验；同时在前端开发中能生成更具审美质感的代码与界面效果。

如需通过 [AI SDK](https://ai-sdk.dev/) 开始基于 GLM-4.7 构建应用，请将 `model` 参数设为 `'zai/glm-4.7'`：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'zai/glm-4.7',

5  prompt:

6    `Create an interactive weather timeline app, fetch forecasts

7     via weather tool, normalize data, render animated charts,

7     通过天气工具获取数据、标准化数据、渲染动态图表，

8     cache results, and produce a production build.`

8     缓存结果，并生成生产构建。`

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于模型提供商自身水平的服务可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试能力的智能[提供商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/glm-4.7).

进一步了解 [AI Gateway](https://vercel.com/docs/ai-gateway)，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/glm-4.7) 中亲自体验。

[**AI Gateway: Track top AI models by usage**\\  
\\  
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\  
\\  
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶尖 AI 模型**\\  
\\  
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用量进行排序。榜单定期更新。\\  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)