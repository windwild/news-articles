---
title: "Introducing Vercel AI SDK 3.2 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-vercel-ai-sdk-3-2"
date: "2024-06-18"
scraped_at: "2026-03-02T09:43:48.339885065+00:00"
language: "en-zh"
translated: true
description: "Vercel AI SDK 3.2 enables agent and embeddings workflows while improving provider support and DX. "
---
{% raw %}

Jun 18, 2024

2024 年 6 月 18 日

在瞬息万变的 AI 世界中，快速适应能力至关重要。

我们一直在认真听取您的反馈，并全力以赴拓展 [AI SDK](https://sdk.vercel.ai/docs/introduction) 的功能，同时持续优化其现有能力。今天，我们正式发布 AI SDK 3.2。

本次版本更新在以下四大领域全面推动了 [SDK](https://sdk.vercel.ai/docs/introduction) 的演进：

- [**智能体（Agents）**](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#agents) **：** 扩展 `generateText` 和 `streamText` 方法，支持多步骤工作流

- [**模型提供商（Providers）**](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#providers) **：** 新增多个模型提供商，并增强 Anthropic 与 Google 模型的支持能力

- [**向量嵌入（Embeddings）**](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#embeddings) **：** 引入嵌入（embeddings）支持，赋能检索增强生成（RAG）、语义搜索等应用场景

- [**开发者体验（DX）改进**](https://vercel.com/blog/introducing-vercel-ai-sdk-3-2#dx-improvements) **：** 提升 AI SDK 的可观测性，并支持客户端工具调用（client-side tool calls）

## Agents

## 智能体（Agents）

随着 AI 模型能力不断增强，它们被赋予的任务也日趋复杂——其中不少任务需通过多个步骤协同完成。借助 AI SDK 3.2，我们迈出了关键一步，让构建此类智能体驱动的工作流变得更加简单高效。

Let’s say you were building an application to analyze product feedback with an LLM.

假设你正在构建一个使用大语言模型（LLM）分析产品反馈的应用程序。

```javascript
await generateText({

2  model: openai('gpt-4o'),

3  system: "You are a product feedback analyzer. You summarize a piece of feedback, then determine whether it is positive, negative, or neutral."

4  prompt: userFeedback,

5});
```

```javascript
await generateText({

2  model: openai('gpt-4o'),

3  system: "你是一名产品反馈分析员。你需要先概括一段用户反馈，再判断其情感倾向是正面、负面还是中性。"

4  prompt: userFeedback,

5});
```

To ensure the model generates useful information, you’ll probably want to first clean the data, then analyze it, and finally send it to a platform where your coworkers can also take a look. In other words, you want your LLM to act as a basic agent.

为确保模型输出有用的信息，你很可能需要先清洗数据，再进行分析，最后将结果发送至一个协作平台，以便同事也能查看。换言之，你希望你的大语言模型扮演一个基础智能体（agent）的角色。

With just a few short additions, we can use the AI SDK to implement this agent.

只需添加少量代码，我们即可借助 AI SDK 实现这一智能体功能。

```javascript
await generateText({

2  model: openai('gpt-4-turbo'),
```

```javascript
await generateText({

2  model: openai('gpt-4-turbo'),
```

3  system: "You are a product feedback analyzer. You summarize feedback, then determine whether it is positive, negative, or neutral. If the feedback is not neutral, you send a message to our Slack channel with that feedback. Always clean the feedback before summarizing or categorizing. "

3  system: “你是一名产品反馈分析员。你需要先对用户反馈进行摘要，再判断其情感倾向为正面、负面或中性。若反馈非中性，则需将该反馈发送至我们的 Slack 频道。在摘要或分类前，务必先对反馈内容进行清洗。”

4  prompt: userFeedback,

4  prompt: userFeedback，

5  tools: {

5  tools: {

6    cleanUserFeedback: tool({

6    cleanUserFeedback: tool({

7      description: "Removes spam, PII, and profanity from raw user feedback",

7      description: “从原始用户反馈中移除垃圾信息、个人身份信息（PII）及不当用语”，

8      parameters: z.object({userFeedback: z.string() }),

8      parameters: z.object({userFeedback: z.string() }),

9      execute: async ({userFeedback}) => cleanUserFeedback(userFeedback),

9      execute: async ({userFeedback}) => cleanUserFeedback(userFeedback),

10    }),

10    }),

11    sendMessageToSlack: tool({

11    sendMessageToSlack: tool({

12      description: "Sends feedback to Slack"

12      description: “将反馈发送至 Slack”

13      parameters: z.object({ sentiment: z.enum(["positive", "negative", "neutral"]), feedbackSummary: z.string()}),\
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
```
13      参数：z.object({ sentiment: z.enum(["positive", "negative", "neutral"]), feedbackSummary: z.string()}),\
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
```

代理将首先以 `userFeedback` 作为输入调用 `cleanFeedback` 工具；随后对清洗后的反馈进行摘要并判定其情感倾向；最后调用 `sendMessagetoSlack` 工具，将情感倾向与反馈摘要发送至 Slack，然后退出。

本次发布仅是支持复杂、自主型智能体（autonomous agents）的起点，我们将在后续版本中持续深化此项工作。

## Providers  
## 提供商  

我们一直在为新的大模型提供商添加支持，这得益于我们卓越社区成员的鼎力协助。在本次 3.2 版本发布中，AI SDK 新增支持以下提供商：

- [Azure OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/azure)  
- [Google Vertex](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex)  
- [Cohere](https://sdk.vercel.ai/providers/ai-sdk-providers/cohere)  
- [Ollama（由社区维护！）](https://sdk.vercel.ai/providers/community-providers/ollama)  

随着各提供商不断升级其模型能力，我们也同步更新了 AI SDK 的功能。目前，以下提供商已支持图像输入：

- [Anthropic（Claude Opus、Sonnet 和 Haiku）](https://sdk.vercel.ai/providers/ai-sdk-providers/anthropic)  
- [Google Vertex](https://sdk.vercel.ai/providers/ai-sdk-providers/google-vertex)  
- [Google Generative AI](https://sdk.vercel.ai/providers/ai-sdk-providers/google-generative-ai)  

最新版受支持的提供商列表及其能力详情，请参阅 [AI SDK 文档](https://sdk.vercel.ai/providers/ai-sdk-providers)。

我们还构建了一个适配器（adapter），使您能够将 LangChain 的 AI 工具与抽象层，与 AI SDK 的 UI 渲染及流式响应（streaming）能力无缝集成。更多详情请查阅 [我们的文档](https://sdk.vercel.ai/providers/adapters/langchain)。

## Embeddings  
## 嵌入（Embeddings）  

AI 应用通常需要将模型的输入与输出表示为高维空间中的向量——尤其适用于 [RAG（检索增强生成）](https://vercel.com/guides/retrieval-augmented-generation) 等典型场景。嵌入技术为此类问题提供了**语义上具有意义**的内容表征方式。

比较两个嵌入向量最常用的方法是余弦相似度（cosine similarity）——它用于衡量嵌入内容之间的语义距离。

本次发布将 AI SDK Core 的统一 API 扩展至支持生成嵌入向量，现已兼容 OpenAI、Mistral、Azure OpenAI 及 Ollama 等提供商。

```javascript\
1// 'embedding' 是单个嵌入对象（number[] 类型）\
\
const { embedding } = await embed({\
\
3  model: openai.embedding('text-embedding-3-small'),\
\
4  value: 'sunny day at the beach'\
\
5});\
```
```javascript\
1// 'embedding' 是一个嵌入对象（number[] 类型）\
\
const { embedding } = await embed({\
\
3  model: openai.embedding('text-embedding-3-small'),\
\
4  value: '阳光明媚的海滩一日'\
\
5});\
```

在加载数据时，往往需要一次性对多个值进行嵌入处理，此时 `embedMany` 将非常实用。

```javascript\
1// 'embeddings' 是一个嵌入对象数组（number[][] 类型），\
\
2// 其顺序与输入值顺序严格一致。\
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
console.log(`相似度范围 -1 到 1: ${cosineSimilarity(embeddings[0], embeddings[1])}`)\
```
```javascript\
1// 'embeddings' 是一个嵌入对象数组（number[][] 类型），\
\
2// 其顺序与输入值顺序严格一致。\
\
const { embeddings } = await embedMany({\
\
4  model: openai.embedding('text-embedding-3-small'),\
\
5  values: [\
\
6    '阳光明媚的海滩一日',\
\
7    '城市里阴雨绵绵的午后',\
\
8  ],\
\
9});\
\
console.log(`相似度范围 -1 到 1: ${cosineSimilarity(embeddings[0], embeddings[1])}`)\
```

AI SDK 现在还内置了 `cosineSimilarity` 辅助函数，帮助您便捷地计算嵌入值之间的语义相似度。

将视觉模型与语义相似度分析能力结合使用（借助 AI SDK），可解锁诸多全新应用场景，例如 [语义图像搜索（semantic image search）](https://semantic-image-search.labs.vercel.dev/)。

如需深入了解该示例的完整实现代码，请参阅我们的 [语义图像搜索模板](https://github.com/vercel-labs/semantic-image-search)！

## DX Improvements  
## 开发体验（DX）改进  

3.2 版本为 AI SDK 构建了 AI 可观测性（AI observability）的基础能力。我们大幅优化了 `streamText` 和 `streamObject` 在使用过程中的 token 消耗统计与错误诊断体验；同时新增 `onFinish` 回调函数——当流式响应结束时自动触发，其中包含完整的 token 使用信息。

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
```
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
9  prompt: "生成一个随机姓名",\
\
10  onFinish({ object, error, usage, ...rest}) {\
\
11    console.log("Token 使用量:", usage);\
\
12    if (object === undefined) {\
\
13      console.error("错误:", error);\
\
14    } else {\
\
15      console.log("成功！", JSON.stringify(object, null, 2));\
\
16    }\
\
17  }\
\
18})\
```

您现在还可通过 `streamObject` 返回结果的 `object` 属性，以 Promise 形式获取最终、类型安全的结构化对象，从而无需 `@ts-ignore` 即可安全地记录和使用完成后的结果。

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
12  // 使用完全类型化的最终对象，无需 @ts-ignore\
\
13  console.log("姓名:", name.firstName, name.lastName);\
\
14});\
```
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
9  prompt: "生成一个随机姓名"\
\
10});\
\
result.object.then(({ name }) => {\
\
12  // 使用完全类型化的最终对象，无需 @ts-ignore\
\
13  console.log("姓名:", name.firstName, name.lastName);\
\
14});\
```

为减小 AI SDK 的打包体积，我们已按前端框架对 AI SDK UI 进行模块拆分。3.2 版本保持向后兼容，但我们强烈建议迁移至 `@ai-sdk/react`、`@ai-sdk/vue`、`@ai-sdk/svelte` 或 `@ai-sdk/solid`。

借助本次发布，您现在可在 React 项目中仅凭 `useChat` 和 `streamText`，即可在客户端构建生成式 UI 聊天机器人。我们已支持客户端与服务端双侧工具执行，并引入了 `toolInvocations` 和 `onToolCall` 新工具，使您能根据大语言模型（LLM）所调用的具体工具，动态条件渲染 UI 组件。

以下是一个简单示例：聊天机器人会告知用户当前正在何处进行对话。

app/api/chat/route.ts  
app/api/chat/route.ts  

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
8      // 客户端工具：启动用户交互\
\
9      askForConfirmation: {\
\
10        description: "Ask the user for confirmation",\
\
11        parameters: z.object({message: z.string().describe("The message to ask for confirmation") }),\
\
12      },\
\
13      // 客户端工具：获取用户位置\
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
```
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
8      // 客户端工具：启动用户交互\
\
9      askForConfirmation: {\
\
10        description: "向用户请求确认",\
\
11        parameters: z.object({message: z.string().describe("请求确认的消息内容") }),\
\
12      },\
\
13      // 客户端工具：获取用户位置\
\
14      getLocation: {\
\
15        description:\
\
16          "获取用户位置。调用此工具前必须先请求用户确认。",\
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
```

在您的 `streamText` 调用中，可省略 `execute` 参数，从而让工具在客户端执行。

app/page.tsx  
app/page.tsx  

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
10    // 自动执行客户端工具\
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
29            // 渲染确认工具（需用户交互的客户端工具）\
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
40                      <button onClick={() => addResult('Yes')}>是</button>\
\
41                      <button onClick={() => addResult('No')}>否</button>\
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
```
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
10    // 自动执行客户端工具\
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
22          <strong>{m.role}：</strong>\
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
29            // 渲染确认工具（需用户交互的客户端工具）\
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
35                      {toolInvocation.args.message}：{toolInvocation.result}\
\
36                    </b>\
\
37                  ) : (\
\
38                    <>\
\
39                      {toolInvocation.args.message}：\
\
40                      <button onClick={() => addResult('是')}>是</button>\
\
41                      <button onClick={() => addResult('否')}>否</button>\
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
```

您可在 `useChat` 中使用 `onToolCall` 来定义客户端工具的执行逻辑。`toolInvocation` 提供了 LLM 在客户端所选择调用的全部工具信息，使您能据此条件化地渲染 UI 组件来响应工具调用——这种“概率路由”（probabilistic routing）机制，与 AI SDK RSC 中的 `streamUI` 函数作用类似。`addToolResult` 则允许您将用户提供的信息回传给 LLM，供其在后续响应中使用。

## Conclusion  
## 总结  

借助 [AI SDK](https://sdk.vercel.ai/docs/introduction) 3.2 版本，我们迈出了支持两大全新用例的第一步：[嵌入（embeddings）](https://sdk.vercel.ai/docs/ai-sdk-core/embeddings) 与 [智能体（agents）](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling#tool-roundtrips)。我们将持续迭代 SDK，确保您始终能第一时间接入前沿模型提供商的能力，并获得构建 AI 应用时流畅、无缝的开发体验。

我们无比期待看到您将创造出怎样的精彩应用！立即动手，[部署您自己的图像搜索应用](https://github.com/vercel-labs/semantic-image-search?tab=readme-ov-file#deploy-your-own)，或 [尝试 SDK 支持的各类模型提供商](https://sdk.vercel.ai/) 吧！

[**借助 Vercel 更快交付生产级 AI 应用**  
与我们的团队联系，了解如何在贵组织内构建 AI 驱动的应用。  
联系我们](https://vercel.com/contact/sales)
{% endraw %}
