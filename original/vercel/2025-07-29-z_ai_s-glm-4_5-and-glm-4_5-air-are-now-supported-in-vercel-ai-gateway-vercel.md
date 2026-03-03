---
title: "Z.ai's GLM-4.5 and GLM-4.5 Air are now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/z-ais-glm-4-5-and-glm-4-5-air-are-now-supported-in-vercel-ai-gateway"
date: "2025-07-29"
scraped_at: "2026-03-02T09:30:41.143520611+00:00"
language: "en"
translated: false
description: "You can now access GLM-4.5 and GLM-4.5 Air, new flagship models from Z.ai designed to unify frontier reasoning, coding, and agentic capabilities, using Vercel's AI Gateway with no other provider accou..."
---




Jul 29, 2025

You can now access [GLM-4.5 and GLM-4.5 Air](https://z.ai/blog/glm-4.5), new flagship models from [Z.ai](https://z.ai/) designed to unify frontier reasoning, coding, and agentic capabilities, using Vercel's [AI Gateway](https://vercel.com/docs/ai-gateway) with no other provider accounts required.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

```bash
pnpm i ai
```

Then set the model to either `zai/glm-4.5` or `zai/glm-4.5-air`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "zai/glm-4.5", // or "zai/glm-4.5-air"

5  prompt: "What is specifically notable about the style of Sonoran food?",

6  providerOptions: {

7    zai: {

8      thinking: {

9        type: 'disabled',

10      },

11    },

12  }

13})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway).