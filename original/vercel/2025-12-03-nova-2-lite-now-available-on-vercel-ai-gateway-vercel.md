---
title: "Nova 2 Lite now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/nova-2-lite-now-available-on-vercel-ai-gateway"
date: "2025-12-03"
scraped_at: "2026-03-02T09:24:46.838894618+00:00"
language: "en"
translated: false
description: "You can now access Amazon's latest model Nova 2 Lite on Vercel AI Gateway with no other provider accounts required."
---




Dec 3, 2025

You can now access Amazon's latest model Nova 2 Lite via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. Nova 2 Lite is a reasoning model for everyday workloads that can process text, images, and videos to generate text.

To use Nova 2 Lite, set `model` to `amazon/nova-2-lite` in the [AI SDK](https://ai-sdk.dev/). Extending thinking is disabled by default. To enable reasoning for this model, set `maxReasoningEffort` in the `providerOptions`. The reasoning content is redacted and displays as such, but users are still charged for these tokens.

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'amazon/nova-2-lite',

5  prompt:

6  `Derive a correct, optimal algorithm to detect all unique cycles in

7   a directed graph, explaining each logical step and validating edge cases.`,

8  providerOptions: {

9    bedrock: {

10      reasoningConfig: {

11        maxReasoningEffort: 'medium' // low, medium, or high accepted

12      },

13    },

14  },

15});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use the model directly in our [model playground](https://vercel.com/ai-gateway/models/nova-2-lite).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)