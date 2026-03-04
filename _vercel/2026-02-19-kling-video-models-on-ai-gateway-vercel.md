---
render_with_liquid: false
title: "Kling video models on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/kling-video-models-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:26.890157411+00:00"
language: "en-zh"
translated: true
description: "Generate AI videos with Kling models via the AI Gateway. Text-to-video with audio, image-to-video with first/last frame control, and motion transfer. 7 models including v3.0, v2.6, and turbo variants."
---
render_with_liquid: false
render_with_liquid: false

Feb 19, 2026

2026 年 2 月 19 日

Kling 视频模型现已在 AI Gateway 中上线，包括最新的 Kling 3.0 模型。您可通过 AI Gateway 和 AI SDK，利用 Kling 先进的视频生成模型，基于文本、图像或运动参考生成电影级视频。

Kling 模型以强大的“图像到视频”生成能力与多镜头叙事能力著称：

- **图像到视频能力（Image-to-Video Capabilities）**：擅长将静态图像动画化为视频片段  

- **逼真的运动与物理效果（Realistic Motion and Physics）**：以动作连贯性、面部表情自然度及物理交互真实性见长  

- **高分辨率输出（High Resolution Output）**：支持最高达 1080p 的视频生成（专业模式）  

- **多镜头叙事（Multishot Narratives）**：Kling 3.0 可根据单条叙事性提示词生成包含多个场景的视频  

- **音频生成（Audio Generation）**：可同步生成音效与环境音，与视频精准匹配  

- **首帧与尾帧控制（First & Last Frame Control）**：支持分别指定起始帧与结束帧，实现精准的场景转场  

## Two ways to get started

## 两种快速入门方式

Video generation is in beta and currently available for Pro and Enterprise plans and paid AI Gateway users.

视频生成功能目前处于 Beta 阶段，仅面向 Pro 和 Enterprise 订阅计划用户，以及付费的 AI Gateway 用户开放。

- **AI SDK 6**: Generate videos programmatically AI SDK 6's `generateVideo`.

- **AI SDK 6**：通过编程方式生成视频——使用 AI SDK 6 的 `generateVideo` 方法。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v2.6-t2v',

5  prompt: 'A chef plates a dessert with caramel drizzle. Kitchen ambiance.',

6});
```

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v2.6-t2v',

5  prompt: '一位厨师将一道淋有焦糖酱的甜点装盘。厨房环境氛围。',

6});
```

- **Gateway Playground**: Experiment with video models with no code in the configurable [AI Gateway playground](https://vercel.com/ai-gateway/models/kling-v3.0-t2v) that's embedded in each model page. Compare providers, tweak prompts, and download results without writing code. To access, click any video gen model in the [model list](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=klingai).

- **Gateway Playground（网关体验平台）**：无需编写代码，即可在每个模型页面内嵌的、高度可配置的 [AI Gateway 体验平台](https://vercel.com/ai-gateway/models/kling-v3.0-t2v) 中快速试用各类视频生成模型。支持跨服务商对比、实时调整提示词（prompt），并直接下载生成结果——全程零编码。如需访问，请点击 [模型列表](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=klingai) 中任意一款视频生成模型。

## Available Models

## 可用模型

|     |     |     |
| --- | --- | --- |
| Model | Type | Description |
| `klingai/kling-v3.0-t2v` | Text-to-Video | 最新版本，画质最高，支持多镜头（multishot）生成 |
| `klingai/kling-v3.0-i2v` | Image-to-Video（首尾帧动画） | 以 v3 质量对图像进行动画化处理，并支持多帧输出 |
| `klingai/kling-v2.6-t2v` | Text-to-Video | 支持音频生成 |
| `klingai/kling-v2.6-i2v` | Image-to-Video（首尾帧动画） | 可使用输入图像作为参考 |
| `klingai/kling-v2.5-turbo-t2v` | Text-to-Video | 生成速度更快 |
| `klingai/kling-v2.5-turbo-i2v` | Image-to-Video（首尾帧动画） | 生成速度更快 |

## Simple: Text-to-Video with Audio

## 简单示例：带音频的文生视频（Text-to-Video）

根据文本描述生成视频。

本示例使用模型 `klingai/kling-v3.0-t2v`，仅凭一条简单的文本提示（prompt），即生成一棵樱花树的视频。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v3.0-t2v',

5  prompt:

6   `Cherry blossom petals falling in slow motion through golden sunlight,

7    Japanese garden with a stone lantern, peaceful atmosphere, cinematic`,

7    日式庭院，配有石灯笼，氛围宁静，电影感十足。

8  aspectRatio: '16:9',

8  aspectRatio: '16:9',

9  duration: 5,

9  duration: 5,

10  providerOptions: {

10  providerOptions: {

11    klingai: {

11    klingai: {

12      mode: 'pro',

12      mode: 'pro',

13    },

13    },

14  },

14  },

15});
```

## Advanced: Multishot Video

## 高级功能：多镜头视频

Generate a narrative video with multiple scenes with only a single prompt. Using Kling 3.0's multishot feature, the model intelligently cuts between shots to tell a complete story:

仅用一个提示词即可生成包含多个场景的叙事性视频。借助 Kling 3.0 的多镜头（multishot）功能，模型可智能切换镜头，完整讲述一个故事：

The prompt is written as a narrative with multiple distinct scenes for the best results. `shotType: 'intelligence'` lets the model decide optimal shot composition and `sound: 'on'` generates synchronized audio for the entire video. Note that the prompt here is in the `providerOptions` since this functionality is specific to Kling. The Kling 3.0 models support this functionality: here `klingai/kling-v3.0-t2v` is used.

提示词应以叙事形式撰写，并包含多个明确区分的场景，以获得最佳效果。`shotType: 'intelligence'` 表示由模型自主决定最优镜头构图；`sound: 'on'` 则为整段视频生成同步音频。请注意：此处的提示词需置于 `providerOptions` 中，因为该功能为 Kling 独有。Kling 3.0 系列模型支持此功能；本例中使用的是 `klingai/kling-v3.0-t2v`。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v3.0-t2v',

5  prompt: '',

6  aspectRatio: '16:9',

7  duration: 10,

8  providerOptions: {

9    klingai: {

9    klingai：{

10      mode: 'pro',

10      mode：'pro'，

11      multiShot: true,

11      multiShot：true，

12      shotType: 'intelligence',

12      shotType：'intelligence'，

13      prompt:

13      prompt：

14       `Elephants walk across a golden savanna under gathering storm clouds.

14       `大象在积聚的雷雨云下，穿行于金色的稀树草原。

15        Lightning cracks in the distance. Rain begins to fall heavily.

15        远处电光闪烁，大雨倾盆而下。

16        The herd finds shelter under acacia trees.

16        象群在金合欢树下寻找庇护。

17        The storm clears revealing a double rainbow.`,

17        暴雨停歇，天空中显现出一道双彩虹。`，

18      sound: 'on',

18      sound：'on'，

19    },

20  },

21});
```

## Advanced: First & Last Frame Control

## 高级功能：首帧与末帧控制

Control exactly how your video starts and ends by providing both a first frame and last frame image. This is perfect for time-lapse effects or precise scene transitions:

通过提供首帧和末帧图像，精确控制视频的起始与结束画面。该功能特别适用于延时摄影效果或精准的场景转场：

These 2 images were provided as start and end frames.

这两张图片分别被指定为起始帧和结束帧。

![](images/kling-video-models-on-ai-gateway-vercel/img_001.jpg)

Using AI SDK 6, you can set `image` and `lastFrameImage` with your start and end frames. In this example, `klingai/kling-v3.0-i2v` is used for the model.

在 AI SDK 6 中，您可通过 `image` 和 `lastFrameImage` 参数分别传入起始帧与结束帧图像。本示例中使用的模型为 `klingai/kling-v3.0-i2v`。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';
```

```javascript
const { videos } = await generateVideo({

4  model: 'klingai/kling-v3.0-i2v',

5  prompt: {

6    image: startImage,

7    text: `Time-lapse of a pink peony flower blooming.

8     The tight bud slowly unfurls, petals gently separating and opening outward.

9     Smooth organic movement. Soft natural lighting.`,

10  },

11  duration: 10,

12  providerOptions: {
```

```javascript
const { videos } = await generateVideo({

4  model: 'klingai/kling-v3.0-i2v',

5  prompt: {

6    image: startImage,

7    text: `粉红色芍药花绽放的延时摄影。

8     紧闭的花苞缓缓展开，花瓣轻柔地分离并向外舒展。

9     动作流畅自然，光线柔和真实。`,

10  },

11  duration: 10,

12  providerOptions: {
```

13    klingai: {

13    klingai：{

14      lastFrameImage: endImage,

14      lastFrameImage: endImage,

15      mode: 'pro',

15      mode: 'pro',

16    },

16    },

17  },

17  },

18});
```

18});
```

## Learn More

## 了解更多

For more examples and detailed configuration options for Kling models, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).

如需了解 Kling 模型的更多示例及详细配置选项，请参阅[视频生成文档](https://vercel.com/docs/ai-gateway/capabilities/video-generation)。您还可以通过[视频生成快速入门](https://vercel.com/docs/ai-gateway/getting-started/video)获取简易的入门脚本。