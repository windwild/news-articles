---
render_with_liquid: false
title: "Improvements and fixes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improvements-and-fixes"
date: "2023-06-22"
scraped_at: "2026-03-02T09:51:57.388978709+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Jun 22, 2023

2023年6月22日

![](images/improvements-and-fixes-vercel/img_001.jpg)![](images/improvements-and-fixes-vercel/img_002.jpg)

- **草稿模式（Draft Mode）：** 所有订阅计划的用户现在均可通过 Vercel 工具栏启用[草稿模式](https://vercel.com/docs/frameworks/nextjs#draft-mode)。启用后，工具栏颜色将变为紫色，以表明当前查看的是草稿内容。

- **倾斜保护（Skew Protection）：** 现在可在 Next.js 13.4.7 或更高版本中实现[倾斜保护](https://vercel.com/docs/concepts/deployments/skew-protection)，从而消除 Web 客户端与服务器之间的版本偏差。倾斜保护这一平台原语（platform primitive）对所有框架均开放使用。

- **存储空间迁移：** Hobby 计划用户升级至 Pro 计划后，其[存储空间（stores）](https://vercel.com/docs/storage)将自动迁移至新团队。

- **已配置的“忽略构建步骤”脚本（Configured Ignored Build Step script）：** 在包含[忽略构建步骤脚本](https://vercel.com/docs/concepts/projects/overview#ignored-build-step)的项目中重建或发布部署时，现可显式跳过该忽略构建步骤脚本，强制执行构建流程。

- **系统环境变量：** 新增系统环境变量 `VERCEL_BRANCH_URL`，其值为生成的 Git 分支 URL，开发者可在代码中直接访问部署对应的[Git 分支别名](https://vercel.com/docs/concepts/deployments/generated-urls#url-with-git-branch)。

- **更快的部署速度：** 含 Edge Functions 的项目部署速度现已提升：平均快 2 秒；在较慢场景下快 9 秒；在最慢场景下最多可提速达 20 秒。

- **Git 元数据：** 当部署存在未暂存（unstaged）的更改时，您现在可在部署详情中查看相关 Git 元数据。

- **Vercel CLI：** [v30.2.3 版本](https://github.com/vercel/vercel/releases/tag/vercel%4030.2.3)已发布，其中更新了 Node 和 Remix 的依赖项。