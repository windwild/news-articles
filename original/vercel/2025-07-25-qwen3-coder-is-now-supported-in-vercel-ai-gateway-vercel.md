---
title: "Qwen3-Coder is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/qwen3-coder-is-now-supported-in-vercel-ai-gateway"
date: "2025-07-25"
scraped_at: "2026-03-02T09:30:48.693061052+00:00"
language: "en"
translated: false
description: "You can now access Qwen3 Coder, a model from QwenLM, an Alibaba Cloud company, designed to handle complex, multi-step coding workflows, using Vercel's AI Gateway with no other provider accounts requir..."
---




Jul 25, 2025

You can now access [Qwen3 Coder](https://github.com/QwenLM/Qwen3-Coder), a model from [QwenLM](https://qwenlm.github.io/), an Alibaba Cloud company, designed to handle complex, multi-step coding workflows, using Vercel's [AI Gateway](https://vercel.com/docs/ai-gateway) with no other provider accounts required.

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

```bash
pnpm i ai
```

Then set the model to `alibaba/qwen3-coder`:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "alibaba/qwen3-coder",

5  prompt: "What's your best argument for the health benefits of burritos?"

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

To deliver high performance and reliability to Qwen3 Coder, AI Gateway leverages multiple model providers under the hood, including Cerebras, DeepInfra, and Parasail.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway).