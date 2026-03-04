---
title: "Metrics for outgoing requests - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/metrics-for-outgoing-requests"
date: "2024-01-16"
scraped_at: "2026-03-02T09:48:24.711782302+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jan 16, 2024

2024 年 1 月 16 日

![Screenshot of new requests metrics, showing 5 outgoing fetch requests with traces on the side](images/metrics-for-outgoing-requests-vercel/img_001.jpg)![Screenshot of new requests metrics, showing 5 outgoing fetch requests with traces on the side](images/metrics-for-outgoing-requests-vercel/img_002.jpg)

![新请求指标截图，显示 5 个发出的 fetch 请求及侧边对应的追踪信息](images/metrics-for-outgoing-requests-vercel/img_001.jpg)![新请求指标截图，显示 5 个发出的 fetch 请求及侧边对应的追踪信息](images/metrics-for-outgoing-requests-vercel/img_002.jpg)

You can now see all outgoing requests for a selected log in [Runtime Logs](https://vercel.com/docs/observability/runtime-logs).

您现在可在 [运行时日志（Runtime Logs）](https://vercel.com/docs/observability/runtime-logs) 中查看所选日志发起的所有出站请求。

Logs now display the status, duration, URL, and a trace for each request. Request metrics work with every request on Vercel, so [all frameworks](https://vercel.com/docs/frameworks) are supported. This makes it easier to debug latency and caching inside your Vercel Functions or when calling [databases](https://vercel.com/docs/storage).

日志现在会为每个请求显示其状态、耗时、URL 及对应追踪（trace）。请求指标适用于 Vercel 上的所有请求，因此支持 [所有框架](https://vercel.com/docs/frameworks)。这有助于更便捷地排查 Vercel Functions 内部的延迟与缓存问题，或在调用 [数据库](https://vercel.com/docs/storage) 时进行调试。

This release also includes various of quality-of-life improvements in the Logs UI.

本次发布还包含日志用户界面（Logs UI）中多项提升使用体验的改进。

Request metrics are **free while in beta** and only available to Pro and Enterprise customers.

请求指标在公测（beta）期间**免费提供**，但仅面向 Pro 和 Enterprise 计划用户开放。