---
title: "Manually purge the CDN cache - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/manually-purge-the-cdn-cache"
date: "2025-06-24"
scraped_at: "2026-03-02T09:32:29.103661596+00:00"
language: "en"
translated: false
description: "Vercel's CDN Cache can now be purged with the click of a button in the dashboard or by running a CLI command, vercel cache purge --type=cdn, using version 44.2.0 or newer."
---




Jun 24, 2025

![](images/manually-purge-the-cdn-cache-vercel/img_001.jpg)![](images/manually-purge-the-cdn-cache-vercel/img_002.jpg)

Users with the **Member** role can now purge Vercel’s CDN cache manually, either via the project's [cache settings dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fcaches&title=Go+to+Cache+Settings) or by running `vercel cache purge --type=cdn` in CLI version 44.2.0 or later.

By default, the CDN cache is purged automatically with each new deployment. For cases where you want to refresh cached content instantly (without waiting for a new build), you can now manually purge the global CDN cache in milliseconds.

This is especially useful for persistent cache scenarios, like **Image Optimization**, where paths are cached across deployments. If upstream images have changed, you can now force a refresh instantly.

Learn more in the [documentation](https://vercel.com/docs/edge-cache#manually-purging-edge-cache).