---
render_with_liquid: false
title: "View advanced function metrics with Observability - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/view-advanced-function-metrics-with-observability"
date: "2024-10-30"
scraped_at: "2026-03-02T09:40:19.025047713+00:00"
language: "en-zh"
translated: true
description: "Users in the limited beta of Observability can now view advanced insights for serverless Vercel Functions. Explore low level metrics about function execution."
---
render_with_liquid: false
render_with_liquid: false

2024年10月30日

2024年10月30日

![](images/view-advanced-function-metrics-with-observability-vercel/img_001.jpg)![](images/view-advanced-function-metrics-with-observability-vercel/img_002.jpg)

![](images/view-advanced-function-metrics-with-observability-vercel/img_001.jpg)![](images/view-advanced-function-metrics-with-observability-vercel/img_002.jpg)

当前处于 [Observability 有限公测阶段](https://vercel.com/changelog/application-aware-observability-in-limited-beta-5POkb52n4XdTZvwbMCqljG) 的用户，现已可查看 Vercel 无服务器函数（Vercel Functions）的高级洞察数据。您可以深入分析函数执行的底层指标，包括：

当前处于 [Observability 有限公测阶段](https://vercel.com/changelog/application-aware-observability-in-limited-beta-5POkb52n4XdTZvwbMCqljG) 的用户，现已可查看 Vercel 无服务器函数（Vercel Functions）的高级洞察数据。您可以深入分析函数执行的底层指标，包括：

- **CPU 节流与内存使用率**：了解 CPU 使用情况和内存消耗，并判断是否可通过为函数分配更多资源来提升性能

- **首字节时间（TTFB）**：通过观测函数响应请求并发送响应首个字节所需的时间，评估其响应速度

- **函数启动类型**：查看冷启动与预热启动的调用比例

- **CPU 节流与内存使用率**：了解 CPU 使用情况和内存消耗，并判断是否可通过为函数分配更多资源来提升性能

- **首字节时间（TTFB）**：通过观测函数响应请求并发送响应首个字节所需的时间，评估其响应速度

- **函数启动类型**：查看冷启动与预热启动的调用比例

Observability 目前处于 [有限公测阶段](https://vercel.com/docs/release-phases#limited-beta)，面向当前已启用 [监控（Monitoring）](https://vercel.com/docs/observability/monitoring#monitoring) 功能的用户开放；您可在 Vercel 项目中新增的 **Observability 标签页** 中访问该功能。

Observability 目前处于 [有限公测阶段](https://vercel.com/docs/release-phases#limited-beta)，面向当前已启用 [监控（Monitoring）](https://vercel.com/docs/observability/monitoring#monitoring) 功能的用户开放；您可在 Vercel 项目中新增的 **Observability 标签页** 中访问该功能。