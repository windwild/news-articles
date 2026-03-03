---
title: "GPT 5.1 Codex models now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-1-codex-models-now-available-in-vercel-ai-gateway"
date: "2025-11-13"
scraped_at: "2026-03-02T09:25:42.656150976+00:00"
language: "en"
translated: false
description: "You can now access the two GPT 5.1 Codex models with Vercel's AI Gateway with no other provider accounts required."
---




Nov 13, 2025

You can now access OpenAI's latest Codex models, GPT-5.1 Codex and GPT-5.1 Codex mini with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required. These Codex models are optimized for long-running, agentic coding tasks and are able to maintain context and reasoning over longer sessions without degradation.

To use these models with the [AI SDK](https://ai-sdk.dev/), set the model to `openai/gpt-5.1-codex` or `openai/gpt-5.1-codex-mini`:

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5.1-codex',

5  prompt:

6    `Create a command-line tool that reads a text file,

7     counts word frequencies, and prints the ten most common

8     words with counts. Use standard libraries only.`

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.1-codex).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)