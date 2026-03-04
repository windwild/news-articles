---
title: "Improvements and Fixes - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/september-2022-papercuts"
date: "2022-09-29"
scraped_at: "2026-03-02T10:00:25.320711705+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Sep 29, 2022

2022 年 9 月 29 日

![](images/improvements-and-fixes-vercel/img_001.jpg)

![](images/improvements-and-fixes-vercel/img_001.jpg)

在您的反馈支持下，我们已发布多项 Bug 修复及少量功能更新，以持续优化您的产品使用体验。

在您的反馈支持下，我们已发布多项 Bug 修复及少量功能更新，以持续优化您的产品使用体验。

- **Vercel CLI：** [v28.4.5](https://github.com/vercel/vercel/releases/tag/vercel%4028.4.5) 版本已发布，包含若干 Bug 修复，并改进了 JSON 解析能力。

- **新增系统环境变量：** [`VERCEL_GIT_PREVIOUS_SHA`](https://vercel.com/docs/concepts/projects/environment-variables#system-environment-variables) 现已在 [忽略构建步骤（Ignored Build Step）](https://vercel.com/docs/concepts/projects/overview#ignored-build-step) 中可用。该变量使脚本能够将当前变更与当前项目及分支上一次成功部署所对应的 `SHA` 进行比对。

- **Vercel 控制台导航优化：** 我们通过 [命令菜单（Command Menu）](https://vercel.com/docs/concepts/dashboard-features/command-menu) 简化了控制台的导航操作。您现在可直接搜索特定设置，并一键跳转至页面中对应位置。

- **更精细的部署耗时统计：** Vercel 控制台“部署”（Deployments）标签页中显示的 [总耗时（total duration time）](https://vercel.com/docs/concepts/deployments/troubleshoot-a-build#build-duration) 现已涵盖全部三个阶段（构建、检查、分配域名），且每个阶段旁的时间戳不再向上取整。

- **项目迁移功能优化：** 在 [迁移项目（transferring a project）](https://vercel.com/docs/concepts/projects/overview#transferring-a-project) 时，下拉菜单中始终显示当前团队名称，并设为禁用状态，末尾标注 “Current”（当前）。此举既可防止用户误将项目迁回其原本所在的 Hobby 团队，亦有助于保留当前团队上下文。

- **部署日志增强：** 现在，部署日志中所有以 `npm ERR!` 开头的日志条目均以红色高亮显示。

- **CLI 文档全面改版：** Vercel [CLI 文档](https://vercel.com/docs/cli) 已完成迁移与重构，现新增“发布阶段（release phases）”说明及各订阅计划（plan）的功能提示。

- **Build environment updates:**`Node.js` updated to v16.16.0, `npm` updated to v8.11.0, `pnpm` updated to v7.12.2.

- **构建环境更新：**`Node.js` 升级至 v16.16.0，`npm` 升级至 v8.11.0，`pnpm` 升级至 v7.12.2。