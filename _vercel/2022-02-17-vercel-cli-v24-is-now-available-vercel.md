---
title: "Vercel CLI v24 is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-cli-v24"
date: "2022-02-17"
scraped_at: "2026-03-02T10:03:07.727373399+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Feb 17, 2022

2022 年 2 月 17 日

![](images/vercel-cli-v24-is-now-available-vercel/img_001.jpg)

Vercel CLI 第 24 版现已发布，包含大量改进与错误修复，并新增了 `vercel bisect` 命令：

- 新增命令 `vercel bisect`：受 `git bisect` 命令启发，[该新命令](https://vercel.com/docs/cli#commands/bisect) 可帮助定位 Bug 首次引入的具体部署（Deployment）。

- 在 `vercel link` 命令中新增对 `--project` 标志的支持。

- 移除了对单文件部署（single file deployments）的支持。

- `vercel dev` 现已进入稳定版（不再处于 Beta 阶段）。

- 将 CLI 的大部分源代码重构为 TypeScript。

**本次为重大版本升级，包含若干不兼容变更（breaking changes）**，其中绝大多数是彻底移除那些已被弃用多年的老功能。更新前请务必仔细阅读[完整更新日志](https://github.com/vercel/vercel/releases/tag/vercel%4024.0.0)。