---
title: "GPT-5, GPT-5-mini, and GPT-5-nano are now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-gpt-5-mini-and-gpt-5-nano-are-now-available-in-vercel-ai-gateway"
date: "2025-08-07"
scraped_at: "2026-03-02T09:30:11.125294911+00:00"
language: "en"
translated: false
description: "You can now access the gpt-5 models by OpenAI, their most advanced models pushing the frontier of reasoning and domain expertise, using Vercel's AI Gateway with no other provider accounts required."
---




Aug 7, 2025

You can now access GPT-5, GPT-5-mini, and GPT-5-nano by [OpenAI](https://openai.com/), models designed to push the frontier of reasoning and domain expertise, using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

```bash
pnpm i ai
```

Then set the model to either `openai/gpt-5 or``openai/gpt-5-mini or openai/gpt-5-nano`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-5", // or openai/gpt-5-mini or openai/gpt-5-nano

5  prompt: "Generate an ansi animation of sutro tower"

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway) and view the [new AI Gateway model leaderboard](https://vercel.com/ai-gateway).

Vercel is a launch partner for the release of gpt-5 models, and thank OpenAI for their collaboration in ensuring day 1 readiness for AI Gateway and its customers.

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)