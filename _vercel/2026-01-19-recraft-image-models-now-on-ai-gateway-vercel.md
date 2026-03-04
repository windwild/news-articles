---
title: "Recraft image models now on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/recraft-image-models-now-on-ai-gateway"
date: "2026-01-19"
scraped_at: "2026-03-02T09:22:22.744527414+00:00"
language: "en-zh"
translated: true
description: "You can now access image models from Recraft in Vercel AI Gateway with no other provider accounts required."
---
{% raw %}

Jan 19, 2026

2026 年 1 月 19 日

Recraft 模型现已通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 提供，无需另行注册其他服务商账户。您可直接调用 Recraft 的图像生成模型 V3 和 V2。

这些图像模型在照片级真实感、文本渲染准确性以及对复杂提示词的理解与执行方面表现卓越。V3 版本支持长文本（多词）生成，并具备精准的文本定位能力、符合解剖学原理的人物/物体结构，以及原生矢量图（vector）输出。其内置 20 多种专业风格，涵盖写实人像、像素艺术等多样化创作方向。

如需使用该模型，请在 [AI SDK](https://ai-sdk.dev/) 中将 `model` 参数设为 `recraft/recraft-v3`。该模型支持 `generateImage` 方法。

```tsx
import { generateImage } from 'ai';



const result = await generateImage({

4  model: 'recraft/recraft-v3',

5  prompt:

6    `A misty Japanese forest with ancient cedar trees, painted in the style of

7     传统浮世绘木版画，色调柔和，以靛蓝色和苔藓绿色为主。`,

8});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于服务商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试功能的智能[服务商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/recraft-v3).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型体验平台](https://vercel.com/ai-gateway/models/recraft-v3) 中亲自尝试。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪主流 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由 Gateway 的流量所产生的总 Token 数量，对各模型的历史使用频次进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
{% endraw %}
