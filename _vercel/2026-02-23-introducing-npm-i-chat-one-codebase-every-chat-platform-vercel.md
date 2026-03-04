---
title: "Introducing npm i chat – One codebase, every chat platform - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/chat-sdk"
date: "2026-02-23"
scraped_at: "2026-03-02T09:21:25.262800365+00:00"
language: "en-zh"
translated: true
description: "Chat SDK is now open source and available in public beta. It's a TypeScript library for building chat bots that work across Slack, Microsoft Teams, Google Chat, Discord, GitHub, and Linear — from a ..."
---

render_with_liquid: false
Feb 23, 2026

2026 年 2 月 23 日

传统上，在多个平台构建聊天机器人需要维护各自独立的代码库，并分别对接各平台的 API。

今天，我们正式开源全新 [**Chat SDK**](https://chat-sdk.dev/)，进入公开测试（public beta）阶段。这是一个统一的 TypeScript 库，使团队只需编写一次机器人逻辑，即可将其部署至 Slack、Microsoft Teams、Google Chat、Discord、GitHub 和 Linear 等平台。

该 SDK 采用事件驱动架构，提供类型安全的处理器（handlers），支持提及（mentions）、消息（messages）、表情反应（reactions）、按钮点击（button clicks）和斜杠命令（slash commands）。团队可使用 JSX 编写卡片（cards）和模态框（modals）等用户界面组件，这些组件将在各平台原生渲染。

SDK 通过可插拔的适配器（adapters）实现分布式状态管理，支持 Redis、ioredis 及内存存储（in-memory storage）等多种后端。

```typescript
import { Chat } from "chat";

import { createSlackAdapter } from "@chat-adapter/slack";

import { createRedisState } from "@chat-adapter/state-redis";

const bot = new Chat({

6  userName: "mybot",

6  用户名: "mybot",

7  adapters: {

7  适配器: {

8    slack: createSlackAdapter(),

8    slack: createSlackAdapter(),

9  },

9  },

10  state: createRedisState(),

10  状态管理: createRedisState(),

11});



11});



bot.onNewMention(async (thread) => {

bot.onNewMention(async (thread) => {

14  await thread.subscribe();

14  await thread.subscribe();

15  await thread.post("Hello! I am listening to this thread.");

15  await thread.post("你好！我正在监听此会话。");

16});
```

一个使用 Slack 适配器和 Redis 状态的 Chat 实例的简单示例，该实例会对新的提及（@mention）作出响应。

你可以向任意消息提供方发送字符串、对象、AST，甚至 JSX！

```jsx
import { Card, CardText, Actions, Button } from "chat";



await thread.post(

4  <Card title="Order #1234">

5    <CardText>Your order has been received!</CardText>

6    <Actions>

7      <Button id="approve" style="primary">Approve</Button>
```

4  <Card title="订单 #1234">

5    <CardText>您的订单已收到！</CardText>

6    <Actions>

7      <Button id="approve" style="primary">批准</Button>

8      <Button id="reject" style="danger">Reject</Button>

8      <Button id="reject" style="danger">拒绝</Button>

9    </Actions>

9    </Actions>

10  </Card>

10  </Card>

11);
```

Chat SDK `post()` functions accept an AI SDK text stream, enabling real-time streaming of AI responses and other incremental content to chat platforms.

Chat SDK 的 `post()` 函数接受 AI SDK 的文本流，从而实现在聊天平台中实时流式传输 AI 响应及其他增量内容。

```jsx
import { ToolLoopAgent } from "ai";



const agent = new ToolLoopAgent({

4  model: "anthropic/claude-4.6-sonnet",

4  model: "anthropic/claude-4.6-sonnet",

5  instructions: "You are a helpful assistant.",

5  instructions: "你是一位乐于助人的助手。"

6});  

6）；

bot.onNewMention(async (thread, message) => {  

bot.onNewMention(async (thread, message) => {

9  const result = await agent.stream({ prompt: message.text });  

9  const result = await agent.stream({ prompt: message.text });

10  await thread.post(result.textStream);  

10  await thread.post(result.textStream);

11});  
11}）；

The framework starts with the core `chat` package and scales through modular platform adapters. Guides are available for building a Slack bot with Next.js and Redis, a Discord support bot with Nuxt, a GitHub bot with Hono, and automated code review bots.  

该框架以核心 `chat` 包为起点，通过模块化的平台适配器实现灵活扩展。我们提供了多份指南，涵盖如何使用 Next.js 与 Redis 构建 Slack 机器人、使用 Nuxt 构建 Discord 支持机器人、使用 Hono 构建 GitHub 机器人，以及构建自动化代码审查机器人。

Explore the [documentation](https://chat-sdk.dev/docs) to learn more.  

请访问 [文档](https://chat-sdk.dev/docs) 了解更多信息。

Looking for the chatbot template? It's now [here](https://chatbot.ai-sdk.dev/).  

在寻找聊天机器人模板吗？它现已迁移至 [此处](https://chatbot.ai-sdk.dev/)。