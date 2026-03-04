---
title: "AI SDK 4.2 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-4-2"
date: "2025-03-21"
scraped_at: "2026-03-02T09:35:26.456420267+00:00"
language: "en-zh"
translated: true
description: "AI SDK 4.2 introduces MCP clients, reasoning, image generation with language models, message parts, sources, and more"
---

render_with_liquid: false
Mar 21, 2025

2025 年 3 月 21 日

推出 MCP 客户端、推理能力、信息来源支持等新特性。

The [AI SDK](https://sdk.vercel.ai/) is an open-source toolkit for building AI applications with JavaScript and TypeScript. Its unified provider API allows you to use any language model and enables powerful UI integrations into leading web frameworks such as [Next.js](https://nextjs.org/) and [Svelte](https://svelte.dev/).

[AI SDK](https://sdk.vercel.ai/) 是一个开源工具包，用于使用 JavaScript 和 TypeScript 构建 AI 应用。其统一的 Provider API 使您能够接入任意语言模型，并支持与主流 Web 框架（如 [Next.js](https://nextjs.org/) 和 [Svelte](https://svelte.dev/)）进行深度、强大的 UI 集成。

With over 1 million weekly downloads, developers are using the SDK to create [incredible applications](https://vercel.com/blog/ai-sdk-4-2#showcase) like [Otto](https://ottogrid.ai/), an AI-powered research tool:

凭借每周超百万次的下载量，开发者正利用该 SDK 构建一系列[令人惊叹的应用](https://vercel.com/blog/ai-sdk-4-2#showcase)，例如 AI 驱动的研究工具 [Otto](https://ottogrid.ai/)：

> “The AI SDK powers everything in Otto, from agents to structuring data to building workflows. With the AI SDK we can focus on building our product, letting us deliver updates much faster. Best of all, we don't have to worry about supporting new models when they change - the AI SDK does it for us, letting us ship updates faster.The AI SDK powers everything in Otto, from agents to structuring data to building workflows. With the AI SDK we can focus on building our product, letting us deliver updates much faster. Best of all, we don't have to worry about supporting new models when they change - the AI SDK does it for us, letting us ship updates faster.”
>
> “AI SDK 支撑着 Otto 的全部功能——从智能体（agents）到数据结构化，再到工作流构建。借助 AI SDK，我们可以专注于产品本身，从而更快地交付更新。最重要的是，当新模型发布或现有模型变更时，我们无需操心兼容性问题——AI SDK 已为我们代劳，让我们得以加速发布更新。”

> ![](images/ai-sdk-4_2-vercel/img_001.png)
>
> ![](images/ai-sdk-4_2-vercel/img_001.png)

> **Sully Omar**

> **Sully Omar**

Today, we're announcing the release of AI SDK 4.2, which introduces:

今天，我们正式发布 AI SDK 4.2 版本，本次更新带来以下重要特性：

- [Reasoning](https://vercel.com/blog/ai-sdk-4-2#reasoning)

- [推理能力（Reasoning）](https://vercel.com/blog/ai-sdk-4-2#reasoning)

- [Model Context Protocol (MCP) clients](https://vercel.com/blog/ai-sdk-4-2#model-context-protocol-(mcp)-clients)

- [模型上下文协议（MCP）客户端](https://vercel.com/blog/ai-sdk-4-2#model-context-protocol-(mcp)-clients)

- [useChat Message Parts](https://vercel.com/blog/ai-sdk-4-2#usechat-message-parts)

- [useChat 消息分段（Message Parts）](https://vercel.com/blog/ai-sdk-4-2#usechat-message-parts)

- [Image Generation with Language Models](https://vercel.com/blog/ai-sdk-4-2#image-generation-with-language-models)

- [基于语言模型的图像生成（Image Generation with Language Models）](https://vercel.com/blog/ai-sdk-4-2#image-generation-with-language-models)

- [URL Sources](https://vercel.com/blog/ai-sdk-4-2#url-sources)

- [URL 源](https://vercel.com/blog/ai-sdk-4-2#url-sources)

- [OpenAI Responses API](https://vercel.com/blog/ai-sdk-4-2#openai-responses-api)

- [OpenAI Responses API](https://vercel.com/blog/ai-sdk-4-2#openai-responses-api)

- [Svelte 5](https://vercel.com/blog/ai-sdk-4-2#svelte-5)

- [Svelte 5](https://vercel.com/blog/ai-sdk-4-2#svelte-5)

- [Middleware updates](https://vercel.com/blog/ai-sdk-4-2#middleware-updates)

- [中间件更新](https://vercel.com/blog/ai-sdk-4-2#middleware-updates)


Let’s explore these new features and improvements.

让我们一起探索这些新功能与改进。

## **Reasoning**

## **推理能力**

https://ai-sdk-reasoning.vercel.app

https://ai-sdk-reasoning.vercel.app

Reasoning models—like Anthropic Sonnet 3.7 and DeepSeek R1—dedicate computational resources at inference-time to work through problems methodically, much like a human showing their chain-of-thought. This approach produces more accurate and reliable results than traditional models, especially for tasks involving logic or multi-step analysis.

推理模型（例如 Anthropic Sonnet 3.7 和 DeepSeek R1）在推理阶段专门分配计算资源，以系统化的方式逐步解决问题，其过程类似于人类展示“思维链”（chain-of-thought）。相比传统模型，该方法能生成更准确、更可靠的结果，尤其适用于涉及逻辑推理或多步分析的任务。

The AI SDK now supports reasoning models across major providers. You can use a reasoning model like Anthropic’s Claude 3.7 Sonnet with the AI SDK just like any other model. You can access the model’s reasoning tokens with the `reasoning` property:

AI SDK 现已支持主流服务商的推理模型。您可像使用其他模型一样，在 AI SDK 中直接调用 Anthropic 的 Claude 3.7 Sonnet 等推理模型。您可通过 `reasoning` 属性访问模型生成的推理 token：

```tsx
import { generateText } from 'ai';
```

```ts
import { anthropic } from '@ai-sdk/anthropic';



const { text, reasoning } = await generateText({

5  model: anthropic('claude-3-7-sonnet-20250219'),

6  prompt: 'How many people will live in the world in 2040?',

7});
```

```ts
导入 anthropic 模块：`import { anthropic } from '@ai-sdk/anthropic';`



const { text, reasoning } = await generateText({

5  model: anthropic('claude-3-7-sonnet-20250219'),

6  prompt: '到 2040 年，全球将有多少人口？',

7});
```

You can experiment with different models to find the best fit for your application. You can easily switch between providers by changing just two lines of code:

您可以尝试不同的模型，为您的应用选择最合适的模型。只需修改两行代码，即可轻松切换不同服务商：

```tsx
import { generateText } from 'ai';

import { bedrock } from '@ai-sdk/amazon-bedrock';
```

```tsx
import { generateText } from 'ai';

import { bedrock } from '@ai-sdk/amazon-bedrock';
```

```javascript
const { text, reasoning } = await generateText({
  model: bedrock('anthropic.claude-3-7-sonnet-20250219-v1:0'),
  prompt: 'How many people will live in the world in 2040?',
});
```

```javascript
const { text, reasoning } = await generateText({
  model: bedrock('anthropic.claude-3-7-sonnet-20250219-v1:0'),
  prompt: 'How many people will live in the world in 2040?',
});
```

For providers that include reasoning as part of their text output rather than as separate tokens, you can use the `extractReasoningMiddleware` that automatically pulls reasoning content from formatted responses. This ensures a consistent experience across OpenAI, Anthropic, Groq, Together AI, Azure OpenAI, and other providers—without changing your application code.

对于将推理（reasoning）内容嵌入文本输出中（而非以独立 token 形式返回）的模型服务商，您可以使用 `extractReasoningMiddleware` 中间件，它能自动从格式化的响应中提取推理内容。这确保了在 OpenAI、Anthropic、Groq、Together AI、Azure OpenAI 等各类服务商之间提供一致的体验——且无需修改您的应用代码。

To see reasoning in action, check out the [AI SDK Reasoning template](https://ai-sdk-reasoning.vercel.app/). To learn more, check out our [reasoning documentation](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot#reasoning).

如需直观了解推理功能的实际效果，请访问 [AI SDK 推理模板](https://ai-sdk-reasoning.vercel.app/)。如需深入了解，请查阅我们的 [推理功能文档](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot#reasoning)。

## -clients) **Model Context Protocol (MCP) Clients**

## -clients) **模型上下文协议（MCP）客户端**

The AI SDK now supports the [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction), an open standard that connects your applications to a growing ecosystem of tools and integrations. With MCP support, you can [access hundreds of pre-built tools](https://github.com/modelcontextprotocol/servers) (”servers”) that add powerful functionality to your application. Some popular MCP servers include:

AI SDK 现已支持 [模型上下文协议（Model Context Protocol, MCP）](https://modelcontextprotocol.io/introduction)，这是一个开放标准，可将您的应用程序接入日益壮大的工具与集成生态。借助 MCP 支持，您可 [访问数百个预构建的工具](https://github.com/modelcontextprotocol/servers)（即“服务器”），为您的应用增添强大功能。一些广受欢迎的 MCP 服务器包括：

- [GitHub](https://github.com/modelcontextprotocol/servers/blob/main/src/github) \- manage repositories, issues, and pull requests

- [GitHub](https://github.com/modelcontextprotocol/servers/blob/main/src/github) —— 管理代码仓库、议题（issues）和拉取请求（pull requests）

- [Slack](https://github.com/modelcontextprotocol/servers/blob/main/src/slack) \- send messages and interact with workspaces

- [Slack](https://github.com/modelcontextprotocol/servers/blob/main/src/slack) —— 发送消息并与工作区（workspace）交互

- [Filesystem](https://github.com/modelcontextprotocol/servers/blob/main/src/filesystem) — Secure file operations with configurable access controls  
- [文件系统](https://github.com/modelcontextprotocol/servers/blob/main/src/filesystem) — 支持可配置访问控制的安全文件操作


As MCP is an open-protocol, your users can also build and connect their own custom MCP servers to extend your applications functionality as needed. MCP has many use cases, but is particularly powerful for local code automation.  
由于 MCP 是一种开放协议，您的用户也可以构建并接入自定义的 MCP 服务器，按需扩展您应用程序的功能。MCP 拥有众多应用场景，尤其擅长本地代码自动化。

The SDK supports connecting to MCP servers via either stdio (for local tools) or SSE (for remote servers). Once connected, you can use MCP tools directly with the AI SDK:  
SDK 支持通过 stdio（适用于本地工具）或 SSE（适用于远程服务器）两种方式连接 MCP 服务器。连接建立后，您即可直接在 AI SDK 中调用 MCP 工具：

```tsx
import { experimental_createMCPClient as createMCPClient } from 'ai';

import { openai } from '@ai-sdk/openai';



const mcpClient = await createMCPClient({

5  transport: {

6    type: 'sse',

7    url: 'https://my-server.com/sse',
```

8  },

9});



const response = await generateText({

12  model: openai('gpt-4o'),

13  tools: await mcpClient.tools(), // 使用 MCP 工具

14  prompt: '查找价格低于 100 美元的产品',

15});
```

如需了解如何在您的项目中实现 MCP，请参阅我们的 [MCP 工具文档](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#using-mcp-tools) 以及分步式 [MCP 食谱](https://sdk.vercel.ai/cookbook/node/mcp-tools)。

## useChat 消息组成部分

## useChat Message Parts

Language models produce more than just text -- they combine reasoning, sources, tool calls, and text responses, all in one message. With multi-step agentic use cases, these different types of outputs are frequently mixed together in a single response.

语言模型生成的内容远不止文本——它们将推理过程、信息来源、工具调用和文本响应全部整合在单条消息中。在多步骤的智能体（agentic）应用场景中，这些不同类型的输出常常混合出现在同一响应中。

AI SDK 4.2 introduces message parts to `useChat`, a new way to handle these different types of outputs that preserve their exact sequence.

AI SDK 4.2 为 `useChat` 引入了“消息部件”（message parts）机制，这是一种全新的方式，用于处理上述各类输出，并严格保持其原始顺序。

```tsx
function Chat() {

2  const { messages } = useChat();

3  return (

4    <div>

5      {messages.map(message => (

6        message.parts.map((part, i) => {

7          switch (part.type) {

8            case "text": return <p key={i}>{part.text}</p>;
```

9            case "source": return <p key={i}>{part.source.url}</p>;

9            情况为 "source" 时：返回 `<p key={i}>{part.source.url}</p>`；

10            case "reasoning": return <div key={i}>{part.reasoning}</div>;

10            情况为 "reasoning" 时：返回 `<div key={i}>{part.reasoning}</div>`；

11            case "tool-invocation": return <div key={i}>{part.toolInvocation.toolName}</div>;

11            情况为 "tool-invocation" 时：返回 `<div key={i}>{part.toolInvocation.toolName}</div>`；

12            case "file": return <img key={i} src={`data:${part.mimeType};base64,${part.data}`} />;

12            情况为 "file" 时：返回 `<img key={i} src={`data:${part.mimeType};base64,${part.data}`} />`；

13          }

13          }

14        })

14        })

15      ))}

15      ))}

16    </div>

16    </div>

17  );

17  );

18}
```

18}
```

We plan to add more part types in future 4.2.x releases. To learn more, check out our [4.2 migration guide](https://sdk.vercel.ai/docs/migration-guides/migration-guide-4-2).

我们计划在未来的 4.2.x 版本中添加更多消息部件类型。欲了解详情，请查阅我们的 [4.2 迁移指南](https://sdk.vercel.ai/docs/migration-guides/migration-guide-4-2)。

## **Image Generation with Language Models**

## **使用语言模型生成图像**

Google's Gemini 2.0 Flash is the first language model capable of producing images directly as part of the response. The AI SDK supports this feature, enabling multi-modal chatbots that can generate and understand both text and images.

Google 的 Gemini 2.0 Flash 是首个能够直接在响应中生成图像的语言模型。AI SDK 支持该功能，从而赋能多模态聊天机器人，使其既能生成也能理解文本与图像。

On the client, you can access images generated by the language model with the `file` message part with `useChat`:

在客户端，您可通过 `useChat` 的 `file` 消息部件访问语言模型所生成的图像：

```tsx
import { useChat } from '@ai-sdk/react';



export default function Chat() {

4  const { messages } = useChat();



6  return (

7    <div>

7    <div>

8      {messages.map(message => (

8      {messages.map(message => (

9        <div key={message.id}>

9        <div key={message.id}>

10          {message.role === 'user' ? 'User: ' : 'AI: '}

10          {message.role === 'user' ? '用户：' : 'AI：'}

11          {message.parts.map((part, i) => {

11          {message.parts.map((part, i) => {

12            if (part.type === 'text') {

12            if (part.type === 'text') {

13              return <div key={i}>{part.text}</div>;

13              return <div key={i}>{part.text}</div>;

14            } else if (

14            } else if (

15              part.type === 'file' &&

15              part.type === 'file' &&

16              part.mimeType.startsWith('image/') 

16              part.mimeType.startsWith('image/')

17            ) {

17            ) {

18              return (

18              返回 (

19                <img

19                <img

20                  key={i}

20                  key={i}

21                  src={`data:${part.mimeType};base64,${part.data}`}

21                  src={`data:${part.mimeType};base64,${part.data}`}

22                  alt="Generated image"

22                  alt="生成的图像"

23                />

23                />

24              );

24              );

25            }

25            }

26          })}

27        </div>

27        </div>

28      ))}

28      ))}

29    </div>

29    </div>

30  );

30  );

31}
```

31}
```

When images are generated, they become part of your chat history just like text messages. You can reference, iterate on, or "edit" previously generated images through natural conversation - asking the model to modify colors, adjust styles, or create variations while maintaining context of the visual conversation.

生成图像后，它们会像文本消息一样成为您聊天记录的一部分。您可以通过自然对话的方式引用、迭代或“编辑”先前生成的图像——例如，要求模型修改颜色、调整风格，或在保持视觉对话上下文的前提下生成变体。

To learn more, check out our [file generation documentation](https://sdk.vercel.ai/docs/ai-sdk-core/image-generation#generating-images-with-language-models).

如需了解更多，请参阅我们的[文件生成文档](https://sdk.vercel.ai/docs/ai-sdk-core/image-generation#generating-images-with-language-models)。

## **URL sources**

## **URL 来源**

https://ai-sdk-sources.vercel.app

https://ai-sdk-sources.vercel.app

Many providers like OpenAI and Google can include search results in their responses, but each implements their own unique way of exposing and accessing these sources. The AI SDK standardizes URL sources (i.e. websites), allowing you to build AI applications that use source attribution.

许多服务商（如 OpenAI 和 Google）可在其响应中包含搜索结果，但各自采用不同的方式暴露和访问这些来源。AI SDK 对 URL 来源（即网站）进行了标准化，使您能够构建支持来源标注（source attribution）的 AI 应用程序。

For example, here's how to use and send sources with Gemini Flash:

例如，以下是如何在 Gemini Flash 中使用并发送来源信息：

api/chat/route.ts

api/chat/route.ts

```tsx
import { google } from "@ai-sdk/google";

import { streamText } from "ai";



export async function POST(req: Request) {

5  const { messages } = await req.json();



7  const result = streamText({

8    model: google("gemini-1.5-flash", { useSearchGrounding: true }),

9    messages,

9    消息，

10  });



10  });



12  return result.toDataStreamResponse({

12  return result.toDataStreamResponse({

13    sendSources: true,

13    sendSources: true,

14  });

14  });

15}
```

15}
```

Here's how to display the sources in your client-side component using `useChat`:

以下是使用 `useChat` 在客户端组件中显示来源信息的方法：

app/page.tsx

`app/page.tsx`

```tsx
function Chat() {
```

```tsx
function Chat() {

2  const { messages } = useChat();

2  const { messages } = useChat();

3  return (

3  return (

4    <div>

4    <div>

5      {messages.map((message) => (

5      {messages.map((message) => (

6        <div key={message.id}>

6        <div key={message.id}>

7          {message.role === "user" ? "User: " : "AI: "}

7          {message.role === "user" ? "用户： " : "AI： "}

8          {message.parts

8          {message.parts

9            .filter((part) => part.type !== "source")

9            .filter((part) => part.type !== "source")

10            .map((part, index) => {

10            .map((part, index) => {

11              if (part.type === "text") { 

11              if (part.type === "text") {

12                return <div key={index}>{part.text}</div>;

12                返回 `<div key={index}>{part.text}</div>`；

13              }

13              }

14            })}

14            })}

15          {message.parts

15          {message.parts

16            .filter((part) => part.type === "source")

16            .filter((part) => part.type === "source")

17            .map((part) => (

17            .map((part) => (

18              <span key={`source-${part.source.id}`}>

18              <span key={`source-${part.source.id}`}>

19                [\
\
20                <a href={part.source.url} target="_blank">\
\
21                  {part.source.title ?? new URL(part.source.url).hostname}\
\
22                </a>\
\
23                ]

19                [\
\
20                <a href={part.source.url} target="_blank">\
\
21                  {part.source.title ?? new URL(part.source.url).hostname}\
\
22                </a>\
\
23                ]

24              </span>

24              </span>

25            ))}

25            ))}

26        </div>

26        </div>

27      ))}

27      ))}

28    </div>

28    </div>

29  );

29  );

30}
30}

```

The AI SDK supports URL sources across compatible models with [OpenAI Respones](https://sdk.vercel.ai/providers/ai-sdk-providers/openai#responses-models), [Google](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai#sources), [Vertex](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex#search-grounding), and [Perplexity](https://sdk.vercel.ai/providers/ai-sdk-providers/perplexity#sources). To see sources in action, check out the [sources template](https://ai-sdk-sources.vercel.app/).

AI SDK 支持在兼容模型中使用 URL 作为数据源，涵盖 [OpenAI Responses](https://sdk.vercel.ai/providers/ai-sdk-providers/openai#responses-models)、[Google](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai#sources)、[Vertex](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex#search-grounding) 和 [Perplexity](https://sdk.vercel.ai/providers/ai-sdk-providers/perplexity#sources)。要实际体验数据源功能，请访问 [sources 模板](https://ai-sdk-sources.vercel.app/)。

## OpenAI Responses API

## OpenAI Responses API

OpenAI [recently released the Responses API](https://openai.com/index/new-tools-for-building-agents/), a brand new way to build applications on OpenAI's platform. The new API offers a way to persist chat history, a web search tool for grounding LLM responses, and tools like file-search and computer use that will be coming in a future update.

OpenAI [近期发布了 Responses API](https://openai.com/index/new-tools-for-building-agents/)，这是一种构建基于 OpenAI 平台应用的全新方式。该新 API 支持持久化聊天历史、提供网络搜索工具以增强大语言模型（LLM）响应的可靠性（grounding），并计划在未来更新中引入文件搜索和计算机操作等工具。

With day one support from the AI SDK, migrating to the new Responses API from the existing Completions API is simple:

借助 AI SDK 的首日支持，从现有的 Completions API 迁移至全新的 Responses API 十分简便：

```tsx
import { openai } from '@ai-sdk/openai';
```

```ts
const completionsAPIModel = openai('gpt-4o-mini');

const responsesAPIModel = openai.responses('gpt-4o-mini');
```

```ts
const completionsAPIModel = openai('gpt-4o-mini');

const responsesAPIModel = openai.responses('gpt-4o-mini');
```

新的网页搜索工具使模型能够访问互联网以获取相关信息，从而提升事实性查询的回答质量：

新的网页搜索工具使模型能够访问互联网以获取相关信息，从而提升事实性查询的回答质量：

```tsx
import { openai } from '@ai-sdk/openai';

import { generateText } from 'ai';



const result = await generateText({

5  model: openai.responses('gpt-4o-mini'),

6  prompt: 'What happened in San Francisco last week?',
```

```tsx
import { openai } from '@ai-sdk/openai';

import { generateText } from 'ai';



const result = await generateText({

5  model: openai.responses('gpt-4o-mini'),

6  prompt: 'What happened in San Francisco last week?',
```

7  tools: {

8    web_search_preview: openai.tools.webSearchPreview(),

9  },

10});



console.log(result.text);

console.log(result.sources);
```

Responses API 还简化了对话历史的管理。您无需在每次请求中发送完整的对话记录，而是可以通过 ID 引用之前的交互，从而降低应用程序的复杂性。

如需深入了解这些功能，请参阅 [OpenAI Responses API 指南](https://sdk.vercel.ai/docs/guides/openai-responses)。

## Svelte 5

## Svelte 5

With AI SDK 4.2, the `@ai-sdk/svelte` package has been completely rewritten by the Svelte team to support Svelte 5 and properly leverage native patterns.

在 AI SDK 4.2 中，`@ai-sdk/svelte` 包已由 Svelte 团队全面重写，以支持 Svelte 5 并充分运用其原生模式。

This new implementation replaces React's hook-based approach with a Svelte-native class-based pattern:

这一新实现摒弃了 React 风格的基于 Hook 的方式，转而采用 Svelte 原生的基于类的模式：

```jsx
1<script>

2  import { Chat } from '@ai-sdk/svelte';



4  // Use the Chat class instead of useChat hook

5  const chat = new Chat();

6</script>



8<div>
```

9  {#each chat.messages as message}

9  {#each chat.messages as message}

10    <div class="message {message.role}">{message.content}</div>

10    <div class="message {message.role}">{message.content}</div>

11  {/each}

11  {/each}

12</div>
```

12</div>
```

To learn more check out the [Svelte quickstart guide](https://sdk.vercel.ai/docs/getting-started/svelte) or check out the [open-source Svelte chatbot template](https://svelte-chat.vercel.ai/) with these patterns implemented.

如需了解更多信息，请查阅 [Svelte 快速入门指南](https://sdk.vercel.ai/docs/getting-started/svelte)，或试用已实现上述模式的 [开源 Svelte 聊天机器人模板](https://svelte-chat.vercel.ai/)。

## Middleware Updates

## 中间件更新

Language model middleware, now stable, is a way to enhance the behavior of language models by intercepting and modifying the calls to the language model. This pattern enables features like guardrails, caching, and logging while maintaining provider flexibility. Middleware is applied with a simple wrapping function that preserves the standard model interface.

语言模型中间件现已进入稳定版本，它通过拦截并修改对语言模型的调用，来增强语言模型的行为。该模式支持护栏（guardrails）、缓存、日志记录等功能，同时保持对不同模型提供商的兼容性。中间件通过一个简单的封装函数应用，该函数保留了标准模型接口。

The SDK now includes three production-ready middleware options:

SDK 现在包含三个可用于生产环境的中间件选项：

- [`extractReasoningMiddleware`](https://sdk.vercel.ai/docs/ai-sdk-core/middleware#extract-reasoning) extracts reasoning steps from text with special tags like `<think>`.

- [`extractReasoningMiddleware`](https://sdk.vercel.ai/docs/ai-sdk-core/middleware#extract-reasoning) 可从带有特殊标签（例如 `<think>`）的文本中提取推理步骤。

- [`simulateStreamingMiddleware`](https://sdk.vercel.ai/docs/ai-sdk-core/middleware#simulate-streaming) simulates streaming behavior with responses from non-streaming language models.

- [`simulateStreamingMiddleware`](https://sdk.vercel.ai/docs/ai-sdk-core/middleware#simulate-streaming) 可利用非流式语言模型的响应，模拟流式输出行为。

- [`defaultSettingsMiddleware`](https://sdk.vercel.ai/docs/ai-sdk-core/middleware#default-settings) 为各类模型调用统一应用配置，可与任意模型（包括自定义提供方）无缝协作。您只需为 `temperature` 等参数指定默认值，并通过 `providerMetadata` 设置特定提供方的选项。

- [`defaultSettingsMiddleware`](https://sdk.vercel.ai/docs/ai-sdk-core/middleware#default-settings) 为各类模型调用统一应用配置，可与任意模型（包括自定义提供方）无缝协作。您只需为 `temperature` 等参数指定默认值，并通过 `providerMetadata` 设置特定提供方的选项。

```tsx
import { openai } from "@ai-sdk/openai";

import { anthropic } from "@ai-sdk/anthropic";

import {

4  customProvider,

5  defaultSettingsMiddleware,

6  wrapLanguageModel,

7} from "ai";



9// custom provider with defaultSettingsMiddleware:
```

```tsx
import { openai } from "@ai-sdk/openai";

import { anthropic } from "@ai-sdk/anthropic";

import {

4  customProvider,

5  defaultSettingsMiddleware,

6  wrapLanguageModel,

7} from "ai";



9// 使用 defaultSettingsMiddleware 的自定义提供方：
```

```javascript
export const model = customProvider({

11  languageModels: {

12    fast: openai("gpt-4o-mini"),

13    writing: anthropic("claude-3-5-sonnet-latest"),

14    reasoning: wrapLanguageModel({

15      model: anthropic("claude-3-7-sonnet-20250219"),

16      middleware: defaultSettingsMiddleware({

17        settings: {

18          providerMetadata: {

19            anthropic: {
```

```javascript
export const model = customProvider({

11  语言模型：{

12    快速：openai("gpt-4o-mini"),

13    写作：anthropic("claude-3-5-sonnet-latest"),

14    推理：wrapLanguageModel({

15      model: anthropic("claude-3-7-sonnet-20250219"),

16      middleware: defaultSettingsMiddleware({

17        settings: {

18          提供商元数据：{

19            anthropic: {
```

20              thinking: { type: "enabled", budgetTokens: 12000 },

20              思考功能：{ type: "enabled", budgetTokens: 12000 },

21            },

21            },

22          },

22          },

23        },

23        },

24      }),

24      }),

25    }),

25    }),

26  },

26  },

27});

27});

These middleware options can be combined to create powerful, composable functionality that work across any supported language model. Check out our [middleware documentation](https://sdk.vercel.ai/docs/ai-sdk-core/middleware) to learn more.

这些中间件选项可以组合使用，从而构建出功能强大、可组合的通用能力，适用于所有受支持的语言模型。请查阅我们的[中间件文档](https://sdk.vercel.ai/docs/ai-sdk-core/middleware)以了解更多信息。

## Other Features

## 其他功能

We have recently made several experimental features stable, meaning they are now production-ready and well-tested. These features include:

我们最近将多项实验性功能转为稳定版，这意味着它们现已具备生产就绪能力，并经过充分测试。这些功能包括：

- [**Custom Provider**](https://sdk.vercel.ai/docs/ai-sdk-core/provider-management#custom-providers) **:** map ids to any model allowing you to set up custom model configurations, alias names, and more.

- [**自定义 Provider**](https://sdk.vercel.ai/docs/ai-sdk-core/provider-management#custom-providers) **：** 将模型 ID 映射至任意模型，支持您自定义模型配置、设置别名名称等。

- [**Middleware Improvements**](https://sdk.vercel.ai/docs/ai-sdk-core/middleware) **:** apply multiple middlewares simultaneously for enhanced request processing and transformation. Middleware moved to stable.

- [**中间件改进**](https://sdk.vercel.ai/docs/ai-sdk-core/middleware) **：** 同时应用多个中间件，以增强请求处理与数据转换能力。中间件已转为稳定版。

- [**Tool Call Streaming**](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot-tool-usage#tool-call-streaming) **:** stream partial tool calls as part of the data stream. Moved to stable.

- [**工具调用流式传输**](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot-tool-usage#tool-call-streaming) **：** 将部分工具调用作为数据流的一部分进行流式传输。该功能已转为稳定版。

- [**Response Body Access**](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#accessing-response-headers--body) **:** access the original response body directly via `response.body` property when using `generateText` or `generateObject`.

- [**响应体访问**](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#accessing-response-headers--body) **：** 在使用 `generateText` 或 `generateObject` 时，可通过 `response.body` 属性直接访问原始响应体。

- [**Data Stream Enhancements**](https://sdk.vercel.ai/cookbook/next/stream-text-multistep) **:** send start/finish events for `streamText` and use `write`/`writeSource` methods for more control over stream data.

- [**数据流增强**](https://sdk.vercel.ai/cookbook/next/stream-text-multistep) **：** 为 `streamText` 发送开始/结束事件，并使用 `write` / `writeSource` 方法，以更精细地控制流式数据。

- [**Error Handling**](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#onerror-callback) **:** utilize `onError` callback for `streamText`/`streamObject` to manage errors gracefully.

- [**错误处理**](https://sdk.vercel.ai/docs/ai-sdk-core/generating-text#onerror-callback) **：** 利用 `streamText` / `streamObject` 的 `onError` 回调函数，优雅地处理错误。

- [**Object Generation**](https://sdk.vercel.ai/docs/ai-sdk-core/generating-structured-data#repairing-invalid-or-malformed-json) **:** leverage `generateObject``repairText` functionality to fix and improve generated content.

- [**对象生成**](https://sdk.vercel.ai/docs/ai-sdk-core/generating-structured-data#repairing-invalid-or-malformed-json) **：** 借助 `generateObject` 的 `repairText` 功能，修复并优化生成的内容。

- **Provider Options:** configure provider-specific request options (e.g. `reasoningEffort` with OpenAI). Details depend on the provider. Moved to stable.

- **Provider 配置项：** 配置特定 Provider 的请求选项（例如 OpenAI 的 `reasoningEffort`）。具体细节取决于所使用的 Provider。该功能已转为稳定版。

- **Provider Metadata:** access provider-specific response metadata. Details depend on the provider. Moved to stable.

- **Provider 元数据：** 访问特定 Provider 的响应元数据。具体细节取决于所使用的 Provider。该功能已转为稳定版。

## Provider Updates

## 供应商更新

The AI SDK provider ecosystem continues to grow with new and improved providers:

AI SDK 供应商生态持续扩展，新增并优化了多个供应商：

- [**Amazon Bedrock**](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock): integrated more closely into AI SDK standard features with abort, fetch and error handling. Added support for cache point support, image generation for Amazon Nova Canvas, budget token support, and reasoning support.

- [**Amazon Bedrock**](https://sdk.vercel.ai/providers/ai-sdk-providers/amazon-bedrock)：更深度集成至 AI SDK 标准功能，支持中止（abort）、请求（fetch）及错误处理；新增缓存点（cache point）支持、Amazon Nova Canvas 图像生成、预算令牌（budget token）支持，以及推理（reasoning）能力支持。

- [**Anthropic**](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic): Added reasoning support, model setting adjustments for reasoning content, tool updates (bash, text editor, computer), and image URL support.

- [**Anthropic**](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic)：新增推理（reasoning）支持；优化推理内容相关的模型配置选项；更新工具集（包括 bash、文本编辑器、计算机操作工具）；支持图像 URL 输入。

- [**Azure**](https://sdk.vercel.ai/providers/ai-sdk-providers/azure): Added image generation support.

- [**Azure**](https://sdk.vercel.ai/providers/ai-sdk-providers/azure)：新增图像生成功能支持。

- [**Cohere**](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere): Improved tool handling with fixes for parameters and tool plan content.

- [**Cohere**](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere)：优化工具调用机制，修复参数传递及工具规划（tool plan）内容相关问题。

- [**DeepInfra**](https://sdk.vercel.ai/providers/ai-sdk-providers/deepinfra): Added image generation support.

- [**DeepInfra**](https://sdk.vercel.ai/providers/ai-sdk-providers/deepinfra)：新增图像生成功能支持。

- [**Google**](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai): Enhanced schema support, resilience against undefined parts, seed support, dynamic retrieval, empty content handling, reasoning support, and model ID updates.

- [**Google**](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai)：增强 Schema 支持；提升对未定义字段（undefined parts）的容错能力；支持随机种子（seed）；支持动态检索（dynamic retrieval）；优化空内容处理；新增推理（reasoning）支持；更新模型 ID 命名规范。

- [**Google Vertex AI**](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex): Added new Gemini models, support for public file URLs in messages, and prompt caching for Anthropic Claude models.

- [**Google Vertex AI**](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex)：新增 Gemini 系列模型；支持在消息中直接引用公开可访问的文件 URL；为 Anthropic Claude 模型新增提示词缓存（prompt caching）功能。

- [**Mistral**](https://sdk.vercel.ai/providers/ai-sdk-providers/mistral): Improved content handling with fixes for undefined content, complex content types, PDF support, and multiple text content parts.

- [**Mistral**](https://sdk.vercel.ai/providers/ai-sdk-providers/mistral)：优化内容处理逻辑，修复未定义内容（undefined content）问题，增强对复杂内容类型的支持，新增 PDF 文件解析能力，并支持单条消息中包含多个文本内容片段。

- [**OpenAI**](https://sdk.vercel.ai/providers/ai-sdk-providers/openai): 新增对 gpt-4.5、o3-mini、responses API 以及 PDF 输入的支持。

- [**OpenAI 兼容接口**](https://sdk.vercel.ai/providers/ai-sdk-providers/openai-compatible): 新增对 `generateText`/`streamText` 中 `providerOptions` 参数的支持。

- [**Perplexity**](https://sdk.vercel.ai/providers/ai-sdk-providers/perplexity): 新增对搜索来源（sources）的支持。

- [**Replicate**](https://sdk.vercel.ai/providers/ai-sdk-providers/replicate): 新增对版本化模型（versioned models）的支持。

- [**Together AI**](https://sdk.vercel.ai/providers/ai-sdk-providers/togetherai): 新增图像生成支持，并扩展了 Provider V1 规范。

- [**xAI**](https://sdk.vercel.ai/providers/ai-sdk-providers/xai): 新增图像生成支持。

## **入门指南**

## Getting started

借助 MCP 支持、大语言模型图像生成、推理能力等强大新特性，现在正是使用 AI SDK 构建 AI 应用的最佳时机。

- **启动一个全新的 AI 项目**：准备开始构建新应用？请查阅我们的 [**最新教程**](https://sdk.vercel.ai/cookbook)

- **探索我们的模板**：访问我们的 [**模板画廊**](https://sdk.vercel.ai/docs/introduction#templates)，亲身体验 AI SDK 的实际应用效果。

- **Join the community**: Share what you're building in our [**GitHub Discussions**](https://github.com/vercel/ai/discussions)

- **加入社区**：欢迎在我们的 [**GitHub 讨论区**](https://github.com/vercel/ai/discussions) 中分享您正在构建的项目！

## Showcase

## 展示案例

Since our 4.1 release, we've seen some incredible products powered by the AI SDK that we wanted to highlight:

自 4.1 版本发布以来，我们已见证多款令人惊叹的产品借助 AI SDK 实现强大功能，特此精选展示如下：

- [Otto](https://ottogrid.ai/) is an agentic spreadsheet that automates repetitive knowledge work.

- [Otto](https://ottogrid.ai/) 是一款具备智能体（agentic）能力的电子表格工具，可自动化处理重复性知识工作。

- [Payload](https://payloadcms.com/) is an open-source Next.js fullstack framework that transforms your configuration into a complete backend with admin UI, APIs, and database management in one seamless package.

- [Payload](https://payloadcms.com/) 是一个开源的 Next.js 全栈框架，只需简单配置，即可一键生成包含管理后台、API 接口与数据库管理功能的完整后端系统。

> “Switching to the AI SDK allowed us to instantly remove a significant amount of custom code and effortlessly support all current and future AI providers. The API is super clean, thoughtfully designed, and offers first-class TypeScript support—we couldn’t be happier!Switching to the AI SDK allowed us to instantly remove a significant amount of custom code and effortlessly support all current and future AI providers. The API is super clean, thoughtfully designed, and offers first-class TypeScript support—we couldn’t be happier!”
>
> ![](images/ai-sdk-4_2-vercel/img_002.jpg)
>
> **Alessio Gravili,** Payload

> “迁移到 AI SDK 使我们得以立即移除大量自定义代码，并轻松支持当前及未来所有 AI 服务商。该 SDK 的 API 极其简洁、设计周全，且原生提供一流的 TypeScript 支持——我们对此再满意不过了！”  
>  
> ![](images/ai-sdk-4_2-vercel/img_002.jpg)  
>  
> **Alessio Gravili**，Payload

## Contributors

## 贡献者

AI SDK 4.2 is the result of the combined work of our core team at Vercel ( [Lars](https://x.com/lgrammel), [Jeremy](https://x.com/jrmyphlmn), [Walter](https://x.com/shaper), and [Nico](https://x.com/nicoalbanese10)) and many community contributors. Thanks for contributing merged pull requests:

AI SDK 4.2 是 Vercel 核心团队（[Lars](https://x.com/lgrammel)、[Jeremy](https://x.com/jrmyphlmn)、[Walter](https://x.com/shaper) 和 [Nico](https://x.com/nicoalbanese10)）与众多社区贡献者通力协作的成果。衷心感谢以下为本版本提交并成功合入 Pull Request 的贡献者：

[Xiang-CH](https://github.com/Xiang-CH), [d3lm](https://github.com/d3lm), [dreamorosi](https://github.com/dreamorosi), [MrunmayS](https://github.com/MrunmayS), [valstu](https://github.com/valstu), [BrianHung](https://github.com/BrianHung), [jstjoe](https://github.com/jstjoe), [rmarescu](https://github.com/rmarescu), [lasley](https://github.com/lasley), [shaneporter](https://github.com/shaneporter), [FinnWoelm](https://github.com/FinnWoelm), [threepointone](https://github.com/threepointone), [minpeter](https://github.com/minpeter), [UrielCh](https://github.com/UrielCh), [Younis-Ahmed](https://github.com/Younis-Ahmed), [edukure](https://github.com/edukure), [O1af](https://github.com/O1af), [abhishekpatil4](https://github.com/abhishekpatil4), [sandonl](https://github.com/sandonl), [NVolcz](https://github.com/NVolcz), [nihaocami](https://github.com/nihaocami), [yudistiraashadi](https://github.com/yudistiraashadi), [mattlgroff](https://github.com/mattlgroff), [gianpaj](https://github.com/gianpaj), [habeebmoosa](https://github.com/habeebmoosa), [KABBOUCHI](https://github.com/KABBOUCHI), [franklin007ban2](https://github.com/franklin007ban2), [yoshinorisano](https://github.com/yoshinorisano), [jcppman](https://github.com/jcppman), [gravelBridge](https://github.com/gravelBridge), [peetzweg](https://github.com/peetzweg), [patelvivekdev](https://github.com/patelvivekdev), [ggallon](https://github.com/ggallon), [zeke](https://github.com/zeke), [epoyraz](https://github.com/epoyraz), [IObert](https://github.com/IObert), [KitBurgess](https://github.com/vercel/ai/commits?author=KitBurgess), [marwhyte](https://github.com/marwhyte), [niranjan94](https://github.com/niranjan94), [asishupadhyay](https://github.com/asishupadhyay), [SalmanK81099](https://github.com/SalmanK81099).

With special recognition to:  

特别致谢：

- [elliott-with-the-longest-name-on-github](https://github.com/elliott-with-the-longest-name-on-github) 为 Svelte 5 提供支持

- [iteratetograceness](https://github.com/iteratetograceness) 为 MCP 提供支持

- [Und3rf10w](https://github.com/Und3rf10w) 为 Amazon Bedrock 推理功能提供支持

您的反馈与贡献持续推动着 AI SDK 的演进。我们非常期待看到您利用这些新能力构建出的精彩应用。