---
title: "Deploy Slack's Bolt.js to Vercel with @vercel/slack-bolt - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/build-slack-agents-with-vercel-slack-bolt"
date: "2025-08-27"
scraped_at: "2026-03-02T09:29:24.367474217+00:00"
language: "en-zh"
translated: true
description: "Deploy your Slack agent to Vercel's AI Cloud using @vercel/slack-bolt to take advantage of AI Gateway, Fluid compute, and more."
---

render_with_liquid: false
Aug 27, 2025

2025 年 8 月 27 日

We've published [`@vercel/slack-bolt`](https://www.npmjs.com/package/@vercel/slack-bolt), our official adapter for deploying Slack's [Bolt for JavaScript](https://docs.slack.dev/tools/bolt-js/) to Vercel's AI Cloud.

我们已发布官方适配器 [`@vercel/slack-bolt`](https://www.npmjs.com/package/@vercel/slack-bolt)，用于将 Slack 的 [Bolt for JavaScript](https://docs.slack.dev/tools/bolt-js/) 部署至 Vercel AI Cloud。

Bolt provides a type-safe library for responding to Slack webhook events. However, Slack's API requires a response within three seconds or users are faced with timeouts. This has made it hard to build Slack agents on traditional serverless platforms.

Bolt 提供了一个类型安全的库，用于响应 Slack 的 Webhook 事件。然而，Slack 的 API 要求在三秒内返回响应，否则用户将遭遇超时。这使得在传统无服务器平台上构建 Slack 智能体（agent）变得十分困难。

Our adapter uses [Fluid compute’s](https://vercel.com/fluid) streaming and `waitUntil` to acknowledge responses within Slack’s deadline while your agent continues working in the background.

我们的适配器利用 [Fluid Compute](https://vercel.com/fluid) 的流式传输能力与 `waitUntil` 功能，在 Slack 规定的时限内及时发送响应确认，同时让您的智能体在后台持续运行。

api/slack/events.ts

`api/slack/events.ts`

```javascript
import { App } from "@slack/bolt";

import { generateText } from "ai";

import { VercelReceiver, createHandler } from "@vercel/slack-bolt";



const receiver = new VercelReceiver();
```

```javascript
const app = new App({

8  token: process.env.SLACK_BOT_TOKEN,

9  signingSecret: process.env.SLACK_SIGNING_SECRET,

10  receiver,

11  deferInitialization: true,

12});

```

```javascript
const app = new App({

8  token: process.env.SLACK_BOT_TOKEN,

9  signingSecret: process.env.SLACK_SIGNING_SECRET,

10  receiver,

11  deferInitialization: true,

12});

```

// listening to Slack messages

// 监听 Slack 消息

app.event("message", async ({ say, message }) => {  

app.event("message", async ({ say, message }) => {  
```

16  const { text } = await generateText({

16  const { text } = await generateText({

17    model: "openai/gpt-5",

17    model: "openai/gpt-5",

18    prompt: `Respond to the user's message: ${message.text}`,

18    prompt: `回应用户的消息：${message.text}`,

19  });

19  });

20  // responding to Slack

20  // 响应 Slack 消息

21  await say(text);

21  await say(text);

22});



22});



export const POST = createHandler(app, receiver);
```

export const POST = createHandler(app, receiver);
```

Listen to Slack messages and respond using the AI SDK

监听 Slack 消息，并使用 AI SDK 进行响应

This adapter works with any function or framework using the Web API Request object such as Hono, Nitro or Next.js.

该适配器可与任何使用 Web API Request 对象的函数或框架配合使用，例如 Hono、Nitro 或 Next.js。

[**Slack Agent Template**\\
\\
Deploy your Slack agent on Vercel's AI Cloud\\
\\
Deploy Now](https://vercel.com/templates/ai/slack-agent-template)

[**Slack 代理模板**\\
\\
在 Vercel 的 AI Cloud 上部署您的 Slack 代理\\
\\
立即部署](https://vercel.com/templates/ai/slack-agent-template)

Get started with our [Slack Agent Template](https://vercel.com/templates/ai/slack-agent-template) today or [visit the library on npm](https://www.npmjs.com/package/@vercel/slack-bolt).

今天就通过我们的 [Slack 代理模板](https://vercel.com/templates/ai/slack-agent-template) 快速上手，或 [访问 npm 上的库](https://www.npmjs.com/package/@vercel/slack-bolt)。