---
title: "Qwen 3 Max Thinking now available on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/qwen-3-max-thinking-now-available-on-ai-gateway"
date: "2026-01-26"
scraped_at: "2026-03-02T09:22:14.171553882+00:00"
language: "en"
translated: false
description: "You can now access Qwen 3 Max Thinking via Vercel's AI Gateway with no other provider accounts required."
---




Jan 26, 2026

You can now access Qwen 3 Max Thinking via [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

Qwen 3 Max Thinking integrates thinking and non-thinking modes for improved performance on complex reasoning tasks. The model autonomously selects and uses its built-in search, memory, and code interpreter tools during conversations without requiring manual tool selection. The tools reduce hallucinations and provide real-time information.

To use this model, set model to `alibaba/qwen3-max-thinking` in the AI SDK:

```tsx
import { streamText } from 'ai'



const { textStream } = await streamText({

4  model: 'alibaba/qwen3-max-thinking',

5  prompt:

6   `Research a current topic, verify facts, remember a user preference,

7    and include a short code snippet to support the explanation.`,

8})
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/qwen-3-max-thinking).