---
title: "Runtime logs can now be filtered by request type and Vercel resource - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/runtime-logs-can-now-be-filtered-by-request-type-and-vercel-resource"
date: "2025-01-07"
scraped_at: "2026-03-02T09:38:25.618595536+00:00"
language: "en"
translated: false
description: "Runtime Logs can now be filtered by request type and Vercel resource, which provides more granular insights into how your requests are processed. Learn how these filters can enhance your debugging and..."
---




Jan 7, 2025

![](images/runtime-logs-can-now-be-filtered-by-request-type-and-vercel-resource-vercel/img_001.jpg)![](images/runtime-logs-can-now-be-filtered-by-request-type-and-vercel-resource-vercel/img_002.jpg)

The "Contain Types" filter in [runtime logs](https://vercel.com/docs/observability/runtime-logs) has been replaced by two new filters for better clarity:

1. **Resource**: Filters which infrastructure resource within the Vercel Edge Network was used to serve the request. Examples include Serverless Functions, Edge Cache, and Edge Middleware

2. **Request Type**: Filters which framework-defined mechanism or rendering strategy was used by the request. Examples include API routes, Incremental Static Regeneration (ISR), and cron jobs


These updates provide more granular insights into how your requests are processed. Both filters are available on all plans starting today.

Learn more about [how Vercel processes requests](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter).