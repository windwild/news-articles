---
title: "Introducing Vercel AI SDK 3.2 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-vercel-ai-sdk-3-2"
date: "2024-06-18"
scraped_at: "2026-03-02T09:43:48.339885065+00:00"
language: "en"
translated: false
description: "Vercel AI SDK 3.2 enables agent and embeddings workflows while improving provider support and DX. "
---




Jun 18, 2024

The importance of adapting quickly in an ever-changing AI world.

We’ve been listening to your feedback and working hard to expand the capabilities of the [AI SDK](https://sdk.vercel.ai/docs/introduction) while improving its existing functionality. Today, we’re launching AI SDK 3.2.

This release advances the [SDK](https://sdk.vercel.ai/docs/introduction) across four major areas:

- [**Agents**](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#agents) **:** Extended `generateText` and `streamText` for multi-step workflows

- [**Providers**](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#providers) **:** Added new providers and expanded capabilities for Anthropic and Google models

- [**Embeddings**](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#embeddings) **:** Introduced embeddings support to power use cases like retrieval augmented generation (RAG) and semantic search

- [**DX improvements**](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#dx-improvements) **:** Improved AI SDK observability and enabled client-side tool calls


## Agents

As AI models become more capable, they’ve been charged with increasingly complex tasks — some of which require multiple steps. With the AI SDK 3.2, we’ve taken the first step towards making these agentic workflows much easier to build.

Let’s say you were building an application to analyze product feedback with an LLM.

```javascript
await generateText({

2  model: openai('gpt-4o'),

3  system: "You are a product feedback analyzer. You summarize a piece of feedback, then determine whether it is positive, negative, or neutral."

4  prompt: userFeedback,

5});
```

To ensure the model generates useful information, you’ll probably want to first clean the data, then analyze it, and finally send it to a platform where your coworkers can also take a look. In other words, you want your LLM to act as a basic agent.

With just a few short additions, we can use the AI SDK to implement this agent.

```javascript
await generateText({

2  model: openai('gpt-4-turbo'),

3  system: "You are a product feedback analyzer. You summarize feedback, then determine whether it is positive, negative, or neutral. If the feedback is not neutral, you send a message to our Slack channel with that feedback. Always clean the feedback before summarizing or categorizing. "

4  prompt: userFeedback,

5  tools: {

6    cleanUserFeedback: tool({

7      description: "Removes spam, PII, and profanity from raw user feedback",

8      parameters: z.object({userFeedback: z.string() }),

9      execute: async ({userFeedback}) => cleanUserFeedback(userFeedback),

10    }),

11    sendMessageToSlack: tool({

12      description: "Sends feedback to Slack"

13      parameters: z.object({ sentiment: z.enum(["positive", "negative", "neutral"), feedbackSummary: z.string()}),\
\
14      execute: async ({ sentiment, feedbackSummary }) => {\
\
15        sendMessageToSlack(sentiment, feedbackSummary)\
\
16        process.exit(0);\
\
17      },\
\
18    }),\
\
19  },\
\
20  maxToolRoundtrips: 10,\
\
21});\
```\
\
The agent will first call the `cleanFeedback` tool with `userFeedback` as input. It will then summarize and determine a sentiment for the cleaned feedback. Finally, it will call the `sendMessagetoSlack` tool send the sentiment and feedback summary to Slack before exiting.\
\
This release is only the beginning of what’s necessary to support complex, autonomous agents, and we’ll continue to build on this work in future releases.\
\
## Providers\
\
We’ve been adding support for new model providers, aided by the work of our wonderful community. With today’s 3.2 release, the AI SDK has added support for the following providers:\
\
- [Azure OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/azure)\
\
- [Google Vertex](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex)\
\
- [Cohere](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere)\
\
- [Ollama (community-maintained!)](https://sdk.vercel.ai/providers/community-providers/ollama)\
\
\
As providers upgrade their models’ capabilities, we’ve been updating the SDK’s functionality too. Image input is now supported for the following providers:\
\
- [Anthropic (Claude Opus, Sonnet, and Haiku)](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic)\
\
- [Google Vertex](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex)\
\
- [Google Generative AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai)\
\
\
The up-to-date list of supported providers and capabilities can be found in the [AI SDK documentation](https://sdk.vercel.ai/providers/ai-sdk-providers).\
\
We’ve also built an adapter to allow you to use LangChain’s AI tools and abstractions with the UI and streaming capabilities of the AI SDK. Check out [our docs](https://sdk.vercel.ai/providers/adapters/langchain) for more information.\
\
## Embeddings\
\
AI applications often require representing model inputs and outputs as vectors in a high-dimensional space — especially for use cases like [RAG](https://vercel.com/guides/retrieval-augmented-generation). To solve this problem, embeddings provide _semantically_ _meaningful_ representations of content.\
\
The most common method of comparing two embeddings vectors is cosine similarity — a measure of the semantic distance between pieces of embedded content.\
\
This release extends the unified API of AI SDK Core to generating embeddings with the OpenAI, Mistral, Azure OpenAI, and Ollama providers.\
\
```javascript\
1// 'embedding' is a single embedding object (number[])\
\
const { embedding } = await embed({\
\
3  model: openai.embedding('text-embedding-3-small'),\
\
4  value: 'sunny day at the beach'\
\
5});\
```\
\
When loading data, it can often be useful to embed many values at once.\
\
```javascript\
1// 'embeddings' is an array of embedding objects (number[][]).\
\
2// It is sorted in the same order as the input values.\
\
const { embeddings } = await embedMany({\
\
4  model: openai.embedding('text-embedding-3-small'),\
\
5  values: [\
\
6    'sunny day at the beach',\
\
7    'rainy afternoon in the city',\
\
8  ],\
\
9});\
\
console.log(`Similarity from -1 to 1: ${cosineSimilarity(embeddings[0], embeddings[1])}`)\
```\
\
The AI SDK now also provides the `cosineSimilarity` helper function to help you determine semantic similarity between embedded values.\
\
Pairing a vision model with semantic similarity using the AI SDK unlocks new applications like [semantic image search](https://semantic-image-search.labs.vercel.dev/).\
\
To get an in-depth look at the code for this example, check out our [semantic image search template](https://github.com/vercel-labs/semantic-image-search)!\
\
## DX Improvements\
\
The 3.2 release is laying the groundwork for AI observability with the AI SDK. We’ve made it easier to understand token usage and errors when using `streamText` and `streamObject`. We’ve also introduced the `onFinish` callback, which is invoked when the stream is finished and contains the token usage.\
\
```javascript\
const result = await streamObject({\
\
2  model: openai('gpt-4-turbo'),\
\
3  schema: z.object({\
\
4    name: z.object({\
\
5      firstName: z.string(),\
\
6      lastName: z.string(),\
\
7    })\
\
8  })\
\
9  prompt: "Generate a random name",\
\
10  onFinish({ object, error, usage, ...rest}) {\
\
11    console.log("Token usage:", usage);\
\
12    if (object === undefined) {\
\
13      console.error("Error": error);\
\
14    } else {\
\
15      console.log("Success!", JSON.stringify(object, null, 2))\
\
16    }\
\
17  }\
\
18})\
```\
\
You can now also access the final, typed object as a promise from the `streamObject` result, allowing you to log and use the finished result with guaranteed type-safety.\
\
```javascript\
const result = await streamObject({\
\
2  model: openai('gpt-4-turbo'),\
\
3  schema: z.object({\
\
4    name: z.object({\
\
5      firstName: z.string(),\
\
6      lastName: z.string()\
\
7    })\
\
8  }),\
\
9  prompt: "Generate a random name"\
\
10});\
\
result.object.then(({ name }) => {\
\
12  // Use the fully typed, final object with no ts-ignore needed\
\
13  console.log("Name:", name.firstName, name.lastName);\
\
14});\
```\
\
To reduce the AI SDK’s bundle size, we’ve also split AI SDK UI by framework. Our 3.2 release will be backwards compatible, but we recommend migrating to `@ai-sdk/react`, `@ai-sdk/vue`, `@ai-sdk/svelte`, or `@ai-sdk/solid`.\
\
With this release, you can now build generative UI chatbots client-side with just `useChat` and `streamText` in your React projects. We’ve enabled client and server-side tool execution with `streamText` and the new `toolInvocations` and `onToolCall` utilities, which allows you to conditionally render UI based on which tools the LLM calls.\
\
Here’s a simple example of a chatbot that tells the user where they’re chatting from.\
\
app/api/chat/route.ts\
\
```javascript\
export async function POST(req: Request) {\
\
2  const { messages } = await req.json();\
\
3\
\
4  const result = await streamText({\
\
5    model: openai('gpt-4-turbo'),\
\
6    messages: convertToCoreMessages(messages),\
\
7    tools: {\
\
8      // client-side tool that starts user interaction:\
\
9      askForConfirmation: {\
\
10        description: "Ask the user for confirmation",\
\
11        parameters: z.object({message: z.string().describe("The message to ask for confirmation") }),\
\
12      },\
\
13      // client-side tool that gets the user's location:\
\
14      getLocation: {\
\
15        description:\
\
16          "Get the user location. Always ask for confirmation before using this tool.",\
\
17        parameters: z.object({}),\
\
18      },\
\
19    }\
\
20  })\
\
21}\
```\
\
In your `streamText` call, you can omit the `execute` parameter to execute the tool on the client-side.\
\
app/page.tsx\
\
```tsx\
export default function Chat() {\
\
2  const {\
\
3    messages,\
\
4    input,\
\
5    handleInputChange,\
\
6    handleSubmit,\
\
7    addToolResult\
\
8  } = useChat({\
\
9    maxToolRoundtrips: 5,\
\
10    // run client-side tools that are automatically executed\
\
11    async function onToolCall({ toolCall }) {\
\
12      if (toolCall.toolName === 'getLocation') {\
\
13        return getUserLocation();\
\
14      }\
\
15    }\
\
16  });\
\
17\
\
18  return (\
\
19    <div>\
\
20      {messages?.map((m: Message) => (\
\
21        <div key={m.id}>\
\
22          <strong>{m.role}:</strong>\
\
23          {m.content}\
\
24          {m.toolInvocations?.map((toolInvocation: ToolInvocation) => {\
\
25            const toolCallId = toolInvocation.toolCallId;\
\
26            const addResult = (result: string) =>\
\
27              addToolResult({ toolCallId, result });\
\
28\
\
29            // render confirmation tool (client-side tool with user interaction)\
\
30            if (toolInvocation.toolName === 'askForConfirmation') {\
\
31              return (\
\
32                <div key={toolCallId}>\
\
33                  {'result' in toolInvocation ? (\
\
34                    <b>\
\
35                      {toolInvocation.args.message}: {toolInvocation.result}\
\
36                    </b>\
\
37                  ) : (\
\
38                    <>\
\
39                      {toolInvocation.args.message}:{' '}\
\
40                      <button onClick={() => addResult('Yes')}>Yes</button>\
\
41                      <button onClick={() => addResult('No')}>No</button>\
\
42                    </>\
\
43                  )}\
\
44                </div>\
\
45              );\
\
46            }\
\
47          })}\
\
48        </div>\
\
49      ))}\
\
50      <form onSubmit={handleSubmit}>\
\
51        <input value={input} onChange={handleInputChange} />\
\
52      </form>\
\
53    </div>\
\
54  );\
\
55  }\
\
56\
```\
\
You can use `onToolCall` within `useChat` to define functions to execute for client-side tools. `toolInvocation` gives you access to the tools the LLM has chosen to call on the client, which allows you to conditionally render UI components to handle tool calls — implementing probabilistic routing much like the `streamUI` function does in AI SDK RSC. `addToolResult` allows you to pass user-provided information back to the LLM for use in future responses.\
\
## Conclusion\
\
With the [AI SDK](https://sdk.vercel.ai/docs/introduction) 3.2, we’re taking the first steps towards supporting two new use cases: [embeddings](https://sdk.vercel.ai/docs/ai-sdk-core/embeddings) and [agents](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#tool-roundtrips). We’ll continue to update the SDK so you have access to the cutting edge of model providers and a seamless development experience when building with AI.\
\
We can’t wait to see what you’ll build. Get started by [deploying your own image search app](https://github.com/vercel-labs/semantic-image-search?tab=readme-ov-file#deploy-your-own) or [experimenting with SDK model providers](https://sdk.vercel.ai/)!\
\
[**Ship production-grade AI applications faster with Vercel**\\
\\
Talk to our team to learn more about building AI-powered applications at your organization. \\
\\
Contact Us](https://vercel.com/contact/sales)