---
title: "Video Generation with AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/video-generation-with-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:26.187280387+00:00"
language: "en"
translated: false
description: "Build video generation into your apps with AI Gateway. Create product videos, dynamic content, and marketing assets at scale."
---




Feb 19, 2026

AI Gateway now supports video generation, so you can create cinematic videos with photorealistic quality, synchronized audio, generate personalized content with consistent identity, all through AI SDK 6.

## Two ways to get started

Video generation is in beta and currently available for Pro and Enterprise plans and paid AI Gateway users.

- **AI SDK 6**: Generate videos programmatically with the same interface you use for text and images. One API, one authentication flow, one observability dashboard across your entire AI pipeline.


```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'xai/grok-imagine-video',

5  prompt: 'A golden retriever catching a frisbee mid-air at the beach',

6});
```

- **AI Gateway Playground**: Experiment with video models with no code in the configurable [AI Gateway playground](https://vercel.com/ai-gateway/models/grok-imagine-video) that's embedded in each model page. Compare providers, tweak prompts, and download results without writing code. To access, click any video gen model in the [model list](https://vercel.com/ai-gateway/models?capabilities=video-generation).


## Four initial video models; 17 variations

- **Grok Imagine** from xAI is fast and great at instruction following. Create and edit videos with style transfer, all in seconds.

- **Wan** from Alibaba specializes in reference-based generation and multi-shot storytelling, with the ability to preserve identity across scenes.

- **Kling** excels at image to video and native audio. The new 3.0 models support multishot video with automatic scene transitions.

- **Veo** from Google delivers high visual fidelity and physics realism. Native audio generation with cinematic lighting and physics.


## Understanding video requests

Video models require more than just describing what you want. Unlike image generation, video prompts can include motion cues (camera movement, object actions, timing) and optionally audio direction. Each provider exposes different capabilities through `providerOptions` that unlock fundamentally different generation modes. See the [documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation) for model-specific options.

## Generation types

AI Gateway initially supports 4 types of video generation:

|     |     |     |     |
| --- | --- | --- | --- |
| **Type** | **Inputs** | **Description** | **Example use cases** |
| Text-to-video | Text prompt | Describe a scene, get a video | Ad creative, explainer videos, social content |
| Image-to-video | Image, text prompt optional | Animate a still image with motion | Product showcases, logo reveals, photo animation |
| First and last frame | 2 images, text prompt optional | Define start and end states, model fills in between | Before/after reveals, time-lapse, transitions |
| Reference-to-video | Images or videos | Extract a character from reference images or videos and place them in new scenes | Spokesperson content, consistent brand characters |

Across the model creators, their current capabilities across the models on AI Gateway are listed below:

|     |     |
| --- | --- |
| **Model Creator** | **Capabilities** |
| xAI | Text-to-video, image-to-video, video editing, audio |
| Wan | Text-to-video, image-to-video, reference-to-video, audio |
| Kling | Text-to-video, image-to-video, first and last frame, audio |
| Veo | Text-to-video, image-to-video, audio |

## Text-to-video

Describe what you want, get a video. The model handles visuals, motion, and optionally audio. Great for hyperrealistic, production-quality footage with just a simple text prompt.

**Example: Programmatic video at scale.** Generate videos on demand for your app, platform, or content pipeline. No licencing fees or production required, just prompts and outputs.

This example uses `klingai/kling-v2.6-t2v` to generate video from a text prompt with a specified aspect ratio and duration.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v2.6-t2v',

5  prompt: `Wide shot of a rocket lifting off from launch pad at dawn.

6    Massive plume of orange fire and white smoke billows outward

7    from the base. The rocket rises slowly at first, engines blazing,

8    then accelerates upward. Pink and orange sunrise sky

9    in the background. Ocean visible in the distance.`,

10  aspectRatio: '16:9',

11  duration: 5,

12  providerOptions: {

13    klingai: {

14      mode: 'pro',

15      sound: 'on',

16    },

17  },

18});
```

**Example: Creative content generation.** Turn a simple prompt into polished video clips for social media, ads, or storytelling with natural motion and cinematic quality.

By setting a very specific and descriptive prompt, `google/veo-3.1-generate-001` generates video with immense detail and the exact desired motion.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



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

Provide a starting image and animate it. Control the initial composition, then let the model generate motion.

**Example: Animate product images.** Turn existing product photos into interactive videos.

The `klingai/kling-v2.6-i2v` model animates a product image after you pass an image URL and motion description in the prompt.

```tsx
iconst { videos } = await generateVideo({

2  model: 'klingai/kling-v2.6-i2v',

3  prompt: {

4    image: blackHoodie,

5    text: `The orange tabby cat walks slowly across the black hoodie.

6      Warm natural light. Cozy lifestyle scene. Smooth, cinematic.`,

7  },

8  duration: 5,

9  providerOptions: {

10    klingai: { mode: 'pro' },

11  },

12});
```

**Example: Animated illustrations.** Bring static artwork to life with subtle motion. Perfect for thematic content or marketing at scale.

**Example: Lifestyle and product photography.** Add subtle motion to food, beverage, or lifestyle shots for social content.

![](images/video-generation-with-ai-gateway-vercel/img_001.jpg)

Here, a picture of coffee is rendered for a more interactive video, with lighting direction and minute details.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



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

## First and last frame

Define the start and end states, and the model generates a seamless transition between them.

**Example: Before/after reveals.** Outfit swaps, product comparisons, changes over time. Upload two images, get a seamless transition.

The start and end states are defined here with two images that used in the prompt and provider options.

![](images/video-generation-with-ai-gateway-vercel/img_002.jpg)

In this example, `klingai/kling-v3.0-i2v` lets you define the start frame in `image` and the end frame in `lastFrameImage`. The model generates the transition between them.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'klingai/kling-v3.0-i2v',

5  prompt: {

6    image: startFrameDataUrl, // Empty room

7    text: `Smooth cinematic transition: The empty loft fills with furniture.

8      A green velvet sofa fades into view, followed by a wooden coffee table.

9      Potted plants rise from the floor. A patterned rug materializes.

10      Framed artwork appears on the walls. Bookshelves on the back wall.

11      Gentle, seamless transformation.`,

12  },

13  duration: 5,

14  providerOptions: {

15    klingai: {

16      lastFrameImage: endFrameDataUrl, // Furnished room

17      mode: 'std',

18    },

19  },

20});
```

## Reference-to-video

Provide reference videos or images of a person/character, and the model extracts their appearance and voice to generate new scenes starring them with consistent identity.

In this example, 2 reference images of dogs are used to generate the final video.

![](images/video-generation-with-ai-gateway-vercel/img_003.jpg)

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

## Video Editing

Transform existing videos with style transfer. Provide a video URL and describe the transformation you want. The model applies the new style while preserving the original motion.

Here, `xai/grok-imagine-video` utilizes a source video from a previous generation to edit into a watercolor style.

```tsx
import { experimental_generateVideo as generateVideo } from 'ai';



const { videos } = await generateVideo({

4  model: 'xai/grok-imagine-video',

5  prompt: `Transform into watercolor painting style, soft flowing brushstrokes,

6   paint bleeding at edges, delicate washes of color, artistic and dreamlike`,

7  providerOptions:

8    xai: {

9      videoUrl: dogVideo,

10    },

11  },

12});
```

## Get started

For more examples and detailed configuration options for video models, check out the [Video Generation Documentation](https://vercel.com/docs/ai-gateway/capabilities/video-generation). You can also find simple getting started scripts with the [Video Generation Quick Start](https://vercel.com/docs/ai-gateway/getting-started/video).

Check out the changelogs for these video models for more detailed examples and prompts.

- [Grok Imagine](https://vercel.com/changelog/grok-imagine-video-on-ai-gateway)

- [Alibaba Wan](https://vercel.com/changelog/wan-models-on-ai-gateway)

- [Veo](https://vercel.com/changelog/veo-video-models-on-ai-gateway)

- [Kling](https://vercel.com/changelog/kling-video-models-on-ai-gateway)