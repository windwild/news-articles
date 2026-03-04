---
title: "Introducing AI SDK 3.0 with Generative UI support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-3-generative-ui"
date: "2024-03-01"
scraped_at: "2026-03-02T09:47:52.330726584+00:00"
language: "en-zh"
translated: true
description: "Stream React Components from LLMs to deliver richer user experiences"
---
{% raw %}

Mar 1, 2024

2024 年 3 月 1 日

Stream React Components from LLMs to deliver richer user experiences

从大语言模型流式输出 React 组件，打造更丰富的用户体验

Last October, we launched [v0.dev](http://v0.dev/), a generative UI design tool that converts text and image prompts to React UIs and streamlines the design engineering process.

去年十月，我们推出了 [v0.dev](http://v0.dev/) —— 一款生成式 UI 设计工具，可将文本与图像提示词自动转化为 React 用户界面，并大幅简化设计工程流程。

Today, we are open sourcing v0's [Generative UI](https://vercel.com/blog/announcing-v0-generative-ui) technology with the release of the [Vercel AI SDK 3.0](https://sdk.vercel.ai/docs). Developers can now move beyond plaintext and markdown chatbots to give LLMs rich, component-based interfaces.

今天，随着 [Vercel AI SDK 3.0](https://sdk.vercel.ai/docs) 的发布，我们正式开源 v0 的 [生成式 UI（Generative UI）](https://vercel.com/blog/announcing-v0-generative-ui) 技术。开发者 now 可以突破纯文本与 Markdown 格式聊天机器人的局限，为大语言模型赋予丰富、基于组件的交互界面。

Art made by Van Gogh?

梵高创作的艺术作品？

searchImages("Van Gogh")

searchImages("Van Gogh")

Here are a few notable works

以下是几幅著名画作：

![Starry Night](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_001.jpg)

![星月夜（Starry Night）](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_001.jpg)

Starry Night

《星月夜》

![Sunflowers](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_002.jpg)

![向日葵（Sunflowers）](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_002.jpg)

Sunflowers

向日葵

![Olive Trees](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_003.jpg)

![橄榄树](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_003.jpg)

Olive Trees

橄榄树


Play

播放


Let your users see more than words can say by rendering components directly within your search experience.

通过在搜索体验中直接渲染组件，让用户看到文字无法表达的丰富信息。


I'd like to get drinks with Max tomorrow evening after studio!

我想明天晚上练完工作室后和 Max 一起喝一杯！


searchContacts("Max")

searchContacts("Max")


![max's avatar](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_004.jpg)

![Max 的头像](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_004.jpg)

max

max


@mleiter

@mleiter

![shu's avatar](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_005.jpg)

![shu 的头像](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_005.jpg)

shu

shu

@shuding

@shuding

getEvents("2023-10-18", \["jrmy", "mleiter"\])

getEvents("2023-10-18", \["jrmy", "mleiter"\])

4PM

下午 4 点

5PM

下午 5 点

6PM

下午 6 点

7PM

下午 7 点

studio

工作室

4-6 PM

下午 4 点至 6 点

Task Planning

任务规划

Play

试玩

Make it easier for your users to interpret agent execution so they can stay in the loop with the magic behind the scenes.

让您的用户更轻松地理解智能体（agent）的执行过程，从而实时掌握幕后运行的“魔法”。

[Visit our demo](https://sdk.vercel.ai/demo) for a first impression or [read the documentation](https://sdk.vercel.ai/docs/concepts/ai-rsc) for a preview of the new APIs.

[访问我们的演示](https://sdk.vercel.ai/demo) 获取第一印象，或 [阅读文档](https://sdk.vercel.ai/docs/concepts/ai-rsc) 预览新 API。

## A new user experience for AI

## 面向 AI 的全新用户体验

Products like ChatGPT have made a profound impact: they help users write code, plan travel, translate, summarize text, and so much more. However, LLMs have faced two important UX challenges:

像 ChatGPT 这样的产品已产生深远影响：它们帮助用户编写代码、规划旅行、翻译文本、总结内容，以及更多。然而，大语言模型（LLM）在用户体验方面长期面临两大关键挑战：

- Limited or imprecise knowledge  
- 知识有限或不够精准  

- Plain text / markdown-only responses  
- 仅支持纯文本或 Markdown 格式响应  

With the introduction of Tools and Function Calling, developers have been able to build more robust applications that are able to fetch realtime data.

随着“工具（Tools）”与“函数调用（Function Calling）”机制的引入，开发者得以构建更加健壮的应用程序，使其能够实时获取数据。

![](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_006.jpg)![](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_007.jpg)

These applications, however, have been challenging to write and are still lacking in richness and interactivity.

然而，这些应用编写起来一直颇具挑战性，且在丰富性和交互性方面仍显不足。

Thanks to our experience in developing v0 with [React Server Components (RSC)](https://vercel.com/blog/understanding-react-server-components), we've arrived at a simple abstraction that can solve both these problems.

得益于我们在使用 [React Server Components（RSC）](https://vercel.com/blog/understanding-react-server-components) 开发 v0 过程中积累的经验，我们提出了一种简洁的抽象方案，可同时解决上述两个问题。

## A new developer experience for AI

## 面向 AI 的全新开发者体验

With the AI SDK 3.0, you can now associate LLM responses to streaming React Server Components.

借助 AI SDK 3.0，您现在可以将大语言模型（LLM）响应与流式传输的 React Server Components 关联起来。

Let's start with the most basic example, streaming text without retrieval or up-to-date information.

我们先从最基础的示例开始：流式输出纯文本，不涉及检索，也不依赖实时信息。

```jsx
import { render } from 'ai/rsc'

import OpenAI from 'openai'



const openai = new OpenAI()
```

```javascript
async function submitMessage(userInput) {

7  'use server'



9  return render({

10    provider: openai,

11    model: 'gpt-4',

12    messages: [\
\
13      { role: 'system', content: 'You are an assistant' },\
\
14      { role: 'user', content: userInput }\
\
15    ],

16    text: ({ content }) => <p>{content}</p>,

17  })

18}
```

```javascript
异步函数 submitMessage(userInput) {

7  'use server'



9  返回 render({

10    provider: openai,

11    model: 'gpt-4',

12    messages: [\
\
13      { role: 'system', content: '你是一位助手' },\
\
14      { role: 'user', content: userInput }\
\
15    ],

16    text: ({ content }) => <p>{content}</p>,

17  })

18}
```

Let's now solve both original problems: retrieve the live weather and render a custom UI. If your model supports [OpenAI-compatible Functions or Tools](https://platform.openai.com/docs/assistants/tools/function-calling), you can use the new `render` method to map specific calls to React Server Components.

现在，让我们来解决这两个原始问题：获取实时天气信息，并渲染自定义 UI。如果你所用的模型支持 [OpenAI 兼容的 Functions 或 Tools（函数或工具）](https://platform.openai.com/docs/assistants/tools/function-calling)，则可以使用全新的 `render` 方法，将特定调用映射到 React Server Components（React 服务端组件）。

```jsx
import { render } from 'ai/rsc'

import OpenAI from 'openai'

import { z } from 'zod'



const openai = new OpenAI()



async function submitMessage(userInput) { // 'What is the weather in SF?'

8  'use server'
```

10  return render({

10  返回 render({  

11    provider: openai,

11    提供商：openai,

12    model: 'gpt-4-0125-preview',

12    模型：'gpt-4-0125-preview',

13    messages: [\
\
14      { role: 'system', content: 'You are a helpful assistant' },\
\
15      { role: 'user', content: userInput }\
\
16    ],

13    消息：[\
\
14      { role: 'system', content: '你是一个乐于助人的助手' },\
\
15      { role: 'user', content: userInput }\
\
16    ],

17    text: ({ content }) => <p>{content}</p>,

17    文本：({ content }) => <p>{content}</p>,

18    tools: {

18    工具：{

19      get_city_weather: {

19      get_city_weather：{

20        description: 'Get the current weather for a city',

20        描述：'获取某城市的当前天气',

21        parameters: z.object({

21        参数：z.object({

22          city: z.string().describe('the city')

22          city：z.string().describe('城市')

23        }).required(),

23        }).必填(),

24        render: async function* ({ city }) {

24        渲染: async function* ({ city }) {

25          yield <Spinner/>

25          yield <Spinner/>

26          const weather = await getWeather(city)

26          const weather = await getWeather(city)

27          return <Weather info={weather} />

27          return <Weather info={weather} />

28        }

28        }

29      }

29      }

30    }

30    }

31  })

31  })

32}
```

What is the weather in SF?

SF 的天气如何？

getWeather("San Francisco, CA")

getWeather("San Francisco, CA")

Thursday, March 7

3月7日，星期四

47°

47°F

sunny

晴朗

7am

上午7点

48°

48°F

8am

上午8点

50°

50°F

9am

上午9点

52°

52°

10am

上午10点

54°

54°

11am

上午11点

56°

56°

12pm

中午12点

58°

58°

1pm

下午1点

60°

60°

Thanks!

谢谢！

Weather

天气

Play

播放

An example of an assistant that renders the weather information in a streamed component.

一个通过流式组件渲染天气信息的助手示例。

## Towards the AI-native web

## 迈向 AI 原生 Web

With Vercel AI SDK 3.0, we're simplifying how you integrate AI into your apps. By using React Server Components, you can now stream UI components directly from LLMs without the need for heavy client-side JavaScript. This means your apps can be more interactive and responsive, without compromising on performance.

借助 Vercel AI SDK 3.0，我们正在简化将 AI 集成到应用中的方式。通过使用 React Server Components（RSC），你现在可以直接从大语言模型（LLM）流式传输 UI 组件，而无需依赖繁重的客户端 JavaScript。这意味着你的应用可以更富交互性、响应更迅速，同时不牺牲性能。

This update makes it easier to build and maintain AI-powered features, helping you focus on creating great user experiences. We're excited to see what you ship.

此次更新让构建和维护 AI 驱动功能变得更加轻松，助你专注于打造卓越的用户体验。我们热切期待你发布的成果。

[**Try the demo**\\
\\
Try an experimental preview of AI SDK 3.0 with Generative UI\\
\\
Try now](https://sdk.vercel.ai/demo)

[**尝试演示**\\
\\
体验 AI SDK 3.0 与生成式 UI 的实验性预览版本\\
\\
立即尝试](https://sdk.vercel.ai/demo)

## FAQ

## 常见问题（FAQ）

- ### Do I need Next.js to use this?

- ### 我必须使用 Next.js 才能使用此功能吗？

  - The new APIs in the AI SDK 3.0 rely on React Server Components (RSC) and React Server Actions which are currently implemented in Next.js. They do not rely on any internal Next.js-specifics, so when other React frameworks like Remix or Waku complete their implementations of RSC, you'll be able to use them for Generative UI assuming they comply with React's spec.

  - AI SDK 3.0 中的新 API 依赖于 React Server Components（RSC）和 React Server Actions，而目前这些能力仅在 Next.js 中实现。这些 API 并不依赖 Next.js 内部的专有机制；因此，一旦其他 React 框架（如 Remix 或 Waku）完成对 RSC 的支持，并符合 React 官方规范，你也将能够使用它们来构建生成式 UI。

- ### **Do React Server Components work with Next.js Pages Router?**

- ### **React Server Components 是否支持 Next.js Pages Router？**

- No. The new APIs rely on React Server Components and React Server Actions which are not implemented in Next.js Pages Router. However, as of Next.js 13, you can use both App Router and Pages Router in the same Next.js application.  
- 否。新 API 依赖 React Server Components（RSC）和 React Server Actions，而这些特性在 Next.js Pages Router 中并未实现。不过，自 Next.js 13 起，您可在同一 Next.js 应用中同时使用 App Router 和 Pages Router。

### **What LLMs are currently supported?**  
### **当前支持哪些大语言模型（LLM）？**

- You can use the RSC APIs with any streaming LLM supported by the AI SDK. However, the [`render`](https://sdk.vercel.ai/docs/api-reference/generative-ui/render) method expects LLMs to support OpenAI's SDK and optionally its [Assistant Tools and Function Calling APIs](https://platform.openai.com/docs/guides/function-calling). We also provide lower-level streaming APIs can be used independently (even without an LLM). At the time of writing though, the new RSC-based [`render`](https://sdk.vercel.ai/docs/api-reference/generative-ui/render) API can be fully used with [OpenAI](https://platform.openai.com/docs/guides/function-calling), [Mistral](https://docs.mistral.ai/guides/function-calling), and [Fireworks](https://blog.fireworks.ai/fireworks-raises-the-quality-bar-with-function-calling-model-and-api-release-e7f49d1e98e9)' `firefunction-v1` model because of their support of the OpenAI SDK-compatible Function Calling.  
- 您可将 RSC API 与 AI SDK 所支持的任意流式大语言模型配合使用。但 [`render`](https://sdk.vercel.ai/docs/api-reference/generative-ui/render) 方法要求 LLM 必须兼容 OpenAI SDK，并可选支持其 [Assistant Tools 和 Function Calling API](https://platform.openai.com/docs/guides/function-calling)。我们还提供了更底层的流式 API，可独立使用（甚至无需 LLM）。不过，截至本文撰写时，基于 RSC 的全新 [`render`](https://sdk.vercel.ai/docs/api-reference/generative-ui/render) API 已能完整支持 [OpenAI](https://platform.openai.com/docs/guides/function-calling)、[Mistral](https://docs.mistral.ai/guides/function-calling) 以及 [Fireworks](https://blog.fireworks.ai/fireworks-raises-the-quality-bar-with-function-calling-model-and-api-release-e7f49d1e98e9) 的 `firefunction-v1` 模型——这得益于它们对 OpenAI SDK 兼容的 Function Calling 功能的支持。

### What if my LLM doesn't support tools or function calling?  
### 如果我的 LLM 不支持工具调用或函数调用，该怎么办？

- You can still use the AI SDK 3.0 RSC APIs to stream text and your own components, or you can prompt engineer your LLM to output structured data that can be parsed and used with the AI SDK.  
- 您仍可使用 AI SDK 3.0 的 RSC API 来流式传输文本及自定义组件；或者，您可通过提示工程（prompt engineering）引导您的 LLM 输出结构化数据，再经解析后供 AI SDK 使用。

### **Does Generative UI work with OpenAI Assistants?**  
### **生成式 UI 是否支持 OpenAI Assistants？**

- You can use OpenAI Assistants as a persistence layer and function calling API with the AI SDK 3.0. Or you can manually perform the LLM calls with a provider or API of your choice.  
- 您可将 OpenAI Assistants 作为持久化层和函数调用 API，与 AI SDK 3.0 配合使用；或者，您也可手动通过任一您选择的提供商或 API 发起 LLM 调用。

### **Can anything be passed from the server to the client?**  
### **是否可将任意内容从服务端传递至客户端？**

- Anything serializable by React can cross the network boundary between server and client. Promises, JavaScript primitives, and certain data structures like Map and Set can all be serialized by React. You can read more about React's serialization in [the React docs.](https://react.dev/reference/react/use-server#serializable-parameters-and-return-values)  
- 凡是 React 可序列化的数据，均可跨越服务端与客户端之间的网络边界。Promise、JavaScript 原始类型，以及 Map、Set 等特定数据结构，均支持由 React 进行序列化。有关 React 序列化机制的更多细节，请参阅 [React 官方文档](https://react.dev/reference/react/use-server#serializable-parameters-and-return-values)。

### **Does this work with LangChain or LlamaIndex?**  
### **该方案是否支持 LangChain 或 LlamaIndex？**

- Yes, with the [`createStreamableUI`](https://sdk.vercel.ai/docs/api-reference/generative-ui/create-streamable-ui) and [`createStreamableValue`](https://sdk.vercel.ai/docs/api-reference/generative-ui/create-streamable-value) primitives you can use any JavaScript library as long as you can call it during the execution of a React Server Action. This means you can build Generative UI products with tools like [LangChain](https://www.langchain.com/), [LlamaIndex](https://www.llamaindex.ai/), agent abstractions, and with durable task runners like [Inngest](https://inngest.com/).  
- 是的，借助 [`createStreamableUI`](https://sdk.vercel.ai/docs/api-reference/generative-ui/create-streamable-ui) 和 [`createStreamableValue`](https://sdk.vercel.ai/docs/api-reference/generative-ui/create-streamable-value) 这两类基础构建单元，只要能在 React Server Action 执行过程中调用，您即可集成任意 JavaScript 库。这意味着您可以基于 [LangChain](https://www.langchain.com/)、[LlamaIndex](https://www.llamaindex.ai/)、各类 Agent 抽象层，以及 [Inngest](https://inngest.com/) 等持久化任务运行器，构建生成式 UI 产品。
{% endraw %}
