---
title: "Wan models on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/wan-models-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:26.658102907+00:00"
language: "en"
translated: false
description: "Generate stylized AI videos with Alibaba Wan models via the Vercel AI Gateway. Text-to-video, image-to-video, and unique style transfer (R2V) to transform existing footage into anime, watercolor, and ..."
---




Feb 19, 2026

Generate stylized videos and transform existing footage with Alibaba's Wan models, now available through AI Gateway. Try them out now via AI SDK 6 or by selecting the models in the AI Gateway playground.

Wan produces artistic videos with smooth motion and can use existing content to keep videos consistent:

- **Character Reference (R2V)**: Extract character appearance and voice from reference videos/images to generate new scenes

- **Flash Variants**: Faster generation times for quick iterations

- **Flexible Resolutions**: Support for 480p, 720p, and 1080p output


## Two ways to get started

Video generation is in beta and currently available for Pro and Enterprise plans and paid AI Gateway users.

- **AI SDK 6**: Generate videos programmatically AI SDK 6's `generateVideo`.


```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-t2v',

5  prompt: 'Watercolor painting of a koi pond coming to life.',

6});
```

- **Gateway Playground**: Experiment with video models with no code in the configurable [AI Gateway playground](https://vercel.com/ai-gateway/models/wan-v2.6-i2v) that's embedded in each model page. Compare providers, tweak prompts, and download results without writing code. To access, click any video gen model in the [model list](https://vercel.com/ai-gateway/models?capabilities=video-generation&providers=alibaba).


## Available Models

|     |     |     |
| --- | --- | --- |
| Model | Type | Description |
| `alibaba/wan-v2.6-t2v` | Text-to-Video | Generate videos from text prompts |
| `alibaba/wan-v2.6-i2v` | Image-to-Video | Animate still images |
| `alibaba/wan-v2.6-i2v-flash` | Image-to-Video | Fast image animation |
| `alibaba/wan-v2.6-r2v` | Reference-to-Video | Character transfer from references |
| `alibaba/wan-v2.6-r2v-flash` | Reference-to-Video | Fast style transfer |
| `alibaba/wan-v2.5-t2v-preview` | Text-to-Video | Previous version |

## Simple: Text-to-Video with Audio

Generate a stylized video from a text description.

You can use detailed prompts and specify styles with the Wan models to achieve the desired output generation. The example here uses `alibaba/wan-v2.6-t2v`:

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'alibaba/wan-v2.6-t2v',

5  prompt:

6   `Animated rainy Tokyo street at night, anime style,

7    neon signs reflecting on wet pavement, people with umbrellas

8    walking past, red and blue lights glowing through the rain.`,

9  resolution: '1280x720',

10  duration: 5,

11});
```

## Advanced: Reference-to-Video

Generate new scenes using characters extracted from reference images or videos.

In this example, 2 reference images of dogs are used to generate the final video.

![](images/wan-models-on-ai-gateway-vercel/img_001.jpg)

Using `alibaba/wan-v2.6-r2v-flash` here, you can instruct the model to utilize the people/characters within the prompt. Wan suggests using `character1`, `character2`, etc. in the prompt for multi-reference to video to get the best results.

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

11    alibaba: {

12      referenceUrls: [shibaImage, yorkieImage],

13    },

14  },

15});
```

## Learn More

For more examples and detailed configuration options for Wan models, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).