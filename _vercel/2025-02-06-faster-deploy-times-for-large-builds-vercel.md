---
render_with_liquid: false
title: "Faster deploy times for large builds - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-deploy-times-for-large-builds"
date: "2025-02-06"
scraped_at: "2026-03-02T09:37:13.725657474+00:00"
language: "en-zh"
translated: true
description: "Discover the upcoming update to Vercel Edge Functions with a new execution duration limit of 300 seconds, enhancing predictability and reliability in function management starting March 1st."
---
render_with_liquid: false
render_with_liquid: false

Feb 6, 2025

2025 年 2 月 6 日

We optimized the deploy step of the [build process](https://vercel.com/docs/deployments/builds#build-process) to reduce build times by 2.8 seconds at P99, 760ms at P75, and 410ms on average.

我们优化了[构建流程](https://vercel.com/docs/deployments/builds#build-process)中的部署（deploy）步骤，使 P99 构建耗时减少 2.8 秒，P75 减少 760 毫秒，平均减少 410 毫秒。

For customers with a large number of Vercel Functions (100+), builds are more than 50 seconds faster. Several customers have time savings of over 2 minutes.

对于拥有大量 Vercel Functions（100 个以上）的客户，构建速度提升超过 50 秒；部分客户节省的时间甚至超过 2 分钟。

Check out [the documentation](https://vercel.com/docs/deployments/builds) to learn more about builds.

请查阅[相关文档](https://vercel.com/docs/deployments/builds)，进一步了解构建流程。