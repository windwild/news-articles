---
title: "Llama 4 is now available on Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/llama-4-is-now-available-on-vercel-marketplace"
date: "2025-04-05"
scraped_at: "2026-03-02T09:35:27.447305299+00:00"
language: "en"
translated: false
description: "Llama 4 is now available on Vercel Marketplace via Groq to bring bring state-of-the-art AI capabilities like multimodal input to your Vercel projects. "
---




Apr 5, 2025

Meta’s latest and most powerful [Llama 4](https://www.llama.com/docs/model-cards-and-prompt-formats/llama4_omni/) models are now available through the Vercel Marketplace via [Groq](https://vercel.com/marketplace/groq).

To get started for free, [install the Groq integration](https://vercel.com/marketplace/groq) in the Vercel dashboard or add Groq to your existing projects with the Vercel CLI:

```bash
vercel install groq
```

You can then use the [AI SDK Groq provider](https://vercel.com/docs/ai/groq#getting-started) with Lama 4:

```tsx
import { groq } from '@ai-sdk/groq';

import { streamText } from 'ai';

import fs from 'fs'



const result = streamText({

6  model: groq('meta-llama/llama-4-scout-17b-16e-instruct'),

7  messages: [\
\
8    {\
\
9      role: 'user',\
\
10      content: [\
\
11        { type: 'text', text: 'Describe the image in detail.' },\
\
12        { type: 'image', image: fs.readFileSync('./data/llama.png') },\
\
13      ],\
\
14    },\
\
15  ],

16});



for await (const textPart of result.textStream) {

19  process.stdout.write(textPart);

20}
```

For a full demo, check out the [official Groq chatbot template](https://vercel.com/templates/next.js/vercel-x-groq-chatbot) (which now uses Llama 4) or compare Llama 4 against other models side-by-side on our [AI SDK Playground](https://sdk.vercel.ai/playground). To learn more, visit [our AI documentation](https://vercel.com/docs/ai/groq).