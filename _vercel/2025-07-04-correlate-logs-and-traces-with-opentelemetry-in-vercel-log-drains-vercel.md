---
title: "Correlate logs and traces with OpenTelemetry in Vercel Log Drains - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/correlate-logs-and-traces-with-opentelemetry-in-vercel-log-drains"
date: "2025-07-04"
scraped_at: "2026-03-02T09:31:30.871000493+00:00"
language: "en-zh"
translated: true
description: "Correlate Vercel Logs and Traces with OpenTelemetry (OTel) in Vercel Log Drains sent to Datadog and Dash0"
---
{% raw %}

Jul 4, 2025

2025 年 7 月 4 日

Vercel 现在会自动将日志与分布式追踪（distributed traces）进行关联，适用于使用 OpenTelemetry（OTel）对应用进行埋点的客户。

追踪（Traces）是一种收集应用程序性能与行为数据的方法，有助于定位性能问题、错误及其他异常的根本原因。[OpenTelemetry（OTel）](https://vercel.com/docs/otel) 是一个开源项目，支持您对应用程序进行埋点以采集追踪数据。

当请求通过 OTel 进行追踪时，Vercel 将自动为相关日志注入追踪 ID（trace ID）和跨度 ID（span ID）。这使得您可以将每条独立日志与特定的追踪或跨度进行关联。

该功能面向通过 Vercel 与 Datadog 和 Dash0 的集成启用日志导出（log drains）的客户。您无需执行任何操作——对于使用 OTel 并已配置上述任一集成的客户，日志与追踪的自动关联将立即生效。

了解更多关于[通过日志导出实现日志与追踪关联](https://vercel.com/docs/drains/using-drains#logs-and-traces-correlation)的信息。
{% endraw %}
