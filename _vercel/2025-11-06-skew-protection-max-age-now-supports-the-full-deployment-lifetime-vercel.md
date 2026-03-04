---
title: "Skew Protection max age now supports the full deployment lifetime - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/skew-protection-max-age-now-supports-the-full-deployment-lifetime"
date: "2025-11-06"
scraped_at: "2026-03-02T09:26:13.332322892+00:00"
language: "en-zh"
translated: true
description: "You can now configure skew protection max age to any value less than or equal to your deployment retention. Previously this was limited to 12 hours for Pro and 7 days for Enterprise."
---

render_with_liquid: false
Nov 6, 2025

2025 年 11 月 6 日

Skew Protection helps ensure that requests for a user's session are consistently routed to the same deployment, even when new versions are being rolled out.

倾斜保护（Skew Protection）可确保在新版本发布期间，用户会话的请求始终被一致地路由至同一部署实例。

You can now configure your project's [Skew Protection](https://vercel.com/docs/skew-protection) max age to persist for the entire lifetime of your deployments. This removes the previous limits of 12 hours on Pro and 7 days on Enterprise.

您现在可以将项目的 [倾斜保护（Skew Protection）](https://vercel.com/docs/skew-protection) 最大有效期配置为与部署的整个生命周期保持一致。此举取消了此前 Pro 计划下 12 小时、Enterprise 计划下 7 天的有效期限制。

Set the value to any duration less than or equal to your project's [Deployment Retention](https://vercel.com/docs/deployment-retention) policy.

请将该值设置为不超过项目 [部署保留策略（Deployment Retention）](https://vercel.com/docs/deployment-retention) 所允许的任意时长。

Learn more about [Skew Protection](https://vercel.com/docs/skew-protection) and [enable it in your project](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fadvanced%23skew-protection&title=Enable+Skew+Protection).

进一步了解 [倾斜保护（Skew Protection）](https://vercel.com/docs/skew-protection)，并[在您的项目中启用该功能](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fadvanced%23skew-protection&title=Enable+Skew+Protection)。