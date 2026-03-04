---
render_with_liquid: false
title: "Yarn 2+ dependency caching now supported - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/yarn-2-dependency-caching-now-supported"
date: "2025-03-31"
scraped_at: "2026-03-02T09:35:16.006933784+00:00"
language: "en-zh"
translated: true
description: "Vercel's build cache now supports Yarn 2+ dependencies. Previously, dependencies were only cached for npm, pnpm, and Yarn 1."
---
render_with_liquid: false
render_with_liquid: false

Mar 31, 2025

2025年3月31日

![](images/yarn-2-dependency-caching-now-supported-vercel/img_001.jpg)![](images/yarn-2-dependency-caching-now-supported-vercel/img_002.jpg)

Vercel now caches dependencies for projects using Yarn 2 and newer, reducing install times and improving build performance. Previously, caching was only supported for npm, pnpm, Bun, and Yarn 1.

Vercel 现已支持为使用 Yarn 2 及更高版本的项目缓存依赖项，从而缩短安装时间并提升构建性能。此前，仅支持对 npm、pnpm、Bun 和 Yarn 1 的缓存。

To disable caching, set the environment variable `VERCEL_FORCE_NO_BUILD_CACHE` with a value of `1` in your project settings.

如需禁用缓存，请在项目设置中将环境变量 `VERCEL_FORCE_NO_BUILD_CACHE` 的值设为 `1`。

If you're using Yarn 4, [enable Corepack](https://vercel.com/docs/builds/configure-a-build#corepack), as [recommended by Yarn](https://yarnpkg.com/corepack).

若您正在使用 Yarn 4，请按 [Yarn 官方推荐](https://yarnpkg.com/corepack) 启用 [Corepack](https://vercel.com/docs/builds/configure-a-build#corepack)。

Visit [the Build Cache documentation](https://vercel.com/docs/deployments/troubleshoot-a-build#understanding-build-cache) to learn more.

请访问 [构建缓存文档](https://vercel.com/docs/deployments/troubleshoot-a-build#understanding-build-cache)，了解更多信息。