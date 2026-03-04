---
title: "Node.js Vercel Functions now support request cancellation - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-vercel-functions-now-support-request-cancellation"
date: "2025-04-23"
scraped_at: "2026-03-02T09:34:29.848298308+00:00"
language: "en-zh"
translated: true
description: "Vercel Functions using Node.js can now detect when a request cancellation and stop execution before completion."
---

render_with_liquid: false
Apr 23, 2025

2025 年 4 月 23 日

Request cancellation is now supported at the route level; you have to manually enable it in `vercel.json`. [Read more .](https://vercel.com/changelog/node-js-vercel-functions-now-support-per-path-request-cancellation)

路由级请求取消功能现已支持；您需在 `vercel.json` 中手动启用。[了解更多](https://vercel.com/changelog/node-js-vercel-functions-now-support-per-path-request-cancellation)

[Vercel Functions using Node.js](https://vercel.com/docs/functions/runtimes/node-js) can now detect when a request is cancelled and stop execution before completion. This includes actions like navigating away, closing a tab, or hitting stop on an AI chat to terminate compute processing early.

基于 Node.js 的 [Vercel Functions](https://vercel.com/docs/functions/runtimes/node-js) 现已支持检测请求是否被取消，并在完成前中止执行。此类场景包括：用户跳转至其他页面、关闭浏览器标签页，或在 AI 聊天界面点击“停止”以提前终止计算处理。

This reduces unnecessary compute, token generation, and sending data the user never see.

此举可减少不必要的计算资源消耗、Token 生成，以及向用户发送其实际不会看到的数据。

You can listen for cancellation using `Request.signal.aborted` or the [`abort`](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal) event:

您可通过 `Request.signal.aborted` 属性或 [`abort`](https://developer.mozilla.org/zh-CN/docs/Web/API/AbortSignal) 事件监听请求取消：

```javascript
export const GET = async (req: Request) => {

2  const abortController = new AbortController();



4  req.signal.addEventListener("abort", () => {

5    console.log("request aborted");
```

6    abortController.abort();

6    abortController.abort();

7  });

7  });

9  const res = await fetch("https://my-backend-service.example.com", {

9  const res = await fetch("https://my-backend-service.example.com", {

10    headers: {

10    headers: {

11      Authorization: `Bearer ${process.env.AUTH_TOKEN}`,

11      Authorization: `Bearer ${process.env.AUTH_TOKEN}`,

12    },

12    },

13    signal: abortController.signal,

13    signal: abortController.signal,

14  });

14  });

16  return new Response(res.body, {

16  返回新的 Response(res.body, {

17    status: res.status,

17    状态: res.status,

18    headers: res.headers,

18    响应头: res.headers,

19  });

19  });

20};

20};

If you're using the [AI SDK](https://sdk.vercel.ai/docs/advanced/stopping-streams#ai-sdk-core), forward the `abortSignal` to your stream:

如果您正在使用 [AI SDK](https://sdk.vercel.ai/docs/advanced/stopping-streams#ai-sdk-core)，请将 `abortSignal` 转发给您的流：

```javascript
import { openai } from '@ai-sdk/openai';

import { streamText } from 'ai';



export async function POST(req: Request) {

```javascript
import { openai } from '@ai-sdk/openai';

import { streamText } from 'ai';



export async function POST(req: Request) {

5  const { prompt } = await req.json();

5  const { prompt } = await req.json();

6  const result = streamText({

6  const result = streamText({

7    model: openai('gpt-4-turbo'),

7    model: openai('gpt-4-turbo'),

8    prompt,

8    prompt,

9    // forward the abort signal

9    // 转发中止信号

10    abortSignal: req.signal,

10    abortSignal: req.signal,

11  });

11  });

12  return result.toTextStreamResponse();

12  return result.toTextStreamResponse();

13}

13}

```

```

Learn more about [cancelling Function requests](https://vercel.com/docs/functions/functions-api-reference#cancel-requests).

更多关于[取消 Function 请求](https://vercel.com/docs/functions/functions-api-reference#cancel-requests)的信息。