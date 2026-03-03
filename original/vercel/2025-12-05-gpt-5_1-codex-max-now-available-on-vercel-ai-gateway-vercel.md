---
title: "GPT 5.1 Codex Max now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-1-codex-max-now-available-on-vercel-ai-gateway"
date: "2025-12-05"
scraped_at: "2026-03-02T09:24:42.573236464+00:00"
language: "en"
translated: false
description: "You can now access the GPT 5.1 Codex Max model with Vercel's AI Gateway with no other provider accounts required."
---




Dec 5, 2025

You can now access OpenAI's latest Codex models, GPT-5.1 Codex Max with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required.

Using a process called compaction, GPT-5.1 Codex Max has been trained to operate across multiple context windows and on real-world software engineering tasks. GPT-5.1 Codex Max is faster and more token efficient compared to previous Codex models, optimized for long-running coding tasks, and can maintain context and reasoning over long periods without needing to start new sessions.

To use GPT-5.1 Codex Max with the [AI SDK](https://ai-sdk.dev/), set the model to `openai/gpt-5.1-codex-max`.

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5.1-codex-max',

5  prompt:

6    `Write a CLI tool that scans web server logs, counts 5xx errors per endpoint,

7     and prints the ten endpoints with the most errors using only standard libraries.`

8  providerOptions: {

9    openai: {

10      reasoningSummary: "auto",

11      reasoningEffort: "low"

12    },

13  },

14});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.1-codex-max).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)