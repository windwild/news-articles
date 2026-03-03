---
title: "Grok 3 now available on Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/grok-3-now-available-on-vercel-marketplace"
date: "2025-04-09"
scraped_at: "2026-03-02T09:34:48.047866421+00:00"
language: "en"
translated: false
description: "Grok 3 is now available on the Vercel Marketplace, allowing users to access xAI's latest large language models directly from their Vercel projects"
---




Apr 9, 2025

![](images/grok-3-now-available-on-vercel-marketplace-vercel/img_001.jpg)![](images/grok-3-now-available-on-vercel-marketplace-vercel/img_002.jpg)

xAI's latest and most powerful Grok 3 models are now available through the Vercel Marketplace, bringing state-of-the-art AI capabilities to your Vercel projects.

To get started, you can use the [AI SDK xAI provider](https://vercel.com/docs/ai/xai#getting-started) in your project:

```tsx
import { xai } from "@ai-sdk/xai";

import { streamtext } from "ai";



const result = streamText({

5  model: xai("grok-3-beta"),

6  prompt: "What is the meaning of life?",

7});



for await (const textPart of result.textStream) {

10  process.stdout.write(textPart); // The answer is 42.

11}
```

Then, [install the xAI Marketplace Integration](https://vercel.com/marketplace/xai) with Vercel CLI (or [from the dashboard](https://vercel.com/marketplace/xai)):

```bash
vercel install xai
```

Once you've accepted the terms, you'll be able to use Grok models from within your project, with no additional steps necessary.

To help you get started, we've also made a [ready-to-deploy Next.js xAI starter template](https://vercel.com/new/clone?project-name=Vercel+x+xAI+Chatbot&repository-name=ai-sdk-starter-xai&repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Fai-sdk-starter-xai&demo-title=Vercel+x+xAI+Chatbot&demo-url=https%3A%2F%2Fai-sdk-starter-xai.labs.vercel.dev%2F&demo-description=A+simple+chatbot+application+built+with+Next.js+that+uses+xAI+via+the+AI+SDK+and+the+Vercel+Marketplace&products=[{%22type%22:%22integration%22,%22protocol%22:%22ai%22,%22productSlug%22:%22grok%22,%22integrationSlug%22:%22xai%22}]). To learn more about xAI on Vercel, read our [announcement](https://vercel.com/blog/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers) and the [documentation](https://vercel.com/docs/ai/xai).