---
title: "AI SDK 6 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-6"
date: "2025-12-22"
scraped_at: "2026-03-02T09:23:34.886135352+00:00"
language: "en"
translated: false
description: "Introducing agents, tool execution approval, DevTools, full MCP support, reranking, image editing, and more."
---




Dec 22, 2025

Introducing agents, tool execution approval, DevTools, full MCP support, reranking, image editing, and more.

With over 20 million monthly downloads and adoption by teams ranging from startups to Fortune 500 companies, the [AI SDK](https://ai-sdk.dev/) is the leading TypeScript toolkit for building AI applications. It provides a unified API, allowing you to integrate with any AI provider, and seamlessly integrates with Next.js, React, Svelte, Vue, and Node.js. The AI SDK enables you to build everything from chatbots to complex background agents.

[Thomson Reuters](https://www.thomsonreuters.com/) used the AI SDK to build [CoCounsel](https://www.thomsonreuters.com/en/cocounsel), their AI assistant for attorneys, accountants, and audit teams, with just 3 developers in 2 months. Now serving 1,300 accounting firms, they're migrating their entire codebase to the AI SDK, deprecating thousands of lines of code across 10 providers and consolidating into one composable, scalable system.

[Clay](https://www.clay.com/) used it to build [Claygent](https://www.clay.com/claygent), their AI web research agent that scrapes public data, connects to first-party sources via MCP servers, and helps sales teams find accounts with custom, targeted insights.

> “We’ve gone all in on the AI SDK. Its agentic capabilities and TypeScript-first design power our AI web research agent (Claygent) at massive scale. It's been a huge help as we build agents for sourcing, qualification, and surfacing the right accounts and prospects for our customers.We’ve gone all in on the AI SDK. Its agentic capabilities and TypeScript-first design power our AI web research agent (Claygent) at massive scale. It's been a huge help as we build agents for sourcing, qualification, and surfacing the right accounts and prospects for our customers.”
>
> ![](images/ai-sdk-6-vercel/img_001.png)
>
> **Jeff Barg,** Clay

Today, we are releasing AI SDK 6, which introduces:

- [Agents](https://vercel.com/blog/ai-sdk-6#agents)

- [Tool Improvements](https://vercel.com/blog/ai-sdk-6#tool-improvements)

- [MCP](https://vercel.com/blog/ai-sdk-6#mcp)

- [Tool Calling with Structured Output](https://vercel.com/blog/ai-sdk-6#tool-calling-with-structured-outputs)

- [DevTools](https://vercel.com/blog/ai-sdk-6#devtools)

- [Reranking](https://vercel.com/blog/ai-sdk-6#reranking)

- [Standard JSON Schema](https://vercel.com/blog/ai-sdk-6#standard-json-schema)

- [Image Editing](https://vercel.com/blog/ai-sdk-6#image-editing)

- [Raw Finish Reason & Extended Usage](https://vercel.com/blog/ai-sdk-6#raw-finish-reason-&-extended-usage)

- [LangChain Adapter Rewrite](https://vercel.com/blog/ai-sdk-6#langchain-adapter-rewrite)

- [New Provider Tools](https://vercel.com/blog/ai-sdk-6#new-provider-tools)


Upgrading from AI SDK 5? Run `npx @ai-sdk/codemod v6` to migrate automatically with minimal code changes.

## Agents

AI SDK 6 introduces the `Agent` abstraction for building reusable agents. Define your agent once with its model, instructions, and tools, then use it across your entire application. Agents automatically integrate with the full AI SDK ecosystem, giving you type-safe UI streaming, structured outputs, and seamless framework support.

The functional approach with `generateText` and `streamText` is powerful and low-level, giving you full control regardless of scale. But when you want to reuse the same agent across different mediums (a chat UI, a background job, an API endpoint), or organize your code with tools in separate files, the inline configuration approach breaks down. You end up passing the same configuration object everywhere or building your own abstraction layer.

### ToolLoopAgent

The `ToolLoopAgent` class provides a production-ready implementation that handles the complete tool execution loop. It calls the LLM with your prompt, executes any requested tool calls, adds results back to the conversation, and repeats until complete (for up to 20 steps by default: `stopWhen: stepCountIs(20)`).

```typescript
import { ToolLoopAgent } from 'ai';

import { weatherTool } from '@/tools/weather';



export const weatherAgent = new ToolLoopAgent({

5  model: 'anthropic/claude-sonnet-4.5',

6  instructions: 'You are a helpful weather assistant.',

7  tools: {

8    weather: weatherTool,

9  },

10});



const result = await weatherAgent.generate({

13  prompt: 'What is the weather in San Francisco?',

14});
```

To learn more, check out the [Building Agents documentation](https://ai-sdk.dev/docs/agents/building-agents).

### Call Options

With call options, you can pass type-safe arguments when you call `generate` or `stream` on a ToolLoopAgent. For example, you can use them to inject retrieved documents for RAG, select models based on request complexity, or customize tool behavior per request.

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

11    ...settings,

12    instructions: `You are a helpful customer support agent.

13- User Account type: ${options.accountType}

14- User ID: ${options.userId}`,

15  }),

16});



const result = await supportAgent.generate({

19  prompt: "How do I upgrade my account?",

20  options: {

21    userId: "user_123",

22    accountType: "free",

23  },

24});
```

To learn more, check out the [Configuring Call Options documentation](https://ai-sdk.dev/docs/agents/configuring-call-options).

### Code Organization & UI Integration

The agent abstraction pushes you toward a clean separation of concerns and rewards you with end-to-end type safety. Define tools in dedicated files, compose them into agents, and expose them via API routes. The same definitions that power your agent logic also type your UI components.

```typescript
1// agents/weather-agent.ts

import { ToolLoopAgent, InferAgentUIMessage } from "ai";

import { weatherTool } from "@/tools/weather-tool";



export const weatherAgent = new ToolLoopAgent({

6  model: "anthropic/claude-sonnet-4.5",

7  instructions: "You are a helpful weather assistant.",

8  tools: { weather: weatherTool },

9});



export type WeatherAgentUIMessage = InferAgentUIMessage<typeof weatherAgent>;



13// app/api/chat/route.ts

import { createAgentUIStreamResponse } from "ai";

import { weatherAgent } from "@/agents/weather-agent";



export async function POST(request: Request) {

18  const { messages } = await request.json();

19  return createAgentUIStreamResponse({

20    agent: weatherAgent,

21    uiMessages: messages,

22  });

23}
```

On the client, types flow automatically. Import the message type from your agent file, then render typed tool components by switching on the part type.

```tsx
1// app/page.tsx

import { useChat } from '@ai-sdk/react';

import type { WeatherAgentUIMessage } from '@/agents/weather-agent';

import { WeatherToolView } from '@/components/weather-tool-view';



export default function Chat() {

7  const { messages, sendMessage } = useChat<WeatherAgentUIMessage>();

8  return (

9    <div>

10      {messages.map((message) =>

11        message.parts.map((part) => {

12          switch (part.type) {

13            case 'tool-weather':

14              return <WeatherToolView invocation={part} />;

15          }

16        })

17      )}

18    </div>

19  );

20}



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

Define once, use everywhere. The same tool definition powers your agent logic, API responses, and UI components.

To learn more, check out the [Agents documentation](https://ai-sdk.dev/docs/agents).

### Custom Agent Implementations

In AI SDK 6, `Agent` is an interface rather than a class. While `ToolLoopAgent` provides a solid default implementation for most use cases, you can implement the `Agent` interface to build your own agent abstractions for your needs.

One such example is [Workflow DevKit](https://useworkflow.dev/), which provides [`DurableAgent`](https://useworkflow.dev/docs/api-reference/workflow-ai/durable-agent). It makes your agents production-ready by turning them into durable, resumable workflows where each tool execution becomes a retryable, observable step.

```typescript
import { getWritable } from 'workflow';

import { DurableAgent } from '@workflow/ai/agent';

import { searchFlights, bookFlight, getFlightStatus } from './tools';



export async function flightBookingWorkflow() {

6  'use workflow';



8  const flightAgent = new DurableAgent({

9    model: 'anthropic/claude-sonnet-4.5',

10    system: 'You are a flight booking assistant.',

11    tools: {

12      searchFlights,

13      bookFlight,

14      getFlightStatus,

15    },

16  });



18  const result = await flightAgent.generate({

19    prompt: 'Find me a flight from NYC to London next Friday.',

20    writable: getWritable(),

21  });

22}
```

Learn more in the [Building Durable Agents documentation](https://useworkflow.dev/docs/ai).

## Tool Improvements

Tools are the foundation of your agents' capabilities. An agent's ability to take meaningful actions depends entirely on how reliably it can generate valid tool inputs, how well those inputs align with your intent, how efficiently tool outputs can be represented as tokens in the conversation, and how safely those tools can execute in production environments.

AI SDK 6 improves each of these areas: tool execution approval for human-in-the-loop control, strict mode for more reliable input generation, input examples for better alignment, and `toModelOutput` for flexible tool outputs.

### Tool Execution Approval

Building agents that can take real-world actions (deleting files, processing payments, modifying production data) requires a critical safety layer: human approval. Without it, you're blindly trusting the agent on every decision.

In AI SDK 6, you get human-in-the-loop control with a single `needsApproval` flag, no custom code required. See this feature in action with the [Chat SDK](https://chat-sdk.dev/), an open-source template for building chatbot applications.

By default, tools run automatically when the model calls them. Set `needsApproval: true` to require approval before execution:

```typescript
import { tool } from 'ai';

import { z } from 'zod';



export const runCommand = tool({

5  description: 'Run a shell command',

6  inputSchema: z.object({

7    command: z.string().describe('The shell command to execute'),

8  }),

9  needsApproval: true, // Require user approval

10  execute: async ({ command }) => {

11    // Your command execution logic here

12  },

13});
```

Not every tool call needs approval. A simple ls command might be fine to auto-approve, but a destructive `rm -rf` command should require review. You can pass a function to `needsApproval` to decide based on the input, and store user preferences to remember approved patterns for future calls.

```typescript
import { tool } from "ai";

import { z } from "zod";



const runCommand = tool({

5  description: "Run a shell command",

6  inputSchema: z.object({

7    command: z.string().describe("The shell command to execute"),

8  }),

9  needsApproval: async ({ command }) => command.includes("rm -rf"),

10  execute: async ({ command }) => {

11    /* command execution logic */

12  },

13});
```

Handling approval in your UI is straightforward with `useChat`. Check the tool invocation state, prompt the user, and return a response with `addToolApprovalResponse`:

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

11  if (invocation.state === 'approval-requested') {

12    return (

13      <div>

14        <p>Run command: {invocation.input.command}?</p>

15        <button

16          onClick={() =>

17            addToolApprovalResponse({

18              id: invocation.approval.id,

19              approved: true,

20            })

21          }

22        >

23          Approve

24        </button>

25        <button

26          onClick={() =>

27            addToolApprovalResponse({

28              id: invocation.approval.id,

29              approved: false,

30            })

31          }

32        >

33          Deny

34        </button>

35      </div>

36    );

37  }



39  if (invocation.state === 'output-available') {

40    return <div>Output: {invocation.output}</div>;

41  }



43  // Handle other states...

44}


```

To learn more, check out the [Tool Execution Approval documentation](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling#tool-execution-approval).

### Strict Mode

When available, native strict mode from language model providers guarantees that tool call inputs match your schema exactly. However, some providers only support subsets of the JSON schema specification in strict mode. If any tool in your request uses an incompatible schema feature, the entire request fails.

AI SDK 6 makes strict mode opt-in per tool. Use strict mode for tools with compatible schemas and regular mode for others, all in the same call.

```typescript
tool({

2  description: 'Get the weather in a location',

3  inputSchema: z.object({

4    location: z.string(),

5  }),

6  strict: true, // Enable strict validation for this tool

7  execute: async ({ location }) => ({

8    // ...

9  }),

10});
```

### Input Examples

Complex tool schemas with nested objects, specific formatting requirements, or domain-specific patterns can be difficult to describe clearly through tool descriptions alone. Even with detailed per-field descriptions, models sometimes generate inputs that are technically valid but don't match your expected patterns.

Input examples show the model concrete instances of correctly structured input, clarifying expectations that are hard to express in schema descriptions:

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

Input examples are currently only natively supported by Anthropic. For providers that don't support them, you can use [`addToolInputExamplesMiddleware`](https://ai-sdk.dev/docs/ai-sdk-core/middleware#add-tool-input-examples) to append the examples to the tool description. If no middleware is used and the provider doesn't support input examples, they are ignored and not sent to the provider.

### Send Custom Tool Output to the Model

By default, whatever you return from your tool's `execute` function is sent to the model in subsequent turns as stringified JSON. However, when tools return large text outputs (file contents, search results) or binary data (screenshots, generated images), you end up sending thousands of unnecessary tokens or awkwardly encoding images as base64 strings.

The `toModelOutput` function separates what your tool result from what you send to the model. Return complete data from `execute` function for your application logic, then use `toModelOutput` to control exactly what tokens go back to the model:

```typescript
import { tool } from "ai";

import { z } from "zod";



const weatherTool = tool({

5  description: "Get the weather in a location",

6  inputSchema: z.object({

7    location: z.string().describe("The location to get the weather for"),

8  }),

9  execute: ({ location }) => ({

10    temperature: 72 + Math.floor(Math.random() * 21) - 10,

11  }),

12  // toModelOutput can be sync or async

13  toModelOutput: async ({ input, output, toolCallId }) => {

14    // many other options, including json, multi-part with files and images, etc.

15    // (support depends on provider)

16    // example: send tool output as a text

17    return {

18      type: "text",

19      value:

20        `The weather in ${input.location} is ${output.temperature}°F.`,

21    };

22  },

23});
```

To learn more, check out the [Tool Calling documentation](https://ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling).

## MCP

AI SDK 6 extends our MCP support to cover OAuth authentication, resources, prompts, and elicitation. You can now expose data through resources, create reusable prompt templates, and handle server-initiated requests for user input. It is now stable and available in the `@ai-sdk/mcp` package.

### HTTP Transport

To connect to a remote MCP server, you configure an HTTP transport with your server URL and authentication headers:

```typescript
import { createMCPClient } from '@ai-sdk/mcp';



const mcpClient = await createMCPClient({

4  transport: {

5    type: 'http',

6    url: '<https://your-server.com/mcp>',

7    headers: { Authorization: 'Bearer my-api-key' },

8  },

9});



const tools = await mcpClient.tools();
```

### OAuth Authentication

Remote MCP servers often require authentication, especially hosted services that access user data or third-party APIs. Implementing OAuth correctly means handling PKCE challenges, token refresh, dynamic client registration, and retry logic when tokens expire mid-session. Getting any of this wrong breaks your integration.

AI SDK 6 handles the complete OAuth flow for you:

```typescript
import { createMCPClient, auth, OAuthClientProvider } from "@ai-sdk/mcp";



const authProvider: OAuthClientProvider = {

4  redirectUrl: "http://localhost:3000/callback",

5  clientMetadata: {

6    client_name: "My App",

7    redirect_uris: ["http://localhost:3000/callback"],

8    grant_types: ["authorization_code", "refresh_token"],

9  },

10  // Token and credential storage methods

11  tokens: async () => { /* ... */ },

12  saveTokens: async (tokens) => { /* ... */ },

13  // ... remaining OAuthClientProvider configuration

14};



await auth(authProvider, { serverUrl: new URL("https://mcp.example.com") });



const client = await createMCPClient({

19  transport: { type: "http", url: "https://mcp.example.com", authProvider },

20});
```

### Resources and Prompts

MCP servers can expose data through resources (files, database records, API responses) that your application can discover and read. Prompts provide reusable templates from the server, complete with parameters you fill in at runtime:

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

11  arguments: { code: "function add(a, b) { return a + b; }" },

12});
```

### Elicitation Support

Sometimes an MCP server needs user input mid-operation (a confirmation, a choice between options, or additional context). Elicitation lets the server request this input while your application handles gathering it:

```typescript
const mcpClient = await createMCPClient({

2  transport: { type: 'sse', url: '<https://your-server.com/sse>' },

3  capabilities: { elicitation: {} },

4});



mcpClient.onElicitationRequest(ElicitationRequestSchema, async request => {

7  const userInput = await getInputFromUser(

8    request.params.message,

9    request.params.requestedSchema,

10  );



12  return {

13    action: 'accept',

14    content: userInput,

15  };

16});


```

To learn more, check out the [MCP Tools documentation](https://ai-sdk.dev/docs/ai-sdk-core/mcp-tools).

## Tool Calling with Structured Output

Previously, combining tool calling with structured output required chaining `generateText` and `generateObject` together. AI SDK 6 unifies `generateObject` and `generateText` to enable multi-step tool calling loops with structured output generation at the end.

```typescript
import { Output, ToolLoopAgent, tool } from "ai";

import { z } from "zod";



const agent = new ToolLoopAgent({

5  model: "anthropic/claude-sonnet-4.5",

6  tools: {

7    weather: tool({

8      description: "Get the weather in a location",

9      inputSchema: z.object({ city: z.string() }),

10      execute: async ({ city }) => {

11        // ...

12      },

13    }),

14  },

15  output: Output.object({

16    schema: z.object({

17      summary: z.string(),

18      temperature: z.number(),

19      recommendation: z.string(),

20    }),

21  }),

22});



const { output } = await agent.generate({

25  prompt: "What is the weather in San Francisco and what should I wear?",

26});
```

### Output Types

Structured output supports several formats. Use the `Output` object to specify what shape you need:

- **`Output.object()`**: Generate structured objects

- **`Output.array()`**: Generate arrays of structured objects

- **`Output.choice()`**: Select from a specific set of options

- **`Output.json()`**: Generate unstructured JSON

- **`Output.text()`**: Generate plain text (default behavior)


To learn more, check out the [Generating Structured Data documentation](https://ai-sdk.dev/docs/ai-sdk-core/generating-structured-data).

## DevTools

Debugging multi-step agent flows is difficult. A small change in context or input tokens at one step can meaningfully change that step's output, which changes the input to the next step, and so on. By the end, the trajectory is completely different, and tracing back to what caused it means manually logging each step and piecing together the sequence yourself.

![](images/ai-sdk-6-vercel/img_002.jpg)

AI SDK DevTools gives you full visibility into your LLM calls and agents. Inspect each step of any call, including input, output, model configuration, token usage, timing, and raw provider requests and responses.

### Setup

To get started, wrap your model with the `devToolsMiddleware`:

```typescript
import { wrapLanguageModel, gateway } from 'ai';

import { devToolsMiddleware } from '@ai-sdk/devtools';



const devToolsEnabledModel = wrapLanguageModel({

5  model: gateway('anthropic/claude-sonnet-4.5'),

6  middleware: devToolsMiddleware(),

7});
```

Then use it with any AI SDK function:

```typescript
import { generateText } from 'ai';



const result = await generateText({

4  model: devToolsEnabledModel,

5  prompt: 'What is love?',

6});
```

### Inspecting Your Runs

Launch the viewer with `npx @ai-sdk/devtools` and open [http://localhost:4983](http://localhost:4983/) to inspect your runs. You'll be able to see:

![](images/ai-sdk-6-vercel/img_003.jpg)

- **Input parameters and prompts**: View the complete input sent to your LLM

- **Output content and tool calls**: Inspect generated text and tool invocations

- **Token usage and timing**: Monitor resource consumption and performance

- **Raw provider data**: Access complete request and response payloads


To learn more, check out the [DevTools](https://ai-sdk.dev/docs/ai-sdk-core/devtools) documentation.

## Reranking

Providing relevant context to a language model isn't just about retrieving everything that might be related. Models perform better with focused, highly relevant context. Reranking reorders search results based on their relevance to a specific query, letting you pass only the most relevant documents to the model.

AI SDK 6 adds native support for reranking with the new `rerank` function:

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

Reranking also supports structured documents, making it ideal for searching through databases, emails, or other structured content:

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



const { rerankedDocuments } = await rerank({

14  model: cohere.reranking('rerank-v3.5'),

15  documents,

16  query: 'Which pricing did we get from Oracle?',

17  topN: 1,

18});
```

The `rerank` function currently supports Cohere, Amazon Bedrock, and [Together.ai](http://together.ai/).

To learn more, check out the [Reranking documentation](https://ai-sdk.dev/docs/ai-sdk-core/reranking).

## Standard JSON Schema

AI SDK 6 adds support for any schema library that implements the [Standard JSON Schema](https://standardschema.dev/json-schema) interface. Previously, the SDK required built-in converters for each schema library (Arktype, Valibot). Now, any library implementing the Standard JSON Schema V1 specification works automatically without additional SDK changes.

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

11        steps: 'string[]',

12      },

13    }),

14  }),

15  prompt: 'Generate a lasagna recipe.',

16});
```

To learn more, check out the [Tools documentation](https://ai-sdk.dev/docs/foundations/tools).

## Provider Tools

AI SDK 6 expands support for provider-specific tools that leverage unique platform capabilities and model-trained functionality. These tools are designed to work with specific models or platforms (such as web search, code execution, and memory management) where providers have optimized their models for these capabilities or offer platform-specific features that aren't available elsewhere.

### Anthropic Provider Tools

- Memory Tool: Store and retrieve information across conversations through a memory file directory

- Tool Search (Regex): Search and select tools dynamically using regex patterns

- Tool Search (BM25): Search and select tools using natural language queries

- Code Execution Tool: Run code in a secure sandboxed environment with bash and file operations


```typescript
import { anthropic } from "@ai-sdk/anthropic";



3// Memory Tool - store and retrieve information

const memory = anthropic.tools.memory_20250818({

5  execute: async (action) => {

6    // Implement memory storage logic

7    // Supports: view, create, str_replace, insert, delete, rename

8  },

9});



11// Tool Search (Regex) - find tools by pattern

const toolSearchRegex = anthropic.tools.toolSearchRegex_20251119();



14// Tool Search (BM25) - find tools with natural language

const toolSearchBm25 = anthropic.tools.toolSearchBm25_20251119();



17// Code Execution Tool - run code in sandbox

const codeExecution = anthropic.tools.codeExecution_20250825();
```

AI SDK 6 also adds support for [programmatic tool calling](https://www.anthropic.com/engineering/advanced-tool-use#programmatic-tool-calling), which allows Claude to call your tools from a code execution environment, keeping intermediate results out of context. This can significantly reduce token usage and cost.

Mark tools as callable from code execution with `allowedCallers`, and use `prepareStep` to preserve the container across steps:

```typescript
import {

2  anthropic,

3  forwardAnthropicContainerIdFromLastStep,

4} from "@ai-sdk/anthropic";



const getWeather = tool({

7  description: "Get weather for a city.",

8  inputSchema: z.object({ city: z.string() }),

9  execute: async ({ city }) => ({ temp: 22 }),

10  providerOptions: {

11    anthropic: { allowedCallers: ["code_execution_20250825"] },

12  },

13});





const result = await generateText({

17  model: anthropic("claude-sonnet-4-5"),

18  tools: {

19    code_execution: anthropic.tools.codeExecution_20250825(),

20    getWeather,

21  },

22  prepareStep: forwardAnthropicContainerIdFromLastStep,

23});
```

To learn more, check out [the Anthropic documentation](https://ai-sdk.dev/providers/ai-sdk-providers/anthropic).

### OpenAI Provider Tools

- Shell Tool: Execute shell commands with timeout and output limits

- Apply Patch Tool: Create, update, and delete files using structured diffs

- MCP Tool: Connect to remote Model Context Protocol servers


```typescript
import { openai } from "@ai-sdk/openai";



3// Shell Tool - execute shell commands

const shell = openai.tools.shell({

5  execute: async ({ action }) => {

6    // action.commands: string[] - commands to execute

7    // action.timeoutMs: optional timeout

8    // action.maxOutputLength: optional max chars to return

9  },

10});



12// Apply Patch Tool - file operations with diffs

const applyPatch = openai.tools.applyPatch({

14  execute: async ({ callId, operation }) => {

15    // operation.type: 'create_file' | 'update_file' | 'delete_file'

16    // operation.path: file path

17    // operation.diff: diff content (for create/update)

18  },

19});



21// MCP Tool - connect to MCP servers

const mcp = openai.tools.mcp({

23  serverLabel: "my-mcp-server",

24  serverUrl: "[https://mcp.example.com](https://mcp.example.com/)",

25  allowedTools: ["tool1", "tool2"],

26});
```

To learn more, check out [the OpenAI documentation](https://ai-sdk.dev/providers/ai-sdk-providers/openai).

### Google Provider Tools

- Google Maps Tool: Enable location-aware responses with Maps grounding (Gemini 2.0+)

- Vertex RAG Store Tool: Retrieve context from Vertex AI RAG Engine corpora (Gemini 2.0+)

- File Search Tool: Semantic and keyword search in file search stores (Gemini 2.5+)


```typescript
import { google } from "@ai-sdk/google";



3// Google Maps Tool - location-aware grounding

const googleMaps = google.tools.googleMaps();



6// Vertex RAG Store Tool - retrieve from RAG corpora

const vertexRagStore = google.tools.vertexRagStore({

8  ragCorpus: "projects/{project}/locations/{location}/ragCorpora/{rag_corpus}",

9  topK: 5, // optional: number of contexts to retrieve

10});



12// File Search Tool - search in file stores

const fileSearch = google.tools.fileSearch({

14  fileSearchStoreNames: ["fileSearchStores/my-store-123"],

15  topK: 10, // optional: number of chunks to retrieve

16  metadataFilter: "author=John Doe", // optional: AIP-160 filter

17});
```

To learn more, check out [the Google documentation](https://ai-sdk.dev/providers/ai-sdk-providers/google-generative-ai).

### xAI Provider Tools

- Web Search: Search the web with domain filtering and image understanding

- X Search: Search X (Twitter) posts with handle and date filtering

- Code Execution: Run code in a sandboxed environment

- View Image: Analyze and describe images

- View X Video: Analyze X video content


```typescript
import { xai } from "@ai-sdk/xai";



3// Web Search Tool - search the web

const webSearch = xai.tools.webSearch({

5  allowedDomains: [\
\
6    "[wikipedia.org](http://wikipedia.org/)",\
\
7    "[github.com](http://github.com/)",\
\
8  ], // optional: max 5

9  excludedDomains: ["[example.com](http://example.com/)"], // optional: max 5

10  enableImageUnderstanding: true, // optional

11});



13// X Search Tool - search X posts

const xSearch = xai.tools.xSearch({

15  allowedXHandles: ["elonmusk", "xai"], // optional: max 10

16  fromDate: "2025-01-01", // optional

17  toDate: "2025-12-31", // optional

18  enableImageUnderstanding: true, // optional

19  enableVideoUnderstanding: true, // optional

20});



22// Code Execution Tool - run code

const codeExecution = xai.tools.codeExecution();



25// View Image Tool - analyze images

const viewImage = xai.tools.viewImage();



28// View X Video Tool - analyze X videos

const viewXVideo = xai.tools.viewXVideo();
```

To learn more, check out [the xAI documentation](https://ai-sdk.dev/providers/ai-sdk-providers/xai).

## Image Editing

Image generation models are increasingly capable of more than just text-to-image generation. Many now support image-to-image operations like inpainting, outpainting, style transfer, and more.

AI SDK 6 extends `generateImage` to support image editing by accepting reference images alongside your text prompt:

```typescript
import { generateImage } from "ai";

import { blackForestLabs } from "@ai-sdk/black-forest-labs";



const { images } = await generateImage({

5  model: blackForestLabs.image("flux-2-pro"),

6  prompt: {

7    text: "Edit this to make it two tanukis on a date",

8    images: ["https://www.example.com/tanuki.png"],

9  },

10});
```

!["Edit this to make it two tanukis on a date"](images/ai-sdk-6-vercel/img_004.jpg)"Edit this to make it two tanukis on a date"

Reference images can be provided as URL strings, base64-encoded strings, Uint8Array, ArrayBuffer, or Buffer.

Note: `experimental_generateImage` has been promoted to stable and renamed to `generateImage`.

Check out [the Image Generation documentation](https://ai-sdk.dev/docs/ai-sdk-core/image-generation) to learn more.

## Raw Finish Reason & Extended Usage

AI SDK 6 improves visibility into model responses with raw finish reasons and restructured usage information.

### Raw Finish Reason

When providers add new finish reasons that the AI SDK doesn't recognize, they previously appeared as `'other'`. Now, `rawFinishReason` exposes the exact string from the provider, letting you handle provider-specific cases before AI SDK updates.

```typescript
const { finishReason, rawFinishReason } = await generateText({

2  model: 'anthropic/claude-sonnet-4.5',

3  prompt: 'What is love?',

4});



6// finishReason: 'other' (mapped)

7// rawFinishReason: 'end_turn' (provider-specific)
```

This is useful when providers have multiple finish reasons that map to a single AI SDK value, or when you need to distinguish between specific provider behaviors.

### Extended Usage Information

Usage reporting now includes detailed breakdowns for both input and output tokens:

```typescript
const { usage } = await generateText({

2  model: 'anthropic/claude-sonnet-4.5',

3  prompt: 'What is love?',

4});



6// Input token details

usage.inputTokenDetails.noCacheTokens;    // Non-cached input tokens

usage.inputTokenDetails.cacheReadTokens;  // Tokens read from cache

usage.inputTokenDetails.cacheWriteTokens; // Tokens written to cache



11// Output token details

usage.outputTokenDetails.textTokens;      // Text generation tokens

usage.outputTokenDetails.reasoningTokens; // Reasoning tokens (where supported)



15// Raw provider usage

usage.raw; // Complete provider-specific usage object
```

These detailed breakdowns give you the visibility you need to optimize costs and debug token usage across providers.

## LangChain Adapter Rewrite

The `@ai-sdk/langchain` package has been rewritten to support modern LangChain and LangGraph features. New APIs include `toBaseMessages()` for converting UI messages to LangChain format, `toUIMessageStream()` for transforming LangGraph event streams, and `LangSmithDeploymentTransport` for browser-side connections to LangSmith deployments. The adapter now supports tool calling with partial input streaming, reasoning blocks, and Human-in-the-Loop workflows via LangGraph interrupts.

```typescript
import { toBaseMessages, toUIMessageStream } from '@ai-sdk/langchain';

import { createUIMessageStreamResponse } from 'ai';



const langchainMessages = await toBaseMessages(messages);

const stream = await graph.stream({ messages: langchainMessages });



return createUIMessageStreamResponse({

8  stream: toUIMessageStream(stream),

9});
```

This release is fully backwards compatible. To learn more, check out the [LangChain Adapter](https://ai-sdk.dev/providers/adapters/langchain) documentation.

## Migrating to AI SDK 6

AI SDK 6 is a major version due to the introduction of the v3 Language Model Specification that powers new capabilities like agents and tool approval. However, unlike AI SDK 5, this release is not expected to have major breaking changes for most users.

The version bump reflects improvements to the specification, not a complete redesign of the SDK. If you're using AI SDK 5, migrating to v6 should be straightforward with minimal code changes.

```bash
npx @ai-sdk/codemod upgrade v6
```

For a detailed overview of all changes and manual steps that might be needed, refer to our [AI SDK 6 migration guide](https://v6.ai-sdk.dev/docs/migration-guides/migration-guide-6-0). The guide includes step-by-step instructions and examples to ensure a smooth update.

## Getting started

> “I’m super hyped for v6. The move from streamText to composable agents is tasteful, and so are the new APIs around type-safety, MCP, and agent preparation. The amount of care the team has put into API design is wild.I’m super hyped for v6. The move from streamText to composable agents is tasteful, and so are the new APIs around type-safety, MCP, and agent preparation. The amount of care the team has put into API design is wild.”
>
> ![](images/ai-sdk-6-vercel/img_005.png)
>
> **Josh,** Upstash

With powerful new capabilities like the `ToolLoopAgent`, human-in-the-loop tool approval, stable structured outputs with tool calling, and DevTools for debugging, there's never been a better time to start building AI applications with the AI SDK.

- **Start a new AI project**: Get up and running with our latest guides for Next.js, React, Svelte, and more. Check out our latest guides.

- **Explore our templates**: Visit our Template Gallery for production-ready starter projects.

- **Migrate to v6**: Use our automated codemod for a smooth transition. Our comprehensive [Migration Guide](https://v6.ai-sdk.dev/docs/migration-guides/migration-guide-6-0) covers all breaking changes.

- **Try DevTools**: Debug your AI applications with full visibility into LLM calls. Check out the DevTools documentation.

- **Join the community**: Share what you're building, ask questions, and connect with other developers in our GitHub Discussions.


## Contributors

AI SDK 6 is the result of the combined work of our core team at Vercel (Gregor, Lars, Aayush, Josh, Nico) and our amazing community of contributors:

[viktorlarsson](https://github.com/viktorlarsson), [shaper](https://github.com/shaper), [AVtheking](https://github.com/AVtheking), [SamyPesse](https://github.com/SamyPesse), [firemoonai](https://github.com/firemoonai), [seldo](https://github.com/seldo), [R-Taneja](https://github.com/R-Taneja), [ZiuChen](https://github.com/ZiuChen), [gaspar09](https://github.com/gaspar09), [christian-bromann](https://github.com/christian-bromann), [jeremyphilemon](https://github.com/jeremyphilemon), [DaniAkash](https://github.com/DaniAkash), [a-tokyo](https://github.com/a-tokyo), [rohrz4nge](https://github.com/rohrz4nge), [EwanTauran](https://github.com/EwanTauran), [codicecustode](https://github.com/codicecustode), [shubham-021](https://github.com/shubham-021), [kkawamu1](https://github.com/kkawamu1), [mclenhard](https://github.com/mclenhard), [gdaybrice](https://github.com/gdaybrice), [dyh-sjtu](https://github.com/dyh-sjtu), [blurrah](https://github.com/blurrah), [EurFelux](https://github.com/EurFelux), [AryanBagade](https://github.com/AryanBagade), [Omcodes23](https://github.com/Omcodes23), [jeffcarbs](https://github.com/jeffcarbs), [codeyogi911](https://github.com/codeyogi911), [zirkelc](https://github.com/zirkelc), [qkdreyer](https://github.com/qkdreyer), [tsuzaki430](https://github.com/tsuzaki430), [qchuchu](https://github.com/qchuchu), [karthikscale3](https://github.com/karthikscale3), [alex-deneuvillers](https://github.com/alex-deneuvillers), [kesku](https://github.com/kesku), [yorkeccak](https://github.com/yorkeccak), [guy-hartstein](https://github.com/guy-hartstein), [Und3rf10w](https://github.com/Und3rf10w), [siwachabhi](https://github.com/siwachabhi), [homanp](https://github.com/homanp), [tengis617](https://github.com/tengis617), [SalvatoreAmoroso](https://github.com/SalvatoreAmoroso), [ericciarla](https://github.com/ericciarla), [baturyilmaz](https://github.com/baturyilmaz), [chentsulin](https://github.com/chentsulin), [kovereduard](https://github.com/kovereduard), [yaonyan](https://github.com/yaonyan), [mwln](https://github.com/mwln), [IdoBouskila](https://github.com/IdoBouskila), [wangyedev](https://github.com/wangyedev), [rubnogueira](https://github.com/rubnogueira), [Emmaccen](https://github.com/Emmaccen), [priyanshusaini105](https://github.com/priyanshusaini105), [dpmishler](https://github.com/dpmishler), [yilinjuang](https://github.com/yilinjuang), [JulioPeixoto](https://github.com/JulioPeixoto), [DeJeune](https://github.com/DeJeune), [BangDori](https://github.com/BangDori), [shadowssdt](https://github.com/shadowssdt), [efantasia](https://github.com/efantasia), [kevinjosethomas](https://github.com/kevinjosethomas), [lukehrucker](https://github.com/lukehrucker), [Mohammedsinanpk](https://github.com/Mohammedsinanpk), [danielamitay](https://github.com/danielamitay), [davidsonsns](https://github.com/davidsonsns), [teeverc](https://github.com/teeverc), [MQ37](https://github.com/MQ37), [jephal](https://github.com/jephal), [TimPietrusky](https://github.com/TimPietrusky), [theishangoswami](https://github.com/theishangoswami), [juliettech13](https://github.com/juliettech13), [shelleypham](https://github.com/shelleypham), [tconley1428](https://github.com/tconley1428), [goyalshivansh2805](https://github.com/goyalshivansh2805), [KirschX](https://github.com/KirschX), [neallseth](https://github.com/neallseth), [jltimm](https://github.com/jltimm), [rahulbhadja](https://github.com/rahulbhadja), [tayyab3245](https://github.com/tayyab3245), [cwtuan](https://github.com/cwtuan), [titouv](https://github.com/titouv), [dylan-duan-aai](https://github.com/dylan-duan-aai), [bel0v](https://github.com/bel0v), [josh-williams](https://github.com/josh-williams), [amyegan](https://github.com/amyegan), [samjbobb](https://github.com/samjbobb), [teunlao](https://github.com/teunlao), [dylanmoz](https://github.com/dylanmoz), [0xlakshan](https://github.com/0xlakshan), [patelvivekdev](https://github.com/patelvivekdev), [nvie](https://github.com/nvie), [nlaz](https://github.com/nlaz), [drew-foxall](https://github.com/drew-foxall), [dannyroosevelt](https://github.com/dannyroosevelt), [Diluka](https://github.com/Diluka), [AlexKer](https://github.com/AlexKer), [YosefLm](https://github.com/YosefLm), [YutoKitano13](https://github.com/YutoKitano13), [SarityS](https://github.com/SarityS), [jonaslalin](https://github.com/jonaslalin), [tobiasbueschel](https://github.com/tobiasbueschel), [dhofheinz](https://github.com/dhofheinz), [ethshea](https://github.com/ethshea), [ellis-driscoll](https://github.com/ellis-driscoll), [marcbouchenoire](https://github.com/marcbouchenoire), [shin-sakata](https://github.com/shin-sakata), [ellispinsky](https://github.com/ellispinsky), [DDU1222](https://github.com/DDU1222), [ci](https://github.com/ci), [tomsseisums](https://github.com/tomsseisums), [kpman](https://github.com/kpman), [juanuicich](https://github.com/juanuicich), [A404coder](https://github.com/A404coder), [tamarshe-dev](https://github.com/tamarshe-dev), [crishoj](https://github.com/crishoj), [kevint-cerebras](https://github.com/kevint-cerebras), [arjunkmrm](https://github.com/arjunkmrm), [Barbapapazes](https://github.com/Barbapapazes), [nimeshnayaju](https://github.com/nimeshnayaju), [lewwolfe](https://github.com/lewwolfe), [sergical](https://github.com/sergical), [tomerigal](https://github.com/tomerigal), [huanshenyi](https://github.com/huanshenyi), [horita-yuya](https://github.com/horita-yuya), [rbadillap](https://github.com/rbadillap), [syeddhasnainn](https://github.com/syeddhasnainn), [Dhravya](https://github.com/Dhravya), [jagreehal](https://github.com/jagreehal), [Mintnoii](https://github.com/Mintnoii), [mhodgson](https://github.com/mhodgson), [amardeeplakshkar](https://github.com/amardeeplakshkar), [aron](https://github.com/aron), [TooTallNate](https://github.com/TooTallNate), [Junyi-99](https://github.com/Junyi-99), [princejoogie](https://github.com/princejoogie), [iiio2](https://github.com/iiio2), [MonkeyLeeT](https://github.com/MonkeyLeeT), [joshualipman123](https://github.com/joshualipman123), [andrewdoro](https://github.com/andrewdoro), [fveiraswww](https://github.com/fveiraswww), [HugoRCD](https://github.com/HugoRCD), [rockingrohit9639](https://github.com/rockingrohit9639)

Your feedback, bug reports, and pull requests on GitHub have been instrumental in shaping this release. We're excited to see what you'll build with these new capabilities.