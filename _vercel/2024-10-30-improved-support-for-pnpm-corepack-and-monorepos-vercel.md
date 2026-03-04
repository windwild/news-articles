---
title: "Improved support for pnpm, Corepack, and monorepos - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-support-for-pnpm-corepack-and-monorepos"
date: "2024-10-30"
scraped_at: "2026-03-02T09:40:02.523167007+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Oct 30, 2024

2024 年 10 月 30 日

We've improved the experience of deploying projects using pnpm, Corepack, and Turborepo together.

我们已优化了同时使用 pnpm、Corepack 和 Turborepo 部署项目的体验。

Previously, combinations of these tools could result in unexpected behavior or complex build errors. Clear error and warning messages have been added, explaining how to fix problems when incompatibilities exist.

此前，这些工具的组合使用可能导致意外行为或复杂的构建错误。现已添加清晰的错误与警告信息，明确说明在出现不兼容情况时应如何解决问题。

For example, a project with Corepack enabled, specifying `pnpm@9.0.0`, and a lockfile of version `6.0` would previously see the warning: `Ignoring not compatible lockfile`. Now, this is handled with a clearer error message: `Detected lockfile "6.0" which is not compatible with the intended corepack package manager "pnpm@9.0.0". Update your lockfile or change to a compatible corepack version.`

例如，一个启用了 Corepack、指定了 `pnpm@9.0.0`、且 lockfile 版本为 `6.0` 的项目，此前会收到警告：`Ignoring not compatible lockfile`（忽略不兼容的 lockfile）。现在则会显示更清晰的错误信息：`Detected lockfile "6.0" which is not compatible with the intended corepack package manager "pnpm@9.0.0". Update your lockfile or change to a compatible corepack version.`（检测到 lockfile 版本为 "6.0"，与指定的 Corepack 包管理器 "pnpm@9.0.0" 不兼容。请更新 lockfile，或切换至兼容的 Corepack 版本。）

Additionally, each package previously had to define its own `packageManager`. The root `package.json#packageManager` is now detected in monorepo projects with [Corepack enabled](https://vercel.com/docs/deployments/configure-a-build#corepack) and applied to all packages.

此外，此前每个包都需单独定义其 `packageManager`。现在，在启用 [Corepack](https://vercel.com/docs/deployments/configure-a-build#corepack) 的单体仓库（monorepo）项目中，根目录下的 `package.json#packageManager` 将被自动识别，并应用于所有子包。