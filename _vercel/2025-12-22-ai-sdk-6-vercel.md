---
title: "AI SDK 6 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-6"
date: "2025-12-22"
scraped_at: "2026-03-02T09:23:34.886135352+00:00"
language: "en-zh"
translated: true
description: "Introducing agents, tool execution approval, DevTools, full MCP support, reranking, image editing, and more."
---

render_with_liquid: false
Dec 22, 2025

2025 年 12 月 22 日

Introducing agents, tool execution approval, DevTools, full MCP support, reranking, image editing, and more.

隆重推出智能体（Agents）、工具执行审批机制、开发者工具（DevTools）、完整的 MCP 支持、重排序（Reranking）、图像编辑，以及更多新特性。

With over 20 million monthly downloads and adoption by teams ranging from startups to Fortune 500 companies, the [AI SDK](https://ai-sdk.dev/) is the leading TypeScript toolkit for building AI applications. It provides a unified API, allowing you to integrate with any AI provider, and seamlessly integrates with Next.js, React, Svelte, Vue, and Node.js. The AI SDK enables you to build everything from chatbots to complex background agents.

[AI SDK](https://ai-sdk.dev/) 是目前构建 AI 应用的领先 TypeScript 工具包，每月下载量超 2000 万次，已被从初创公司到《财富》世界 500 强企业在内的各类团队广泛采用。它提供统一的 API 接口，支持对接任意 AI 服务商，并与 Next.js、React、Svelte、Vue 和 Node.js 无缝集成。借助 AI SDK，您可构建从聊天机器人到复杂后台智能体（background agents）的各类 AI 应用。

[Thomson Reuters](https://www.thomsonreuters.com/) used the AI SDK to build [CoCounsel](https://www.thomsonreuters.com/en/cocounsel), their AI assistant for attorneys, accountants, and audit teams, with just 3 developers in 2 months. Now serving 1,300 accounting firms, they're migrating their entire codebase to the AI SDK, deprecating thousands of lines of code across 10 providers and consolidating into one composable, scalable system.

汤森路透（[Thomson Reuters](https://www.thomsonreuters.com/)）利用 AI SDK，仅由 3 名开发人员在 2 个月内便构建出面向律师、会计师及审计团队的 AI 助手——[CoCounsel](https://www.thomsonreuters.com/en/cocounsel)。该产品目前已服务于 1300 家会计事务所；汤森路透正将其全部代码库迁移至 AI SDK，废弃横跨 10 个服务商的数千行代码，整合为一个可组合、可扩展的统一系统。

[Clay](https://www.clay.com/) used it to build [Claygent](https://www.clay.com/claygent), their AI web research agent that scrapes public data, connects to first-party sources via MCP servers, and helps sales teams find accounts with custom, targeted insights.

Clay（[Clay](https://www.clay.com/)）使用 AI SDK 构建了其 AI 网络研究智能体——[Claygent](https://www.clay.com/claygent)，该智能体可抓取公开数据，通过 MCP 服务器连接第一方数据源，并帮助销售团队基于定制化、精准化的洞察发现目标客户。

> “We’ve gone all in on the AI SDK. Its agentic capabilities and TypeScript-first design power our AI web research agent (Claygent) at massive scale. It's been a huge help as we build agents for sourcing, qualification, and surfacing the right accounts and prospects for our customers.We’ve gone all in on the AI SDK. Its agentic capabilities and TypeScript-first design power our AI web research agent (Claygent) at massive scale. It's been a huge help as we build agents for sourcing, qualification, and surfacing the right accounts and prospects for our customers.”
>
> “我们已全面投入 AI SDK。其智能体（agentic）能力与以 TypeScript 为先的设计理念，支撑着我们的 AI 网络研究智能体（Claygent）实现大规模运行。在构建用于线索挖掘（sourcing）、资质评估（qualification），以及为客户精准识别合适客户与潜在客户的各类智能体过程中，AI SDK 给予了我们巨大助力。”
>
> ![](images/ai-sdk-6-vercel/img_001.png)
>
> ![](images/ai-sdk-6-vercel/img_001.png)
>
> **Jeff Barg,** Clay
>
> **Jeff Barg，** Clay 公司

Today, we are releasing AI SDK 6, which introduces:

今天，我们正式发布 AI SDK 6，本次版本带来以下重要更新：

- [Agents](https://vercel.com/blog/ai-sdk-6#agents)

- [智能体（Agents）](https://vercel.com/blog/ai-sdk-6#agents)

- [Tool Improvements](https://vercel.com/blog/ai-sdk-6#tool-improvements)

- [工具功能增强（Tool Improvements）](https://vercel.com/blog/ai-sdk-6#tool-improvements)

- [MCP](https://vercel.com/blog/ai-sdk-6#mcp)

- [MCP 支持](https://vercel.com/blog/ai-sdk-6#mcp)

- [Tool Calling with Structured Output](https://vercel.com/blog/ai-sdk-6#tool-calling-with-structured-outputs)

- [工具调用与结构化输出](https://vercel.com/blog/ai-sdk-6#tool-calling-with-structured-outputs)

- [DevTools](https://vercel.com/blog/ai-sdk-6#devtools)

- [开发者工具（DevTools）](https://vercel.com/blog/ai-sdk-6#devtools)

- [Reranking](https://vercel.com/blog/ai-sdk-6#reranking)

- [重排序（Reranking）](https://vercel.com/blog/ai-sdk-6#reranking)

- [Standard JSON Schema](https://vercel.com/blog/ai-sdk-6#standard-json-schema)

- [标准 JSON Schema](https://vercel.com/blog/ai-sdk-6#standard-json-schema)

- [Image Editing](https://vercel.com/blog/ai-sdk-6#image-editing)

- [图像编辑（Image Editing）](https://vercel.com/blog/ai-sdk-6#image-editing)

- [Raw Finish Reason & Extended Usage](https://vercel.com/blog/ai-sdk-6#raw-finish-reason-&-extended-usage)

- [原始结束原因（Raw Finish Reason）与扩展用量信息（Extended Usage）](https://vercel.com/blog/ai-sdk-6#raw-finish-reason-&-extended-usage)

- [LangChain Adapter Rewrite](https://vercel.com/blog/ai-sdk-6#langchain-adapter-rewrite)

- [LangChain 适配器重写](https://vercel.com/blog/ai-sdk-6#langchain-adapter-rewrite)

- [New Provider Tools](https://vercel.com/blog/ai-sdk-6#new-provider-tools)

- [新增的提供商工具（New Provider Tools）](https://vercel.com/blog/ai-sdk-6#new-provider-tools)

Upgrading from AI SDK 5? Run `npx @ai-sdk/codemod v6` to migrate automatically with minimal code changes.

从 AI SDK 5 升级？运行 `npx @ai-sdk/codemod v6`，即可在代码改动极小的情况下自动完成迁移。

## Agents

## 智能体（Agents）

AI SDK 6 introduces the `Agent` abstraction for building reusable agents. Define your agent once with its model, instructions, and tools, then use it across your entire application. Agents automatically integrate with the full AI SDK ecosystem, giving you type-safe UI streaming, structured outputs, and seamless framework support.

AI SDK 6 引入了 `Agent` 抽象，用于构建可复用的智能体。您只需一次定义智能体的模型、指令和工具，即可在整个应用中重复使用它。智能体自动与完整的 AI SDK 生态系统集成，为您提供类型安全的 UI 流式传输、结构化输出以及无缝的框架支持。

The functional approach with `generateText` and `streamText` is powerful and low-level, giving you full control regardless of scale. But when you want to reuse the same agent across different mediums (a chat UI, a background job, an API endpoint), or organize your code with tools in separate files, the inline configuration approach breaks down. You end up passing the same configuration object everywhere or building your own abstraction layer.

采用 `generateText` 和 `streamText` 的函数式方法功能强大且层级较低，无论规模大小，都能为您提供完全的控制权。但当您希望在不同场景（如聊天界面、后台任务、API 端点）中复用同一智能体，或希望将工具逻辑拆分到独立文件中以组织代码时，内联配置方式便难以维系。最终，您要么不得不在各处重复传递相同的配置对象，要么被迫自行构建抽象层。

### ToolLoopAgent

### ToolLoopAgent（工具循环智能体）

The `ToolLoopAgent` class provides a production-ready implementation that handles the complete tool execution loop. It calls the LLM with your prompt, executes any requested tool calls, adds results back to the conversation, and repeats until complete (for up to 20 steps by default: `stopWhen: stepCountIs(20)`).

`ToolLoopAgent` 类提供了一个可用于生产环境的实现，完整处理工具执行循环：它使用您的提示调用大语言模型（LLM），执行所有被请求的工具调用，将执行结果添加回对话上下文，并持续循环直至任务完成（默认最多执行 20 步：`stopWhen: stepCountIs(20)`）。

```typescript
import { ToolLoopAgent } from 'ai';

import { weatherTool } from '@/tools/weather';



export const weatherAgent = new ToolLoopAgent({

5  model: 'anthropic/claude-sonnet-4.5',

6  instructions: 'You are a helpful weather assistant.',
```

7  tools: {

8    weather: weatherTool,

9  },

10});



const result = await weatherAgent.generate({

13  prompt: 'What is the weather in San Francisco?',

14});
```

如需了解更多信息，请参阅 [构建 Agent 文档](https://ai-sdk.dev/docs/agents/building-agents)。

### 调用选项

With call options, you can pass type-safe arguments when you call `generate` or `stream` on a ToolLoopAgent. For example, you can use them to inject retrieved documents for RAG, select models based on request complexity, or customize tool behavior per request.

使用调用选项（call options），您可以在对 `ToolLoopAgent` 调用 `generate` 或 `stream` 方法时传入类型安全的参数。例如，您可以利用它们向 RAG 注入已检索的文档、根据请求复杂度选择模型，或按请求定制工具行为。

```typescript
import { ToolLoopAgent } from "ai";

import { z } from "zod";



const supportAgent = new ToolLoopAgent({

5  model: "anthropic/claude-sonnet-4.5",

6  callOptionsSchema: z.object({

7    userId: z.string(),

8    accountType: z.enum(["free", "pro", "enterprise"]),

9  }),

10  prepareCall: ({ options, ...settings }) => ({

10  prepareCall: ({ options, ...settings }) => ({

11    ...settings,

11    ...settings,

12    instructions: `You are a helpful customer support agent.

12    instructions: `你是一位乐于助人的客户服务代理。

13- User Account type: ${options.accountType}

13- 用户账户类型：${options.accountType}

14- User ID: ${options.userId}`,

14- 用户 ID：${options.userId}`,

15  }),

15  }),

16});



16});



const result = await supportAgent.generate({

const result = await supportAgent.generate({

19  prompt: "How do I upgrade my account?",  

19  prompt: "我该如何升级我的账户？",

20  options: {

20  选项：{

21    userId: "user_123",

21    userId: "user_123",

22    accountType: "free",

22    accountType: "free",

23  },

23  },

24});

24});

To learn more, check out the [Configuring Call Options documentation](https://ai-sdk.dev/docs/agents/configuring-call-options).

如需了解更多信息，请参阅[配置调用选项文档](https://ai-sdk.dev/docs/agents/configuring-call-options)。

### Code Organization & UI Integration

### 代码组织与 UI 集成

The agent abstraction pushes you toward a clean separation of concerns and rewards you with end-to-end type safety. Define tools in dedicated files, compose them into agents, and expose them via API routes. The same definitions that power your agent logic also type your UI components.

Agent 抽象促使你实现清晰的关注点分离，并以端到端的类型安全性作为回报。在专用文件中定义工具，将它们组合为 Agent，并通过 API 路由对外暴露。驱动 Agent 逻辑的同一套定义，也同时为你的 UI 组件提供类型支持。

```typescript
1// agents/weather-agent.ts

1// agents/weather-agent.ts

import { ToolLoopAgent, InferAgentUIMessage } from "ai";

import { ToolLoopAgent, InferAgentUIMessage } from "ai";

```typescript
import { weatherTool } from "@/tools/weather-tool";

导入 { weatherTool } 来自 "@/tools/weather-tool";

export const weatherAgent = new ToolLoopAgent({

6  model: "anthropic/claude-sonnet-4.5",

6  模型： "anthropic/claude-sonnet-4.5",

7  instructions: "You are a helpful weather assistant.",

7  指令： "你是一个乐于助人的天气助手。",

8  tools: { weather: weatherTool },

8  工具： { weather: weatherTool },

9});

9});

export type WeatherAgentUIMessage = InferAgentUIMessage<typeof weatherAgent>;

导出类型 WeatherAgentUIMessage = InferAgentUIMessage<typeof weatherAgent>;
```

13// app/api/chat/route.ts

13// app/api/chat/route.ts

import { createAgentUIStreamResponse } from "ai";

导入 { createAgentUIStreamResponse } 模块，来自 "ai" 库。

import { weatherAgent } from "@/agents/weather-agent";

导入 { weatherAgent } 模块，来自 "@/agents/weather-agent"。

export async function POST(request: Request) {

导出异步函数 POST，接收一个 Request 类型参数：

18  const { messages } = await request.json();

18  const { messages } = await request.json();

19  return createAgentUIStreamResponse({

19  返回 createAgentUIStreamResponse 函数调用结果，传入以下参数：

20    agent: weatherAgent,

20    agent: weatherAgent,

21    uiMessages: messages,

21    uiMessages: messages,

22  });

22  });

23}
```

在客户端，类型会自动流动。从你的 agent 文件中导入消息类型，然后通过判断 part 类型来渲染带类型的工具组件。

```tsx
1// app/page.tsx

import { useChat } from '@ai-sdk/react';

import type { WeatherAgentUIMessage } from '@/agents/weather-agent';

import { WeatherToolView } from '@/components/weather-tool-view';



export default function Chat() {

7  const { messages, sendMessage } = useChat<WeatherAgentUIMessage>();

8  return (

9    <div>

9    <div>

10      {messages.map((message) =>

10      {messages.map((message) =>

11        message.parts.map((part) => {

11        message.parts.map((part) => {

12          switch (part.type) {

12          switch (part.type) {

13            case 'tool-weather':

13            case 'tool-weather':

14              return <WeatherToolView invocation={part} />;

14              返回 <WeatherToolView invocation={part} />；

15          }

15          }

16        })

16        })

17      )}

17      )}

18    </div>

18    </div>

19  );

20}



22// components/weather-tool-view.tsx

22// components/weather-tool-view.tsx

import { UIToolInvocation } from 'ai';

import { weatherTool } from '@/tools/weather-tool';



export function WeatherToolView({

27  invocation,

28}: {

29  invocation: UIToolInvocation<typeof weatherTool>;

30}) {

31  return (

32    <div>

33      Weather in {invocation.input.location} is {invocation.output?.temperature}°F

34    </div>

35  );

36}
```

一次定义，处处使用。同一工具定义可同时驱动您的智能体逻辑、API 响应以及 UI 组件。

如需了解更多信息，请查阅 [Agents 文档](https://ai-sdk.dev/docs/agents)。

### Custom Agent Implementations

### 自定义 Agent 实现

In AI SDK 6, `Agent` is an interface rather than a class. While `ToolLoopAgent` provides a solid default implementation for most use cases, you can implement the `Agent` interface to build your own agent abstractions for your needs.

在 AI SDK 6 中，`Agent` 是一个接口而非类。尽管 `ToolLoopAgent` 为大多数使用场景提供了稳健的默认实现，您仍可通过实现 `Agent` 接口，构建契合自身需求的自定义 Agent 抽象。

One such example is [Workflow DevKit](https://useworkflow.dev/), which provides [`DurableAgent`](https://useworkflow.dev/docs/api-reference/workflow-ai/durable-agent). It makes your agents production-ready by turning them into durable, resumable workflows where each tool execution becomes a retryable, observable step.

其中一个典型示例是 [Workflow DevKit](https://useworkflow.dev/)，它提供了 [`DurableAgent`](https://useworkflow.dev/docs/api-reference/workflow-ai/durable-agent)。该工具通过将您的 Agent 转化为持久化、可恢复的工作流，使其具备生产就绪能力——其中每一次工具调用都成为一个可重试、可观测的步骤。

```typescript
import { getWritable } from 'workflow';

import { DurableAgent } from '@workflow/ai/agent';

import { searchFlights, bookFlight, getFlightStatus } from './tools';



export async function flightBookingWorkflow() {

6  'use workflow';
```

```javascript
8  const flightAgent = new DurableAgent({

9    model: 'anthropic/claude-sonnet-4.5',

10    system: 'You are a flight booking assistant.',

11    tools: {

12      searchFlights,

13      bookFlight,

14      getFlightStatus,

15    },

16  });
```

```javascript
8  const flightAgent = new DurableAgent({

9    model: 'anthropic/claude-sonnet-4.5',

10    system: '您是一位航班预订助手。',

11    tools: {

12      searchFlights,

13      bookFlight,

14      getFlightStatus,

15    },

16  });
```

18  const result = await flightAgent.generate({

19    prompt: 'Find me a flight from NYC to London next Friday.',

20    writable: getWritable(),

21  });

22}
```

详见 [构建持久化智能体文档](https://useworkflow.dev/docs/ai)。

## 工具功能改进

工具是智能体能力的基础。智能体能否执行有意义的操作，完全取决于以下几点：其生成有效工具输入的可靠性、这些输入与用户意图的一致性、工具输出在对话中以 token 形式表示的效率，以及这些工具在生产环境中执行的安全性。

AI SDK 6 在上述每个方面均进行了优化：新增工具执行审批机制，支持人工介入控制；引入严格模式（strict mode），提升输入生成的可靠性；提供输入示例（input examples），增强意图对齐效果；并新增 `toModelOutput` 方法，实现更灵活的工具输出处理。

### 工具执行审批

Building agents that can take real-world actions (deleting files, processing payments, modifying production data) requires a critical safety layer: human approval. Without it, you're blindly trusting the agent on every decision.

构建能够执行现实世界操作（如删除文件、处理付款、修改生产数据）的智能体，需要一个关键的安全层：人工审批。缺少这一环节，就意味着您将盲目地信任该智能体所作的每一个决策。

In AI SDK 6, you get human-in-the-loop control with a single `needsApproval` flag, no custom code required. See this feature in action with the [Chat SDK](https://chat-sdk.dev/), an open-source template for building chatbot applications.

在 AI SDK 6 中，您只需设置一个 `needsApproval` 标志，即可轻松实现“人在环路中”（human-in-the-loop）控制，无需编写任何自定义代码。您可通过 [Chat SDK](https://chat-sdk.dev/) —— 一个用于构建聊天机器人应用的开源模板 —— 实际体验该功能。

By default, tools run automatically when the model calls them. Set `needsApproval: true` to require approval before execution:

默认情况下，当模型调用工具时，工具会自动执行。将 `needsApproval: true` 设置为 `true`，即可在执行前强制要求人工审批：

```typescript
import { tool } from 'ai';

import { z } from 'zod';



export const runCommand = tool({

5  description: 'Run a shell command',

6  inputSchema: z.object({

7    command: z.string().describe('The shell command to execute'),
```

8  }),

9  needsApproval: true, // 需要用户批准

10  execute: async ({ command }) => {

11    // 此处编写命令执行逻辑

12  },

13});
```

并非每次工具调用都需要用户批准。例如，一个简单的 `ls` 命令可能适合自动批准，但具有破坏性的 `rm -rf` 命令则应要求人工审核。你可以向 `needsApproval` 传入一个函数，根据输入参数动态决定是否需要批准；同时，你还可以存储用户的偏好设置，以记住已批准的命令模式，供后续调用复用。

```typescript
import { tool } from "ai";

import { z } from "zod";
```

```ts
const runCommand = tool({

5  description: "Run a shell command",

5  描述：“运行一个 shell 命令”,

6  inputSchema: z.object({

6  输入模式：z.object({

7    command: z.string().describe("The shell command to execute"),

7    command: z.string().describe("要执行的 shell 命令"),

8  }),

8  }),

9  needsApproval: async ({ command }) => command.includes("rm -rf"),

9  需要审批：async ({ command }) => command.includes("rm -rf"),

10  execute: async ({ command }) => {

10  执行：async ({ command }) => {

11    /* command execution logic */

11    /* 命令执行逻辑 */

12  },

12  },

13});
```

Handling approval in your UI is straightforward with `useChat`. Check the tool invocation state, prompt the user, and return a response with `addToolApprovalResponse`:

在 UI 中处理审批操作借助 `useChat` 非常简单。检查工具调用状态，向用户发起提示，并使用 `addToolApprovalResponse` 返回响应：

```tsx
import { ChatAddToolApproveResponseFunction } from 'ai';

import { runCommand } from './tools/command-tool';



export function CommandToolView({

5  invocation,

6  addToolApprovalResponse,

7}: {

8  invocation: UIToolInvocation<typeof runCommand>;

9  addToolApprovalResponse: ChatAddToolApproveResponseFunction;

10}) {

10}) {

11  if (invocation.state === 'approval-requested') {

11  如果调用状态为 `'approval-requested'`（待审批）：

12    return (

12    返回（

13      <div>

13      <div>

14        <p>运行命令：{invocation.input.command}？</p>

14        <p>运行命令：{invocation.input.command}？</p>

15        <button

15        <button

16          onClick={() =>

16          onClick={() =>

17            addToolApprovalResponse({

17            addToolApprovalResponse({

18              id: invocation.approval.id,

18              id: invocation.approval.id,

19              approved: true,

20            })

20            })

21          }

21          }

22        >

22        >

23          Approve

23          批准

24        </button>

24        </button>

25        <button

25        <button

26          onClick={() =>

26          onClick={() =>

27            addToolApprovalResponse({

27            addToolApprovalResponse({

28              id: invocation.approval.id,

28              id: invocation.approval.id,

29              approved: false,

30            })

30            })

31          }

31          }

32        >

32        >

33          Deny

33          拒绝

34        </button>

34        </button>

35      </div>

35      </div>

36    );

36    );

37  }

37  }

39  if (invocation.state === 'output-available') {

39  if (invocation.state === 'output-available') {

40    return <div>Output: {invocation.output}</div>;

40    返回 <div>输出：{invocation.output}</div>；

41  }



41  }

43  // Handle other states...

43  // 处理其他状态……

44}

44}

```

To learn more, check out the [Tool Execution Approval documentation](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling#tool-execution-approval).

如需了解更多信息，请参阅[工具执行审批文档](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling#tool-execution-approval)。

### Strict Mode

### 严格模式

When available, native strict mode from language model providers guarantees that tool call inputs match your schema exactly. However, some providers only support subsets of the JSON schema specification in strict mode. If any tool in your request uses an incompatible schema feature, the entire request fails.

当可用时，语言模型提供商原生的严格模式可确保工具调用输入与您定义的 Schema 完全一致。然而，部分提供商在严格模式下仅支持 JSON Schema 规范的子集。如果您的请求中任一工具使用了不兼容的 Schema 特性，则整个请求将失败。

AI SDK 6 makes strict mode opt-in per tool. Use strict mode for tools with compatible schemas and regular mode for others, all in the same call.

AI SDK 6 将严格模式设为按工具逐个启用。您可在同一调用中，对具备兼容 Schema 的工具启用严格模式，而对其他工具使用常规模式。

```typescript
tool({

2  description: 'Get the weather in a location',

2  描述：'获取指定地点的天气信息',

3  inputSchema: z.object({

3  输入模式：z.object({

4    location: z.string(),

4    地点: z.string(),

5  }),

5  }),

6  strict: true, // Enable strict validation for this tool

6  strict: true, // 启用该工具的严格校验

7  execute: async ({ location }) => ({

7  execute: async ({ location }) => ({

8    // ...

8    // ……

9  }),

9  }),

10});
```

### Input Examples

### 输入示例

Complex tool schemas with nested objects, specific formatting requirements, or domain-specific patterns can be difficult to describe clearly through tool descriptions alone. Even with detailed per-field descriptions, models sometimes generate inputs that are technically valid but don't match your expected patterns.

仅靠工具描述往往难以清晰表达包含嵌套对象、特定格式要求或领域专用模式的复杂工具 Schema。即使提供了详尽的字段级说明，模型有时仍会生成在技术上合法、却不符合你预期模式的输入。

Input examples show the model concrete instances of correctly structured input, clarifying expectations that are hard to express in schema descriptions:

输入示例向模型展示结构正确、格式规范的具体输入实例，从而明确那些仅靠 Schema 描述难以传达的预期行为：

```typescript
tool({

2  description: 'Get the weather in a location',

3  inputSchema: z.object({

4    location: z.string().describe('The location to get the weather for'),

5  }),

6  inputExamples: [\
\
7    { input: { location: 'San Francisco' } },\
\
8    { input: { location: 'London' } },\
\
9  ],

10  execute: async ({ location }) => {

11    // ...

12  },

13});
```

11    // ...

12  },

13});
```

Input examples are currently only natively supported by Anthropic. For providers that don't support them, you can use [`addToolInputExamplesMiddleware`](https://ai-sdk.dev/docs/ai-sdk-core/middleware#add-tool-input-examples) to append the examples to the tool description. If no middleware is used and the provider doesn't support input examples, they are ignored and not sent to the provider.

输入示例目前仅由 Anthropic 原生支持。对于不支持输入示例的模型提供商，你可以使用 [`addToolInputExamplesMiddleware`](https://ai-sdk.dev/docs/ai-sdk-core/middleware#add-tool-input-examples) 将示例追加到工具描述中。如果未使用任何中间件，且该提供商本身不支持输入示例，则这些示例将被忽略，不会发送给提供商。

### Send Custom Tool Output to the Model

### 向模型发送自定义工具输出

By default, whatever you return from your tool's `execute` function is sent to the model in subsequent turns as stringified JSON. However, when tools return large text outputs (file contents, search results) or binary data (screenshots, generated images), you end up sending thousands of unnecessary tokens or awkwardly encoding images as base64 strings.

默认情况下，你的工具 `execute` 函数所返回的任何内容，都会以字符串化 JSON 的形式在后续对话轮次中发送给模型。然而，当工具返回大量文本输出（如文件内容、搜索结果）或二进制数据（如截图、生成的图像）时，你最终会发送成千上万个不必要的 token，或者不得不以笨拙的方式将图像编码为 base64 字符串。

The `toModelOutput` function separates what your tool result from what you send to the model. Return complete data from `execute` function for your application logic, then use `toModelOutput` to control exactly what tokens go back to the model:

`toModelOutput` 函数将你的工具执行结果与实际发送给模型的内容分离开来。请在 `execute` 函数中返回完整数据以供应用逻辑使用，再通过 `toModelOutput` 精确控制哪些 token 被送回模型：

```typescript
import { tool } from "ai";

import { z } from "zod";
```

```ts
const weatherTool = tool({

5  description: "Get the weather in a location",

5  描述：“获取指定地点的天气信息”,

6  inputSchema: z.object({

6  输入模式：z.object({

7    location: z.string().describe("The location to get the weather for"),

7    location: z.string().describe("要查询天气的地点"),

8  }),

8  }),

9  execute: ({ location }) => ({

9  execute: ({ location }) => ({

10    temperature: 72 + Math.floor(Math.random() * 21) - 10,

10    temperature: 72 + Math.floor(Math.random() * 21) - 10,

11  }),

11  }),

12  // toModelOutput can be sync or async

12  // toModelOutput 可以是同步或异步函数

13  toModelOutput: async ({ input, output, toolCallId }) => {
```

Note: Since lines 1–4 and 14+ are not included in the provided snippet, only the given lines (5–13) are translated. Code syntax (e.g., `z.object`, `Math.random()`, `async`, variable names like `input`, `output`, `toolCallId`) remains unchanged per rule #4. Descriptive strings and comments are translated; technical identifiers and expressions are preserved.

14    // many other options, including json, multi-part with files and images, etc.

14    // 还有其他多种选项，包括 JSON、含文件和图像的 multipart 等。

15    // (support depends on provider)

15    // （具体支持情况取决于所使用的提供商）

16    // example: send tool output as a text

16    // 示例：将工具输出以纯文本形式发送

17    return {

17    return {

18      type: "text",

18      type: "text",

19      value:

19      value:

20        `The weather in ${input.location} is ${output.temperature}°F.`,

20        `当前 ${input.location} 的天气温度为 ${output.temperature}°F。`,

21    };

21    };

22  },

22  },

23});
23});
```

To learn more, check out the [Tool Calling documentation](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling).

如需了解更多信息，请参阅 [工具调用（Tool Calling）文档](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling)。

## MCP

## MCP

AI SDK 6 extends our MCP support to cover OAuth authentication, resources, prompts, and elicitation. You can now expose data through resources, create reusable prompt templates, and handle server-initiated requests for user input. It is now stable and available in the `@ai-sdk/mcp` package.

AI SDK 6 扩展了我们对 MCP 的支持，现已涵盖 OAuth 认证、资源（Resources）、提示词（Prompts）以及用户输入引导（Elicitation）。您现在可以通过资源暴露数据、创建可复用的提示词模板，并处理由服务器发起的用户输入请求。该功能现已稳定，并已发布于 `@ai-sdk/mcp` 包中。

### HTTP Transport

### HTTP 传输协议

To connect to a remote MCP server, you configure an HTTP transport with your server URL and authentication headers:

要连接远程 MCP 服务器，您需配置一个 HTTP 传输协议，指定服务器 URL 及认证请求头：

```typescript
import { createMCPClient } from '@ai-sdk/mcp';



const mcpClient = await createMCPClient({

4  transport: {

5    type: 'http',

6    url: '<https://your-server.com/mcp>',

6    url: '<https://your-server.com/mcp>',

7    headers: { Authorization: 'Bearer my-api-key' },

7    headers: { Authorization: 'Bearer my-api-key' },

8  },

8  },

9});



9});



const tools = await mcpClient.tools();
```

const tools = await mcpClient.tools();
```

### OAuth Authentication

### OAuth 认证

Remote MCP servers often require authentication, especially hosted services that access user data or third-party APIs. Implementing OAuth correctly means handling PKCE challenges, token refresh, dynamic client registration, and retry logic when tokens expire mid-session. Getting any of this wrong breaks your integration.

远程 MCP 服务器通常需要身份验证，尤其是那些访问用户数据或第三方 API 的托管服务。正确实现 OAuth 意味着需妥善处理 PKCE 挑战、令牌刷新、动态客户端注册，以及在会话中途令牌过期时的重试逻辑。上述任一环节出错，都将导致您的集成失效。

AI SDK 6 handles the complete OAuth flow for you:

AI SDK 6 为您自动处理完整的 OAuth 流程：

```typescript
import { createMCPClient, auth, OAuthClientProvider } from "@ai-sdk/mcp";
```

```typescript
const authProvider: OAuthClientProvider = {

const authProvider: OAuthClientProvider = {

4  redirectUrl: "http://localhost:3000/callback",

4  重定向 URL："http://localhost:3000/callback",

5  clientMetadata: {

5  客户端元数据：{

6    client_name: "My App",

6    client_name："My App",

7    redirect_uris: ["http://localhost:3000/callback"],

7    redirect_uris：["http://localhost:3000/callback"],

8    grant_types: ["authorization_code", "refresh_token"],

8    grant_types：["authorization_code", "refresh_token"],

9  },

9  },

10  // Token and credential storage methods

10  // 令牌与凭据存储方法

11  tokens: async () => { /* ... */ },

11  tokens: async () => { /* ... */ },
```

12  saveTokens: async (tokens) => { /* ... */ },

12  saveTokens: async (tokens) => { /* …… */ },

13  // ... remaining OAuthClientProvider configuration

13  // ……其余 OAuthClientProvider 配置

14};



await auth(authProvider, { serverUrl: new URL("https://mcp.example.com") });



await auth(authProvider, { serverUrl: new URL("https://mcp.example.com") });



const client = await createMCPClient({

19  transport: { type: "http", url: "https://mcp.example.com", authProvider },

19  transport: { type: "http", url: "https://mcp.example.com", authProvider },

20});
```

```

### Resources and Prompts

### 资源与提示

MCP servers can expose data through resources (files, database records, API responses) that your application can discover and read. Prompts provide reusable templates from the server, complete with parameters you fill in at runtime:

MCP 服务器可通过资源（如文件、数据库记录、API 响应）向您的应用暴露数据，您的应用可发现并读取这些资源。提示词（Prompts）则提供了来自服务器的可复用模板，其中包含您在运行时填充的参数：

```typescript
1// List and read resources

const resources = await mcpClient.listResources();

const resourceData = await mcpClient.readResource({

4  uri: "file:///example/document.txt",

5});



7// List and get prompts

const prompts = await mcpClient.experimental_listPrompts();

const prompt = await mcpClient.experimental_getPrompt({

10  name: "code_review",

10  名称: "code_review",

11  arguments: { code: "function add(a, b) { return a + b; }" },

11  参数: { code: "function add(a, b) { return a + b; }" },

12});

12});

### Elicitation Support

### 征询支持

Sometimes an MCP server needs user input mid-operation (a confirmation, a choice between options, or additional context). Elicitation lets the server request this input while your application handles gathering it:

有时，MCP 服务器需要在操作执行中途获取用户输入（例如确认、在多个选项中做出选择，或补充额外上下文）。征询（Elicitation）机制允许服务器发起此类输入请求，而您的应用程序则负责实际收集这些输入：

```typescript
const mcpClient = await createMCPClient({

2  transport: { type: 'sse', url: '<https://your-server.com/sse>' },

3  capabilities: { elicitation: {} },

4});

```

```javascript
mcpClient.onElicitationRequest(ElicitationRequestSchema, async request => {

mcpClient.onElicitationRequest(ElicitationRequestSchema, async request => {

7  const userInput = await getInputFromUser(

7  const userInput = await getInputFromUser(

8    request.params.message,

8    request.params.message,

9    request.params.requestedSchema,

9    request.params.requestedSchema,

10  );

10  );



12  return {

12  return {

13    action: 'accept',

13    action: 'accept',

14    content: userInput,

14    content: userInput,

15  };

15  };
```

16});


```

如需了解更多信息，请查阅 [MCP Tools 文档](https://ai-sdk.dev/docs/ai-sdk-core/mcp-tools)。

## 带结构化输出的工具调用

此前，将工具调用与结构化输出结合使用需要将 `generateText` 和 `generateObject` 串联调用。AI SDK 6 将 `generateObject` 与 `generateText` 统一，从而支持多步工具调用循环，并在最后一步生成结构化输出。

```typescript
import { Output, ToolLoopAgent, tool } from "ai";

import { z } from "zod";

const agent = new ToolLoopAgent({

5  model: "anthropic/claude-sonnet-4.5",

6  tools: {

6  工具：{

7    weather: tool({

7    weather: tool（{

8      description: "Get the weather in a location",

8      description: “获取某地的天气状况”，

9      inputSchema: z.object({ city: z.string() }),

9      inputSchema: z.object({ city: z.string() }),

10      execute: async ({ city }) => {

10      execute: async ({ city }) => {

11        // ...

11        // ……

12      },

12      },

13    }),

13    }),

14  },

14  },

15  output: Output.object({

15  output: Output.object（{

16    schema: z.object({

16    schema: z.object({

17      summary: z.string(),

17      summary: z.string(),

18      temperature: z.number(),

18      temperature: z.number(),

19      recommendation: z.string(),

19      recommendation: z.string(),

20    }),

20    }),

21  }),

21  }),

22});

22});

const { output } = await agent.generate({

const { output } = await agent.generate({

25  prompt: "What is the weather in San Francisco and what should I wear?",  

25  prompt: "旧金山的天气如何？我该穿什么？"

26});
```

### Output Types

### 输出类型

Structured output supports several formats. Use the `Output` object to specify what shape you need:

结构化输出支持多种格式。请使用 `Output` 对象来指定您所需的数据结构：

- **`Output.object()`**: Generate structured objects

- **`Output.object()`**: 生成结构化对象

- **`Output.array()`**: Generate arrays of structured objects

- **`Output.array()`**: 生成结构化对象的数组

- **`Output.choice()`**: Select from a specific set of options

- **`Output.choice()`**: 从一组预定义选项中进行选择

- **`Output.json()`**: Generate unstructured JSON

- **`Output.json()`**: 生成非结构化的 JSON

- **`Output.text()`**: Generate plain text (default behavior)

- **`Output.text()`**: 生成纯文本（默认行为）

To learn more, check out the [Generating Structured Data documentation](https://ai-sdk.dev/docs/ai-sdk-core/generating-structured-data).

如需了解更多，请参阅 [生成结构化数据文档](https://ai-sdk.dev/docs/ai-sdk-core/generating-structured-data)。

## DevTools

## 开发者工具

Debugging multi-step agent flows is difficult. A small change in context or input tokens at one step can meaningfully change that step's output, which changes the input to the next step, and so on. By the end, the trajectory is completely different, and tracing back to what caused it means manually logging each step and piecing together the sequence yourself.

调试多步 Agent 流程十分困难。某一步骤中上下文或输入 token 的微小变化，都可能显著改变该步骤的输出，进而改变下一步的输入，依此类推。最终，整个执行轨迹可能完全偏离预期；而要追溯问题根源，则需手动记录每一步日志，并自行拼凑出完整执行序列。

![](images/ai-sdk-6-vercel/img_002.jpg)

AI SDK DevTools gives you full visibility into your LLM calls and agents. Inspect each step of any call, including input, output, model configuration, token usage, timing, and raw provider requests and responses.

AI SDK DevTools 为您提供对所有大语言模型（LLM）调用及 Agent 执行过程的完整可观测性。您可以检查任意一次调用的每个步骤，包括输入、输出、模型配置、Token 使用量、耗时，以及底层服务商的原始请求与响应。

### Setup

### 配置

To get started, wrap your model with the `devToolsMiddleware`:

开始使用前，请使用 `devToolsMiddleware` 将您的模型进行封装：

```typescript
import { wrapLanguageModel, gateway } from 'ai';

import { devToolsMiddleware } from '@ai-sdk/devtools';



const devToolsEnabledModel = wrapLanguageModel({

5  model: gateway('anthropic/claude-sonnet-4.5'),

6  middleware: devToolsMiddleware(),

6  中间件：devToolsMiddleware(),

7});
```

7});
```

Then use it with any AI SDK function:

然后在任意 AI SDK 函数中使用它：

```typescript
import { generateText } from 'ai';



const result = await generateText({

4  model: devToolsEnabledModel,

4  模型：devToolsEnabledModel,

5  prompt: 'What is love?',

5  提示词：'What is love?',

6});
```

6});
```

### Inspecting Your Runs

### 检查您的运行记录

Launch the viewer with `npx @ai-sdk/devtools` and open [http://localhost:4983](http://localhost:4983/) to inspect your runs. You'll be able to see:

使用 `npx @ai-sdk/devtools` 启动查看器，并访问 [http://localhost:4983](http://localhost:4983/) 检查您的运行记录。您将能够看到：

![](images/ai-sdk-6-vercel/img_003.jpg)

- **Input parameters and prompts**: View the complete input sent to your LLM

- **输入参数与提示词（prompts）**：查看发送给大语言模型（LLM）的完整输入内容

- **Output content and tool calls**: Inspect generated text and tool invocations

- **输出内容与工具调用**：检查生成的文本及工具调用情况

- **Token usage and timing**: Monitor resource consumption and performance

- **Token 使用量与时序信息**：监控资源消耗与性能表现

- **Raw provider data**: Access complete request and response payloads

- **原始服务商数据**：获取完整的请求与响应载荷

To learn more, check out the [DevTools](https://ai-sdk.dev/docs/ai-sdk-core/devtools) documentation.

如需了解更多，请查阅 [DevTools](https://ai-sdk.dev/docs/ai-sdk-core/devtools) 文档。

## Reranking

## 重排序（Reranking）

Providing relevant context to a language model isn't just about retrieving everything that might be related. Models perform better with focused, highly relevant context. Reranking reorders search results based on their relevance to a specific query, letting you pass only the most relevant documents to the model.

为语言模型提供相关上下文，绝非简单地检索所有可能相关的资料；模型在聚焦、高度相关的信息下表现更佳。重排序（reranking）会依据搜索结果与特定查询的相关性对其进行重新排序，从而确保仅将最相关的文档传递给模型。

AI SDK 6 adds native support for reranking with the new `rerank` function:

AI SDK 6 通过新增的 `rerank` 函数，原生支持重排序功能：

```typescript
import { rerank } from 'ai';

import { cohere } from '@ai-sdk/cohere';



const documents = [\
\
5  'sunny day at the beach',\
\
6  'rainy afternoon in the city',\
\
7  'snowy night in the mountains',\
\
8];



const { ranking } = await rerank({

11  model: cohere.reranking('rerank-v3.5'),

12  documents,

13  query: 'talk about rain',

14  topN: 2,
```

```typescript
import { rerank } from 'ai';

import { cohere } from '@ai-sdk/cohere';



const documents = [\
\
5  '晴朗的海滩日',\
\
6  '城市里阴雨绵绵的午后',\
\
7  '山中白雪皑皑的夜晚',\
\
8];



const { ranking } = await rerank({

11  model: cohere.reranking('rerank-v3.5'),

12  documents,

13  query: '谈谈下雨',

14  topN: 2,
```

15});



console.log(ranking);

18// [\
\
19//   { originalIndex: 1, score: 0.9, document: 'rainy afternoon in the city' },\
\
20//   { originalIndex: 0, score: 0.3, document: 'sunny day at the beach' }\
\
21// ]
```

### Structured Document Reranking

### 结构化文档重排序

Reranking also supports structured documents, making it ideal for searching through databases, emails, or other structured content:

重排序功能同样支持结构化文档，非常适合在数据库、电子邮件或其他结构化内容中进行搜索：

```typescript
import { rerank } from 'ai';

import { cohere } from '@ai-sdk/cohere';



const documents = [\
\
5  { from: 'Paul Doe', subject: 'Follow-up', text: '20% discount offer...' },\
\
6  {\
\
7    from: 'John McGill',\
\
8    subject: 'Missing Info',\
\
9    text: 'Oracle pricing: $5000/month',\
\
10  },\
\
11];

```javascript
const { rerankedDocuments } = await rerank({

14  model: cohere.reranking('rerank-v3.5'),

15  documents,

16  query: 'Which pricing did we get from Oracle?',

17  topN: 1,

18});
```

`rerank` 函数当前支持 Cohere、Amazon Bedrock 以及 [Together.ai](http://together.ai/)。

如需了解更多信息，请查阅 [重排序（Reranking）文档](https://ai-sdk.dev/docs/ai-sdk-core/reranking)。

## Standard JSON Schema

## 标准 JSON Schema

AI SDK 6 adds support for any schema library that implements the [Standard JSON Schema](https://standardschema.dev/json-schema) interface.  
AI SDK 6 现在支持任何实现了 [标准 JSON Schema](https://standardschema.dev/json-schema) 接口的模式（schema）库。

Previously, the SDK required built-in converters for each schema library (Arktype, Valibot). Now, any library implementing the Standard JSON Schema V1 specification works automatically without additional SDK changes.  
此前，SDK 需要为每个模式库（如 Arktype、Valibot）内置专用的转换器。如今，只要模式库实现了标准 JSON Schema V1 规范，即可开箱即用，无需对 SDK 做额外修改。

```typescript
import { generateText, Output } from 'ai';

import { type } from 'arktype';



const result = await generateText({

5  model: 'anthropic/claude-sonnet-4.5',

6  output: Output.object({

7    schema: type({

8      recipe: {

9        name: 'string',

10        ingredients: type({ name: 'string', amount: 'string' }).array(),

10        食材：type({ name: 'string', amount: 'string' }).array(),

11        steps: 'string[]',

11        步骤：'string[]',

12      },

12      },

13    }),

13    }),

14  }),

14  }),

15  prompt: 'Generate a lasagna recipe.',

15  prompt: '生成一份千层面食谱。',

16});
16});
```

To learn more, check out the [Tools documentation](https://ai-sdk.dev/docs/foundations/tools).

如需了解更多信息，请查阅 [工具文档](https://ai-sdk.dev/docs/foundations/tools)。

## Provider Tools

## 提供商专属工具

AI SDK 6 扩展了对提供商专属工具的支持，这些工具可利用各平台的独特能力及模型原生训练的功能。此类工具专为特定模型或平台（例如网络搜索、代码执行和内存管理）而设计，提供商已在这些能力上对其模型进行了专门优化，或提供了其他平台所不具备的平台级特性。

### Anthropic Provider Tools

### Anthropic 提供商工具

- Memory Tool: Store and retrieve information across conversations through a memory file directory

- 记忆工具（Memory Tool）：通过内存文件目录在多轮对话中存储和检索信息

- Tool Search (Regex): Search and select tools dynamically using regex patterns

- 工具搜索（正则表达式，Regex）：使用正则表达式模式动态搜索和选择工具

- Tool Search (BM25): Search and select tools using natural language queries

- 工具搜索（BM25）：使用自然语言查询搜索和选择工具

- Code Execution Tool: Run code in a secure sandboxed environment with bash and file operations

- 代码执行工具（Code Execution Tool）：在具备 Bash 和文件操作能力的安全沙箱环境中运行代码


```typescript
import { anthropic } from "@ai-sdk/anthropic";



3// Memory Tool - store and retrieve information

3// 记忆工具 —— 存储与检索信息

const memory = anthropic.tools.memory_20250818({

5  execute: async (action) => {

6    // Implement memory storage logic

6    // 实现内存存储逻辑

7    // Supports: view, create, str_replace, insert, delete, rename

7    // 支持：view、create、str_replace、insert、delete、rename

8  },

8  },

9});



9 });



11// Tool Search (Regex) - find tools by pattern

11// 工具搜索（正则表达式）——按模式查找工具

const toolSearchRegex = anthropic.tools.toolSearchRegex_20251119();

const toolSearchRegex = anthropic.tools.toolSearchRegex_20251119();



14// Tool Search (BM25) - find tools with natural language

14// 工具搜索（BM25）——使用自然语言查找工具

const toolSearchBm25 = anthropic.tools.toolSearchBm25_20251119();

const toolSearchBm25 = anthropic.tools.toolSearchBm25_20251119();

17// Code Execution Tool - run code in sandbox

17// 代码执行工具 —— 在沙箱中运行代码

const codeExecution = anthropic.tools.codeExecution_20250825();
```

const codeExecution = anthropic.tools.codeExecution_20250825();
```

AI SDK 6 also adds support for [programmatic tool calling](https://www.anthropic.com/engineering/advanced-tool-use#programmatic-tool-calling), which allows Claude to call your tools from a code execution environment, keeping intermediate results out of context. This can significantly reduce token usage and cost.

AI SDK 6 还新增了对[程序化工具调用（programmatic tool calling）](https://www.anthropic.com/engineering/advanced-tool-use#programmatic-tool-calling)的支持，使 Claude 能够直接从代码执行环境中调用您定义的工具，从而将中间结果保留在上下文之外。这可显著降低 token 消耗和使用成本。

Mark tools as callable from code execution with `allowedCallers`, and use `prepareStep` to preserve the container across steps:

通过 `allowedCallers` 标记工具为允许从代码执行环境调用，并使用 `prepareStep` 在多个步骤间保持容器状态：

```typescript
import {

2  anthropic,

3  forwardAnthropicContainerIdFromLastStep,

4} from "@ai-sdk/anthropic";
```

```ts
const getWeather = tool({

7  description: "Get weather for a city.",

7  描述：“获取某城市的天气信息。”

8  inputSchema: z.object({ city: z.string() }),

8  输入模式：z.object({ city: z.string() }),

9  execute: async ({ city }) => ({ temp: 22 }),

9  执行函数：async ({ city }) => ({ temp: 22 }),

10  providerOptions: {

10  提供商选项：{

11    anthropic: { allowedCallers: ["code_execution_20250825"] },

11    anthropic: { allowedCallers: ["code_execution_20250825"] },

12  },

12  },

13});
```

```ts
const result = await generateText({

17  model: anthropic("claude-sonnet-4-5"),

18  tools: {

19    code_execution: anthropic.tools.codeExecution_20250825(),

20    getWeather,

21  },

22  prepareStep: forwardAnthropicContainerIdFromLastStep,

23});
```

如需了解更多信息，请查阅 [Anthropic 官方文档](https://ai-sdk.dev/providers/ai-sdk-providers/anthropic)。

### OpenAI Provider 工具

### OpenAI 提供商工具

- Shell Tool: Execute shell commands with timeout and output limits  
- Shell 工具：执行带超时和输出限制的 Shell 命令

- Apply Patch Tool: Create, update, and delete files using structured diffs  
- 应用补丁工具：使用结构化差异（structured diffs）创建、更新和删除文件

- MCP Tool: Connect to remote Model Context Protocol servers  
- MCP 工具：连接远程 Model Context Protocol 服务器


```typescript
import { openai } from "@ai-sdk/openai";



3// Shell Tool - execute shell commands  
3// Shell 工具 — 执行 Shell 命令

const shell = openai.tools.shell({

5  execute: async ({ action }) => {

6    // action.commands: string[] - commands to execute  
6    // action.commands: string[] — 待执行的命令列表

7    // action.timeoutMs: optional timeout  
7    // action.timeoutMs：可选的超时时间（毫秒）
```

8    // action.maxOutputLength: 可选的最大返回字符数

9  },

10});



12// Apply Patch Tool — 使用差分（diff）进行文件操作

const applyPatch = openai.tools.applyPatch({

14  execute: async ({ callId, operation }) => {

15    // operation.type: 'create_file' | 'update_file' | 'delete_file'

16    // operation.path: 文件路径

17    // operation.diff: 差分内容（仅适用于 create/update 操作）

18  },

19});



21// MCP Tool - connect to MCP servers

21// MCP 工具 — 连接到 MCP 服务器

const mcp = openai.tools.mcp({

23  serverLabel: "my-mcp-server",

23  服务器标签: "my-mcp-server",

24  serverUrl: "[https://mcp.example.com](https://mcp.example.com/)",

24  服务器 URL: "[https://mcp.example.com](https://mcp.example.com/)",

25  allowedTools: ["tool1", "tool2"],

25  允许使用的工具: ["tool1", "tool2"],

26});
```

To learn more, check out [the OpenAI documentation](https://ai-sdk.dev/providers/ai-sdk-providers/openai).

如需了解更多信息，请查阅 [OpenAI 官方文档](https://ai-sdk.dev/providers/ai-sdk-providers/openai)。

### Google Provider Tools

### Google 提供商工具

- Google Maps Tool: Enable location-aware responses with Maps grounding (Gemini 2.0+)

- Google Maps 工具：通过 Maps 接地（grounding）实现基于位置的响应（需 Gemini 2.0 或更高版本）

- Vertex RAG Store Tool: Retrieve context from Vertex AI RAG Engine corpora (Gemini 2.0+)

- Vertex RAG Store 工具：从 Vertex AI RAG Engine 的语料库中检索上下文（需 Gemini 2.0 或更高版本）

- File Search Tool: Semantic and keyword search in file search stores (Gemini 2.5+)

- 文件搜索工具：在文件搜索存储中执行语义搜索与关键词搜索（需 Gemini 2.5 或更高版本）

```typescript
import { google } from "@ai-sdk/google";



3// Google Maps Tool - location-aware grounding

3// Google Maps 工具 —— 基于位置的接地（grounding）

const googleMaps = google.tools.googleMaps();



6// Vertex RAG Store Tool - retrieve from RAG corpora

6// Vertex RAG Store 工具 —— 从 RAG 语料库中检索
```

```javascript
const vertexRagStore = google.tools.vertexRagStore({

8  ragCorpus: "projects/{project}/locations/{location}/ragCorpora/{rag_corpus}",

8  ragCorpus: “projects/{project}/locations/{location}/ragCorpora/{rag_corpus}”,

9  topK: 5, // optional: number of contexts to retrieve

9  topK: 5, // 可选：检索的上下文数量

10});

10});

12// File Search Tool - search in file stores

12// 文件搜索工具 — 在文件存储中进行搜索

const fileSearch = google.tools.fileSearch({

14  fileSearchStoreNames: ["fileSearchStores/my-store-123"],

14  fileSearchStoreNames: ["fileSearchStores/my-store-123"],

15  topK: 10, // optional: number of chunks to retrieve

15  topK: 10, // 可选：检索的文本块（chunk）数量

16  metadataFilter: "author=John Doe", // optional: AIP-160 filter

16  metadataFilter: "author=John Doe", // 可选：符合 AIP-160 规范的元数据过滤器
```

17});
```

如需了解更多，请查阅 [Google 官方文档](https://ai-sdk.dev/providers/ai-sdk-providers/google-generative-ai)。

### xAI 提供商工具

- 网络搜索（Web Search）：支持域名过滤与图像理解的网络搜索功能  

- X 搜索（X Search）：支持按用户账号（handle）和日期筛选的 X（Twitter）帖子搜索  

- 代码执行（Code Execution）：在沙箱环境中运行代码  

- 查看图像（View Image）：分析并描述图像内容  

- 查看 X 视频（View X Video）：分析 X 平台上的视频内容  

```typescript
import { xai } from "@ai-sdk/xai";
```

3// Web Search Tool - search the web

3// 网络搜索工具 —— 搜索网页

const webSearch = xai.tools.webSearch({

const webSearch = xai.tools.webSearch({

5  allowedDomains: [\
\
5  allowedDomains: [\

6    "[wikipedia.org](http://wikipedia.org/)",\
\
6    "[wikipedia.org](http://wikipedia.org/)",\

7    "[github.com](http://github.com/)",\
\
7    "[github.com](http://github.com/)",\

8  ], // optional: max 5

8  ], // 可选：最多 5 个域名

9  excludedDomains: ["[example.com](http://example.com/)"], // optional: max 5

9  excludedDomains: ["[example.com](http://example.com/)"], // 可选：最多 5 个域名

10  enableImageUnderstanding: true, // optional

10  enableImageUnderstanding: true, // 可选

11});



11});



13// X Search Tool - search X posts

13// X 搜索工具 —— 搜索 X 平台帖子

const xSearch = xai.tools.xSearch({

const xSearch = xai.tools.xSearch({

15  allowedXHandles: ["elonmusk", "xai"], // optional: max 10

15  allowedXHandles: ["elonmusk", "xai"], // 可选：最多 10 个 X 用户名

16  fromDate: "2025-01-01", // 可选

17  toDate: "2025-12-31", // 可选

18  enableImageUnderstanding: true, // 可选

19  enableVideoUnderstanding: true, // 可选

20});



22// 代码执行工具 — 运行代码

const codeExecution = xai.tools.codeExecution();



25// 图像查看工具 — 分析图像

```typescript
const viewImage = xai.tools.viewImage();
```

```typescript
const viewImage = xai.tools.viewImage();
```

28// View X Video Tool - analyze X videos

28// “View X Video” 工具——分析 X 平台视频

```typescript
const viewXVideo = xai.tools.viewXVideo();
```

```typescript
const viewXVideo = xai.tools.viewXVideo();
```

To learn more, check out [the xAI documentation](https://ai-sdk.dev/providers/ai-sdk-providers/xai).

如需了解更多信息，请查阅 [xAI 文档](https://ai-sdk.dev/providers/ai-sdk-providers/xai)。

## Image Editing

## 图像编辑

Image generation models are increasingly capable of more than just text-to-image generation. Many now support image-to-image operations like inpainting, outpainting, style transfer, and more.

图像生成模型的能力正日益超越单纯的文生图（text-to-image）任务。如今，许多模型已支持各类图生图（image-to-image）操作，例如图像修复（inpainting）、图像扩展（outpainting）、风格迁移（style transfer）等。

AI SDK 6 extends `generateImage` to support image editing by accepting reference images alongside your text prompt:

AI SDK 6 对 `generateImage` 进行了扩展，使其支持图像编辑功能：您可在提供文本提示（text prompt）的同时，传入参考图像（reference images）。

```typescript
import { generateImage } from "ai";

import { blackForestLabs } from "@ai-sdk/black-forest-labs";
```

```typescript
import { generateImage } from "ai";

import { blackForestLabs } from "@ai-sdk/black-forest-labs";
```

```ts
const { images } = await generateImage({

5  model: blackForestLabs.image("flux-2-pro"),

6  prompt: {

7    text: "Edit this to make it two tanukis on a date",

8    images: ["https://www.example.com/tanuki.png"],

9  },

10});
```

!["Edit this to make it two tanukis on a date"](images/ai-sdk-6-vercel/img_004.jpg)  
“将此图编辑为两只狸猫正在约会”

参考图像可以以 URL 字符串、base64 编码字符串、Uint8Array、ArrayBuffer 或 Buffer 的形式提供。

Note: `experimental_generateImage` has been promoted to stable and renamed to `generateImage`.

注意：`experimental_generateImage` 已升级为稳定版，并重命名为 `generateImage`。

Check out [the Image Generation documentation](https://ai-sdk.dev/docs/ai-sdk-core/image-generation) to learn more.

请参阅[图像生成文档](https://ai-sdk.dev/docs/ai-sdk-core/image-generation)，了解更多信息。

## Raw Finish Reason & Extended Usage

## 原始结束原因与扩展用量信息

AI SDK 6 improves visibility into model responses with raw finish reasons and restructured usage information.

AI SDK 6 通过提供原始结束原因（raw finish reasons）和重构后的用量信息（usage information），增强了对模型响应的可观测性。

### Raw Finish Reason

### 原始结束原因

When providers add new finish reasons that the AI SDK doesn't recognize, they previously appeared as `'other'`. Now, `rawFinishReason` exposes the exact string from the provider, letting you handle provider-specific cases before AI SDK updates.

当模型服务商新增了 AI SDK 尚未识别的结束原因时，过去这些原因统一显示为 `'other'`；而现在，`rawFinishReason` 字段将直接暴露服务商返回的原始字符串，使您能在 AI SDK 更新前，自主处理各服务商特有的结束原因场景。

```typescript
const { finishReason, rawFinishReason } = await generateText({

2  model: 'anthropic/claude-sonnet-4.5',

3  prompt: 'What is love?',

4});
```

6// finishReason: 'other'（已映射）

7// rawFinishReason: 'end_turn'（供应商特定）
```

当不同供应商的多种结束原因映射到 AI SDK 的同一取值时，或当您需要区分特定供应商的行为时，此功能非常有用。

### 扩展的用量信息

用量报告现在包含输入令牌和输出令牌的详细细分：

```typescript
const { usage } = await generateText({

2  model: 'anthropic/claude-sonnet-4.5',

3  prompt: 'What is love?',

4});

6// Input token details

6// 输入令牌详情

usage.inputTokenDetails.noCacheTokens;    // Non-cached input tokens

usage.inputTokenDetails.noCacheTokens;    // 未缓存的输入令牌

usage.inputTokenDetails.cacheReadTokens;  // Tokens read from cache

usage.inputTokenDetails.cacheReadTokens;  // 从缓存中读取的令牌

usage.inputTokenDetails.cacheWriteTokens; // Tokens written to cache

usage.inputTokenDetails.cacheWriteTokens; // 写入缓存的令牌



11// Output token details

11// 输出令牌详情

usage.outputTokenDetails.textTokens;      // Text generation tokens

usage.outputTokenDetails.textTokens;      // 文本生成令牌

usage.outputTokenDetails.reasoningTokens; // Reasoning tokens (where supported)

usage.outputTokenDetails.reasoningTokens; // 推理令牌（在支持的情况下）

15// 原始提供方（provider）用法

15// 原始提供方（provider）用法

usage.raw; // 完整的、特定于提供方的用量对象  
usage.raw; // 完整的、特定于提供方的用量对象  

这些详细的用量分解，可帮助您全面掌握各提供方的 Token 消耗情况，从而优化成本并高效调试。

这些详细的用量分解，可帮助您全面掌握各提供方的 Token 消耗情况，从而优化成本并高效调试。

## LangChain 适配器重写

## LangChain 适配器重写

`@ai-sdk/langchain` 包已全面重写，以支持现代 LangChain 和 LangGraph 的各项特性。新增 API 包括：`toBaseMessages()`（用于将 UI 消息转换为 LangChain 格式）、`toUIMessageStream()`（用于转换 LangGraph 事件流）、以及 `LangSmithDeploymentTransport`（用于在浏览器端连接 LangSmith 部署实例）。该适配器现已支持工具调用（tool calling）中的部分输入流式传输（partial input streaming）、推理块（reasoning blocks），以及通过 LangGraph 中断（interrupts）实现的人机协同（Human-in-the-Loop）工作流。

`@ai-sdk/langchain` 包已全面重写，以支持现代 LangChain 和 LangGraph 的各项特性。新增 API 包括：`toBaseMessages()`（用于将 UI 消息转换为 LangChain 格式）、`toUIMessageStream()`（用于转换 LangGraph 事件流）、以及 `LangSmithDeploymentTransport`（用于在浏览器端连接 LangSmith 部署实例）。该适配器现已支持工具调用（tool calling）中的部分输入流式传输（partial input streaming）、推理块（reasoning blocks），以及通过 LangGraph 中断（interrupts）实现的人机协同（Human-in-the-Loop）工作流。

```typescript
import { toBaseMessages, toUIMessageStream } from '@ai-sdk/langchain';

import { createUIMessageStreamResponse } from 'ai';



const langchainMessages = await toBaseMessages(messages);

const stream = await graph.stream({ messages: langchainMessages });
```

```javascript
return createUIMessageStreamResponse({

8  stream: toUIMessageStream(stream),

9});
```

```javascript
return createUIMessageStreamResponse({

8  stream: toUIMessageStream(stream),

9});
```

This release is fully backwards compatible. To learn more, check out the [LangChain Adapter](https://ai-sdk.dev/providers/adapters/langchain) documentation.

此版本完全向后兼容。欲了解更多信息，请查阅 [LangChain 适配器](https://ai-sdk.dev/providers/adapters/langchain) 文档。

## Migrating to AI SDK 6

## 迁移至 AI SDK 6

AI SDK 6 是一个主版本，因其引入了 v3 语言模型规范（Language Model Specification），该规范为智能体（agents）和工具调用审批（tool approval）等新功能提供支持。然而，与 AI SDK 5 不同，本次发布预计对大多数用户不会引入重大破坏性变更。

版本号的升级反映了语言模型规范本身的改进，而非 SDK 架构的全面重构。若您正在使用 AI SDK 5，迁移到 v6 应当十分顺畅，仅需极少的代码修改。

版本号的升级反映了语言模型规范本身的改进，而非 SDK 架构的全面重构。若您正在使用 AI SDK 5，迁移到 v6 应当十分顺畅，仅需极少的代码修改。

```bash
npx @ai-sdk/codemod upgrade v6
```

```bash
npx @ai-sdk/codemod upgrade v6
```

For a detailed overview of all changes and manual steps that might be needed, refer to our [AI SDK 6 migration guide](https://v6.ai-sdk.dev/docs/migration-guides/migration-guide-6-0). The guide includes step-by-step instructions and examples to ensure a smooth update.

如需全面了解所有变更内容以及可能需要的手动操作步骤，请参阅我们的 [AI SDK 6 迁移指南](https://v6.ai-sdk.dev/docs/migration-guides/migration-guide-6-0)。该指南包含分步操作说明与示例代码，助您顺利完成升级。

## Getting started

## 入门指南

> “我对 v6 版本感到无比兴奋！从 `streamText` 迁移到可组合式智能体（composable agents）的设计非常优雅，围绕类型安全（type-safety）、MCP（Model Control Protocol）以及智能体准备（agent preparation）所构建的新 API 同样令人赞叹。团队在 API 设计上倾注的心血简直令人惊叹。”  
>  
> ![](images/ai-sdk-6-vercel/img_005.png)  
>  
> **Josh**，Upstash  

凭借一系列强大新能力——例如 `ToolLoopAgent`、人工介入式工具调用审批（human-in-the-loop tool approval）、基于工具调用的稳定结构化输出（stable structured outputs with tool calling），以及专为调试打造的 DevTools——现在正是使用 AI SDK 构建 AI 应用的最佳时机。

- **启动一个全新的 AI 项目**：参考我们为 Next.js、React、Svelte 等框架提供的最新入门指南，快速上手。请查阅我们的[最新指南](https://v6.ai-sdk.dev/docs/guides)。  

- **探索我们的模板库**：访问[模板画廊（Template Gallery）](https://templates.ai-sdk.dev/)，获取开箱即用、面向生产环境的启动项目。  

- **迁移到 v6 版本**：使用我们提供的自动化 codemod 工具，实现平滑升级。我们详尽的[迁移指南](https://v6.ai-sdk.dev/docs/migration-guides/migration-guide-6-0)全面涵盖了所有不兼容变更（breaking changes）。  

- **试用 DevTools**：借助 DevTools 对 LLM 调用进行全程可视化调试，大幅提升 AI 应用开发效率。请参阅 [DevTools 文档](https://v6.ai-sdk.dev/docs/guides/devtools)。  

- **加入社区**：在我们的 [GitHub Discussions](https://github.com/vercel/ai/discussions) 中分享你的项目、提出问题，并与其他开发者交流协作。

## Contributors

## 贡献者

AI SDK 6 是 Vercel 核心团队（Gregor、Lars、Aayush、Josh、Nico）与众多杰出社区贡献者通力协作的成果：

[viktorlarsson](https://github.com/viktorlarsson), [shaper](https://github.com/shaper), [AVtheking](https://github.com/AVtheking), [SamyPesse](https://github.com/SamyPesse), [firemoonai](https://github.com/firemoonai), [seldo](https://github.com/seldo), [R-Taneja](https://github.com/R-Taneja), [ZiuChen](https://github.com/ZiuChen), [gaspar09](https://github.com/gaspar09), [christian-bromann](https://github.com/christian-bromann), [jeremyphilemon](https://github.com/jeremyphilemon), [DaniAkash](https://github.com/DaniAkash), [a-tokyo](https://github.com/a-tokyo), [rohrz4nge](https://github.com/rohrz4nge), [EwanTauran](https://github.com/EwanTauran), [codicecustode](https://github.com/codicecustode), [shubham-021](https://github.com/shubham-021), [kkawamu1](https://github.com/kkawamu1), [mclenhard](https://github.com/mclenhard), [gdaybrice](https://github.com/gdaybrice), [dyh-sjtu](https://github.com/dyh-sjtu), [blurrah](https://github.com/blurrah), [EurFelux](https://github.com/EurFelux), [AryanBagade](https://github.com/AryanBagade), [Omcodes23](https://github.com/Omcodes23), [jeffcarbs](https://github.com/jeffcarbs), [codeyogi911](https://github.com/codeyogi911), [zirkelc](https://github.com/zirkelc), [qkdreyer](https://github.com/qkdreyer), [tsuzaki430](https://github.com/tsuzaki430), [qchuchu](https://github.com/qchuchu), [karthikscale3](https://github.com/karthikscale3), [alex-deneuvillers](https://github.com/alex-deneuvillers), [kesku](https://github.com/kesku), [yorkeccak](https://github.com/yorkeccak), [guy-hartstein](https://github.com/guy-hartstein), [Und3rf10w](https://github.com/Und3rf10w), [siwachabhi](https://github.com/siwachabhi), [homanp](https://github.com/homanp), [tengis617](https://github.com/tengis617), [SalvatoreAmoroso](https://github.com/SalvatoreAmoroso), [ericciarla](https://github.com/ericciarla), [baturyilmaz](https://github.com/baturyilmaz), [chentsulin](https://github.com/chentsulin), [kovereduard](https://github.com/kovereduard), [yaonyan](https://github.com/yaonyan), [mwln](https://github.com/mwln), [IdoBouskila](https://github.com/IdoBouskila), [wangyedev](https://github.com/wangyedev), [rubnogueira](https://github.com/rubnogueira), [Emmaccen](https://github.com/Emmaccen), [priyanshusaini105](https://github.com/priyanshusaini105), [dpmishler](https://github.com/dpmishler), [yilinjuang](https://github.com/yilinjuang), [JulioPeixoto](https://github.com/JulioPeixoto), [DeJeune](https://github.com/DeJeune), [BangDori](https://github.com/BangDori), [shadowssdt](https://github.com/shadowssdt), [efantasia](https://github.com/efantasia), [kevinjosethomas](https://github.com/kevinjosethomas), [lukehrucker](https://github.com/lukehrucker), [Mohammedsinanpk](https://github.com/Mohammedsinanpk), [danielamitay](https://github.com/danielamitay), [davidsonsns](https://github.com/davidsonsns), [teeverc](https://github.com/teeverc), [MQ37](https://github.com/MQ37), [jephal](https://github.com/jephal), [TimPietrusky](https://github.com/TimPietrusky), [theishangoswami](https://github.com/theishangoswami), [juliettech13](https://github.com/juliettech13), [shelleypham](https://github.com/shelleypham), [tconley1428](https://github.com/tconley1428), [goyalshivansh2805](https://github.com/goyalshivansh2805), [KirschX](https://github.com/KirschX), [neallseth](https://github.com/neallseth), [jltimm](https://github.com/jltimm), [rahulbhadja](https://github.com/rahulbhadja), [tayyab3245](https://github.com/tayyab3245), [cwtuan](https://github.com/cwtuan), [titouv](https://github.com/titouv), [dylan-duan-aai](https://github.com/dylan-duan-aai), [bel0v](https://github.com/bel0v), [josh-williams](https://github.com/josh-williams), [amyegan](https://github.com/amyegan), [samjbobb](https://github.com/samjbobb), [teunlao](https://github.com/teunlao), [dylanmoz](https://github.com/dylanmoz), [0xlakshan](https://github.com/0xlakshan), [patelvivekdev](https://github.com/patelvivekdev), [nvie](https://github.com/nvie), [nlaz](https://github.com/nlaz), [drew-foxall](https://github.com/drew-foxall), [dannyroosevelt](https://github.com/dannyroosevelt), [Diluka](https://github.com/Diluka), [AlexKer](https://github.com/AlexKer), [YosefLm](https://github.com/YosefLm), [YutoKitano13](https://github.com/YutoKitano13), [SarityS](https://github.com/SarityS), [jonaslalin](https://github.com/jonaslalin), [tobiasbueschel](https://github.com/tobiasbueschel), [dhofheinz](https://github.com/dhofheinz), [ethshea](https://github.com/ethshea), [ellis-driscoll](https://github.com/ellis-driscoll), [marcbouchenoire](https://github.com/marcbouchenoire), [shin-sakata](https://github.com/shin-sakata), [ellispinsky](https://github.com/ellispinsky), [DDU1222](https://github.com/DDU1222), [ci](https://github.com/ci), [tomsseisums](https://github.com/tomsseisums), [kpman](https://github.com/kpman), [juanuicich](https://github.com/juanuicich), [A404coder](https://github.com/A404coder), [tamarshe-dev](https://github.com/tamarshe-dev), [crishoj](https://github.com/crishoj), [kevint-cerebras](https://github.com/kevint-cerebras), [arjunkmrm](https://github.com/arjunkmrm), [Barbapapazes](https://github.com/Barbapapazes), [nimeshnayaju](https://github.com/nimeshnayaju), [lewwolfe](https://github.com/lewwolfe), [sergical](https://github.com/sergical), [tomerigal](https://github.com/tomerigal), [huanshenyi](https://github.com/huanshenyi), [horita-yuya](https://github.com/horita-yuya), [rbadillap](https://github.com/rbadillap), [syeddhasnainn](https://github.com/syeddhasnainn), [Dhravya](https://github.com/Dhravya), [jagreehal](https://github.com/jagreehal), [Mintnoii](https://github.com/Mintnoii), [mhodgson](https://github.com/mhodgson), [amardeeplakshkar](https://github.com/amardeeplakshkar), [aron](https://github.com/aron), [TooTallNate](https://github.com/TooTallNate), [Junyi-99](https://github.com/Junyi-99), [princejoogie](https://github.com/princejoogie), [iiio2](https://github.com/iiio2), [MonkeyLeeT](https://github.com/MonkeyLeeT), [joshualipman123](https://github.com/joshualipman123), [andrewdoro](https://github.com/andrewdoro), [fveiraswww](https://github.com/fveiraswww), [HugoRCD](https://github.com/HugoRCD), [rockingrohit9639](https://github.com/rockingrohit9639)

[viktorlarsson](https://github.com/viktorlarsson)、[shaper](https://github.com/shaper)、[AVtheking](https://github.com/AVtheking)、[SamyPesse](https://github.com/SamyPesse)、[firemoonai](https://github.com/firemoonai)、[seldo](https://github.com/seldo)、[R-Taneja](https://github.com/R-Taneja)、[ZiuChen](https://github.com/ZiuChen)、[gaspar09](https://github.com/gaspar09)、[christian-bromann](https://github.com/christian-bromann)、[jeremyphilemon](https://github.com/jeremyphilemon)、[DaniAkash](https://github.com/DaniAkash)、[a-tokyo](https://github.com/a-tokyo)、[rohrz4nge](https://github.com/rohrz4nge)、[EwanTauran](https://github.com/EwanTauran)、[codicecustode](https://github.com/codicecustode)、[shubham-021](https://github.com/shubham-021)、[kkawamu1](https://github.com/kkawamu1)、[mclenhard](https://github.com/mclenhard)、[gdaybrice](https://github.com/gdaybrice)、[dyh-sjtu](https://github.com/dyh-sjtu)、[blurrah](https://github.com/blurrah)、[EurFelux](https://github.com/EurFelux)、[AryanBagade](https://github.com/AryanBagade)、[Omcodes23](https://github.com/Omcodes23)、[jeffcarbs](https://github.com/jeffcarbs)、[codeyogi911](https://github.com/codeyogi911)、[zirkelc](https://github.com/zirkelc)、[qkdreyer](https://github.com/qkdreyer)、[tsuzaki430](https://github.com/tsuzaki430)、[qchuchu](https://github.com/qchuchu)、[karthikscale3](https://github.com/karthikscale3)、[alex-deneuvillers](https://github.com/alex-deneuvillers)、[kesku](https://github.com/kesku)、[yorkeccak](https://github.com/yorkeccak)、[guy-hartstein](https://github.com/guy-hartstein)、[Und3rf10w](https://github.com/Und3rf10w)、[siwachabhi](https://github.com/siwachabhi)、[homanp](https://github.com/homanp)、[tengis617](https://github.com/tengis617)、[SalvatoreAmoroso](https://github.com/SalvatoreAmoroso)、[ericciarla](https://github.com/ericciarla)、[baturyilmaz](https://github.com/baturyilmaz)、[chentsulin](https://github.com/chentsulin)、[kovereduard](https://github.com/kovereduard)、[yaonyan](https://github.com/yaonyan)、[mwln](https://github.com/mwln)、[IdoBouskila](https://github.com/IdoBouskila)、[wangyedev](https://github.com/wangyedev)、[rubnogueira](https://github.com/rubnogueira)、[Emmaccen](https://github.com/Emmaccen)、[priyanshusaini105](https://github.com/priyanshusaini105)、[dpmishler](https://github.com/dpmishler)、[yilinjuang](https://github.com/yilinjuang)、[JulioPeixoto](https://github.com/JulioPeixoto)、[DeJeune](https://github.com/DeJeune)、[BangDori](https://github.com/BangDori)、[shadowssdt](https://github.com/shadowssdt)、[efantasia](https://github.com/efantasia)、[kevinjosethomas](https://github.com/kevinjosethomas)、[lukehrucker](https://github.com/lukehrucker)、[Mohammedsinanpk](https://github.com/Mohammedsinanpk)、[danielamitay](https://github.com/danielamitay)、[davidsonsns](https://github.com/davidsonsns)、[teeverc](https://github.com/teeverc)、[MQ37](https://github.com/MQ37)、[jephal](https://github.com/jephal)、[TimPietrusky](https://github.com/TimPietrusky)、[theishangoswami](https://github.com/theishangoswami)、[juliettech13](https://github.com/juliettech13)、[shelleypham](https://github.com/shelleypham)、[tconley1428](https://github.com/tconley1428)、[goyalshivansh2805](https://github.com/goyalshivansh2805)、[KirschX](https://github.com/KirschX)、[neallseth](https://github.com/neallseth)、[jltimm](https://github.com/jltimm)、[rahulbhadja](https://github.com/rahulbhadja)、[tayyab3245](https://github.com/tayyab3245)、[cwtuan](https://github.com/cwtuan)、[titouv](https://github.com/titouv)、[dylan-duan-aai](https://github.com/dylan-duan-aai)、[bel0v](https://github.com/bel0v)、[josh-williams](https://github.com/josh-williams)、[amyegan](https://github.com/amyegan)、[samjbobb](https://github.com/samjbobb)、[teunlao](https://github.com/teunlao)、[dylanmoz](https://github.com/dylanmoz)、[0xlakshan](https://github.com/0xlakshan)、[patelvivekdev](https://github.com/patelvivekdev)、[nvie](https://github.com/nvie)、[nlaz](https://github.com/nlaz)、[drew-foxall](https://github.com/drew-foxall)、[dannyroosevelt](https://github.com/dannyroosevelt)、[Diluka](https://github.com/Diluka)、[AlexKer](https://github.com/AlexKer)、[YosefLm](https://github.com/YosefLm)、[YutoKitano13](https://github.com/YutoKitano13)、[SarityS](https://github.com/SarityS)、[jonaslalin](https://github.com/jonaslalin)、[tobiasbueschel](https://github.com/tobiasbueschel)、[dhofheinz](https://github.com/dhofheinz)、[ethshea](https://github.com/ethshea)、[ellis-driscoll](https://github.com/ellis-driscoll)、[marcbouchenoire](https://github.com/marcbouchenoire)、[shin-sakata](https://github.com/shin-sakata)、[ellispinsky](https://github.com/ellispinsky)、[DDU1222](https://github.com/DDU1222)、[ci](https://github.com/ci)、[tomsseisums](https://github.com/tomsseisums)、[kpman](https://github.com/kpman)、[juanuicich](https://github.com/juanuicich)、[A404coder](https://github.com/A404coder)、[tamarshe-dev](https://github.com/tamarshe-dev)、[crishoj](https://github.com/crishoj)、[kevint-cerebras](https://github.com/kevint-cerebras)、[arjunkmrm](https://github.com/arjunkmrm)、[Barbapapazes](https://github.com/Barbapapazes)、[nimeshnayaju](https://github.com/nimeshnayaju)、[lewwolfe](https://github.com/lewwolfe)、[sergical](https://github.com/sergical)、[tomerigal](https://github.com/tomerigal)、[huanshenyi](https://github.com/huanshenyi)、[horita-yuya](https://github.com/horita-yuya)、[rbadillap](https://github.com/rbadillap)、[syeddhasnainn](https://github.com/syeddhasnainn)、[Dhravya](https://github.com/Dhravya)、[jagreehal](https://github.com/jagreehal)、[Mintnoii](https://github.com/Mintnoii)、[mhodgson](https://github.com/mhodgson)、[amardeeplakshkar](https://github.com/amardeeplakshkar)、[aron](https://github.com/aron)、[TooTallNate](https://github.com/TooTallNate)、[Junyi-99](https://github.com/Junyi-99)、[princejoogie](https://github.com/princejoogie)、[iiio2](https://github.com/iiio2)、[MonkeyLeeT](https://github.com/MonkeyLeeT)、[joshualipman123](https://github.com/joshualipman123)、[andrewdoro](https://github.com/andrewdoro)、[fveiraswww](https://github.com/fveiraswww)、[HugoRCD](https://github.com/HugoRCD)、[rockingrohit9639](https://github.com/rockingrohit9639)

Your feedback, bug reports, and pull requests on GitHub have been instrumental in shaping this release. We're excited to see what you'll build with these new capabilities.

您在 GitHub 上提供的反馈、问题报告和拉取请求（pull requests）对本次版本的成型起到了至关重要的作用。我们非常期待看到您如何利用这些新功能构建出精彩的应用！