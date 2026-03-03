---
title: "Video Generation with AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/video-generation-with-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:26.187280387+00:00"
language: "en-zh"
translated: true
description: "Build video generation into your apps with AI Gateway. Create product videos, dynamic content, and marketing assets at scale."
---

Feb 19, 2026

2026 年 2 月 19 日

AI Gateway 现已支持视频生成，您可通过 AI SDK 6 创建具备电影级质感、照片级真实感、音画同步的视频，并生成身份一致的个性化内容。

## Two ways to get started

## 两种入门方式

视频生成功能目前处于 Beta 阶段，仅面向 Pro 和 Enterprise 订阅计划用户，以及已付费使用 AI Gateway 的用户开放。

- **AI SDK 6**: 使用与文本和图像生成相同的接口，以编程方式生成视频。一套 API、一套认证流程、一个统一的可观测性仪表盘，覆盖您的整个 AI 流水线。


```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'xai/grok-imagine-video',

5  prompt: 'A golden retriever catching a frisbee mid-air at the beach',
```

6});
```

- **AI Gateway Playground**: Experiment with video models with no code in the configurable [AI Gateway playground](https://vercel.com/ai-gateway/models/grok-imagine-video) that's embedded in each model page. Compare providers, tweak prompts, and download results without writing code. To access, click any video gen model in the [model list](https://vercel.com/ai-gateway/models?capabilities=video-generation).

- **AI 网关 Playground（AI Gateway Playground）**：在每个模型页面内嵌的、可配置的 [AI 网关 Playground](https://vercel.com/ai-gateway/models/grok-imagine-video) 中，无需编写代码即可试用视频生成模型。轻松对比不同服务商、调整提示词（prompts），并直接下载结果。要访问该功能，请点击 [模型列表](https://vercel.com/ai-gateway/models?capabilities=video-generation) 中任意一款支持视频生成的模型。

## Four initial video models; 17 variations

## 首批四款视频模型；共 17 种变体

- **Grok Imagine** from xAI is fast and great at instruction following. Create and edit videos with style transfer, all in seconds.

- xAI 推出的 **Grok Imagine** 速度快，且擅长遵循指令。支持在数秒内完成视频创建与编辑，并实现风格迁移（style transfer）。

- **Wan** from Alibaba specializes in reference-based generation and multi-shot storytelling, with the ability to preserve identity across scenes.

- 阿里巴巴推出的 **Wan** 擅长基于参考图像的生成与多镜头叙事，并能在不同场景中保持主体身份的一致性。

- **Kling** excels at image to video and native audio. The new 3.0 models support multishot video with automatic scene transitions.

- **Kling** 在“图生视频”（image-to-video）和原生音频生成方面表现卓越。其最新 3.0 版本模型支持多镜头视频生成，并具备自动场景切换能力。

- **Veo** from Google delivers high visual fidelity and physics realism. Native audio generation with cinematic lighting and physics.

- 谷歌推出的 **Veo** 具备高视觉保真度与物理真实感。支持原生音频生成，并融合电影级布光与物理模拟效果。

## Understanding video requests

## 理解视频生成请求

Video models require more than just describing what you want. Unlike image generation, video prompts can include motion cues (camera movement, object actions, timing) and optionally audio direction. Each provider exposes different capabilities through `providerOptions` that unlock fundamentally different generation modes. See the [documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation) for model-specific options.

视频模型的使用远不止于简单描述所需内容。与图像生成不同，视频提示词（video prompts）可包含运动线索（如摄像机运动、物体动作、时间节奏等），还可选择性加入音频指示。各服务商通过 `providerOptions` 参数暴露不同的能力，从而启用本质迥异的生成模式。有关各模型专属选项的详细说明，请参阅 [文档](https://vercel.com/docs/ai-gateway/capabilities/video-generation)。

## Generation types

## 生成类型

AI Gateway 最初支持 4 种视频生成类型：

|     |     |     |     |
| --- | --- | --- | --- |
| **类型** | **输入** | **描述** | **典型使用场景** |
| 文本生成视频（Text-to-video） | 文本提示（Text prompt） | 描述一个场景，生成对应视频 | 广告创意、讲解类视频、社交媒体内容 |
| 图像生成视频（Image-to-video） | 图像，文本提示为可选 | 为静态图像添加动态效果 | 产品展示、Logo 动态呈现、照片动画 |
| 首尾帧生成视频（First and last frame） | 两张图像，文本提示为可选 | 定义起始与结束状态，模型自动生成中间过渡帧 | 对比呈现（如“前后对比”）、延时效果、转场动画 |
| 参考生成视频（Reference-to-video） | 图像或视频 | 从参考图像或视频中提取人物角色，并将其置于全新场景中 | 发言人内容制作、品牌专属角色一致性呈现 |

各模型厂商当前在 AI Gateway 上所支持的能力如下所示：

|     |     |
| --- | --- |
| **模型厂商** | **支持能力** |
| xAI | 文本生成视频、图像生成视频、视频编辑、音频生成 |
| Wan | 文本生成视频、图像生成视频、参考生成视频、音频生成 |
| Kling | 文本生成视频、图像生成视频、首尾帧生成视频、音频生成 |
| Veo | 文本生成视频、图像生成视频、音频生成 |

## 文本生成视频（Text-to-video）

描述你想要的内容，即可获得一段视频。该模型自动处理画面、运动，以及可选的音频生成。仅需一条简洁的文本提示，即可产出超写实、具备专业制作水准的视频素材。

**示例：规模化程序化视频生成。** 按需为你的应用、平台或内容流水线批量生成视频。无需版权许可费用，也无需传统视频制作流程，只需输入提示词，即可输出成品视频。

本示例使用 `klingai/kling-v2.6-t2v` 模型，根据指定宽高比和时长，由文本提示生成视频。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';
```

```javascript
const { videos } = await generateVideo({
```

```javascript
const { videos } = await generateVideo({
```

4  model: 'klingai/kling-v2.6-t2v',

4  模型：'klingai/kling-v2.6-t2v',

5  prompt: `Wide shot of a rocket lifting off from launch pad at dawn.

5  提示词：`黎明时分，火箭从发射台升空的广角镜头。

6    Massive plume of orange fire and white smoke billows outward

6    底部喷涌出巨大的橙色火焰与白色烟云，

7    from the base. The rocket rises slowly at first, engines blazing,

7    火箭起初缓慢上升，发动机烈焰喷射，

8    then accelerates upward. Pink and orange sunrise sky

8    随后加速向上攀升。背景是粉紫色与橙色交织的朝霞天空，

9    in the background. Ocean visible in the distance.`,

9    远处可见海洋。`,

10  aspectRatio: '16:9',

10  画面宽高比：'16:9',

11  duration: 5,

11  视频时长：5 秒，

12  providerOptions: {
```

12  providerOptions: {
```

13    klingai: {

13    klingai：{

14      mode: 'pro',

14      mode：'pro'，

15      sound: 'on',

15      sound：'on'，

16    },

16    }，

17  },

17  }，

18});

18}）；

```

```

**Example: Creative content generation.**

**示例：创意内容生成。**

Turn a simple prompt into polished video clips for social media, ads, or storytelling with natural motion and cinematic quality.

将一个简单的提示词转化为适用于社交媒体、广告或叙事场景的精修视频片段，具备自然的运动效果与电影级画质。

By setting a very specific and descriptive prompt, `google/veo-3.1-generate-001` generates video with immense detail and the exact desired motion.

通过设置高度具体且富有描述性的提示词，`google/veo-3.1-generate-001` 可生成细节极为丰富、运动效果完全符合预期的视频。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```javascript
const { videos } = await generateVideo({

4  model: 'google/veo-3.1-generate-001',

5  prompt: `Close-up of a great horned owl turning its head slowly.

6    Enormous yellow eyes with intricate iris detail.

7    Every feather texture visible, from soft facial disc to ear tufts.

8    The owl blinks once, deliberately.`

9  aspectRatio: '16:9',

10});
```

## Image-to-video

## 图像生成视频

Provide a starting image and animate it. Control the initial composition, then let the model generate motion.

提供一张起始图像并为其添加动画效果。您可控制初始构图，再由模型生成动态画面。

**Example: Animate product images.**  
**示例：为产品图片添加动画效果。**

Turn existing product photos into interactive videos.  
将现有的产品照片转化为交互式视频。

The `klingai/kling-v2.6-i2v` model animates a product image after you pass an image URL and motion description in the prompt.  
`klingai/kling-v2.6-i2v` 模型可根据您在提示词中传入的图片 URL 和运动描述，为产品图片生成动画。

```tsx
iconst { videos } = await generateVideo({

2  model: 'klingai/kling-v2.6-i2v',

3  prompt: {

4    image: blackHoodie,

5    text: `The orange tabby cat walks slowly across the black hoodie.

6      Warm natural light. Cozy lifestyle scene. Smooth, cinematic.`,

7  },

8  duration: 5,
```

9  providerOptions: {

9  providerOptions: {

10    klingai: { mode: 'pro' },

10    klingai: { mode: 'pro' },

11  },

11  },

12});
```

12});
```

**Example: Animated illustrations.** Bring static artwork to life with subtle motion. Perfect for thematic content or marketing at scale.

**示例：动态插画。** 为静态艺术作品注入细腻的运动效果，使其栩栩如生。非常适合主题性内容或大规模营销场景。

**Example: Lifestyle and product photography.** Add subtle motion to food, beverage, or lifestyle shots for social content.

**示例：生活方式与产品摄影。** 为食品、饮品或生活方式类图片添加细腻动感，提升社交媒体内容表现力。

![](images/video-generation-with-ai-gateway-vercel/img_001.jpg)

![](images/video-generation-with-ai-gateway-vercel/img_001.jpg)

Here, a picture of coffee is rendered for a more interactive video, with lighting direction and minute details.

此处，一杯咖啡的图片被渲染成更具交互感的视频，精准呈现光线方向与细微质感。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```javascript
const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-i2v',

5  prompt: {

6    image: 'https://your-storage.com/coffee-pour.png',

7    text: `Coffee swirls gently in the cup, steam rises slowly,

8     warm morning light shifts subtly`,

9  },

10  resolution: '1280x720',

11  duration: 3,

12});
```

```javascript
const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-i2v',

5  prompt: {

6    image: 'https://your-storage.com/coffee-pour.png',

7    text: `咖啡在杯中轻柔旋转，热气缓缓升腾，

8     温暖的晨光微妙流转`,

9  },

10  resolution: '1280x720',

11  duration: 3,

12});
```

## First and last frame

## 首帧与末帧

Define the start and end states, and the model generates a seamless transition between them.

定义起始状态与结束状态，模型将自动生成二者之间的无缝过渡。

**Example: Before/after reveals.** Outfit swaps, product comparisons, changes over time. Upload two images, get a seamless transition.

**示例：前后对比展示**。服装更换、产品对比、随时间推移的变化等。上传两张图片，即可获得无缝过渡效果。

The start and end states are defined here with two images that used in the prompt and provider options.

起始状态与结束状态在此处通过两张图片定义，这两张图片将用于提示词（prompt）及服务商配置选项中。

![](images/video-generation-with-ai-gateway-vercel/img_002.jpg)

![](images/video-generation-with-ai-gateway-vercel/img_002.jpg)

In this example, `klingai/kling-v3.0-i2v` lets you define the start frame in `image` and the end frame in `lastFrameImage`. The model generates the transition between them.

本示例中，`klingai/kling-v3.0-i2v` 模型支持通过 `image` 参数指定首帧，通过 `lastFrameImage` 参数指定末帧；模型将据此生成两帧之间的过渡视频。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v3.0-i2v',

5  prompt: {

5  提示词：{

6    image: startFrameDataUrl, // Empty room

6    图像：startFrameDataUrl，// 空房间

7    text: `Smooth cinematic transition: The empty loft fills with furniture.

7    文本：`流畅的电影级转场：空旷的阁楼逐渐填满家具。

8      A green velvet sofa fades into view, followed by a wooden coffee table.

8      一张墨绿色丝绒沙发渐显入画，随后是一张木质咖啡桌。

9      Potted plants rise from the floor. A patterned rug materializes.

9      盆栽植物从地面缓缓升起；一块图案地毯随之浮现。

10      Framed artwork appears on the walls. Bookshelves on the back wall.

10      墙上出现装裱好的艺术画作；后墙立起书架。

11      Gentle, seamless transformation.`,

11      温和、无缝的转变。`,

12  },

12  },

13  duration: 5,

13  持续时间：5，

14  providerOptions: {

15    klingai: {

16      lastFrameImage: endFrameDataUrl, // Furnished room

16      lastFrameImage: endFrameDataUrl, // 带家具的房间

17      mode: 'std',

17      mode: 'std',

18    },

18    },

19  },

19  },

20});

20});

## Reference-to-video

## 参考视频生成（Reference-to-video）

Provide reference videos or images of a person/character, and the model extracts their appearance and voice to generate new scenes starring them with consistent identity.

提供人物或角色的参考视频或图像，模型将从中提取其外貌与声音特征，并生成由该角色主演的新场景，确保身份一致性。

In this example, 2 reference images of dogs are used to generate the final video.

本示例中，使用了 2 张狗的参考图像来生成最终视频。

![](images/video-generation-with-ai-gateway-vercel/img_003.jpg)

Using `alibaba/wan-v2.6-r2v-flash` here, you can instruct the model to utilize the people/characters within the prompt. Wan suggests using `character1`, `character2`, etc. in the prompt for multi-reference to video to get the best results.

此处使用 `alibaba/wan-v2.6-r2v-flash`，您可通过提示词（prompt）指示模型调用其中指定的人物/角色。Wan 建议在提示词中使用 `character1`、`character2` 等标识符，以实现对视频的多角色引用，从而获得最佳生成效果。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-r2v-flash',

5  prompt:

6   `character1 and character2 are playing together on the beach in San Francisco

7    with the Golden Gate Bridge in the background, sunny day, waves crashing`,

8  resolution: '1280x720',

9  duration: 5,

10  providerOptions: {

10  providerOptions: {

11    alibaba: {

11    alibaba: {

12      referenceUrls: [shibaImage, yorkieImage],

12      referenceUrls: [shibaImage, yorkieImage],

13    },

13    },

14  },

14  },

15});

15});

## Video Editing

## 视频编辑

Transform existing videos with style transfer. Provide a video URL and describe the transformation you want. The model applies the new style while preserving the original motion.

利用风格迁移技术对现有视频进行转换。提供一个视频 URL，并描述您希望实现的转换效果。模型将在保留原始运动轨迹的同时，应用新的视觉风格。

Here, `xai/grok-imagine-video` utilizes a source video from a previous generation to edit into a watercolor style.

此处，`xai/grok-imagine-video` 利用此前生成的一个源视频，将其编辑为水彩画风格。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```javascript
const { videos } = await generateVideo({

4  model: 'xai/grok-imagine-video',

4  模型：'xai/grok-imagine-video',

5  prompt: `Transform into watercolor painting style, soft flowing brushstrokes,

5  提示词：`转换为水彩画风格，柔和流动的笔触，

6   paint bleeding at edges, delicate washes of color, artistic and dreamlike`,

6   颜料在边缘晕染，色彩轻盈通透，富有艺术感且如梦似幻`,

7  providerOptions:

7  服务提供商选项：

8    xai: {

8    xai: {

9      videoUrl: dogVideo,

9      videoUrl: dogVideo,

10    },

10    },

11  },
```

12});
```

## Get started

## 入门指南

For more examples and detailed configuration options for video models, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).

如需更多视频模型示例及详细配置选项，请参阅[视频生成文档](https://vercel.com/docs/ai-gateway/capabilities/video-generation)。您还可通过[视频生成快速入门](https://vercel.com/docs/ai-gateway/getting-started/video)获取简易的入门脚本。

Check out the changelogs for these video models for more detailed examples and prompts.

请查阅以下视频模型的更新日志，获取更详尽的示例和提示词（prompts）：

- [Grok Imagine](https://vercel.com/changelog/grok-imagine-video-on-ai-gateway)

- [Alibaba Wan](https://vercel.com/changelog/wan-models-on-ai-gateway)

- [Veo](https://vercel.com/changelog/veo-video-models-on-ai-gateway)

- [Kling](https://vercel.com/changelog/kling-video-models-on-ai-gateway)