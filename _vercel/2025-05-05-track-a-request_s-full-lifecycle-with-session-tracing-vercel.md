---
title: "Track a request's full lifecycle with session tracing - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/session-tracing-now-available"
date: "2025-05-05"
scraped_at: "2026-03-02T09:34:01.343517362+00:00"
language: "en-zh"
translated: true
description: "Vercel session tracing is now available on all plans, providing insight into steps Vercel's infrastructure took to serve a request alongside user code spans. "
---
{% raw %}

May 5, 2025

2025 年 5 月 5 日

Session tracing is now available to all Vercel users, providing end-to-end visibility into the timing of each step in a request's lifecycle, from when it enters Vercel’s infrastructure to execution inside your Vercel Functions.

会话追踪（Session Tracing）现已向所有 Vercel 用户开放，为您提供端到端的请求生命周期时序可见性——从请求进入 Vercel 基础设施开始，直至在您的 Vercel Functions 中执行完毕。

With session tracing you can:

借助会话追踪，您可以：

- Start tracing sessions on your deployments directly from the Vercel Toolbar, no setup required.

  直接通过 Vercel 工具栏（Vercel Toolbar）为您的部署开启会话追踪，无需任何配置。

- View spans for Vercel's routing, caching, middleware, and function layers as well as those instrumented in your code.

  查看涵盖 Vercel 路由、缓存、中间件及函数层的 trace span，以及您代码中已接入追踪的 span。

- Share traces with teammates for faster debugging and optimization.

  与团队成员共享 trace，加速问题排查与性能优化。

- Use tracing alongside logs and metrics to debug, optimize, and improve iteration speed.

  将追踪与日志（logs）和指标（metrics）结合使用，以辅助调试、优化性能并提升迭代速度。

Session tracing is free to customers on all plans.

所有套餐的客户均可免费使用会话追踪功能。

To get started, find Tracing in the Vercel Toolbar, or learn more in [the docs](https://vercel.com/docs/session-tracing).

如需开始使用，请在 Vercel 工具栏中找到 “Tracing”（追踪），或参阅[官方文档](https://vercel.com/docs/session-tracing)了解更多信息。
{% endraw %}
