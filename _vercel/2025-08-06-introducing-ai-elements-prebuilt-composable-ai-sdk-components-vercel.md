---
title: "Introducing AI Elements: Prebuilt, composable AI SDK components - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-ai-elements"
date: "2025-08-06"
scraped_at: "2026-03-02T09:30:11.856415237+00:00"
language: "en-zh"
translated: true
description: "Focus on your AI’s intelligence, not the UI scaffolding. AI Elements is now available as a new Vercel product to help frontend engineers build AI-driven interfaces in a fraction of the time."
---

Aug 6, 2025

2025 年 8 月 6 日

![](images/introducing-ai-elements-prebuilt-composable-ai-sdk-components-vercel/img_001.jpg)![](images/introducing-ai-elements-prebuilt-composable-ai-sdk-components-vercel/img_002.jpg)

[AI Elements](https://ai-sdk.dev/elements/overview) 是一个全新的开源库，提供可定制的 React 组件，用于基于 Vercel AI SDK 构建用户界面。

该库基于 [`shadcn/ui`](https://ui.shadcn.com/) 构建，让你对各类 UI 基础组件（如消息线程、输入框、推理面板和响应操作）拥有完全控制权。

例如，你可以使用 [AI SDK](https://ai-sdk.dev/) 提供的 `useChat` 钩子来管理状态与流式响应，并借助 AI Elements 渲染响应内容。

```tsx
import { Message, MessageContent } from "@/components/ai-elements/message";

import { Response } from "@/components/ai-elements/response";

import { useChat } from "@ai-sdk/react";

export default function Example() {

6  const { messages } = useChat();

6  const { messages } = useChat();

8  return messages.map((message) => (

8  return messages.map((message) => (

9    <Message from={message.role} key={message.id}>

9    <Message from={message.role} key={message.id}>

10      <MessageContent>

10      <MessageContent>

11        {message.parts

11        {message.parts

12          .filter((part) => part.type === "text")

12          .filter((part) => part.type === "text")

13          .map((part, i) => (

13          .map((part, i) => (

14            <Response key={`${message.id}-${i}`}>{part.text}</Response>

14            <Response key={`${message.id}-${i}`}>{part.text}</Response>

15          ))}

16      </MessageContent>

16      </MessageContent>

17    </Message>

17    </Message>

18  ));

18  ));

19}
```

19}
```

### **Getting started**

### **入门指南**

To install the components, you can initialize with [our CLI](https://ai-sdk.dev/elements/overview/setup), and pick your components, import them, and start building.

要安装这些组件，您可以使用 [我们的 CLI 工具](https://ai-sdk.dev/elements/overview/setup) 进行初始化，从中选择所需组件、导入后即可开始构建。

Terminal

终端

```bash
npx ai-elements@latest
```

```bash
npx ai-elements@latest
```

[Read the docs](https://ai-sdk.dev/elements/overview) and start building better AI interfaces, faster.

[查阅文档](https://ai-sdk.dev/elements/overview)，更快地构建更优质的 AI 界面。

AI Elements replaces ChatSDK with a more flexible set of UI building blocks for AI interfaces. ChatSDK will be migrated to a dedicated Next.js template. Future templates will use AI Elements to support a wider range of AI-native interface patterns beyond chat.

AI Elements 以一套更灵活的 UI 构建模块取代了 ChatSDK，专为 AI 界面而设计。ChatSDK 将迁移至一个独立的 Next.js 模板中。未来的所有模板都将基于 AI Elements 构建，从而支持更广泛的 AI 原生界面模式（不仅限于聊天场景）。