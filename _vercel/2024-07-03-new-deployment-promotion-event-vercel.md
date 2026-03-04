---
title: "New deployment promotion event - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-webhook-for-promotion-events"
date: "2024-07-03"
scraped_at: "2026-03-02T09:43:23.702789130+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Jul 3, 2024

2024 年 7 月 3 日

通过 Webhook 订阅新的 `deployment.promoted` [事件](https://vercel.com/docs/observability/webhooks-overview/webhooks-api#deployment.promoted)，即可在部署[晋升](https://vercel.com/docs/deployments/managing-deployments#managing-promotion)后收到通知。

“晋升”（Promotion）是指将您的生产环境域名分配给某次部署，使其开始承接生产流量的操作。该新事件将在以下情况下向您发送通知：

- 部署被自动晋升，且域名被自动分配（默认行为）

- 部署通过 CLI、API 或控制台被[显式晋升](https://vercel.com/docs/deployments/managing-deployments#staging-and-promoting-a-production-deployment)。

[了解更多关于晋升的信息](https://vercel.com/docs/deployments/managing-deployments#managing-promotion)，或查看[完整的事件列表](https://vercel.com/docs/observability/webhooks-overview/webhooks-api)。
{% endraw %}
