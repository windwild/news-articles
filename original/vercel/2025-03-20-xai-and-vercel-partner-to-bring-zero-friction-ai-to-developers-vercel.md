---
title: "xAI and Vercel partner to bring zero-friction AI to developers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers"
date: "2025-03-20"
scraped_at: "2026-03-02T09:35:21.462225332+00:00"
language: "en"
translated: false
description: "Vercel partners with xAI to bring Grok models directly to your Vercel projects through the Vercel Marketplace—and soon v0—with no additional signup required. xAI adds a new free tier through Verce..."
---




Mar 20, 2025

Use xAI's Grok models across Vercel, the AI SDK, and v0

Vercel provides the tools and infrastructure to build AI-native web applications. We're partnering with [xAI](https://x.ai/) to bring their powerful Grok models directly to Vercel projects through the [Vercel Marketplace](https://vercel.com/marketplace/xai)—and soon [v0](https://v0.dev/)—with no additional signup required.

To help you get started, xAI is introducing a new free tier through Vercel to enable quick prototyping and experimentation. These Grok models now power our official [Next.js AI chatbot template](https://vercel.com/templates/next.js/nextjs-ai-chatbot) with the [AI SDK](https://sdk.vercel.ai/).

This is a part of our ongoing effort to make using AI frictionless on Vercel.

![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_001.jpg)![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_002.jpg)

## The Vercel Marketplace

With [Grok models now available](https://vercel.com/marketplace/xai) from the Vercel Marketplace, developers can build with xAI’s conversational models quickly.

![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_003.jpg)![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_004.jpg)

- Get started with xAI's free plan—no additional signup through the Marketplace

- Access Grok's large language models (LLMs) directly from your Vercel projects

- Simplify authentication and API key management through automatically configured environment variables

- Pay only for what you use with integrated billing through Vercel


If you're already working in a Vercel project, you can also install xAI through the Marketplace from the Vercel CLI:

```bash
vercel install xai
```

[**Explore AI on the Vercel Marketplace**\\
\\
Play, test, and integrate with a wide range of AI model types, sizes, and specializations in the Vercel Marketplace.\\
\\
Get started](https://vercel.com/marketplace?category=ai)

## More ways to get started with AI

We've streamlined AI experimentation and development through the AI SDK, ready-to-use templates, and our model playground.

### The Next.js AI Chatbot, now powered by xAI

The [Next.js AI Chatbot](https://github.com/vercel/ai-chatbot) is a free open-source chatbot template built by the creators of Next.js, AI SDK, and shadcn/ui. It features tool calling, retrieval, code execution, artifacts, and genUI examples—the UI infrastructure you need to build your own ChatGPT or [grok.com](http://grok.com/).

![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_005.jpg)![](images/xai-and-vercel-partner-to-bring-zero-friction-ai-to-developers-vercel/img_006.jpg)

### AI SDK

The [AI SDK](https://sdk.vercel.ai/docs) is a free open-source library that gives you the tools you need to build AI-powered products and agents. It offers a unified API for integrating almost any language model, so you can experiment, test, and change models and providers with just one or two lines of code.

```tsx
import { xai } from "@ai-sdk/xai";

import { streamtext } from "ai";



const result = streamText({

5  model: xai("grok-2-1212"),

6  prompt: "What is the meaning of life?",

7});



for await (const textPart of result.textStream) {

10  process.stdout.write(textPart); // The answer is 42.

11}
```

The AI SDK also has a [playground](https://sdk.vercel.ai/playground) where you can compare output from different models and providers. xAI is the default provider and you can compare xAI’s Grok models against others from Anthropic, Google, OpenAI, and many more.

## A peek at what's next

When you’re vibe coding with [v0](https://v0.dev/), you'll soon be able to leverage the xAI Vercel Marketplace integration right in v0's chat interface (which is currently possible with [Vercel Marketplace storage integrations](https://vercel.com/changelog/vercel-marketplace-integrations-now-available-in-v0)).

Soon, we'll be adding more AI integrations in the Vercel Marketplace. If you're a service provider interested in joining, you can reach out to us at integrations@vercel.com.

### Get started today

With xAI now in the Vercel Marketplace, developers have more flexibility to build AI-powered applications with industry-leading models. Whether you're integrating Grok into your chatbot, experimenting with new AI workflows and agents, or scaling existing workloads, Vercel makes it easy to start shipping.

[**Explore AI on Vercel**\\
\\
Vercel offers everything you need to get started with AI.\\
\\
Start building](https://vercel.com/ai)