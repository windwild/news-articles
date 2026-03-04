---
title: "45% faster build initialization - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/45-percent-faster-build-initialization"
date: "2025-05-15"
scraped_at: "2026-03-02T09:33:22.140287432+00:00"
language: "en-zh"
translated: true
description: "Customers on all plans can now benefit from faster build cache restoration times. We've made architectural improvements to builds to help customers build faster."
---

render_with_liquid: false
May 15, 2025

2025年5月15日

Builds on Vercel now initialize 45% faster on average, reducing build times by around 15 seconds for Pro and Enterprise teams.

Vercel 上的构建现在平均初始化速度提升 45%，使 Pro 和企业版团队的构建耗时缩短约 15 秒。

Build initialization includes steps like restoring the build cache and fetching your code before the [Build Command](https://vercel.com/docs/deployments/configure-a-build#build-command) runs. These improvements come from continued enhancements to [Hive, Vercel’s build infrastructure](https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure).

构建初始化包括恢复构建缓存、拉取您的代码等步骤，这些操作均在 [构建命令（Build Command）](https://vercel.com/docs/deployments/configure-a-build#build-command) 执行之前完成。本次性能提升得益于对 [Hive（Vercel 的构建基础设施）](https://vercel.com/blog/a-deep-dive-into-hive-vercels-builds-infrastructure) 的持续优化。

This improvement also reduced I/O wait times for file writes inside the build container by 75%, improving performance for the entire build.

此项改进还将构建容器内文件写入操作的 I/O 等待时间降低了 75%，从而提升了整体构建性能。

Learn more about [builds on Vercel](https://vercel.com/docs/deployments/builds).

了解更多关于 [Vercel 构建（builds）](https://vercel.com/docs/deployments/builds) 的信息。