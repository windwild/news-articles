---
title: "Streaming is now supported in Vercel Functions for the Python runtime - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/streaming-is-now-supported-in-vercel-functions-for-the-python-runtime"
date: "2024-11-22"
scraped_at: "2026-03-02T09:39:00.915165773+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Nov 22, 2024

2024 年 11 月 22 日

[流式传输（Streaming）](https://vercel.com/docs/functions/streaming-functions) 现已支持，并即将在 Vercel Functions 的 [Python 运行时（Python runtime）](https://vercel.com/docs/functions/runtimes/python) 中默认启用，使函数能够在数据生成的同时即刻发送至客户端，而无需等待完整响应完成。这一功能对 AI 应用尤为实用。

此次变更将分阶段逐步上线。**自今日起，所有新创建的项目将立即启用该功能；所有现有项目则将于 2025 年 1 月 5 日起全面启用**。在该日期，使用 [日志转发（Log Drains）](https://vercel.com/docs/observability/log-drains) 的项目将完成迁移，且流式响应将[影响运行时日志（runtime logs）的格式与输出频率](https://vercel.com/docs/functions/streaming-functions#runtime-logs)。

若您正在使用日志转发（Log Drains），请确保您的日志采集管道（ingestion pipeline）能够兼容新的日志格式及更高的日志输出频率。

如需为您的 Python 版 Vercel Functions 默认启用流式传输，请在项目中添加环境变量 `VERCEL_FORCE_PYTHON_STREAMING=1`。此后，您下一次生产环境部署将自动启用流式传输功能。

欲了解更多信息，请参阅 [Python 流式传输文档](https://vercel.com/docs/functions/streaming-functions#streaming-python-functions)，或通过 [我们的模板](https://vercel.com/templates/python/ai-sdk-python-streaming) 快速上手。