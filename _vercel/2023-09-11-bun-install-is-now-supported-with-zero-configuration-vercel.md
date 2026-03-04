---
render_with_liquid: false
title: "Bun install is now supported with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bun-install-is-now-supported-with-zero-configuration"
date: "2023-09-11"
scraped_at: "2026-03-02T09:51:04.207006798+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Sep 11, 2023

2023 年 9 月 11 日

![Vercel + Bun logo in dark theme](images/bun-install-is-now-supported-with-zero-configuration-vercel/img_001.jpg)![Vercel + Bun logo in dark theme](images/bun-install-is-now-supported-with-zero-configuration-vercel/img_002.jpg)

![深色主题下的 Vercel + Bun 标志](images/bun-install-is-now-supported-with-zero-configuration-vercel/img_001.jpg)![深色主题下的 Vercel + Bun 标志](images/bun-install-is-now-supported-with-zero-configuration-vercel/img_002.jpg)

Projects using [Bun as a package manager](https://bun.sh/docs/cli/install) can now be deployed to Vercel with zero configuration.

现可零配置将使用 [Bun 作为包管理器](https://bun.sh/docs/cli/install) 的项目部署至 Vercel。

Like yarn, npm, and pnpm, Bun acts as a package manager focused on saving disk space and boosting installation speed. Starting today, Projects that contain a `bun.lockb` file will automatically run `bun install` as the default [Install Command](https://vercel.com/docs/concepts/deployments/build-step#install-command) using `bun@1`.

与 yarn、npm 和 pnpm 类似，Bun 是一款专注于节省磁盘空间并提升安装速度的包管理器。自今日起，包含 `bun.lockb` 文件的项目将在构建时自动以 `bun@1` 执行 `bun install`，作为默认的 [安装命令（Install Command）](https://vercel.com/docs/concepts/deployments/build-step#install-command)。

This change impacts the build phase but not runtime. Therefore, Serverless Functions will not use the Bun runtime yet.

此项变更仅影响构建阶段，不影响运行时。因此，Serverless 函数目前尚不支持使用 Bun 运行时。

[Check out the documentation](https://vercel.com/docs/concepts/deployments/build-step#install-command) to learn more.

[查阅文档](https://vercel.com/docs/concepts/deployments/build-step#install-command) 了解更多信息。