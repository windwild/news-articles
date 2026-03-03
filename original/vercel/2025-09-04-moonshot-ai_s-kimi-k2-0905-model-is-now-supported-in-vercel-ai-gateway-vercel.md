---
title: "Moonshot AI's Kimi K2 0905 model is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/moonshot-ais-kimi-k2-0905-model-is-now-supported-in-vercel-ai-gateway"
date: "2025-09-04"
scraped_at: "2026-03-02T09:29:40.127027898+00:00"
language: "en"
translated: false
description: "You can now access Kimi K2 0905 from Moonshot AI using Vercel AI Gateway, with no Moonshot AI account required."
---




Sep 4, 2025

You can now access [Kimi K2 0905](https://github.com/MoonshotAI/Kimi-K2), a new model from [Moonshot AI](https://www.moonshot.ai/) focused on agentic coding with a 256K context window, using Vercel [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK v5](https://ai-sdk.dev/docs/introduction), start by installing the package:

```bash
pnpm i ai
```

Then set the model to `moonshotai/kimi-k2-0905`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'moonshotai/kimi-k2-0905',

5  prompt: 'How is a trillion parameter oss model possible?'

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

To deliver high performance to Kimi K2, AI Gateway leverages multiple model providers under the hood, including direct to Moonshot AI, Groq, and Fireworks AI.

Learn more about [AI Gateway](https://vercel.com/ai-gateway).