---
title: "Kling video models on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/kling-video-models-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:26.890157411+00:00"
language: "en"
translated: false
description: "Generate AI videos with Kling models via the AI Gateway. Text-to-video with audio, image-to-video with first/last frame control, and motion transfer. 7 models including v3.0, v2.6, and turbo variants."
---




Feb 19, 2026

Kling video models are now available in AI Gateway, including the newest Kling 3.0 models. Generate cinematic videos from text, images, or motion references with Kling's state-of-the-art video models, now available through AI Gateway and AI SDK.

Kling models are known for their image to video models and multishot capabilities:

- **Image-to-Video Capabilities**: Strong at animating still images into video clips

- **Realistic Motion and Physics**: Known for coherent motion, facial expressions, and physical interactions

- **High Resolution Output**: Supports up to 1080p generation (pro mode)

- **Multishot Narratives**: Kling 3.0 can generate multi-scene videos from a single narrative prompt

- **Audio Generation**: Create synchronized sound effects and ambient audio alongside your video

- **First & Last Frame Control**: Specify both start and end frames for precise scene transitions


## Two ways to get started

Video generation is in beta and currently available for Pro and Enterprise plans and paid AI Gateway users.

- **AI SDK 6**: Generate videos programmatically AI SDK 6's `generateVideo`.


```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v2.6-t2v',

5  prompt: 'A chef plates a dessert with caramel drizzle. Kitchen ambiance.',

6});
```

- **Gateway Playground**: Experiment with video models with no code in the configurable [AI Gateway playground](https://vercel.com/ai-gateway/models/kling-v3.0-t2v) that's embedded in each model page. Compare providers, tweak prompts, and download results without writing code. To access, click any video gen model in the [model list](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=klingai).


## Available Models

|     |     |     |
| --- | --- | --- |
| Model | Type | Description |
| `klingai/kling-v3.0-t2v` | Text-to-Video | Latest generation, highest quality with multishot support |
| `klingai/kling-v3.0-i2v` | Image-to-Video, First-and-Last-Frame | Animate images with v3 quality and multiple frames |
| `klingai/kling-v2.6-t2v` | Text-to-Video | Audio generation support |
| `klingai/kling-v2.6-i2v` | Image-to-Video, First-and-Last-Frame | Use images as reference |
| `klingai/kling-v2.5-turbo-t2v` | Text-to-Video | Faster generation |
| `klingai/kling-v2.5-turbo-i2v` | Image-to-Video, First-and-Last-Frame | Faster generation |

## Simple: Text-to-Video with Audio

Generate a video from a text description.

In this example, model `klingai/kling-v3.0-t2v` is used to generate a video of a cherry blossom tree with no inputs other than a simple text prompt.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v3.0-t2v',

5  prompt:

6   `Cherry blossom petals falling in slow motion through golden sunlight,

7    Japanese garden with a stone lantern, peaceful atmosphere, cinematic`,

8  aspectRatio: '16:9',

9  duration: 5,

10  providerOptions: {

11    klingai: {

12      mode: 'pro',

13    },

14  },

15});
```

## Advanced: Multishot Video

Generate a narrative video with multiple scenes with only a single prompt. Using Kling 3.0's multishot feature, the model intelligently cuts between shots to tell a complete story:

The prompt is written as a narrative with multiple distinct scenes for the best results. `shotType: 'intelligence'` lets the model decide optimal shot composition and `sound: 'on'` generates synchronized audio for the entire video. Note that the prompt here is in the `providerOptions` since this functionality is specific to Kling. The Kling 3.0 models support this functionality: here `klingai/kling-v3.0-t2v` is used.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v3.0-t2v',

5  prompt: '',

6  aspectRatio: '16:9',

7  duration: 10,

8  providerOptions: {

9    klingai: {

10      mode: 'pro',

11      multiShot: true,

12      shotType: 'intelligence',

13      prompt:

14       `Elephants walk across a golden savanna under gathering storm clouds.

15        Lightning cracks in the distance. Rain begins to fall heavily.

16        The herd finds shelter under acacia trees.

17        The storm clears revealing a double rainbow.`,

18      sound: 'on',

19    },

20  },

21});
```

## Advanced: First & Last Frame Control

Control exactly how your video starts and ends by providing both a first frame and last frame image. This is perfect for time-lapse effects or precise scene transitions:

These 2 images were provided as start and end frames.

![](images/kling-video-models-on-ai-gateway-vercel/img_001.jpg)

Using AI SDK 6, you can set `image` and `lastFrameImage` with your start and end frames. In this example, `klingai/kling-v3.0-i2v` is used for the model.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



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

13    klingai: {

14      lastFrameImage: endImage,

15      mode: 'pro',

16    },

17  },

18});
```

## Learn More

For more examples and detailed configuration options for Kling models, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).