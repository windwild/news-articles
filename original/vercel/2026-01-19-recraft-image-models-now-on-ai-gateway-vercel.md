---
title: "Recraft image models now on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/recraft-image-models-now-on-ai-gateway"
date: "2026-01-19"
scraped_at: "2026-03-02T09:22:22.744527414+00:00"
language: "en"
translated: false
description: "You can now access image models from Recraft in Vercel AI Gateway with no other provider accounts required."
---




Jan 19, 2026

Recraft models are now available via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. You can access Recraft's image models, V3 and V2.

These image models excel at photorealism, accurate text rendering, and complex prompt following. V3 supports long multi-word text generation with precise positioning, anatomical correctness, and native vector output. It includes 20+ specialized styles from realistic portraits to pixel art.

To use this model, set `model` to `recraft/recraft-v3` in the [AI SDK](https://ai-sdk.dev/). This model supports `generateImage`.

```tsx
import { generateImage } from 'ai';



const result = await generateImage({

4  model: 'recraft/recraft-v3',

5  prompt:

6    `A misty Japanese forest with ancient cedar trees, painted in the style of

7     traditional ukiyo-e woodblock prints with soft indigo and moss green tones.`,

8});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/recraft-v3).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)