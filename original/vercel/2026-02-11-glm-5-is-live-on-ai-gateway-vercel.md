---
title: "GLM-5 is live on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/glm-5-is-live-on-ai-gateway"
date: "2026-02-11"
scraped_at: "2026-03-02T09:21:33.128389995+00:00"
language: "en"
translated: false
description: "You can now access Z.AI's latest model, GLM 5, via Vercel's AI Gateway with no other provider accounts required."
---




Feb 11, 2026

You can now access GLM-5 via [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

GLM-5 from Z.AI is now available on AI Gateway. Compared to GLM-4.7, GLM-5 adds multiple thinking modes, improved long-range planning and memory, and better handling of complex multi-step agent tasks. It's particularly strong at agentic coding, autonomous tool use, and extracting structured data from documents like contracts and financial reports.

To use this model, set model to `zai/glm-5` in the AI SDK:

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'zai/glm-5',

5  prompt:

6    `Generate a complete REST API with authentication,

7     database models, and test coverage for a task management app.`,

8});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/glm-5).