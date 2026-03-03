---
title: "Recraft V4 on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/recraft-v4-on-ai-gateway"
date: "2026-02-17"
scraped_at: "2026-03-02T09:21:30.962758680+00:00"
language: "en-zh"
translated: true
description: "You can now access the Recraft V4 image model via Vercel's AI Gateway with no other provider accounts required."
---

Feb 17, 2026

2026 年 2 月 17 日

Recraft V4 现已在 AI Gateway 上线。

这是一款面向专业设计与市场营销场景构建的文生图模型。V4 在开发过程中广泛采纳了在职设计师的实际反馈。该模型在照片级真实感方面显著提升：人物皮肤更逼真、纹理更自然、人工合成痕迹更少；同时生成的图像光照干净、构图多样。在插画创作方面，该模型还能生成原创角色，并采用更具不可预测性的配色方案。

本模型提供两个版本：

- **V4**：速度更快、成本效益更高，适用于日常工作任务与快速迭代  

- **V4 Pro**：可生成更高分辨率图像，适用于印刷级素材及大规模应用场景


如需调用该模型，请在 AI SDK 中将 `model` 参数设为 `recraft/recraft-v4-pro` 或 `recraft/recraft-v4`：

```tsx
import { generateImage } from 'ai';



const result = await generateImage({

4  model: 'recraft/recraft-v4',

4  模型：'recraft/recraft-v4',

5  prompt:

5  提示词：

6    `Product photo of a ceramic coffee mug on a wooden table,

6    一张陶瓷咖啡杯置于木桌上的产品照片，

7     morning light, shallow depth of field.`,

7    清晨光线，浅景深。`,

8});

8});

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化，从而实现高于服务商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)功能、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能服务商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/recraft-v4).

了解更多关于[AI Gateway](https://vercel.com/ai-gateway)的信息，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的[模型体验平台](https://vercel.com/ai-gateway/models/recraft-v4)中亲自试用。