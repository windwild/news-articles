---
title: "Caching details now available in Runtime Logs - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/caching-details-now-available-in-runtime-logs"
date: "2025-10-31"
scraped_at: "2026-03-02T09:26:22.334846824+00:00"
language: "en"
translated: false
description: "Details on ISR cache keys, cache tags, and cache revalidation reasons are now available in Runtime Logs for all customers"
---




Oct 31, 2025

![](images/caching-details-now-available-in-runtime-logs-vercel/img_001.jpg)![](images/caching-details-now-available-in-runtime-logs-vercel/img_002.jpg)

You can now view more details on how Vercel's [CDN](https://vercel.com/docs/cdn) globally serves cached content to users as quickly as possible.

In the right-hand panel of the Runtime Logs page, we now list:

- **Cache key**: A unique identifier for a specific version of a cached page

- **Cache tags**: Tags associated with the cached data

- **Revalidation reason**: If a revalidation took place, the reason why the content was being revalidated (time-based, tag-based, or deployment-based)


![](images/caching-details-now-available-in-runtime-logs-vercel/img_003.jpg)![](images/caching-details-now-available-in-runtime-logs-vercel/img_004.jpg)

This is available to all Vercel users at no additional cost. [Try it out](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Flogs) or learn more about [Runtime Logs](https://vercel.com/docs/logs/runtime).