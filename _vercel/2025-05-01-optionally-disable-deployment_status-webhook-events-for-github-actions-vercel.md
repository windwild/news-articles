---
title: "Optionally disable deployment_status webhook events for GitHub Actions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/optionally-disable-deployment_status-webhook-events-for-github-actions"
date: "2025-05-01"
scraped_at: "2026-03-02T09:34:15.946674721+00:00"
language: "en-zh"
translated: true
description: "You can now disable webhook events that Vercel sends to GitHub Actions that create many notifications on GitHub pull requests."
---
&#123;% raw %}

May 1, 2025

2025年5月1日

![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_001.jpg)![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_002.jpg)

您现在可以禁用 Vercel 在连接至您的 GitHub 仓库时向 GitHub 发送的 [`deployment_status` webhook 事件](https://docs.github.com/en/webhooks/webhook-events-and-payloads#deployment_status)。

当启用 `deployment_status` 事件时，GitHub 的拉取请求（Pull Request）活动会为每次部署生成一条带状态信息的日志。虽然这有助于团队更及时地掌握部署动态，但对于部署事件频繁的仓库（尤其是包含多个项目的单体仓库 monorepo），也可能导致事件日志过于冗杂、干扰关键信息。

![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_003.jpg)![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_004.jpg)

禁用这些事件后，可避免重复消息充斥 GitHub 拉取请求的事件历史记录，从而为您提供更简洁、更聚焦的 PR 活动视图。Vercel 在 GitHub 上发布的包含预览部署链接的评论将照常发布，不受影响。

![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_005.jpg)![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_006.jpg)

[`deployment_status` 事件](https://docs.github.com/en/rest/deployments/deployments?apiVersion=2022-11-28)最常被用作 GitHub Actions 的触发器。我们建议您[迁移到 `repository_dispatch` 事件](https://vercel.com/docs/git/vercel-for-github#migrating-from-deployment_status)，以简化工作流，并利用更丰富的 Vercel 部署信息。

[参阅文档了解更多信息](https://vercel.com/docs/git/vercel-for-github#silence-deployment-notifications-on-pull-requests)。
&#123;% endraw %}
