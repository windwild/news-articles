---
title: "Automatically skip unnecessary deployments in monorepos - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatically-skip-unnecessary-deployments-in-monorepos"
date: "2024-07-22"
scraped_at: "2026-03-02T09:42:43.290547674+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Jul 22, 2024

2024 年 7 月 22 日

![Root Directory Settings](images/automatically-skip-unnecessary-deployments-in-monorepos-vercel/img_001.jpg)![Root Directory Settings](images/automatically-skip-unnecessary-deployments-in-monorepos-vercel/img_002.jpg)

![根目录设置](images/automatically-skip-unnecessary-deployments-in-monorepos-vercel/img_001.jpg)![根目录设置](images/automatically-skip-unnecessary-deployments-in-monorepos-vercel/img_002.jpg)

Vercel now automatically skip builds for unchanged code in your monorepo.

Vercel 现在会自动跳过单体仓库（monorepo）中未发生变化的代码的构建。

Projects without changes in their source code (or the source code of internal dependencies) will be skipped, reducing build queuing and improving the time to deployment for affected projects.

若项目自身源代码（或其内部依赖项的源代码）未发生变更，则该构建将被跳过，从而减少构建排队时间，并加快受影响项目的部署速度。

This feature is powered by [Turborepo](https://turbo.build/repo/docs/core-concepts/package-and-task-graph#package-graph), and works with any [monorepo using workspaces](https://vercel.com/docs/monorepos#requirements). For more advanced customization, like canceling builds based on branches, you can configure an [Ignored Build Step](https://vercel.com/docs/projects/overview#ignore-build-step-on-redeploy).

该功能由 [Turborepo](https://turbo.build/repo/docs/core-concepts/package-and-task-graph#package-graph) 提供支持，适用于任何采用 [workspace 机制的单体仓库](https://vercel.com/docs/monorepos#requirements)。如需更高级的自定义配置（例如基于分支取消构建），您可配置 [忽略构建步骤（Ignored Build Step）](https://vercel.com/docs/projects/overview#ignore-build-step-on-redeploy)。

Learn more about [skipping unaffected projects](https://vercel.com/docs/monorepos#skipping-unaffected-projects).

了解更多关于 [跳过未受影响项目](https://vercel.com/docs/monorepos#skipping-unaffected-projects) 的信息。
{% endraw %}
