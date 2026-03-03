---
title: "Claude Opus 4.5 now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-opus-4-5-now-available-in-vercel-ai-gateway"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:22.866353805+00:00"
language: "en"
translated: false
description: "You can now access Anthropic's latest model Claude Opus 4.5 in Vercel AI Gateway with no other provider accounts required."
---




Nov 24, 2025

You can now access Anthropic's latest model, Claude Opus 4.5, via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

Claude Opus 4.5 is suited for demanding reasoning tasks and complex problem solving. This model has improvements in general intelligence and vision compared to previous iterations. It excels at difficult coding tasks and agentic workflows, especially those with computer use and tool use, and can effectively handle context usage and external memory files. Frontend coding and design are established strengths, particularly for developing real-world web applications.

To use Claude Opus 4.5, set `model` to `anthropic/claude-opus-4.5` in the [AI SDK](https://ai-sdk.dev/). There is a new `effort` parameter for this model. This parameter affects all types of tokens and controls the level of token usage when responding to a request. By default, `effort` is set to high and is independent of the thinking budget. To use it in AI Gateway with the AI SDK, set `effort` for the provider in `providerOptions`, as seen below in the example.

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'anthropic/claude-opus-4.5',

5  prompt:

6  `Design and build a production-ready SaaS web app with

7   real-time analytics, feature flags, dashboards, alerts, RBAC,

8   integrations, accessibility, and performance optimization.`,

9  providerOptions: {

10    anthropic: {

11      effort: 'high',

12  },

13});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use Claude Opus 4.5 directly in our [model playground](https://vercel.com/ai-gateway/models/claude-opus-4.5).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)