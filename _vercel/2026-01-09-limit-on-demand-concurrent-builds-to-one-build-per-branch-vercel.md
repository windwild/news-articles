---
title: "Limit on-demand concurrent builds to one build per branch - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/limit-on-demand-concurrent-builds-to-one-build-per-branch"
date: "2026-01-09"
scraped_at: "2026-03-02T09:23:04.183893296+00:00"
language: "en-zh"
translated: true
description: "Configure On-Demand Concurrent Builds to run one active build per branch. Deployments to the same branch are queued, and only the latest build runs."
---

render_with_liquid: false
Jan 9, 2026

2026 年 1 月 9 日

[On-Demand Concurrent Builds](https://vercel.com/docs/deployments/managing-builds#on-demand-concurrent-builds) let builds start immediately, without waiting for other deployments to finish.

[按需并发构建（On-Demand Concurrent Builds）](https://vercel.com/docs/deployments/managing-builds#on-demand-concurrent-builds) 允许构建立即启动，无需等待其他部署完成。

You can now configure this feature to run one active build per branch. When enabled, deployments to the same branch are queued. After the active build finishes, only the most recent queued deployment starts building. Older queued deployments are skipped. Deployments on different branches can still build concurrently.

现在，您可以将此功能配置为每个分支仅运行一个活跃构建。启用后，同一分支上的部署将进入队列；当当前活跃构建完成后，仅最新入队的部署会开始构建，而更早入队的部署则会被跳过。不同分支上的部署仍可并发构建。

Enable this in your [project settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment) or learn more in the [documentation](https://vercel.com/docs/deployments/managing-builds#on-demand-concurrent-builds).

您可在 [项目设置](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment) 中启用此功能，或参阅 [文档](https://vercel.com/docs/deployments/managing-builds#on-demand-concurrent-builds) 了解更多信息。