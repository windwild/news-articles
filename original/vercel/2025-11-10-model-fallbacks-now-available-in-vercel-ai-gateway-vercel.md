---
title: "Model fallbacks now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/model-fallbacks-now-available-in-vercel-ai-gateway"
date: "2025-11-10"
scraped_at: "2026-03-02T09:25:40.124464861+00:00"
language: "en"
translated: false
description: "Model fallbacks now supported in Vercel AI Gateway in addition to provider routing, giving you failover options when models fail or are unavailable."
---




Nov 10, 2025

Vercel's [AI Gateway](https://vercel.com/ai-gateway) now supports [fallback models](https://vercel.com/docs/ai-gateway/provider-options#model-fallbacks-with-the-models-option) for when models fail or are unavailable. In addition to safeguarding against provider-level failures, model fallbacks can help with errors and capability mismatches between models (e.g., multimodal, tool-calling, etc.).

Fallback models will be tried in the specified order until a request succeeds or no options remain. Any error, such as context limits, unsupported inputs, or provider outages, can trigger a fallback. Requests are billed based on the model that completes successfully.

This example shows an instance where the primary model does not support multimodal capabilities, falling back to models that do. To use, specify the model fallbacks in `models` within `providerOptions`:

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-oss-120b', // Primary model

5  prompt: 'Parse the attached PDF for tables and graphs, \

6  and return the highest performing categories this year',

7  providerOptions: {

8    gateway: {

9      models: [\
\
10        'google/gemini-2.5-pro',\
\
11        'anthropic/claude-sonnet-4.5',\
\
12        'meta/llama-3.1-8b'\
\
13      ], // Fallback models

14    },

15  },

16})
```

To have pre-defined provider routing in addition to model routing, specify both `models` and providers (`order` or `only`) in `providerOptions`:

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5-nano', // Primary model

5  prompt: 'Parse the attached PDF for tables and graphs, \

6  and return the highest performing categories this year',

7  providerOptions: {

8    gateway: {

9      order: ['vertex', 'cerebras'], // Provider routing order

10      models: [\
\
11        'google/gemini-2.5-flash',\
\
12        'openai/gpt-oss-120b'\
\
13      ], // Fallback models

14    },

15  },

16})
```

AI Gateway also includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and supports [OpenAI-compatible API](https://vercel.com/docs/ai-gateway/openai-compat#model-fallbacks).