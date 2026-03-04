---
title: "Query data on external API requests in Vercel Observability - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/query-data-on-external-api-requests-in-vercel-observability"
date: "2025-09-24"
scraped_at: "2026-03-02T09:28:00.934823121+00:00"
language: "en-zh"
translated: true
description: "It's now possible to run custom queries against all external API requests that where made from Vercel Functions"
---
&#123;% raw %}

Sep 24, 2025

2025 年 9 月 24 日

Observability Plus 现已支持查询和可视化外部 API 请求。

Observability Plus 的 [查询构建器](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%3Fbuilder%3Dtrue%26by%3DprojectId) 使客户能够探索其 Vercel 数据，并对流量、性能及其他关键指标进行可视化。您现在可针对外部 API 调用（例如向 AI 服务商发起的 `fetch` 请求）编写自定义查询，统计请求数量或首字节时间（TTFB）。

TTFB 查询结果包含平均值、最小值、最大值以及第 75、90、95 和 99 百分位数（p75、p90、p95、p99）的细分数据。您还可按 `request hostname`（请求主机名）对结果进行筛选或分组，从而聚焦于特定的 API。

查询构建器面向使用 Observability Plus 的 Pro 和 Enterprise 团队开放。

了解更多关于 [可观测性（Observability）](https://vercel.com/docs/observability) 和 [Observability Plus](https://vercel.com/docs/observability/observability-plus) 的信息。
&#123;% endraw %}
