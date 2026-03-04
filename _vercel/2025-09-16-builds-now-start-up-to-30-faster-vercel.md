---
render_with_liquid: false
title: "Builds now start up to 30% faster - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/builds-now-start-up-to-30-faster"
date: "2025-09-16"
scraped_at: "2026-03-02T09:28:30.525197407+00:00"
language: "en-zh"
translated: true
description: "Vercel builds now initialize faster due optimized cache downloads. We use a worker pool to download the build cache, reducing initialization times by 30%"
---
render_with_liquid: false
render_with_liquid: false

Sep 16, 2025

2025 年 9 月 16 日

The build cache stores files from previous builds to speed up future ones. We've improved its performance by downloading parts of the cache in parallel using a worker pool.

构建缓存会存储先前构建生成的文件，以加速后续构建。我们通过使用工作线程池并行下载缓存的各个部分，提升了其性能。

This decreased the build initialization time by **30% on average**, reducing build times by up to 7 seconds for all plans.

这使得构建初始化时间平均缩短了 **30%**，所有套餐下的构建总耗时最多可减少 7 秒。

This is enabled automatically for all new builds and adds to the [build initialization improvements](https://vercel.com/changelog/45-percent-faster-build-initialization) previously launched.

该优化将自动应用于所有新构建，进一步补充了此前已发布的 [构建初始化性能提升](https://vercel.com/changelog/45-percent-faster-build-initialization) 功能。

Learn more about [builds on Vercel](https://vercel.com/docs/deployments/builds).

了解更多关于 [Vercel 上的构建流程](https://vercel.com/docs/deployments/builds)。