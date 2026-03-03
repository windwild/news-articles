---
title: "AI SDK 5 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-5"
date: "2025-07-31"
scraped_at: "2026-03-02T09:30:39.291328713+00:00"
language: "en"
translated: false
description: "Introducing type-safe chat, agentic loop control, new specification, tool enhancements,  speech generation, and more."
---




Jul 31, 2025

Introducing type-safe chat and agentic loop control for full-stack AI applications

With over 2 million weekly downloads, the [AI SDK](https://v5.ai-sdk.dev/) is the leading open-source AI application toolkit for TypeScript and JavaScript. Its unified provider API allows you to use any language model and enables powerful integrations into leading web frameworks.

> “When customers ask how they should build their agents, I always say the AI SDK. The industry is moving really fast and everything is changing constantly. The AI SDK is the only perfect abstraction I've seen so far. v5 continues that track record. You can tell it was built by people that are obsessed with Typescript. Everything feels right.When customers ask how they should build their agents, I always say the AI SDK. The industry is moving really fast and everything is changing constantly. The AI SDK is the only perfect abstraction I've seen so far. v5 continues that track record. You can tell it was built by people that are obsessed with Typescript. Everything feels right.”
>
> ![](images/ai-sdk-5-vercel/img_001.jpg)
>
> **Ben Hylak,** raindrop.ai

Building applications with TypeScript means building applications for the web. Today, we are releasing AI SDK 5, the first AI framework with a fully typed and highly customizable chat integration for React, Svelte, Vue and Angular.

AI SDK 5 introduces:

- [**Redesigned Chat**](https://vercel.com/blog/ai-sdk-5#redesigned-chat)

- [**Agentic Loop Control**](https://vercel.com/blog/ai-sdk-5#agentic-loop-control)

- [**Speech Generation & Transcription**](https://vercel.com/blog/ai-sdk-5#experimental-speech-generation-&-transcription)

- [**Tool Improvements**](https://vercel.com/blog/ai-sdk-5#tool-improvements)

- [**V2 Specifications**](https://vercel.com/blog/ai-sdk-5#v2-specifications)

- [**Global Provider**](https://vercel.com/blog/ai-sdk-5#global-provider)

- [**Access Raw Responses**](https://vercel.com/blog/ai-sdk-5#access-raw-responses)

- [**Zod 4 Support**](https://vercel.com/blog/ai-sdk-5#zod-4-support)


Let’s "dive" into the details.

## Redesigned Chat

With AI SDK 5, we've rebuilt chat from the ground up. We took the powerful primitives that developers love for working with LLMs and built a world-class UI integration on top, with end-to-end type safety across your entire application. From server to the client, every piece of data, tool call, and metadata is fully typed. This represents the next evolution of AI libraries for the web.

### Separate UI and Model Messages

One of the biggest challenges developers faced with previous versions of the AI SDK was managing different message types and figuring out how to properly persist chat history.

This was a core consideration in rebuilding `useChat`, which led to the creation of distinct types of messages:

- **UIMessage:** This is the _source of truth_ for your application state, containing all messages, metadata, tool results, and more. We recommend using UIMessages for persisting so that you can always restore the correct user-facing chat history.

- **ModelMessage:** This is a streamlined representation optimized for sending to language models.


We've made this distinction explicit in the API:

```tsx
1// Explicitly convert your UIMessages to ModelMessages

const uiMessages: UIMessage[] = [ /* ... */ ]

const modelMessages = convertToModelMessages(uiMessages);



const result = await streamText({

6  model: openai('gpt-4o'),

7  // Convert the rich UIMessage format to ModelMessage format

8  // This can be replaced with any function that returns ModelMessage[]

9  messages: modelMessages,

10});



12// When finished: Get the complete UIMessage array for persistence

return result.toUIMessageStreamResponse({

14  originalMessages: uiMessages,

15  onFinish: ({ messages, responseMessage }) => {

16    // Save the complete UIMessage array - your full source of truth

17    saveChat({ chatId, messages });



19    // Or save just the response message

20    saveMessage({ chatId, message: responseMessage })

21  },

22});
```

This separation between UI and model messages makes persistence straightforward. The `onFinish` callback provides all your messages in the format needed to save, with no explicit conversion required.

For complete examples of implementing message persistence with the AI SDK, check out our chatbot [persistence documentation](https://v5.ai-sdk.dev/docs/ai-sdk-ui/chatbot-message-persistence) and the [persistence template repository](https://github.com/vercel-labs/ai-sdk-persistence-db/).

### Customizable UI Messages

With AI SDK 5, you can customize the UIMessage to create your own type with the exact shape of your data, tools, and metadata, that is tailored to your application. You can pass this type as a generic argument to `createUIMessageStream` on the server and to `useChat` on the client, providing full-stack type-safety.

```tsx
1// Define your custom message type once

import { UIMessage } from 'ai';

3// ... import your tool and data part types



export type MyUIMessage = UIMessage<MyMetadata, MyDataParts, MyTools>;



7// Use it on the client

const { messages } = useChat<MyUIMessage>();



10// And use it on the server

const stream = createUIMessageStream<MyUIMessage>(/* ... */);
```

To learn more, check out the [UIMessage documentation](https://v5.ai-sdk.dev/docs/reference/ai-sdk-core/ui-message).

### Data Parts

Modern AI applications need to send more than just an LLM's plain-text response from the server to the client (e.g. anything from status updates to partial tool results). Without proper typing, streaming custom data can turn your frontend into a mess of runtime checks and type assertions. **Data parts** solve this by providing a first-class way to stream any arbitrary, type-safe data from the server to the client, ensuring your code remains maintainable as your application grows.

On the server, you can stream a data part by specifying your part type (e.g. `data-weather`) and then passing your data. You can update the same data part by specifying an ID:

```tsx
1// On the server, create a UIMessage stream

2// Typing the stream with your custom message type

const stream = createUIMessageStream<MyUIMessage>({

4  async execute({ writer }) {

5    // manually write start step if no LLM call



7    const dataPartId = 'weather-1';



9    // 1. Send the initial loading state

10    writer.write({

11      type: 'data-weather', // type-checked against MyUIMessage

12      id: dataPartId,

13      data: { city: 'San Francisco', status: 'loading' },

14    });



16    // 2. Later, update the same part (same id) with the final result

17    writer.write({

18      type: 'data-weather',

19      id: dataPartId,

20      data: { city: 'San Francisco', weather: 'sunny', status: 'success' },

21    });

22  },

23});
```

On the client, you can then render this specific part. When you use the same ID, the AI SDK replaces the existing data part with the new one:

```tsx
1// On the client, data parts are fully typed

const { messages } = useChat<MyUIMessage>();

3{

4  messages.map(message =>

5    message.parts.map((part, index) => {

6      switch (part.type) {

7        case 'data-weather':

8          return (

9            <div key={index}>

10              {/* TS knows part.data has city, status, and optional weather */}

11              {part.data.status === 'loading'

12                ? `Getting weather for ${part.data.city}...`

13                : `Weather in ${part.data.city}: ${part.data.weather}`}

14            </div>

15          );

16      }

17    }),

18  );

19}
```

There are also instances where you want to send data that you do not want to persist, but use to communicate status updates, or make other changes to the UI - this is where transient data parts and the `onData` hook comes in.

Transient parts are sent to the client but not added to the message history. They are only accessible via the `onData` useChat handler:

```tsx
1// server

writer.write({

3  type: 'data-notification',

4  data: { message: 'Processing...', level: 'info' },

5  transient: true, // Won't be added to message history

6});



8// client

const [notification, setNotification] = useState();

const { messages } = useChat({

11  onData: ({ data, type }) => {

12    if (type === 'data-notification') {

13      setNotification({ message: data.message, level: data.level });

14    }

15  },

16});
```

To learn more, check out the [data parts documentation](https://v5.ai-sdk.dev/docs/ai-sdk-ui/streaming-data).

### Type-Safe Tool Invocations

Tool invocations in useChat have been redesigned with type-specific part identifiers. Each tool now creates a part type like `tool-TOOLNAME` instead of using generic `tool-invocation` parts.

AI SDK 5 builds on this foundation with three improvements:

- **Type Safety**: By defining your tools' shape within your custom message type, you get end-to-end type safety for both input (your tools' `inputSchema`) and output (your tools' `outputSchema`).

- **Automatic Input Streaming**: Tool call inputs now stream by default, providing partial updates as the model generates them.

- **Explicit Error States**: tool execution errors are limited to the tool and can be resubmitted to the LLM.


Together, these features enable you to build maintainable UIs that show users exactly what's happening throughout the tool execution process—from initial invocation through streaming updates to final results or errors:

```tsx
1// On the client, tool parts are fully typed with the new structure

const { messages } = useChat<MyUIMessage>();

3{

4  messages.map(message => (

5    <>

6      {message.parts.map(part => {

7        switch (part.type) {

8          // Static tools with specific (`tool-${toolName}`) types

9          case 'tool-getWeather':

10            // New states for streaming and error handling

11            switch (part.state) {

12              case 'input-streaming':

13                // Automatically streamed partial inputs

14                return <div>Getting weather for {part.input.location}...</div>;

15              case 'input-available':

16                return <div>Getting weather for {part.input.location}...</div>;

17              case 'output-available':

18                return <div>The weather is: {part.output}</div>;

19              case 'output-error':

20                // Explicit error state with information

21                return <div>Error: {part.errorText}</div>;

22            }

23        }

24      })}

25    </>

26  ));

27}
```

The chat also supports dynamic tools ( [more below](https://vercel.com/blog/ai-sdk-5#dynamic-tools)). Dynamic tools (e.g. tools from MCP server) are not known during development and can be rendered using the `dynamic-tool` part:

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

10              <div key={index}>

11                <h4>Tool: {part.toolName}</h4>

12                {part.state === 'input-streaming' && (

13                  <pre>{JSON.stringify(part.input, null, 2)}</pre>

14                )}

15                {part.state === 'output-available' && (

16                  <pre>{JSON.stringify(part.output, null, 2)}</pre>

17                )}

18                {part.state === 'output-error' && (

19                  <div>Error: {part.errorText}</div>

20                )}

21              </div>

22            );

23        }

24      })}

25    </>

26  ));

27}
```

To learn more, see the [dynamic tools section](https://vercel.com/blog/ai-sdk-5#dynamic-tools) below or check out the [tool calling documentation](https://v5.ai-sdk.dev/docs/ai-sdk-ui/chatbot#using-inferred-types).

### Message Metadata

For information _about_ a message, such as a timestamp, model ID, or token count, you can now attach type-safe metadata to a message. You can use it to attach metadata that is relevant to your application.

To send metadata from the server:

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

10        model: "gpt-4o",

11      };

12    }

13    if (part.type === "finish") {

14      return {

15        model: part.response.modelId,

16        totalTokens: part.totalUsage.totalTokens,

17      };

18    }

19  },

20});
```

You can then access it on the client:

```tsx
1// on the client

const { messages } = useChat<MyUIMessage>();

3{

4  messages.map(message => (

5    <div key={message.id}>

6      {/* TS knows message.metadata may have model and totalTokens */}

7      {message.metadata?.model && (

8        <span>Model: {message.metadata.model}</span>

9      )}

10      {message.metadata?.totalTokens && (

11        <span>{message.metadata.totalTokens} tokens</span>

12      )}

13    </div>

14  ));

15}
```

As you update metadata values at different points in the message lifecycle, the client always displays the most current value.

To learn more, check out the [message metadata documentation](https://v5.ai-sdk.dev/docs/ai-sdk-ui/message-metadata).

### Modular Architecture & Extensibility

The new `useChat` hook has been redesigned with modularity at its core, enabling three powerful extensibility patterns:

- **Flexible Transports:** Swap out the default `fetch`-based transport for custom implementations. Use WebSockets for real-time communication or connect directly to LLM providers without a backend for client-only applications, browser extensions, and privacy-focused use cases. To learn more, check out the [transport documentation](https://v5.ai-sdk.dev/docs/ai-sdk-ui/transport).

- **Decoupled State Management:** The hook's state is fully decoupled, allowing seamless integration with external stores like Zustand, Redux, or MobX. Share chat state across your entire application while maintaining all of `useChat`'s powerful features.

- **Framework-Agnostic Chat:** Build your own chat hooks for any framework using the exposed `AbstractChat` class. Create custom integrations while maintaining full compatibility with the AI SDK ecosystem.


### Vue, Svelte, and Angular Support

AI SDK 5 brings the redesigned chat experience to every major web framework. Vue and Svelte now have complete feature parity with React, and we've introduced support for Angular.

All frameworks now get the same powerful features: custom message types for your application's specific needs, data parts for streaming arbitrary typed data, fully typed tool invocations with automatic input streaming, and type-safe message metadata. Whether you're using `useChat` in React, Vue's composition API, Svelte's stores, or Angular's signals, you're working with the same powerful primitives and end-to-end type safety.

To learn more, check out the [Vue](https://github.com/vercel/ai/tree/main/examples/nuxt-openai), [Svelte](https://github.com/vercel/ai-chatbot-svelte), and [Angular example](https://github.com/vercel/ai/tree/main/examples/angular).

### **SSE Streaming**

The AI SDK now uses Server-Sent Events (SSE) as its standard for streaming data from the server to the client. SSE is natively supported in all major browsers and environments. This change makes our streaming protocol more robust, easier to debug with standard browser developer tools, and simpler to build upon.

## Agentic Loop Control

Building reliable AI agents requires precise control over execution flow and context. With AI SDK 5, we're introducing primitives that give you complete control over how your agents run and what context and tools they have at each step.

AI SDK 5 introduces three features for building agents:

- **stopWhen**: Define when a tool-calling loop is stopped.

- **prepareStep**: Adjust the parameters for each step

- **Agent Abstraction**: Use `generateText` and `streamText` with predefined settings


### stopWhen

When you make a request with the `generateText` and `streamText`, it runs for a single step by default. The `stopWhen` parameter transforms your single request into a tool-calling loop that will continue until:

- The `stopWhen` condition is satisfied, or

- The model generates text instead of a tool call (always a stopping condition)


Common stopping conditions include:

- **Step limit**: `stepCountIs(5)` \- run for up to 5 steps

- **Specific tool**: `hasToolCall('finalAnswer')` \- stop when a particular tool is called


```javascript
import { openai } from "@ai-sdk/openai";

import { generateText, stepCountIs, hasToolCall } from "ai";

const result = await generateText({

4  model: openai("gpt-4o"),

5  tools: {

6    /* your tools */

7  },

8  // Stop a tool-calling loop after 5 steps or;

9  // When weather tool is called

10  stopWhen: [stepCountIs(5), hasToolCall("weather")],

11});
```

### prepareStep

While `stopWhen` keeps your agent running, `prepareStep`allows you to control the settings for each step.

Before each step executes, you can adjust:

- **Messages**: Compress or filter context to stay within limits or filter out irrelevant tokens.

- **Model**: Switch between models based on task complexity.

- **System prompt**: Adapt instructions for different tasks.

- **Tools**: Enable/disable tools as needed.

- **Tool choice**: Force specific tool usage (or none) when required.


```javascript
const result = await streamText({

2  model: openai('gpt-4o'),

3  messages: convertToModelMessages(messages),

4  tools: {

5    /* Your tools */

6  },

7  prepareStep: async ({ stepNumber, messages }) => {

8    if (stepNumber === 0) {

9      return {

10        // Use a different model for the first step

11        model: openai('gpt-4o-mini'),

12        // Force a specific tool choice

13        toolChoice: { type: 'tool', toolName: 'analyzeIntent' },

14      };

15    }



17    // Compress context for longer conversations

18    if (messages.length > 10) {

19      return {

20        // use a model with a larger context window

21        model: openai('gpt-4.1'),

22        messages: messages.slice(-10),

23      };

24    }

25  },

26});
```

### Agent Abstraction

The `Agent` class provides an object-oriented approach to building agents. It doesn't add new capabilities - everything you can do with `Agent` can be done with `generateText` or `streamText`. Instead, it allows you to encapsulate your agent configuration and execution:

```javascript
import { openai } from "@ai-sdk/openai";

import { Experimental_Agent as Agent, stepCountIs } from "ai";



const codingAgent = new Agent({

5  model: openai("gpt-4o"),

6  system: "You are a coding agent. You specialise in Next.js and TypeScript.",

7  stopWhen: stepCountIs(10),

8  tools: {

9    /* Your tools */

10  },

11});



13// Calls `generateText`

const result = codingAgent.generate({

15  prompt: "Build an AI coding agent.",

16});



18// Calls `streamText`

const result = codingAgent.stream({

20  prompt: "Build an AI coding agent.",

21});
```

## Experimental Speech Generation & Transcription

AI SDK 5 extends our unified provider abstraction to speech. Just as we've done for text and image generation, we're bringing the same consistent, type-safe interface to both speech generation and transcription. Whether you're using [OpenAI](https://v5.ai-sdk.dev/providers/ai-sdk-providers/openai#speech-models), [ElevenLabs](https://v5.ai-sdk.dev/providers/ai-sdk-providers/elevenlabs#transcription-models), or [DeepGram](https://v5.ai-sdk.dev/providers/ai-sdk-providers/deepgram#transcription-models), you work with the same familiar API pattern, and can switch providers with a single line change.

```javascript
import {

2  experimental_generateSpeech as generateSpeech,

3  experimental_transcribe as transcribe,

4} from 'ai';

import { openai } from '@ai-sdk/openai';



7// Text-to-Speech: Generate audio from text

const { audio } = await generateSpeech({

9  model: openai.speech('tts-1'),

10  text: 'Hello, world!',

11  voice: 'alloy',

12});



14// Speech-to-Text: Transcribe audio to text

const { text, segments } = await transcribe({

16  model: openai.transcription('whisper-1'),

17  audio: await readFile('audio.mp3'),

18});
```

To learn more, check out the [speech](https://v5.ai-sdk.dev/docs/ai-sdk-core/speech) and [transcription](https://v5.ai-sdk.dev/docs/ai-sdk-core/transcription) documentation.

## Tool Improvements

AI SDK 5 enhances tool capabilities with comprehensive improvements including dynamic tools, provider-executed functions, lifecycle hooks, and type-safety throughout the tool calling process.

### Parameter & Result Renaming

In AI SDK 5, we've aligned our tool definition interface more closely with the Model Context Protocol (MCP) specification by renaming key concepts:

- **parameters → inputSchema**: This rename better describes the schema's purpose of validating and typing the tool's input.

- **result → output**: Similarly, tool outputs are now consistently named.


AI SDK 5 also introduces an optional `outputSchema`property, which aligns with the MCP specification and enables type-safety for client-side tool calling.

These changes make tool definitions more intuitive and consistent with emerging industry standards:

```javascript
1// Before (v4)

const weatherTool = tool({

3  name: 'getWeather',

4  parameters: z.object({ location: z.string() }),

5  execute: async ({ location }) => {

6    return `Weather in ${location}: sunny, 72°F`;

7  }

8});



10// After (v5)

const weatherTool = tool({

12  description: 'Get the weather for a location',

13  inputSchema: z.object({ location: z.string() }),

14  outputSchema: z.string(), // New in v5 (optional)

15  execute: async ({ location }) => {

16    return `Weather in ${location}: sunny, 72°F`;

17  }

18});
```

### Dynamic Tools

AI applications often need to work with tools that can't be known in advance:

- MCP (Model Context Protocol) tools without schemas

- User-defined functions loaded at runtime

- External tool providers


Dynamic tools and the `dynamicTool` function enables tools where input and output types are determined at runtime rather than at development time. Dynamic tools are separated from static tools to give you type safety and flexibility at the same time.

```javascript
import { dynamicTool } from 'ai';

import { z } from 'zod';



const customDynamicTool = dynamicTool({

5  description: 'Execute a custom user-defined function',

6  inputSchema: z.object({}),

7  // input is typed as 'unknown'

8  execute: async input => {

9    const { action, parameters } = input as any;

10    // Execute your dynamic logic

11    return {

12      result: `Executed ${action} with ${JSON.stringify(parameters)}`,

13    };

14  },

15});



const weatherTool = tool({ /* ... */ })



const result = await generateText({

20  model: 'openai/gpt-4o',

21  tools: {

22    // Static tool with known types

23    weatherTool,

24    // Dynamic tool

25    customDynamicTool,

26  },

27  onStepFinish: ({ toolCalls, toolResults }) => {

28    // Type-safe iteration

29    for (const toolCall of toolCalls) {

30      if (toolCall.dynamic) {

31        // Dynamic tool: input is 'unknown'

32        console.log('Dynamic:', toolCall.toolName, toolCall.input);

33        continue;

34      }



36      // Static tool: full type inference

37      switch (toolCall.toolName) {

38        case 'weather':

39          console.log(toolCall.input.location); // typed as string

40          break;

41      }

42    }

43  },

44});
```

To learn more, check out the [dynamic tool documentation](https://v5.ai-sdk.dev/docs/ai-sdk-core/tools-and-tool-calling#dynamic-tools).

### Provider-Executed Tools

Many AI providers have introduced provider-executed tools. When these tools are called, the provider will execute the tool and send back the tool result as part of the response (e.g. OpenAI’s web search and file search, xAI’s web search, and more).

The AI SDK now natively supports provider-executed tools, automatically appending the results to the message history without any additional configuration.

```javascript
import { openai } from '@ai-sdk/openai';

import { generateText } from 'ai';



const result = await generateText({

5  model: openai.responses('gpt-4o-mini'),

6  tools: {

7    web_search_preview: openai.tools.webSearchPreview({}),

8  },

9  // ...

10});
```

### **Tool Lifecycle Hooks**

AI SDK 5 introduces granular tool lifecycle hooks (`onInputStart`, `onInputDelta`, `onInputAvailable`) that can be paired with data parts for sending input-related information (e.g. status updates) back to the client.

```javascript
const weatherTool = tool({

2  description: 'Get the weather for a given city',

3  inputSchema: z.object({ city: z.string() }),

4  onInputStart: ({ toolCallId }) => {

5    console.log('Tool input streaming started:', toolCallId);

6  },

7  onInputDelta: ({ inputTextDelta, toolCallId }) => {

8    console.log('Tool input delta:', inputTextDelta);

9  },

10  onInputAvailable: ({ input, toolCallId }) => {

11    console.log('Tool input ready:', input);

12  },

13  execute: async ({ city }) => {

14    return `Weather in ${city}: sunny, 72°F`;

15  },

16});
```

### **Tool Provider Options**

AI SDK 5 adds support for tool-level provider options. You can use this to, for example, cache tool definitions with Anthropic for multi-step agents, reducing token usage, processing time, and costs:

```javascript
const result = await generateText({

2  model: anthropic('claude-3-5-sonnet-20240620'),

3  tools: {

4    cityAttractions: tool({

5      inputSchema: z.object({ city: z.string() }),

6      // Apply provider-specific options to individual tools

7      providerOptions: {

8        anthropic: {

9          cacheControl: { type: 'ephemeral' },

10        },

11      },

12      execute: async ({ city }) => {

13        // Implementation

14      },

15    }),

16  },

17});
```

## V2 Specifications

The foundation of the AI SDK is the specification layer, which standardizes how different language models, embeddings models, etc. plug into functions such as `streamText` . The specification layer enables the provider architecture of the AI SDK.

In AI SDK 5, we have updated all specifications to V2. These new specifications incorporate changes in the underlying API capabilities (like provider-executed tools) and have extensibility mechanisms such as provider metadata and options. They will serve as the foundation for AI SDK 5 and beyond.

To learn more about the V2 specifications, visit the [custom provider documentation](https://v5.ai-sdk.dev/providers/community-providers/custom-providers).

## Global Provider

The AI SDK 5 includes a global provider feature that allows you to specify a model using just a plain model ID string:

```javascript
import { streamText } from 'ai';



const result = await streamText({

4  model: 'openai/gpt-4o', // Uses the global provider (defaults to AI Gateway)

5  prompt: 'Invent a new holiday and describe its traditions.',

6});
```

By default, the global provider is set to the [Vercel AI Gateway](https://vercel.com/docs/ai-gateway).

### Customizing the Global Provider

You can set your own preferred global provider:

```javascript
import { openai } from '@ai-sdk/openai';

import { streamText } from 'ai';



4// Initialise once during startup:

globalThis.AI_SDK_DEFAULT_PROVIDER = openai;



7// Somewhere else in your codebase:

const result = streamText({

9  model: 'gpt-4o', // Uses OpenAI provider without prefix

10  prompt: 'Invent a new holiday and describe its traditions.',

11});
```

This simplifies provider usage and makes it easier to switch between providers without changing your model references throughout your codebase.

## Access Raw Responses

When you need full control or want to implement new features before they're officially supported, the AI SDK provides complete access to raw request and response data. This escape hatch is invaluable for debugging, implementing provider-specific features, or handling edge cases.

### Raw Streaming Chunks

With AI SDK 5, you can access the raw chunks with streamed functions as they are received from your provider:

```javascript
import { openai } from "@ai-sdk/openai";

import { streamText } from "ai";



const result = streamText({

5  model: openai("gpt-4o-mini"),

6  prompt: "Invent a new holiday and describe its traditions.",

7  includeRawChunks: true,

8});



10// Access raw chunks through fullStream

for await (const part of result.fullStream) {

12  if (part.type === "raw") {

13    // Access provider-specific data structures

14    // e.g., OpenAI's choices, usage, etc.

15    console.log("Raw chunk:", part.rawValue);

16  }

17}
```

### Request and Response Bodies

You can also access the exact request sent to the provider and the full response received:

```javascript
const result = await generateText({

2  model: openai("gpt-4o"),

3  prompt: "Write a haiku about debugging",

4});



6// Access the raw request body sent to the provider

7// See exact prompt formatting, parameters, etc.

console.log("Request:", result.request.body);



10// Access the raw response body from the provider

11// Full provider response including metadata

console.log("Response:", result.response.body);
```

## Zod 4 Support

AI SDK 5 supports Zod 4. You can use either Zod 3 or the new [Zod 4 mini](https://zod.dev/v4) schemas for input and output validation across all validation-enabled APIs.

We recommend using Zod 4 for new projects. Follow the recommendation on the [Zod v4 docs](https://zod.dev/v4/#installation).

## **Migrating to AI SDK 5**

AI SDK 5 includes breaking changes that remove deprecated APIs. We've made the migration process easier with automated migration tools. You can run our automated codemods to handle some of the changes.

```bash
npx @ai-sdk/codemod upgrade
```

For a detailed overview of all changes and manual steps that might be needed, refer to our [AI SDK 5 migration guide](https://v5.ai-sdk.dev/docs/migration-guides/migration-guide-5-0). The guide includes step-by-step instructions and examples to ensure a smooth update.

## Getting started

With redesigned chat, agentic control and a new specification, there's never been a better time to start building AI applications with the AI SDK.

- **Start a new AI project:** Ready to build something new? Check out our latest [guides](https://v5.ai-sdk.dev/).

- **Explore our templates:** Visit our [Template Gallery](https://vercel.com/templates/ai) to see the AI SDK in action.

- **Migrate to v5:** Upgrading an existing project? Our comprehensive [Migration Guide](https://v5.ai-sdk.dev/docs/migration-guides/migration-guide-5-0) and codemods are ready to help.

- **Chat SDK:** Check out [the Chat SDK open-source template](https://chat-sdk.dev/) that helps you quickly build powerful chatbot applications without starting from scratch.

- **Join the community:** Share what you're building and get help in our [GitHub Discussions](https://github.com/vercel/ai/discussions).


## Contributors

AI SDK 5 is the result of the combined work of our core team at Vercel ( [Lars](https://x.com/lgrammel), [Nico](https://x.com/nicoalbanese10), and [Josh](https://x.com/nishimiya)) and our amazing community of contributors:

[@R-Taneja](https://github.com/R-Taneja), [@danielamitay](https://github.com/danielamitay), [@Und3rf10w](https://github.com/Und3rf10w), [@kvnang](https://github.com/kvnang), [@jakesjews](https://github.com/jakesjews), [@shaper](https://github.com/shaper), [@ankrgyl](https://github.com/ankrgyl), [@gkarthi-signoz](https://github.com/gkarthi-signoz), [@bytaesu](https://github.com/bytaesu), [@ben-vargas](https://github.com/ben-vargas), [@jakobhoeg](https://github.com/jakobhoeg), [@andrico1234](https://github.com/andrico1234), [@jessevdp](https://github.com/jessevdp), [@cristiand391](https://github.com/cristiand391), [@shelleypham](https://github.com/shelleypham), [@damianstasik](https://github.com/damianstasik), [@petergoldstein](https://github.com/petergoldstein), [@lucaazalim](https://github.com/lucaazalim), [@li-kai](https://github.com/li-kai), [@remorses](https://github.com/remorses), [@Potrock](https://github.com/Potrock), [@cwgorman](https://github.com/cwgorman), [@jpdenford](https://github.com/jpdenford), [@allenzhou101](https://github.com/allenzhou101), [@jonaslalin](https://github.com/jonaslalin), [@quuu](https://github.com/quuu), [@jeremyphilemon](https://github.com/jeremyphilemon), [@jeffbarg](https://github.com/jeffbarg), [@zabealbe](https://github.com/zabealbe), [@Gaubee](https://github.com/Gaubee), [@FranciscoMoretti](https://github.com/FranciscoMoretti), [@undo76](https://github.com/undo76), [@winzamark123](https://github.com/winzamark123), [@psinha40898](https://github.com/psinha40898), [@patrickloeber](https://github.com/patrickloeber), [@iteratetograceness](https://github.com/iteratetograceness), [@gr2m](https://github.com/gr2m), [@patelvivekdev](https://github.com/patelvivekdev), [@nvti](https://github.com/nvti), [@jacoblee93](https://github.com/jacoblee93), [@AbhiPrasad](https://github.com/AbhiPrasad), [@huanshenyi](https://github.com/huanshenyi), [@DeJeune](https://github.com/DeJeune), [@tleekkul](https://github.com/tleekkul), [@albertlast](https://github.com/albertlast), [@mmstroik](https://github.com/mmstroik), [@http-samc](https://github.com/http-samc), [@QuantGeekDev](https://github.com/QuantGeekDev), [@benjamincburns](https://github.com/benjamincburns), [@chrisvariety](https://github.com/chrisvariety), [@himanshusinghs](https://github.com/himanshusinghs), [@gorango](https://github.com/gorango), [@joshualipman123](https://github.com/joshualipman123), [@abhikjain360](https://github.com/abhikjain360), [@zhm](https://github.com/zhm), [@elliott-with-the-longest-name-on-github](https://github.com/elliott-with-the-longest-name-on-github), [@samdenty](https://github.com/samdenty), [@cgoinglove](https://github.com/cgoinglove), [@minpeter](https://github.com/minpeter), [@haydenbleasel](https://github.com/haydenbleasel), [@SnehanChakravarthi](https://github.com/SnehanChakravarthi), [@Sma1lboy](https://github.com/Sma1lboy), [@faiz-gear](https://github.com/faiz-gear), [@mattzcarey](https://github.com/mattzcarey), [@BramMeerten](https://github.com/BramMeerten), [@gentamura](https://github.com/gentamura), [@colegottdank](https://github.com/colegottdank), [@wobsoriano](https://github.com/wobsoriano), [@philipkiely-baseten](https://github.com/philipkiely-baseten), [@AmagiDDmxh](https://github.com/AmagiDDmxh), [@dylanmoz](https://github.com/dylanmoz), [@Deipzza](https://github.com/Deipzza), [@whysosaket](https://github.com/whysosaket), [@leopardracer](https://github.com/leopardracer), [@archiewood](https://github.com/archiewood), [@theswerd](https://github.com/theswerd), [@chasewoo](https://github.com/chasewoo), [@omahs](https://github.com/omahs), [@akselleirv](https://github.com/akselleirv), [@EricZhou0815](https://github.com/EricZhou0815), [@mxzinke](https://github.com/mxzinke)

Your feedback, bug reports, and pull requests on GitHub have been instrumental in shaping this release. We're excited to see what you'll build with these new capabilities.

[![Matt Pocock](images/ai-sdk-5-vercel/img_002.jpg)](https://x.com/mattpocockuk/status/1942239821067665665)

[Matt Pocock](https://x.com/mattpocockuk/status/1942239821067665665)


· [Follow](https://x.com/intent/follow?screen_name=mattpocockuk)

[View on Twitter](https://x.com/mattpocockuk/status/1942239821067665665)

The AI SDK v5 is really, really good

\- Cuts out a lot of crap
\- Adds flexibility
\- Tons more type-safety
\- More LLM features

[11:10 AM · Jul 7, 2025](https://x.com/mattpocockuk/status/1942239821067665665) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[418](https://x.com/intent/like?tweet_id=1942239821067665665) [Reply](https://x.com/intent/tweet?in_reply_to=1942239821067665665)


[Read 15 replies](https://x.com/mattpocockuk/status/1942239821067665665)

[![Sami Hindi](images/ai-sdk-5-vercel/img_003.jpg)](https://x.com/DevBySami/status/1950255041996079197)

[Sami Hindi](https://x.com/DevBySami/status/1950255041996079197)


· [Follow](https://x.com/intent/follow?screen_name=DevBySami)

[View on Twitter](https://x.com/DevBySami/status/1950255041996079197)

wasn’t expecting the new message system to make such a difference in [@aisdk](https://x.com/aisdk)

separating UI and model messages cleans up so much front-end spaghetti

can actually read my own code now

not gonna miss the tangled chat logic

[2:00 PM · Jul 29, 2025](https://x.com/DevBySami/status/1950255041996079197) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[10](https://x.com/intent/like?tweet_id=1950255041996079197) [Reply](https://x.com/intent/tweet?in_reply_to=1950255041996079197)


[Read 2 replies](https://x.com/DevBySami/status/1950255041996079197)

[![Josh tried coding](images/ai-sdk-5-vercel/img_004.jpg)](https://x.com/joshtriedcoding/status/1950554058000847235)

[Josh tried coding](https://x.com/joshtriedcoding/status/1950554058000847235)


· [Follow](https://x.com/intent/follow?screen_name=joshtriedcoding)

[View on Twitter](https://x.com/joshtriedcoding/status/1950554058000847235)

im very impressed with the ai-sdk v5

◆ fully type-safe server to client
◆ easy to stream custom data

demo coming very soon


[9:48 AM · Jul 30, 2025](https://x.com/joshtriedcoding/status/1950554058000847235) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[148](https://x.com/intent/like?tweet_id=1950554058000847235) [Reply](https://x.com/intent/tweet?in_reply_to=1950554058000847235)


[Read 7 replies](https://x.com/joshtriedcoding/status/1950554058000847235)




· [Follow](https://x.com/intent/follow?screen_name=SullyOmarr)

[View on Twitter](https://x.com/SullyOmarr/status/1940106909698465844)

man [@aisdk](https://x.com/aisdk) v5 is so good, feels bad having to build agents without it

whats the equivalent or other languages (python etc)

[1:55 PM · Jul 1, 2025](https://x.com/SullyOmarr/status/1940106909698465844) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[254](https://x.com/intent/like?tweet_id=1940106909698465844) [Reply](https://x.com/intent/tweet?in_reply_to=1940106909698465844)


[Read 35 replies](https://x.com/SullyOmarr/status/1940106909698465844)

[![Alex Moore](images/ai-sdk-5-vercel/img_005.jpg)](https://x.com/ikindacode/status/1944211984645255551)

[Alex Moore](https://x.com/ikindacode/status/1944211984645255551)


· [Follow](https://x.com/intent/follow?screen_name=ikindacode)

[View on Twitter](https://x.com/ikindacode/status/1944211984645255551)

Just tested the new [@vercel](https://x.com/vercel) AI Gateway with [@aisdk](https://x.com/aisdk). What a dang dream. You mean I just swap a string and boom, I'm using a different model? That's it? 😮‍💨

[9:47 PM · Jul 12, 2025](https://x.com/ikindacode/status/1944211984645255551) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[36](https://x.com/intent/like?tweet_id=1944211984645255551) [Reply](https://x.com/intent/tweet?in_reply_to=1944211984645255551)


[Read 4 replies](https://x.com/ikindacode/status/1944211984645255551)

[![Francisco Moretti](images/ai-sdk-5-vercel/img_006.jpg)](https://x.com/franmoretti_/status/1942919268313534638)

[Francisco Moretti](https://x.com/franmoretti_/status/1942919268313534638)


· [Follow](https://x.com/intent/follow?screen_name=franmoretti_)

[View on Twitter](https://x.com/franmoretti_/status/1942919268313534638)

AI SDK v5 is a masterpiece. Migration resulted in more typesafety, more control and flexibility, with less code

[8:10 AM · Jul 9, 2025](https://x.com/franmoretti_/status/1942919268313534638) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[13](https://x.com/intent/like?tweet_id=1942919268313534638) [Reply](https://x.com/intent/tweet?in_reply_to=1942919268313534638)


[Read more on X](https://x.com/franmoretti_/status/1942919268313534638)