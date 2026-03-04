---
render_with_liquid: false
title: "Revert and pin deployments with Instant Rollback - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/revert-and-pin-deployments-with-instant-rollback"
date: "2023-12-19"
scraped_at: "2026-03-02T09:49:05.137837006+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Dec 19, 2023

2023 年 12 月 19 日

![](images/revert-and-pin-deployments-with-instant-rollback-vercel/img_001.jpg)![](images/revert-and-pin-deployments-with-instant-rollback-vercel/img_002.jpg)

[Instant Rollback](https://vercel.com/docs/deployments/instant-rollback)

[即时回滚](https://vercel.com/docs/deployments/instant-rollback)

[Instant Rollback](https://vercel.com/docs/deployments/instant-rollback) enables you to quickly revert to a previous production deployment, making it easier to fix breaking changes.

[即时回滚](https://vercel.com/docs/deployments/instant-rollback) 功能使您能够快速回退至此前的生产环境部署，从而更轻松地修复造成故障的变更。

You can now choose to prevent the automatic assignment of production domains when rolling back. Reverted deployments will not be replaced by new production deployments until you [manually promote](https://vercel.com/changelog/stage-and-manually-promote-deployments-to-production) a new deployment.

现在，您可选择在执行回滚操作时禁用生产域名的自动分配。回滚后的部署将不会被新的生产环境部署所覆盖，除非您[手动提升](https://vercel.com/changelog/stage-and-manually-promote-deployments-to-production)某个新部署至生产环境。

[Learn more](https://vercel.com/docs/deployments/managing-deployments#manually-promoting-to-production) in our documentation.

请参阅我们的[文档](https://vercel.com/docs/deployments/managing-deployments#manually-promoting-to-production)了解更多信息。