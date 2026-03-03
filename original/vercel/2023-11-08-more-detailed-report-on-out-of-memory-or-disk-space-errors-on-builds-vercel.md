---
title: "More detailed report on out of memory or disk space errors on builds - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/report-on-out-of-memory-or-disk-space"
date: "2023-11-08"
scraped_at: "2026-03-02T09:49:51.456499265+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 8, 2023

![](images/more-detailed-report-on-out-of-memory-or-disk-space-errors-on-builds-vercel/img_001.jpg)![](images/more-detailed-report-on-out-of-memory-or-disk-space-errors-on-builds-vercel/img_002.jpg)

You will now see more information in the build logs when your build fails due to either exhausting the available memory (OOM) or disk space (ENOSPC).

In the case of OOM, your build logs will confirm the event. For ENOSPC situations, detailed information on disk space allocation is provided.

Check out [our documentation](https://vercel.com/docs/deployments/troubleshoot-a-build#build-container-resources) to learn more.