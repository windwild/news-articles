---
title: "Commits to the same branch now build with no queues - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/build-commits-to-the-same-branch-without-waiting"
date: "2025-10-14"
scraped_at: "2026-03-02T09:27:06.373515906+00:00"
language: "en"
translated: false
description: "Building and deploying applications within the same GitHub branch, such as main, is now faster when using concurrent builds."
---




Oct 14, 2025

Vercel now builds multiple commits to the same branch at the same time when On-Demand Concurrent Builds is enabled.

Previously, a new commit would wait for the previous build on that branch to finish before starting. This update eliminates that queue, allowing commits to start building as soon as they arrive.

Visit the [On-demand concurrent builds documentation](https://vercel.com/docs/builds/managing-builds#on-demand-concurrent-builds) to learn more.