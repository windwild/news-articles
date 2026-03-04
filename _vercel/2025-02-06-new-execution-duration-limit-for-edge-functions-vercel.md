---
title: "New execution duration limit for Edge Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-execution-duration-limit-for-edge-functions"
date: "2025-02-06"
scraped_at: "2026-03-02T09:36:45.565451037+00:00"
language: "en-zh"
translated: true
description: "Learn about the upcoming update to Vercel Edge Functions, introducing a new execution duration limit of 300 seconds to enhance predictability and reliability in function management starting March 1st,..."
---
{% raw %}

Feb 6, 2025

2025 年 2 月 6 日

Starting on March 1st, 2025, we will begin the rollout of a new execution duration limit of 300 seconds for [Vercel Functions](https://vercel.com/docs/functions/runtimes/edge-runtime) using the Edge runtime.

自 2025 年 3 月 1 日起，我们将开始对使用 Edge 运行时的 [Vercel Functions](https://vercel.com/docs/functions/runtimes/edge-runtime) 实施新的执行时长限制：300 秒。

Previously, Edge Functions had no fixed timeout for streaming responses, leading to unpredictable behavior based on system resources and traffic. With this update, Edge Functions will consistently allow streaming responses for up to 300 seconds, including post-response tasks like `waitUntil()`.

此前，Edge Functions 对流式响应未设定固定超时时间，其行为会因系统资源和流量状况而产生不可预测的变化。本次更新后，Edge Functions 将统一支持最长 300 秒的流式响应，该时限涵盖响应发送完成后的后续任务（例如 `waitUntil()`）。

Please note that Edge Functions must begin sending a response within **25 seconds** to maintain streaming capabilities beyond this period. This limit remains as before.

请注意：为确保在 25 秒之后仍能维持流式响应能力，Edge Functions 必须在 **25 秒内** 开始发送响应。此项限制保持不变。

Learn more about [Vercel Functions using the Edge runtime](https://vercel.com/docs/functions/runtimes/edge/edge-functions).

了解更多关于[使用 Edge 运行时的 Vercel Functions](https://vercel.com/docs/functions/runtimes/edge/edge-functions)。
{% endraw %}
