---
title: "Cohere Provider for the Vercel AI SDK now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/cohere-provider-for-the-vercel-ai-sdk-now-available"
date: "2024-06-17"
scraped_at: "2026-03-02T09:43:28.053755594+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jun 17, 2024

The Vercel AI SDK now supports Cohere through [a new official provider](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere). To use the provider, install the relevant package:

```bash
pnpm install ai @ai-sdk/cohere
```

You can then use the provider with all [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core/overview) methods. For example, here's how you can use it with `generateText`:

```javascript
import { cohere } from '@ai-sdk/cohere';

import { generateText } from 'ai';



const { text } = await generateText({

5  model: cohere('command-r-plus'),

6  prompt: 'Write a vegetarian lasagna recipe for 4 people.',

7});
```

Using the Cohere provider with the Vercel AI SDK

For more information, [please see the documentation](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere).