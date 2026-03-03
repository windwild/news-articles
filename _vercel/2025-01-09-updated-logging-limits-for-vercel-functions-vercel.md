---
title: "Updated logging limits for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/updated-logging-limits-for-vercel-functions"
date: "2025-01-09"
scraped_at: "2026-03-02T09:38:17.827006608+00:00"
language: "en-zh"
translated: true
description: "The runtime log limits for Vercel Functions have been increased, allowing for significantly larger log entries. Logs are increased to 256KB per log line, 256 log lines per request, and 1MB total log s..."
---

Jan 9, 2025

2025 年 1 月 9 日

[Vercel Functions](https://vercel.com/docs/functions) 的 [运行时日志（runtime log）](https://vercel.com/docs/observability/runtime-logs) 限制已提升，支持显著更大的日志条目。此次更新取代了此前每行 4KB 的限制，现已对所有项目生效。

**当前运行时日志限制如下：**

- **单行日志大小：** 每行最多 256 KB。

- **单次请求的日志行数：** 每次请求最多支持 256 行独立日志。

- **单次请求的总日志大小：** 每次请求中所有日志行的总和最多为 1 MB。

了解更多关于日志的信息，请参阅 [我们的文档](https://vercel.com/docs/observability/runtime-logs)。