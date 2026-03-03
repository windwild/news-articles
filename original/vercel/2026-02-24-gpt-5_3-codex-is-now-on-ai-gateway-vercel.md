---
title: "GPT 5.3 Codex is now on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-3-codex-is-now-on-ai-gateway"
date: "2026-02-24"
scraped_at: "2026-03-02T09:21:24.487692064+00:00"
language: "en"
translated: false
description: "You can now access OpenAI's newest model GPT 5.3 Codex via Vercel's AI Gateway with no other provider accounts required."
---




Feb 24, 2026

GPT 5.3 Codex is now available on AI Gateway. GPT 5.3 Codex brings together the coding strengths of GPT-5.2-Codex and the reasoning depth of GPT-5.2 in a single model that's 25% faster and more token-efficient.

Built for long-running agentic work, the model handles research, tool use, and multi-step execution across the full software lifecycle, from debugging and deployment to product documents and data analysis. Additionally, you can steer it mid-task without losing context. For web development, it better understands underspecified prompts and defaults to more functional, production-ready output.

To use this model, set model to `openai/gpt-5.3-codex` in the AI SDK.

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5.3-codex',

5  prompt:

6    `Research our current API architecture, identify performance

7     bottlenecks, refactor the slow endpoints, add monitoring,

8     and deploy the changes to staging.`,

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.3-codex).