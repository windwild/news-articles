---
title: "Automatic pnpm v10 support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-pnpm-v10-support"
date: "2025-02-28"
scraped_at: "2026-03-02T09:35:33.983185988+00:00"
language: "en-zh"
translated: true
description: "New projects will detect and use pnpm@10, based on the project lockfile. Old projects can opt-in to pnpm@10 using Corepack."
---

Feb 28, 2025

2025 年 2 月 28 日

![](images/automatic-pnpm-v10-support-vercel/img_001.jpg)![](images/automatic-pnpm-v10-support-vercel/img_002.jpg)

Vercel now supports pnpm v10.

Vercel 现已支持 pnpm v10。

New projects with a `pnpm-lock.yaml` file with `lockfileVersion: '9.0'` will automatically use pnpm v10 for Install and Build Commands. Existing projects will continue to use pnpm v9 for backwards compatibility, since pnpm v9 also uses `lockfileVersion: '9.0'`.

新项目若包含 `pnpm-lock.yaml` 文件，且其中 `lockfileVersion: '9.0'`，则其安装（Install）与构建（Build）命令将自动使用 pnpm v10。为保障向后兼容性，现有项目将继续使用 pnpm v9——因为 pnpm v9 同样采用 `lockfileVersion: '9.0'`。

Check your [build logs](https://vercel.com/docs/deployments/logs) to see which version a deployment uses. If you'd like to manually upgrade or downgrade your version, [use Corepack](https://vercel.com/docs/deployments/configure-a-build#corepack).

请查阅您的 [构建日志](https://vercel.com/docs/deployments/logs)，确认某次部署所使用的 pnpm 版本。如需手动升级或降级版本，请[使用 Corepack](https://vercel.com/docs/deployments/configure-a-build#corepack)。

Visit the [package managers documentation](https://vercel.com/docs/deployments/builds/package-managers#supported-package-managers) to learn more.

请访问 [包管理器文档](https://vercel.com/docs/deployments/builds/package-managers#supported-package-managers)，了解更多信息。