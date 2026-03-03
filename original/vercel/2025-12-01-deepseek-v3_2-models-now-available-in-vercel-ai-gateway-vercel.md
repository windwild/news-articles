---
title: "DeepSeek V3.2 models now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deepseek-v3-2-now-in-vercel-ai-gateway"
date: "2025-12-01"
scraped_at: "2026-03-02T09:25:02.441224546+00:00"
language: "en"
translated: false
description: "You can now access the newest DeepSeek V3.2 models, V3.2 and V3.2 Speciale in Vercel AI Gateway with no other provider accounts required."
---




Dec 1, 2025

You can now access DeepSeek's latest models, DeepSeek V3.2 and DeepSeek V3.2 Speciale, via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

DeepSeek V3.2 supports combined thinking and tool use, handling agent-style operations (tool calls) in both reasoning and non-reasoning modes. DeepSeek V3.2 Speciale is optimized for maximal reasoning performance, and is suited for complex task use cases but requires higher token usage and does not support tool use.

To use the DeepSeek V3.2 models, set `model` to the following in the [AI SDK](https://ai-sdk.dev/):

- Non-thinking: `deepseek/deepseek-v3.2`

- Thinking: `deepseek/deepseek-v3.2-thinking`

- Speciale: `deepseek/deepseek-v3.2-speciale`


```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'deepseek/deepseek-v3.2-speciale',

5  prompt:

6  `Design a self-contained, step-by-step solution to a novel math–algorithm

7   hybrid problem: prove correctness, derive complexity, and construct

8   an optimal implementation for the general case.`,

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use DeepSeek V3.2 models directly in our [model playground](https://vercel.com/ai-gateway/models/deepseek-v3.2-speciale).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)