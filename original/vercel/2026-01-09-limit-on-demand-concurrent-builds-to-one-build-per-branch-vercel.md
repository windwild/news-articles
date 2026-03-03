---
title: "Limit on-demand concurrent builds to one build per branch - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/limit-on-demand-concurrent-builds-to-one-build-per-branch"
date: "2026-01-09"
scraped_at: "2026-03-02T09:23:04.183893296+00:00"
language: "en"
translated: false
description: "Configure On-Demand Concurrent Builds to run one active build per branch. Deployments to the same branch are queued, and only the latest build runs."
---




Jan 9, 2026

[On-Demand Concurrent Builds](https://vercel.com/docs/deployments/managing-builds#on-demand-concurrent-builds) let builds start immediately, without waiting for other deployments to finish.

You can now configure this feature to run one active build per branch. When enabled, deployments to the same branch are queued. After the active build finishes, only the most recent queued deployment starts building. Older queued deployments are skipped. Deployments on different branches can still build concurrently.

Enable this in your [project settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment) or learn more in the [documentation](https://vercel.com/docs/deployments/managing-builds#on-demand-concurrent-builds).