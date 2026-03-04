---
title: "waitUntil is now available for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/waituntil-is-now-available-for-vercel-functions"
date: "2024-05-10"
scraped_at: "2026-03-02T09:45:32.230815315+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

May 10, 2024

2024 年 5 月 10 日

![](images/waituntil-is-now-available-for-vercel-functions-vercel/img_001.jpg)![](images/waituntil-is-now-available-for-vercel-functions-vercel/img_002.jpg)

You can now use [waitUntil](https://vercel.com/docs/functions/functions-api-reference#waituntil) by importing `@vercel/functions` in your Vercel Functions, regardless of the framework or runtime you use.

您现在可以在 Vercel Functions 中通过导入 `@vercel/functions` 来使用 [waitUntil](https://vercel.com/docs/functions/functions-api-reference#waituntil)，无论您使用何种框架或运行时。

The `waitUntil()` method enqueues an asynchronous task to be performed during the lifecycle of the request. It doesn't block the response, but should complete before shutting down the function.

`waitUntil()` 方法会将一个异步任务加入队列，使其在请求生命周期内执行。该方法不会阻塞响应发送，但应在函数关闭前完成执行。

It's used to run anything that can be done after the response is sent, such as logging, sending analytics, or updating a cache, without blocking the response from being sent.

它适用于所有可在响应发送后执行的操作，例如日志记录、发送分析数据或更新缓存，且不会阻塞响应的返回。

The package is supported in Next.js (including Server Actions), Vercel CLI, and other frameworks, and can be used with the [Node.js and Edge runtimes](https://vercel.com/docs/functions/runtimes).

该包支持 Next.js（包括 Server Actions）、Vercel CLI 及其他框架，并可与 [Node.js 和 Edge 运行时](https://vercel.com/docs/functions/runtimes) 配合使用。

Learn more in the [documentation](https://vercel.com/docs/functions/functions-api-reference#waituntil).

更多详情请参阅 [文档](https://vercel.com/docs/functions/functions-api-reference#waituntil)。
&#123;% endraw %}
