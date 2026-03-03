---
title: "Vercel AI SDK 3.1: ModelFusion joins the team - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-ai-sdk-3-1-modelfusion-joins-the-team"
date: "2024-05-02"
scraped_at: "2026-03-02T09:45:20.124108405+00:00"
language: "en-zh"
translated: true
description: "ModelFusion joins Vercel "
---

May 2, 2024

2024 年 5 月 2 日

向构建完整的 TypeScript AI 应用框架迈出关键一步

Today, we're releasing the AI SDK 3.1, with [ModelFusion](https://modelfusion.dev/) joining our team.

今天，我们正式发布 AI SDK 3.1 版本，并迎来 [ModelFusion](https://modelfusion.dev/) 加入我们的团队。

This release brings us one step closer to delivering a **complete TypeScript framework for building AI applications**. It is organized into three main parts:

此次发布使我们向交付一个**用于构建 AI 应用的完整 TypeScript 框架**又迈进了一步。该框架由以下三个核心部分组成：

- [**AI SDK Core**](https://sdk.vercel.ai/docs/ai-sdk-core): A unified API for generating text, structured objects, and tool calls with large language models (LLMs).

- [**AI SDK Core**](https://sdk.vercel.ai/docs/ai-sdk-core)：面向大语言模型（LLM）的统一 API，支持文本生成、结构化对象生成及工具调用。

- [**AI SDK UI**](https://sdk.vercel.ai/docs/ai-sdk-ui): A set of framework-agnostic hooks for quickly building chat interfaces.

- [**AI SDK UI**](https://sdk.vercel.ai/docs/ai-sdk-ui)：一套与框架无关的 React Hook，可快速构建聊天界面。

- [**AI SDK RSC**](https://sdk.vercel.ai/docs/ai-sdk-rsc): A library to stream generative user interfaces with React Server Components (RSC).

- [**AI SDK RSC**](https://sdk.vercel.ai/docs/ai-sdk-rsc)：一个基于 React Server Components（RSC）流式渲染生成式用户界面的库。

A streaming Node.js chatbot built with the AI SDK Core APIs

一个基于 AI SDK Core API 构建的流式 Node.js 聊天机器人

## AI SDK Core - A new foundation for AI

## AI SDK Core —— AI 开发的新基石

Drawing inspiration from projects like Drizzle and Prisma, you can imagine the AI SDK Core as an **ORM-style abstraction for LLMs**.

受 Drizzle 和 Prisma 等项目启发，你可以将 AI SDK Core 视为一种**面向大语言模型（LLM）的 ORM 风格抽象层**。

These new APIs provide a set of unified, low-level primitives to work with LLMs in any JavaScript environment—abstracting away the quirks between major model providers. This simplifies integrating LLMs down to just two decisions:

这些新 API 提供了一组统一的、底层的原语，可在任意 JavaScript 环境中与大语言模型（LLM）协同工作——屏蔽了主流模型提供商之间的差异与兼容性问题。这将 LLM 集成简化为仅需做出两个关键决策：

- What kind of data do you want to generate? (text or a structured object)

- 您希望生成何种类型的数据？（纯文本，还是结构化对象）

- How do you want it delivered? (incrementally streamed or all-at-once)

- 您希望以何种方式获取结果？（增量流式传输，还是一次性返回全部结果）

![](images/vercel-ai-sdk-3_1-modelfusion-joins-the-team-vercel/img_001.jpg)![](images/vercel-ai-sdk-3_1-modelfusion-joins-the-team-vercel/img_002.jpg)

You can use the AI SDK Core API with any provider that implements the [AI SDK Language Model Specification](https://sdk.vercel.ai/providers/community-providers/custom-providers). We worked with major AI model providers to iterate on the Vercel AI SDK Core, and already support:

您可将 AI SDK Core API 与任何实现了 [AI SDK 语言模型规范（AI SDK Language Model Specification）](https://sdk.vercel.ai/providers/community-providers/custom-providers) 的服务商配合使用。我们携手主流 AI 模型提供商共同迭代优化 Vercel AI SDK Core，目前已支持以下服务商：

- **OpenAI**

- **OpenAI**

- **Anthropic**

- **Anthropic**

- **Google Gemini**

- **Google Gemini**

- **Mistral**

- **Mistral**

The Language Model Specification is open-source. Anyone can now build AI provider integrations that work seamlessly with the Vercel AI SDK, and our amazing community has already started to add support for providers such as LLamaCpp.

该语言模型规范（Language Model Specification）完全开源。如今，任何人皆可基于此规范构建与 Vercel AI SDK 无缝协作的 AI 服务商集成；而我们出色的社区开发者已率先为 LLamaCpp 等服务商添加了支持。

### Generating text

### 生成文本

Here’s an example of generating text with AI SDK Core using the `mistral-large-latest` model from [Mistral AI](https://mistral.ai/).

以下是一个使用 AI SDK Core 和 [Mistral AI](https://mistral.ai/) 的 `mistral-large-latest` 模型生成文本的示例。

```tsx
import { generateText } from 'ai';

import { mistral } from '@ai-sdk/mistral';‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌



const { text } = await generateText({

5  model: mistral("‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌mistral-large-latest‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌"),

6  prompt: "Generate a lasangna recipe.",

7});﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌
```

如果希望将模型切换为 OpenAI 的 `gpt-4-turbo`，只需修改两行代码即可。

```tsx
import { generateText } from 'ai';

import { openai } from '@ai-sdk/openai';



const { text } = await generateText({

5  model: openai("gpt-4-turbo"),

6  prompt: "Generate a lasagna recipe.",

7});‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌
```

```tsx
import { generateText } from 'ai';

import { openai } from '@ai-sdk/openai';



const { text } = await generateText({

5  model: openai("gpt-4-turbo"),

6  prompt: "生成一份千层面食谱。",

7});‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌
```

### Generating Structured Data

### 生成结构化数据

The Vercel AI SDK standardizes structured object generation across model providers with the `generateObject` and `streamObject` functions. Generating fully typed objects is as simple as defining a [Zod schema](https://sdk.vercel.ai/docs/ai-sdk-core/schemas-and-zod) and passing it to your function call.

Vercel AI SDK 通过 `generateObject` 和 `streamObject` 函数，在不同模型提供商之间统一了结构化对象的生成方式。要生成完全类型化的对象，只需定义一个 [Zod schema](https://sdk.vercel.ai/docs/ai-sdk-core/schemas-and-zod)，并将其传入函数调用即可。

```tsx
import { generateObject } from 'ai'
```

```typescript
import { z } from 'zod'

import { openai } from '@ai-sdk/openai';



const { object } = await generateObject({

6  model: openai('gpt-4-turbo'),

7  schema: z.object({

8    recipe: z.object({

9      name: z.string().describe('name of recipe'),

10      ingredients: z.array(

11        z.object({
```

```typescript
import { z } from 'zod'

import { openai } from '@ai-sdk/openai';



const { object } = await generateObject({

6  model: openai('gpt-4-turbo'),

7  schema: z.object({

8    recipe: z.object({

9      名称: z.string().describe('菜谱名称'),

10      食材: z.array(

11        z.object({
```

12          name: z.string().describe('ingredient name'),

12          名称：z.string().describe('食材名称'),

13          amount: z.string().describe('amount of ingredient')

13          用量：z.string().describe('食材用量')

14        })

14        })

15      ),

15      ),

16      steps: z.array(z.string()).describe('steps to prepare recipe')

16      步骤：z.array(z.string()).describe('制作食谱的步骤')

17    })

17    })

18  }),

18  }),

19  prompt: 'Generate a lasagna recipe.'

19  prompt: '生成一份千层面食谱。'

20})
20})

The model returns a validated and type-safe object — in this case, a lasagna recipe — based on your predetermined schema.

该模型根据您预先定义的 Schema，返回一个经过验证且类型安全的对象——在本例中，即一份千层面食谱。

```json
1{

2  "name": "Classic Lasagna",

3  "ingredients": [\
\
4    {\
\
5      "name": "Olive oil",\
\
6      "amount": "2 tablespoons"\
\
7    },\
\
8    ...\
\
9  ],

10  "steps": [\
\
11    "Preheat oven to 375°F (190°C).",\
\
12    "In a large skillet, heat olive oil over medium heat. Add ground beef, onion, and garlic. Cook until beef is browned.",\
\
13    ...\
\
14  ]

15}
```

## AI SDK UI — 几秒钟内构建聊天界面

流式对话文本界面（如 ChatGPT）在过去一年中广受欢迎。然而，实现一个基础的聊天界面仍需编写大量复杂样板代码：包括状态管理（跟踪用户输入、对话历史、加载状态）、解析与处理流式文本的逻辑、用于管理持久化数据的生命周期钩子等。

AI SDK UI 将主流 AI 界面的实现大幅简化为三个与框架无关的 Hook：`useChat`、`useCompletion` 和 `useAssistant`。配合 AI SDK Core 提供的 `streamText` 函数，你仅需不到 50 行代码即可构建一个支持流式响应的聊天机器人。

app/api/chat/route.ts

```tsx
import { streamText } from 'ai';
```

```typescript
import { openai } from '@ai-sdk/openai';

import { openai } from '@ai-sdk/openai';

export async function POST(req: Request) {

export async function POST(req: Request) {

5  const { messages } = await req.json();

5  const { messages } = await req.json();

7  const result = await streamText({

7  const result = await streamText({

8    model: openai('gpt-4-turbo'),

8    model: openai('gpt-4-turbo'),

9    messages,

9    messages,

10  });

10  });
```

12  return result.toAIStreamResponse();

12  返回 result.toAIStreamResponse()；

13}
```

app/page.tsx

```
app/page.tsx
```

```tsx
1'use client'



import { useChat } from 'ai/react'



export default function Page() {

6  const { messages, input, handleInputChange, handleSubmit } = useChat();
```

```tsx
1'使用客户端组件'



import { useChat } from 'ai/react'



export default function Page() {

6  const { messages, input, handleInputChange, handleSubmit } = useChat();
```

8  return (

8  返回（

9    <>

9    <>

10      {messages.map(message => (

10      {messages.map(message => (

11        <div key={message.id}>

11        <div key={message.id}>

12          {message.role === 'user' ? 'User: ' : 'AI: '}

12          {message.role === 'user' ? '用户：' : 'AI：'}

13          {message.content}

13          {message.content}

14        </div>

14        </div>

15      ))}

15      ))}

16      <form onSubmit={handleSubmit}>

16      <form onSubmit={handleSubmit}>

17        <input

17        <input

18          name="prompt"

18          name="prompt"

19          value={input}

19          value={input}

20          onChange={handleInputChange}

20          onChange={handleInputChange}

21          id="input"

21          id="input"

22        />

22        />

23        <button type="submit">Submit</button>

23        <button type="submit">提交</button>

24      </form>

24      </form>

25    </>

25    </>

26  )

26  )

27}

27}

In this [Next.js App Router](https://nextjs.org/docs/app) example, the `useChat` hook enables streaming chat messages from OpenAI, manages the chat state, and updates the UI automatically as new messages arrive.

在此 [Next.js App Router](https://nextjs.org/docs/app) 示例中，`useChat` 钩子支持从 OpenAI 流式传输聊天消息、管理聊天状态，并在新消息到达时自动更新用户界面。

## AI SDK RSC - Move beyond text

## AI SDK RSC — 超越纯文本

While AI chatbots have made a profound impact, LLM applications have faced two important UX challenges:

尽管 AI 聊天机器人已产生深远影响，大语言模型（LLM）应用仍面临两大关键用户体验（UX）挑战：

- Limited or imprecise knowledge  
- Plain text or markdown-only responses  

- 知识有限或不够精准  
- 仅支持纯文本或 Markdown 格式的响应  

With the introduction of [Tools and Tool Calling](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling), developers can build more robust applications that fetch realtime data.

随着 [工具（Tools）与工具调用（Tool Calling）](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling) 的引入，开发者能够构建更强大的应用，实时获取外部数据。

With Vercel AI SDK RSC, you can now move beyond text-based chatbots to give LLMs rich, component-based interfaces.

借助 Vercel AI SDK RSC，您现在可以突破纯文本聊天机器人的局限，为大语言模型提供丰富、基于组件的用户界面。

In today's release, we're adding `streamUI`, a new function that's compatible with AI SDK Core Language Model Specification. This is the successor to `render` (which we plan to deprecate in the next minor release).

在本次发布中，我们新增了 `streamUI` 函数——一个兼容 AI SDK Core 语言模型规范（Language Model Specification）的新函数。它是 `render` 函数的继任者（我们计划在下一个次要版本中将其弃用）。

Let’s look at an example React Server Action that can retrieve the live weather and render a custom UI with `streamUI`.

下面我们来看一个 React Server Action 示例，它可获取实时天气信息，并通过 `streamUI` 渲染自定义用户界面。

```jsx
import { streamUI } from 'ai/rsc'
```

```markdown
import { openai } from '@ai-sdk/openai'

import { z } from 'zod'

import { Spinner, Weather } from '@/components'

import { getWeather } from '@/utils'



async function submitMessage(userInput) { // 'What is the weather in SF?'

async function submitMessage(userInput) { // “旧金山的天气如何？”

8  'use server'

8  'use server'

10  const result = streamUI({

10  const result = streamUI({

11    model: openai('gpt-4-turbo'),

11    model: openai('gpt-4-turbo'),
```

12    messages: [\
\
13      { role: 'system', content: 'You are a helpful assistant' },\
\
14      { role: 'user', content: userInput }\
\
15    ],

12    消息列表：[\
\
13      { role: 'system', content: '你是一个乐于助人的助手' },\
\
14      { role: 'user', content: userInput }\
\
15    ],

16    text: ({ content }) => <p>{content}</p>,

16    文本渲染函数：({ content }) => <p>{content}</p>,

17    tools: {

17    工具集：{

18      get_city_weather: {

18      get_city_weather：{

19        description: 'Get the current weather for a city',

19        描述：'获取某城市的当前天气',

20        parameters: z.object({

20        参数：z.object({

21          city: z.string().describe('the city')

21          city：z.string().describe('城市名称')

22        }).required(),

22        }).required(),

23        generate: async function* ({ city }) {

23        generate：async function* ({ city }) {

24          yield <Spinner/>

24          yield <Spinner/>

25          const weather = await getWeather(city)

25          const weather = await getWeather(city)

26          return <Weather info={weather} />

26          return <Weather info={weather} />

27        }

27        }

28      }

28      }

29    }

29    }

30  })

30  })



32  return result.value

32  return result.value

33}
33}

```

What is the weather in SF?

```
旧金山的天气如何？

`getWeather("San Francisco, CA")`

`getWeather("旧金山，加利福尼亚州")`

Thursday, March 7

3月7日，星期四

47°

47°F（约8.3°C）

sunny

晴

7am

上午7点

48°

48°F（约8.9°C）

8am

上午8点

50°

50°F（约10°C）

9am

上午9点

52°

52°F（约11.1°C）

10am

上午10点

54°

54°F

11am

上午11点

56°

56°F

12pm

中午12点

58°

58°F

1pm

下午1点

60°

60°F

Thanks!

谢谢！

Weather

天气

Play

播放

An example of an assistant that renders the weather information in a streamed component.

一个示例助手，以流式组件形式渲染天气信息。

## Towards a complete TypeScript AI framework

## 迈向完整的 TypeScript AI 框架

The Vercel AI SDK 3.1 marks an important step towards delivering a complete TypeScript AI Framework.

Vercel AI SDK 3.1 是迈向交付完整 TypeScript AI 框架的重要一步。

- With the **AI SDK Core**, you get a unified API for calling LLMs that works anywhere JavaScript or TypeScript runs.

- 借助 **AI SDK Core**，您将获得一个统一的 API，用于调用大语言模型（LLM），该 API 可在任何支持 JavaScript 或 TypeScript 的环境中运行。

- With the **AI SDK UI**, you can build chat interfaces in seconds with framework-agnostic hooks.

- 借助 **AI SDK UI**，您可借助与框架无关的 Hooks，在数秒内构建聊天界面。

- Finally, with the **AI SDK RSC**, you can go beyond chat interfaces to deliver the next generation of AI native applications with Generative UI.

- 最后，借助 **AI SDK RSC**，您可突破传统聊天界面的限制，利用生成式用户界面（Generative UI）打造新一代原生 AI 应用。

You can learn more in **our new** [**documentation**](https://sdk.vercel.ai/docs) or experiment with different models using the [AI playground](https://sdk.vercel.ai/).

您可在我们全新的 [**文档**](https://sdk.vercel.ai/docs) 中了解更多信息，或通过 [AI Playground](https://sdk.vercel.ai/) 尝试不同模型。

[**Explore the possibilities**\\
\\
Talk to our team to learn more about building AI-powered applications for your organization. \\
\\
Get started](https://vercel.com/contact)

[**探索无限可能**\\
\\
联系我们的团队，深入了解如何为您的组织构建 AI 驱动的应用程序。\\
\\
立即开始](https://vercel.com/contact)