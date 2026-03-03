---
title: "Introducing the Vercel AI SDK: npm i ai - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-vercel-ai-sdk"
date: "2023-06-15"
scraped_at: "2026-03-02T09:52:06.610996214+00:00"
language: "en-zh"
translated: true
description: "An interoperable, streaming-enabled, edge-ready software development kit for AI apps built with React and Svelte."
---

Jun 15, 2023

2023 年 6 月 15 日

一款可互操作、支持流式传输、面向边缘计算就绪的软件开发工具包（SDK），专为基于 React 和 Svelte 构建的 AI 应用而设计。

过去六个月中，[Scale](https://scale.com/)、[Jasper](https://www.jasper.ai/)、[Perplexity](https://www.perplexity.ai/)、[Runway](https://runwayml.com/)、[Lexica](https://lexica.art/) 和 [Jenni](https://jenni.ai/) 等 AI 公司均采用 [Next.js](https://vercel.com/solutions/nextjs) 框架，并在 Vercel 平台上发布产品。Vercel 可加速您的产品开发进程，让您专注于通过 AI 应用创造实际价值，而非耗费精力构建与维护底层基础设施。

今天，我们正式推出一系列全新工具，以进一步提升 AI 应用在 Vercel 平台上的用户体验。

- **Vercel AI SDK**：轻松实现 AI 模型 API 响应的流式传输  
- **对话与提示词（Prompt）体验中心（Chat & Prompt Playground）**：探索来自 [OpenAI](https://vercel.com/docs/integrations/openai)、Hugging Face 等平台的各类模型  

## The Vercel AI SDK

## Vercel AI SDK

[Vercel AI SDK](https://sdk.vercel.ai/) 是一个[开源](https://github.com/vercel-labs/ai) JavaScript/TypeScript 库，旨在帮助开发者快速构建具备对话能力、支持流式响应及聊天交互界面的 AI 应用。该 SDK 当前已原生支持 React/Next.js 与 Svelte/SvelteKit，对 Nuxt/Vue 的支持也即将上线。

在终端中运行以下命令即可安装 SDK：

```bash
npm install ai
```

You can also [view the source code on GitHub](https://github.com/vercel-labs/ai).

您也可以在 GitHub 上[查看源代码](https://github.com/vercel-labs/ai)。

### **Built-in LLM Adapters**

### **内置大语言模型（LLM）适配器**

Choosing the right LLM for your application is crucial to building a great experience. Each has unique tradeoffs, and can be tuned in different ways to meet your requirements.

为您的应用选择合适的大语言模型（LLM）对于打造卓越的用户体验至关重要。每种模型都有其独特的权衡取舍，且可通过不同方式进行调优，以满足您的具体需求。

Vercel’s AI SDK embraces interoperability, and includes first-class support for [OpenAI](https://openai.com/), [LangChain](https://js.langchain.com/docs/), and [Hugging Face](https://huggingface.co/) Inference. This means that regardless of your preferred AI model provider, you can leverage the Vercel AI SDK to create cutting-edge streaming UI experiences.

Vercel 的 AI SDK 坚持互操作性理念，原生支持 [OpenAI](https://openai.com/)、[LangChain](https://js.langchain.com/docs/) 和 [Hugging Face](https://huggingface.co/) 推理服务。这意味着，无论您偏爱哪家 AI 模型提供商，均可借助 Vercel AI SDK 构建前沿的流式 UI 体验。

```tsx
import { OpenAIStream, StreamingTextResponse } from 'ai'

import { Configuration, OpenAIApi } from 'openai-edge'



4// Create an OpenAI API client (that's edge friendly!)

4// 创建一个兼容边缘计算（Edge）的 OpenAI API 客户端！

const config = new Configuration({

6  apiKey: process.env.OPENAI_API_KEY
```

7})

const openai = new OpenAIApi(config)



10// IMPORTANT! Set the runtime to edge

10// 重要！将运行时（runtime）设置为 edge

export const runtime = 'edge'



export async function POST(req: Request) {

14  // Extract the `messages` from the body of the request

14  // 从请求体中提取 `messages`

15  const { messages } = await req.json()

17  // Ask OpenAI for a streaming chat completion given the prompt

17  // 向 OpenAI 请求基于提示词的流式聊天补全

18  const response = await openai.createChatCompletion({

18  const response = await openai.createChatCompletion({

19    model: 'gpt-3.5-turbo',

19    model: 'gpt-3.5-turbo',

20    stream: true,

20    stream: true,

21    messages

21    messages

22  })

22  })

23  // Convert the response into a friendly text-stream

23  // 将响应转换为易于使用的文本流

24  const stream = OpenAIStream(response)

24  const stream = OpenAIStream(response)

25  // Respond with the stream

25  // 以该流作为响应返回

26  return new StreamingTextResponse(stream)

26  return new StreamingTextResponse(stream)

27}
```

### **Streaming First UI Helpers**

### **面向流式传输的 UI 辅助工具**

The Vercel AI SDK includes React and Svelte hooks for data fetching and rendering streaming text responses. These hooks enable real-time, dynamic data representation in your application, offering an immersive and interactive experience to your users.

Vercel AI SDK 提供了适用于 React 和 Svelte 的 Hook，用于数据获取及流式文本响应的渲染。这些 Hook 可在您的应用中实现实时、动态的数据呈现，为用户提供沉浸式且高度交互的体验。

Building a rich chat or completion interface now just takes a few lines of code thanks to [`useChat`](https://sdk.vercel.ai/docs/api-reference/use-chat) and [`useCompletion`](https://sdk.vercel.ai/docs/api-reference/use-completion):

借助 [`useChat`](https://sdk.vercel.ai/docs/api-reference/use-chat) 和 [`useCompletion`](https://sdk.vercel.ai/docs/api-reference/use-completion)，现在仅需几行代码即可构建功能丰富的聊天或补全界面：

```tsx
1'use client'



import { useChat } from 'ai/react'



export default function Chat() {

6  const { messages, input, handleInputChange, handleSubmit } = useChat()
```

8  return (

8  返回 (

9    <div>

9    <div>

10      {messages.map(m => (

10      {messages.map(m => (

11        <div key={m.id}>

11        <div key={m.id}>

12          {m.role}: {m.content}

12          {m.role}：{m.content}

13        </div>

13        </div>

14      ))}

14      ))}

16      <form onSubmit={handleSubmit}>

16      <form onSubmit={handleSubmit}>

17        `<label>`

17        `<label>`

18          Say something...

18          说点什么……

19          `<input`

19          `<input`

20            value={input}

20            value={input}

21            onChange={handleInputChange}

21            onChange={handleInputChange}

22          />`

22          />`

23        `</label>`

23        `</label>`

24      `</form>`

24      `</form>`

25    `</div>`

25    `</div>`

26  )`

26  )`

27}
```

### **Stream Helpers and Callbacks**

### **流式处理辅助工具与回调函数**

We've also included callbacks for storing completed streaming responses to a database within the same request. This feature allows for efficient data management and streamlines the entire process of handling streaming text responses.

我们还提供了回调函数，用于在同一次请求中将完成的流式响应存储到数据库中。该功能有助于高效管理数据，并简化流式文本响应的整体处理流程。

```tsx
export async function POST(req: Request) {

2  // ... same as above

2  // ……同上

4  // Convert the response into a friendly text-stream

4  // 将响应转换为易于使用的文本流

5  const stream = OpenAIStream(response, {

6    onStart: async () => {

7      // This callback is called when the stream starts

7      // 此回调函数在流启动时被调用

8      // You can use this to save the prompt to your database

8      // 您可以使用此代码将提示词保存到数据库中

9      await savePromptToDatabase(prompt)

9      await savePromptToDatabase(prompt)

10    },

10    },

11    onToken: async (token: string) => {

11    onToken: async (token: string) => {

12      // This callback is called for each token in the stream

12      // 此回调函数会在流式响应中每个 token 生成时被调用

13      // You can use this to debug the stream or save the tokens to your database

13      // 您可利用此回调进行流式响应调试，或将 token 保存至数据库

14      console.log(token)

14      console.log(token)

15    },

15    },

16    onCompletion: async (completion: string) => {

16    onCompletion: async (completion: string) => {

17      // This callback is called when the stream completes

17      // 此回调函数在流式响应完成时被调用

18      // You can use this to save the final completion to your database

18      // 您可以使用此代码将最终的生成结果保存到您的数据库中

19      await saveCompletionToDatabase(completion)

19      await saveCompletionToDatabase(completion)

20    }

20    }

21  })

21  })



23  // Respond with the stream

23  // 以流式响应返回数据

24  return new StreamingTextResponse(stream)

24  return new StreamingTextResponse(stream)

25}
25}

### **Edge & Serverless ready**

### **支持 Edge 与无服务器架构**

Our SDK is integrated with Vercel products like Serverless and Edge Functions. You can deploy AI application that scale instantly, stream generated responses, and are cost effective.

我们的 SDK 已与 Vercel 的各类产品（例如无服务器函数和 Edge 函数）深度集成。您可快速部署 AI 应用——这些应用能够即时弹性伸缩、流式传输生成内容，且成本效益优异。

With [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure), you write application code in frameworks like Next.js and SvelteKit using the AI SDK, and Vercel converts this code into [global application infrastructure](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure).

借助[框架定义的基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)，您可使用 AI SDK 在 Next.js、SvelteKit 等框架中编写应用代码，Vercel 会将这些代码自动转化为[全球应用基础设施（Global Application Infrastructure）](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure)。

## **Chat & Prompt Playground**

## **聊天与提示词游乐场**

In late April, we launched an interactive online prompt playground [play.vercel.ai](http://play.vercel.ai/) with 20 open source and cloud LLMs.

今年四月下旬，我们推出了交互式在线提示词游乐场 [play.vercel.ai](http://play.vercel.ai/)，集成了 20 款开源及云托管大语言模型（LLM）。

The playground provides a valuable resource for developers to compare various language model results in real-time, tweak parameters, and quickly generate Next.js, Svelte, and Node.js code.

该游乐场为开发者提供了宝贵资源：可实时对比不同语言模型的输出效果、灵活调整参数，并快速生成 Next.js、Svelte 和 Node.js 代码。

Today, we’ve added a **new chat interface** to the playground so you can simultaneously compare chat models side-by-side. We’ve also added code generation support for the Vercel AI SDK. You can now go from playground to chat app in just a few clicks.

今天，我们在游乐场中新增了**聊天界面（Chat Interface）**，支持您并排实时对比多个对话模型；同时新增了对 Vercel AI SDK 的代码生成功能。现在，您只需点击几下，即可从游乐场快速构建出一个完整的聊天应用。

![Comparing the results from OpenAI GPT-4, Anthropic Claude, and Hugging Face through the Vercel AI SDK Playground and chat interface.](images/introducing-the-vercel-ai-sdk-npm-i-ai-vercel/img_001.jpg)  
通过 Vercel AI SDK 游乐场与聊天界面，对比 OpenAI GPT-4、Anthropic Claude 与 Hugging Face 模型的输出结果。

## What’s Next?

## 下一步是什么？

We'll be adding more [SDK examples](https://sdk.vercel.ai/) in the coming weeks, as well as new templates built entirely with the AI SDK. Further, as new best practices for building [AI](https://vercel.com/ai) applications emerge, we’ll lift them into the SDK based on your feedback.

在接下来的几周内，我们将持续增加更多 [SDK 示例](https://sdk.vercel.ai/)，并推出完全基于 AI SDK 构建的新模板。此外，随着构建 [AI](https://vercel.com/ai) 应用的最佳实践不断演进，我们也将根据您的反馈，将这些实践逐步融入 SDK。

[**Apply to the AI Accelerator**\\  
\\  
Apply to get access to over $850k in credits from Vercel and our AI partners.\\  
\\  
Apply today](https://vercel.com/ai-accelerator)

[**申请加入 AI 加速器（AI Accelerator）**\\  
\\  
申请即有机会获得 Vercel 及其 AI 合作伙伴提供的总额超 85 万美元的云资源抵扣额度。\\  
\\  
立即申请](https://vercel.com/ai-accelerator)

Vercel.com landing page  

Vercel.com 首页

### Vercel AI Accelerator

### Vercel AI 加速器

Blog post

博客文章

Jun 22, 2023

2023 年 6 月 22 日

### An Introduction to Streaming on the Web

### 网络流式传输简介

![](images/introducing-the-vercel-ai-sdk-npm-i-ai-vercel/img_002.jpg)

Lydia Hallie

莉迪亚·哈利