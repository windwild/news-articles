---
title: "Introducing AI SDK 3.0 with Generative UI support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-sdk-3-generative-ui"
date: "2024-03-01"
scraped_at: "2026-03-02T09:47:52.330726584+00:00"
language: "en"
translated: false
description: "Stream React Components from LLMs to deliver richer user experiences"
---




Mar 1, 2024

Stream React Components from LLMs to deliver richer user experiences

Last October, we launched [v0.dev](http://v0.dev/), a generative UI design tool that converts text and image prompts to React UIs and streamlines the design engineering process.

Today, we are open sourcing v0's [Generative UI](https://vercel.com/blog/announcing-v0-generative-ui) technology with the release of the [Vercel AI SDK 3.0](https://sdk.vercel.ai/docs). Developers can now move beyond plaintext and markdown chatbots to give LLMs rich, component-based interfaces.

Art made by Van Gogh?

searchImages("Van Gogh")

Here are a few notable works

![Starry Night](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_001.jpg)

Starry Night

![Sunflowers](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_002.jpg)

Sunflowers

![Olive Trees](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_003.jpg)

Olive Trees


Play

Let your users see more than words can say by rendering components directly within your search experience.

I'd like to get drinks with Max tomorrow evening after studio!

searchContacts("Max")

![max's avatar](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_004.jpg)

max

@mleiter

![shu's avatar](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_005.jpg)

shu

@shuding

getEvents("2023-10-18", \["jrmy", "mleiter"\])

4PM

5PM

6PM

7PM

studio

4-6 PM

Task Planning

Play

Make it easier for your users to interpret agent execution so they can stay in the loop with the magic behind the scenes.

[Visit our demo](https://sdk.vercel.ai/demo) for a first impression or [read the documentation](https://sdk.vercel.ai/docs/concepts/ai-rsc) for a preview of the new APIs.

## A new user experience for AI

Products like ChatGPT have made a profound impact: they help users write code, plan travel, translate, summarize text, and so much more. However, LLMs have faced two important UX challenges:

- Limited or imprecise knowledge

- Plain text / markdown-only responses


With the introduction of Tools and Function Calling, developers have been able to build more robust applications that are able to fetch realtime data.

![](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_006.jpg)![](images/introducing-ai-sdk-3_0-with-generative-ui-support-vercel/img_007.jpg)

These applications, however, have been challenging to write and are still lacking in richness and interactivity.

Thanks to our experience in developing v0 with [React Server Components (RSC)](https://vercel.com/blog/understanding-react-server-components), we've arrived at a simple abstraction that can solve both these problems.

## A new developer experience for AI

With the AI SDK 3.0, you can now associate LLM responses to streaming React Server Components.

Let's start with the most basic example, streaming text without retrieval or up-to-date information.

```jsx
import { render } from 'ai/rsc'

import OpenAI from 'openai'



const openai = new OpenAI()



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

Let's now solve both original problems: retrieve the live weather and render a custom UI. If your model supports [OpenAI-compatible Functions or Tools](https://platform.openai.com/docs/assistants/tools/function-calling), you can use the new `render` method to map specific calls to React Server Components.

```jsx
import { render } from 'ai/rsc'

import OpenAI from 'openai'

import { z } from 'zod'



const openai = new OpenAI()



async function submitMessage(userInput) { // 'What is the weather in SF?'

8  'use server'



10  return render({

11    provider: openai,

12    model: 'gpt-4-0125-preview',

13    messages: [\
\
14      { role: 'system', content: 'You are a helpful assistant' },\
\
15      { role: 'user', content: userInput }\
\
16    ],

17    text: ({ content }) => <p>{content}</p>,

18    tools: {

19      get_city_weather: {

20        description: 'Get the current weather for a city',

21        parameters: z.object({

22          city: z.string().describe('the city')

23        }).required(),

24        render: async function* ({ city }) {

25          yield <Spinner/>

26          const weather = await getWeather(city)

27          return <Weather info={weather} />

28        }

29      }

30    }

31  })

32}
```

What is the weather in SF?

getWeather("San Francisco, CA")

Thursday, March 7

47°

sunny

7am

48°

8am

50°

9am

52°

10am

54°

11am

56°

12pm

58°

1pm

60°

Thanks!

Weather

Play

An example of an assistant that renders the weather information in a streamed component.

## Towards the AI-native web

With Vercel AI SDK 3.0, we're simplifying how you integrate AI into your apps. By using React Server Components, you can now stream UI components directly from LLMs without the need for heavy client-side JavaScript. This means your apps can be more interactive and responsive, without compromising on performance.

This update makes it easier to build and maintain AI-powered features, helping you focus on creating great user experiences. We're excited to see what you ship.

[**Try the demo**\\
\\
Try an experimental preview of AI SDK 3.0 with Generative UI\\
\\
Try now](https://sdk.vercel.ai/demo)

## FAQ

- ### Do I need Next.js to use this?


  - The new APIs in the AI SDK 3.0 rely on React Server Components (RSC) and React Server Actions which are currently implemented in Next.js. They do not rely on any internal Next.js-specifics, so when other React frameworks like Remix or Waku complete their implementations of RSC, you'll be able to use them for Generative UI assuming they comply with React's spec.
- ### **Do React Server Components work with Next.js Pages Router?**


  - No. The new APIs rely on React Server Components and React Server Actions which are not implemented in Next.js Pages Router. However, as of Next.js 13, you can use both App Router and Pages Router in the same Next.js application.
- ### **What LLMs are currently supported?**


  - You can use the RSC APIs with any streaming LLM supported by the AI SDK. However, the [`render`](https://sdk.vercel.ai/docs/api-reference/generative-ui/render) method expects LLMs to support OpenAI's SDK and optionally its [Assistant Tools and Function Calling APIs](https://platform.openai.com/docs/guides/function-calling). We also provide lower-level streaming APIs can be used independently (even without an LLM). At the time of writing though, the new RSC-based [`render`](https://sdk.vercel.ai/docs/api-reference/generative-ui/render) API can be fully used with [OpenAI](https://platform.openai.com/docs/guides/function-calling), [Mistral](https://docs.mistral.ai/guides/function-calling), and [Fireworks](https://blog.fireworks.ai/fireworks-raises-the-quality-bar-with-function-calling-model-and-api-release-e7f49d1e98e9)' `firefunction-v1` model because of their support of the OpenAI SDK-compatible Function Calling.
- ### What if my LLM doesn't support tools or function calling?


  - You can still use the AI SDK 3.0 RSC APIs to stream text and your own components, or you can prompt engineer your LLM to output structured data that can be parsed and used with the AI SDK.
- ### **Does Generative UI work with OpenAI Assistants?**


  - You can use OpenAI Assistants as a persistence layer and function calling API with the AI SDK 3.0. Or you can manually perform the LLM calls with a provider or API of your choice.
- ### **Can anything be passed from the server to the client?**


  - Anythingserializable by Reactcan cross the network boundary between server and client. Promises, JavaScript primitives, and certain data structures like Map and Set can all be serialized by React. You can read more about React's serialization in [the React docs.](https://react.dev/reference/react/use-server#serializable-parameters-and-return-values)
- ### **Does this work with LangChain or LlamaIndex?**


  - Yes, with the [`createStreamableUI`](https://sdk.vercel.ai/docs/api-reference/generative-ui/create-streamable-ui) and [`createStreamableValue`](https://sdk.vercel.ai/docs/api-reference/generative-ui/create-streamable-value) primitives you can use any JavaScript library as long as you can call it during the execution of a React Server Action. This means you can build Generative UI products with tools like [LangChain](https://www.langchain.com/), [LlamaIndex](https://www.llamaindex.ai/), agent abstractions, and with durable task runners like [Inngest](https://inngest.com/).