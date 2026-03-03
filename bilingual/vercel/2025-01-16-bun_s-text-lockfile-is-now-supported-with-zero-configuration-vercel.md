---
title: "Bun's text lockfile is now supported with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/buns-text-lockfile-is-now-supported-with-zero-configuration"
date: "2025-01-16"
scraped_at: "2026-03-02T09:38:14.605948980+00:00"
language: "en-zh"
translated: true
description: "Bun v1.1.39 introduces text lockfile support, and Vercel now supports bun.lock with zero configuration. You can use the text lockfile today with bun install --save-text-lockfile."
---

Jan 16, 2025

2025 年 1 月 16 日

Projects using Bun's new text `bun.lock` lockfile can now be deployed to Vercel with zero configuration.

使用 Bun 全新文本格式 `bun.lock` 锁文件的项目，现在可零配置部署至 Vercel。

While Vercel [already supports Bun's binary `bun.lockb` lockfile](https://vercel.com/changelog/bun-install-is-now-supported-with-zero-configuration-6qPMITQUrVSmCuGQSdO9HC), Bun v1.1.39 introduces a new [text-based](https://bun.sh/blog/bun-lock-text-lockfile) lock file with `bun install --save-text-lockfile`. Bun plans to make this the default in v1.2.

尽管 Vercel [已支持 Bun 的二进制格式 `bun.lockb` 锁文件](https://vercel.com/changelog/bun-install-is-now-supported-with-zero-configuration-6qPMITQUrVSmCuGQSdO9HC)，Bun v1.1.39 引入了一种全新的[基于文本的](https://bun.sh/blog/bun-lock-text-lockfile)锁文件，可通过命令 `bun install --save-text-lockfile` 生成。Bun 计划在 v1.2 版本中将该文本锁文件设为默认格式。

Learn more about [package managers supported by Vercel](https://vercel.com/docs/deployments/builds/package-managers#package-managers).

了解更多关于 [Vercel 支持的包管理器](https://vercel.com/docs/deployments/builds/package-managers#package-managers) 的信息。