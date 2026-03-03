---
title: "Updated logging limits for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/updated-logging-limits-for-vercel-functions"
date: "2025-01-09"
scraped_at: "2026-03-02T09:38:17.827006608+00:00"
language: "en"
translated: false
description: "The runtime log limits for Vercel Functions have been increased, allowing for significantly larger log entries. Logs are increased to 256KB per log line, 256 log lines per request, and 1MB total log s..."
---




Jan 9, 2025

The [runtime log](https://vercel.com/docs/observability/runtime-logs) limits for [Vercel Functions](https://vercel.com/docs/functions) have been increased, allowing for significantly larger log entries. These updates replace the previous 4KB-per-line restriction, and they are now live for all projects.

**The runtime log limits are now:**

- **Log line size:** Up to 256KB per log line.

- **Log line count:** Up to 256 individual log lines per request.

- **Total log size per request:** Up to 1MB (sum of all log lines in a single request).


Learn more about our logs in [our documentation](https://vercel.com/docs/observability/runtime-logs).