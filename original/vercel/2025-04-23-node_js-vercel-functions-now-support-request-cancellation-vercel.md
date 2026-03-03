---
title: "Node.js Vercel Functions now support request cancellation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-vercel-functions-now-support-request-cancellation"
date: "2025-04-23"
scraped_at: "2026-03-02T09:34:29.848298308+00:00"
language: "en"
translated: false
description: "Vercel Functions using Node.js can now detect when a request cancellation and stop execution before completion."
---




Apr 23, 2025

Request cancellation is now supported at the route level; you have to manually enable it in `vercel.json`. [Read more .](https://vercel.com/changelog/node-js-vercel-functions-now-support-per-path-request-cancellation)

[Vercel Functions using Node.js](https://vercel.com/docs/functions/runtimes/node-js) can now detect when a request is cancelled and stop execution before completion. This includes actions like navigating away, closing a tab, or hitting stop on an AI chat to terminate compute processing early.

This reduces unnecessary compute, token generation, and sending data the user never see.

You can listen for cancellation using `Request.signal.aborted` or the [`abort`](https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal) event:

```javascript
export const GET = async (req: Request) => {

2  const abortController = new AbortController();



4  req.signal.addEventListener("abort", () => {

5    console.log("request aborted");

6    abortController.abort();

7  });



9  const res = await fetch("https://my-backend-service.example.com", {

10    headers: {

11      Authorization: `Bearer ${process.env.AUTH_TOKEN}`,

12    },

13    signal: abortController.signal,

14  });



16  return new Response(res.body, {

17    status: res.status,

18    headers: res.headers,

19  });

20};
```

If you're using the [AI SDK](https://sdk.vercel.ai/docs/advanced/stopping-streams#ai-sdk-core), forward the `abortSignal` to your stream:

```javascript
import { openai } from '@ai-sdk/openai';

import { streamText } from 'ai';



export async function POST(req: Request) {

5  const { prompt } = await req.json();

6  const result = streamText({

7    model: openai('gpt-4-turbo'),

8    prompt,

9    // forward the abort signal

10    abortSignal: req.signal,

11  });

12  return result.toTextStreamResponse();

13}
```

Learn more about [cancelling Function requests](https://vercel.com/docs/functions/functions-api-reference#cancel-requests).