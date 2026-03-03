---
title: "Gemini 3.1 Pro is live on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gemini-3-1-pro-is-live-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:28.501290730+00:00"
language: "en"
translated: false
description: "You can now access Google's newest model, Gemini 3.1 Pro Preview via Vercel's AI Gateway with no other provider accounts required."
---




Feb 19, 2026

Gemini 3.1 Pro Preview from Google is now available on AI Gateway.

This model release brings quality improvements across software engineering and agentic workflows, with enhanced usability for real-world tasks in finance and spreadsheet applications. Gemini 3.1 Pro Preview introduces more efficient thinking across use cases, reducing token consumption while maintaining performance.

To use this model, set model to `google/gemini-3.1-pro-preview` in the AI SDK. This model supports the `medium` thinking level for finer control over the trade-offs between cost, performance, and speed.

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3.1-pro-preview',

5  prompt:

6    `Review this pull request for security vulnerabilities,

7     suggest fixes, and update the test suite to cover edge cases.`,

8  providerOptions: {

9    google: {

10      thinking_level: 'medium',

11    },

12  },

13});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gemini-3.1-pro-preview).