---
title: "Projects using pnpm can now be deployed with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/projects-using-pnpm-can-now-be-deployed-with-zero-configuration"
date: "2022-03-22"
scraped_at: "2026-03-02T10:02:29.885975428+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Mar 22, 2022

2022年3月22日

![](images/projects-using-pnpm-can-now-be-deployed-with-zero-configuration-vercel/img_001.jpg)

Projects using [pnpm](https://pnpm.io/) can now be deployed to Vercel with zero configuration. Vercel is also now sponsoring pnpm to further package manager innovation.

使用 [pnpm](https://pnpm.io/) 的项目现在可零配置部署至 Vercel。Vercel 现已开始赞助 pnpm，以进一步推动包管理器领域的创新。

Like Yarn and npm, pnpm is a package manager focused on saving disk space and [boosting installation speed](https://pnpm.io/benchmarks) by utilizing symlinks. Starting today, Projects that contain a `pnpm-lock.yaml` file will automatically run `pnpm install` as the default [Install Command](https://vercel.com/docs/concepts/deployments/build-step#install-command) using the latest version of pnpm.

与 Yarn 和 npm 类似，pnpm 是一款专注于节省磁盘空间并借助符号链接[提升安装速度](https://pnpm.io/benchmarks)的包管理器。从今日起，凡包含 `pnpm-lock.yaml` 文件的项目，将自动使用最新版本的 pnpm 执行 `pnpm install`，作为默认的[安装命令（Install Command）](https://vercel.com/docs/concepts/deployments/build-step#install-command)。

[Check out the documentation](https://vercel.com/docs/concepts/deployments/build-step#install-command) as well.

也请参阅[相关文档](https://vercel.com/docs/concepts/deployments/build-step#install-command)。