---
title: "Qwen 3.5 Plus is on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/qwen-3-5-plus-is-on-ai-gateway"
date: "2026-02-16"
scraped_at: "2026-03-02T09:21:31.828813843+00:00"
language: "en"
translated: false
description: "You can now access Alibaba's latest model, Qwen 3.5 Plus, via Vercel's AI Gateway with no other provider accounts required."
---




Feb 16, 2026

Qwen 3.5 Plus is now available on AI Gateway.

The model comes with a 1M context window and built-in adaptive tool use. Qwen 3.5 Plus excels at agentic workflows, thinking, searching, and using tools across multimodal contexts, making it well-suited for web development, frontend tasks, and turning instructions into working code. Compared to Qwen 3 VL, it delivers stronger performance in scientific problem solving and visual reasoning tasks.

To use this model, set model to `alibaba/qwen3.5-plus` in the AI SDK:

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'alibaba/qwen3.5-plus',

5  prompt:

6    `Analyze this UI mockup, extract the design system,

7     and generate a production-ready React component

8     with responsive breakpoints and theme support.`,

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/qwen3.5-plus).