---
title: "New monorepo projects now skip builds with unchanged code by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-monorepo-projects-now-skip-builds-with-unchanged-code-by-default"
date: "2025-02-24"
scraped_at: "2026-03-02T09:36:07.726788054+00:00"
language: "en-zh"
translated: true
description: "Vercel now defaults to skipping builds for unchanged code in monorepos, reducing queue times and improving efficiency. Additionally, the setting for this behavior has been added to the Vercel Terrafor..."
---

Feb 24, 2025

2025 年 2 月 24 日

![Skip deployments when there are no changes to the root directory and its dependencies](images/new-monorepo-projects-now-skip-builds-with-unchanged-code-by-default-vercel/img_001.jpg)![当根目录及其依赖项无变更时跳过部署](images/new-monorepo-projects-now-skip-builds-with-unchanged-code-by-default-vercel/img_002.jpg)

Previously, we added [opt-in support for skipping builds with unchanged code in monorepos](https://vercel.com/changelog/automatically-skip-unnecessary-deployments-in-monorepos) to reduce build queueing.

此前，我们已为单体仓库（monorepos）引入了[可选的“代码未变更则跳过构建”功能](https://vercel.com/changelog/automatically-skip-unnecessary-deployments-in-monorepos)，以减少构建排队。

This behavior is now the default for new projects. To [enable deployment skipping](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment%23root-directory&title=Disable+unaffected+project+skipping) in an existing project, visit the **Build and Deployment** settings for the project.

该行为现已成为新项目的默认设置。如需在已有项目中[启用部署跳过功能](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment%23root-directory&title=Disable+unaffected+project+skipping)，请前往该项目的 **构建与部署（Build and Deployment）** 设置页面。

Additionally, this setting has been added to the [Vercel provider for Terraform](https://registry.terraform.io/providers/vercel/vercel/latest) in 2.10.0.

此外，该设置已在 Terraform 的 [Vercel Provider](https://registry.terraform.io/providers/vercel/vercel/latest) 2.10.0 版本中加入。

Learn more about [skipping deployments](https://vercel.com/docs/monorepos#skipping-unaffected-projects).

了解更多关于[跳过部署](https://vercel.com/docs/monorepos#skipping-unaffected-projects)的信息。