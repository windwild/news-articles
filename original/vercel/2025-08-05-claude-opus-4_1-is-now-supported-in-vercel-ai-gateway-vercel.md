---
title: "Claude Opus 4.1 is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-4-1-opus-is-now-supported-in-vercel-ai-gateway"
date: "2025-08-05"
scraped_at: "2026-03-02T09:30:28.656991391+00:00"
language: "en"
translated: false
description: "You can now access Claude Opus 4.1, a new model released by Anthropic today, using Vercel's AI Gateway with no other provider accounts required."
---




Aug 5, 2025

You can now access [Claude Opus 4.1](https://www.anthropic.com/news/claude-opus-4-1), a new model released today, using Vercel's [AI Gateway](https://vercel.com/docs/ai-gateway) with no other provider accounts required. This release from Anthropic improves agentic task execution, real-world coding, and reasoning over the previous Opus 4 model.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

```bash
pnpm i ai
```

Then set the model to `anthropic/claude-4.1-opus`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "anthropic/claude-4.1-opus",

5  prompt: "what's the history of Taqueria La Cumbre in San Francisco?"

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

To deliver high performance and reliability to Claude Opus 4.1, AI Gateway leverages multiple model providers under the hood, including Anthropic and Bedrock.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway) and view the [new AI Gateway model leaderboard](https://vercel.com/ai-gateway).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)