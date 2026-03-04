---
title: "AI SDK 4.1 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-4-1"
date: "2025-01-20"
scraped_at: "2026-03-02T09:37:58.599555072+00:00"
language: "en-zh"
translated: true
description: "AI SDK 4.1 introduces image generation, non-blocking data streaming, improved tool calling, and more"
---

render_with_liquid: false
Jan 20, 2025

2025 年 1 月 20 日

Introducing image generation, non-blocking data streaming, improved tool calling, and more.

新增图像生成、非阻塞数据流、改进的工具调用等功能。

The [AI SDK](https://sdk.vercel.ai/) is an open-source toolkit for building AI applications with JavaScript and TypeScript. Its unified provider API allows you to use any language model and enables powerful UI integrations into leading web frameworks such as [Next.js](https://nextjs.org/) and [Svelte](https://svelte.dev/).

[AI SDK](https://sdk.vercel.ai/) 是一个开源工具包，用于使用 JavaScript 和 TypeScript 构建 AI 应用。其统一的 Provider API 支持接入任意大语言模型，并可深度集成主流 Web 框架（如 [Next.js](https://nextjs.org/) 和 [Svelte](https://svelte.dev/)），实现强大的 UI 交互能力。

Since our 4.0 release, we've seen some incredible products powered by the AI SDK:

自 4.0 版本发布以来，我们已见证多款由 AI SDK 驱动的卓越产品：

- [Languine](https://languine.ai/en) is an open-source CLI tool that automates application localization, detecting translation changes and maintaining consistent tone across all major i18n libraries.

- [Languine](https://languine.ai/en) 是一款开源命令行工具，可自动化应用本地化流程，自动检测翻译变更，并在所有主流 i18n 库中保持语调一致。

- [Scira](https://scira.app/) is a minimalist AI-powered search engine, using the AI SDK to power search-grounded LLM responses and powerful generative UI interactions.

- [Scira](https://scira.app/) 是一款极简风格的 AI 搜索引擎，依托 AI SDK 实现基于搜索结果的大语言模型响应，以及强大的生成式 UI 交互体验。

- [Fullmoon](https://fullmoon.app/) enables cross-platform chat with private local LLMs, bringing secure AI conversations to everyone.

- [Fullmoon](https://fullmoon.app/) 支持跨平台聊天，运行私有本地大语言模型（LLM），让安全可靠的 AI 对话触手可及。

![](images/ai-sdk-4_1-vercel/img_001.jpg)

![](images/ai-sdk-4_1-vercel/img_001.jpg)

Check out [Languine](https://languine.ai/), an AI-powered CLI and pipeline designed to automate translations for developers

欢迎了解 [Languine](https://languine.ai/) —— 一款面向开发者的 AI 驱动型命令行工具与流水线系统，专为自动化翻译而设计。

Each of these projects is open-source ( [Languine](https://github.com/midday-ai/languine), [Scira](https://github.com/zaidmukaddam/scira), [Fullmoon](https://github.com/mainframecomputer/fullmoon-web)), giving you the opportunity to explore how these AI-powered applications are built.

上述所有项目均为开源项目（[Languine](https://github.com/midday-ai/languine)、[Scira](https://github.com/zaidmukaddam/scira)、[Fullmoon](https://github.com/mainframecomputer/fullmoon-web)），为您提供深入学习这些 AI 应用构建方式的宝贵机会。

Today, we're announcing the release of AI SDK 4.1, which introduces [image generation capabilities](https://vercel.com/blog/ai-sdk-4-1#image-generation). This update allows developers to generate images through a unified API that works seamlessly across providers like [Replicate](https://replicate.com/), [OpenAI](https://openai.com/), [Google Vertex](https://cloud.google.com/vertex-ai), and [Fireworks](https://fireworks.ai/).

今天，我们宣布发布 AI SDK 4.1 版本，该版本新增了[图像生成功能](https://vercel.com/blog/ai-sdk-4-1#image-generation)。此次更新使开发者能够通过统一的 API 生成图像，该 API 可无缝兼容多家服务商，包括 [Replicate](https://replicate.com/)、[OpenAI](https://openai.com/)、[Google Vertex](https://cloud.google.com/vertex-ai) 和 [Fireworks](https://fireworks.ai/)。

Along with image generation, this release includes:

除图像生成功能外，本次发布还包括：

- [Stream transformation & smoothing](https://vercel.com/blog/ai-sdk-4-1#stream-transformation-&-smoothing)

- [流式传输转换与平滑处理](https://vercel.com/blog/ai-sdk-4-1#stream-transformation-&-smoothing)

- [Simplified persistence with useChat](https://vercel.com/blog/ai-sdk-4-1#simplified-persistence-with-usechat)

- [借助 useChat 简化持久化](https://vercel.com/blog/ai-sdk-4-1#simplified-persistence-with-usechat)

- [Non-blocking data streaming](https://vercel.com/blog/ai-sdk-4-1#non-blocking-data-streaming)

- [非阻塞式数据流传输](https://vercel.com/blog/ai-sdk-4-1#non-blocking-data-streaming)

- [Tool-calling improvements](https://vercel.com/blog/ai-sdk-4-1#tool-calling-improvements)

- [工具调用功能改进](https://vercel.com/blog/ai-sdk-4-1#tool-calling-improvements)

- [Structured output improvements](https://vercel.com/blog/ai-sdk-4-1#structured-output-improvements)

- [结构化输出功能改进](https://vercel.com/blog/ai-sdk-4-1#structured-output-improvements)

- [New and updated providers](https://vercel.com/blog/ai-sdk-4-1#new-and-updated-providers)

- [新增及更新的服务商支持](https://vercel.com/blog/ai-sdk-4-1#new-and-updated-providers)

Let's explore these new features and improvements.

让我们一起探索这些新特性和改进之处。

## Image generation

## 图像生成

Generating images from text prompts is a novel generative AI capability that enables new types of applications and workflows. The ecosystem is growing rapidly, with providers such as Replicate supporting hundreds of different image generation models, adding more and more every day.

通过文本提示生成图像是生成式 AI 的一项全新能力，能够赋能各类新型应用与工作流。该生态正飞速发展，以 Replicate 为代表的提供商已支持数百种不同的图像生成模型，并且每日持续新增。

With AI SDK 4.1, we're taking our first step towards enabling multi-modal outputs by introducing support for image generation through the new experimental [`generateImage`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/generate-image#generateimage) function.

在 AI SDK 4.1 中，我们迈出支持多模态输出的第一步：通过全新的实验性 [`generateImage`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/generate-image#generateimage) 函数，正式引入图像生成功能。

```javascript
import { experimental_generateImage as generateImage } from 'ai';

import { replicate } from '@ai-sdk/replicate';



const { image } = await generateImage({

5  model: replicate.image('black-forest-labs/flux-1.1-pro-ultra'),

6  prompt: 'A futuristic cityscape at sunset',

7});
```

![](images/ai-sdk-4_1-vercel/img_002.jpg)

Image generated with Replicate's [black-forest-labs/flux-1.1-pro-ultra](https://replicate.com/black-forest-labs/flux-1.1-pro-ultra) model

使用 Replicate 的 [black-forest-labs/flux-1.1-pro-ultra](https://replicate.com/black-forest-labs/flux-1.1-pro-ultra) 模型生成的图像

Switching between AI providers is as simple as changing 2 lines of code - your prompt and settings remain unchanged:

切换 AI 服务提供商只需修改两行代码——您的提示词（prompt）和配置保持不变：

```javascript
import { experimental_generateImage as generateImage } from 'ai';

import { fireworks } from '@ai-sdk/fireworks';



const { image } = await generateImage({

5  model: fireworks.image('accounts/fireworks/models/SSD-1B'),

6  prompt: 'A futuristic cityscape at sunset',

7});
```

```javascript
import { experimental_generateImage as generateImage } from 'ai';

import { fireworks } from '@ai-sdk/fireworks';



const { image } = await generateImage({

5  model: fireworks.image('accounts/fireworks/models/SSD-1B'),

6  prompt: 'A futuristic cityscape at sunset',

7});
```

![](images/ai-sdk-4_1-vercel/img_003.jpg)

Image generated with Fireworks' [SSD-1B](https://fireworks.ai/models/fireworks/SSD-1B) model

使用 Fireworks 的 [SSD-1B](https://fireworks.ai/models/fireworks/SSD-1B) 模型生成的图像

With the `generateImage` function, you have full control of parameters like:

通过 `generateImage` 函数，您可以完全控制以下参数：

- Control image dimensions with `size` or `aspectRatio`

- 使用 `size` 或 `aspectRatio` 控制图像尺寸

- Generate multiple images in parallel with `n`

- 使用 `n` 并行生成多张图像

- Access images in both base64 and uint8Array formats

- 以 base64 和 uint8Array 两种格式获取图像

- Control randomness with `seed`

- 使用 `seed` 控制随机性

Provider-specific options are also supported through the `providerOptions` parameter:

提供商专属选项也可通过 `providerOptions` 参数进行配置：

```javascript
const { image } = await generateImage({

2  model: replicate.image('black-forest-labs/flux-1.1-pro-ultra'),

3  prompt: 'A futuristic cityscape at sunset',
```

4  size: "16:9",

4  尺寸：`"16:9"`，

5  n: 3,

5  图像数量：`3`，

6  seed: 0,

6  随机种子：`0`，

7  providerOptions: {

7  提供商选项：{

8    replicate: { style: 'realistic_image' },

8    replicate: { style: 'realistic_image' }，

9  },

9  }，

10});
```

10});
```

The AI SDK supports image generation across multiple providers including [Replicate](https://sdk.vercel.ai/providers/ai-sdk-providers/replicate#image-models), [OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/openai#image-models), [Google Vertex AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex#image-models), and [Fireworks](https://sdk.vercel.ai/providers/ai-sdk-providers/fireworks#image-models).

AI SDK 支持通过多个服务商生成图像，包括 [Replicate](https://sdk.vercel.ai/providers/ai-sdk-providers/replicate#image-models)、[OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/openai#image-models)、[Google Vertex AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex#image-models) 和 [Fireworks](https://sdk.vercel.ai/providers/ai-sdk-providers/fireworks#image-models)。

Check out our [image generation demo](https://ai-sdk-image-generator.vercel.app/) to see how different providers handle the same prompts and explore the capabilities of each model.

欢迎体验我们的 [图像生成演示](https://ai-sdk-image-generator.vercel.app/)，直观对比不同服务商对同一提示词的生成效果，并深入了解各模型的具体能力。

## Stream transformation & smoothing

## 流式转换与平滑处理

AI SDK 4.1 introduces new capabilities for transforming stream output on the server. This enables powerful use cases such as:

AI SDK 4.1 引入了在服务端转换流式输出的新能力，从而支持以下强大应用场景：

- Creating smoother streaming experiences with the built-in [`smoothStream`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/smooth-stream) transform (with custom chunking options such as by character, word, line)

- 利用内置的 [`smoothStream`](https://sdk.vercel.ai/docs/reference/ai-sdk-core/smooth-stream) 转换器（支持按字符、单词、行等自定义分块方式）打造更流畅的流式响应体验

- Filtering content and applying safety guardrails

- 过滤内容并应用安全防护机制（safety guardrails）

- Any custom transformation (eg. [uppercase](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#custom-transformations))

- 任意自定义转换（例如：[转大写](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#custom-transformations)）

For example, the built-in `smoothStream` function helps create more natural text streaming by smoothing chunky or inconsistent provider responses into a smoother flow:

例如，内置的 `smoothStream` 函数可通过平滑处理来自模型提供商的粒度粗大或不一致的响应片段，从而生成更自然、更连贯的文本流：

```javascript
import { smoothStream, streamText } from 'ai';



const result = streamText({

4  model,

5  prompt,

6  experimental_transform: smoothStream(),

6  experimental_transform: smoothStream(),

7});
```

7});
```

Multiple transformations can be applied by passing them as an array:

多个转换可以通过将它们作为数组传入来同时应用：

```javascript
const result = streamText({

```javascript
const result = streamText({

2  model,

2  model,

3  prompt,

3  prompt,

4  experimental_transform: [firstTransform, secondTransform],

4  experimental_transform: [firstTransform, secondTransform],

5});
```

5});
```

Check out our [stream transformation documentation](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#stream-transformation) to learn more about configuring chunking patterns, implementing content filtering, and creating your own transformations.

请参阅我们的 [流式转换文档](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#stream-transformation)，了解如何配置分块模式、实现内容过滤，以及创建您自己的转换逻辑。

## Simplified persistence with `useChat`

## 使用 `useChat` 简化持久化

We heard your feedback that adding persistence to `useChat` is too complicated. To address this, we've added three key improvements:

我们了解到，您反馈为 `useChat` 添加持久化功能过于复杂。为此，我们新增了三项关键改进：

- Chat ID can be forwarded from the client to the server

- 聊天 ID 可从前端（客户端）传递至后端（服务器）

- Response message IDs can be forwarded from the server to the client

- 响应消息 ID 可从后端（服务器）传递至前端（客户端）

- The new `appendResponseMessages` utility unifies messages for simple saving

- 新增的 `appendResponseMessages` 工具函数可统一消息结构，简化保存逻辑

Check out our [chat persistence guide](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot-message-persistence) to learn more, or start with our [minimal example](https://github.com/vercel/ai/blob/main/examples/next-openai/app/api/use-chat-persistence/route.ts) if you prefer to dive straight into code.

欢迎查阅我们的 [聊天消息持久化指南](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot-message-persistence) 以了解详情；若您更倾向于直接上手编码，也可从我们的 [最小示例](https://github.com/vercel/ai/blob/main/examples/next-openai/app/api/use-chat-persistence/route.ts) 开始。

## Non-blocking data streaming

## 非阻塞式数据流

AI SDK 4.1 introduces powerful new streaming functionality with the [`createDataStreamResponse`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/create-data-stream-response#createdatastreamresponse) function enabling powerful use cases like streaming retrieval-augmented generation (RAG) context and search results to the client before the LLM’s response begins. Previously, streaming was limited to returning the result of a single LLM call (eg. `streamText().toDataStreamResponse()`). Now, you can create non-blocking data streams that:

AI SDK 4.1 引入了强大的新型流式传输功能，通过 [`createDataStreamResponse`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/create-data-stream-response#createdatastreamresponse) 函数，支持在大语言模型（LLM）生成响应开始前，就将检索增强生成（RAG）上下文、搜索结果等数据实时流式推送至客户端。此前，流式传输仅限于返回单次 LLM 调用的结果（例如：`streamText().toDataStreamResponse()`）。而现在，您可以创建非阻塞式数据流，其具备以下能力：

- Return immediately and allows you to stream data on-demand

- 立即返回响应，并支持按需动态推送数据

- Provide full control over when and what data is streamed

- 完全掌控数据推送的时机与内容

- Support adding annotations and metadata to messages

- 支持为消息添加注释（annotations）和元数据（metadata）

Here's an example of using `createDataStreamResponse` to stream custom data alongside LLM output:

以下是使用 `createDataStreamResponse` 在流式输出大语言模型（LLM）结果的同时，同步流式传输自定义数据的一个示例：

```javascript
import { openai } from "@ai-sdk/openai";

import { createDataStreamResponse, Message, streamText } from "ai";

import { getRelevantContent } from "./get-relevant-content"; // user-defined

import { openai } from "@ai-sdk/openai";

import { createDataStreamResponse, Message, streamText } from "ai";

import { getRelevantContent } from "./get-relevant-content"; // 用户自定义
```


export async function POST(req: Request) {

6  const { messages }: { messages: Message[] } = await req.json();



8  const lastMessage = messages.pop();

```javascript
export async function POST(req: Request) {

6  const { messages }: { messages: Message[] } = await req.json();



8  const lastMessage = messages.pop();
```

10  return createDataStreamResponse({

10  返回 createDataStreamResponse({

11    execute: async (dataStream) => {

11    execute: async (dataStream) => {

12      const relevantContent = await getRelevantContent(lastMessage.content);

12      const relevantContent = await getRelevantContent(lastMessage.content);

13      for (const content of relevantContent) {

13      for (const content of relevantContent) {

14        dataStream.writeData({

14        dataStream.writeData({

15          type: "source",

15          type: "source",

16          url: content.url,

16          url: content.url,

17          title: content.title,

17          title: content.title,

18        });

18        });

19      }

19      }

21      lastMessage.content =

21      lastMessage.content =

22        lastMessage.content +

22        lastMessage.content +

23        "\n\nUse the following information to answer the question: " +

23        "\n\n请使用以下信息回答问题： " +

24        relevantContent.join("\n");

24        relevantContent.join("\n");



26      const result = streamText({

26      const result = streamText({

27        model: openai("gpt-4o"),

27        model: openai("gpt-4o"),

28        messages: [...messages, lastMessage],

28        messages: [...messages, lastMessage],

29        onFinish: async ({}) => {

29        onFinish: async ({}) => {

30          dataStream.writeMessageAnnotation({ sources: relevantContent });

30          dataStream.writeMessageAnnotation({ sources: relevantContent });

31        },

31        },

32      });



32      });



34      result.mergeIntoDataStream(dataStream);

34      result.mergeIntoDataStream(dataStream);

35    },

35    },

36  });

36  });

37}
```

37}
```

The streamed data is automatically handled by the [`useChat`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-chat) hook on the client, making it simple to access both the message content and any additional streamed data:

流式传输的数据会由客户端的 [`useChat`](https://sdk.vercel.ai/docs/reference/ai-sdk-ui/use-chat) Hook 自动处理，从而可以轻松访问消息内容以及任何其他流式传输的数据：

```tsx
1"use client";

```typescript
import { useChat } from "ai/react";

import { useChat } from "ai/react";

export default function Chat() {

export default function Chat() {

6  const { messages, data } = useChat();

6  const { messages, data } = useChat();

8  // Access streamed data

8  // 访问流式传输的数据

9  console.log(data);

9  console.log(data);

11  // Access message annotations

11  // 访问消息注释
```

12  messages.forEach(m => console.log(m.annotations));

12  messages.forEach(m => console.log(m.annotations));

14  return (/* ... */);

14  return (/* ... */);

15}
```

15}
```

To learn more, check out the [streaming custom data documentation](https://sdk.vercel.ai/docs/ai-sdk-ui/streaming-data).

如需了解更多信息，请查阅[流式传输自定义数据文档](https://sdk.vercel.ai/docs/ai-sdk-ui/streaming-data)。

## Tool-calling improvements

## 工具调用改进

Tools are a core building block of production AI applications - they enable language models to interact with real-world systems and data. However, getting tools to work reliably can be challenging. With AI SDK 4.1, we've invested significantly in making tool calling more robust:

工具是生产级 AI 应用的核心构建模块——它们使大语言模型能够与真实世界中的系统和数据进行交互。然而，确保工具稳定可靠地运行往往颇具挑战。在 AI SDK 4.1 中，我们大幅投入以提升工具调用的鲁棒性：

### Improved context within tool calls

### 工具调用中的上下文增强

When executing a tool call, the `execute` function now has access to helpful context accessible through a second parameter:

执行工具调用时，`execute` 函数现在可通过第二个参数访问有用的上下文信息：

- `toolCallId` for tracking specific executions and adding tool-related annotations

- `toolCallId`：用于追踪特定执行过程，并添加与工具相关的标注（annotations）。

- `messages` 数组，包含完整的对话历史，包括先前的工具调用及对应结果  

- `abortSignal`，用于取消长时间运行的操作，并传递给底层 `fetch` 调用  

以下是一个使用这些上下文选项的示例：  

```javascript
const result = await generateText({

2  model,

3  abortSignal,

4  tools: {

5    weather: tool({

6      parameters: z.object({ location: z.string() }),

7      execute: async ({ location }, { toolCallId, messages, abortSignal }) => {

8        // Use toolCallId for tracking

8        // 使用 toolCallId 进行跟踪

9        data.appendMessageAnnotation({

9        data.appendMessageAnnotation({

10          type: 'tool-status',

10          type: 'tool-status',

11          toolCallId,

11          toolCallId,

12          status: 'in-progress',

12          status: 'in-progress',

13        });



13        });



15        // Forward abort signal

15        // 转发中止信号

16        const response = await fetch(

16        const response = await fetch(

17          `https://api.weatherapi.com/v1/current.json?q=${location}`,  

17          `https://api.weatherapi.com/v1/current.json?q=${location}`,

18          { signal: abortSignal },

18          { signal: abortSignal },

19        );

19        );



21        return response.json();

21        return response.json();

22      },

22      },

23    }),

23    }),

24  },

24  },

25});

25});

```

To learn more, check out the [tool-calling documentation](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#tool-execution-options).

如需了解更多信息，请参阅 [工具调用文档](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#tool-execution-options)。

### Tool call repair

### 工具调用修复

When tool calls fail, you can now use the [`experimental_toToolCallRepair`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#tool-call-repair) function to attempt repairs to:

当工具调用失败时，您现在可以使用 [`experimental_toToolCallRepair`](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#tool-call-repair) 函数尝试修复，包括：

- Use a model with structured outputs to generate the arguments.

  使用支持结构化输出的模型来生成参数。

- Send the messages, system prompt, and tool schema to a stronger model to generate the arguments.

  将消息、系统提示词（system prompt）和工具 Schema 发送给更强大的模型，以生成参数。

- Provide more specific repair instructions based on which tool was called.

  根据所调用的具体工具，提供更具针对性的修复指令。

```javascript
import { openai } from '@ai-sdk/openai';

import { generateObject, generateText, NoSuchToolError, tool } from 'ai';



const result = await generateText({

5  model,

6  tools,
```

7  prompt,

7  提示词，

9  // example approach: use a model with structured outputs for repair.

9  // 示例方法：使用支持结构化输出的模型进行修复。

10  // (you can use other strategies as well)

10  // （你也可以采用其他策略）

11  experimental_repairToolCall: async ({

11  experimental_repairToolCall: async ({

12    toolCall,

12    toolCall,

13    tools,

13    tools,

14    parameterSchema,

14    parameterSchema,

15    error,

15    error,

16  }) => { 

16  }) => {

17    if (NoSuchToolError.isInstance(error)) {

17    如果错误实例为 `NoSuchToolError`：

18      return null; // do not attempt to fix invalid tool names

18      return null; // 不尝试修复无效的工具名称

19    }



21    const tool = tools[toolCall.toolName as keyof typeof tools];

21    const tool = tools[toolCall.toolName as keyof typeof tools];



23    const { object: repairedArgs } = await generateObject({

23    const { object: repairedArgs } = await generateObject({

24      model: openai('gpt-4o', { structuredOutputs: true }),

24      model: openai('gpt-4o', { structuredOutputs: true }),

25      schema: tool.parameters,

25      schema: tool.parameters,

26      prompt: [\
\
27        `The model tried to call the tool "${toolCall.toolName}"` +\
\
28          ` with the following arguments:`,\
\
29        JSON.stringify(toolCall.args),\
\
30        `The tool accepts the following schema:`,\
\
31        JSON.stringify(parameterSchema(toolCall)),\
\
32        'Please fix the arguments.',\
\
33      ].join('\\n'),

26      prompt: [\
\
27        `模型尝试调用工具 "${toolCall.toolName}"` +\
\
28          `，并传入以下参数：`,\
\
29        JSON.stringify(toolCall.args),\
\
30        `该工具接受如下 Schema：`,\
\
31        JSON.stringify(parameterSchema(toolCall)),\
\
32        '请修正这些参数。',\
\
33      ].join('\\n'),

34    });



36    return { ...toolCall, args: JSON.stringify(repairedArgs) };

37  },

38});
```

### Granular error handling

### 细粒度错误处理

To help ship more resilient tool calls, the AI SDK now provides granular error types that make debugging and error handling more precise. Each error type exposes detailed information about what went wrong and includes contextual data to help diagnose and fix issues:

为了帮助构建更具韧性的工具调用，AI SDK 现在提供了细粒度的错误类型，使调试和错误处理更加精准。每种错误类型均详细说明了问题根源，并附带上下文数据，以辅助诊断与修复问题：

- `NoSuchToolError`: Handles cases where the model attempts to call an undefined tool.

- `NoSuchToolError`：用于处理模型尝试调用未定义工具的情形。

- `InvalidToolArgumentsError`: Catches schema validation failures when tool arguments don't match the expected parameters.

- `InvalidToolArgumentsError`：捕获工具参数不符合预期参数结构时发生的 Schema 校验失败。

- `ToolExecutionError`: Identifies runtime issues during tool execution.

- `ToolExecutionError`：识别工具执行过程中发生的运行时问题。

- `ToolCallRepairError`: Tracks failures during automatic tool call repair attempts.

- `ToolCallRepairError`：跟踪自动工具调用修复过程中的失败情况。

These specific error types allow you to implement targeted error handling strategies and provide better feedback to users when tool execution fails. To learn more, check out the [error handling documentation](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#handling-errors).

这些特定的错误类型使您能够实施有针对性的错误处理策略，并在工具执行失败时向用户提供更清晰、更有帮助的反馈。欲了解详情，请参阅[错误处理文档](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#handling-errors)。

## Structured output improvements

## 结构化输出改进

We've expanded structured output capabilities to enable more dynamic and resilient AI applications:

我们已扩展结构化输出能力，以支持构建更动态、更具韧性的 AI 应用。

### Structured outputs with tools

### 结构化输出与工具协同使用

One of our most requested features is now available: the ability to combine structured outputs with tool usage. With the new `experimental_output` option in both `generateText` and `streamText`, you can build sophisticated large-language model (LLM) calls that can both interact with external systems and return predictably structured data.

我们最受期待的功能之一现已上线：将结构化输出与工具调用相结合。借助 `generateText` 和 `streamText` 中新增的 `experimental_output` 选项，您可以构建功能强大的大语言模型（LLM）调用——既能与外部系统交互，又能稳定返回结构明确的数据。

Here's an example showing how structured outputs and tools work together:

以下示例展示了结构化输出与工具如何协同工作：

```javascript
import { openai } from '@ai-sdk/openai';

import { generateText, tool, Output } from 'ai';

import { z } from 'zod';
```

```javascript
const result = await generateText({

6  model: openai('gpt-4o', { structuredOutputs: true }),

6  模型：openai('gpt-4o', { structuredOutputs: true }),

7  prompt: "What's the weather like in London and New York?",

7  提示词："伦敦和纽约的天气如何？",

8  maxSteps: 5,

8  最大执行步数：5,

9  tools: {

9  工具：{

10    getWeather: tool({

10    getWeather：tool({

11      parameters: z.object({

11      参数：z.object({

12        city: z.string(),

12        city：z.string(),

13        units: z.enum(['celsius', 'fahrenheit']),

13        units：z.enum(['celsius', 'fahrenheit']),
```

14      }),

14      }），

15      execute: async ({ city, units }) => {

15      execute: async ({ city, units }) => {

16        // Fetch weather data

16        // 获取天气数据

17      },

17      }，

18    }),

18      }），

19  },

19  }，

20  experimental_output: Output.object({

20  experimental_output: Output.object（{

21    schema: z.object({

21    schema: z.object（{

22      cities: z.array(

22      cities: z.array（

23        z.object({  

23        z.object（{

24          name: z.string(),

25          temperature: z.number(),

26          conditions: z.string(),

27        }),

28      ),

29    }),

30  }),

31});
```

与其分别调用以确定需查询哪些城市，再为每个城市调用天气工具，模型现在可在单个函数中处理整个工作流。这使得代码更加高效且易于维护，尤其适用于输入不可预测或存在多条潜在工具调用路径的复杂场景。欲了解详情，请参阅 [使用 `generateText` 和 `streamText` 生成结构化输出的文档](https://sdk.vercel.ai/docs/ai-sdk-core/generating-structured-data#structured-outputs-with-generatetext-and-streamtext)。

目前，带工具的结构化输出功能仅支持 OpenAI 模型。

### Enhanced error handling

### 增强的错误处理

Error handling for structured outputs has been significantly improved in 4.1. Previously, when structure parsing or validation failed, you only received an error – with no access to the underlying response. This meant your only option was to retry the request. With the new [`NoObjectGeneratedError`](https://sdk.vercel.ai/docs/reference/ai-sdk-errors/ai-no-object-generated-error), you now have access to:

结构化输出的错误处理在 4.1 版本中得到了显著增强。此前，当结构解析或验证失败时，你仅会收到一个错误，而无法访问底层响应内容——这意味着你唯一的选择就是重试请求。借助新的 [`NoObjectGeneratedError`](https://sdk.vercel.ai/docs/reference/ai-sdk-errors/ai-no-object-generated-error) 错误类型，你现在可以获取以下信息：

- Raw model output for debugging or salvaging partial responses  
  原始模型输出，用于调试或抢救部分有效响应

- Complete request context (response ID, timestamp, model)  
  完整的请求上下文（响应 ID、时间戳、模型名称）

- Token usage and cost analytics  
  Token 使用量及费用分析数据


Here's how to implement the enhanced error handling:

以下是增强型错误处理的实现方式：

```javascript
try {

2  const result = await generateObject({

3    model,

4    schema,

5    prompt,

5    prompt,

6  });

6  });

7} catch (error) {

7} catch (error) {

8  if (error instanceof NoObjectGeneratedError) {

8  if (error instanceof NoObjectGeneratedError) {

9    console.log('Generated text:', error.text);

9    console.log('生成的文本：', error.text);

10    console.log('Response metadata:', error.response);

10    console.log('响应元数据：', error.response);

11    console.log('Token usage:', error.usage);

11    console.log('Token 使用量：', error.usage);

12    console.log('Error cause:', error.cause);

12    console.log('错误原因：', error.cause);

13  }

13  }

14}
14}

This granular error information makes it easier to diagnose and fix issues with structured output generation, whether they occur during parsing, validation, or model generation phases.

此类细粒度的错误信息有助于更轻松地诊断和修复结构化输出生成过程中出现的问题，无论这些问题发生在解析、验证还是模型生成阶段。

Check out the [structured output error handling documentation](https://sdk.vercel.ai/docs/ai-sdk-core/generating-structured-data#error-handling) to learn more about implementing these patterns.

请查阅[结构化输出错误处理文档](https://sdk.vercel.ai/docs/ai-sdk-core/generating-structured-data#error-handling)，了解如何实现这些错误处理模式。

## New and updated providers

## 新增及更新的提供商

The AI SDK provider ecosystem continues to grow with new and improved providers:

AI SDK 的提供商生态持续扩展，新增并优化了多个提供商：

- [Google Vertex](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex) AI 2.0: A complete refresh of the Vertex AI integration that introduces enhanced performance, improved error handling, and search-grounding support.

- [Google Vertex](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex) AI 2.0：对 Vertex AI 集成的全面重构，带来性能提升、错误处理能力增强以及搜索增强（search-grounding）支持。

- [OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/openai): Fully revamped support for latest reasoning models.

- [OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/openai)：全面重构，新增对最新推理模型（reasoning models）的原生支持。

- [OpenAI Compatible](https://sdk.vercel.ai/providers/openai-compatible-providers): A new dedicated provider for OpenAI-compatible APIs.

- [OpenAI Compatible](https://sdk.vercel.ai/providers/openai-compatible-providers)：专为兼容 OpenAI API 规范的服务而设计的全新独立提供商。

- [Replicate](https://sdk.vercel.ai/providers/ai-sdk-providers/replicate): Adds first-party provider for Replicate (image models).

- [Replicate](https://sdk.vercel.ai/providers/ai-sdk-providers/replicate)：新增对 Replicate（图像模型）的官方原生支持。

- [Fireworks](https://sdk.vercel.ai/providers/openai-compatible-providers/fireworks): Adds first-party provider for Fireworks (language and image models).

- [Fireworks](https://sdk.vercel.ai/providers/openai-compatible-providers/fireworks)：新增对 Fireworks（语言模型与图像模型）的官方原生支持。

- [Cohere](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere): Adds first-party provider for Cohere (language and embedding models).

- [Cohere](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere)：新增对 Cohere（语言模型与嵌入模型）的官方原生支持。

- [Together AI](https://sdk.vercel.ai/providers/openai-compatible-providers/togetherai)：新增对 Together AI（语言模型）的官方支持。

- [DeepInfra](https://sdk.vercel.ai/providers/ai-sdk-providers/deepinfra)：新增对 DeepInfra（语言模型）的官方支持。

- [DeepSeek](https://sdk.vercel.ai/providers/ai-sdk-providers/deepseek)：新增对 DeepSeek（语言模型）的官方支持。

- [Cerebras](https://sdk.vercel.ai/providers/ai-sdk-providers/cerebras)：新增对 Cerebras（语言模型）的官方支持。

## **入门指南**

借助图像生成、非阻塞式数据流传输、增强的工具调用等强大新功能，现在正是使用 AI SDK 构建 AI 应用的最佳时机。

- **启动一个全新的 AI 项目**：准备开始构建新项目了吗？请查阅我们的 [**最新指南**](https://sdk.vercel.ai/cookbook)

- **探索模板示例**：访问我们的 [**模板画廊**](https://sdk.vercel.ai/docs/introduction#templates)，亲身体验 AI SDK 的实际应用效果

- **加入社区**：在我们的 [**GitHub Discussions**](https://github.com/vercel/ai/discussions) 中分享您正在构建的项目

## 贡献者

AI SDK 4.1 is the result of the combined work of our core team at [Vercel](https://tweets.vercel.fyi/) ( [Lars](https://x.com/lgrammel), [Jeremy](https://x.com/jrmyphlmn), [Walter](https://x.com/shaper), and [Nico](https://x.com/nicoalbanese10)) and many community contributors. Special thanks for contributing merged pull requests:

AI SDK 4.1 是由我们在 [Vercel](https://tweets.vercel.fyi/) 的核心团队（[Lars](https://x.com/lgrammel)、[Jeremy](https://x.com/jrmyphlmn)、[Walter](https://x.com/shaper) 和 [Nico](https://x.com/nicoalbanese10)）与众多社区贡献者通力协作的成果。特别感谢以下为本版本贡献了已合并 Pull Request 的开发者：

[patelvivekdev](https://github.com/patelvivekdev), [zeke](https://github.com/zeke), [daviddkkim](https://github.com/daviddkkim), [klren0312](https://github.com/klren0312), [viktorlarsson](https://github.com/viktorlarsson), [richhuth](https://github.com/richhuth), [dragos-cojocaru](https://github.com/dragos-cojocaru), [olyaiy](https://github.com/olyaiy), [minpeter](https://github.com/minpeter), [nathanwijaya](https://github.com/nathanwijaya), [timconnorz](https://github.com/timconnorz), [palmm](https://github.com/palmm), [Ojansen](https://github.com/Ojansen), [ggallon](https://github.com/ggallon), [williamlmao](https://github.com/williamlmao), [nasjp](https://github.com/nasjp), [ManuLpz4](https://github.com/ManuLpz4), [aaronccasanova](https://github.com/aaronccasanova), [marcklingen](https://github.com/marcklingen), [aaishikasb](https://github.com/aaishikasb), [michael-hhai](https://github.com/michael-hhai), [jeremypress](https://github.com/jeremypress), [yoshinorisano](https://github.com/yoshinorisano).

[patelvivekdev](https://github.com/patelvivekdev)、[zeke](https://github.com/zeke)、[daviddkkim](https://github.com/daviddkkim)、[klren0312](https://github.com/klren0312)、[viktorlarsson](https://github.com/viktorlarsson)、[richhuth](https://github.com/richhuth)、[dragos-cojocaru](https://github.com/dragos-cojocaru)、[olyaiy](https://github.com/olyaiy)、[minpeter](https://github.com/minpeter)、[nathanwijaya](https://github.com/nathanwijaya)、[timconnorz](https://github.com/timconnorz)、[palmm](https://github.com/palmm)、[Ojansen](https://github.com/Ojansen)、[ggallon](https://github.com/ggallon)、[williamlmao](https://github.com/williamlmao)、[nasjp](https://github.com/nasjp)、[ManuLpz4](https://github.com/ManuLpz4)、[aaronccasanova](https://github.com/aaronccasanova)、[marcklingen](https://github.com/marcklingen)、[aaishikasb](https://github.com/aaishikasb)、[michael-hhai](https://github.com/michael-hhai)、[jeremypress](https://github.com/jeremypress)、[yoshinorisano](https://github.com/yoshinorisano)。

Your feedback and contributions are invaluable as we continue to evolve the AI SDK.

在 AI SDK 持续演进的过程中，您的反馈与贡献弥足珍贵。