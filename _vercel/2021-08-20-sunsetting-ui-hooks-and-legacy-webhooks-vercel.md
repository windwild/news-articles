---
render_with_liquid: false
title: "Sunsetting UI-Hooks and Legacy Webhooks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sunsetting-ui-hooks-and-legacy-webhooks"
date: "2021-08-20"
scraped_at: "2026-03-02T10:04:23.194316691+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Aug 20, 2021

2021 年 8 月 20 日

![](images/sunsetting-ui-hooks-and-legacy-webhooks-vercel/img_001.jpg)

如[此前公告](https://vercel.com/changelog/ui-hooks-for-integrations-will-be-deprecated)（发布于 2021 年 5 月 25 日）所述，Vercel 将移除面向集成（Integrations）的 UI Hooks 功能。

UI Hooks 已不再对新创建的集成开放，且后续也将从所有现有集成中彻底移除。这意味着：

- 含有 UI Hooks 的集成将无法再被安装。

- 集成的 UI Hooks 将不再显示在控制台（Dashboard）中。

- 对应的配置字段将从集成控制台（Integration Console）中移除。

- 以下 API 端点  
  `/v1/integrations/configuration/:id/metadata`  
  将停止可用。

Furthermore, we also deprecated the manual webhook creation through our API. See our [previous announcement](https://vercel.com/changelog/integration-webhooks-are-now-easier-to-configure) about this change. This means that:

此外，我们还弃用了通过 API 手动创建 Webhook 的方式。有关此项变更的详情，请参阅我们此前的[公告](https://vercel.com/changelog/integration-webhooks-are-now-easier-to-configure)。这意味着：

- The API endpoint

`/v1/integrations/webhooks`

will become unavailable.

- 以下 API 端点  
`/v1/integrations/webhooks`  
将停止可用。

- The API endpoint

`/v1/integrations/webhooks/:id`

will become unavailable.

- 以下 API 端点  
`/v1/integrations/webhooks/:id`  
将停止可用。

- `DELETE`

requests to the configured generic Webhook URL will be not send anymore.

- 针对已配置的通用 Webhook URL 发起的 `DELETE` 请求将不再被发送。

Check the [updated documentation](https://vercel.com/docs/integrations#upgrading-your-integration) to learn more about upgrading your Integration.

请查阅[更新后的文档](https://vercel.com/docs/integrations#upgrading-your-integration)，了解如何升级您的 Integration。