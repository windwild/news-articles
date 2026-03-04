---
title: "Streaming from serverless Node.js and Edge Runtime on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/streaming-for-serverless-node-js-and-edge-runtimes-with-vercel-functions"
date: "2023-03-28"
scraped_at: "2026-03-02T09:53:42.919563559+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel enables streaming for serverless Node.js and Edge runtimes. HTTP streaming enables the server to incrementally send response data in smaller chunks to the client while generating the ..."
---

render_with_liquid: false
Mar 28, 2023

2023 年 3 月 28 日

Vercel 最近成为首家在 Node.js（Lambda）和 Edge 运行时环境中均提供稳定 HTTP 响应流式传输（HTTP response streaming）支持的无服务器计算平台。这一能力帮助开发者构建高性能 Web 应用，重点关注速度、可扩展性以及资源利用效率。

让我们一起来了解 Vercel 如何为无服务器 Node.js 环境启用流式响应，以及该能力如何显著提升您 Web 应用的性能与用户体验。

## HTTP Streaming

## HTTP 流式传输

HTTP 流式传输（HTTP Streaming）是一种数据传输技术，它允许服务器将数据以较小的数据块形式逐步发送给客户端，而非一次性发送整个大负载。这种方式可缩短响应时间、提升用户体验，并更高效地处理海量数据。

传统的 HTTP 响应通常要求服务器先完整生成全部响应负载，再将其作为单次响应整体发送至客户端。尽管该方式对小体积负载通常已足够，但在处理大体积或动态生成的数据时却存在明显不足：可能导致更高的响应延迟、更长的加载时间，进而损害用户体验。

![非流式 HTTP 请求的网络与主线程活动](images/streaming-from-serverless-node_js-and-edge-runtime-on-vercel-vercel/img_001.jpg)非流式 HTTP 请求的网络与主线程活动

HTTP 流式传输则使服务器能够在生成完整响应的同时，将响应数据分块逐步发送至客户端。浏览器能够立即处理并渲染这些流式数据块，从而大幅降低响应延迟，并显著加快首字节时间（[TTFB](https://developer.mozilla.org/en-US/docs/Glossary/Time_to_first_byte)）与首次内容绘制时间（[FCP](https://developer.mozilla.org/en-US/docs/Glossary/First_contentful_paint)）。

![流式 HTTP 请求的网络与主线程活动](images/streaming-from-serverless-node_js-and-edge-runtime-on-vercel-vercel/img_002.jpg)流式 HTTP 请求的网络与主线程活动

流式传输为 Web 应用带来诸多显著优势，包括：

- **Improving performance**

- **提升性能**

by reducing TTFB and enabling faster page loads. Sending responses incrementally in smaller chunks ensures that slower services don't block the page load. The incremental processing of chunks on the main thread allows the browser to handle user input and other tasks more efficiently, leading to an overall smoother experience and better responsiveness.

通过降低首字节时间（TTFB）并加快页面加载速度来提升性能。以较小的数据块逐步发送响应，可确保响应较慢的服务不会阻塞整个页面加载过程；主线程对这些数据块进行增量式处理，使浏览器能更高效地响应用户输入及其他任务，从而带来整体更流畅的体验和更佳的响应性。

- **Efficiently handling large, dynamic payloads**

- **高效处理大型动态负载**

as data can be sent without having to wait for the entire payload to be generated. This eliminates AWS Lambda response size limitations and boosts rendering performance.

数据可在无需等待整个负载完全生成的情况下即刻发送，从而规避了 AWS Lambda 的响应大小限制，并显著提升渲染性能。

- **Improving scalability**

- **提升可扩展性**

by cutting down on overall memory usage, as it's no longer necessary to buffer the entire response in memory before sending it down to the client.

通过降低整体内存占用实现可扩展性的提升：响应不再需要在内存中完整缓冲后才发送至客户端。

Vercel's serverless architecture is largely powered by AWS Lambda, which, at the time of writing, does not provide native support for HTTP streaming.

Vercel 的无服务器架构主要依托于 AWS Lambda；而截至本文撰写时，AWS Lambda 尚未提供对 HTTP 流式传输的原生支持。

Despite this limitation, the Vercel engineering team has developed a custom solution that enables HTTP streaming in Vercel Serverless Functions.

尽管存在这一限制，Vercel 工程团队已自主研发了一套定制化方案，成功在 Vercel 无服务器函数中实现了 HTTP 流式传输功能。

## Streaming on Vercel

## Vercel 上的流式传输

When a request is made to a Vercel Serverless Function with streaming enabled, the request is first routed through an **Edge Location** that forwards it to a **Serverless Function Invocation Service**. The request gets inspected by this service and modified to include streaming-specific payload attributes, including as a callback URL. The invocation service forwards the modified request to AWS Lambda.

当向启用了流式传输功能的 Vercel 无服务器函数发起请求时，该请求首先被路由至一个 **边缘节点（Edge Location）**，再由其转发至 **无服务器函数调用服务（Serverless Function Invocation Service）**。此服务会对请求进行检查，并修改其负载内容，加入专用于流式传输的属性（例如回调 URL）。随后，调用服务将修改后的请求转发至 AWS Lambda。

Within AWS Lambda, the response stream gets generated.  
在 AWS Lambda 中，响应流被生成。

Due to the lack of native support for returning streaming responses, Vercel uses special bridge code inside the Lambda function to implement streaming support.  
由于 AWS Lambda 原生不支持返回流式响应，Vercel 在 Lambda 函数内部使用特殊的桥接代码来实现流式响应支持。

This bridge is responsible for establishing a secure socket connection to the request’s callback URL which is then used to transfer the response stream to the invocation service.  
该桥接模块负责与请求的回调 URL 建立安全套接字连接，随后利用该连接将响应流传输至调用服务。

![Request flows through Edge Location to Vercel’s Serverless Function Invocation Service. This forwards the request to the Lambda with the callback URL, which the bridge uses to establish a secure socket connection. ](images/streaming-from-serverless-node_js-and-edge-runtime-on-vercel-vercel/img_003.jpg)  
![请求经由边缘节点（Edge Location）流向 Vercel 的无服务器函数调用服务。该服务将请求连同回调 URL 一并转发至 Lambda，桥接模块则利用该 URL 建立安全套接字连接。](images/streaming-from-serverless-node_js-and-edge-runtime-on-vercel-vercel/img_003.jpg)

Request flows through Edge Location to Vercel’s Serverless Function Invocation Service. This forwards the request to the Lambda with the callback URL, which the bridge uses to establish a secure socket connection.  
请求经由边缘节点（Edge Location）流向 Vercel 的无服务器函数调用服务。该服务将请求连同回调 URL 一并转发至 Lambda，桥接模块则利用该 URL 建立安全套接字连接。

A receiver within the invocation service reads and processes the incoming data from the socket.  
调用服务内部的一个接收器读取并处理来自套接字的传入数据。

The invocation service forwards the request back to the client as the response to the original HTTP request, which can start processing the data once the first chunk has been received and incrementally process and render the data as it streams in.  
调用服务将响应作为原始 HTTP 请求的返回结果，回传给客户端；客户端可在接收到首个数据块后立即开始处理，并随着数据持续流入，逐步处理和渲染内容。

As the first platform to support this capability on AWS Lambda, streaming on Vercel enhances the performance applications hosted on Vercel even further by enabling developers to build web applications with a focus on speed, scalability, and efficient resource usage.  
作为首个在 AWS Lambda 上支持该能力的平台，Vercel 的流式响应功能进一步提升了托管于 Vercel 的应用性能，使开发者能够专注于构建具备高速响应、高可扩展性及资源高效利用特性的 Web 应用。

Experience the benefits of Streaming on Vercel today with [Next.js Route Handlers](https://vercel.com/templates/next.js/app-directory), [React Server Components](https://vercel.com/templates/next.js/app-directory), [Remix Streaming SSR](https://vercel.com/templates/remix), or [SvelteKit](https://vercel.com/templates/svelte/sveltekit-edge-functions).  
即刻体验 Vercel 流式响应带来的优势：使用 [Next.js 路由处理器（Route Handlers）](https://vercel.com/templates/next.js/app-directory)、[React 服务端组件（React Server Components）](https://vercel.com/templates/next.js/app-directory)、[Remix 流式服务端渲染（Streaming SSR）](https://vercel.com/templates/remix)，或 [SvelteKit](https://vercel.com/templates/svelte/sveltekit-edge-functions)。