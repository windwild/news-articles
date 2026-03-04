---
render_with_liquid: false
title: "More Secure Deployment Protection - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/more-secure-deployment-protection"
date: "2025-07-14"
scraped_at: "2026-03-02T09:31:17.179092058+00:00"
language: "en-zh"
translated: true
description: "Standard Deployment Protection now protects all except production custom domains enhancing protection for automatic aliases for production deployments."
---
render_with_liquid: false
render_with_liquid: false

Jul 14, 2025

2025年7月14日

![](images/more-secure-deployment-protection-vercel/img_001.jpg)![](images/more-secure-deployment-protection-vercel/img_002.jpg)

[Deployment Protection](https://vercel.com/docs/deployment-protection) safeguards preview and production URLs so that users can't access the domains that you don't want them to.

[部署保护（Deployment Protection）](https://vercel.com/docs/deployment-protection) 可保护预览环境与生产环境的 URL，防止用户访问您不希望其访问的域名。

Starting today, the [Standard Deployment Protection](https://vercel.com/docs/deployment-protection#standard-protection) option has been updated for new projects to protect all automatically generated domains, including the production branch git domain (for example `project-git-main.vercel.app`). 

即日起，针对新项目，[标准部署保护（Standard Deployment Protection）](https://vercel.com/docs/deployment-protection#standard-protection) 选项已更新，将自动保护所有系统生成的域名，包括生产分支的 Git 域名（例如 `project-git-main.vercel.app`）。

Existing projects can update to this new behavior in the Project settings page in the Vercel dashboard.

现有项目可在 Vercel 控制台的“项目设置（Project settings）”页面中启用此项新行为。