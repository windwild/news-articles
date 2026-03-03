---
title: "Commits to the same branch now build with no queues - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/build-commits-to-the-same-branch-without-waiting"
date: "2025-10-14"
scraped_at: "2026-03-02T09:27:06.373515906+00:00"
language: "en-zh"
translated: true
description: "Building and deploying applications within the same GitHub branch, such as main, is now faster when using concurrent builds."
---

Oct 14, 2025

2025 年 10 月 14 日

当启用“按需并发构建”（On-Demand Concurrent Builds）功能时，Vercel 现在可同时为同一分支上的多个提交执行构建。

此前，新提交需等待该分支上先前的构建完成之后才能开始。此次更新消除了这一排队机制，使提交在到达后即可立即启动构建。

访问 [按需并发构建文档](https://vercel.com/docs/builds/managing-builds#on-demand-concurrent-builds) 了解更多信息。