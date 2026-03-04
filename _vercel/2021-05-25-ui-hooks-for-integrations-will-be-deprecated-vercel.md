---
title: "UI Hooks for Integrations will be deprecated - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/ui-hooks-for-integrations-will-be-deprecated"
date: "2021-05-25"
scraped_at: "2026-03-02T10:04:56.555684741+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
May 25, 2021

2021 年 5 月 25 日

![](images/ui-hooks-for-integrations-will-be-deprecated-vercel/img_001.jpg)

Since the launch of the [Integration Marketplace](https://vercel.com/integrations), any newly submitted Integration was expected to provide UI Hooks for integrating its UI into the Vercel Dashboard.

自 [集成市场（Integration Marketplace）](https://vercel.com/integrations) 上线以来，所有新提交的集成（Integration）均需提供 UI Hooks，以便将其用户界面集成至 Vercel 控制台（Dashboard）中。

As this constraint required a lot of additional work to be done by third-party services that already had their Integration UI available in their own dashboard, UI Hooks will now be deprecated in favor of allowing Integration authors to re-use existing interfaces outside Vercel.

由于该限制要求已在其自有控制台中提供集成 UI 的第三方服务额外投入大量开发工作，Vercel 决定弃用 UI Hooks，转而允许集成开发者复用其在 Vercel 外部已有的用户界面。

UI Hooks have already become unavailable for newly created Integrations, but they will soon also be removed from all existing Integrations, meaning that:

UI Hooks 已对所有新创建的集成不可用；不久之后，它们也将从所有现有集成中彻底移除。这意味着：

- Integration UI Hooks will no longer be shown on the Dashboard.

- 集成 UI Hooks 将不再显示在控制台中。

- The respective configuration field will be removed from the Integration Console.

- 相应的配置字段将从集成控制台（Integration Console）中移除。

- The API endpoint `/v1/integrations/configuration/:id/metadata` will become unavailable.

- API 端点 `/v1/integrations/configuration/:id/metadata` 将停止可用。

These changes will be applied on **August 20th, 2021**, which is the same date as the one that was announced for the [Deprecation of old Integration Webhooks](https://vercel.com/changelog/integration-webhooks-are-now-easier-to-configure).

上述变更将于 **2021 年 8 月 20 日**正式生效，该日期与此前公布的 [旧版集成 Webhook 弃用计划](https://vercel.com/changelog/integration-webhooks-are-now-easier-to-configure) 所定日期一致。

Check out [the updated documentation](https://vercel.com/docs/integrations#upgrading-your-integration) to learn more about upgrading your Integration.

请查阅 [更新后的文档](https://vercel.com/docs/integrations#upgrading-your-integration)，了解如何升级您的集成。