---
title: "Claude Haiku 4.5 now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-haiku-4-5-now-available-in-vercel-ai-gateway"
date: "2025-10-15"
scraped_at: "2026-03-02T09:27:08.423277986+00:00"
language: "en"
translated: false
description: "You can now access Claude Haiku 4.5 with Vercel's AI Gateway with no other provider accounts required."
---




Oct 15, 2025

You can now access Anthropic's latest model, Claude Haiku 4.5 using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. Haiku 4.5 matches Sonnet 4's performance on coding, computer use, and agent tasks at substantially lower cost and faster speeds.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), set the model to `anthropic/claude-haiku-4.5`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "anthropic/claude-haiku-4.5",

5  prompt: "Write me a haiku about Claude Haiku 4.5."

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

To deliver high performance and reliability to Claude Haiku 4.5, AI Gateway leverages multiple model providers under the hood, including Anthropic, Bedrock and Vertex AI.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway) or try it in our [model playground](https://vercel.com/ai-gateway/models/claude-haiku-4.5).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)