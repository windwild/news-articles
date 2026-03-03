---
title: "Caching details now available in Runtime Logs - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/caching-details-now-available-in-runtime-logs"
date: "2025-10-31"
scraped_at: "2026-03-02T09:26:22.334846824+00:00"
language: "en-zh"
translated: true
description: "Details on ISR cache keys, cache tags, and cache revalidation reasons are now available in Runtime Logs for all customers"
---

Oct 31, 2025

2025 年 10 月 31 日

![](images/caching-details-now-available-in-runtime-logs-vercel/img_001.jpg)![](images/caching-details-now-available-in-runtime-logs-vercel/img_002.jpg)

You can now view more details on how Vercel's [CDN](https://vercel.com/docs/cdn) globally serves cached content to users as quickly as possible.

您现在可以查看更详细的日志信息，了解 Vercel 的 [CDN](https://vercel.com/docs/cdn) 如何在全球范围内尽可能快速地向用户提供缓存内容。

In the right-hand panel of the Runtime Logs page, we now list:

在“Runtime Logs”（运行时日志）页面的右侧面板中，我们现在列出了以下信息：

- **Cache key**: A unique identifier for a specific version of a cached page

- **缓存键（Cache key）**：缓存页面某一特定版本的唯一标识符

- **Cache tags**: Tags associated with the cached data

- **缓存标签（Cache tags）**：与缓存数据关联的标签

- **Revalidation reason**: If a revalidation took place, the reason why the content was being revalidated (time-based, tag-based, or deployment-based)

- **重新验证原因（Revalidation reason）**：若发生了重新验证，则显示内容被重新验证的原因（基于时间、基于标签，或基于部署）

![](images/caching-details-now-available-in-runtime-logs-vercel/img_003.jpg)![](images/caching-details-now-available-in-runtime-logs-vercel/img_004.jpg)

This is available to all Vercel users at no additional cost. [Try it out](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Flogs) or learn more about [Runtime Logs](https://vercel.com/docs/logs/runtime).

此功能面向所有 Vercel 用户免费开放。[立即试用](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Flogs)，或进一步了解 [Runtime Logs（运行时日志）](https://vercel.com/docs/logs/runtime)。