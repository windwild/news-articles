---
title: "Edge Middleware and Edge Functions are now powered by Vercel Functions - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/edge-middleware-and-edge-functions-are-now-powered-by-vercel-functions"
date: "2025-06-25"
scraped_at: "2026-03-02T09:32:09.911773741+00:00"
language: "en-zh"
translated: true
description: "The Edge runtime now runs on Vercel Functions, unifying pricing across all compute, and available before and after cache. Edge Middleware and Edge Functions are now deprecated."
---

render_with_liquid: false
Jun 25, 2025

2025 年 6 月 25 日

使用 Edge 运行时的函数现已运行在统一的 Vercel Functions 基础设施之上。

该变更同时适用于缓存前与缓存后阶段：

- Edge Middleware 现已更名为 Vercel Routing Middleware，这是一种全新的基础设施原语，可在缓存之前以 [Fluid compute](https://vercel.com/fluid) 技术运行完整的 Vercel Functions；

- Edge Functions 现已更名为 Vercel Functions（采用 Edge 运行时），在缓存之后执行。


Edge Middleware 和 Edge Functions 已被弃用，分别由 Vercel Routing Middleware 和 Vercel Functions 取代。二者均支持 Edge 运行时、Node.js 及更多运行时环境。

通过此次更新，所有函数（包括使用 Edge 运行时的函数）均已具备以下特性：

- **支持 Fluid compute**：基于 [Fluid compute](https://vercel.com/docs/functions/fluid-compute) 运行，性能更优、成本效益更高；

- **多运行时支持**：兼容 Node.js 运行时与 Edge 运行时；

- **框架驱动部署**：可直接从受支持的框架代码中自动部署。

- **Consistent pricing**: Uses unified Vercel Functions pricing [based on Active CPU time](https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute) across all compute types

- **统一的定价策略**：所有计算类型均采用统一的 Vercel Functions 定价模型，该模型基于[活跃 CPU 时间](https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute)计费。

Vercel Routing Middleware is now generally available to all users.

Vercel 路由中间件（Routing Middleware）现已向所有用户正式发布（GA）。

Learn more about [Routing Middleware](https://vercel.com/docs/routing-middleware).

了解更多关于 [Routing Middleware（路由中间件）](https://vercel.com/docs/routing-middleware) 的信息。