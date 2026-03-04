---
render_with_liquid: false
title: "More detailed report on out of memory or disk space errors on builds - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/report-on-out-of-memory-or-disk-space"
date: "2023-11-08"
scraped_at: "2026-03-02T09:49:51.456499265+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Nov 8, 2023

2023 年 11 月 8 日

![](images/more-detailed-report-on-out-of-memory-or-disk-space-errors-on-builds-vercel/img_001.jpg)![](images/more-detailed-report-on-out-of-memory-or-disk-space-errors-on-builds-vercel/img_002.jpg)

![](images/more-detailed-report-on-out-of-memory-or-disk-space-errors-on-builds-vercel/img_001.jpg)![](images/more-detailed-report-on-out-of-memory-or-disk-space-errors-on-builds-vercel/img_002.jpg)

当构建因耗尽可用内存（OOM）或磁盘空间（ENOSPC）而失败时，您现在将在构建日志中看到更详细的信息。

在发生 OOM 的情况下，构建日志将明确确认该事件；而在 ENOSPC 情况下，则会提供有关磁盘空间分配的详细信息。

请查阅[我们的文档](https://vercel.com/docs/deployments/troubleshoot-a-build#build-container-resources)了解更多信息。