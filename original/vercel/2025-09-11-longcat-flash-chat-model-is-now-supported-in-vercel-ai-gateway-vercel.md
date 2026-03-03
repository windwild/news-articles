---
title: "LongCat-Flash Chat model is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/longcat-flash-chat-model-is-now-supported-in-vercel-ai-gateway"
date: "2025-09-11"
scraped_at: "2026-03-02T09:28:37.034198409+00:00"
language: "en"
translated: false
description: "You can now access LongCat-Flash Chat from Meituan using Vercel AI Gateway, with no Meituan account required."
---




Sep 11, 2025

You can now access LongCat Flash Chat, a new model from Meituan focused on agentic tool use, using Vercel [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. The model dynamically activates parameters, based on contextual demands.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK v5](https://ai-sdk.dev/docs/introduction), start by installing the package:

```bash
pnpm i ai
```

Then set the model to `meituan/longcat-flash-chat`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'meituan/longcat-flash-chat',

5  prompt: 'How does dynamic parameter activation work for AI models?'

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/ai-gateway) and access the model [here](https://vercel.com/ai-gateway/models/longcat-flash-chat).