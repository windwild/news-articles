---
title: "Claim Deployments now available for fast and secure deployment transfers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claim-deployments"
date: "2025-01-20"
scraped_at: "2026-03-02T09:37:37.323824046+00:00"
language: "en-zh"
translated: true
description: "With Claim Deployments, third-party platforms, including AI agents and visual builder applications, can now hand off deployment ownership."
---
&#123;% raw %}

Jan 20, 2025

2025 年 1 月 20 日

![Claim Deployment - Dark](images/claim-deployments-now-available-for-fast-and-secure-deployment-transfers-vercel/img_001.jpg)![Claim Deployment - Dark](images/claim-deployments-now-available-for-fast-and-secure-deployment-transfers-vercel/img_002.jpg)

![Claim Deployment - Dark](images/claim-deployments-now-available-for-fast-and-secure-deployment-transfers-vercel/img_001.jpg)![Claim Deployment - Dark](images/claim-deployments-now-available-for-fast-and-secure-deployment-transfers-vercel/img_002.jpg)

[多租户平台](https://vercel.com/solutions/multi-tenant-saas)（例如 AI 智能体和可视化搭建应用）现在可轻松将部署的所有权直接转移给用户或团队。

**工作原理：**

- **创建部署：** 任何第三方均可通过 [Vercel CLI](https://vercel.com/docs/cli/deploying-from-cli) 或 Vercel API 创建新部署：[POST /files](https://vercel.com/docs/rest-api/endpoints/deployments#upload-deployment-files) 和 [POST /deployments](https://vercel.com/docs/rest-api/endpoints/deployments#create-a-new-deployment)

- **发起转移：** 接着调用 Vercel API 端点，为该部署生成一个 `claim-deployment` URL。

- **用户确认所属团队：** 用户选择其 Vercel 团队并完成所有权转移。

[查阅我们的文档](https://vercel.com/docs/deployments/claim-deployments) 了解更多信息。
&#123;% endraw %}
