---
render_with_liquid: false
title: "Next.js 14 on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/next-js-14"
date: "2023-10-26"
scraped_at: "2026-03-02T09:49:56.198969845+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Oct 26, 2023

2023 年 10 月 26 日

Next.js 14 已在 Vercel 上获得全面支持。借助 Next.js，您可以为访客构建以数据为驱动、高度个性化的体验，并自动部署至 Vercel——享受包括以下特性在内的多项优化：

- [**流式响应（Streaming）**](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming) **：** Next.js App Router 原生支持流式响应。您可即时显示加载状态，并在 UI 单元渲染完成时逐段流式传输。借助 Vercel Functions，流式响应可在 Node.js 和 Edge 运行时环境中无缝启用，且无需修改任何代码。

- [**React 服务端组件（Server Components）**](https://nextjs.org/docs/app/building-your-application/rendering/server-components) **：** 服务端组件允许您在组件级别定义数据获取逻辑，并轻松表达缓存与重新验证策略。在 Vercel 上，该能力通过 Vercel Functions 及全新缓存架构——[Vercel 数据缓存（Vercel Data Cache）](https://vercel.com/docs/infrastructure/data-cache)——原生支持；该架构可同时缓存静态内容与数据请求结果。

- [**React 服务端操作（Server Actions）**](https://nextjs.org/docs/app/building-your-application/data-fetching/forms-and-mutations) **：** 服务端操作让您无需手动编写 API，即可直接调用 JavaScript 函数执行数据变更操作。在 Vercel 上，服务端操作由 Vercel Functions 提供支持。

- [**部分预渲染（Partial Prerendering，实验性功能）**](https://vercel.com/templates/next.js/partial-prerendering-nextjs) **：** 这是一项面向动态内容的新型编译优化技术，其核心是提供快速的初始静态响应；该技术凝聚了 Vercel 团队十年来在服务端渲染（SSR）、静态站点生成（SSG）及增量静态重新验证（ISR）等领域的研究与工程实践成果。

此外，Next.js 14 还带来以下新特性：

- **Turbopack：** App Router 与 Pages Router 均已通过 5,000 项测试；本地开发服务器启动速度提升 53.3%，热更新（Fast Refresh）代码更新速度提升 94.7%。

- **表单与数据变更（Forms and mutations）：** 当用户网络连接较慢，或在性能较低的设备上提交表单时，用户体验得到显著改善。

- **元数据（Metadata）：** 阻塞式元数据与非阻塞式元数据现已解耦。仅一小部分元数据选项具有阻塞性；我们确保非阻塞式元数据不会阻碍部分预渲染页面的静态外壳（static shell）正常交付。

- **Logging:** More verbose logging around fetch caching can be enabled.

- **日志记录：** 可启用更详细的 fetch 缓存相关日志。

- **`create-next-app:`** There is now an 80% smaller function size for a basic `create-next-app` application.

- **`create-next-app`：** 基础 `create-next-app` 应用的函数体积现已缩小 80%。

- **Memory management:** Enhanced memory management is available when using `edge` runtime in development.

- **内存管理：** 在开发模式下使用 `edge` 运行时，现已提供增强的内存管理能力。

[Check out our documentation](https://nextjs.org/docs/getting-started/installation) to learn more.

[查阅我们的文档](https://nextjs.org/docs/getting-started/installation) 以了解更多信息。