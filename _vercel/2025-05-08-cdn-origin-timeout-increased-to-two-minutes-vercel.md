---
title: "CDN origin timeout increased to two minutes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/cdn-origin-timeout-increased-to-two-minutes"
date: "2025-05-08"
scraped_at: "2026-03-02T09:34:11.537526265+00:00"
language: "en-zh"
translated: true
description: "Vercel’s CDN proxy read timeout now increased to 120 seconds across all plans, enabling long-running AI workloads and reducing 504 gateway timeout errors. Available immediately at no cost, including..."
---
{% raw %}

May 8, 2025

2025 年 5 月 8 日

Vercel’s CDN will now wait up to 120 seconds for your backend to start sending data, up from 30 seconds. This extended proxied request timeout is now available on all plans at no additional cost.

Vercel 的 CDN 现在将最多等待 120 秒，以等待您的后端开始发送数据，此前该时限为 30 秒。此次延长的代理请求超时（proxied request timeout）现已面向所有套餐免费提供。

The [proxied request timeout](https://vercel.com/docs/limits#proxied-request-timeout) defines how long our CDN allows your [external backend](https://vercel.com/docs/rewrites) to respond before canceling the request. After the initial byte is received, your backend can take longer than two minutes to complete the request, as long as it continues sending data at least once every 120 seconds.

[代理请求超时](https://vercel.com/docs/limits#proxied-request-timeout) 定义了我们的 CDN 在取消请求前，允许您的[外部后端](https://vercel.com/docs/rewrites)响应的最长时间。在接收到首个字节后，只要您的后端能确保至少每 120 秒发送一次数据，其完成整个请求所耗时间即可超过两分钟。

This update improves reliability for workloads with long processing times, such as LLM generation or complex data queries, and reduces the chance of 504 gateway timeouts.

此项更新提升了长耗时任务（例如大语言模型生成或复杂数据查询）的可靠性，并降低了出现 504 网关超时错误的概率。

This change is effective immediately, with no action or configuration required.

此项变更即刻生效，无需任何操作或配置。
{% endraw %}
