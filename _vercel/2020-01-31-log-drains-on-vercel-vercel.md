---
render_with_liquid: false
title: "Log Drains on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/log-drains"
date: "2020-01-31"
scraped_at: "2026-03-02T10:07:16.635500536+00:00"
language: "en-zh"
translated: true
description: "Easily forward and collect your logs using Log Drains."
---
render_with_liquid: false
render_with_liquid: false

Jan 31, 2020

2020 年 1 月 31 日

通过第一方集成和自定义集成，将日志收集至您最喜爱的日志服务提供商。

检查某次部署的 [构建步骤](https://vercel.com/docs/build-step)、[运行时](https://vercel.com/docs/serverless-functions/introduction) 和 [边缘网络](https://vercel.com/docs/edge-network/overview) 流量所产生的日志，对于精准定位其行为特征、深入理解可优化环节至关重要。

今天，我们非常激动地宣布推出 **日志接收器（Log Drains）** 功能：您可借助专精于应用日志存储的服务，集中收集所有日志。

## 日志接收器（Log Drains）简介

日志接收器（Log Drains）让日志收集变得轻而易举——每当生成一条新日志行时，系统便会通过 `HTTPS`、`HTTP`、`TLS` 或 `TCP` 协议，将日志实时转发至归档、检索与告警等下游服务。

截至本文撰写之时，我们当前支持以下 3 种日志格式的接收器：

- JSON  
- NDJSON  
- Syslog

Along with Log Drains, we are introducing two new logging integrations: **LogDNA** and **Datadog**.

除了日志传输（Log Drains）功能外，我们还推出了两项新的日志集成：**LogDNA** 和 **Datadog**。

![The LogDNA and Datadog integrations available in the ZEIT Integrations marketplace.](images/log-drains-on-vercel-vercel/img_001.jpg)  
ZEIT 集成市场（ZEIT Integrations Marketplace）中提供的 LogDNA 与 Datadog 集成。

## Getting started

## 入门指南

1. Install the desired integration from the [Integrations Marketplace](https://vercel.com/integrations).

1. 从 [集成市场（Integrations Marketplace）](https://vercel.com/integrations) 安装所需的集成。

2. Follow the configuration steps provided and choose a project to connect with the service.

2. 按照提供的配置步骤操作，并选择一个项目与该服务进行连接。

3. Watch your logs appear on the selected service.

3. 查看您的日志实时出现在所选服务中。

![The LogDNA and Datadog application interfaces.](images/log-drains-on-vercel-vercel/img_002.jpg)  
LogDNA 与 Datadog 的应用界面。

## Benefits of Log Drains

## 日志传输（Log Drains）的优势

- Persisted storage of logs.

- 日志持久化存储。

- Large volume of log storage available.

- 支持海量日志存储。

- Ability to create alerts based on logging patterns.  
- 能够基于日志模式创建告警。

- Generating metrics and graphs from logs data.  
- 能够从日志数据中生成指标和图表。

## Conclusion

## 结论

With Log Drains, you can easily collect and forward your deployment logs to a third-party logging provider, such as our fantastic launch partners [LogDNA](https://vercel.com/integrations/logdna), [Logflare](https://vercel.com/integrations/logflare), and [Datadog.](https://vercel.com/integrations/datadog)  
借助 Log Drains，您可以轻松收集并转发部署日志至第三方日志服务提供商，例如我们出色的首发合作伙伴：[LogDNA](https://vercel.com/integrations/logdna)、[Logflare](https://vercel.com/integrations/logflare) 和 [Datadog](https://vercel.com/integrations/datadog)。

Ready to develop an integration? Check out our documentation and [create an integration with Vercel today](https://vercel.com/docs/integrations).  
准备开发集成？请查阅我们的文档，并[立即使用 Vercel 创建集成](https://vercel.com/docs/integrations)。

All of our work is heavily driven by feedback from our users. For feature requests, or to suggest ideas to make our platform and your experience better, please reach out to us [via email](mailto:support@vercel.com) or on [Twitter](https://twitter.com/vercel).  
我们所有的工作都高度依赖于用户的反馈。如需提出功能需求，或就如何改进平台及您的使用体验提供宝贵建议，欢迎通过[电子邮件](mailto:support@vercel.com)或在[Twitter](https://twitter.com/vercel) 上联系我们。