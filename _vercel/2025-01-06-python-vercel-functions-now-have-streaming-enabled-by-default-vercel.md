---
title: "Python Vercel Functions now have streaming enabled by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-vercel-functions-now-have-streaming-enabled-by-default"
date: "2025-01-06"
scraped_at: "2026-03-02T09:38:25.216986468+00:00"
language: "en-zh"
translated: true
description: "Streaming is now enabled by default for all Vercel Functions using the Python runtime. Python functions can now send data to the client as it’s generated, rather than waiting for the entire response..."
---
{% raw %}

Jan 6, 2025

2025 年 1 月 6 日

[Streaming](https://vercel.com/docs/functions/streaming-functions) is now enabled by default for all Vercel Functions using the [Python runtime](https://vercel.com/docs/functions/runtimes/python), completing the rollout plan [announced last year](https://vercel.com/changelog/streaming-is-now-supported-in-vercel-functions-for-the-python-runtime).  
[流式传输（Streaming）](https://vercel.com/docs/functions/streaming-functions) 现已默认启用，适用于所有使用 [Python 运行时（Python runtime）](https://vercel.com/docs/functions/runtimes/python) 的 Vercel Functions，从而完成了去年[宣布的上线计划](https://vercel.com/changelog/streaming-is-now-supported-in-vercel-functions-for-the-python-runtime)。Python 函数现在可在数据生成的同时即时发送至客户端，而无需等待整个响应完成——这对 AI 应用和实时更新等场景尤为有益。

The `VERCEL_FORCE_PYTHON_STREAMING` environment variable is no longer necessary, as streaming is now applied automatically in your new deployments.  
`VERCEL_FORCE_PYTHON_STREAMING` 环境变量已不再需要，因为流式传输功能将在您的新部署中自动启用。

With streaming responses, the runtime log format and frequency have been updated.  
启用流式响应后，运行时日志的格式与输出频率均已更新。

If you’re using Log Drains, ensure your ingestion pipeline can handle the new log format and increased log frequency.  
若您正在使用 Log Drains，请确保您的日志采集管道能够兼容新的日志格式，并可应对更频繁的日志输出。

For more details, visit [our documentation](https://vercel.com/docs/functions/streaming-functions#streaming-python-functions) or get started with [our template](https://vercel.com/templates/python/ai-sdk-python-streaming).  
如需了解更多详情，请访问[我们的文档](https://vercel.com/docs/functions/streaming-functions#streaming-python-functions)，或通过[我们的模板](https://vercel.com/templates/python/ai-sdk-python-streaming)快速上手。
{% endraw %}
