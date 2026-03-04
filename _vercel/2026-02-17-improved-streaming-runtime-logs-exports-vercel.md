---
title: "Improved streaming runtime logs exports - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-streaming-runtime-logs-exports"
date: "2026-02-17"
scraped_at: "2026-03-02T09:21:31.703314381+00:00"
language: "en-zh"
translated: true
description: "Runtime Logs exports now stream directly to your browser, export actual requests instead of raw rows, and match exactly what's on your screen or search."
---

render_with_liquid: false
Feb 17, 2026

2026 年 2 月 17 日

借助运行时日志（Runtime Logs），您可以查看并导出您的日志。现在，导出功能直接流式传输至浏览器——您的下载会立即开始，同时您可继续使用 Vercel 控制台，导出任务则在后台持续运行。这消除了等待大型文件完成缓冲的需要。

此外，我们新增了两项导出选项：您现在可以导出当前屏幕所显示的全部内容，或导出所有匹配当前搜索条件的请求。

![](images/improved-streaming-runtime-logs-exports-vercel/img_001.jpg)![](images/improved-streaming-runtime-logs-exports-vercel/img_002.jpg)

所有套餐均支持单次导出最多 10,000 条请求；而 [Observability Plus](https://vercel.com/docs/observability/observability-plus) 订阅用户则可单次导出最多 100,000 条请求。

导出的日志数据现按请求（request）进行索引，以确保与 [运行时日志](https://vercel.com/docs/observability/runtime-logs) 控制台界面保持一致。导出限制也已按请求粒度实施，从而确保导出的数据严格匹配控制台中所筛选显示的请求。

[了解更多关于运行时日志的信息](https://vercel.com/docs/logs/runtime)