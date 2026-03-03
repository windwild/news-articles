---
title: "Introducing Vercel Drains: Complete observability data, anywhere - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-vercel-drains"
date: "2025-09-15"
scraped_at: "2026-03-02T09:28:40.664142383+00:00"
language: "en-zh"
translated: true
description: "Vercel Drains give you a single way to stream observability data out of Vercel and into the systems your team already rely on."
---

Sep 15, 2025

2025 年 9 月 15 日

Vercel Log Drains are now Vercel Drains.

Vercel Log Drains 现已更名为 Vercel Drains。

Why? They’re not just for logs anymore, as you can now also export OpenTelemetry traces, Web Analytics events, and Speed Insights metrics.

为何更名？因为它们不再仅限于日志导出——您现在还可导出 OpenTelemetry 追踪数据（traces）、Web Analytics 事件以及 Speed Insights 指标。

Drains give you a single way to stream observability data out of Vercel and into the systems your team already rely on.

Drains 为您提供统一的通道，将可观测性数据从 Vercel 实时流式传输至您的团队已在使用的各类系统中。

### Why drains matter

### 为何 Drains 至关重要

Most teams already have an observability stack they trust like Datadog, Honeycomb, Grafana, Elastic, or their own warehouses. But those systems are only as good as the data they receive. Logs alone don’t explain how modern apps behave.

大多数团队已拥有自己信赖的可观测性技术栈，例如 Datadog、Honeycomb、Grafana、Elastic，或自建的数据仓库。但这些系统的价值完全取决于其所接收的数据质量。单靠日志，无法完整解释现代应用的实际行为。

To fully understand performance, you need more than log lines. Traces show how a request moves through serverless functions. Analytics capture user interactions. Real-user metrics reveal what’s happening in the browser.

要全面理解应用性能，仅靠日志行远远不够。追踪（Traces）可揭示请求在无服务器函数（serverless functions）中的流转路径；分析数据（Analytics）可捕获用户交互行为；真实用户指标（Real-user metrics）则能反映浏览器端的实际运行状况。

Vercel Drains unify these signals into a single pipeline, streaming complete data to the tools you already use, and

Vercel Drains 将上述多种信号统一整合至单一数据管道中，将完整的可观测性数据实时流式传输至您已在使用的各类工具，并支持：

- **Logs**: Runtime, build, static asset, firewall, and function logs.

- **日志（Logs）**：运行时日志、构建日志、静态资源日志、防火墙日志及函数日志。

- **Traces**: Trace Drains forward distributed tracing data from your deployments.

- **追踪（Traces）**：Trace Drains 将您各部署环境产生的分布式追踪数据转发出去。

- **Web Analytics**: Lightweight page view and custom event data.  
- **网页分析**：轻量级页面浏览量与自定义事件数据。

- **Speed Insights**: Real-user performance metrics and Web Vitals.  
- **速度洞察**：真实用户性能指标与 Web Vitals。

Because Vercel runs the entire request path, from the browser through to dynamic function execution, these signals are consistent and correlated. Logs from traced requests are automatically enriched with `traceId` and `spanId`, so you can move from a log line straight into the distributed trace it belongs to.  
由于 Vercel 承担了完整的请求链路——从浏览器端一直延伸至动态函数执行——因此这些观测信号具有一致性且彼此关联。被追踪请求所生成的日志会自动注入 `traceId` 和 `spanId` 字段，使您能直接从任意一条日志快速跳转至其所属的分布式追踪（distributed trace）。

![](images/introducing-vercel-drains-complete-observability-data-anywhere-vercel/img_001.jpg)![](images/introducing-vercel-drains-complete-observability-data-anywhere-vercel/img_002.jpg)

## Two ways to drain data  
## 两种数据导出方式

Drains can be created in two forms, depending on how you want to connect:  
根据您的集成需求，Drains 可以以两种形式创建：

**1\. Custom drains:** Set up a drain to any HTTP endpoint you control. You can:  
**1. 自定义 Drains**：将数据导出至您自主控制的任意 HTTP 端点。您可以：

- Pick the data type (logs, traces, analytics, or performance metrics)  
- 选择导出的数据类型（日志、链路追踪、分析数据或性能指标）

- Configure sampling rates to manage traffic  
- 配置采样率以调控传输流量

- Choose JSON, NDJSON, or Protobuf  
- 选择数据序列化格式：JSON、NDJSON 或 Protobuf

- Add headers or signature verification for security

- 添加请求头或签名验证以增强安全性

For example, you might stream traces to an OTLP collector, logs into a self-hosted Elastic cluster, and analytics events into Snowflake.

例如，您可以将追踪数据（traces）流式传输至 OTLP 收集器，将日志（logs）发送至自托管的 Elastic 集群，并将分析事件（analytics events）导入 Snowflake。

**2\. Integration drains:** Vercel has turnkey integrations with vendors like Dash0, Statsig, Datadog, Logflare, and more. These direct integrations help handle the configuration automatically and begin streaming logs into your account.

**2. 集成式导出通道（Integration Drains）：** Vercel 提供开箱即用的厂商集成，支持 Dash0、Statsig、Datadog、Logflare 等服务商。这些直连集成可自动完成配置，并立即开始将日志流式传输至您的账户。

## End-to-end observability

## 端到端可观测性

The advantage of Drains on Vercel is the context. A spike in LCP can be tied back to the trace of a slow API call. A 500 error log can be tied to the specific request that triggered it. By exporting logs, traces, analytics, and performance metrics together, you get one continuous view of how your app behaves in production, to any tools you already use.

Vercel 导出通道（Drains）的核心优势在于上下文关联能力：LCP（最大内容绘制）指标的突增可回溯至某次缓慢 API 调用的追踪链路；一条 500 错误日志可精准关联至触发该错误的具体请求。通过统一导出日志、追踪、分析事件及性能指标，您即可在生产环境中获得应用行为的完整、连续视图，并无缝对接您已有的各类工具。

Since traces follow the OpenTelemetry protocol, they plug directly into Datadog APM, Honeycomb, Grafana Tempo, New Relic, or any vendor that supports OTel, with no custom instrumentation needed. Logs and traces correlate automatically, and analytics can be streamed into the same warehouse you use for business reporting.

由于追踪数据遵循 OpenTelemetry（OTel）协议，因此可直接接入 Datadog APM、Honeycomb、Grafana Tempo、New Relic 等任意支持 OTel 的厂商平台，无需额外定制埋点。日志与追踪自动关联，分析事件亦可直接流式写入您用于业务报表的同一数仓。

Drains are available now on Pro and Enterprise plans. Data exported via Drains is billed at $0.50 per GB, the same rate as existing log drains. You can configure multiple drains per team, across as many projects as needed.

导出通道（Drains）现已面向 Pro 和 Enterprise 计划用户开放。通过 Drains 导出的数据按 $0.50/GB 计费，费率与现有日志导出通道一致。每个团队可配置多个 Drains，并可跨任意数量的项目灵活部署。

## Get started

## 快速入门

You can set up Drains today from your Vercel dashboard → Team Settings → Drains. Choose a Custom HTTP endpoint to stream any data type, or install an Integration from the Marketplace for a managed setup.

您可立即通过 Vercel 控制台 → 团队设置（Team Settings）→ 导出通道（Drains）来配置 Drains：选择“自定义 HTTP 端点（Custom HTTP endpoint）”以流式传输任意类型的数据；或从 Marketplace 安装集成应用，实现托管式一键部署。

[Read the full docs](https://vercel.com/docs/drains) for configuration details, supported formats, and schema references.

[查阅完整文档](https://vercel.com/docs/drains)，了解详细配置方法、支持的数据格式及 Schema 参考。