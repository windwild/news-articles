---
title: "OpenAI's GPT-OSS-Safeguard-20B now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openai-gpt-oss-safeguard-20b-now-available-in-vercel-ai-gateway"
date: "2025-10-29"
scraped_at: "2026-03-02T09:26:36.672616450+00:00"
language: "en"
translated: false
description: "You can now access OpenAI's GPT-OSS-Safeguard-20B with Vercel's AI Gateway with no other provider accounts required."
---




Oct 29, 2025

You can now access OpenAI's latest open source model, GPT-OSS-Safeguard-20B using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

GPT-OSS-Safeguard-20B is a fine-tuned version of its general-purpose GPT-OSS model, designed for developers to implement custom, policy-driven content moderation.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK](https://ai-sdk.dev/), set the model to `openai/gpt-oss-safeguard-20b`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-oss-safeguard-20b",

5  prompt: "Why are safety classification models important?"

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-oss-safeguard-20b).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)