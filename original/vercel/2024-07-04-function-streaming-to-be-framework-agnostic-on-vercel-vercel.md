---
title: "Function streaming to be framework-agnostic on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-functions-streaming-to-be-framework-agnostic"
date: "2024-07-04"
scraped_at: "2026-03-02T09:43:07.986788139+00:00"
language: "en"
translated: false
description: "Function streaming now framework-agnostic on Vercel."
---




Jul 4, 2024

Streaming will soon be enabled by default for all Node.js Vercel Functions

In 2023, Vercel Functions added support for [streaming HTTP responses](https://vercel.com/blog/streaming-for-serverless-node-js-and-edge-runtimes-with-vercel-functions).

This feature has been enabled for frameworks like Next.js (App Router), SvelteKit, Remix, and more. We've been progressively rolling out streaming to more frameworks over the past two years, and we're beginning to roll out streaming for [all functions](https://vercel.com/docs/functions/runtimes/node-js) and compatible frameworks.

## What changes when streaming responses?

When your Vercel Functions stream responses instead of buffering, you can immediately return results to your visitors—either an API function response or a server-side template.

## Responses on runtime errors

When streaming, response headers are sent immediately with the initial stream. If there is a runtime error after the initial headers have been sent, the function closes the stream and logs an error to Vercel. For example:

api/index.js

```javascript
import { setTimeout } from "node:timers/promises";



export default async function (req, res) {

4  res.writeHead(200, { "Content-Type": "text/plain" });

5  res.write("Chunk 1\\n");

6  await setTimeout(1000);

7  throw new Error("Oh no!");

8}
```

An example function that writes to the response with a delay.

When buffering a response and not streaming, this function would not respond for several seconds. Since the function throws an error before completion, it would respond with a `500` error:

```bash
HTTP/2 500

cache-control: public, max-age=0, must-revalidate

content-type: text/plain; charset=utf-8

date: Mon, 24 Jun 2024 10:26:35 GMT

server: Vercel

strict-transport-security: max-age=63072000; includeSubDomains; preload

x-robots-tag: noindex

x-vercel-error: FUNCTION_INVOCATION_FAILED

x-vercel-id: cdg1::hgz6d-1719224792404-c4031128df3b

content-length: 56



A server error has occurred



FUNCTION_INVOCATION_FAILED
```

An example of a 500 error response from a Vercel Function.

When streaming is enabled, the response status code and part of the body will have already been sent to the client. The stream will send the status code and part of the body before ending. For example, you would then see `Oh no!` error in the Vercel logs.

```bash
HTTP/2 200

age: 0

cache-control: public, max-age=0, must-revalidate

content-type: text/plain

date: Mon, 24 Jun 2024 10:29:58 GMT

server: Vercel

strict-transport-security: max-age=63072000; includeSubDomains; preload

x-robots-tag: noindex

x-vercel-cache: MISS

x-vercel-execution-region: iad1

x-vercel-id: cdg1::iad1::zclv9-1719224997952-452256b220b0



Chunk 1
```

An example of a 200 response from a streamed function.

## Enhanced runtime logs experience

Without streaming, Functions need to finish executing before a response can be sent to the client. Similarly, logs are only sent from the function and visible in the Vercel logs UI until after the function finishes responding.

When viewing runtime logs in the Logs tab, you would see a single line for each function invocation. The log line contains all context for that invocation up to `4KB` size limit. For example:

```javascript
import { setTimeout } from "node:timers/promises";



export default async function (req, res) {

4  console.log("Before setting a response");

5  res.writeHead(200, { "Content-Type": "text/plain" });

6  res.write("Chunk 1\\n");

7  await setTimeout(1000);

8  console.warn("Before writing a second chunk");

9  res.write("Chunk 2\\n");

10  await setTimeout(1000);

11  console.error("Before ending the response");

12  res.end("Done!");

13}
```

An example function that writes a response with a delay.

When this function is called three times in a row, we can see the following in Vercel Logs tab:

![](images/function-streaming-to-be-framework-agnostic-on-vercel-vercel/img_001.jpg)

We see three log lines above, each appearing only _after_ the function invocation had finished. Logs for each invocation are collapsed into a single line. Now, let's explore how this changes when we enable streaming.

![](images/function-streaming-to-be-framework-agnostic-on-vercel-vercel/img_002.jpg)

With streaming, each log statement gets its own line with a precise timestamp. Logs appear in near real-time, streaming in as they happen. You do not need to wait for the function invocation to complete to see logs.

You will notice the individual log lines do not display the status code. This is because logs are independent of the response and can occur before a status code is determined. With streaming being enabled by default, this brings consistency to the logs experience when using Vercel Functions.

These changes in frequency and format of Function logs will also affect Vercel Log Drains. If you are using Log Drains, ensure that your provider supports streaming responses and this increase frequency for logs.

## Enabling streaming functions today

Streaming will be enabled by default for Hobby accounts starting **July 8th, 2024;** and for Pro and Enterprise accounts starting **October 1st, 2024**.

To enable streaming as the default today for all your Vercel Functions, set the `VERCEL_FORCE_NODEJS_STREAMING` environment variable in your project to `true`. Streaming will be enabled on your next deployment.