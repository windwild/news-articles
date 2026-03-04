---
title: "Integration Webhooks are now easier to configure - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/integration-webhooks-are-now-easier-to-configure"
date: "2021-04-20"
scraped_at: "2026-03-02T10:04:59.640461088+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Apr 20, 2021

2021 年 4 月 20 日

![](images/integration-webhooks-are-now-easier-to-configure-vercel/img_001.jpg)

您现在可以在 [Integration](https://vercel.com/docs/integrations) 设置中指定一个**通用 Webhook URL**。如果您的 Integration 依赖 Webhook，则配置和使用 Webhook 将变得简单得多。以下每类事件均将以 `POST` 请求的形式发送：

- [Deployment Created](https://vercel.com/docs/api#integrations/webhooks/event-payloads/deployment)（部署已创建）、[Deployment Ready](https://vercel.com/docs/api#integrations/webhooks/event-payloads/deployment-ready)（部署已就绪）和 [Deployment Error](https://vercel.com/docs/api#integrations/webhooks/event-payloads/deployment-error)（部署出错）事件，将在您的 Integration 所安装的每个 Project 中触发。

- [Integration Removed](https://vercel.com/docs/api#integrations/webhooks/event-payloads/integration-configuration-removed)（Integration 已移除）和 [Permission Updated](https://vercel.com/docs/api#integrations/webhooks/event-payloads/integration-configuration-permission-updated)（权限已更新）事件，将在您的 Integration 创建的每个 Integration Configuration 中触发。

- [Project Created](https://vercel.com/docs/api#integrations/webhooks/event-payloads/project-created)（Project 已创建）和 [Project Removed](https://vercel.com/docs/api#integrations/webhooks/event-payloads/project-removed)（Project 已移除）事件，将在 Integration 拥有某个 Vercel 作用域下全部 Project 的访问权限时触发——即当该作用域内有 Project 被创建或移除时。

此前，您可通过 Vercel API 手动列出、创建和删除 Webhook；但该 API 已被弃用，并将于 **2021 年 8 月 20 日**正式移除。

我们不再支持“删除钩子 URL”（Delete Hook URL）——即当 Integration Configuration 被移除时向其发送 `DELETE` 请求的功能。若此前已设置了 Delete Hook URL，则该 URL 现已被自动设为普通 Webhook URL，且“Integration Removed”（Integration 已移除）事件默认启用。目前，“Integration Removed”事件会以两个请求形式发送（一个 `POST` 请求和一个 `DELETE` 请求）；但从 **2021 年 8 月 20 日起**，`DELETE` 请求将停止发送。

请查阅[更新后的文档](https://vercel.com/docs/integrations#webhooks)及[API 参考](https://vercel.com/docs/integrations#webhooks/events)了解更多信息。