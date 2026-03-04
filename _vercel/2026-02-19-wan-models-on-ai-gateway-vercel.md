---
render_with_liquid: false
title: "Wan models on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/wan-models-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:26.658102907+00:00"
language: "en-zh"
translated: true
description: "Generate stylized AI videos with Alibaba Wan models via the Vercel AI Gateway. Text-to-video, image-to-video, and unique style transfer (R2V) to transform existing footage into anime, watercolor, and ..."
---
render_with_liquid: false
render_with_liquid: false

Feb 19, 2026

2026 年 2 月 19 日

通过阿里云 AI Gateway，现可使用阿里巴巴的 Wan 系列模型生成风格化视频，并对现有影像素材进行转换。您可通过 AI SDK 6 立即体验，或在 AI Gateway 的 Playground 中直接选择相应模型进行试用。

Wan 系列模型可生成富有艺术感的视频，具备流畅的运动表现，并支持利用已有内容确保视频风格与角色的一致性：

- **角色参考（R2V）**：从参考视频或图像中提取角色外观与声音特征，用于生成全新场景  

- **闪电变体（Flash Variants）**：显著缩短生成耗时，便于快速迭代  

- **灵活分辨率支持**：输出分辨率支持 480p、720p 和 1080p  

## 两种快速上手方式  

视频生成功能目前处于 Beta 测试阶段，仅面向 Pro 与 Enterprise 订阅计划用户，以及已付费的 AI Gateway 用户开放。

- **AI SDK 6**：通过 AI SDK 6 的 `generateVideo` 方法以编程方式生成视频。


```tsx
import { experimental_generateVideo as generateVideo } from 'ai';

```js
const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-t2v',

5  prompt: 'Watercolor painting of a koi pond coming to life.',

6});
```

```js
const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-t2v',

5  prompt: '一幅锦鲤池塘跃然纸上的水彩画。',

6});
```

- **Gateway Playground**: Experiment with video models with no code in the configurable [AI Gateway playground](https://vercel.com/ai-gateway/models/wan-v2.6-i2v) that's embedded in each model page. Compare providers, tweak prompts, and download results without writing code. To access, click any video gen model in the [model list](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=alibaba).

- **网关 Playground（Gateway Playground）**：在每个模型页面内嵌的、可配置的 [AI 网关 Playground](https://vercel.com/ai-gateway/models/wan-v2.6-i2v) 中，无需编写代码即可试用各类视频生成模型。您可对比不同服务商、调整提示词（prompt），并直接下载结果。要访问该工具，请点击 [模型列表](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=alibaba) 中任意一个视频生成模型。

## Available Models

## 可用模型

|     |     |     |
| --- | --- | --- |
| Model | Type | Description |
| `alibaba/wan-v2.6-t2v` | Text-to-Video | Generate videos from text prompts |
| `alibaba/wan-v2.6-i2v` | Image-to-Video | Animate still images |
| `alibaba/wan-v2.6-i2v-flash` | Image-to-Video | Fast image animation |
| `alibaba/wan-v2.6-r2v` | Reference-to-Video | Character transfer from references |
| `alibaba/wan-v2.6-r2v-flash` | Reference-to-Video | Fast style transfer |
| `alibaba/wan-v2.5-t2v-preview` | Text-to-Video | Previous version |

| 模型（Model） | 类型（Type） | 描述（Description） |
| --- | --- | --- |
| `alibaba/wan-v2.6-t2v` | 文本生成视频（Text-to-Video） | 根据文本提示生成视频 |
| `alibaba/wan-v2.6-i2v` | 图像生成视频（Image-to-Video） | 为静态图像添加动画效果 |
| `alibaba/wan-v2.6-i2v-flash` | 图像生成视频（Image-to-Video） | 快速图像动画生成 |
| `alibaba/wan-v2.6-r2v` | 参考图生成视频（Reference-to-Video） | 基于参考图像进行角色迁移 |
| `alibaba/wan-v2.6-r2v-flash` | 参考图生成视频（Reference-to-Video） | 快速风格迁移 |
| `alibaba/wan-v2.5-t2v-preview` | 文本生成视频（Text-to-Video） | 上一版本 |

## Simple: Text-to-Video with Audio

## 简单示例：带音频的文本生成视频（Text-to-Video）

Generate a stylized video from a text description.

根据一段文字描述生成风格化的视频。

You can use detailed prompts and specify styles with the Wan models to achieve the desired output generation. The example here uses `alibaba/wan-v2.6-t2v`:

您可以使用详细提示词，并通过 Wan 模型指定风格，以实现理想的输出生成效果。本示例使用 `alibaba/wan-v2.6-t2v`：

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-t2v',

5  prompt:

6   `Animated rainy Tokyo street at night, anime style,

7    neon signs reflecting on wet pavement, people with umbrellas

8    walking past, red and blue lights glowing through the rain.`,

9  resolution: '1280x720',
```

10  duration: 5,

11});
```

## Advanced: Reference-to-Video

## 高级功能：参考图/视频生成

Generate new scenes using characters extracted from reference images or videos.

使用从参考图像或视频中提取的角色来生成新场景。

In this example, 2 reference images of dogs are used to generate the final video.

本示例中，使用了 2 张狗的参考图像来生成最终视频。

![](images/wan-models-on-ai-gateway-vercel/img_001.jpg)

Using `alibaba/wan-v2.6-r2v-flash` here, you can instruct the model to utilize the people/characters within the prompt. Wan suggests using `character1`, `character2`, etc. in the prompt for multi-reference to video to get the best results.

此处使用 `alibaba/wan-v2.6-r2v-flash` 模型，您可在提示词（prompt）中指定需调用的人物/角色。Wan 建议在多参考视频生成任务中，在提示词中使用 `character1`、`character2` 等标识符，以获得最佳效果。

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-r2v-flash',

4  模型：'alibaba/wan-v2.6-r2v-flash'

5  prompt:

5  提示词：

6   `character1 and character2 are playing together on the beach in San Francisco

6   `character1 和 character2 正在旧金山的海滩上一起玩耍，

7    with the Golden Gate Bridge in the background, sunny day, waves crashing`,

7    背景为金门大桥，晴朗天气，海浪拍岸`,

8  resolution: '1280x720',

8  分辨率：'1280x720'

9  duration: 5,

9  时长：5

10  providerOptions: {

10  服务商选项：{

11    alibaba: {

11    alibaba：{

12      referenceUrls: [shibaImage, yorkieImage],

12      参考图片 URL：[shibaImage, yorkieImage]

13    },

14  },

15});
```

## Learn More

## 了解更多

For more examples and detailed configuration options for Wan models, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).

如需了解 Wan 模型的更多示例及详细配置选项，请参阅[视频生成文档](https://vercel.com/docs/ai-gateway/capabilities/video-generation)。您还可以通过[视频生成快速入门](https://vercel.com/docs/ai-gateway/getting-started/video)获取简单的入门脚本。