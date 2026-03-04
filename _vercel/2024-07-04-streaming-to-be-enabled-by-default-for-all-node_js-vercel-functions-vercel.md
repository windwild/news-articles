---
render_with_liquid: false
title: "Streaming to be enabled by default for all Node.js Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-functions-to-enable-streaming-by-default"
date: "2024-07-04"
scraped_at: "2026-03-02T09:43:07.791044431+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Jul 4, 2024

2024 年 7 月 4 日

[流式传输（Streaming）](https://vercel.com/docs/functions/streaming-functions) 将很快默认对所有 [Node.js Vercel Functions](https://vercel.com/docs/functions/runtimes/node-js#using-the-node.js-runtime-with-serverless-functions) 启用。

该变更将于 **2024 年 7 月 8 日** 起对 Hobby 计划账户生效；并于 **2024 年 10 月 1 日** 起对 Pro 和 Enterprise 计划账户生效。

如需立即为您的所有 Vercel Functions 全局启用流式传输作为默认行为，请在项目中将环境变量 `VERCEL_FORCE_NODEJS_STREAMING` 设置为 `true`。下次部署时，流式传输功能即会启用。

函数返回的流式响应将改变您的 [运行时日志格式与频率](https://vercel.com/docs/functions/streaming-functions#runtime-logs)。如果您正在使用日志转发（Log Drains），请确保您的日志采集管道能够兼容新的日志格式并应对更高的日志输出频率。

更多详情，请参阅这篇 [博客文章](https://vercel.com/blog/vercel-functions-streaming-to-be-framework-agnostic) 以及我们的 [流式传输文档](https://vercel.com/docs/functions/streaming-functions)。