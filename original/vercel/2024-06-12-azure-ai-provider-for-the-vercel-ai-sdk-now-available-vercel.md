---
title: "Azure AI Provider for the Vercel AI SDK now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/azure-ai-provider-for-the-vercel-ai-sdk-now-available"
date: "2024-06-12"
scraped_at: "2026-03-02T09:44:00.698759093+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jun 12, 2024

The Vercel AI SDK now supports Azure AI services through [a new official provider](https://sdk.vercel.ai/providers/ai-sdk-providers/azure). To use the provider, install the relevant package:

```bash
pnpm install ai @ai-sdk/azure
```

You can then use the provider with all [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core/overview) methods. For example, here's how you can use it with `generateText`:

```javascript
import { azure } from '@ai-sdk/azure';

import { generateText } from 'ai';



const { text } = await generateText({

5  model: azure('your-deployment-name'),

6  prompt: 'Write a vegetarian lasagna recipe for 4 people.',

7});
```

Using the Azure provider with the Vercel AI SDK

For more information, [please see the documentation](https://sdk.vercel.ai/providers/ai-sdk-providers/azure).