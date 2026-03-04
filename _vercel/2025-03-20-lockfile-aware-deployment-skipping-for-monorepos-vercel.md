---
render_with_liquid: false
title: "Lockfile-aware deployment skipping for monorepos - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/lockfile-aware-deployment-skipping-for-monorepos"
date: "2025-03-20"
scraped_at: "2026-03-02T09:35:23.249814810+00:00"
language: "en-zh"
translated: true
description: "Vercel now maps dependencies in your package manager’s lockfile to applications in your monorepo, skipping unaffected projects for monorepos."
---
render_with_liquid: false
render_with_liquid: false

Mar 20, 2025

2025年3月20日

![Skip deployments when there are no changes to the root directory and its dependencies](images/lockfile-aware-deployment-skipping-for-monorepos-vercel/img_001.jpg)![Skip deployments when there are no changes to the root directory and its dependencies](images/lockfile-aware-deployment-skipping-for-monorepos-vercel/img_002.jpg)

![当根目录及其依赖项无变更时跳过部署](images/lockfile-aware-deployment-skipping-for-monorepos-vercel/img_001.jpg)![当根目录及其依赖项无变更时跳过部署](images/lockfile-aware-deployment-skipping-for-monorepos-vercel/img_002.jpg)

Vercel now maps dependencies in your package manager’s lockfile to applications in your monorepo. Deployments only occur for applications using updated dependencies.

Vercel 现在会将包管理器 lockfile 中的依赖项映射到单体仓库（monorepo）中的各个应用。仅当某应用所依赖的包发生更新时，才触发该应用的部署。

This feature is based on Turborepo's lockfile analysis, supporting the package managers listed as stable in [Turborepo's Support Policy](https://turbo.build/repo/docs/getting-started/support-policy#package-managers).

该功能基于 Turborepo 的 lockfile 分析能力，支持 [Turborepo 支持策略](https://turbo.build/repo/docs/getting-started/support-policy#package-managers) 中列为“稳定版”的包管理器。

Previously, any change to the lockfile would redeploy all applications in the monorepo since it was treated as a shared input. Now, Vercel inspects the lockfile’s contents to determine which applications have dependency changes, further reducing potential queue times.

此前，由于 lockfile 被视为共享输入，其任何变更都会导致单体仓库中所有应用重新部署。如今，Vercel 会解析 lockfile 的具体内容，精准识别出哪些应用的依赖关系发生了变化，从而进一步缩短潜在的排队等待时间。

Learn more about [skipping unaffected projects in monorepos](https://vercel.com/docs/monorepos#skipping-unaffected-projects).

了解更多关于[在单体仓库中跳过未受影响项目的机制](https://vercel.com/docs/monorepos#skipping-unaffected-projects)。