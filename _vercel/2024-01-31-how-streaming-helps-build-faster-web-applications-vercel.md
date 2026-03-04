---
title: "How streaming helps build faster web applications - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-streaming-helps-build-faster-web-applications"
date: "2024-01-31"
scraped_at: "2026-03-02T09:48:12.621081943+00:00"
language: "en-zh"
translated: true
description: "Learn why streaming is critical for performance and how the Next.js App Router integrates with React Suspense to easily enable streaming UI."
---
&#123;% raw %}

Jan 31, 2024

2024 年 1 月 31 日

了解 Next.js App Router 如何帮助您充分利用流式 UI（streaming UI）。

流式传输是构建**快速**且**动态** Web 应用的关键。

在启用[流式传输](https://vercel.com/blog/an-introduction-to-streaming-on-the-web)时，您可以将 UI 从服务器逐步发送至客户端，而无需等待所有数据加载完成。这能让用户立即看到关键内容，例如“加入购物车”的主操作按钮。

全球规模最大、最具影响力的公司与电商平台，均采用流式传输以实现最优性能。

让我们一起了解流式传输如何助力构建高性能 Web 应用，并打造卓越的产品体验。

## 流式传输如何提升性能

Amazon 和 Google 等全球顶级网站均采用流式传输，以同时提升性能（由 [Core Web Vitals](https://vercel.com/blog/how-core-web-vitals-affect-seo) 定义）和[转化率](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#why-do-you-need-speed)。

流式传输可避免慢速数据源阻塞初始 UI 的呈现，从而让用户更快看到页面；此外，它还能并行加载其他关键资源（如 JavaScript、样式表和字体），进一步优化整体加载效率。

### 将计算逻辑部署在数据源附近

As your application grows, so does network traffic between your clients (possibly in distant regions) and your database (likely in one region). We can’t beat the speed of light, so we need compute to run close to our data. That’s usually one region, _maybe_ 2-3, depending on your data sovereignty and security requirements.

随着应用规模扩大，客户端（可能位于遥远地区）与数据库（通常部署于单一区域）之间的网络流量也随之增长。我们无法突破光速限制，因此必须将计算资源部署在靠近数据的位置——这通常意味着一个区域，_最多_ 2–3 个区域，具体取决于您的数据主权与安全合规要求。

For example, your Vercel Function can [stream responses](https://vercel.com/docs/functions/streaming) from `us-east` close to your data, and prevent many network roundtrips from origin and Vercel region.

例如，您的 Vercel Function 可在靠近数据的 `us-east` 区域流式传输响应，从而避免大量源自源站与 Vercel 区域之间的网络往返。

To further optimize your [Time To First Byte (TTFB)](https://web.dev/ttfb/), Next.js is building [Partial Prerendering](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) to generate a static shell of your route ahead of time and deploy it to every Vercel region. Partial Prerendering enables consistent, fast initial loading, paired with being able to stream dynamic data from your [Vercel Functions](https://vercel.com/docs/functions/streaming) at the same time.

为进一步优化 [首字节时间（TTFB）](https://web.dev/ttfb/)，Next.js 正在构建 [部分预渲染（Partial Prerendering）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model)，以提前生成路由的静态外壳（static shell），并将其部署至所有 Vercel 区域。部分预渲染可实现稳定、快速的初始加载，同时支持从您的 [Vercel Functions](https://vercel.com/docs/functions/streaming) 流式传输动态数据。

## Using streaming with the Next.js App Router

## 在 Next.js App Router 中使用流式传输

The Next.js App Router, with React Suspense, makes it easy to stream UI components. Next.js supports both out-of-order streaming (default) and in-order streaming defined by your Suspense boundaries.

Next.js App Router 结合 React Suspense，使 UI 组件的流式传输变得轻而易举。Next.js 同时支持**乱序流式传输**（默认行为）和由您定义的 Suspense 边界所决定的**有序流式传输**。

Unlike conventional streaming that follows a sequential order, out-of-order streaming enhances user experience by rendering parts of a UI, while continuing to load other elements, reducing the perceived load time.

与遵循严格顺序的传统流式传输不同，乱序流式传输通过优先渲染 UI 的部分区域（同时继续加载其余内容），显著提升用户体验，降低用户感知的加载延迟。

Streaming pairs with the React component model. Each component can be considered a chunk. Components that have higher priority (e.g. product information) or that don't rely on data can be sent first (e.g. layout), and React can start hydration earlier. Components that have lower priority (e.g. reviews, related products) can be sent in the same server request after their data has been fetched.

流式传输天然契合 React 的组件模型：每个组件均可视为一个独立的数据块（chunk）。高优先级组件（如商品信息）或无需依赖数据的组件（如布局）可率先发送，使 React 更早启动水合（hydration）；而低优先级组件（如用户评论、关联商品）则可在其所需数据获取完成后，于同一服务端请求中后续发送。

Using Partial Prerendering with Next.js to stream content out of order.

借助 Next.js 的部分预渲染（Partial Prerendering）实现乱序内容流式传输。

Learn more about [streaming and React Suspense in Next.js](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming). Optionally, learn more about a new technique that takes advantage of streaming called [Partial Prerendering](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model).

深入了解 Next.js 中的 [流式传输与 React Suspense](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming)。您还可选择进一步了解一项充分利用流式传输能力的新技术：[部分预渲染（Partial Prerendering）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model)。

## Using streaming with AI applications and LLMs

## 在 AI 应用与大语言模型（LLMs）中使用流式传输

The next generation of web apps built on [AI](https://vercel.com/ai) are also [using streaming](https://sdk.vercel.ai/docs/concepts/streaming).

基于 [AI](https://vercel.com/ai) 构建的下一代 Web 应用，也正在采用 [流式传输（streaming）](https://sdk.vercel.ai/docs/concepts/streaming)。

Large Language Models (LLMs) are extremely powerful. However, when generating long outputs, they can be very slow compared to the latency you're likely used to. If you try to build a traditional blocking UI, your users might easily find themselves staring at loading spinners for 5, 10, even up to 40s waiting for the entire LLM response to be generated. This can lead to a poor user experience, especially in conversational applications like chatbots.

大语言模型（LLMs）功能极为强大。然而，在生成较长输出时，其响应速度往往远低于你所习惯的延迟水平。若尝试构建传统的阻塞式用户界面（blocking UI），用户很可能需要盯着加载旋转图标长达 5 秒、10 秒，甚至长达 40 秒，只为等待整个 LLM 响应生成完毕。这将严重损害用户体验——尤其在聊天机器人等对话式应用中。

Streaming UIs can help mitigate this issue by displaying parts of the response as they become available. This is easily enabled through the combination of Next.js and the [AI SDK](https://sdk.vercel.ai/docs).

流式 UI（Streaming UI）可通过“边生成、边展示”的方式缓解这一问题——即在响应内容逐步生成的同时，实时将其分段呈现给用户。借助 Next.js 与 [AI SDK](https://sdk.vercel.ai/docs) 的组合，这一能力可轻松启用。

## Start streaming

## 开始使用流式传输

Want to build your next product with the power of streaming? Get started with the [Next.js App Router](https://vercel.com/templates/next.js/nextjs-boilerplate) and learn more about [streaming in Next.js](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming).

想利用流式传输能力打造你的下一个产品吗？立即从 [Next.js App Router](https://vercel.com/templates/next.js/nextjs-boilerplate) 入手，并深入了解 [Next.js 中的流式传输](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming)。

Vercel.com landing page

Vercel.com 官网落地页

### Developer Experience Platform

### 开发者体验平台

Blog post

博客文章

Jun 22, 2023

2023 年 6 月 22 日

### An Introduction to Streaming on the Web

### 网络流式传输简介

![](images/how-streaming-helps-build-faster-web-applications-vercel/img_001.jpg)

莉迪亚·哈利
&#123;% endraw %}
