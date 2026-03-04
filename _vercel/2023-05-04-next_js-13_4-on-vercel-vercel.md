---
title: "Next.js 13.4 on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/next-js-13-4"
date: "2023-05-04"
scraped_at: "2026-03-02T09:53:00.793343477+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

May 4, 2023

2023 年 5 月 4 日

![](images/next_js-13_4-on-vercel-vercel/img_001.jpg)![](images/next_js-13_4-on-vercel-vercel/img_002.jpg)

Next.js 13.4 中已趋于稳定的 Next.js App Router，现已在 Vercel 上开箱即用，配备预配置的、全局性的、框架定义的基础设施。

借助 Next.js 构建以数据为驱动、高度个性化的用户体验，并自动部署至 Vercel，享受经过优化的全球性能表现。

- **嵌套式** [**路由（Routes）**](https://nextjs.org/docs/app/building-your-application/routing) **与布局（Layouts）：** 轻松在不同路由间共享 UI，同时保留状态、避免高开销的重复渲染。在 Vercel 上，您的布局和页面可配置为以 Edge Functions 形式部署，从而显著提升 SEO 效果与运行性能。

- [**流式传输（Streaming）**](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming) **：** Next.js App Router 原生支持响应流式传输。可即时显示[加载状态（loading states）](https://next-on-the-edge.vercel.app/)，并在 UI 组件逐个完成渲染时，以“UI 单元”为粒度进行流式输出。借助 Vercel Functions，流式传输可在 Node 和 Edge 运行时环境中无缝启用，且无需任何代码修改。

- [**React 服务端组件（Server Components）**](https://nextjs.org/docs/getting-started/react-essentials#server-components) **：** 服务端组件允许您在组件级别定义数据获取逻辑，并轻松表达缓存策略与重新验证（revalidation）策略。Vercel 原生支持该特性——依托 Vercel Functions 及全新推出的 Vercel 数据缓存（Vercel Data Cache）架构，该架构可同时缓存静态内容与数据请求结果。

- **对** [**数据获取（Data Fetching）**](https://nextjs.org/docs/pages/building-your-application/data-fetching) **的全面支持：** Next.js 提供细粒度缓存能力，让您可在数据获取层级灵活选择静态或动态数据。在 Vercel 上，[数据缓存（Data Cache）](https://vercel.com/changelog/introducing-vercel-data-cache) 将自动跨部署共享，从而加快构建速度并提升整体性能。

- **内置** [**SEO 支持**](https://nextjs.org/docs/app/building-your-application/optimizing/metadata#seo-1) **：** 借助元数据（Metadata）API，您可以轻松定制网页在 Web 上的分享效果，且完全兼容流式传输。

此外，在 Next.js 13.4 中您还将发现：

- [**Turbopack**](https://turbo.build/pack) **（Beta 版）：** 本地开发服务器，速度更快，稳定性更高。

- [**Server Actions**](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions) **（Alpha 版）：** 在服务端执行数据变更操作，无需任何客户端 JavaScript。

[查阅我们的文档](https://nextjs.org/docs/getting-started) 以了解更多信息。
&#123;% endraw %}
