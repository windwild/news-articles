---
title: "Log drains now support log source selection - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/log-drains-now-support-log-source-selection"
date: "2022-06-02"
scraped_at: "2026-03-02T10:01:57.388270846+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jun 2, 2022

2022年6月2日

![Log sources selection](images/log-drains-now-support-log-source-selection-vercel/img_001.jpg)

![日志源选择](images/log-drains-now-support-log-source-selection-vercel/img_001.jpg)

Log drains can now be configured to send over select Vercel logs to providers for reduced log management costs and simplified monitoring setup. This new functionality is currently available for the [Datadog](https://vercel.com/integrations/datadog-logs) integration.

日志接收器（log drains）现在可配置为仅向第三方服务商发送指定的 Vercel 日志，从而降低日志管理成本，并简化监控配置流程。该新功能当前已支持 [Datadog](https://vercel.com/integrations/datadog-logs) 集成。

Choose to send logs from the following sources:

请选择要发送日志的来源：

- `static`

- `static`（静态资源）

- `lambda`

- `lambda`（Serverless 函数）

- `edge`

- `edge`（边缘函数）

- `build`

- `build`（构建日志）

- `external`

- `external`（外部服务日志）

For information on log sources and how to add them to your integration, [check out the documentation](https://vercel.com/docs/log-drains#log-sources).

有关日志源的详细说明以及如何将其添加到您的集成中，请参阅[官方文档](https://vercel.com/docs/log-drains#log-sources)。