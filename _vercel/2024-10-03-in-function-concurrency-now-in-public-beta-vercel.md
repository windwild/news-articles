---
title: "In-function concurrency now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/in-function-concurrency-now-in-public-beta"
date: "2024-10-03"
scraped_at: "2026-03-02T09:40:38.914418423+00:00"
language: "en-zh"
translated: true
description: "In-function concurrency is now in public beta, and allows a single function instance to handle multiple invocations concurrently, improving resource utilization by taking advantage of idle time in exi..."
---

Oct 3, 2024

2024年10月3日

![](images/in-function-concurrency-now-in-public-beta-vercel/img_001.jpg)![](images/in-function-concurrency-now-in-public-beta-vercel/img_002.jpg)

[**函数内并发现已整合至 Fluid 计算平台**\\
\\
Fluid 计算融合了传统服务器的高效性与无服务器架构的灵活性，可支持实时、动态的工作负载，例如 API、流式处理和 AI 应用。\\
\\
了解 Fluid](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute)

[**函数内并发现已进入公开测试阶段（public beta）**](https://vercel.com/docs/release-phases#public-beta)，它允许单个函数实例同时处理多个调用，从而在现有函数实例处于空闲时段时充分利用资源，显著提升资源利用率。

传统无服务器架构中，一个函数实例仅对应一次调用；而借助函数内并发能力，多个调用可重叠执行，效率可提升 20%–50%，从而减少 GB·小时（gigabyte-hours）消耗，并降低总体成本。

作为本次公开测试的一部分，我们对每个函数实例所支持的最大并发调用数设置了初始限制，并将根据用户反馈逐步提高该上限。请注意：对于纯 CPU 密集型工作负载，此功能可能导致延迟略有增加。

函数内并发的公开测试版面向所有使用 [Standard 或 Performance 函数 CPU 配置](https://vercel.com/docs/functions/configuring-functions/memory#setting-your-default-function-memory-/-cpu-size) 的 [Pro 和 Enterprise 计划](https://vercel.com/docs/accounts/plans#account-plans-on-vercel) 用户开放。您可通过 [控制台仪表板启用该功能](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings)，并实时追踪资源节省效果。

了解更多，请阅读我们的 [博客文章](https://vercel.com/blog/serverless-servers-introducing-in-function-concurrency-for-vercel-functions-2MoEVmoCwraZoZC9t5HI59) 和 [官方文档](https://vercel.com/docs/functions/runtimes/node-js#in-function-concurrency)。