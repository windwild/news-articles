---
title: "Improved unhandled Node.js errors in Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-unhandled-node-js-errors-in-fluid-compute"
date: "2025-06-12"
scraped_at: "2026-03-02T09:32:38.013887431+00:00"
language: "en-zh"
translated: true
description: "Fluid compute now gracefully handles Node.js uncaught exceptions and unhandled rejections to provide better isolation between requests."
---
{% raw %}

Jun 12, 2025

2025 年 6 月 12 日

Fluid Compute 现在能够优雅地处理 Node.js 中的[未捕获异常](https://nodejs.org/api/process.html#event-uncaughtexception)和[未处理的 Promise 拒绝](https://nodejs.org/api/process.html#event-unhandledrejection)：在记录错误日志后，允许正在进行的请求正常完成，随后再退出进程。

此举可防止同一 Fluid 实例上运行的[并发请求](https://vercel.com/docs/functions/fluid-compute#optimized-concurrency)因未处理的错误而被意外终止，从而提供与传统 Serverless 调用同等的隔离性。

请为您的现有项目[启用 Fluid](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)，并参阅我们的[博客文章](https://vercel.com/blog/introducing-fluid-compute)和[文档](https://vercel.com/docs/functions/fluid-compute)以了解更多信息。
{% endraw %}
