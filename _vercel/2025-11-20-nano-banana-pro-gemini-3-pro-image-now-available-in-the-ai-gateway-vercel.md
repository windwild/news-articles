---
title: "Nano Banana Pro (Gemini 3 Pro Image) now available in the AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/nano-banana-pro-gemini-3-pro-image-now-available-in-the-ai-gateway"
date: "2025-11-20"
scraped_at: "2026-03-02T09:25:27.048385534+00:00"
language: "en-zh"
translated: true
description: "You can now access Google's latest model Nano Banana Pro (Gemini 3 Pro Image) in Vercel AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Nov 20, 2025

2025 年 11 月 20 日

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接调用 Google 最新图像生成模型 Nano Banana Pro（Gemini 3 Pro Image），无需另行注册其他服务商账号。

Nano Banana Pro（Gemini 3 Pro Image）专为比 Nano Banana 更复杂的使用场景而设计。该模型针对专业及创意工作流进行了专项优化，例如：可生成带精准标注的图表，并能整合网络搜索信息，使所生成图像包含最新时效性内容。此外，Nano Banana Pro 还支持更高分辨率的图像生成，以及更高的多图输入数量上限，从而实现更优的图像合成效果。

如需在 AI Gateway 中通过 [AI SDK](https://ai-sdk.dev/) 使用 Nano Banana Pro，请将 `model` 参数设为 `google/gemini-3-pro-image`。请注意：该模型为多模态模型，因此需调用 `generateText` 方法执行实际的图像生成任务。

```tsx
import { generateText } from 'ai';



const result = await generateText({

4  model: 'google/gemini-3-pro-image',

5  prompt:

6    `Generate a labeled data pipeline diagram,

7     from data ingestion through transformation,

7     从数据摄取到数据转换，

8     storage, and analytics layers.`,

8     存储和分析层。`,

9});

9});

if (result.text) {

if (result.text) {

11  process.stdout.write(`\nAssistant: ${result.text}`);

11  process.stdout.write(`\n助手: ${result.text}`);

12}

12}

for (const file of result.files) {

for (const file of result.files) {

14  if (file.mediaType.startsWith('image/')) {

14  if (file.mediaType.startsWith('image/')) {

15    await presentImages([file]);

15    await presentImages([file]);

17}
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于供应商自身水平的服务可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及支持自动重试的智能[供应商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Read the [AI Gateway docs](https://vercel.com/docs/ai-gateway/image-generation) for examples on how to use Nano Banana Pro to generate images, view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try to generate images in our [model playground](https://vercel.com/ai-gateway/models/gemini-3-pro-image).

请查阅 [AI Gateway 文档](https://vercel.com/docs/ai-gateway/image-generation)，了解如何使用 Nano Banana Pro 生成图像；浏览 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型 Playground](https://vercel.com/ai-gateway/models/gemini-3-pro-image) 中尝试图像生成功能。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶尖 AI 模型**  
\\  
AI Gateway 模型排行榜依据通过网关的所有流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
&#123;% endraw %}
