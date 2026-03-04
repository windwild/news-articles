---
title: "Function streaming to be framework-agnostic on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-functions-streaming-to-be-framework-agnostic"
date: "2024-07-04"
scraped_at: "2026-03-02T09:43:07.986788139+00:00"
language: "en-zh"
translated: true
description: "Function streaming now framework-agnostic on Vercel."
---

render_with_liquid: false
Jul 4, 2024

Jul 4, 2024

Streaming will soon be enabled by default for all Node.js Vercel Functions

所有 Node.js Vercel 函数即将默认启用流式响应（streaming）。

In 2023, Vercel Functions added support for [streaming HTTP responses](https://vercel.com/blog/streaming-for-serverless-node-js-and-edge-runtimes-with-vercel-functions).

2023 年，Vercel Functions 增加了对 [流式 HTTP 响应](https://vercel.com/blog/streaming-for-serverless-node-js-and-edge-runtimes-with-vercel-functions) 的支持。

This feature has been enabled for frameworks like Next.js (App Router), SvelteKit, Remix, and more. We've been progressively rolling out streaming to more frameworks over the past two years, and we're beginning to roll out streaming for [all functions](https://vercel.com/docs/functions/runtimes/node-js) and compatible frameworks.

该功能目前已在 Next.js（App Router）、SvelteKit、Remix 等框架中启用。过去两年间，我们已逐步将流式响应能力扩展至更多框架；如今，我们正开始向 [所有函数](https://vercel.com/docs/functions/runtimes/node-js) 及兼容框架全面推广流式响应。

## What changes when streaming responses?

## 启用流式响应后有哪些变化？

When your Vercel Functions stream responses instead of buffering, you can immediately return results to your visitors—either an API function response or a server-side template.

当您的 Vercel 函数采用流式响应而非缓冲式响应时，您即可立即将结果返回给访问者——无论是 API 函数的响应，还是服务端渲染的模板。

## Responses on runtime errors

## 运行时错误下的响应行为

When streaming, response headers are sent immediately with the initial stream. If there is a runtime error after the initial headers have been sent, the function closes the stream and logs an error to Vercel. For example:

启用流式响应后，响应头（response headers）会随初始数据流一同立即发送。若在响应头已发出后发生运行时错误，函数将关闭当前数据流，并在 Vercel 日志中记录该错误。例如：

api/index.js

api/index.js

```javascript
import { setTimeout } from "node:timers/promises";
```

```javascript
export default async function (req, res) {

4  res.writeHead(200, { "Content-Type": "text/plain" });

5  res.write("Chunk 1\\n");

6  await setTimeout(1000);

7  throw new Error("Oh no!");

8}
```

```javascript
export default async function (req, res) {

4  res.writeHead(200, { "Content-Type": "text/plain" });

5  res.write("Chunk 1\\n");

6  await setTimeout(1000);

7  throw new Error("Oh no!");

8}
```

一个向响应中写入内容并带有延迟的示例函数。

当对响应进行缓冲（而非流式传输）时，该函数将延迟数秒才返回响应。由于函数在执行完成前抛出错误，最终将返回 `500` 错误：

当对响应进行缓冲（而非流式传输）时，该函数将延迟数秒才返回响应。由于函数在执行完成前抛出错误，最终将返回 `500` 错误：

```bash
HTTP/2 500
```

```bash
HTTP/2 500
```

`cache-control: public, max-age=0, must-revalidate`

`缓存控制：公开，最大年龄为 0 秒，必须重新验证`

`content-type: text/plain; charset=utf-8`

`内容类型：纯文本；字符编码为 UTF-8`

`date: Mon, 24 Jun 2024 10:26:35 GMT`

`日期：2024 年 6 月 24 日，星期一，10:26:35（格林尼治标准时间）`

`server: Vercel`

`服务器：Vercel`

`strict-transport-security: max-age=63072000; includeSubDomains; preload`

`严格传输安全策略：有效期 63072000 秒（即 2 年）；包含子域名；预加载`

`x-robots-tag: noindex`

`X-Robots-Tag：禁止索引`

`x-vercel-error: FUNCTION_INVOCATION_FAILED`

`X-Vercel 错误：函数调用失败`

`x-vercel-id: cdg1::hgz6d-1719224792404-c4031128df3b`

`X-Vercel ID：cdg1::hgz6d-1719224792404-c4031128df3b`

`content-length: 56`

`内容长度：56`

A server error has occurred

服务器发生错误

FUNCTION_INVOCATION_FAILED

FUNCTION_INVOCATION_FAILED

```

An example of a 500 error response from a Vercel Function.

这是 Vercel Function 返回 500 错误响应的一个示例。

When streaming is enabled, the response status code and part of the body will have already been sent to the client. The stream will send the status code and part of the body before ending. For example, you would then see `Oh no!` error in the Vercel logs.

启用流式传输时，响应状态码及响应体的一部分可能已发送至客户端。流会在结束前先发送状态码及响应体的一部分。例如，此时你将在 Vercel 日志中看到 `Oh no!` 错误。

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

Chunk 1

```

An example of a 200 response from a streamed function.

一个来自流式函数的 200 响应示例。

## Enhanced runtime logs experience

## 运行时日志体验增强

Without streaming, Functions need to finish executing before a response can be sent to the client. Similarly, logs are only sent from the function and visible in the Vercel logs UI until after the function finishes responding.

不使用流式传输时，函数必须完全执行完毕后，才能向客户端发送响应。同样，日志也仅在函数完成响应后，才会从函数中发出，并显示在 Vercel 日志 UI 中。

When viewing runtime logs in the Logs tab, you would see a single line for each function invocation. The log line contains all context for that invocation up to `4KB` size limit. For example:

在“Logs”（日志）标签页中查看运行时日志时，每次函数调用仅显示一行日志。该行日志包含此次调用的全部上下文信息，大小上限为 `4KB`。例如：

```javascript
import { setTimeout } from "node:timers/promises";



export default async function (req, res) {

4  console.log("Before setting a response");

5  res.writeHead(200, { "Content-Type": "text/plain" });

6  res.write("Chunk 1\\n");

7  await setTimeout(1000);

8  console.warn("Before writing a second chunk");
```

9  res.write("Chunk 2\\n");

9  res.write("Chunk 2\\n");

10  await setTimeout(1000);

10  await setTimeout(1000);

11  console.error("Before ending the response");

11  console.error("Before ending the response");

12  res.end("Done!");

12  res.end("Done!");

13}
```

13}
```

An example function that writes a response with a delay.

一个带延迟写入响应的示例函数。

When this function is called three times in a row, we can see the following in Vercel Logs tab:

当该函数被连续调用三次时，我们可在 Vercel 的 Logs（日志）标签页中看到以下内容：

![](images/function-streaming-to-be-framework-agnostic-on-vercel-vercel/img_001.jpg)

![](images/function-streaming-to-be-framework-agnostic-on-vercel-vercel/img_001.jpg)

We see three log lines above, each appearing only _after_ the function invocation had finished. Logs for each invocation are collapsed into a single line. Now, let's explore how this changes when we enable streaming.

上方显示了三条日志记录，每条均仅在对应函数调用**完全结束之后**才出现；每次调用的日志被折叠为单行。接下来，让我们探究启用流式传输（streaming）后这一行为将如何变化。

![](images/function-streaming-to-be-framework-agnostic-on-vercel-vercel/img_002.jpg)

![](images/function-streaming-to-be-framework-agnostic-on-vercel-vercel/img_002.jpg)

With streaming, each log statement gets its own line with a precise timestamp. Logs appear in near real-time, streaming in as they happen. You do not need to wait for the function invocation to complete to see logs.

启用流式传输后，每条日志语句都独占一行，并附带精确的时间戳。日志近乎实时地持续输出，随事件发生而即时流式传输。您无需等待函数调用完成即可查看日志。

You will notice the individual log lines do not display the status code. This is because logs are independent of the response and can occur before a status code is determined. With streaming being enabled by default, this brings consistency to the logs experience when using Vercel Functions.

您会注意到，单条日志行中并不显示状态码（status code）。这是因为日志与响应相互独立，且可能在状态码确定之前就已生成。由于流式传输将默认启用，这将提升 Vercel Functions 日志体验的一致性。

These changes in frequency and format of Function logs will also affect Vercel Log Drains. If you are using Log Drains, ensure that your provider supports streaming responses and this increase frequency for logs.

Function 日志在频率和格式上的上述变更，同样会影响 Vercel Log Drains。若您正在使用 Log Drains，请确保您的日志服务提供商支持流式响应，并能处理日志输出频率的提升。

## Enabling streaming functions today

## 立即启用流式函数

Streaming will be enabled by default for Hobby accounts starting **July 8th, 2024;** and for Pro and Enterprise accounts starting **October 1st, 2024**.

流式传输将自 **2024 年 7 月 8 日起** 对 Hobby 计划账户默认启用；自 **2024 年 10 月 1 日起** 对 Pro 和 Enterprise 计划账户默认启用。

To enable streaming as the default today for all your Vercel Functions, set the `VERCEL_FORCE_NODEJS_STREAMING` environment variable in your project to `true`. Streaming will be enabled on your next deployment.

如需立即为您的所有 Vercel Functions 默认启用流式传输，请在项目中将环境变量 `VERCEL_FORCE_NODEJS_STREAMING` 设置为 `true`。下次部署时，流式传输即会生效。