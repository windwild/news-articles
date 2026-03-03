---
title: "Faster builds with per-branch caching - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-builds-with-per-branch-caching"
date: "2021-03-16"
scraped_at: "2026-03-02T10:05:01.020674965+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Mar 16, 2021

![](images/faster-builds-with-per-branch-caching-vercel/img_001.jpg)

The Build Step now considers the current Git branch when reading and writing the cache.

Since the first push to a branch will create a deployment without a branch-specific cache, it will read from the Production branch's cache. Subsequent pushes to that branch will read from its own branch-specific cache.

This means that Preview branches will no longer write to the Production branch's cache. This leads to faster builds because changing dependencies in one branch won't change the cache of another branch.

In addition, we no longer delete the build cache when a build fails. Instead, you can manually trigger a build without cache by using the "Redeploy" button on the Dashboard.

Our tests with a large Next.js app brought down incremental build times from **13 minutes** to **4 minutes**.

Check out [the documentation](https://vercel.com/docs/build-step#caching) as well.