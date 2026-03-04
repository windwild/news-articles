---
title: "Route build traffic through Static IPs - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/route-build-traffic-through-static-ips"
date: "2025-11-04"
scraped_at: "2026-03-02T09:26:10.934328140+00:00"
language: "en-zh"
translated: true
description: "You can now choose whether build traffic, such as calls to external APIs or CMS data sources during the build process, routes through your Static IPs."
---

render_with_liquid: false
Nov 4, 2025

2025 年 11 月 4 日

You can now choose whether build traffic, such as calls to external APIs or CMS data sources during the build process, routes through your Static IPs.

现在，您可选择在构建过程中（例如调用外部 API 或 CMS 数据源时）的构建流量是否经由您的静态 IP（Static IPs）路由。

To enable this, go to your Project Settings → Connectivity → toggle "Use static IPs for builds."

如需启用此功能，请进入项目设置（Project Settings）→ 连接性（Connectivity），然后开启“为构建使用静态 IP”（Use static IPs for builds）开关。

By default, this setting is disabled. When enabled, both build and function traffic will route through Static IPs and count toward [Private Data Transfer](https://vercel.com/docs/pricing/regional-pricing) usage.

默认情况下，该设置处于关闭状态。启用后，构建流量与函数流量均将通过静态 IP 路由，并计入 [私有数据传输](https://vercel.com/docs/pricing/regional-pricing) 的用量。

This is available to all teams using Static IPs.

所有使用静态 IP 的团队均可使用此功能。

[Try it out](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fconnectivity&title=) or learn more [here](https://vercel.com/docs/connectivity/static-ips#routing-build-traffic).

[立即试用](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fconnectivity&title=)，或在此处[了解详情](https://vercel.com/docs/connectivity/static-ips#routing-build-traffic)。