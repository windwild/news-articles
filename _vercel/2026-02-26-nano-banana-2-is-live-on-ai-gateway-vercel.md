---
title: "Nano Banana 2 is live on AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/nano-banana-2-is-live-on-ai-gateway"
date: "2026-02-26"
scraped_at: "2026-03-02T09:21:22.410752272+00:00"
language: "en-zh"
translated: true
description: "You can now access Google's newest model, Gemini 3.1 Flash Image Preview (Nano Banana 2) via Vercel's AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Feb 26, 2026

2026 年 2 月 26 日

Gemini 3.1 Flash Image Preview (Nano Banana 2) is now available on AI Gateway.

Gemini 3.1 Flash 图像预览版（Nano Banana 2）现已在 AI Gateway 上线。

This release improves visual quality while maintaining the generation speed and cost of flash-tier models.

本次发布在保持 Flash 级模型生成速度与成本优势的同时，显著提升了图像视觉质量。

Nano Banana 2 can use Google Image Search to ground outputs in real-world imagery. This helps with rendering lesser-known landmarks and objects by retrieving live visual data. This model also introduces configurable thinking levels (Minimal and High) to let the model reason through complex prompts before rendering. New resolutions and new aspect ratios (512p, 1:4 and 1:8) are available alongside the existing options to expand to support more types of creative assets.

Nano Banana 2 可调用 Google 图片搜索，将生成结果锚定于真实世界影像，通过实时检索视觉数据，显著提升冷门地标与物体的渲染准确性。该模型还引入可配置的推理层级（“Minimal” 与 “High”），使模型可在图像生成前对复杂提示进行深度推理。此外，新增分辨率（512p）与宽高比（1:4、1:8），配合现有选项，进一步拓展对多样化创意素材的支持能力。

To use this model, set model to `google/gemini-3.1-flash-image-preview` in the AI SDK. Nano Banana 2 is a multimodal model. Use \`streamText\` or \`generateText\` to generate images alongside text responses. This example shows how the model can use web search to find live data.

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `google/gemini-3.1-flash-image-preview`。Nano Banana 2 是一个多模态模型，可调用 \`streamText\` 或 \`generateText\` 方法，在生成文本响应的同时生成图像。以下示例展示了该模型如何借助网络搜索获取实时数据。

![](images/nano-banana-2-is-live-on-ai-gateway-vercel/img_001.jpg)

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3.1-flash-image-preview',

5  providerOptions: {

5  providerOptions: {

6    google: { responseModalities: ['TEXT', 'IMAGE'] },

6    google: { responseModalities: ['TEXT', 'IMAGE'] },

7  },

7  },

8  prompt: 'Generate an image of the 2026 Super Bowl at golden hour',

8  prompt: '在黄金时刻生成一张2026年超级碗比赛的图像',

9});
```

9});
```

You can also change the thinking level: in this example, thinking is set to `high` for a more thorough response.

您还可以调整思考级别：本示例中，`thinking` 被设为 `high`，以获得更详尽的响应。

![](images/nano-banana-2-is-live-on-ai-gateway-vercel/img_002.jpg)

![](images/nano-banana-2-is-live-on-ai-gateway-vercel/img_002.jpg)

```tsx
import { streamText } from 'ai';



const result = streamText({


```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3.1-flash-image-preview',

4  模型：'google/gemini-3.1-flash-image-preview',

5  providerOptions: {

5  提供商选项（providerOptions）：{

6    google: {

6    google：{

7      responseModalities: ['TEXT', 'IMAGE'],

7      响应模态（responseModalities）：['TEXT', 'IMAGE'],

8      thinkingConfig: {

8      思维配置（thinkingConfig）：{

9        includeThoughts: true,

9        包含思维过程（includeThoughts）：true,

10        thinkingLevel: 'high',

10        思维层级（thinkingLevel）：'high',

11      },

11      },

12    },

12    },

13  },

13  },

14  prompt:

14  提示词：

15   `一张现代 GPU 的爆炸图，展示芯片（die）、高带宽内存（HBM）堆栈、中介层（interposer）

16    以及散热方案，各组件以分离的悬浮图层形式呈现，并配有带标签的引线注释。`,

17});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于服务商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)功能、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能服务商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gemini-3.1-flash-image-preview).

了解更多关于[AI Gateway](https://vercel.com/ai-gateway)的信息，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的[模型游乐场](https://vercel.com/ai-gateway/models/gemini-3.1-flash-image-preview)中亲自体验。