---
title: "Improved streaming runtime logs exports - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-streaming-runtime-logs-exports"
date: "2026-02-17"
scraped_at: "2026-03-02T09:21:31.703314381+00:00"
language: "en"
translated: false
description: "Runtime Logs exports now stream directly to your browser, export actual requests instead of raw rows, and match exactly what's on your screen or search."
---




Feb 17, 2026

With runtime logs, you can view and export your logs. Exports now stream directly to the browser - your download starts immediately and you can continue to use the Vercel dashboard while the export runs in the background. This eliminates the need to wait for large files to buffer.

Additionally, we've added two new options: You can now export exactly what's on your screen or all requests matching your current search.

![](images/improved-streaming-runtime-logs-exports-vercel/img_001.jpg)![](images/improved-streaming-runtime-logs-exports-vercel/img_002.jpg)

All plans can export up to 10,000 requests per export, and [Observability Plus](https://vercel.com/docs/observability/observability-plus) subscribers can export up to 100,000 requests.

Exported log data is now indexed by request to ensure consistency with the [Runtime Logs](https://vercel.com/docs/observability/runtime-logs) dashboard interface. Export limits are now applied by request to ensure that the exported data matches the filtered requests shown on the dashboard.

[Learn more about runtime logs](https://vercel.com/docs/logs/runtime).