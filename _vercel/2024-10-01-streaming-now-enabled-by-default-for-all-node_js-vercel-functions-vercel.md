---
title: "Streaming now enabled by default for all Node.js Vercel Functions - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/streaming-now-enabled-by-default-for-all-node-js-vercel-functions"
date: "2024-10-01"
scraped_at: "2026-03-02T09:41:17.091861503+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Oct 1, 2024

2024 年 10 月 1 日

[Streaming（流式响应）](https://vercel.com/docs/functions/streaming-functions) 现已默认启用，适用于所有 Pro 和 Enterprise 团队部署的、运行在 Node.js 上的 [Vercel Functions（Vercel 函数）](https://vercel.com/docs/functions/runtimes/node-js#using-the-node.js-runtime-with-serverless-functions)，这标志着我们于 [2024 年 7 月 8 日发布的计划](https://vercel.com/changelog/vercel-functions-to-enable-streaming-by-default) 已全面完成。这意味着 Vercel Functions 现在可在数据生成的同时即时将其发送至客户端，而无需等待整个响应体构建完毕。

环境变量 `VERCEL_FORCE_NODEJS_STREAMING` 不再需要——流式响应将在部署时自动启用。

**日志行为变更：** 流式响应将[改变运行时日志的格式与输出频率](https://vercel.com/docs/functions/streaming-functions#runtime-logs)。若您正在使用 Log Drains（日志转发），请确认您的日志采集管道能够正确解析新的日志格式，并可应对显著增加的日志量。

欲了解更多信息，请参阅我们的[博客文章](https://vercel.com/blog/vercel-functions-streaming-to-be-framework-agnostic)和[官方文档](https://vercel.com/docs/functions/streaming-functions)。