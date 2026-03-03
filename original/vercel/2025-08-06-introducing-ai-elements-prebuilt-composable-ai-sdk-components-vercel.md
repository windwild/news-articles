---
title: "Introducing AI Elements: Prebuilt, composable AI SDK components - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-ai-elements"
date: "2025-08-06"
scraped_at: "2026-03-02T09:30:11.856415237+00:00"
language: "en"
translated: false
description: "Focus on your AI’s intelligence, not the UI scaffolding. AI Elements is now available as a new Vercel product to help frontend engineers build AI-driven interfaces in a fraction of the time."
---




Aug 6, 2025

![](images/introducing-ai-elements-prebuilt-composable-ai-sdk-components-vercel/img_001.jpg)![](images/introducing-ai-elements-prebuilt-composable-ai-sdk-components-vercel/img_002.jpg)

[AI Elements](https://ai-sdk.dev/elements/overview) is a new open source library of customizable React components for building interfaces with the Vercel AI SDK.

Built on [`shadcn/ui`](https://ui.shadcn.com/), it provides full control over UI primitives like message threads, input boxes, reasoning panels, and response actions.

For example, you can use `useChat` from the [AI SDK](https://ai-sdk.dev/) to manage state and streaming, and render responses using AI Elements.

```tsx
import { Message, MessageContent } from "@/components/ai-elements/message";

import { Response } from "@/components/ai-elements/response";

import { useChat } from "@ai-sdk/react";



export default function Example() {

6  const { messages } = useChat();



8  return messages.map((message) => (

9    <Message from={message.role} key={message.id}>

10      <MessageContent>

11        {message.parts

12          .filter((part) => part.type === "text")

13          .map((part, i) => (

14            <Response key={`${message.id}-${i}`}>{part.text}</Response>

15          ))}

16      </MessageContent>

17    </Message>

18  ));

19}
```

### **Getting started**

To install the components, you can initialize with [our CLI](https://ai-sdk.dev/elements/overview/setup), and pick your components, import them, and start building.

Terminal

```bash
npx ai-elements@latest
```

[Read the docs](https://ai-sdk.dev/elements/overview) and start building better AI interfaces, faster.

AI Elements replaces ChatSDK with a more flexible set of UI building blocks for AI interfaces. ChatSDK will be migrated to a dedicated Next.js template. Future templates will use AI Elements to support a wider range of AI-native interface patterns beyond chat.