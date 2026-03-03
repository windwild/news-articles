---
title: "gpt-oss-20b and gpt-oss-120b are now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-oss-20b-and-gpt-oss-120b-are-now-supported-in-vercel-ai-gateway"
date: "2025-08-05"
scraped_at: "2026-03-02T09:30:17.283758236+00:00"
language: "en"
translated: false
description: "You can now access gpt-oss by OpenAI, an open-weight reasoning model designed to push the open model frontier, using Vercel's AI Gateway with no other provider accounts required."
---




Aug 5, 2025

You can now access gpt-oss-20b and gpt-oss-120b by [OpenAI](https://openai.com/), open-weight reasoning models designed to push the open model frontier, using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

```bash
pnpm i ai
```

Then set the model to either `openai/gpt-oss-20b` or `openai/gpt-oss-120b`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-oss-120b", // or openai/gpt-oss-20b

5  prompt: "Generate an ansi animation of sutro tower"

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

To deliver high performance and reliability to gpt-oss, AI Gateway leverages multiple model providers under the hood, including Groq, Baseten, Cerebras, and Huggingface.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway) and view the [new AI Gateway model leaderboard](https://vercel.com/ai-gateway).

Vercel is a launch partner for the release of gpt-oss, and thank OpenAI for their collaboration in ensuring day 1 readiness for AI Gateway and its customers.

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)