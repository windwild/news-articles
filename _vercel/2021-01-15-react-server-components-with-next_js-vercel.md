---
title: "React Server Components with Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/everything-about-react-server-components"
date: "2021-01-15"
scraped_at: "2026-03-02T10:06:01.248779109+00:00"
language: "en-zh"
translated: true
description: "Learn about React Server Components (experimental) and how they'll change how we build React applications, creating a better end-user experience."
---
&#123;% raw %}

Jan 15, 2021

2021 年 1 月 15 日

React Server Components（React 服务端组件）使开发者能够构建横跨服务端与客户端的应用程序，将客户端应用丰富的交互性与传统服务端渲染的性能优势相结合。

在即将发布的 Next.js 主要版本中，React 开发者将能够在 `app` 目录内使用 Server Components，这是 [Layouts RFC](https://nextjs.org/blog/layouts-rfc) 所述变更的一部分。本文将探讨 Server Components 如何帮助开发者构建更快速的 React 应用。

## What are React Server Components?

## 什么是 React Server Components？

React Server Components 通过将服务端渲染的最佳特性与客户端交互能力相结合，提升了应用程序的用户体验。

在传统的纯客户端 React 应用中，开发者常常需要在 SEO 与性能之间做出权衡。而 Server Components 使开发者能够更充分地利用其服务端基础设施，并默认实现卓越的性能表现。

例如，以往会显著增大客户端 JavaScript 包体积的大型依赖，如今可完全保留在服务端。通过向浏览器发送更少的 JavaScript 代码，页面达到可交互状态（Time to Interactive）的时间得以缩短，从而提升 [Core Web Vitals](https://vercel.com/blog/core-web-vitals) 指标。

## React Server Components vs Server-Side Rendering

## React Server Components 与服务端渲染（SSR）对比

[Server-side Rendering](https://nextjs.org/docs/basic-features/pages#server-side-rendering)（服务端渲染，SSR）会在服务端动态地将应用程序渲染为 HTML。这种方式将计算工作从用户设备转移到服务端，尤其有利于网络连接较慢或设备较老旧的用户，从而加快页面加载速度。然而，在初始 HTML 加载完成后，开发者仍需承担下载、解析及水合（hydrate）这些组件的成本。

React Server Components 结合 Next.js 的服务端渲染能力，有助于消除“全有或全无”式数据获取所带来的权衡困境。你可以在数据逐步到达的过程中渐进式地呈现更新内容。

## Using React Server Components with Next.js

## 在 Next.js 中使用 React 服务器组件

The Next.js team at Vercel released the [Layouts RFC](https://nextjs.org/blog/layouts-rfc) a few months ago outlining the vision for the future of routing, layouts, and data fetching in the framework. While these changes **aren’t available yet**, we can start learning about how they will be used.

Vercel 的 Next.js 团队几个月前发布了 [布局 RFC（征求意见稿）](https://nextjs.org/blog/layouts-rfc)，概述了该框架在路由、布局和数据获取方面的未来愿景。尽管这些变更**目前尚不可用**，但我们已经可以开始了解它们将如何被使用。

Pages and Layouts in `app` will be rendered as React Server Components by default. This improves performance by reducing the amount of JavaScript sent to the client for components that are not interactive. Client components will be able to be defined through either a file name extension or through a string literal in the file.

`app` 目录下的页面（Pages）和布局（Layouts）默认将以 React 服务器组件（React Server Components）形式渲染。这通过减少向客户端发送非交互式组件所需的 JavaScript 代码量，从而提升性能。客户端组件可通过文件扩展名或文件内的字符串字面量进行声明。

Both client and server components can be used inside the same route. For example:

客户端组件与服务器组件可在同一路由内共存。例如：

![Both client and server components can be used together in the same route.](images/react-server-components-with-next_js-vercel/img_001.jpg)  
![客户端组件与服务器组件可在同一路由内共存。](images/react-server-components-with-next_js-vercel/img_001.jpg)

Both client and server components can be used together in the same route.

客户端组件与服务器组件可在同一路由内共存。

Stay tuned for more updates on React Server Components in the upcoming months.

敬请关注未来几个月关于 React 服务器组件的更多更新。
&#123;% endraw %}
