---
title: "Introducing AI Integrations on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-integrations"
date: "2024-02-08"
scraped_at: "2026-03-02T09:48:10.015051170+00:00"
language: "en"
translated: false
description: "AI Integrations on Vercel"
---




Feb 8, 2024

Incorporate AI models and services from industry-leading providers into your Vercel projects with just a few clicks.

Today, we’re launching **nine new AI integrations for Vercel** from leading AI companies.

We’ve also created a new **model playground** where you can try dozens of models instantly to generate text, images, audio, and more right in your dashboard.

![Explore and play with the popular AI models from various providers.](images/introducing-ai-integrations-on-vercel-vercel/img_001.jpg)![Explore and play with the popular AI models from various providers.](images/introducing-ai-integrations-on-vercel-vercel/img_002.jpg)Explore and play with the popular AI models from various providers.

## **Building the future with AI**

Vercel is the product infrastructure for [AI applications](https://vercel.com/ai).

From [chatbots](https://vercel.com/templates/next.js/nextjs-ai-chatbot) that augment customer service flows, to recommendation systems with semantic search, [Retrieval Augmented Generation (RAG)](https://vercel.com/guides/retrieval-augmented-generation), and generative image services—companies can build better product experiences faster than ever before with AI.

We've partnered with our first cohort of AI providers to speed up your product development process.

![Our first cohort of AI Integration partners, now available in the AI tab.](images/introducing-ai-integrations-on-vercel-vercel/img_003.jpg)![Our first cohort of AI Integration partners, now available in the AI tab.](images/introducing-ai-integrations-on-vercel-vercel/img_004.jpg)Our first cohort of AI Integration partners, now available in the AI tab.

_**"We're excited to partner with Vercel on bringing the latest state of the art open source machine learning models to more AI Engineers. We believe that AI should be easy to run and integrate into any web application."**_— Replicate Software Engineer, Charlie Holtz

## Connecting to models with the AI SDK

After you've integrated with an AI provider, you can then quickly get started using the model in your frontend application using the [Vercel AI SDK](https://sdk.vercel.ai/docs). This SDK is like an ORM for any AI model you want to use, whether it's for text, images, and soon audio.

For example, if you want to use the Perplexity API with Next.js, it only takes the following code to stream back responses to your frontend:

app/api/chat/route.ts

```tsx
import { OpenAIStream, StreamingTextResponse } from 'ai';

import OpenAI from 'openai';



const perplexity = new OpenAI({

5  apiKey: process.env.PERPLEXITY_API_KEY || '',

6  baseUrl: 'https://api.perplexity.ai',

7});



export async function POST(req: Request) {

10  const { messages } = await req.json();



12  // Generated a chat completion based on the prompt

13  const response = await perplexity.chat.completions.create({

14    model: 'pplx-7b-chat',

15    stream: true,

16    messages: messages,

17  });



19  // Convert the response into a friendly text-stream

20  const stream = OpenAIStream(response);



22  // Respond with the stream

23  return new StreamingTextResponse(stream);

24}
```

Using the Perplexity API with the Next.js App Router.

[Learn more about the AI SDK](https://sdk.vercel.ai/docs) or follow the instructions after connecting to your provider of choice.

### **Get Started Today**

The future of application development is intelligent, intuitive, and immersive. With Vercel's AI Integrations, you're not just building applications; you're crafting experiences that anticipate and adapt to user needs in real-time.

If you’re an AI company or developer keen to join our AI Integrations, you can [create your own integration](https://vercel.com/docs/integrations/create-integration).

Check out the new tab in your Vercel dashboard and [add AI to your app today](https://vercel.com/docs/integrations/ai).

[**Start building today**\\
\\
Explore, preview, and seamlessly integrate AI models and databases into your Vercel projects. \\
\\
Get Started](https://vercel.com/docs/integrations/ai)