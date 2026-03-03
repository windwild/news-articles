---
title: "FLUX.2 Pro image model is now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/flux-2-pro-image-model-is-now-available-on-vercel-ai-gateway"
date: "2025-11-25"
scraped_at: "2026-03-02T09:24:51.688239676+00:00"
language: "en-zh"
translated: true
description: "You can now access the newest image model FLUX.2 Pro from Black Forest Labs in Vercel AI Gateway with no other provider accounts required."
---

Nov 25, 2025

2025 年 11 月 25 日

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接调用 Black Forest Labs 全新发布的图像生成模型 FLUX.2 Pro，无需另行注册其他服务商账号。

FLUX.2 Pro 是一款全新训练的基础图像模型，专为高级视觉智能任务设计，支持更高分辨率的图像输出（最高达 400 万像素），对现实世界知识的理解更准确，并能对光照效果与空间构图实现更精细的控制。相较于 FLUX.1 系列模型，FLUX.2 Pro 新增了多参考图输入（multi-reference input）能力，显著提升了人物与产品在多张图像中的一致性表现，支持精确的颜色匹配，并提供了更丰富的可控参数选项。

FLUX.2 Pro 在根本架构上区别于 AI Gateway 当前支持的其他具备图像生成功能的模型。该模型是纯粹面向图像生成的校正流（rectified-flow）Transformer 模型，而非已集成的多模态大语言模型（LLM）。如需使用此模型，请在 [AI SDK](https://ai-sdk.dev/) 中将 `model` 参数设为 `bfl/flux-2-pro`。该模型支持 `generateImage` 方法。

```tsx
import { experimental_generateImage as generateImage } from 'ai';



const result = await generateImage({

4  model: 'bfl/flux-2-pro',

5  prompt:

6    `Render a turquoise throated puffleg hummingbird

7     resting on a branch covered with dew at sunrise.`,

7     在日出时分，停歇在沾满露珠的枝头。`,

8  size: '1024x1024',

8  size: '1024x1024',

9});
9});

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于服务商自身可用性的运行时间。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试功能的智能[服务商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Read the [docs](https://vercel.com/docs/ai-gateway/image-generation) for more detailed examples on how to use FLUX.2 Pro with the AI SDK and OpenAI-compatible API, view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or try these models directly in the [model playground](https://vercel.com/ai-gateway/models/flux-2-pro).

请查阅[文档](https://vercel.com/docs/ai-gateway/image-generation)，获取更多关于如何结合 AI SDK 和 OpenAI 兼容 API 使用 FLUX.2 Pro 的详细示例；浏览 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或直接在 [模型 Playground](https://vercel.com/ai-gateway/models/flux-2-pro) 中体验这些模型。

[**AI Gateway: Track top AI models by usage**\\  
\\  
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\  
\\  
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪主流 AI 模型**\\  
\\  
AI Gateway 模型排行榜依据通过网关的所有流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)