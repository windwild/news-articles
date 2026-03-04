---
render_with_liquid: false
title: "Manually create deployments by commit or branch in the dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/manually-create-deployments-by-commit-or-branch-in-the-dashboard"
date: "2023-12-19"
scraped_at: "2026-03-02T09:49:00.349191814+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Dec 19, 2023

2023 年 12 月 19 日

![](images/manually-create-deployments-by-commit-or-branch-in-the-dashboard-vercel/img_001.jpg)![](images/manually-create-deployments-by-commit-or-branch-in-the-dashboard-vercel/img_002.jpg)

You can now initiate new deployments directly from the dashboard using a git reference. This approach is helpful when git providers have service interruptions with webhook delivery.

您现在可以通过仪表板（Dashboard）直接使用 Git 引用发起新的部署。当 Git 托管平台因服务中断而无法正常投递 Webhook 时，此方法尤为有用。

To create a deployment from a git branch or SHA:

要基于 Git 分支或提交哈希（SHA）创建部署，请执行以下步骤：

1. From the dashboard, select the project you'd like to create a deployment for.

1. 在仪表板中，选择您希望为其创建部署的项目。

2. Select the **Deployments** tab. Once on the Deployments page, select the **Create Deployment** button in the three dots to the right of the **Deployments** header.

2. 点击 **Deployments**（部署）标签页。进入部署页面后，点击 **Deployments** 标题右侧的三个圆点菜单，然后选择 **Create Deployment**（创建部署）按钮。

Depending on how you would like to deploy, enter the following:

根据您的部署需求，输入以下内容之一：

1. **Targeted Deployments:** Provide the unique ID (SHA) of a commit to build a deployment based on that specific commit.

1. **定向部署（Targeted Deployments）：** 输入某次提交的唯一标识符（即 SHA 值），以基于该次特定提交构建部署。

2. **Branch-Based Deployments:** Provide the full name of a branch when you want to build the most recent changes from that specific branch.

2. **基于分支的部署（Branch-Based Deployments）：** 当您希望基于某一分支的最新变更构建部署时，请输入该分支的完整名称。

Finally, select **Create Deployment** and Vercel will build and deploy your commit or branch.

最后，点击 **Create Deployment**（创建部署），Vercel 将为您构建并部署所选的提交或分支。

When the same commit appears in multiple branches, Vercel will prompt you to choose the appropriate branch configuration. This choice is crucial as it affects settings like environment variables linked to each branch.

当同一提交出现在多个分支中时，Vercel 将提示您选择合适的分支配置。此选择至关重要，因为它会影响与各分支关联的环境变量等设置。

[Learn more](https://vercel.com/docs/deployments/git#creating-a-deployment-from-a-git-reference) in our documentation.

[了解更多](https://vercel.com/docs/deployments/git#creating-a-deployment-from-a-git-reference)（英文文档）