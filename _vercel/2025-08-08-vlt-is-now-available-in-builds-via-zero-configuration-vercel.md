---
title: "vlt is now available in builds via zero configuration - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/vlt-is-now-available-in-builds-via-zero-configuration"
date: "2025-08-08"
scraped_at: "2026-03-02T09:30:09.014309695+00:00"
language: "en-zh"
translated: true
description: "The package manager vlt is now available as a zero-config option, auto detected based on the presence of a lockfile in your build."
---

render_with_liquid: false
Aug 8, 2025

2025 年 8 月 8 日

![](images/vlt-is-now-available-in-builds-via-zero-configuration-vercel/img_001.jpg)![](images/vlt-is-now-available-in-builds-via-zero-configuration-vercel/img_002.jpg)

Vercel 现在支持 `vlt` 包管理器，可在构建过程中实现零配置自动集成。

即日起，凡包含 `vlt-lock.json` 文件的项目，Vercel 将自动以 `vlt install` 作为默认的 [安装命令](https://vercel.com/docs/concepts/deployments/build-step#install-command) 执行。

`vlt` 运行需依赖 Node.js `20.x` 版本，且仅适用于现代版 [构建镜像](https://vercel.com/docs/builds/build-image)。

了解更多关于 [Vercel 对包管理器的支持](https://vercel.com/docs/package-managers#supported-package-managers)。