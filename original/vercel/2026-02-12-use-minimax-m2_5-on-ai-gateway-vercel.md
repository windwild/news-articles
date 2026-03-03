---
title: "Use MiniMax M2.5 on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/use-minimax-m2-5-on-ai-gateway"
date: "2026-02-12"
scraped_at: "2026-03-02T09:21:32.536081625+00:00"
language: "en"
translated: false
description: "You can now access MiniMax M2.5 through Vercel's AI Gateway with no other provider accounts required."
---




Feb 12, 2026

MiniMax M2.5 is now available on AI Gateway.

M2.5 plans before it builds, breaking down functions, structure, and UI design before writing code. It handles full-stack projects across Web, Android, iOS, Windows, and Mac, covering the entire development lifecycle from initial system design through code review. Compared to M2.1, it adapts better to unfamiliar codebases and uses fewer search rounds to solve problems.

To use this model, set model to `minimax/minimax-m2.5` in the AI SDK:

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'minimax/minimax-m2.5',

5  prompt:

6    `Design and implement a multi-tenant SaaS authentication system

7     with role-based access control, supporting OAuth providers

8     and API key management.`,

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/minimax-m2.5).