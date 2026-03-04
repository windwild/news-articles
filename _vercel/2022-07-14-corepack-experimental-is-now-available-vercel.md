---
render_with_liquid: false
title: "Corepack (experimental) is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/corepack-experimental-is-now-available"
date: "2022-07-14"
scraped_at: "2026-03-02T10:01:21.244927114+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Jul 14, 2022

2022年7月14日

![](images/corepack-experimental-is-now-available-vercel/img_001.jpg)![](images/corepack-experimental-is-now-available-vercel/img_002.jpg)

[Corepack](https://nodejs.org/docs/latest-v16.x/api/corepack.html) 允许你在项目中使用特定版本的包管理器（如 pnpm、yarn 或 npm）。从今天起，你可以启用实验性的 Corepack 支持。

通过在 `package.json` 文件中添加 [`packageManager`](https://nodejs.org/docs/latest-v16.x/api/packages.html#packagemanager) 字段，并在项目中将环境变量设为 `ENABLE_EXPERIMENTAL_COREPACK=1`，即可启用 Corepack。请注意，Corepack 目前处于实验阶段，不遵循语义化版本控制规则；Node.js 的任何后续版本中均可能引入破坏性变更或直接移除该功能。

[请参阅相关文档](https://vercel.com/docs/concepts/deployments/configure-a-build#corepack)。