---
title: "Introducing the Vercel AI SDK: npm i ai - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-vercel-ai-sdk"
date: "2023-06-15"
scraped_at: "2026-03-02T09:52:06.610996214+00:00"
language: "en"
translated: false
description: "An interoperable, streaming-enabled, edge-ready software development kit for AI apps built with React and Svelte."
---




Jun 15, 2023

An interoperable, streaming-enabled, edge-ready software development kit for AI apps built with React and Svelte.

Over the past 6 months, AI companies like [Scale](https://scale.com/), [Jasper](https://www.jasper.ai/), [Perplexity](https://www.perplexity.ai/), [Runway](https://runwayml.com/), [Lexica](https://lexica.art/), and [Jenni](https://jenni.ai/) have launched with [Next.js](https://vercel.com/solutions/nextjs) and Vercel. Vercel helps accelerate your product development by enabling you to focus on creating value with your AI applications, rather than spending time building and maintaining infrastructure.

Today, we're launching new tools to improve the AI experience on Vercel.

- **Vercel AI SDK:** Easily stream API responses from AI models

- **Chat & Prompt Playground:** Explore models from [OpenAI](https://vercel.com/docs/integrations/openai), Hugging Face, and more


## The Vercel AI SDK

The [Vercel AI SDK](https://sdk.vercel.ai/) is an [open-source](https://github.com/vercel-labs/ai) library designed to help developers build conversational, streaming, and chat user interfaces in JavaScript and TypeScript. The SDK supports React/Next.js, Svelte/SvelteKit, with support for Nuxt/Vue coming soon.

To install the SDK, enter the following command in your terminal:

```bash
npm install ai
```

You can also [view the source code on GitHub](https://github.com/vercel-labs/ai).

### **Built-in LLM Adapters**

Choosing the right LLM for your application is crucial to building a great experience. Each has unique tradeoffs, and can be tuned in different ways to meet your requirements.

Vercel’s AI SDK embraces interoperability, and includes first-class support for [OpenAI](https://openai.com/), [LangChain](https://js.langchain.com/docs/), and [Hugging Face](https://huggingface.co/) Inference. This means that regardless of your preferred AI model provider, you can leverage the Vercel AI SDK to create cutting-edge streaming UI experiences.

```tsx
import { OpenAIStream, StreamingTextResponse } from 'ai'

import { Configuration, OpenAIApi } from 'openai-edge'



4// Create an OpenAI API client (that's edge friendly!)

const config = new Configuration({

6  apiKey: process.env.OPENAI_API_KEY

7})

const openai = new OpenAIApi(config)



10// IMPORTANT! Set the runtime to edge

export const runtime = 'edge'



export async function POST(req: Request) {

14  // Extract the `messages` from the body of the request

15  const { messages } = await req.json()



17  // Ask OpenAI for a streaming chat completion given the prompt

18  const response = await openai.createChatCompletion({

19    model: 'gpt-3.5-turbo',

20    stream: true,

21    messages

22  })

23  // Convert the response into a friendly text-stream

24  const stream = OpenAIStream(response)

25  // Respond with the stream

26  return new StreamingTextResponse(stream)

27}
```

### **Streaming First UI Helpers**

The Vercel AI SDK includes React and Svelte hooks for data fetching and rendering streaming text responses. These hooks enable real-time, dynamic data representation in your application, offering an immersive and interactive experience to your users.

Building a rich chat or completion interface now just takes a few lines of code thanks to [`useChat`](https://sdk.vercel.ai/docs/api-reference/use-chat) and [`useCompletion`](https://sdk.vercel.ai/docs/api-reference/use-completion):

```tsx
1'use client'



import { useChat } from 'ai/react'



export default function Chat() {

6  const { messages, input, handleInputChange, handleSubmit } = useChat()



8  return (

9    <div>

10      {messages.map(m => (

11        <div key={m.id}>

12          {m.role}: {m.content}

13        </div>

14      ))}



16      <form onSubmit={handleSubmit}>

17        <label>

18          Say something...

19          <input

20            value={input}

21            onChange={handleInputChange}

22          />

23        </label>

24      </form>

25    </div>

26  )

27}
```

### **Stream Helpers and Callbacks**

We've also included callbacks for storing completed streaming responses to a database within the same request. This feature allows for efficient data management and streamlines the entire process of handling streaming text responses.

```tsx
export async function POST(req: Request) {

2  // ... same as above



4  // Convert the response into a friendly text-stream

5  const stream = OpenAIStream(response, {

6    onStart: async () => {

7      // This callback is called when the stream starts

8      // You can use this to save the prompt to your database

9      await savePromptToDatabase(prompt)

10    },

11    onToken: async (token: string) => {

12      // This callback is called for each token in the stream

13      // You can use this to debug the stream or save the tokens to your database

14      console.log(token)

15    },

16    onCompletion: async (completion: string) => {

17      // This callback is called when the stream completes

18      // You can use this to save the final completion to your database

19      await saveCompletionToDatabase(completion)

20    }

21  })



23  // Respond with the stream

24  return new StreamingTextResponse(stream)

25}
```

### **Edge & Serverless ready**

Our SDK is integrated with Vercel products like Serverless and Edge Functions. You can deploy AI application that scale instantly, stream generated responses, and are cost effective.

﻿With [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), you write application code in frameworks like Next.js and SvelteKit using the AI SDK, and Vercel converts this code into [global application infrastructure](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure).

## **Chat & Prompt Playground**

In late April, we launched an interactive online prompt playground [play.vercel.ai](http://play.vercel.ai/) with 20 open source and cloud LLMs.

The playground provides a valuable resource for developers to compare various language model results in real-time, tweak parameters, and quickly generate Next.js, Svelte, and Node.js code.

Today, we’ve added a **new chat interface** to the playground so you can simultaneously compare chat models side-by-side. We’ve also added code generation support for the Vercel AI SDK. You can now go from playground to chat app in just a few clicks.

![Comparing the results from OpenAI GPT-4, Anthropic Claude, and Hugging Face through the Vercel AI SDK Playground and chat interface.](images/introducing-the-vercel-ai-sdk-npm-i-ai-vercel/img_001.jpg)Comparing the results from OpenAI GPT-4, Anthropic Claude, and Hugging Face through the Vercel AI SDK Playground and chat interface.

## What’s Next?

We'll be adding more [SDK examples](https://sdk.vercel.ai/) in the coming weeks, as well as new templates built entirely with the AI SDK. Further, as new best practices for building [AI](https://vercel.com/ai) applications emerge, we’ll lift them into the SDK based on your feedback.

[**Apply to the AI Accelerator**\\
\\
Apply to get access to over $850k in credits from Vercel and our AI partners.\\
\\
Apply today](https://vercel.com/ai-accelerator)

Vercel.com landing page

### Vercel AI Accelerator

Blog post

Jun 22, 2023

### An Introduction to Streaming on the Web

![](images/introducing-the-vercel-ai-sdk-npm-i-ai-vercel/img_002.jpg)

Lydia Hallie