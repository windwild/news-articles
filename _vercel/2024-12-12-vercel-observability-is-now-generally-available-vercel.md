---
title: "Vercel Observability is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-observability-is-now-generally-available"
date: "2024-12-12"
scraped_at: "2026-03-02T09:38:32.836573809+00:00"
language: "en-zh"
translated: true
description: "Observability is now available to all Vercel customers, delivering insights to optimize infrastructure and application performance."
---

Dec 12, 2024

2024 年 12 月 12 日

![](images/vercel-observability-is-now-generally-available-vercel/img_001.jpg)![](images/vercel-observability-is-now-generally-available-vercel/img_002.jpg)

Vercel Observability is now available to all Vercel customers, delivering framework-aware insights to optimize infrastructure and application performance.

Vercel Observability 现已面向所有 Vercel 用户正式发布，提供与开发框架深度集成的洞察能力，助力优化基础设施与应用性能。

Included with all plans, Observability offers visibility—at both the [team](https://vercel.com/d?to=%2F%5Bteam%5D%2F~%2Fobservability%2Fserverless-functions&title=Go+to+Observability) and [project](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability&title=Go+to+Vercel+Observability) levels—into key metrics aligned with your app's architecture, such as:

所有订阅方案均包含 Observability 功能，支持在 [团队](https://vercel.com/d?to=%2F%5Bteam%5D%2F~%2Fobservability%2Fserverless-functions&title=Go+to+Observability) 和 [项目](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability&title=Go+to+Vercel+Observability) 两个层级，全面观测与您应用架构高度契合的关键指标，包括：

- **Vercel Functions usage:** Invocations, durations, and error rates  
- **Vercel Functions 使用情况**：调用次数、执行时长与错误率  

- **In-function concurrency:** Resource and cost-savings for customers with in-function concurrency enabled  
- **函数内并发（In-function concurrency）**：为已启用函数内并发功能的客户提升资源利用率并降低成本  

- **External API requests:** Outgoing API calls by hostname  
- **外部 API 请求**：按主机名统计的出站 API 调用  

- **Edge Requests:** Request volumes by routes, including dynamic routes like `/blog/[slug]`  
- **边缘请求（Edge Requests）**：按路由统计的请求量，涵盖 `/blog/[slug]` 等动态路由  

- **Fast Data Transfer:** Path-level insights on requests by incoming, outgoing, and total data transfer  
- **快速数据传输（Fast Data Transfer）**：按路径粒度分析请求的入站、出站及总数据传输量  

- **Builds**: Resource usage and build-step latency  
- **构建（Builds）**：资源消耗与各构建步骤的延迟

- **ISR 缓存（增量静态再生缓存）：** 路由级别的读写用量，以及重新验证期间的函数总执行时长

- **ISR 缓存（增量静态再生缓存）：** 路由级别的读写用量，以及重新验证期间的函数总执行时长


除上述功能外，Pro 和 Enterprise 计划的客户可升级至 [Observability Plus](https://vercel.com/docs/observability#enabling-observability-plus)，以获得以下权益：

除上述功能外，Pro 和 Enterprise 计划的客户可升级至 [Observability Plus（增强可观测性）](https://vercel.com/docs/observability#enabling-observability-plus)，以获得以下权益：

- 延长数据保留期至 30 天  
- 完整访问所有数据字段及聚合延迟统计信息  
- 支持高级查询的监控能力  
- 路径级计算分析  

- 延长数据保留期至 30 天  
- 完整访问所有数据字段及聚合延迟统计信息  
- 支持高级查询的监控能力  
- 路径级计算分析  


Observability Plus 的定价从每月 $10 起，按需使用费用为每百万事件 $1.20（按比例计费）。

Observability Plus 的定价从每月 10 美元起，按需使用费用为每百万事件 1.20 美元（按比例计费）。


[监控功能现已整合进](https://vercel.com/changelog/monitoring-pricing-reduced-up-to-87) Observability Plus。现有 Monitoring 用户无需任何操作，即可享受新下调的费率——每百万事件 $1.20；同时，用户也可迁移至 Observability Plus，以获取完整功能套件。

[监控功能现已整合进](https://vercel.com/changelog/monitoring-pricing-reduced-up-to-87) Observability Plus（增强可观测性）。现有 Monitoring 用户无需任何操作，即可享受新下调的费率——每百万事件 1.20 美元；同时，用户也可迁移至 Observability Plus，以获取完整功能套件。


了解更多关于 [Vercel 可观测性（Observability）](https://vercel.com/docs/observability) 的信息。

了解更多关于 [Vercel 可观测性（Observability）](https://vercel.com/docs/observability) 的信息。