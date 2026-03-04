---
title: "Veo video models on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/veo-video-models-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:27.341116407+00:00"
language: "en-zh"
translated: true
description: "Generate photorealistic AI videos with the Veo models via Vercel AI Gateway. Text-to-video and image-to-video with native audio generation. Up to 4K resolution with fast mode options."
---
{% raw %}

Feb 19, 2026

2026年2月19日

Generate photorealistic videos with synchronized audio using Google's Veo models, now available through AI Gateway. Try them out now via AI SDK 6 or by selecting the models in the AI Gateway playground.

现可通过 AI Gateway 使用 Google 的 Veo 模型生成逼真度极高的视频，并同步生成音频。您可立即通过 AI SDK 6 尝试，或在 AI Gateway 演示平台中选择相应模型进行体验。

Veo models are known for their cinematic quality and audio generation:

Veo 模型以电影级画质与高质量音频生成能力著称：

- **Native Audio Generation:** Automatically generate realistic sound effects, ambient audio, and even dialogue that matches your video

- **原生音频生成**：自动合成逼真的音效、环境音，甚至与视频内容匹配的对白

- **Up to 1080p Resolution:** Generate videos at 720p and 1080p

- **最高达 1080p 分辨率**：支持生成 720p 和 1080p 视频

- **Photorealistic Quality:** Realism for nature, wildlife, and cinematic scenes

- **照片级真实感**：适用于自然风光、野生动物及电影级场景，呈现高度写实效果

- **Image-to-Video:** Animate still photos with natural motion

- **图像转视频**：为静态图片添加自然流畅的动态效果

- **Fast Mode:** Quicker generation when you need rapid iterations

- **快速模式**：需快速迭代时，显著缩短生成耗时


## Two ways to get started

## 两种入门方式

Video generation is in beta and currently available for Pro and Enterprise plans and paid AI Gateway users.

视频生成功能目前处于 Beta 测试阶段，仅面向 Pro 与 Enterprise 订阅用户，以及已付费的 AI Gateway 用户开放。

- **AI SDK 6**: Generate videos programmatically AI SDK 6's `generateVideo`.

- **AI SDK 6**：以编程方式生成视频 —— AI SDK 6 的 `generateVideo` 方法。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'google/veo-3.1-generate-001',

5  prompt: 'Woman sipping coffee by a rain-streaked window, cozy morning light.',

6});
```

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'google/veo-3.1-generate-001',

5  prompt: '一位女子坐在雨痕斑驳的窗边啜饮咖啡，晨光温暖而惬意。',

6});
```

- **Gateway Playground**: Experiment with video models with no code in the configurable [AI Gateway playground](https://vercel.com/ai-gateway/models/veo-3.1-generate-001) that's embedded in each model page. Compare providers, tweak prompts, and download results without writing code. To access, click any video gen model in the [model list](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=vertex).

- **Gateway Playground（网关体验平台）**：无需编写代码，即可在每个模型页面内嵌的可配置 [AI Gateway Playground（AI 网关体验平台）](https://vercel.com/ai-gateway/models/veo-3.1-generate-001) 中试用各类视频生成模型。轻松对比不同服务商、调整提示词（prompt），并直接下载生成结果。如需访问，请点击 [模型列表](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=vertex) 中任意一款支持视频生成的模型。

## Available Models

## 可用模型

|     |     |
| --- | --- |
| Model | Description |
| `google/veo-3.1-generate-001` | 最新版本，画质最高 |
| `google/veo-3.1-fast-generate-001` | 快速模式，适用于快速迭代 |
| `google/veo-3.0-generate-001` | 全质量生成 |
| `google/veo-3.0-fast-generate-001` | 快速模式生成 |

## Simple: Text-to-Video with Audio

## 简单：带音频的文生视频

Describe a scene and get a video.

描述一个场景，即可生成一段视频。

Generate a cinematic wildlife video with natural sound: here `google/veo-3.1-generate-001` is used with `generateAudio: true`.

生成一段具有自然音效的电影级野生动物视频：此处使用模型 `google/veo-3.1-generate-001`，并设置 `generateAudio: true`。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'google/veo-3.1-generate-001',

5  prompt:

6   `Close-up of a great horned owl

7    turning its head slowly in a moonlit forest.`,
```

8  aspectRatio: '16:9',

8  纵横比：'16:9',

9  providerOptions: {

9  提供商选项：{

10    vertex: { generateAudio: true },

10    vertex: { generateAudio: true },

11  },

11  },

12});
```

12});
```

## Advanced: Image-to-Video with Dialog

## 高级功能：带对话的图像转视频

A common workflow to ensure quality is generating a custom image with Gemini 3 Pro Image (Nano Banana Pro), then bringing it to life with Veo, complete with motion and spoken dialog.

为确保输出质量，一种常见工作流是：先使用 Gemini 3 Pro 图像模型（Nano Banana Pro）生成定制图像，再通过 Veo 将其转化为动态视频，并添加动作与语音对话。

Starting image from Nano Banana Pro:

来自 Nano Banana Pro 的起始图像：

![](images/veo-video-models-on-ai-gateway-vercel/img_001.jpg)

![](images/veo-video-models-on-ai-gateway-vercel/img_001.jpg)

Use prompts with image input with the Veo models for more control over the output. This example uses `google/veo-3.1-generate-001`, which supports image to video.

在调用 Veo 模型时，可结合图像输入与文本提示词，从而更精准地控制输出效果。本示例使用支持“图像转视频”的模型 `google/veo-3.1-generate-001`。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'google/veo-3.1-generate-001',

5  prompt: {

6    image: imageUrl,

7    text:

8     `The podcast host says "Welcome back to the show! Today we are diving

9      into something really exciting." with a friendly smile, rain falling on

10      window, cozy atmosphere.`,
```

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'google/veo-3.1-generate-001',

5  prompt: {

6    image: imageUrl,

7    text:

8     `播客主持人面带亲切微笑说道：“欢迎回到本期节目！今天我们将深入探讨一件非常令人兴奋的事情。”窗外正下着雨，整体氛围温馨舒适。`,
```

11  },

12  aspectRatio: '16:9',

13  duration: 4,

14  providerOptions: {

15    vertex: { generateAudio: true },

16  },

17});
```

## Learn More

## 了解更多

For more examples and detailed configuration options for Veo models, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).

如需了解 Veo 模型的更多示例及详细配置选项，请查阅 [视频生成文档](https://vercel.com/docs/ai-gateway/capabilities/video-generation)。您还可以通过 [视频生成快速入门](https://vercel.com/docs/ai-gateway/getting-started/video) 获取简洁的入门脚本。
{% endraw %}
