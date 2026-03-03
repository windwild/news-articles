---
title: "Mistral Large 3 now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/mistral-large-3-now-available-on-vercel-ai-gateway"
date: "2025-12-02"
scraped_at: "2026-03-02T09:24:31.098997397+00:00"
language: "en"
translated: false
description: "You can now access Mistral's latest model, Mistral Large 3, on Vercel AI Gateway with no other provider accounts required."
---




Dec 2, 2025

You can now access Mistral's latest model Mistral Large 3 via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. Mistral Large 3 is Mistral's most capable model to date. It has a sparse mixture-of-experts architecture with 41B active parameters (675B total), and is Mistral’s first mixture-of-experts model since the Mixtral series.

To use Mistral Large 3, set `model` to `mistral/mistral-large-3` in the [AI SDK](https://ai-sdk.dev/).

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'mistral/mistral-large-3',

5  prompt: 'What are the most important things to consider when using OSS models?',

6});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use the model directly in our [model playground](https://vercel.com/ai-gateway/models/mistral-large-3).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)