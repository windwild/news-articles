---
title: "Introducing AI Integrations on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-integrations"
date: "2024-02-08"
scraped_at: "2026-03-02T09:48:10.015051170+00:00"
language: "en-zh"
translated: true
description: "AI Integrations on Vercel"
---

Feb 8, 2024

2024 年 2 月 8 日

Incorporate AI models and services from industry-leading providers into your Vercel projects with just a few clicks.

只需几次点击，即可将来自行业领先供应商的 AI 模型与服务集成到您的 Vercel 项目中。

Today, we’re launching **nine new AI integrations for Vercel** from leading AI companies.

今天，我们正式推出来自顶尖 AI 公司的 **九项全新 Vercel AI 集成**。

We’ve also created a new **model playground** where you can try dozens of models instantly to generate text, images, audio, and more right in your dashboard.

我们还全新打造了一个 **模型体验沙盒（Model Playground）**，您可在仪表板中即时试用数十种模型，快速生成文本、图像、音频等内容。

![Explore and play with the popular AI models from various providers.](images/introducing-ai-integrations-on-vercel-vercel/img_001.jpg)![Explore and play with the popular AI models from various providers.](images/introducing-ai-integrations-on-vercel-vercel/img_002.jpg)探索并体验来自各大供应商的热门 AI 模型。

## **Building the future with AI**

## **携手 AI，共建未来**

Vercel is the product infrastructure for [AI applications](https://vercel.com/ai).

Vercel 是 [AI 应用](https://vercel.com/ai) 的产品级基础设施。

From [chatbots](https://vercel.com/templates/next.js/nextjs-ai-chatbot) that augment customer service flows, to recommendation systems with semantic search, [Retrieval Augmented Generation (RAG)](https://vercel.com/guides/retrieval-augmented-generation), and generative image services—companies can build better product experiences faster than ever before with AI.

无论是用于增强客户服务流程的 [聊天机器人](https://vercel.com/templates/next.js/nextjs-ai-chatbot)，还是融合语义搜索的推荐系统、[检索增强生成（RAG）](https://vercel.com/guides/retrieval-augmented-generation) 技术，以及生成式图像服务——企业均可借助 AI，以前所未有的速度构建更卓越的产品体验。

We've partnered with our first cohort of AI providers to speed up your product development process.

我们已携手首批 AI 合作伙伴，助力加速您的产品开发进程。

![Our first cohort of AI Integration partners, now available in the AI tab.](images/introducing-ai-integrations-on-vercel-vercel/img_003.jpg)![Our first cohort of AI Integration partners, now available in the AI tab.](images/introducing-ai-integrations-on-vercel-vercel/img_004.jpg)我们的首批 AI 集成合作伙伴现已上线，您可在控制台的“AI”标签页中查看和使用。

_**"We're excited to partner with Vercel on bringing the latest state of the art open source machine learning models to more AI Engineers. We believe that AI should be easy to run and integrate into any web application."**_  
_**“我们非常高兴与 Vercel 合作，将最新一代的开源机器学习模型带给更多 AI 工程师。我们坚信，AI 应当易于运行，并能轻松集成到任意 Web 应用中。”**_  
— Replicate Software Engineer, Charlie Holtz  
— Replicate 软件工程师，Charlie Holtz

## Connecting to models with the AI SDK

## 使用 AI SDK 连接模型

After you've integrated with an AI provider, you can then quickly get started using the model in your frontend application using the [Vercel AI SDK](https://sdk.vercel.ai/docs). This SDK is like an ORM for any AI model you want to use, whether it's for text, images, and soon audio.  

在完成与 AI 服务提供商的集成后，你即可借助 [Vercel AI SDK](https://sdk.vercel.ai/docs) 快速在前端应用中调用模型。该 SDK 就如同面向任意 AI 模型（无论是文本、图像，还是即将支持的音频模型）的 ORM（对象关系映射）工具。

For example, if you want to use the Perplexity API with Next.js, it only takes the following code to stream back responses to your frontend:  

例如，若要在 Next.js 中使用 Perplexity API，仅需以下代码即可将响应以流式方式返回至你的前端：

app/api/chat/route.ts

```tsx
import { OpenAIStream, StreamingTextResponse } from 'ai';

import OpenAI from 'openai';



const perplexity = new OpenAI({

5  apiKey: process.env.PERPLEXITY_API_KEY || '',

6  baseUrl: 'https://api.perplexity.ai',

6  baseUrl: 'https://api.perplexity.ai',

7});

7});

export async function POST(req: Request) {

export async function POST(req: Request) {

10  const { messages } = await req.json();

10  const { messages } = await req.json();

12  // Generated a chat completion based on the prompt

12  // 基于提示词生成聊天补全内容

13  const response = await perplexity.chat.completions.create({

13  const response = await perplexity.chat.completions.create({

14    model: 'pplx-7b-chat',

14    model: 'pplx-7b-chat',

15    stream: true,

16    messages: messages,

16    消息：messages，

17  });

17  });

19  // Convert the response into a friendly text-stream

19  // 将响应转换为友好的文本流

20  const stream = OpenAIStream(response);

20  const stream = OpenAIStream(response);

22  // Respond with the stream

22  // 使用该流进行响应

23  return new StreamingTextResponse(stream);

23  return new StreamingTextResponse(stream);

24}

24}

```

Using the Perplexity API with the Next.js App Router.

```

使用 Perplexity API 与 Next.js App Router。

[Learn more about the AI SDK](https://sdk.vercel.ai/docs) or follow the instructions after connecting to your provider of choice.

[了解更多关于 AI SDK 的信息](https://sdk.vercel.ai/docs)，或在连接至您选择的提供商后，按照相关说明操作。

### **Get Started Today**

### **立即开始**

The future of application development is intelligent, intuitive, and immersive. With Vercel's AI Integrations, you're not just building applications; you're crafting experiences that anticipate and adapt to user needs in real-time.

应用开发的未来是智能化、直观化与沉浸式的。借助 Vercel 的 AI 集成能力，您所构建的不仅是应用程序，更是能够实时预测并响应用户需求的卓越体验。

If you’re an AI company or developer keen to join our AI Integrations, you can [create your own integration](https://vercel.com/docs/integrations/create-integration).

如果您是一家 AI 公司或热衷于加入我们 AI 集成生态的开发者，欢迎[创建您自己的集成](https://vercel.com/docs/integrations/create-integration)。

Check out the new tab in your Vercel dashboard and [add AI to your app today](https://vercel.com/docs/integrations/ai).

请查看您的 Vercel 控制台中的新标签页，并[今天就为您的应用添加 AI 功能](https://vercel.com/docs/integrations/ai)。

[**Start building today**\\
\\
Explore, preview, and seamlessly integrate AI models and databases into your Vercel projects. \\
\\
Get Started](https://vercel.com/docs/integrations/ai)

[**即刻开始构建**\\
\\
探索、预览，并无缝将 AI 模型与数据库集成至您的 Vercel 项目中。\\
\\
立即开始](https://vercel.com/docs/integrations/ai)