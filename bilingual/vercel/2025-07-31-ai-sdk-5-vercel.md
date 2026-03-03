---
title: "AI SDK 5 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-5"
date: "2025-07-31"
scraped_at: "2026-03-02T09:30:39.291328713+00:00"
language: "en-zh"
translated: true
description: "Introducing type-safe chat, agentic loop control, new specification, tool enhancements,  speech generation, and more."
---

Jul 31, 2025

2025 年 7 月 31 日

面向全栈 AI 应用的类型安全聊天功能与智能体循环控制正式发布

[AI SDK](https://v5.ai-sdk.dev/) 每周下载量已超 200 万次，是 TypeScript 和 JavaScript 生态中领先的开源 AI 应用工具包。其统一的模型提供商（provider）API 支持接入任意大语言模型，并可深度集成主流 Web 框架。

> “当客户询问该如何构建自己的智能体（agent）时，我总会推荐 AI SDK。整个行业正以前所未有的速度演进，技术格局日新月异。迄今为止，AI SDK 是我见过最精妙、最完备的抽象层。v5 版本延续了这一卓越传统——你一眼就能看出，它出自一群对 TypeScript 极度热忱的工程师之手。一切体验都恰到好处。”  
>  
> ![](images/ai-sdk-5-vercel/img_001.jpg)  
>  
> **Ben Hylak**，raindrop.ai

使用 TypeScript 构建应用，本质上就是在为 Web 构建应用。今天，我们正式发布 AI SDK 5 —— 首个为 React、Svelte、Vue 和 Angular 提供完全类型化（fully typed）、高度可定制化聊天集成能力的 AI 框架。

AI SDK 5 新增以下核心特性：

- [**重构的聊天组件（Redesigned Chat）**](https://vercel.com/blog/ai-sdk-5#redesigned-chat)

- [**智能体循环控制（Agentic Loop Control）**](https://vercel.com/blog/ai-sdk-5#agentic-loop-control)

- [**语音生成与语音转文字（Speech Generation & Transcription）**](https://vercel.com/blog/ai-sdk-5#experimental-speech-generation-&-transcription)

- [**工具（Tool）能力增强**](https://vercel.com/blog/ai-sdk-5#tool-improvements)

- [**V2 Specifications**](https://vercel.com/blog/ai-sdk-5#v2-specifications)

- [**V2 规范**](https://vercel.com/blog/ai-sdk-5#v2-specifications)

- [**Global Provider**](https://vercel.com/blog/ai-sdk-5#global-provider)

- [**全局 Provider**](https://vercel.com/blog/ai-sdk-5#global-provider)

- [**Access Raw Responses**](https://vercel.com/blog/ai-sdk-5#access-raw-responses)

- [**访问原始响应**](https://vercel.com/blog/ai-sdk-5#access-raw-responses)

- [**Zod 4 Support**](https://vercel.com/blog/ai-sdk-5#zod-4-support)

- [**Zod 4 支持**](https://vercel.com/blog/ai-sdk-5#zod-4-support)


Let’s "dive" into the details.

让我们“深入”细节。

## Redesigned Chat

## 重新设计的聊天功能

With AI SDK 5, we've rebuilt chat from the ground up. We took the powerful primitives that developers love for working with LLMs and built a world-class UI integration on top, with end-to-end type safety across your entire application. From server to the client, every piece of data, tool call, and metadata is fully typed. This represents the next evolution of AI libraries for the web.

借助 AI SDK 5，我们从零开始彻底重构了聊天功能。我们在开发者喜爱的、用于操作大语言模型（LLM）的强大基础组件之上，构建了一套世界级的 UI 集成方案，并在整个应用中实现了端到端的类型安全：从服务端到客户端，每一条数据、每一次工具调用、每一项元数据均具备完整类型定义。这标志着面向 Web 的 AI 类库迈入了全新演进阶段。

### Separate UI and Model Messages

### UI 消息与模型消息分离

One of the biggest challenges developers faced with previous versions of the AI SDK was managing different message types and figuring out how to properly persist chat history.

在 AI SDK 早期版本中，开发者面临的主要挑战之一，便是如何管理多种类型的消息，以及如何正确持久化聊天历史记录。

This was a core consideration in rebuilding `useChat`, which led to the creation of distinct types of messages:

这一问题成为我们重构 `useChat` 钩子的核心考量，最终催生了两类截然不同的消息类型：

- **UIMessage:** 这是应用程序状态的 _唯一真实来源（source of truth）_，其中包含所有消息、元数据、工具执行结果等。我们建议使用 `UIMessage` 进行持久化存储，以便始终能够准确还原面向用户的聊天历史。

- **ModelMessage:** 这是一种精简化的表示形式，专为向大语言模型发送而优化。

我们在 API 中明确区分了这两者：

```tsx
1// 显式地将 UIMessage 转换为 ModelMessage

const uiMessages: UIMessage[] = [ /* ... */ ]

const modelMessages = convertToModelMessages(uiMessages);



const result = await streamText({

6  model: openai('gpt-4o'),

7  // 将丰富的 UIMessage 格式转换为 ModelMessage 格式

8  // This can be replaced with any function that returns ModelMessage[]

8  // 此处可替换为任意返回 ModelMessage[] 的函数

9  messages: modelMessages,

9  messages: modelMessages,

10});



10});



12// When finished: Get the complete UIMessage array for persistence

12// 完成后：获取完整的 UIMessage 数组以用于持久化存储

return result.toUIMessageStreamResponse({

13return result.toUIMessageStreamResponse({

14  originalMessages: uiMessages,

14  originalMessages: uiMessages,

15  onFinish: ({ messages, responseMessage }) => {

15  onFinish: ({ messages, responseMessage }) => {

16    // Save the complete UIMessage array - your full source of truth

16    // 保存完整的 UIMessage 数组——这是您数据的唯一真实来源

17    saveChat({ chatId, messages });

17    saveChat({ chatId, messages });

19    // Or save just the response message

19    // 或者仅保存响应消息

20    saveMessage({ chatId, message: responseMessage })

20    saveMessage({ chatId, message: responseMessage })

21  },

21  },

22});

22});

This separation between UI and model messages makes persistence straightforward. The `onFinish` callback provides all your messages in the format needed to save, with no explicit conversion required.

UI 消息与模型消息的这种分离，使持久化操作变得简单直接。`onFinish` 回调会以适合保存的格式提供全部消息，无需任何显式转换。

For complete examples of implementing message persistence with the AI SDK, check out our chatbot [persistence documentation](https://v5.ai-sdk.dev/docs/ai-sdk-ui/chatbot-message-persistence) and the [persistence template repository](https://github.com/vercel-labs/ai-sdk-persistence-db/).

如需了解如何使用 AI SDK 实现消息持久化的完整示例，请参阅我们的聊天机器人 [持久化文档](https://v5.ai-sdk.dev/docs/ai-sdk-ui/chatbot-message-persistence) 以及 [持久化模板仓库](https://github.com/vercel-labs/ai-sdk-persistence-db/)。

### Customizable UI Messages

### 可自定义的 UI 消息

With AI SDK 5, you can customize the UIMessage to create your own type with the exact shape of your data, tools, and metadata, that is tailored to your application. You can pass this type as a generic argument to `createUIMessageStream` on the server and to `useChat` on the client, providing full-stack type-safety.

借助 AI SDK 5，您可以自定义 `UIMessage` 类型，创建完全契合您应用需求的消息类型——其结构可精确匹配您的数据、工具及元数据。您可将该类型作为泛型参数，分别传入服务端的 `createUIMessageStream` 和客户端的 `useChat`，从而实现全栈类型安全。

```tsx
1// Define your custom message type once

1// 一次性定义您的自定义消息类型

```typescript
import { UIMessage } from 'ai';

import { UIMessage } from 'ai';

// ... import your tool and data part types

// ……导入你的工具类型和数据部分类型

export type MyUIMessage = UIMessage<MyMetadata, MyDataParts, MyTools>;

export type MyUIMessage = UIMessage<MyMetadata, MyDataParts, MyTools>;

// Use it on the client

// 在客户端使用它

const { messages } = useChat<MyUIMessage>();

const { messages } = useChat<MyUIMessage>();

// And use it on the server

// 并在服务端使用它

const stream = createUIMessageStream<MyUIMessage>(/* ... */);

const stream = createUIMessageStream<MyUIMessage>(/* ... */);
```

To learn more, check out the [UIMessage documentation](https://v5.ai-sdk.dev/docs/reference/ai-sdk-core/ui-message).

如需了解更多信息，请查阅 [UIMessage 文档](https://v5.ai-sdk.dev/docs/reference/ai-sdk-core/ui-message)。

### Data Parts

### 数据部分（Data Parts）

Modern AI applications need to send more than just an LLM's plain-text response from the server to the client (e.g. anything from status updates to partial tool results). Without proper typing, streaming custom data can turn your frontend into a mess of runtime checks and type assertions. **Data parts** solve this by providing a first-class way to stream any arbitrary, type-safe data from the server to the client, ensuring your code remains maintainable as your application grows.

现代 AI 应用不仅需要将大语言模型（LLM）生成的纯文本响应从服务端发送至客户端，还需传输更多内容（例如状态更新、工具调用的中间结果等）。若缺乏恰当的类型定义，流式传输自定义数据将导致前端充斥大量运行时检查与类型断言，使代码难以维护。**数据部分（Data Parts）** 为此提供了一流支持——它允许你以类型安全的方式，从服务端向客户端流式传输任意结构化数据，从而确保随着应用规模扩大，代码依然清晰、健壮且易于维护。

On the server, you can stream a data part by specifying your part type (e.g. `data-weather`) and then passing your data. You can update the same data part by specifying an ID:

在服务端，你可以通过指定数据部分类型（例如 `data-weather`）并传入对应数据，来流式发送一个数据部分；还可通过指定 ID 来更新同一数据部分：

```tsx
1// On the server, create a UIMessage stream

2// Typing the stream with your custom message type

const stream = createUIMessageStream<MyUIMessage>({

4  async execute({ writer }) {

5    // manually write start step if no LLM call

```

7    const dataPartId = 'weather-1';

7    const dataPartId = 'weather-1';

9    // 1. Send the initial loading state

9    // 1. 发送初始加载状态

10    writer.write({

10    writer.write({

11      type: 'data-weather', // type-checked against MyUIMessage

11      type: 'data-weather', // 类型经 MyUIMessage 校验

12      id: dataPartId,

12      id: dataPartId,

13      data: { city: 'San Francisco', status: 'loading' },

13      data: { city: 'San Francisco', status: 'loading' },

14    });

14    });

16    // 2. Later, update the same part (same id) with the final result

16    // 2. 后续使用最终结果更新同一部分（相同 id）

17    writer.write({

17    writer.write({

18      type: 'data-weather',

18      type: 'data-weather',

19      id: dataPartId,

19      id: dataPartId,

20      data: { city: 'San Francisco', weather: 'sunny', status: 'success' },

20      data: { city: 'San Francisco', weather: 'sunny', status: 'success' },

21    });

21    });

22  },

22  },

23});

23});

```

On the client, you can then render this specific part. When you use the same ID, the AI SDK replaces the existing data part with the new one:

```

在客户端，你可以渲染该特定部分。当你使用相同的 ID 时，AI SDK 将用新数据部分替换已有的数据部分：

```tsx
1// On the client, data parts are fully typed

1// 在客户端，数据部分具有完整的类型定义

const { messages } = useChat<MyUIMessage>();

const { messages } = useChat<MyUIMessage>();

3{

4  messages.map(message =>

5    message.parts.map((part, index) => {

6      switch (part.type) {

7        case 'data-weather':

8          return (

9            <div key={index}>

10              {/* TypeScript 知道 part.data 包含 city、status，以及可选的 weather */}

11              {part.data.status === 'loading'

12                ? `正在获取 ${part.data.city} 的天气信息...`

13                : `Weather in ${part.data.city}: ${part.data.weather}`}

13                ：`${part.data.city} 的天气：${part.data.weather}`}

14            </div>

14            </div>

15          );

15          );

16      }

16      }

17    }),

17    }),

18  );

18  );

19}
```

19}
```

There are also instances where you want to send data that you do not want to persist, but use to communicate status updates, or make other changes to the UI - this is where transient data parts and the `onData` hook comes in.

在某些场景下，您需要向客户端发送一些**不希望持久化保存**的数据，例如用于传达状态更新，或对 UI 做其他临时性修改——此时便需要用到**瞬态数据片段（transient data parts）**以及 `onData` 钩子。

Transient parts are sent to the client but not added to the message history. They are only accessible via the `onData` useChat handler:

瞬态数据片段会被发送至客户端，但**不会被添加到消息历史记录中**；它们仅可通过 `onData` 回调（即 `useChat` 的 `onData` 处理函数）访问：

```tsx
1// server

```tsx
1// 服务端

```javascript
writer.write({
  type: 'data-notification',
  data: { message: 'Processing...', level: 'info' },
  transient: true, // Won't be added to message history
});
```

```javascript
writer.write({
  type: 'data-notification',
  data: { message: '处理中……', level: 'info' },
  transient: true, // 不会添加到消息历史记录中
});
```

// client  
// 客户端  

```javascript
const [notification, setNotification] = useState();
const { messages } = useChat({
  onData: ({ data, type }) => {
```

```javascript
const [notification, setNotification] = useState();
const { messages } = useChat({
  onData: ({ data, type }) => {
```

12    if (type === 'data-notification') {

12    如果 type 等于 'data-notification'：

13      setNotification({ message: data.message, level: data.level });

13      设置通知（{ message: data.message, level: data.level }）；

14    }

14    }

15  },

15  }，

16});
```

16});
```

To learn more, check out the [data parts documentation](https://v5.ai-sdk.dev/docs/ai-sdk-ui/streaming-data).

如需了解更多信息，请查阅 [data parts 文档](https://v5.ai-sdk.dev/docs/ai-sdk-ui/streaming-data)。

### Type-Safe Tool Invocations

### 类型安全的工具调用

Tool invocations in useChat have been redesigned with type-specific part identifiers. Each tool now creates a part type like `tool-TOOLNAME` instead of using generic `tool-invocation` parts.

`useChat` 中的工具调用已使用类型专属的 part 标识符重新设计。每个工具现在会生成形如 `tool-TOOLNAME` 的 part 类型，而不再使用通用的 `tool-invocation` part。

AI SDK 5 builds on this foundation with three improvements:

AI SDK 5 在此基础之上进行了三项改进：

- **Type Safety**: By defining your tools' shape within your custom message type, you get end-to-end type safety for both input (your tools' `inputSchema`) and output (your tools' `outputSchema`).

- **类型安全**：通过在您自定义的消息类型中定义工具的结构，您可获得端到端的类型安全性，覆盖输入（工具的 `inputSchema`）与输出（工具的 `outputSchema`）。

- **Automatic Input Streaming**: Tool call inputs now stream by default, providing partial updates as the model generates them.

- **自动输入流式传输**：工具调用的输入现在默认启用流式传输，模型在生成过程中会实时提供部分更新。

- **Explicit Error States**: tool execution errors are limited to the tool and can be resubmitted to the LLM.

- **明确的错误状态**：工具执行错误被限定在工具范围内，可重新提交给大语言模型（LLM）进行重试。

Together, these features enable you to build maintainable UIs that show users exactly what's happening throughout the tool execution process—from initial invocation through streaming updates to final results or errors:

上述两项特性协同工作，使您能够构建可维护的用户界面，向用户清晰呈现工具执行全过程中的每一步状态——从初始调用、流式更新，直至最终结果或错误信息：

```tsx
1// On the client, tool parts are fully typed with the new structure

1// 在客户端，工具片段（tool parts）已基于新结构实现完整类型定义

const { messages } = useChat<MyUIMessage>();

3{

4  messages.map(message => (

5    <>

6      {message.parts.map(part => {

7        switch (part.type) {

8          // Static tools with specific (`tool-${toolName}`) types

8          // 具有特定类型（`tool-${toolName}`）的静态工具

9          case 'tool-getWeather':

9          case 'tool-getWeather':

10            // New states for streaming and error handling

10            // 用于流式传输和错误处理的新状态

11            switch (part.state) {

11            switch (part.state) {

12              case 'input-streaming':

12              case 'input-streaming':

13                // Automatically streamed partial inputs

13                // 自动流式传输的部分输入

14                return <div>Getting weather for {part.input.location}...</div>;

14                return <div>正在获取 {part.input.location} 的天气信息...</div>;

15              case 'input-available':

15              case 'input-available':

16                return <div>Getting weather for {part.input.location}...</div>;

16                return <div>正在获取 {part.input.location} 的天气信息...</div>;

17              case 'output-available':

17              case 'output-available':

18                return <div>The weather is: {part.output}</div>;

18                返回 <div>天气为：{part.output}</div>;

19              case 'output-error':

19              case 'output-error':

20                // Explicit error state with information

20                // 显式错误状态，并附带错误信息

21                return <div>Error: {part.errorText}</div>;

21                返回 <div>错误：{part.errorText}</div>;

22            }

22            }

23        }

23        }

24      })}

24      })}

25    </>

25    </>

26  ));

26  ));

27}

27}

The chat also supports dynamic tools ( [more below](https://vercel.com/blog/ai-sdk-5#dynamic-tools)).

聊天功能还支持动态工具（[详见下方](https://vercel.com/blog/ai-sdk-5#dynamic-tools)）。

Dynamic tools (e.g. tools from MCP server) are not known during development and can be rendered using the `dynamic-tool` part:

动态工具（例如来自 MCP 服务器的工具）在开发阶段无法预先获知，可通过 `dynamic-tool` 类型部件进行渲染：

```tsx
const { messages } = useChat<MyUIMessage>();

2{

3  messages.map(message => (

4    <>

5      {message.parts.map(part => {

6        switch (part.type) {

7          // Dynamic tools use generic `dynamic-tool` type

8          case 'dynamic-tool':

9            return (
```

10              `<div key={index}>`

10              `<div key={index}>`

11                `<h4>Tool: {part.toolName}</h4>`

11                `<h4>工具：{part.toolName}</h4>`

12                `{part.state === 'input-streaming' && (`

12                `{part.state === 'input-streaming' && (`

13                  `<pre>{JSON.stringify(part.input, null, 2)}</pre>`

13                  `<pre>{JSON.stringify(part.input, null, 2)}</pre>`

14                )}`

14                )}`

15                `{part.state === 'output-available' && (`

15                `{part.state === 'output-available' && (`

16                  `<pre>{JSON.stringify(part.output, null, 2)}</pre>`

16                  `<pre>{JSON.stringify(part.output, null, 2)}</pre>`

17                )}`

17                )}`

18                `{part.state === 'output-error' && (`

18                `{part.state === 'output-error' && (`

19                  `<div>Error: {part.errorText}</div>`

19                  `<div>错误：{part.errorText}</div>`

20                )}

21              </div>

22            );

23        }

24      })}

25    </>

26  ));

27}
```

如需了解更多信息，请参阅下方的[动态工具（Dynamic Tools）章节](https://vercel.com/blog/ai-sdk-5#dynamic-tools)，或查阅[工具调用文档（Tool Calling Documentation）](https://v5.ai-sdk.dev/docs/ai-sdk-ui/chatbot#using-inferred-types)。

### 消息元数据

### Message Metadata

For information _about_ a message, such as a timestamp, model ID, or token count, you can now attach type-safe metadata to a message. You can use it to attach metadata that is relevant to your application.

关于一条消息的信息（例如时间戳、模型 ID 或 token 数量），您现在可以向该消息附加类型安全的元数据。您可以利用它来附加与您的应用程序相关的元数据。

To send metadata from the server:

从服务器发送元数据：

```javascript
1// on the server

const result = streamText({

3  /* ... */

4});

return result.toUIMessageStreamResponse({

6  messageMetadata: ({ part }) => {

7    if (part.type === "start") {

8      return {

9        // This object is checked against your metadata type

9        // 此对象将与您的元数据类型进行比对

10        model: "gpt-4o",

10        model: "gpt-4o",

11      };

11      };

12    }

12    }

13    if (part.type === "finish") {

13    if (part.type === "finish") {

14      return {

14      return {

15        model: part.response.modelId,

15        model: part.response.modelId,

16        totalTokens: part.totalUsage.totalTokens,

16        totalTokens: part.totalUsage.totalTokens,

17      };

17      };

18    }

19  },

20});
```

然后你可以在客户端访问它：

```tsx
1// on the client

1// 在客户端

const { messages } = useChat<MyUIMessage>();

3{

4  messages.map(message => (

5    <div key={message.id}>

6      {/* TS knows message.metadata may have model and totalTokens */}

6      {/* TypeScript 知道 message.metadata 可能包含 model 和 totalTokens */}

7      {message.metadata?.model && (

8        <span>模型：{message.metadata.model}</span>

9      )}

10      {message.metadata?.totalTokens && (

11        <span>{message.metadata.totalTokens} 个 token</span>

12      )}

13    </div>

14  ));

15}
```

当您在消息生命周期的不同阶段更新元数据值时，客户端始终显示最新的值。

如需了解更多信息，请查阅 [消息元数据文档](https://v5.ai-sdk.dev/docs/ai-sdk-ui/message-metadata)。

### Modular Architecture & Extensibility

### 模块化架构与可扩展性

The new `useChat` hook has been redesigned with modularity at its core, enabling three powerful extensibility patterns:

新的 `useChat` Hook 以模块化为核心进行了重构，支持以下三种强大的可扩展模式：

- **Flexible Transports:** Swap out the default `fetch`-based transport for custom implementations. Use WebSockets for real-time communication or connect directly to LLM providers without a backend for client-only applications, browser extensions, and privacy-focused use cases. To learn more, check out the [transport documentation](https://v5.ai-sdk.dev/docs/ai-sdk-ui/transport).

- **灵活的传输层（Transport）：** 可替换默认基于 `fetch` 的传输实现，接入自定义传输逻辑。例如，使用 WebSocket 实现实时通信；或在无后端场景下直接对接大语言模型（LLM）服务商，适用于纯客户端应用、浏览器插件及注重隐私的使用场景。欲了解详情，请参阅[传输层文档](https://v5.ai-sdk.dev/docs/ai-sdk-ui/transport)。

- **Decoupled State Management:** The hook's state is fully decoupled, allowing seamless integration with external stores like Zustand, Redux, or MobX. Share chat state across your entire application while maintaining all of `useChat`'s powerful features.

- **解耦的状态管理：** 该 Hook 的状态完全解耦，可无缝集成 Zustand、Redux 或 MobX 等外部状态库。您可在整个应用中共享聊天状态，同时保留 `useChat` 的全部强大功能。

- **Framework-Agnostic Chat:** Build your own chat hooks for any framework using the exposed `AbstractChat` class. Create custom integrations while maintaining full compatibility with the AI SDK ecosystem.

- **框架无关的聊天能力：** 借助公开的 `AbstractChat` 类，您可为任意前端框架构建专属的聊天 Hook。在实现高度定制化集成的同时，确保与 AI SDK 生态系统完全兼容。

### Vue, Svelte, and Angular Support

### 对 Vue、Svelte 和 Angular 的支持

AI SDK 5 brings the redesigned chat experience to every major web framework. Vue and Svelte now have complete feature parity with React, and we've introduced support for Angular.

AI SDK 5 将重构后的聊天体验带到了所有主流 Web 框架。Vue 和 Svelte 现已实现与 React 完全一致的功能覆盖，同时我们正式新增了对 Angular 的支持。

All frameworks now get the same powerful features: custom message types for your application's specific needs, data parts for streaming arbitrary typed data, fully typed tool invocations with automatic input streaming, and type-safe message metadata. Whether you're using `useChat` in React, Vue's composition API, Svelte's stores, or Angular's signals, you're working with the same powerful primitives and end-to-end type safety.

所有框架现均享有同等强大的功能：支持按需定义自定义消息类型；通过“数据片段（data parts）”流式传输任意类型的结构化数据；提供完全类型化的工具调用（tool invocation），并自动支持输入流式处理；以及具备类型安全的消息元数据（message metadata）。无论您是在 React 中使用 `useChat`，在 Vue 的组合式 API 中使用，还是在 Svelte 的 store 或 Angular 的 signal 中使用，所依赖的底层原语（primitives）完全一致，并全程保障端到端的类型安全。

To learn more, check out the [Vue](https://github.com/vercel/ai/tree/main/examples/nuxt-openai), [Svelte](https://github.com/vercel/ai-chatbot-svelte), and [Angular example](https://github.com/vercel/ai/tree/main/examples/angular).

如需进一步了解，请查阅 [Vue 示例](https://github.com/vercel/ai/tree/main/examples/nuxt-openai)、[Svelte 示例](https://github.com/vercel/ai-chatbot-svelte) 和 [Angular 示例](https://github.com/vercel/ai/tree/main/examples/angular)。

### **SSE Streaming**

### **SSE 流式传输**

The AI SDK now uses Server-Sent Events (SSE) as its standard for streaming data from the server to the client. SSE is natively supported in all major browsers and environments. This change makes our streaming protocol more robust, easier to debug with standard browser developer tools, and simpler to build upon.

AI SDK 现在采用服务器发送事件（Server-Sent Events，简称 SSE）作为从服务器向客户端流式传输数据的标准协议。SSE 在所有主流浏览器和运行环境中均原生支持。这一变更使我们的流式传输协议更加稳健，更易于借助标准浏览器开发者工具进行调试，也更便于在其基础上进行扩展开发。

## Agentic Loop Control

## 智能体循环控制

Building reliable AI agents requires precise control over execution flow and context. With AI SDK 5, we're introducing primitives that give you complete control over how your agents run and what context and tools they have at each step.

构建可靠的 AI 智能体，需要对执行流程与上下文进行精准控制。借助 AI SDK 5，我们引入了基础控制原语（primitives），让您能够完全掌控智能体的运行方式，以及每一步所具备的上下文与可用工具。

AI SDK 5 introduces three features for building agents:

AI SDK 5 引入了三项用于构建智能体的核心功能：

- **stopWhen**: Define when a tool-calling loop is stopped.

- **stopWhen**：定义工具调用循环的终止条件。

- **prepareStep**: Adjust the parameters for each step

- **prepareStep**：为每一步动态调整参数。

- **Agent Abstraction**: Use `generateText` and `streamText` with predefined settings

- **智能体抽象（Agent Abstraction）**：使用预设配置调用 `generateText` 和 `streamText`。

### stopWhen

### stopWhen

When you make a request with the `generateText` and `streamText`, it runs for a single step by default. The `stopWhen` parameter transforms your single request into a tool-calling loop that will continue until:

调用 `generateText` 或 `streamText` 发起请求时，默认仅执行单步操作。而 `stopWhen` 参数可将该单次请求转化为一个持续运行的工具调用循环，该循环将持续执行，直至满足以下任一条件：

- The `stopWhen` condition is satisfied, or  
- `stopWhen` 条件被满足；或

- The model generates text instead of a tool call (always a stopping condition)

- 模型生成文本而非调用工具（始终为终止条件）

Common stopping conditions include:

常见终止条件包括：

- **Step limit**: `stepCountIs(5)` \- run for up to 5 steps

- **步数限制**：`stepCountIs(5)` —— 最多执行 5 步

- **Specific tool**: `hasToolCall('finalAnswer')` \- stop when a particular tool is called

- **特定工具**：`hasToolCall('finalAnswer')` —— 当调用指定工具时终止

```javascript
import { openai } from "@ai-sdk/openai";

import { generateText, stepCountIs, hasToolCall } from "ai";

const result = await generateText({

4  model: openai("gpt-4o"),

5  tools: {

6    /* your tools */
```

7  },

8  // 在执行 5 步后停止工具调用循环；  
9  // 或当调用 weather 工具时停止  

10  stopWhen: [stepCountIs(5), hasToolCall("weather")],

11});
```

### prepareStep

### prepareStep（准备步骤）

虽然 `stopWhen` 控制智能体的运行终止条件，`prepareStep` 则允许你为每一步执行自定义配置。

在每一步执行前，你可以调整以下设置：

- **Messages（消息）**：压缩或过滤上下文，以确保不超出 token 限制，或剔除无关的 token。  
- **Model（模型）**：根据任务复杂度，在不同模型之间动态切换。

- **System prompt**: Adapt instructions for different tasks.

- **系统提示（System prompt）**：针对不同任务调整指令。

- **Tools**: Enable/disable tools as needed.

- **工具（Tools）**：根据需要启用或禁用工具。

- **Tool choice**: Force specific tool usage (or none) when required.

- **工具选择（Tool choice）**：在必要时强制指定使用特定工具（或不使用任何工具）。

```javascript
const result = await streamText({

2  model: openai('gpt-4o'),

3  messages: convertToModelMessages(messages),

4  tools: {

5    /* Your tools */

6  },

7  prepareStep: async ({ stepNumber, messages }) => {
```

8    if (stepNumber === 0) {

8    如果 stepNumber 等于 0，则：

9      return {

9      返回：

10        // Use a different model for the first step

10        // 第一步使用不同的模型

11        model: openai('gpt-4o-mini'),

11        model: openai('gpt-4o-mini'),

12        // Force a specific tool choice

12        // 强制指定工具调用

13        toolChoice: { type: 'tool', toolName: 'analyzeIntent' },

13        toolChoice: { type: 'tool', toolName: 'analyzeIntent' },

14      };

14      };

15    }



15    }

17    // Compress context for longer conversations

17    // 对更长的对话压缩上下文

18    if (messages.length > 10) {

18    如果消息数量超过 10 条：

19      return {

19      则返回：

20        // use a model with a larger context window

20        // 使用上下文窗口更大的模型

21        model: openai('gpt-4.1'),

21        model: openai('gpt-4.1'),

22        messages: messages.slice(-10),

22        messages: messages.slice(-10),

23      };

23      };

24    }

24    }

25  },

25  },

26});

26});

### Agent Abstraction

### Agent 抽象

The `Agent` class provides an object-oriented approach to building agents. It doesn't add new capabilities - everything you can do with `Agent` can be done with `generateText` or `streamText`. Instead, it allows you to encapsulate your agent configuration and execution:

`Agent` 类提供了一种面向对象的方式来构建智能体（agents）。它并未引入新功能——所有通过 `Agent` 能实现的操作，均可使用 `generateText` 或 `streamText` 完成。相反，它使您能够将智能体的配置与执行逻辑封装在一起：

```javascript
import { openai } from "@ai-sdk/openai";

import { Experimental_Agent as Agent, stepCountIs } from "ai";

const codingAgent = new Agent({

5  model: openai("gpt-4o"),

6  system: "You are a coding agent. You specialise in Next.js and TypeScript.",

7  stopWhen: stepCountIs(10),

8  tools: {

9    /* Your tools */
```

10  },

11});



13// Calls `generateText`

13// 调用 `generateText`

const result = codingAgent.generate({

15  prompt: "Build an AI coding agent.",

15  提示词（prompt）：`"Build an AI coding agent."`

16});



18// Calls `streamText`

18// 调用 `streamText`

const result = codingAgent.stream({

20  prompt: "Build an AI coding agent.",

20  提示词：“构建一个 AI 编程智能体。”

21});

21}）；

## Experimental Speech Generation & Transcription

## 实验性语音生成与语音转文字

AI SDK 5 将我们统一的供应商抽象（unified provider abstraction）扩展至语音领域。正如我们在文本生成和图像生成中所做的一样，我们同样为语音生成与语音转文字提供了统一、一致且类型安全的接口。无论您使用的是 [OpenAI](https://v5.ai-sdk.dev/providers/ai-sdk-providers/openai#speech-models)、[ElevenLabs](https://v5.ai-sdk.dev/providers/ai-sdk-providers/elevenlabs#transcription-models)，还是 [DeepGram](https://v5.ai-sdk.dev/providers/ai-sdk-providers/deepgram#transcription-models)，您都可通过熟悉的 API 模式进行开发，并仅需修改一行代码即可切换语音服务提供商。

```javascript
import {

2  experimental_generateSpeech as generateSpeech,

3  experimental_transcribe as transcribe,

4} from 'ai';

import { openai } from '@ai-sdk/openai';
```

7// Text-to-Speech: Generate audio from text  
7// 文本转语音：从文本生成音频  

const { audio } = await generateSpeech({  

const { audio } = await generateSpeech({  

9  model: openai.speech('tts-1'),  
9  model: openai.speech('tts-1'),  

10  text: 'Hello, world!',  
10  text: 'Hello, world!',  

11  voice: 'alloy',  
11  voice: 'alloy',  

12});  
12});  

14// Speech-to-Text: Transcribe audio to text  
14// 语音转文本：将音频转录为文本  

const { text, segments } = await transcribe({  

const { text, segments } = await transcribe({  

16  model: openai.transcription('whisper-1')  
16  model: openai.transcription('whisper-1')

17  audio: await readFile('audio.mp3'),

17  audio: await readFile('audio.mp3'),

18});
```

18});
```

To learn more, check out the [speech](https://v5.ai-sdk.dev/docs/ai-sdk-core/speech) and [transcription](https://v5.ai-sdk.dev/docs/ai-sdk-core/transcription) documentation.

如需了解更多信息，请查阅 [语音处理（speech）](https://v5.ai-sdk.dev/docs/ai-sdk-core/speech) 和 [语音转文字（transcription）](https://v5.ai-sdk.dev/docs/ai-sdk-core/transcription) 文档。

## Tool Improvements

## 工具能力增强

AI SDK 5 通过一系列全面升级显著增强了工具能力，包括动态工具支持、由提供商执行的函数、生命周期钩子（lifecycle hooks），以及在整个工具调用流程中实现的类型安全（type-safety）。

### Parameter & Result Renaming

### 参数与结果字段重命名

在 AI SDK 5 中，我们对工具定义接口进行了调整，使其更贴近模型上下文协议（Model Context Protocol, MCP）规范，关键概念已重命名如下：

- **parameters → inputSchema**：此次重命名更准确地体现了该 schema 的作用——校验并定义工具输入的数据结构与类型。

- **result → output**：同理，工具的返回值现在统一命名为 `output`。

AI SDK 5 还新增了一个可选的 `outputSchema` 属性，该属性同样遵循 MCP 规范，并支持客户端工具调用时的类型安全。

这些变更使工具定义更加直观，并与新兴的行业标准保持一致：

```javascript
1// Before (v4)

1// 之前（v4 版本）

const weatherTool = tool({

const weatherTool = tool({

3  name: 'getWeather',

3  name: 'getWeather',

4  parameters: z.object({ location: z.string() }),

4  parameters: z.object({ location: z.string() }),

5  execute: async ({ location }) => {

5  execute: async ({ location }) => {

6    return `Weather in ${location}: sunny, 72°F`;

6    return `Weather in ${location}: sunny, 72°F`;

7  }

7  }

8});

8});
```

10// After (v5)

10// 升级后（v5 版本）

const weatherTool = tool({

const weatherTool = tool({

12  description: 'Get the weather for a location',

12  description: '获取指定地点的天气信息',

13  inputSchema: z.object({ location: z.string() }),

13  inputSchema: z.object({ location: z.string() }),

14  outputSchema: z.string(), // New in v5 (optional)

14  outputSchema: z.string(), // v5 新增（可选）

15  execute: async ({ location }) => {

15  execute: async ({ location }) => {

16    return `Weather in ${location}: sunny, 72°F`;

16    return `Weather in ${location}: sunny, 72°F`;

17  }

17  }

18});

18});

### Dynamic Tools

### 动态工具

AI applications often need to work with tools that can't be known in advance:

AI 应用程序通常需要与一些无法预先确定的工具协同工作：

- MCP (Model Context Protocol) tools without schemas  
- 无模式定义的 MCP（Model Context Protocol）工具

- User-defined functions loaded at runtime  
- 在运行时加载的用户自定义函数

- External tool providers  
- 外部工具提供方


Dynamic tools and the `dynamicTool` function enables tools where input and output types are determined at runtime rather than at development time. Dynamic tools are separated from static tools to give you type safety and flexibility at the same time.

动态工具及 `dynamicTool` 函数，支持在运行时而非开发时确定输入与输出类型。动态工具与静态工具相互分离，从而让您同时获得类型安全性与灵活性。

```javascript
import { dynamicTool } from 'ai';

import { z } from 'zod';



const customDynamicTool = dynamicTool({

5  description: 'Execute a custom user-defined function',

6  inputSchema: z.object({}),

6  inputSchema: z.object({}),

7  // input is typed as 'unknown'

7  // input 的类型为 'unknown'

8  execute: async input => {

8  execute: async input => {

9    const { action, parameters } = input as any;

9    const { action, parameters } = input as any;

10    // Execute your dynamic logic

10    // 执行您的动态逻辑

11    return {

11    return {

12      result: `Executed ${action} with ${JSON.stringify(parameters)}`,

12      result: `已执行 ${action}，参数为 ${JSON.stringify(parameters)}`,

13    };

13    };

14  },

14  },

15}); 

15});

```javascript
const weatherTool = tool({ /* ... */ })
```

```javascript
const weatherTool = tool({ /* ... */ })
```

```javascript
const result = await generateText({

20  model: 'openai/gpt-4o',

21  tools: {

22    // Static tool with known types

23    weatherTool,

24    // Dynamic tool

25    customDynamicTool,
```

```javascript
const result = await generateText({

20  model: 'openai/gpt-4o',

21  tools: {

22    // 具有已知类型的静态工具

23    weatherTool,

24    // 动态工具

25    customDynamicTool,
```

26  },

26  },

27  onStepFinish: ({ toolCalls, toolResults }) => {

27  onStepFinish: ({ toolCalls, toolResults }) => {

28    // Type-safe iteration

28    // 类型安全的遍历

29    for (const toolCall of toolCalls) {

29    for (const toolCall of toolCalls) {

30      if (toolCall.dynamic) {

30      if (toolCall.dynamic) {

31        // Dynamic tool: input is 'unknown'

31        // 动态工具：输入类型为 'unknown'

32        console.log('Dynamic:', toolCall.toolName, toolCall.input);

32        console.log('Dynamic:', toolCall.toolName, toolCall.input);

33        continue;

33        continue;

34      }

34      }

```

36      // Static tool: full type inference

36      // 静态工具：完整的类型推断

37      switch (toolCall.toolName) {

37      switch (toolCall.toolName) {

38        case 'weather':

38        case 'weather':

39          console.log(toolCall.input.location); // typed as string

39          console.log(toolCall.input.location); // 类型为 string

40          break;

40          break;

41      }

41      }

42    }

42    }

43  },

43  },

44});

44});

To learn more, check out the [dynamic tool documentation](https://v5.ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling#dynamic-tools).

如需了解更多信息，请查阅 [动态工具文档](https://v5.ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling#dynamic-tools)。

### Provider-Executed Tools

### 由 AI 提供商执行的工具

Many AI providers have introduced provider-executed tools. When these tools are called, the provider will execute the tool and send back the tool result as part of the response (e.g. OpenAI’s web search and file search, xAI’s web search, and more).

许多 AI 提供商已推出由其自身执行的工具。当调用这些工具时，提供商将直接执行该工具，并将工具结果作为响应的一部分返回（例如 OpenAI 的网页搜索和文件搜索、xAI 的网页搜索等）。

The AI SDK now natively supports provider-executed tools, automatically appending the results to the message history without any additional configuration.

AI SDK 现已原生支持由提供商执行的工具，无需额外配置，即可自动将工具执行结果追加至消息历史中。

```javascript
import { openai } from '@ai-sdk/openai';

import { generateText } from 'ai';



const result = await generateText({

5  model: openai.responses('gpt-4o-mini'),

6  tools: {

7    web_search_preview: openai.tools.webSearchPreview({}),
```

8  },

9  // ...

10});
```

### **Tool Lifecycle Hooks**

### **工具生命周期钩子**

AI SDK 5 引入了细粒度的工具生命周期钩子（`onInputStart`、`onInputDelta`、`onInputAvailable`），这些钩子可与数据片段（data parts）配合使用，将输入相关的信息（例如状态更新）回传给客户端。

```javascript
const weatherTool = tool({

2  description: 'Get the weather for a given city',

3  inputSchema: z.object({ city: z.string() }),

4  onInputStart: ({ toolCallId }) => {

5    console.log('Tool input streaming started:', toolCallId);

6  },

7  onInputDelta: ({ inputTextDelta, toolCallId }) => {

7  onInputDelta: ({ inputTextDelta, toolCallId }) => {

8    console.log('Tool input delta:', inputTextDelta);

8    console.log('工具输入增量：', inputTextDelta);

9  },

9  },

10  onInputAvailable: ({ input, toolCallId }) => {

10  onInputAvailable: ({ input, toolCallId }) => {

11    console.log('Tool input ready:', input);

11    console.log('工具输入就绪：', input);

12  },

12  },

13  execute: async ({ city }) => {

13  execute: async ({ city }) => {

14    return `Weather in ${city}: sunny, 72°F`;

14    return `城市 ${city} 的天气：晴朗，72°F`;

16});
```

### **Tool Provider Options**

### **工具提供方选项**

AI SDK 5 新增了对工具级提供方选项（tool-level provider options）的支持。例如，您可以利用该功能将工具定义缓存至 Anthropic，从而为多步骤智能体（multi-step agents）减少 token 消耗、处理时间及成本：

```javascript
const result = await generateText({

2  model: anthropic('claude-3-5-sonnet-20240620'),

3  tools: {

4    cityAttractions: tool({

5      inputSchema: z.object({ city: z.string() }),

6      // 为单个工具应用特定于提供方的选项

7      providerOptions: {

8        anthropic: {

8        anthropic: {

9          cacheControl: { type: 'ephemeral' },

9          缓存控制：{ type: 'ephemeral' },

10        },

10        },

11      },

11      },

12      execute: async ({ city }) => {

12      execute: async ({ city }) => {

13        // Implementation

13        // 实现逻辑

14      },

14      },

15    }),

15    }),

16  },

16  },

17});

17});

## V2 Specifications

## V2 规范

The foundation of the AI SDK is the specification layer, which standardizes how different language models, embeddings models, etc. plug into functions such as `streamText`. The specification layer enables the provider architecture of the AI SDK.

AI SDK 的基础是规范层（specification layer），它标准化了各类语言模型、嵌入模型等如何接入 `streamText` 等函数。该规范层支撑了 AI SDK 的提供者（provider）架构。

In AI SDK 5, we have updated all specifications to V2. These new specifications incorporate changes in the underlying API capabilities (like provider-executed tools) and have extensibility mechanisms such as provider metadata and options. They will serve as the foundation for AI SDK 5 and beyond.

在 AI SDK 5 中，我们已将全部规范升级至 V2 版本。这些新规范整合了底层 API 能力的演进（例如由提供者执行的工具），并引入了扩展机制，如提供者元数据（provider metadata）和选项（options）。它们将成为 AI SDK 5 及后续版本的基石。

To learn more about the V2 specifications, visit the [custom provider documentation](https://v5.ai-sdk.dev/providers/community-providers/custom-providers).

如需深入了解 V2 规范，请访问 [自定义提供者文档](https://v5.ai-sdk.dev/providers/community-providers/custom-providers)。

## Global Provider

## 全局提供者

The AI SDK 5 includes a global provider feature that allows you to specify a model using just a plain model ID string:

AI SDK 5 引入了全局提供者（global provider）功能，使您仅需一个简洁的模型 ID 字符串即可指定模型：

```javascript
import { streamText } from 'ai';



const result = await streamText({

4  model: 'openai/gpt-4o', // Uses the global provider (defaults to AI Gateway)
```

5  prompt: 'Invent a new holiday and describe its traditions.',

5  提示词：“创造一个新节日，并描述其传统习俗。”

6});
```

By default, the global provider is set to the [Vercel AI Gateway](https://vercel.com/docs/ai-gateway).

默认情况下，全局提供者被设置为 [Vercel AI 网关](https://vercel.com/docs/ai-gateway)。

### Customizing the Global Provider

### 自定义全局提供者

You can set your own preferred global provider:

您可以设置自己偏好的全局提供者：

```javascript
import { openai } from '@ai-sdk/openai';

import { streamText } from 'ai';



4// Initialise once during startup:

4// 在启动期间初始化一次：

globalThis.AI_SDK_DEFAULT_PROVIDER = openai;

7// 在代码库的其他位置：

const result = streamText({

9  model: 'gpt-4o', // 使用 OpenAI 提供商，无需添加前缀

10  prompt: '发明一个新节日，并描述其传统习俗。',

11});
```

这简化了提供方（provider）的使用方式，使你在不修改代码库中各处模型引用的前提下，更轻松地在不同提供方之间切换。

## 访问原始响应

当你需要完全控制权，或希望在某项功能被官方正式支持之前就自行实现时，AI SDK 提供了对原始请求与响应数据的完整访问能力。这一“逃生通道”（escape hatch）对于调试、实现特定提供方的功能，或处理边缘情况而言极为宝贵。

### 原始流式数据块

With AI SDK 5, you can access the raw chunks with streamed functions as they are received from your provider:

AI SDK 5 中，您可以通过流式函数访问从服务商接收到的原始数据块（raw chunks）：

```javascript
import { openai } from "@ai-sdk/openai";

import { streamText } from "ai";



const result = streamText({

5  model: openai("gpt-4o-mini"),

6  prompt: "Invent a new holiday and describe its traditions.",

7  includeRawChunks: true,

8});
```

10// Access raw chunks through fullStream

10// 通过 fullStream 访问原始数据块

for await (const part of result.fullStream) {

for await (const part of result.fullStream) {

12  if (part.type === "raw") {

12  if (part.type === "raw") {

13    // Access provider-specific data structures

13    // 访问提供商特定的数据结构

14    // e.g., OpenAI's choices, usage, etc.

14    // 例如：OpenAI 的 choices、usage 等

15    console.log("Raw chunk:", part.rawValue);

15    console.log("原始数据块:", part.rawValue);

16  }

16  }

17}

17}

```

```

### Request and Response Bodies

### 请求与响应体

You can also access the exact request sent to the provider and the full response received:

您还可以访问发送给提供商的确切请求以及接收到的完整响应：

```javascript
const result = await generateText({

2  model: openai("gpt-4o"),

3  prompt: "Write a haiku about debugging",

4});



6// Access the raw request body sent to the provider

6// 访问发送给模型提供商的原始请求体

7// See exact prompt formatting, parameters, etc.

7// 查看确切的提示词格式、参数等。

console.log("Request:", result.request.body);



10// Access the raw response body from the provider

10// 访问来自模型提供商的原始响应体
```

11// Full provider response including metadata

11// 完整的提供商响应（包含元数据）

console.log("Response:", result.response.body);
```

console.log("Response:", result.response.body);
```

## Zod 4 Support

## Zod 4 支持

AI SDK 5 supports Zod 4. You can use either Zod 3 or the new [Zod 4 mini](https://zod.dev/v4) schemas for input and output validation across all validation-enabled APIs.

AI SDK 5 支持 Zod 4。您可在所有支持验证功能的 API 中，选择使用 Zod 3 或全新的 [Zod 4 mini](https://zod.dev/v4) 模式进行输入与输出验证。

We recommend using Zod 4 for new projects. Follow the recommendation on the [Zod v4 docs](https://zod.dev/v4/#installation).

我们建议新项目采用 Zod 4。请参阅 [Zod v4 文档](https://zod.dev/v4/#installation) 中的相关建议。

## **Migrating to AI SDK 5**

## **迁移到 AI SDK 5**

AI SDK 5 includes breaking changes that remove deprecated APIs. We've made the migration process easier with automated migration tools. You can run our automated codemods to handle some of the changes.

AI SDK 5 包含若干破坏性变更，移除了已弃用的 API。我们提供了自动迁移工具，以简化迁移流程。您可运行我们的自动化 codemod 工具来处理部分变更。

```bash
npx @ai-sdk/codemod upgrade
```

```bash
npx @ai-sdk/codemod upgrade
```

For a detailed overview of all changes and manual steps that might be needed, refer to our [AI SDK 5 migration guide](https://v5.ai-sdk.dev/docs/migration-guides/migration-guide-5-0). The guide includes step-by-step instructions and examples to ensure a smooth update.

如需全面了解所有变更内容以及可能需要的手动调整步骤，请参阅我们的 [AI SDK 5 迁移指南](https://v5.ai-sdk.dev/docs/migration-guides/migration-guide-5-0)。该指南提供分步操作说明与示例，助您顺利完成升级。

## Getting started

## 入门指南

With redesigned chat, agentic control and a new specification, there's never been a better time to start building AI applications with the AI SDK.

借助重新设计的聊天界面、智能体控制能力以及全新规范，现在正是使用 AI SDK 构建 AI 应用的最佳时机。

- **Start a new AI project:** Ready to build something new? Check out our latest [guides](https://v5.ai-sdk.dev/).

- **启动一个全新的 AI 项目：** 准备好构建新应用了吗？请查阅我们最新的[入门指南](https://v5.ai-sdk.dev/)。

- **Explore our templates:** Visit our [Template Gallery](https://vercel.com/templates/ai) to see the AI SDK in action.

- **探索我们的模板：** 访问我们的[模板画廊](https://vercel.com/templates/ai)，亲身体验 AI SDK 的实际应用效果。

- **Migrate to v5:** Upgrading an existing project? Our comprehensive [Migration Guide](https://v5.ai-sdk.dev/docs/migration-guides/migration-guide-5-0) and codemods are ready to help.

- **迁移到 v5 版本：** 正在升级现有项目？我们详尽的[迁移指南](https://v5.ai-sdk.dev/docs/migration-guides/migration-guide-5-0)和自动化代码迁移工具（codemods）已准备就绪，助您顺利完成升级。

- **Chat SDK:** Check out [the Chat SDK open-source template](https://chat-sdk.dev/) that helps you quickly build powerful chatbot applications without starting from scratch.

- **Chat SDK：** 查看 [Chat SDK 开源模板](https://chat-sdk.dev/)，它能帮您无需从零开始，快速构建功能强大的聊天机器人应用。

- **Join the community:** Share what you're building and get help in our [GitHub Discussions](https://github.com/vercel/ai/discussions).

- **加入社区：** 在我们的 [GitHub Discussions](https://github.com/vercel/ai/discussions) 中分享您的项目成果，并获取帮助与支持。

## Contributors

## 贡献者

AI SDK 5 is the result of the combined work of our core team at Vercel ( [Lars](https://x.com/lgrammel), [Nico](https://x.com/nicoalbanese10), and [Josh](https://x.com/nishimiya)) and our amazing community of contributors:

AI SDK 5 是 Vercel 核心团队（[Lars](https://x.com/lgrammel)、[Nico](https://x.com/nicoalbanese10) 和 [Josh](https://x.com/nishimiya)）与众多杰出贡献者通力协作的成果：

[@R-Taneja](https://github.com/R-Taneja), [@danielamitay](https://github.com/danielamitay), [@Und3rf10w](https://github.com/Und3rf10w), [@kvnang](https://github.com/kvnang), [@jakesjews](https://github.com/jakesjews), [@shaper](https://github.com/shaper), [@ankrgyl](https://github.com/ankrgyl), [@gkarthi-signoz](https://github.com/gkarthi-signoz), [@bytaesu](https://github.com/bytaesu), [@ben-vargas](https://github.com/ben-vargas), [@jakobhoeg](https://github.com/jakobhoeg), [@andrico1234](https://github.com/andrico1234), [@jessevdp](https://github.com/jessevdp), [@cristiand391](https://github.com/cristiand391), [@shelleypham](https://github.com/shelleypham), [@damianstasik](https://github.com/damianstasik), [@petergoldstein](https://github.com/petergoldstein), [@lucaazalim](https://github.com/lucaazalim), [@li-kai](https://github.com/li-kai), [@remorses](https://github.com/remorses), [@Potrock](https://github.com/Potrock), [@cwgorman](https://github.com/cwgorman), [@jpdenford](https://github.com/jpdenford), [@allenzhou101](https://github.com/allenzhou101), [@jonaslalin](https://github.com/jonaslalin), [@quuu](https://github.com/quuu), [@jeremyphilemon](https://github.com/jeremyphilemon), [@jeffbarg](https://github.com/jeffbarg), [@zabealbe](https://github.com/zabealbe), [@Gaubee](https://github.com/Gaubee), [@FranciscoMoretti](https://github.com/FranciscoMoretti), [@undo76](https://github.com/undo76), [@winzamark123](https://github.com/winzamark123), [@psinha40898](https://github.com/psinha40898), [@patrickloeber](https://github.com/patrickloeber), [@iteratetograceness](https://github.com/iteratetograceness), [@gr2m](https://github.com/gr2m), [@patelvivekdev](https://github.com/patelvivekdev), [@nvti](https://github.com/nvti), [@jacoblee93](https://github.com/jacoblee93), [@AbhiPrasad](https://github.com/AbhiPrasad), [@huanshenyi](https://github.com/huanshenyi), [@DeJeune](https://github.com/DeJeune), [@tleekkul](https://github.com/tleekkul), [@albertlast](https://github.com/albertlast), [@mmstroik](https://github.com/mmstroik), [@http-samc](https://github.com/http-samc), [@QuantGeekDev](https://github.com/QuantGeekDev), [@benjamincburns](https://github.com/benjamincburns), [@chrisvariety](https://github.com/chrisvariety), [@himanshusinghs](https://github.com/himanshusinghs), [@gorango](https://github.com/gorango), [@joshualipman123](https://github.com/joshualipman123), [@abhikjain360](https://github.com/abhikjain360), [@zhm](https://github.com/zhm), [@elliott-with-the-longest-name-on-github](https://github.com/elliott-with-the-longest-name-on-github), [@samdenty](https://github.com/samdenty), [@cgoinglove](https://github.com/cgoinglove), [@minpeter](https://github.com/minpeter), [@haydenbleasel](https://github.com/haydenbleasel), [@SnehanChakravarthi](https://github.com/SnehanChakravarthi), [@Sma1lboy](https://github.com/Sma1lboy), [@faiz-gear](https://github.com/faiz-gear), [@mattzcarey](https://github.com/mattzcarey), [@BramMeerten](https://github.com/BramMeerten), [@gentamura](https://github.com/gentamura), [@colegottdank](https://github.com/colegottdank), [@wobsoriano](https://github.com/wobsoriano), [@philipkiely-baseten](https://github.com/philipkiely-baseten), [@AmagiDDmxh](https://github.com/AmagiDDmxh), [@dylanmoz](https://github.com/dylanmoz), [@Deipzza](https://github.com/Deipzza), [@whysosaket](https://github.com/whysosaket), [@leopardracer](https://github.com/leopardracer), [@archiewood](https://github.com/archiewood), [@theswerd](https://github.com/theswerd), [@chasewoo](https://github.com/chasewoo), [@omahs](https://github.com/omahs), [@akselleirv](https://github.com/akselleirv), [@EricZhou0815](https://github.com/EricZhou0815), [@mxzinke](https://github.com/mxzinke)

Your feedback, bug reports, and pull requests on GitHub have been instrumental in shaping this release. We're excited to see what you'll build with these new capabilities.

您在 GitHub 上提交的反馈意见、缺陷报告（bug reports）和拉取请求（pull requests）对本次版本的成型起到了至关重要的作用。我们热切期待您利用这些全新能力所构建出的精彩应用！

[![Matt Pocock](images/ai-sdk-5-vercel/img_002.jpg)](https://x.com/mattpocockuk/status/1942239821067665665)

[马特·波科克（Matt Pocock）](https://x.com/mattpocockuk/status/1942239821067665665)


· [关注](https://x.com/intent/follow?screen_name=mattpocockuk)

[在 Twitter 上查看](https://x.com/mattpocockuk/status/1942239821067665665)

AI SDK v5 真的、真的非常出色！

\- 大幅精简冗余代码  
\- 显著提升灵活性  
\- 类型安全性大幅增强  
\- 支持更多大语言模型（LLM）功能  

[2025 年 7 月 7 日 上午 11:10](https://x.com/mattpocockuk/status/1942239821067665665) [Twitter 网站版、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[418 次点赞](https://x.com/intent/like?tweet_id=1942239821067665665) [回复](https://x.com/intent/tweet?in_reply_to=1942239821067665665)


[阅读 15 条回复](https://x.com/mattpocockuk/status/1942239821067665665)

[![萨米·印地（Sami Hindi）](images/ai-sdk-5-vercel/img_003.jpg)](https://x.com/DevBySami/status/1950255041996079197)

[Sami Hindi](https://x.com/DevBySami/status/1950255041996079197)

[萨米·阿拉伯语](https://x.com/DevBySami/status/1950255041996079197)

· [Follow](https://x.com/intent/follow?screen_name=DevBySami)

· [关注](https://x.com/intent/follow?screen_name=DevBySami)

[View on Twitter](https://x.com/DevBySami/status/1950255041996079197)

[在 Twitter 上查看](https://x.com/DevBySami/status/1950255041996079197)

wasn’t expecting the new message system to make such a difference in [@aisdk](https://x.com/aisdk)

没想到新的消息系统会在 [@aisdk](https://x.com/aisdk) 中带来如此显著的改善。

separating UI and model messages cleans up so much front-end spaghetti

将 UI 消息与模型消息分离，大幅简化了前端“意大利面式”代码（spaghetti code）。

can actually read my own code now

现在我终于能看懂自己写的代码了。

not gonna miss the tangled chat logic

再也不会怀念那些错综复杂的聊天逻辑了。

[2:00 PM · Jul 29, 2025](https://x.com/DevBySami/status/1950255041996079197) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[下午 2:00 · 2025 年 7 月 29 日](https://x.com/DevBySami/status/1950255041996079197) [面向网站的 Twitter、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[10](https://x.com/intent/like?tweet_id=1950255041996079197) [Reply](https://x.com/intent/tweet?in_reply_to=1950255041996079197)

[10 次点赞](https://x.com/intent/like?tweet_id=1950255041996079197) [回复](https://x.com/intent/tweet?in_reply_to=1950255041996079197)

[Read 2 replies](https://x.com/DevBySami/status/1950255041996079197)

[阅读 2 条回复](https://x.com/DevBySami/status/1950255041996079197)

[![Josh tried coding](images/ai-sdk-5-vercel/img_004.jpg)](https://x.com/joshtriedcoding/status/1950554058000847235)

[![Josh tried coding](images/ai-sdk-5-vercel/img_004.jpg)](https://x.com/joshtriedcoding/status/1950554058000847235)

[Josh tried coding](https://x.com/joshtriedcoding/status/1950554058000847235)

[Josh tried coding](https://x.com/joshtriedcoding/status/1950554058000847235)


· [Follow](https://x.com/intent/follow?screen_name=joshtriedcoding)

· [关注](https://x.com/intent/follow?screen_name=joshtriedcoding)

[View on Twitter](https://x.com/joshtriedcoding/status/1950554058000847235)

在 Twitter 上查看

im very impressed with the ai-sdk v5

我对 ai-sdk v5 印象非常深刻

◆ fully type-safe server to client  
◆ 服务端到客户端完全类型安全  

◆ easy to stream custom data  
◆ 轻松流式传输自定义数据  

demo coming very soon  
演示即将上线  

[9:48 AM · Jul 30, 2025](https://x.com/joshtriedcoding/status/1950554058000847235) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[上午 9:48 · 2025 年 7 月 30 日](https://x.com/joshtriedcoding/status/1950554058000847235) [面向网站的 Twitter、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[148](https://x.com/intent/like?tweet_id=1950554058000847235) [Reply](https://x.com/intent/tweet?in_reply_to=1950554058000847235)

[148 次点赞](https://x.com/intent/like?tweet_id=1950554058000847235) [回复](https://x.com/intent/tweet?in_reply_to=1950554058000847235)


[Read 7 replies](https://x.com/joshtriedcoding/status/1950554058000847235)

阅读 7 条回复

· [关注](https://x.com/intent/follow?screen_name=SullyOmarr)

[在 Twitter 上查看](https://x.com/SullyOmarr/status/1940106909698465844)

man [@aisdk](https://x.com/aisdk) v5 太棒了，不用它来构建智能体（agents）反而觉得有点遗憾。

其他语言（比如 Python 等）有没有对应的等效库或替代方案？

[2025 年 7 月 1 日 下午 1:55](https://x.com/SullyOmarr/status/1940106909698465844) [Twitter 网站版、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[254](https://x.com/intent/like?tweet_id=1940106909698465844) [回复](https://x.com/intent/tweet?in_reply_to=1940106909698465844)


[阅读 35 条回复](https://x.com/SullyOmarr/status/1940106909698465844)

[![Alex Moore](images/ai-sdk-5-vercel/img_005.jpg)](https://x.com/ikindacode/status/1944211984645255551)

[Alex Moore](https://x.com/ikindacode/status/1944211984645255551)

· [关注](https://x.com/intent/follow?screen_name=ikindacode)

[在 Twitter 上查看](https://x.com/ikindacode/status/1944211984645255551)

刚刚用 [@aisdk](https://x.com/aisdk) 测试了全新的 [@vercel](https://x.com/vercel) AI Gateway，简直美梦成真！意思是，我只需替换一个字符串，啪的一下，就切换到了另一个模型？就这么简单？😮‍💨

[2025 年 7 月 12 日 晚上 9:47](https://x.com/ikindacode/status/1944211984645255551) [Twitter 网站版、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[36](https://x.com/intent/like?tweet_id=1944211984645255551) [回复](https://x.com/intent/tweet?in_reply_to=1944211984645255551)


[阅读 4 条回复](https://x.com/ikindacode/status/1944211984645255551)

[![Francisco Moretti](images/ai-sdk-5-vercel/img_006.jpg)](https://x.com/franmoretti_/status/1942919268313534638)

[Francisco Moretti](https://x.com/franmoretti_/status/1942919268313534638)


· [关注](https://x.com/intent/follow?screen_name=franmoretti_)

[在 Twitter 上查看](https://x.com/franmoretti_/status/1942919268313534638)

AI SDK v5 is a masterpiece. Migration resulted in more typesafety, more control and flexibility, with less code

AI SDK v5 是一件杰作。迁移后，类型安全性更高、控制力与灵活性更强，同时代码量更少。

[8:10 AM · Jul 9, 2025](https://x.com/franmoretti_/status/1942919268313534638) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[上午 8:10 · 2025 年 7 月 9 日](https://x.com/franmoretti_/status/1942919268313534638) [面向网站的 X（原 Twitter）、广告信息与隐私政策](https://help.x.com/zh-cn/x-for-websites-ads-info-and-privacy)

[13](https://x.com/intent/like?tweet_id=1942919268313534638) [Reply](https://x.com/intent/tweet?in_reply_to=1942919268313534638)

[13 次点赞](https://x.com/intent/like?tweet_id=1942919268313534638) [回复](https://x.com/intent/tweet?in_reply_to=1942919268313534638)


[Read more on X](https://x.com/franmoretti_/status/1942919268313534638)

[在 X 上阅读更多](https://x.com/franmoretti_/status/1942919268313534638)