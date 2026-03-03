---
title: "New webhook events for domain management - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-webhook-events-for-domain-management"
date: "2025-06-26"
scraped_at: "2026-03-02T09:31:55.070030660+00:00"
language: "en-zh"
translated: true
description: "You can now subscribe to webhook events for deeper visibility into domain operations on Vercel. These events make it easier to automate domain workflows, especially in multi-tenant platforms or when m..."
---

Jun 26, 2025

2025 年 6 月 26 日

您现在可以订阅 Webhook 事件，从而更深入地洞察 Vercel 上的域名操作。

**新增事件类别包括：**

- **域名转移（Domain transfers）**：跟踪入站域名转移过程中的关键阶段。

- **域名续订（Domain renewals）**：监控续订尝试及自动续订状态变更，便于在影响服务可用性之前及时发现失败情况。

- **域名证书（Domain certificates）**：当证书被签发、续订或移除时收到通知，助您确保各环境下的 HTTPS 覆盖始终有效。

- **DNS 更改（DNS changes）**：当 DNS 记录被创建、更新或删除时接收告警。

- **项目域名管理（Project Domain Management）**：检测跨项目的域名生命周期变更，包括域名创建、更新、验证状态及重新分配等。

这些事件对多租户平台尤为有价值——此类平台通常为每位用户或客户动态分配域名。同时，它们也帮助团队将监控与告警能力嵌入关键的域名及证书运维流程中。

有关如何订阅的详细说明，请参阅 [Webhook 文档](https://vercel.com/docs/webhooks/webhooks-api)。