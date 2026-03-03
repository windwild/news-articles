---
title: "Trinity Mini model now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/trinity-mini-model-now-available-in-vercel-ai-gateway"
date: "2025-12-01"
scraped_at: "2026-03-02T09:25:20.346121903+00:00"
language: "en"
translated: false
description: "You can now access the newest Arcee AI model Trinity Mini in Vercel AI Gateway with no other provider accounts required."
---




Dec 1, 2025

You can now access Arcee AI's latest model Trinity Mini via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. Trinity Mini is an open weight MoE reasoning model with 26B parameters (3B active) trained end-to-end in the U.S.

To use Trinity Mini, set `model` to `arcee-ai/trinity-mini` in the [AI SDK](https://ai-sdk.dev/).

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'arcee-ai/trinity-mini',

5  prompt:

6  `Generate a full reasoning chain that reconstructs how an unknown machine

7   operates solely from its final outputs, inferring internal mechanisms,

8   intermediate states, and causal links step by step.`,

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use the model directly in our [model playground](https://vercel.com/ai-gateway/models/trinity-mini).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)