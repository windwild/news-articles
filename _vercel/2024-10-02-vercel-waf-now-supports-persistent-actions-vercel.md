---
title: "Vercel WAF now supports persistent actions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-waf-now-supports-persistent-actions"
date: "2024-10-02"
scraped_at: "2026-03-02T09:40:46.431558952+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Oct 2, 2024

2024年10月2日

![](images/vercel-waf-now-supports-persistent-actions-vercel/img_001.jpg)![](images/vercel-waf-now-supports-persistent-actions-vercel/img_002.jpg)

Vercel [Web Application Firewall (WAF)](https://vercel.com/docs/security/vercel-waf) now supports persistent actions to block repeat offenders who trigger firewall rules.

Vercel [Web 应用防火墙（WAF）](https://vercel.com/docs/security/vercel-waf) 现已支持“持久化操作”（persistent actions），可对反复触发防火墙规则的恶意客户端实施阻断。

These persistent actions enforce specific responses—such as blocking—against clients for a defined period, ranging from 1-60 minutes. While active, these actions prevent unnecessary processing by blocking requests earlier in their lifecycle, reducing edge request load.

此类持久化操作可在 1 至 60 分钟的指定时间段内，对客户端强制执行特定响应（例如阻断）。在生效期间，这些操作可在请求生命周期更早阶段即予以拦截，从而避免不必要的处理，减轻边缘节点的请求负载。

You can apply persistence to existing rules for actions like deny, challenge, and rate-limiting, adding an extra layer of control to your firewall logic.

您可将持久化能力应用于现有的 deny（拒绝）、challenge（人机验证挑战）和 rate-limiting（速率限制）等规则，为您的防火墙逻辑增添一层额外的管控能力。

Learn more about [persistent actions](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions).

了解更多关于[持久化操作](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions)的信息。
{% endraw %}
