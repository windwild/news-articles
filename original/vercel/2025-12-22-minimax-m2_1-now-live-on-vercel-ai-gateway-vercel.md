---
title: "MiniMax M2.1 now live on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/minimax-m2-1-now-live-on-vercel-ai-gateway"
date: "2025-12-22"
scraped_at: "2026-03-02T09:23:36.521516939+00:00"
language: "en"
translated: false
description: "You can now access the MiniMax M2.1 model on Vercel's AI Gateway with no other provider accounts required."
---




Dec 22, 2025

You can now access MiniMax's latest model, M2.1, with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required.

MiniMax M2.1 is faster than its predecessor M2, with clear improvements specifically in coding use cases and complicated multi-step tasks with tool calls. M2.1 writes higher quality code, is better at following instructions for difficult tasks, and has a cleaner reasoning process. The model has breadth in addition to depth, with improved performance across multiple coding languages (Go, C++, JS, C#, TS, etc.) and refactoring, feature adds, bug fixes, and code review.

To start building with MiniMax M2.1 via [AI SDK](https://ai-sdk.dev/), set the model to `minimax/minimax-m2.1`:

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'minimax/minimax-m2.1',

5  prompt:

6    `Initialize a React + TypeScript project of a sunrise.

7     Generate assets with an image tool, compute sun position

8     with a time tool, animate it, run tests, and produce a build.`

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/minimax-m2.1).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)