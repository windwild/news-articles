---
title: "Runtime logs can now be filtered by request type and Vercel resource - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/runtime-logs-can-now-be-filtered-by-request-type-and-vercel-resource"
date: "2025-01-07"
scraped_at: "2026-03-02T09:38:25.618595536+00:00"
language: "en-zh"
translated: true
description: "Runtime Logs can now be filtered by request type and Vercel resource, which provides more granular insights into how your requests are processed. Learn how these filters can enhance your debugging and..."
---

render_with_liquid: false
Jan 7, 2025

2025 年 1 月 7 日

![](images/runtime-logs-can-now-be-filtered-by-request-type-and-vercel-resource-vercel/img_001.jpg)![](images/runtime-logs-can-now-be-filtered-by-request-type-and-vercel-resource-vercel/img_002.jpg)

[运行时日志](https://vercel.com/docs/observability/runtime-logs) 中的“包含类型”（Contain Types）筛选器已更新为两个新筛选器，以提升可读性与清晰度：

1. **资源（Resource）**：筛选请求所使用的 Vercel 边缘网络（Vercel Edge Network）中的具体基础设施资源。例如：无服务器函数（Serverless Functions）、边缘缓存（Edge Cache）和边缘中间件（Edge Middleware）。

2. **请求类型（Request Type）**：筛选请求所采用的、由框架定义的机制或渲染策略。例如：API 路由（API routes）、增量静态再生（Incremental Static Regeneration, ISR）以及定时任务（cron jobs）。

这些更新使您能够更精细地洞察请求的处理过程。即日起，所有订阅计划均支持这两个筛选器。

进一步了解 [Vercel 如何处理请求](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)。