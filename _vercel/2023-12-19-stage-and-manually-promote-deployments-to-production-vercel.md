---
title: "Stage and manually promote deployments to production - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/stage-and-manually-promote-deployments-to-production"
date: "2023-12-19"
scraped_at: "2026-03-02T09:48:58.114677360+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Dec 19, 2023

2023 年 12 月 19 日

![](images/stage-and-manually-promote-deployments-to-production-vercel/img_001.jpg)![](images/stage-and-manually-promote-deployments-to-production-vercel/img_002.jpg)

您现在可以自主控制域名何时分配给部署，从而实现生产环境部署的**手动上线（Promotion）**，使其开始对外提供流量服务。

当创建新部署时（通过我们的 [Git 集成](https://vercel.com/docs/deployments/git)、CLI 或 [REST API](https://vercel.com/docs/rest-api)），Vercel 将自动为该部署应用项目中已配置的所有自定义域名。

现在，您可创建**暂存部署（Staged Deployments）**——即暂不分配任何域名的部署；待验证通过后，再将其手动提升（Promote）至生产环境并正式对外提供服务。此功能对构建自定义工作流，或为质量保障（QA）与测试目的维护多个生产级环境尤为有用。

**在仪表板（Dashboard）中操作**

- 在 Git 项目的设置中，禁用生产分支（Production Branch）的域名自动分配功能。

- 在全部部署列表中找到目标部署，点击右侧菜单，选择 **Promote to Production**（提升至生产环境）。

**通过 CLI 操作**

- `vercel --prod --skip-domain`

- `vercel promote [deployment-id or url]`

- `vercel promote [部署 ID 或 URL]`

[Learn more](https://vercel.com/docs/deployments/managing-deployments#manually-promoting-to-production) in our documentation.

[了解更多](https://vercel.com/docs/deployments/managing-deployments#manually-promoting-to-production) 请参阅我们的文档。