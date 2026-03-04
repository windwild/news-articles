---
title: "Image-only models available in Vercel AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/image-only-models-available-in-vercel-ai-gateway"
date: "2025-11-28"
scraped_at: "2026-03-02T09:25:06.095392882+00:00"
language: "en-zh"
translated: true
description: "You can now access image-only models from Black Forest Labs and Google in Vercel AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Nov 28, 2025

2025 年 11 月 28 日

You can now access image-only models via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 直接调用纯图像生成模型，无需另行注册其他服务商账号。

In addition to multimodal models with image generation capabilities that are currently available in AI Gateway (e.g., [GPT-5.1](https://vercel.com/ai-gateway/models/gpt-5.1-thinking), [Nano Banana Pro](https://vercel.com/ai-gateway/models/gemini-3-pro-image), etc.), these image-only models are exclusively for image generation.

除 AI 网关当前已支持的具备图像生成功能的多模态模型（例如：[GPT-5.1](https://vercel.com/ai-gateway/models/gpt-5.1-thinking)、[Nano Banana Pro](https://vercel.com/ai-gateway/models/gemini-3-pro-image) 等）外，本次新增的纯图像生成模型专用于图像生成任务。

The models include:

所含模型包括：

Black Forest Labs:

Black Forest Labs（黑森林实验室）：

- FLUX.2 Flex: `bfl/flux-2-flex`

- FLUX.2 Flex：`bfl/flux-2-flex`

- FLUX.2 Pro: `bfl/flux-2-pro`

- FLUX.2 Pro：`bfl/flux-2-pro`

- FLUX.1 Kontext Max: `bfl/flux-kontext-max`

- FLUX.1 Kontext Max：`bfl/flux-kontext-max`

- FLUX.1 Kontext Pro: `bfl/flux-kontext-pro`

- FLUX.1 Kontext Pro：`bfl/flux-kontext-pro`

- FLUX 1.1 Pro Ultra: `bfl/flux-pro-1.1-ultra`

- FLUX 1.1 Pro Ultra：`bfl/flux-pro-1.1-ultra`

- FLUX 1.1 Pro: `bfl/flux-pro-1.1`

- FLUX 1.1 Pro：`bfl/flux-pro-1.1`

- FLUX.1 Fill Pro: `bfl/flux-pro-1.0-fill`

- FLUX.1 Fill Pro：`bfl/flux-pro-1.0-fill`

Google:

Google：

- Imagen 4.0 Generate 001: `google/imagen-4.0-generate`

- Imagen 4.0 Generate 001：`google/imagen-4.0-generate`

- Imagen 4.0 Fast Generate 001: `google/imagen-4.0-fast-generate`

- Imagen 4.0 Fast Generate 001：`google/imagen-4.0-fast-generate`

- Imagen 4.0 Ultra Generate 001: `google/imagen-4.0-ultra-generate`

- Imagen 4.0 Ultra Generate 001：`google/imagen-4.0-ultra-generate`


To use these models, set `model` to the corresponding slug from above in the [AI SDK](https://ai-sdk.dev/). These models support `generateImage`.

如需使用这些模型，请在 [AI SDK](https://ai-sdk.dev/) 中将 `model` 参数设为上方列出的对应模型标识符（slug）。这些模型均支持 `generateImage` 功能。

```tsx
import { experimental_generateImage as generateImage } from 'ai';



const result = await generateImage({

4  model: 'bfl/flux-2-flex',

5  prompt:
```

6    'A snow leopard poised on a neon-lit rooftop at midnight rendered in vivid pop-art style.',

6    “一只雪豹静伏于霓虹灯映照的屋顶之上，时间是午夜，画面采用鲜明浓烈的波普艺术风格。”

7});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于服务商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试能力的智能[服务商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Read the [docs](https://vercel.com/docs/ai-gateway/image-generation) on image generation, view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or try these models directly in the [model playground](https://vercel.com/ai-gateway/models?type=image).

请查阅有关图像生成的[文档](https://vercel.com/docs/ai-gateway/image-generation)，浏览[AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或直接在[模型 Playground](https://vercel.com/ai-gateway/models?type=image) 中体验这些模型。

[**AI Gateway: Track top AI models by usage**\\  
\\  
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\  
\\  
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶级 AI 模型**\\  
\\  
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)