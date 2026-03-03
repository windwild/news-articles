---
title: "Introducing npm i chat – One codebase, every chat platform - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/chat-sdk"
date: "2026-02-23"
scraped_at: "2026-03-02T09:21:25.262800365+00:00"
language: "en"
translated: false
description: "Chat SDK is now open source and available in public beta. It's a TypeScript library for building chat bots that work across Slack, Microsoft Teams, Google Chat, Discord, GitHub, and Linear — from a ..."
---




Feb 23, 2026

Building chatbots across multiple platforms traditionally requires maintaining separate codebases and handling individual platform APIs.

Today, we're open sourcing the new [**Chat SDK**](https://chat-sdk.dev/) in public beta. It's a unified TypeScript library that lets teams write bot logic once and deploy it to Slack, Microsoft Teams, Google Chat, Discord, GitHub, and Linear.

The event-driven architecture includes type-safe handlers for mentions, messages, reactions, button clicks, and slash commands. Teams can build user interfaces using JSX cards and modals that render natively on each platform.

The SDK handles distributed state management using pluggable adapters for Redis, ioredis, and in-memory storage.

```typescript
import { Chat } from "chat";

import { createSlackAdapter } from "@chat-adapter/slack";

import { createRedisState } from "@chat-adapter/state-redis";



const bot = new Chat({

6  userName: "mybot",

7  adapters: {

8    slack: createSlackAdapter(),

9  },

10  state: createRedisState(),

11});



bot.onNewMention(async (thread) => {

14  await thread.subscribe();

15  await thread.post("Hello! I am listening to this thread.");

16});
```

A simple example of Chat instance with a Slack adapter and Redis state that responds to new mentions.

You can post messages to any provider with strings, objects, ASTs and even JSX!

```jsx
import { Card, CardText, Actions, Button } from "chat";



await thread.post(

4  <Card title="Order #1234">

5    <CardText>Your order has been received!</CardText>

6    <Actions>

7      <Button id="approve" style="primary">Approve</Button>

8      <Button id="reject" style="danger">Reject</Button>

9    </Actions>

10  </Card>

11);
```

Chat SDK `post()` functions accept an AI SDK text stream, enabling real-time streaming of AI responses and other incremental content to chat platforms.

```jsx
import { ToolLoopAgent } from "ai";



const agent = new ToolLoopAgent({

4  model: "anthropic/claude-4.6-sonnet",

5  instructions: "You are a helpful assistant.",

6});



bot.onNewMention(async (thread, message) => {

9  const result = await agent.stream({ prompt: message.text });

10  await thread.post(result.textStream);

11});
```

The framework starts with the core `chat` package and scales through modular platform adapters. Guides are available for building a Slack bot with Next.js and Redis, a Discord support bot with Nuxt, a GitHub bot with Hono, and automated code review bots.

Explore the [documentation](https://chat-sdk.dev/docs) to learn more.

Looking for the chatbot template? It's now [here](https://chatbot.ai-sdk.dev/).