---
title: "Yarn 2+ dependency caching now supported - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/yarn-2-dependency-caching-now-supported"
date: "2025-03-31"
scraped_at: "2026-03-02T09:35:16.006933784+00:00"
language: "en"
translated: false
description: "Vercel's build cache now supports Yarn 2+ dependencies. Previously, dependencies were only cached for npm, pnpm, and Yarn 1."
---




Mar 31, 2025

![](images/yarn-2-dependency-caching-now-supported-vercel/img_001.jpg)![](images/yarn-2-dependency-caching-now-supported-vercel/img_002.jpg)

Vercel now caches dependencies for projects using Yarn 2 and newer, reducing install times and improving build performance. Previously, caching was only supported for npm, pnpm, Bun, and Yarn 1.

To disable caching, set the environment variable `VERCEL_FORCE_NO_BUILD_CACHE` with a value of `1` in your project settings.

If you're using Yarn 4, [enable Corepack](https://vercel.com/docs/builds/configure-a-build#corepack), as [recommended by Yarn](https://yarnpkg.com/corepack).

Visit [the Build Cache documentation](https://vercel.com/docs/deployments/troubleshoot-a-build#understanding-build-cache) to learn more.