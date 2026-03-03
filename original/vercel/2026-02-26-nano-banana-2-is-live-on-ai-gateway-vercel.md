---
title: "Nano Banana 2 is live on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/nano-banana-2-is-live-on-ai-gateway"
date: "2026-02-26"
scraped_at: "2026-03-02T09:21:22.410752272+00:00"
language: "en"
translated: false
description: "You can now access Google's newest model, Gemini 3.1 Flash Image Preview (Nano Banana 2) via Vercel's AI Gateway with no other provider accounts required."
---




Feb 26, 2026

Gemini 3.1 Flash Image Preview (Nano Banana 2) is now available on AI Gateway.

This release improves visual quality while maintaining the generation speed and cost of flash-tier models.

Nano Banana 2 can use Google Image Search to ground outputs in real-world imagery. This helps with rendering lesser-known landmarks and objects by retrieving live visual data. This model also introduces configurable thinking levels (Minimal and High) to let the model reason through complex prompts before rendering. New resolutions and new aspect ratios (512p, 1:4 and 1:8) are available alongside the existing options to expand to support more types of creative assets.

To use this model, set model to `google/gemini-3.1-flash-image-preview` in the AI SDK. Nano Banana 2 is a multimodal model. Use \`streamText\` or \`generateText\` to generate images alongside text responses. This example shows how the model can use web search to find live data.

![](images/nano-banana-2-is-live-on-ai-gateway-vercel/img_001.jpg)

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3.1-flash-image-preview',

5  providerOptions: {

6    google: { responseModalities: ['TEXT', 'IMAGE'] },

7  },

8  prompt: 'Generate an image of the 2026 Super Bowl at golden hour',

9});
```

You can also change the thinking level: in this example, thinking is set to `high` for a more thorough response.

![](images/nano-banana-2-is-live-on-ai-gateway-vercel/img_002.jpg)

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3.1-flash-image-preview',

5  providerOptions: {

6    google: {

7      responseModalities: ['TEXT', 'IMAGE'],

8      thinkingConfig: {

9        includeThoughts: true,

10        thinkingLevel: 'high',

11      },

12    },

13  },

14  prompt:

15   `An exploded view diagram of a modern GPU, showing the die, HBM stacks, interposer,

16    and cooling solution as separate floating layers with labeled callouts.`,

17});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gemini-3.1-flash-image-preview).