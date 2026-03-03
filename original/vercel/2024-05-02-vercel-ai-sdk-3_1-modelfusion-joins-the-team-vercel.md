---
title: "Vercel AI SDK 3.1: ModelFusion joins the team - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-ai-sdk-3-1-modelfusion-joins-the-team"
date: "2024-05-02"
scraped_at: "2026-03-02T09:45:20.124108405+00:00"
language: "en"
translated: false
description: "ModelFusion joins Vercel "
---




May 2, 2024

One step closer to a complete TypeScript framework for AI applications

Today, we're releasing the AI SDK 3.1, with [ModelFusion](https://modelfusion.dev/) joining our team.

This release brings us one step closer to delivering a **complete TypeScript framework for building AI applications**. It is organized into three main parts:

- [**AI SDK Core**](https://sdk.vercel.ai/docs/ai-sdk-core): A unified API for generating text, structured objects, and tool calls with large language models (LLMs).

- [**AI SDK UI**](https://sdk.vercel.ai/docs/ai-sdk-ui): A set of framework-agnostic hooks for quickly building chat interfaces.

- [**AI SDK RSC**](https://sdk.vercel.ai/docs/ai-sdk-rsc): A library to stream generative user interfaces with React Server Components (RSC).


A streaming Node.js chatbot built with the AI SDK Core APIs

## AI SDK Core - A new foundation for AI

Drawing inspiration from projects like Drizzle and Prisma, you can imagine the AI SDK Core as an **ORM-style abstraction for LLMs**.

These new APIs provide a set of unified, low-level primitives to work with LLMs in any JavaScript environment—abstracting away the quirks between major model providers. This simplifies integrating LLMs down to just two decisions:

- What kind of data do you want to generate? (text or a structured object)

- How do you want it delivered? (incrementally streamed or all-at-once)


![](images/vercel-ai-sdk-3_1-modelfusion-joins-the-team-vercel/img_001.jpg)![](images/vercel-ai-sdk-3_1-modelfusion-joins-the-team-vercel/img_002.jpg)

You can use the AI SDK Core API with any provider that implements the [AI SDK Language Model Specification](https://sdk.vercel.ai/providers/community-providers/custom-providers). We worked with major AI model providers to iterate on the Vercel AI SDK Core, and already support:

- **OpenAI**

- **Anthropic**

- **Google Gemini**

- **Mistral**


The Language Model Specification is open-source. Anyone can now build AI provider integrations that work seamlessly with the Vercel AI SDK, and our amazing community has already started to add support for providers such as LLamaCpp.

### Generating text

Here’s an example of generating text with AI SDK Core using the `mistral-large-latest` model from [Mistral AI](https://mistral.ai/).

```tsx
import { generateText } from 'ai';

import { mistral } from '@ai-sdk/mistral';‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌



const { text } = await generateText({

5  model: mistral("‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌mistral-large-latest‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌"),

6  prompt: "Generate a lasangna recipe.",

7});﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌
```

If you want to switch out the model for OpenAI’s `gpt-4-turbo`, you can do so by changing two lines of code.

```tsx
import { generateText } from 'ai';

import { openai } from '@ai-sdk/openai';



const { text } = await generateText({

5  model: openai("gpt-4-turbo"),

6  prompt: "Generate a lasagna recipe.",

7});‌﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌‌‍﻿﻿‌‍﻿﻿‌﻿‍‌﻿‌‌‍‌‌‌‍​﻿‌‍‌‍‌﻿‌‍‌‌‌‍‍‍‌‌﻿﻿‌‌‌‍﻿‍‌﻿﻿‌‌‌‌﻿‌﻿‍‌‌﻿‌‍​‍‌‍‌﻿‌﻿﻿‌‌‍‌‌﻿﻿‌
```

### Generating Structured Data

The Vercel AI SDK standardizes structured object generation across model providers with the `generateObject` and `streamObject` functions. Generating fully typed objects is as simple as defining a [Zod schema](https://sdk.vercel.ai/docs/ai-sdk-core/schemas-and-zod) and passing it to your function call.

```tsx
import { generateObject } from 'ai'

import { z } from 'zod'

import { openai } from '@ai-sdk/openai';



const { object } = await generateObject({

6  model: openai('gpt-4-turbo'),

7  schema: z.object({

8    recipe: z.object({

9      name: z.string().describe('name of recipe'),

10      ingredients: z.array(

11        z.object({

12          name: z.string().describe('ingredient name'),

13          amount: z.string().describe('amount of ingredient')

14        })

15      ),

16      steps: z.array(z.string()).describe('steps to prepare recipe')

17    })

18  }),

19  prompt: 'Generate a lasagna recipe.'

20})
```

The model returns a validated and type-safe object — in this case, a lasagna recipe — based on your predetermined schema.

```json
1{

2  "name": "Classic Lasagna",

3  "ingredients": [\
\
4    {\
\
5      "name": "Olive oil",\
\
6      "amount": "2 tablespoons"\
\
7    },\
\
8    ...\
\
9  ],

10  "steps": [\
\
11    "Preheat oven to 375°F (190°C).",\
\
12    "In a large skillet, heat olive oil over medium heat. Add ground beef, onion, and garlic. Cook until beef is browned.",\
\
13    ...\
\
14  ]

15}
```

## AI SDK UI - Chat interface in seconds

Streaming conversational text UIs (like ChatGPT) have gained massive popularity over the past year. However, a basic chat interface still requires complex boilerplate: state management (tracking client input, conversation history, loading state), logic to parse and process streaming text, lifecycle hooks to manage persistent data, and more.

AI SDK UI simplifies the implementation of popular AI interfaces into three framework-agnostic hooks, `useChat`, `useCompletion`, and `useAssistant`. Together with AI SDK Core’s `streamText` function, you can build a streaming chatbot in less than 50 lines of code.

app/api/chat/route.ts

```tsx
import { streamText } from 'ai';

import { openai } from '@ai-sdk/openai';



export async function POST(req: Request) {

5  const { messages } = await req.json();



7  const result = await streamText({

8    model: openai('gpt-4-turbo'),

9    messages,

10  });



12  return result.toAIStreamResponse();

13}
```

app/page.tsx

```tsx
1'use client'



import { useChat } from 'ai/react'



export default function Page() {

6  const { messages, input, handleInputChange, handleSubmit } = useChat();



8  return (

9    <>

10      {messages.map(message => (

11        <div key={message.id}>

12          {message.role === 'user' ? 'User: ' : 'AI: '}

13          {message.content}

14        </div>

15      ))}

16      <form onSubmit={handleSubmit}>

17        <input

18          name="prompt"

19          value={input}

20          onChange={handleInputChange}

21          id="input"

22        />

23        <button type="submit">Submit</button>

24      </form>

25    </>

26  )

27}
```

In this [Next.js App Router](https://nextjs.org/docs/app) example, the `useChat` hook enables streaming chat messages from OpenAI, manages the chat state, and updates the UI automatically as new messages arrive.

## AI SDK RSC - Move beyond text

While AI chatbots have made a profound impact, LLM applications have faced two important UX challenges:

- Limited or imprecise knowledge

- Plain text or markdown-only responses


With the introduction of [Tools and Tool Calling](https://sdk.vercel.ai/docs/ai-sdk-core/tools-and-tool-calling), developers can build more robust applications that fetch realtime data.

With Vercel AI SDK RSC, you can now move beyond text-based chatbots to give LLMs rich, component-based interfaces.

In today's release, we're adding `streamUI`, a new function that's compatible with AI SDK Core Language Model Specification. This is the successor to `render` (which we plan to deprecate in the next minor release).

Let’s look at an example React Server Action that can retrieve the live weather and render a custom UI with `streamUI`.

```jsx
import { streamUI } from 'ai/rsc'

import { openai } from '@ai-sdk/openai'

import { z } from 'zod'

import { Spinner, Weather } from '@/components'

import { getWeather } from '@/utils'



async function submitMessage(userInput) { // 'What is the weather in SF?'

8  'use server'



10  const result = streamUI({

11    model: openai('gpt-4-turbo'),

12    messages: [\
\
13      { role: 'system', content: 'You are a helpful assistant' },\
\
14      { role: 'user', content: userInput }\
\
15    ],

16    text: ({ content }) => <p>{content}</p>,

17    tools: {

18      get_city_weather: {

19        description: 'Get the current weather for a city',

20        parameters: z.object({

21          city: z.string().describe('the city')

22        }).required(),

23        generate: async function* ({ city }) {

24          yield <Spinner/>

25          const weather = await getWeather(city)

26          return <Weather info={weather} />

27        }

28      }

29    }

30  })



32  return result.value

33}
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

## Towards a complete TypeScript AI framework

The Vercel AI SDK 3.1 marks an important step towards delivering a complete TypeScript AI Framework.

- With the **AI SDK Core**, you get a unified API for calling LLMs that works anywhere JavaScript or TypeScript runs.

- With the **AI SDK UI**, you can build chat interfaces in seconds with framework-agnostic hooks.

- Finally, with the **AI SDK RSC**, you can go beyond chat interfaces to deliver the next generation of AI native applications with Generative UI.


You can learn more in **our new** [**documentation**](https://sdk.vercel.ai/docs) or experiment with different models using the [AI playground](https://sdk.vercel.ai/).

[**Explore the possibilities**\\
\\
Talk to our team to learn more about building AI-powered applications for your organization. \\
\\
Get started](https://vercel.com/contact)