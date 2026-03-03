---
title: "Veo video models on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/veo-video-models-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:27.341116407+00:00"
language: "en"
translated: false
description: "Generate photorealistic AI videos with the Veo models via Vercel AI Gateway. Text-to-video and image-to-video with native audio generation. Up to 4K resolution with fast mode options."
---




Feb 19, 2026

Generate photorealistic videos with synchronized audio using Google's Veo models, now available through AI Gateway. Try them out now via AI SDK 6 or by selecting the models in the AI Gateway playground.

Veo models are known for their cinematic quality and audio generation:

- **Native Audio Generation:** Automatically generate realistic sound effects, ambient audio, and even dialogue that matches your video

- **Up to 1080p Resolution:** Generate videos at 720p and 1080p

- **Photorealistic Quality:** Realism for nature, wildlife, and cinematic scenes

- **Image-to-Video:** Animate still photos with natural motion

- **Fast Mode:** Quicker generation when you need rapid iterations


## Two ways to get started

Video generation is in beta and currently available for Pro and Enterprise plans and paid AI Gateway users.

- **AI SDK 6**: Generate videos programmatically AI SDK 6's `generateVideo`.


```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'google/veo-3.1-generate-001',

5  prompt: 'Woman sipping coffee by a rain-streaked window, cozy morning light.',

6});
```

- **Gateway Playground**: Experiment with video models with no code in the configurable [AI Gateway playground](https://vercel.com/ai-gateway/models/veo-3.1-generate-001) that's embedded in each model page. Compare providers, tweak prompts, and download results without writing code. To access, click any video gen model in the [model list](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=vertex).


## Available Models

|     |     |
| --- | --- |
| Model | Description |
| `google/veo-3.1-generate-001` | Latest generation, highest quality |
| `google/veo-3.1-fast-generate-001` | Fast mode for quicker iterations |
| `google/veo-3.0-generate-001` | Full quality generation |
| `google/veo-3.0-fast-generate-001` | Fast mode generation |

## Simple: Text-to-Video with Audio

Describe a scene and get a video.

Generate a cinematic wildlife video with natural sound: here `google/veo-3.1-generate-001` is used with `generateAudio: true`.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'google/veo-3.1-generate-001',

5  prompt:

6   `Close-up of a great horned owl

7    turning its head slowly in a moonlit forest.`,

8  aspectRatio: '16:9',

9  providerOptions: {

10    vertex: { generateAudio: true },

11  },

12});
```

## Advanced: Image-to-Video with Dialog

A common workflow to ensure quality is generating a custom image with Gemini 3 Pro Image (Nano Banana Pro), then bringing it to life with Veo, complete with motion and spoken dialog.

Starting image from Nano Banana Pro:

![](images/veo-video-models-on-ai-gateway-vercel/img_001.jpg)

Use prompts with image input with the Veo models for more control over the output. This example uses `google/veo-3.1-generate-001`, which supports image to video.

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

11  },

12  aspectRatio: '16:9',

13  duration: 4,

14  providerOptions: {

15    vertex: { generateAudio: true },

16  },

17});
```

## Learn More

For more examples and detailed configuration options for Veo models, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).