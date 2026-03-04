---
title: "AI SDK 3.4 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-3-4"
date: "2024-09-20"
scraped_at: "2026-03-02T09:41:04.810616570+00:00"
language: "en-zh"
translated: true
description: "AI SDK 3.4 introduces middleware, data stream protocol, and multi-step generations"
---
{% raw %}

Sep 20, 2024

2024 年 9 月 20 日

Introducing language model middleware, data stream protocol, and multi-step generations

介绍语言模型中间件、数据流协议与多步生成能力

The [AI SDK](https://sdk.vercel.ai/) is an open-source toolkit for building AI applications with JavaScript and TypeScript. Its unified provider API allows you to use any language model and enables powerful UI integrations into leading web frameworks such as [Next.js](https://nextjs.org/) and [Svelte](https://svelte.dev/).

[AI SDK](https://sdk.vercel.ai/) 是一个开源工具包，用于使用 JavaScript 和 TypeScript 构建 AI 应用。其统一的 Provider API 使您能够接入任意语言模型，并支持与 Next.js、Svelte 等主流 Web 框架进行深度 UI 集成。

Since our [3.3 release](https://vercel.com/blog/vercel-ai-sdk-3-3), we've seen some incredible products built with the AI SDK:

自 [3.3 版本发布](https://vercel.com/blog/vercel-ai-sdk-3-3) 以来，我们已见证众多令人惊叹的产品基于 AI SDK 构建而成：

- [**postgres.new**](http://postgres.new/) is an AI-powered SQL editor that uses the AI SDK to translate user queries into SQL.

- [**postgres.new**](http://postgres.new/) 是一款由 AI 驱动的 SQL 编辑器，利用 AI SDK 将用户自然语言查询自动翻译为 SQL 语句。

- [**v0**](http://v0.dev/) is a web development agent that allows you to generate UI, ask engineering questions, and execute code — all in natural language.

- [**v0**](http://v0.dev/) 是一款面向 Web 开发的智能代理，支持通过自然语言生成 UI、提出工程问题并执行代码。

![v0 by Vercel is powered by the AI SDK](images/ai-sdk-3_4-vercel/img_001.jpg)![v0 by Vercel is powered by the AI SDK](images/ai-sdk-3_4-vercel/img_002.jpg)v0 by Vercel is powered by the AI SDK

![v0 by Vercel is powered by the AI SDK](images/ai-sdk-3_4-vercel/img_001.jpg)![v0 by Vercel is powered by the AI SDK](images/ai-sdk-3_4-vercel/img_002.jpg)v0 由 Vercel 推出，底层由 AI SDK 提供支持

Today, we’re excited to release AI SDK 3.4 which introduces several new features:

今天，我们非常高兴地推出 AI SDK 3.4 版本，带来多项全新功能：

1. [**Language model middleware**](https://vercel.com/blog/ai-sdk-3-4#language-model-middleware): intercept and modify language model calls

1. [**语言模型中间件**](https://vercel.com/blog/ai-sdk-3-4#language-model-middleware)：拦截并修改语言模型调用

2. [**Data stream protocol**](https://vercel.com/blog/ai-sdk-3-4#data-stream-protocol): use AI SDK UI with with any backend

2. [**数据流协议**](https://vercel.com/blog/ai-sdk-3-4#data-stream-protocol)：将 AI SDK 的 UI 组件与任意后端服务无缝集成

3. [**Structured outputs**](https://vercel.com/blog/ai-sdk-3-4#structured-outputs) **:** 基于对象（object）、数组（array）或枚举（enum）的输出模式

4. [**Multi-step calls**](https://vercel.com/blog/ai-sdk-3-4#multi-step-calls) **:** 通过智能体（agents）和助手（assistants）实现的自动工具调用

5. [**Tracing improvements**](https://vercel.com/blog/ai-sdk-3-4#tracing-improvements)：面向性能分析与成本洞察的高级遥测能力

6. [**Mock models and testing**](https://vercel.com/blog/ai-sdk-3-4#mock-models-and-testing) **:** 模拟语言模型响应，以支持单元测试

7. [**Provider updates**](https://vercel.com/blog/ai-sdk-3-4#provider-updates) **:** 新增模型提供商、性能优化及功能增强


## **Language model middleware**

## **语言模型中间件**

AI SDK 3.4 引入了[语言模型中间件（language model middleware）](https://sdk.vercel.ai/docs/ai-sdk-core/middleware#language-model-middleware)。该设计灵感源自 Web 开发中的中间件机制，为拦截、修改和增强语言模型调用提供了模块化的实现方式。

语言模型中间件提供以下三种方法：

- [`transformParams`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/language-model-v1-middleware#transform-params)：在语言模型请求发出前对其进行修改。该方法支持动态注入上下文、优化提示词（prompt refinement），或整合外部数据源。例如，可通过检索相关文档内容并将其加入 prompt，从而实现检索增强生成（RAG）。

- [`wrapGenerate`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/language-model-v1-middleware#wrap-generate) 和 [`wrapStream`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/language-model-v1-middleware#wrap-stream)：拦截并“包装”语言模型调用，使你能够在模型交互前后均执行请求级别的逻辑。该机制非常适合实现日志记录、缓存以及安全防护（safety guardrails）等功能。

A major advantage of the language model middleware interface is that it is shareable. You can package, distribute, and reuse middleware across projects. This modular, self-contained approach makes it simple to maintain and update as new models come out.

语言模型中间件接口的一大优势在于其可共享性。您可将中间件打包、分发，并在不同项目中复用。这种模块化、自包含的设计，使得在新模型发布时，维护与更新变得十分简便。

Language model middleware is an experimental feature. Experimental features let you use the latest AI SDK functionality as soon as possible, however, they can change in patch versions.

语言模型中间件是一项实验性功能。实验性功能使您能尽早使用最新的 AI SDK 功能；但请注意，此类功能可能在补丁版本（patch versions）中发生变更。

### **Implementing RAG with middleware**

### **借助中间件实现 RAG**

Let's look at how you can implement a [retrieval-augmented generation](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) middleware:

让我们来看看如何实现一个 [检索增强生成](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)（RAG）中间件：

```tsx
import type {

2  Experimental_LanguageModelV1Middleware as LanguageModelV1Middleware

3} from "ai";



export const yourRagMiddleware: LanguageModelV1Middleware = {

6  transformParams: async ({ params }) => {
```

7    const lastUserMessageText = getLastUserMessageText({

8      prompt: params.prompt,

9    });



7    const lastUserMessageText = getLastUserMessageText({

8      prompt: params.prompt,

9    });



11    // do not use RAG when the last message is not a user message

11    // 当最后一条消息不是用户消息时，不使用 RAG

12    if (lastUserMessageText == null) return params;



12    if (lastUserMessageText == null) 返回 params;



14    // find relevant sources for the last user message:

14    // 为最后一条用户消息查找相关资料源：

15    const sources = findSources({ text: lastUserMessageText });

15    const sources = findSources({ text: lastUserMessageText });

17    const instruction =

17    const instruction =

18      "Use the following information to answer the question:\n" +

18      “请使用以下信息回答问题：\n” +

19      sources.map((chunk) => JSON.stringify(chunk)).join("\n");

19      sources.map((chunk) => JSON.stringify(chunk)).join("\n");



21    // return params with the instruction added to the last user message:

21    // 将指令添加到用户最后一条消息中，并返回更新后的参数：

22    return paramsWithUpdatedLastUserMessage({ params, text: instruction });

22    return paramsWithUpdatedLastUserMessage({ params, text: instruction });

23  },

23  },

24};

24};


Example RAG middleware (pseudocode)

示例 RAG 中间件（伪代码）

This middleware uses the `transformParams` function to intercept the model call, retrieve relevant information based on the user's last message, and add it to the prompt. This approach keeps your RAG logic separate from your main application code, making it easy to maintain and extend based on your use case.

该中间件利用 `transformParams` 函数拦截模型调用，根据用户的最后一条消息检索相关信息，并将其添加到提示词（prompt）中。这种设计将你的 RAG 逻辑与主应用程序代码解耦，便于维护，并可根据具体使用场景灵活扩展。

### **Using middleware with your language model**

### **将中间件应用于您的语言模型**

Once you've created your middleware, you can apply it to your language model:

创建好中间件后，您即可将其应用于您的语言模型：

```tsx
import {

2  streamText,

3  experimental_wrapLanguageModel as wrapLanguageModel,

4} from 'ai';

import { openai } from '@ai-sdk/openai'



const result = await streamText({

8  model: wrapLanguageModel({

9    model: openai('gpt-4o'),

9    模型：openai('gpt-4o')，

10    middleware: yourLanguageModelMiddleware,

10    中间件：yourLanguageModelMiddleware，

11  }),

11  }),

12  prompt: 'What is founder mode?',

12  提示词：'What is founder mode?'，

13});
```

13});
```

Check out our [RAG template](https://vercel.com/templates/next.js/ai-sdk-internal-knowledge-base) to see middleware [in action](https://ai-sdk-preview-internal-knowledge-base.vercel.app/) and explore the [source code](https://github.com/vercel-labs/ai-sdk-preview-internal-knowledge-base) for a production-grade implementation.

欢迎查看我们的 [RAG 模板](https://vercel.com/templates/next.js/ai-sdk-internal-knowledge-base)，直观了解中间件的 [实际运行效果](https://ai-sdk-preview-internal-knowledge-base.vercel.app/)，并浏览 [源代码](https://github.com/vercel-labs/ai-sdk-preview-internal-knowledge-base)，获取面向生产环境的完整实现方案。

Whether you're implementing complex [RAG systems](https://github.com/vercel/ai/blob/main/examples/ai-core/src/middleware/your-rag-middleware.ts), [adding guardrails](https://github.com/vercel/ai/blob/main/examples/ai-core/src/middleware/your-guardrail-middleware.ts), or [optimizing performance with caching](https://github.com/vercel/ai/blob/main/examples/ai-core/src/middleware/your-cache-middleware.ts), middleware provides a clean and modular way to extend your language model's capabilities.

无论您是在构建复杂的 [RAG 系统](https://github.com/vercel/ai/blob/main/examples/ai-core/src/middleware/your-rag-middleware.ts)，还是在 [添加安全护栏（guardrails）](https://github.com/vercel/ai/blob/main/examples/ai-core/src/middleware/your-guardrail-middleware.ts)，抑或通过 [缓存机制优化性能](https://github.com/vercel/ai/blob/main/examples/ai-core/src/middleware/your-cache-middleware.ts)，中间件都为您提供了一种简洁、模块化的途径，以扩展语言模型的能力。

## **Data stream protocol**

## **数据流协议**

Building AI-powered frontends often involves managing complex streaming data, handling partial responses, and maintaining consistent chat state. To solve these problems, we built [AI SDK UI](https://sdk.vercel.ai/docs/ai-sdk-ui/overview#ai-sdk-ui), a library that provides framework-agnostic hooks to help you build common AI-native UIs:

构建 AI 驱动的前端应用，常常需要处理复杂的流式数据、应对不完整的响应片段，并维持一致的对话状态。为解决这些问题，我们开发了 [AI SDK UI](https://sdk.vercel.ai/docs/ai-sdk-ui/overview#ai-sdk-ui) —— 一个提供框架无关（framework-agnostic）Hook 的库，助您高效构建各类原生 AI 用户界面：

- [`useChat`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-chat): Manages real-time streaming of chat messages

- [`useChat`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-chat)：管理聊天消息的实时流式传输

- [`useCompletion`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-completion): 处理文本补全，并自动更新 UI

- [`useCompletion`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-completion)：处理文本补全，并自动更新 UI

Up until now, to use AI SDK UI, you had to use [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core/overview) on the backend. This is not a viable option if your backend is already written in another language like Python. With AI SDK 3.4, we are **introducing a new Data Stream Protocol that allows you to use AI SDK UI with any backend**, in any programming language.

截至目前，若要使用 AI SDK UI，您必须在后端使用 [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core/overview)。但如果您的后端已用 Python 等其他语言编写，这一方案便不可行。借助 AI SDK 3.4，我们**正式推出一种全新的数据流协议（Data Stream Protocol），使您能够将 AI SDK UI 与任意编程语言编写的后端集成**。

Implementing the data stream protocol involves two key steps:

实现该数据流协议包含两个关键步骤：

1. Send data from your backend according to [the protocol specifications](https://sdk.vercel.ai/docs/ai-sdk-ui/stream-protocol#stream-protocols)

1. 按照[协议规范](https://sdk.vercel.ai/docs/ai-sdk-ui/stream-protocol#stream-protocols)，从您的后端发送数据

2. [Configure AI SDK UI hooks](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-chat#api) to use the custom backend endpoint

2. [配置 AI SDK UI 的 Hook](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-chat#api)，以调用您自定义的后端接口

To help you get started with implementing the Stream Protocol in different backend frameworks, we've prepared a [Python FastAPI Example](https://github.com/vercel/ai/tree/main/examples/next-fastapi). We've also created examples for many JavaScript backend frameworks:

为帮助您快速在不同后端框架中实现数据流协议，我们准备了 [Python FastAPI 示例](https://github.com/vercel/ai/tree/main/examples/next-fastapi)。此外，我们还为多种 JavaScript 后端框架提供了示例：

- [Node.js Express Example](https://sdk.vercel.ai/examples/api-servers/node-js-http-server)

- [Node.js Express 示例](https://sdk.vercel.ai/examples/api-servers/node-js-http-server)

- [Node.js Fastify Example](https://sdk.vercel.ai/examples/api-servers/fastify)

- [Node.js Fastify 示例](https://sdk.vercel.ai/examples/api-servers/fastify)

- [Node.js Hono Example](https://sdk.vercel.ai/examples/api-servers/hono)

- [Node.js Hono 示例](https://sdk.vercel.ai/examples/api-servers/hono)

- [Node.js Nest.js Example](https://sdk.vercel.ai/examples/api-servers/nest)

- [Node.js Nest.js 示例](https://sdk.vercel.ai/examples/api-servers/nest)

The new data stream protocol also allows you easily to create custom chat frontends completely tailored to your needs, while still leveraging the full power of AI SDK Core. To learn more, check out [the stream protocol documentation](https://sdk.vercel.ai/docs/ai-sdk-ui/stream-protocol#stream-protocols).

新的数据流协议还使您能够轻松创建完全契合自身需求的自定义聊天前端，同时依然充分利用 AI SDK Core 的全部能力。欲了解更多信息，请参阅[流协议文档](https://sdk.vercel.ai/docs/ai-sdk-ui/stream-protocol#stream-protocols)。

## **Structured outputs**

## **结构化输出**

The AI SDK has long supported [structured output generation](https://sdk.vercel.ai/docs/ai-sdk-core/generating-structured-data) through the [`generateObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/generate-object) and [`streamObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/stream-object) functions. These functions allow you to create type-safe, schema-validated outputs from language models. They are instrumental for tasks like information extraction, data classification, and synthetic data generation.

AI SDK 长期以来已通过 [`generateObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/generate-object) 和 [`streamObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/stream-object) 函数支持[结构化输出生成](https://sdk.vercel.ai/docs/ai-sdk-core/generating-structured-data)。这些函数使您能够从大语言模型中生成类型安全、符合预定义 Schema 的输出，对信息抽取、数据分类及合成数据生成等任务尤为关键。

Based on your feedback, we're introducing a new output mode parameter for `generateObject` and `streamObject`. This parameter allows you to define what kind of output you want, and gives you options to better steer it. The default output mode is `object`.

根据您的反馈，我们为 `generateObject` 和 `streamObject` 引入了一个全新的输出模式（output mode）参数。该参数让您可明确指定所需输出的类型，并提供多种选项以更精准地引导模型行为。默认输出模式为 `object`。

1\. **Object mode (default)**

1. **对象模式（默认）**

Object mode will force the model to return a single structured object based on the schema that you provide.

对象模式将强制模型严格依据您提供的 Schema，返回一个单一的结构化对象。

```tsx
const { object } = await generateObject({

2  model: openai('gpt-4o'),

3  schema: z.object({

4    product: z.object({
```

5      name: z.string(),

5      名称：z.string(),

6      description: z.string(),

6      描述：z.string(),

7      price: z.number(),

7      价格：z.number(),

8    }),

8    }),

9  }),

9  }),

10  prompt: 'Generate a description for a new smartphone.',

10  prompt: '为一款新型智能手机生成描述。',

11});
```

11});
```

Generate a single object with object output mode

以“对象输出模式”生成单个对象

2\. **Array mode (new)**

2\. **数组模式（新增）**

Array output mode allows the model to generate an array of objects that conform to a specified element schema. This mode is particularly useful when you need to create multiple structured objects with consistent properties.

数组输出模式允许模型生成一个符合指定元素 Schema 的对象数组。当您需要批量创建具有统一属性结构的多个对象时，该模式尤为实用。

```tsx
const { elementStream: destinations } = await streamObject({

2  model: openai('gpt-4o'),

3  output: 'array',

4  schema: z.object({

5    city: z.string(),

6    country: z.string(),

7    description: z.string(),

8    attractions: z.array(z.string()).describe('List of major attractions.'),

9  }),

10  prompt: 'What are the top 5 cities for short vacations in Europe?',
```

```tsx
const { elementStream: destinations } = await streamObject({

2  model: openai('gpt-4o'),

3  output: 'array',

4  schema: z.object({

5    城市: z.string(),

6    国家: z.string(),

7    描述: z.string(),

8    景点: z.array(z.string()).describe('主要景点列表。'),

9  }),

10  prompt: '欧洲最适合短途度假的前 5 座城市是哪些？',
```

11});  

11});

for await (const destination of destinations) {  

for await (const destination of destinations) {

14  console.log(destination); // destination is a complete array element  

14  console.log(destination); // destination 是一个完整的数组元素

15}  
15}

```

```

Generate an array of objects that conform to an element schema with array output mode  

以“数组输出模式”生成一组符合元素 schema 的对象

When used with the [`useObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-object) hook in a React component, this new array output mode streams only complete array element as they become available. This results in a more stable UI with no layout shifts, improving the overall user experience.  

在 React 组件中与 [`useObject`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-object) 钩子配合使用时，这一新增的“数组输出模式”仅在每个完整的数组元素就绪后才进行流式传输。这可带来更稳定的用户界面（UI），避免布局偏移（layout shifts），从而显著提升整体用户体验。

Check out [array output mode in action](https://ai-sdk-preview-array-output-mode.vercel.app/).  

欢迎体验 [实际运行中的数组输出模式](https://ai-sdk-preview-array-output-mode.vercel.app/)。

3\. **Enum mode (new)**  

3. **枚举模式（新增）**

Enum mode will force the model to return a single value from a predefined set of options. This is particularly useful for classification tasks (e.g. sentiment analysis) where you want to constrain the output to a specific set of categories.  

枚举模式将强制模型从预定义的选项集合中返回单一值。该模式特别适用于分类任务（例如情感分析），当你希望将模型输出严格限定于特定类别集合时尤为有效。

```tsx
const { object: movieGenre } = await generateObject({

2  model: openai('gpt-4o'),

3  output: "enum",

4  enum: ["action", "comedy", "drama", "horror", "sci-fi"],

5  prompt:

6    `Classify the genre of this movie plot:` +

7    `"A group of astronauts travel through a wormhole ` +

8    `in search of a new habitable planet for humanity."`,

9});
```

以枚举（enum）输出模式生成一个特定值

Note: Enum mode is limited to generateObject given the short length of the resulting generation.

注意：由于生成结果长度较短，枚举（Enum）模式仅限于 `generateObject` 使用。

4\. **No schema (new)**

4. **无 Schema 模式（新增）**

In some cases, you might not want to use a schema, for example when the data is a dynamic user request. You can use the `output` setting to set the output format to `no-schema` in those cases and omit the schema parameter. Check out [no-schema output mode in action](https://ai-sdk-preview-no-schema.vercel.app/).

在某些场景下，您可能不希望使用 Schema，例如当数据来自动态的用户请求时。此时，您可通过 `output` 配置项将输出格式设为 `no-schema`，并省略 `schema` 参数。请参阅 [无 Schema 输出模式的实际演示](https://ai-sdk-preview-no-schema.vercel.app/)。

## Multi-step calls

## 多步调用

In a [previous update](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#agents), we added the [`steps`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#steps) parameter to `generateText`, allowing language models to make multiple tool calls and receive results within a single generation.

在[此前的一次更新](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#agents)中，我们为 `generateText` 添加了 [`steps`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#steps) 参数，使语言模型可在单次生成过程中多次调用工具并接收其返回结果。

With AI SDK 3.4, we've added this functionality to `streamText`. This addition addresses the need for real-time, streaming responses that can interact with tools, a frequent request from our users. The key benefit of this feature is that you no longer need to manually orchestrate checking for tool calls and feeding results back to the model. The AI SDK handles this automatically.

在 AI SDK 3.4 中，我们将这一功能扩展至 `streamText`。此举旨在满足用户对“支持工具交互的实时流式响应”的高频需求。该功能的核心优势在于：您无需再手动编排“检测工具调用 → 获取结果 → 将结果反馈给模型”的流程——AI SDK 将自动完成全部处理。

This functionality enables multi-step use cases:

该功能支持多种多步交互场景：

The example above uses `streamText` with steps to give the model to automatically call any necessary tools to successfully fulfill the users query.

上述示例通过在 `streamText` 中启用 `steps`，使模型能够自动调用任意必要工具，从而成功响应用户的查询。

```tsx
import { z } from 'zod';

import { streamText, tool } from 'ai';​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​‌​﻿‍​‌﻿​﻿‌﻿‍‍‌​​﻿‌‌‌‌​﻿‌﻿​﻿‌‍‌‍​﻿‌﻿‌﻿‌﻿‌﻿‌‍​‍‌‍‌​‌‍‌﻿‌﻿‌‍‌﻿‍‍‌​‌​‌​‌﻿​﻿​﻿‌​‍‍‌‌​﻿‌​﻿﻿​‍‌‍‌﻿‌​​﻿﻿‌‌‍‌‌​‍​‍‌﻿﻿‌

```typescript
import { openai } from '@ai-sdk/openai';



const result = await streamText({

6  model: openai('gpt-4o'),

7  messages,

8  tools: {

9    listOrders: tool({

10      description: "list all orders",

11      parameters: z.object({ userId: z.string() }),

12      execute: async ({ userId }) => getOrders(userId)
```

```typescript
import { openai } from '@ai-sdk/openai';



const result = await streamText({

6  model: openai('gpt-4o'),

7  messages,

8  tools: {

9    listOrders: tool({

10      描述: "列出所有订单",

11      参数: z.object({ userId: z.string() }),

12      执行: async ({ userId }) => getOrders(userId)
```

13    }),

13    }），

14    viewTrackingInformation: tool({

14    viewTrackingInformation: tool（{

15      description: "view tracking information for a specific order",

15      description: “查看特定订单的物流跟踪信息”，

16      parameters: z.object({ orderId: z.string() }),

16      parameters: z.object({ orderId: z.string() }),

17      execute: async ({ orderId }) => getTrackingInformation({ orderId })

17      execute: async ({ orderId }) => getTrackingInformation({ orderId })

18    }),

18    }），

19  },

19  }，

20  maxSteps: 3,

20  maxSteps: 3，

21  onStepFinish({ toolResults, usage }) {

21  onStepFinish({ toolResults, usage }) {

22    // your own logic

22    // 您自定义的逻辑

23    // e.g. saving chat history or recording usage for each step

23    // 例如：保存聊天记录，或为每一步操作记录使用情况

24  },

24  },

25  onFinish({ steps }) {

25  onFinish({ steps }) {

26    // your own logic

26    // 您自定义的逻辑

27    // e.g. saving chat history or recording usage for the entire generation

27    // 例如：保存完整聊天记录，或为整个生成过程记录使用情况

28  }

28  }

29});​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍​‍﻿﻿‌‍​‌‌﻿​​‌‍‍‌​‍﻿﻿‌‍​‍‌‍﻿​‌‍﻿﻿‌‍‌﻿​‍﻿﻿‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​​﻿﻿﻿‌‍‌‌​﻿﻿‌​﻿​‌​﻿‍​‌﻿​﻿‌﻿‍‍‌​​﻿‌‌‌‌​﻿‌﻿​﻿‌‍‌‍​﻿‌﻿‌﻿‌﻿‌﻿‌‍​‍‌‍‌​‌‍‌﻿‌﻿‌‍‌﻿‍‍‌​‌​‌​‌﻿​﻿​﻿‌​‍‍‌‌​﻿‌​﻿﻿​‍‌‍‌﻿‌​​﻿﻿‌‌‍‌‌​‍​‍‌﻿﻿‌

```

Steps are a great option for any use case that requires the model to use multiple tools in succession to gather the necessary information and provide an accurate response to the user's query.

```

“步骤（Steps）”是任何需要模型依次调用多个工具、以收集必要信息并准确回应用户查询的场景的理想选择。

To access intermediate tool calls and results from each step, you can use the [`steps`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#steps) property in the result object. You can also provide an [`onStepFinish`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#onstepfinish-callback) callback that is triggered when a step is finished. Additionally, you can access `steps` in the `onFinish` callback, which allows you to work with the complete set of steps once the entire generation is complete.

如需访问每一步中的中间工具调用及其结果，您可在结果对象中使用 [`steps`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#steps) 属性。您还可提供一个 [`onStepFinish`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#onstepfinish-callback) 回调函数，该函数将在每一步完成时被触发。此外，在 `onFinish` 回调中您同样可以访问 `steps`，从而在整轮生成全部完成后，对完整的步骤集合进行处理。

Check out the [multi-step example in action](https://ai-sdk-preview-roundtrips.vercel.app/) and [deploy your own](https://vercel.com/templates/next.js/ai-sdk-roundtrips).

请体验 [多步骤示例的实际运行效果](https://ai-sdk-preview-roundtrips.vercel.app/)，并 [部署您自己的版本](https://vercel.com/templates/next.js/ai-sdk-roundtrips)。

## **Tracing improvements**

## **追踪功能改进**

In the last release of the AI SDK, we [introduced support for OpenTelemetry](https://vercel.com/blog/vercel-ai-sdk-3-3#tracing) to collect telemetry data, providing you with insights into your AI operations. [OpenTelemetry](https://opentelemetry.io/) is an open-source observability framework that offers standardized instrumentation for collecting telemetry data.

在上一个 AI SDK 版本中，我们[引入了对 OpenTelemetry 的支持](https://vercel.com/blog/vercel-ai-sdk-3-3#tracing)，用于采集遥测数据，帮助您深入洞察 AI 操作的运行状况。[OpenTelemetry](https://opentelemetry.io/) 是一个开源可观测性框架，提供标准化的插桩（instrumentation）能力，用于统一采集遥测数据。

Since this launch, several observability platforms have created integration guides for using tracing with the AI SDK. These include:

自该版本发布以来，多家可观测性平台已为 AI SDK 的追踪功能编写了集成指南，包括：

- [Braintrust 的 AI SDK 追踪使用指南](https://www.braintrust.dev/docs/guides/tracing#vercel-ai-sdk)

- [Langfuse 关于 AI SDK 的集成文档](https://langfuse.com/docs/integrations/vercel-ai-sdk)

- [Arize AI 为 AI SDK 提供的 OpenInference 包](https://github.com/Arize-ai/openinference/tree/main/js/packages/openinference-vercel)

In 3.4, we've enhanced our tracing capabilities to align more closely with [OpenTelemetry Semantic Conventions for GenAI operations](https://opentelemetry.io/docs/specs/semconv/gen-ai/gen-ai-spans/). We've added new attributes such as the **response ID**, **response model**, and **response timestamp**, as well as performance metrics like **time to first chunk** and **average output tokens per second**.

在 3.4 版本中，我们增强了追踪能力，使其更紧密地遵循 [OpenTelemetry 生成式 AI（GenAI）操作语义规范](https://opentelemetry.io/docs/specs/semconv/gen-ai/gen-ai-spans/)。我们新增了多项属性，例如 **响应 ID（response ID）**、**响应模型（response model）** 和 **响应时间戳（response timestamp）**，同时还增加了诸如 **首块响应耗时（time to first chunk）** 和 **平均每秒输出 token 数（average output tokens per second）** 等性能指标。

These improvements enable more accurate cost tracking, facilitate user feedback collection, and allow for the creation of detailed performance dashboards. Check out [the telemetry documentation](https://sdk.vercel.ai/docs/ai-sdk-core/telemetry) to learn more.

这些改进有助于实现更精准的成本核算、更便捷地收集用户反馈，并支持构建详尽的性能仪表盘。欲了解更多信息，请参阅 [遥测文档](https://sdk.vercel.ai/docs/ai-sdk-core/telemetry)。

## Mock models and testing

## 模拟模型与测试

Testing language models can be challenging as they are non-deterministic and slow and expensive to call. In 3.4, we are releasing mock providers and test helpers to allow you to unit test your code. Here’s an example of how you would create a mock response with `generateText`:

对语言模型进行测试颇具挑战性，因其具有非确定性，且调用过程缓慢、成本高昂。在 3.4 版本中，我们推出了模拟（mock）提供方（providers）和测试辅助工具，助您对代码开展单元测试。以下是如何使用 `generateText` 创建模拟响应的示例：

```tsx
import { generateText } from 'ai';

import { MockLanguageModelV1 } from 'ai/test';



const result = await generateText({

5  model: new MockLanguageModelV1({

6    doGenerate: async () => ({

7      rawCall: { rawPrompt: null, rawSettings: {} },

8      finishReason: 'stop',

9      usage: { promptTokens: 10, completionTokens: 20 },

10      text: `Hello, world!`,
```

11    }),

12  }),

13  prompt: 'Hello, test!',

14});
```

这些工具允许您控制 AI SDK 的输出，并在不实际调用语言模型服务商的前提下，以可重复、确定性的方式测试您的代码。欲了解更多信息，请参阅[测试文档](https://sdk.vercel.ai/docs/ai-sdk-core/testing)。

## **服务商更新**

我们扩展了对各类服务商的支持，以提供更丰富的选项并全面提升整体性能。此次更新既包括为现有服务商新增的功能，也涵盖新增的嵌入（embedding）模型支持。

- [**Anthropic**](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic)：新增对[prompt 缓存](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic#example-cache-control)的支持，助力构建成本更低、响应更快的应用。

- [**Amazon Bedrock**](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock)：新增对 Amazon Bedrock 安全护栏（Guardrails）的支持，使您能够实施安全防护机制，并对模型输出进行干预与调整。

- [**Cohere**](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere)：新增对嵌入模型（embedding model）的支持。

- [**OpenAI**](https://sdk.vercel.ai/providers/ai-sdk-providers/openai): 新增对新式结构化输出（structured outputs）功能的支持，可生成严格符合指定 Schema 的 JSON 输出，并支持基于该 JSON 调用工具。新增对 `o1-preview` 和 `o1-mini` 等推理模型（reasoning models）的[推理令牌（reasoning tokens）支持](https://sdk.vercel.ai/providers/ai-sdk-providers/openai#reasoning-models)。

- [**Google Generative AI**](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai): 为 Gemini 模型新增[搜索增强（search grounding）支持](https://x.com/rauchg/status/1823386817086832784)，使模型能够访问最新信息。同时新增嵌入模型（embedding model）支持。

- [**Mistral**](https://sdk.vercel.ai/providers/ai-sdk-providers/mistral): 为 [Pixtral](https://mistral.ai/news/pixtral-12b/) 模型新增图像（image）输入支持。

- [**LlamaIndex**](https://sdk.vercel.ai/providers/adapters/llamaindex): 新增适配器（adapter），支持在 AI SDK 中直接使用 LlamaIndex 提供的工具与抽象层。

- **新增社区提供商（Community Providers）**: [Cloudflare Workers AI](https://sdk.vercel.ai/providers/community-providers/cloudflare-workers-ai)、[Portkey](https://sdk.vercel.ai/providers/community-providers/portkey)、[Anthropic Vertex](https://sdk.vercel.ai/providers/community-providers/anthropic-vertex-ai)、[FriendliAi](https://sdk.vercel.ai/providers/community-providers/friendliai)。

## **入门指南**

## Getting started

借助语言模型中间件（language model middleware）、数据流协议（data stream protocol）及多步生成（multi-step generations）等全新功能，现在正是使用 AI SDK 构建 AI 应用的最佳时机。

- **启动一个全新的 AI 项目**：准备开始构建新项目了吗？请查阅我们的[最新入门指南](https://sdk.vercel.ai/docs/guides)。

- **探索模板库**：访问我们的[模板画廊（Template Gallery）](https://vercel.com/templates?type=ai)，直观了解 AI SDK 的实际应用效果，并为您的下一个项目获取灵感。

- **加入社区**：欢迎在我们的 [GitHub Discussions](https://github.com/vercel/ai/discussions/1914) 中分享您正在使用 AI SDK 构建的项目！

**What's next?** AI SDK 4.0 will be a maintenance release in which experimental features will be promoted to stable, and deprecated features will be removed.

**接下来是什么？** AI SDK 4.0 将是一次维护性版本发布，其中实验性功能将转为稳定版，而已弃用的功能将被移除。

## Contributors

## 贡献者

AI SDK 3.4 是 Vercel 核心团队与众多社区贡献者通力协作的成果。

特别感谢以下提交并成功合并了 Pull Request 的贡献者：

[DBvc](https://github.com/DBvc), [nikhilsnayak,](https://github.com/nikhilsnayak) [codybrouwers,](https://github.com/codybrouwers) [jackwilson323,](https://github.com/jackwilson323) [axel-rock,](https://github.com/axel-rock) [waigel,](https://github.com/waigel) [blechatellier,](https://github.com/blechatellier) [danielgavrilov,](https://github.com/danielgavrilov) [shoopapa,](https://github.com/shoopapa) [dyeoman2,](https://github.com/dyeoman2) [nalaso,](https://github.com/nalaso) [yoshinorisano,](https://github.com/yoshinorisano) [narengogi,](https://github.com/narengogi) [minpeter,](https://github.com/minpeter) [shaper,](https://github.com/shaper) [ggallon,](https://github.com/ggallon) [siddharthsambharia-portkey,](https://github.com/siddharthsambharia-portkey) [OscarBarrett](https://github.com/OscarBarrett) , [seuha516,](https://github.com/seuha516) [Saran33,](https://github.com/Saran33) [ahnjaeshin,](https://github.com/ahnjaeshin) [thucpn,](https://github.com/thucpn) [kexiZeroing,](https://github.com/kexiZeroing) [huozhi,](https://github.com/huozhi) [AbhiShake1,](https://github.com/AbhiShake1) [mikkokut](https://github.com/mikkokut), [marcusschiesser](https://github.com/marcusschiesser).

您的反馈与贡献对我们持续演进 AI SDK 至关重要。
{% endraw %}
