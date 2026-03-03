---
title: "Grok Imagine Video on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/grok-imagine-video-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:26.603149305+00:00"
language: "en-zh"
translated: true
description: "Generate AI videos with xAI Grok Imagine via the AI SDK. Text-to-video, image-to-video, and video editing with natural audio and dialogue."
---

Feb 19, 2026

2026 年 2 月 19 日

使用 xAI 的 Grok Imagine Video（现已接入 AI Gateway）生成高质量视频，具备自然流畅的动作与音频效果。立即通过以下方式体验：[v0 Grok Creative Studio](https://v0-grokstudio.vercel.app/)、AI SDK 6，或在 [AI Gateway playground](https://vercel.com/ai-gateway/models/grok-imagine-video) 中选择该模型。

Grok Imagine 以逼真的运动表现和出色的指令遵循能力著称：

- **快速生成**：数秒内即可生成视频片段，而非耗时数分钟  

- **精准理解指令**：可解析复杂提示词，并响应后续调整指令以优化场景  

- **视频编辑功能**：支持对现有视频进行风格迁移、物体替换或场景重构  

- **音频与对话生成**：原生支持音频生成，提供自然、富有表现力的语音及精准的口型同步（lip-sync）


## 三种入门方式

视频生成功能目前处于 Beta 测试阶段，仅面向 Pro 与 Enterprise 订阅用户，以及已付费的 AI Gateway 用户开放。

- [**v0 Grok Creative Studio**](https://v0-grokstudio.vercel.app/)：v0 团队基于 AI Gateway 构建了一个模板化创作平台，用于生成并展示 Grok 视频与图像作品。

- **AI SDK 6**: 以编程方式生成视频 —— AI SDK 6 的 `generateVideo` 方法。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'xai/grok-imagine-video',

5  prompt: '一只金毛寻回犬在海滩上跃起接飞盘的瞬间',

6});
```

- **网关 Playground（Gateway Playground）**: 无需编写代码，即可在可配置的 [AI Gateway Playground](https://vercel.com/ai-gateway/models/grok-imagine-video) 中试用视频生成模型——该 Playground 已嵌入每个模型页面中。您可对比不同服务商、调整提示词（prompt），并直接下载结果，全程无需写代码。要访问该 Playground，请点击 [模型列表](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=xai) 中任意一款视频生成模型。

## 可用模型

|     |     |
| --- | --- |
| 模型（Model） | 描述（Description） |
| `xai/grok-imagine-video` | 支持文本生成视频（text-to-video）、图像生成视频（image-to-video）及视频编辑（video editing） |

## Simple: Text-to-Video

## 简单：文本生成视频

Generate a video from a text description.

根据文本描述生成视频。

In this example, `xai/grok-imagine-video` is used to generate a video of 2 swans. Note that you can also specify the duration of the output.

本示例使用 `xai/grok-imagine-video` 模型生成一段包含两只天鹅的视频。请注意，您还可以指定输出视频的时长。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'xai/grok-imagine-video',

5  prompt:

6   `Two elegant white swans gliding on a misty lake at dawn, soft golden light,

7    reflections on still water, romantic atmosphere, cinematic`,
```

8  aspectRatio: '16:9',

8  aspectRatio: '16:9',

9  resolution: '1280x720',

9  resolution: '1280x720',

10  duration: 3,

10  duration: 3,

11});

11});

## Advanced: Reference-to-Video

## 高级功能：参考视频生成（Reference-to-Video）

Transform an existing video into a new style:

将一段现有视频转换为全新风格：

In this example, using a previous generation from Grok Imagine Video, the output was transformed into an animated watercolor style.

本示例中，我们以 Grok Imagine Video 之前生成的一段视频为输入，将其转换为动态水彩画风格。

The source video is used and edited, which is useful for style transfer, object swapping, and scene transformations.

源视频被直接调用并编辑，适用于风格迁移、对象替换以及场景变换等任务。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```ts
const { videos } = await generateVideo({

4  model: 'xai/grok-imagine-video',

4  模型：'xai/grok-imagine-video',

5  prompt:

5  提示词：

6   'Transform into anime style, soft hand-painted look, warm dreamy atmosphere',

6   “转换为动漫风格，柔和的手绘质感，温暖梦幻的氛围”,

7  providerOptions: {

7  服务提供商选项：{

8    xai: {

8    xai：{

9      videoUrl: sourceVideo,

9      videoUrl: sourceVideo,

10    },

10    },

11  },

11  },

12});
```

## Learn More

## 了解更多

For more examples and detailed configuration options for Grok Imagine Video, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).

有关 Grok Imagine Video 的更多示例及详细配置选项，请参阅[视频生成文档](https://vercel.com/docs/ai-gateway/capabilities/video-generation)。您还可以通过[视频生成快速入门](https://vercel.com/docs/ai-gateway/getting-started/video)获取简易的入门脚本。