---
title: "Gemini 3 Flash is now available on the Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gemini-3-flash-is-now-available-on-the-vercel-ai-gateway"
date: "2025-12-17"
scraped_at: "2026-03-02T09:23:45.183982528+00:00"
language: "en"
translated: false
description: "You can now access the Gemini 3 Flash model on Vercel's AI Gateway with no other provider accounts required."
---




Dec 17, 2025

You can now access Google's latest Gemini model, Gemini 3 Flash, with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required.

It is Google's most intelligent model that is optimized for speed, with Gemini 3's pro-grade reasoning alongside flash-level latency, efficiency, and cost. Gemini 3 Flash significantly outperforms the previous Gemini 2.5 models, beating Gemini 2.5 Pro across most benchmarks, while using 30% less tokens and is 3x faster at a fraction of the cost.

To use the Gemini 3 Flash with the [AI SDK](https://ai-sdk.dev/), set the model to `google/gemini-3-flash`:

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3-flash',

5  prompt:

6    `Produce a step-by-step analysis that solves a novel

7     problem, exposes intermediate logic, and delivers a final answer

8     using minimal tokens and maximal inference density.`

9  providerOptions: {

10    google: {

11      thinkingLevel: 'high',

12      includeThoughts: true

13    },

14  },

15});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gemini-3-flash).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)