---
render_with_liquid: false
title: "Application-aware Observability now in limited beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/application-aware-observability-in-limited-beta"
date: "2024-10-02"
scraped_at: "2026-03-02T09:40:59.215564620+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Oct 2, 2024

2024 年 10 月 2 日

![](images/application-aware-observability-now-in-limited-beta-vercel/img_001.jpg)![](images/application-aware-observability-now-in-limited-beta-vercel/img_002.jpg)

我们正逐步推出全新的可观测性（Observability）功能，为您在 Vercel 控制台中提供更深入的应用性能与行为洞察。

该功能将覆盖函数执行、数据传输、缓存机制及 API 请求等维度，提供精细化的分析能力，进一步增强 Vercel [框架定义基础设施](https://vercel.com/blog/framework-defined-infrastructure-6TC15lNnFHwnz1XJ570BE9)（Framework-Defined Infrastructure）的可观测性。

新增洞察能力包括：

- **Vercel Functions 与外部 API 请求**：监控函数运行行为及对外部服务的请求情况，涵盖调用次数、执行时长与错误率等指标

- **Vercel 边缘网络（Edge Network）**：追踪数据传输量、增量静态再生（ISR）使用情况及边缘请求详情，深入分析缓存命中率、内容重新验证（revalidation）以及基于地理位置的性能表现

目前，可观测性功能已面向现有 Monitoring 订阅用户开启限量公测（Limited Beta），您可通过 Vercel 项目中的全新 **Observability（可观测性）标签页** 进行访问。

如需更高级的平台级可观测性能力，欢迎[探索我们与 Sentry、Datadog、Honeycomb 等厂商的集成方案](https://vercel.com/marketplace?category=observability)。