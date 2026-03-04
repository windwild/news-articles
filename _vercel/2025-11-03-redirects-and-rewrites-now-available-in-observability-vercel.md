---
title: "Redirects and rewrites now available in Observability - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/redirects-and-rewrites-now-available-in-observability"
date: "2025-11-03"
scraped_at: "2026-03-02T09:26:26.628294388+00:00"
language: "en-zh"
translated: true
description: "Improved observability of redirects and rewrites are now generally available under the Observability tab on Vercel's Dashboard.  Redirect and rewrite request logs are now drainable to any configured D..."
---

render_with_liquid: false
Nov 3, 2025

2025 年 11 月 3 日

![An image showing the Edit Drain modal to opt into Redirect request logs](images/redirects-and-rewrites-now-available-in-observability-vercel/img_001.jpg)![An image showing the Edit Drain modal to opt into Redirect request logs](images/redirects-and-rewrites-now-available-in-observability-vercel/img_002.jpg)

![显示“Edit Drain”模态框以启用重定向请求日志的图片](images/redirects-and-rewrites-now-available-in-observability-vercel/img_001.jpg)![显示“Edit Drain”模态框以启用重定向请求日志的图片](images/redirects-and-rewrites-now-available-in-observability-vercel/img_002.jpg)

Improved observability into [redirects](https://vercel.com/docs/redirects) and [external rewrites](https://vercel.com/docs/rewrites#external-rewrites) is now available to all Vercel customers.

针对 [重定向（redirects）](https://vercel.com/docs/redirects) 和 [外部重写（external rewrites）](https://vercel.com/docs/rewrites#external-rewrites) 的可观测性已全面升级，并向所有 Vercel 用户开放。

External rewrites forward requests to APIs or websites outside your Vercel project, effectively allowing Vercel to function as a reverse proxy or standalone CDN.

外部重写会将请求转发至您 Vercel 项目之外的 API 或网站，从而让 Vercel 充当反向代理或独立 CDN。

![See external rewrites, connection latency, and errors by hostname or path](images/redirects-and-rewrites-now-available-in-observability-vercel/img_003.jpg)![See external rewrites, connection latency, and errors by hostname or path](images/redirects-and-rewrites-now-available-in-observability-vercel/img_004.jpg)

![按主机名或路径查看外部重写、连接延迟及错误的界面截图](images/redirects-and-rewrites-now-available-in-observability-vercel/img_003.jpg)![按主机名或路径查看外部重写、连接延迟及错误的界面截图](images/redirects-and-rewrites-now-available-in-observability-vercel/img_004.jpg)

See external rewrites, connection latency, and errors by hostname or path

按主机名或路径查看外部重写、连接延迟及错误

Customers on all plans get new views that offer visibility into key rewrite metrics:

所有套餐用户均可使用全新视图，实时掌握关键重写指标：

- Total external rewrites  
- External rewrites by hostnames  

- 外部重写总次数  
- 按主机名划分的外部重写次数  

Customers on Pro and Enterprise plans can upgrade to [Observability Plus](https://vercel.com/docs/observability#enabling-observability-plus) to get:  

Pro 与 Enterprise 套餐用户可升级至 [Observability Plus](https://vercel.com/docs/observability#enabling-observability-plus)，以获取以下功能：

- Connection latency to external host

- 到外部主机的连接延迟

- Rewrites by source/destination paths

- 基于源路径/目标路径的重写

- Routes and paths for redirect location

- 重定向目标位置的路由与路径


[Drains](https://vercel.com/docs/drains) have also been updated to support the following:

[Drains（数据输出）](https://vercel.com/docs/drains) 也已更新，以支持以下功能：

- [Redirects](https://vercel.com/docs/redirects)

- [重定向（Redirects）](https://vercel.com/docs/redirects)

- [External Rewrites](https://vercel.com/docs/rewrites#external-rewrites)

- [外部重写（External Rewrites）](https://vercel.com/docs/rewrites#external-rewrites)

- [Cached External Rewrites](https://vercel.com/docs/rewrites#caching-external-rewrites)

- [缓存的外部重写（Cached External Rewrites）](https://vercel.com/docs/rewrites#caching-external-rewrites)


[View external rewrites](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability%2Frewrites&title=View+external+rewrites) or learn more about [Observability](https://vercel.com/docs/observability).

[查看外部重写](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fobservability%2Frewrites&title=View+external+rewrites)，或进一步了解 [可观测性（Observability）](https://vercel.com/docs/observability)。