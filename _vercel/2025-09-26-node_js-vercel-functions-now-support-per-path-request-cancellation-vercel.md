---
title: "Node.js Vercel Functions now support per-path request cancellation  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-vercel-functions-now-support-per-path-request-cancellation"
date: "2025-09-26"
scraped_at: "2026-03-02T09:28:28.064192439+00:00"
language: "en-zh"
translated: true
description: "Vercel Functions using Node.js can now detect when a request is cancelled and stop execution before completion. This includes actions like navigating away, closing a tab, or hitting stop on an AI chat..."
---
{% raw %}

Sep 26, 2025

2025 年 9 月 26 日

[Vercel Functions using Node.js](https://vercel.com/docs/functions/runtimes/node-js) can now detect when a request is cancelled and stop execution before completion. This is configurable on a per-path basis, and includes actions like navigating away, closing a tab, or hitting stop on an AI chat to terminate compute processing early.

[Vercel Functions（基于 Node.js）](https://vercel.com/docs/functions/runtimes/node-js) 现在能够检测请求是否被取消，并在执行完成前中止运行。该功能支持按路径粒度进行配置，涵盖用户离开当前页面、关闭浏览器标签页，或在 AI 聊天界面点击“停止”按钮等操作，从而提前终止计算处理。

This reduces unnecessary compute, token generation, and sending data the user would never see.

此举可减少不必要的计算资源消耗、无效的 token 生成，以及向用户发送其根本不会看到的数据。

To enable cancellation, add `"supportsCancellation": true` to your `vercel.json` configuration. You can apply it to specific paths or all functions:

如需启用请求取消功能，请在 `vercel.json` 配置文件中添加 `"supportsCancellation": true`。您可将其应用于特定路径，也可应用于全部函数：

vercel.json

vercel.json

```json
1{

2  "functions": {

3    "api/*": {

4      "supportsCancellation": true

5    }
```

6  }

7}
```

启用后，你可以通过 `Request.signal.aborted` 属性或 [`abort`](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal) 事件来监听取消操作：

```javascript
export const GET = async (req: Request) => {

2  const abortController = new AbortController();



4  req.signal.addEventListener("abort", () => {

5    console.log("请求已被取消");

6    abortController.abort();

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

16  return new Response(res.body, {

17    status: res.status,

17    status: res.status,

18    headers: res.headers,

18    头部信息：res.headers，

19  });

19  });

20};

20};

```

If you’re using the [AI SDK](https://ai-sdk.dev/docs/advanced/stopping-streams#ai-sdk-core), forward the `abortSignal` to your stream:

```

如果您正在使用 [AI SDK](https://ai-sdk.dev/docs/advanced/stopping-streams#ai-sdk-core)，请将 `abortSignal` 传递给您的流：

```javascript
import { openai } from '@ai-sdk/openai';

import { streamText } from 'ai';



export async function POST(req: Request) {

5  const { prompt } = await req.json();

6  const result = streamText({ 

5  const { prompt } = await req.json();

5  const { prompt } = await req.json();

6  const result = streamText({ 

6  const result = streamText({

7    model: openai('gpt-4-turbo'),

7    模型：openai('gpt-4-turbo')，

8    prompt,

8    提示词（prompt），

9    // forward the abort signal

9    // 转发中止信号

10    abortSignal: req.signal,

10    abortSignal: req.signal，

11  });

11  });

12  return result.toTextStreamResponse();

12  return result.toTextStreamResponse();

13}
```

13}
```

Learn more about [cancelling Function requests](https://vercel.com/docs/functions/functions-api-reference#cancel-requests).

了解更多关于[取消 Function 请求](https://vercel.com/docs/functions/functions-api-reference#cancel-requests)的信息。
{% endraw %}
