---
title: "Instantly redirect traffic using custom Vercel Firewall rules - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/instantly-redirect-traffic-using-custom-vercel-firewall-rules"
date: "2024-07-24"
scraped_at: "2026-03-02T09:42:57.305296583+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jul 24, 2024

2024年7月24日

![](images/instantly-redirect-traffic-using-custom-vercel-firewall-rules-vercel/img_001.jpg)![](images/instantly-redirect-traffic-using-custom-vercel-firewall-rules-vercel/img_002.jpg)

You can now redirect requests to a new page using [custom Firewall rules](https://vercel.com/docs/security/vercel-waf/custom-rules), adding to the existing challenge and block actions.

您现在可以使用[自定义防火墙规则（Custom Firewall Rules）](https://vercel.com/docs/security/vercel-waf/custom-rules)，在现有“挑战（challenge）”和“拦截（block）”操作之外，新增“重定向至新页面”的功能。

Publishing custom rules does not require a new deployment and will instantly propagate across the global Vercel Edge Network. Therefore, using custom rule redirects in moderation could provide a fast alternative to [Edge Network redirects](https://vercel.com/docs/edge-network/redirects), particularly in emergency situations.

发布自定义规则无需重新部署，且会立即在全球 Vercel 边缘网络（Vercel Edge Network）中生效。因此，在合理使用的前提下，基于自定义规则的重定向可为[边缘网络重定向（Edge Network redirects）](https://vercel.com/docs/edge-network/redirects)提供一种更快速的替代方案，尤其适用于紧急情况。

Firewall redirects execute before Edge Network configuration redirects (e.g. [vercel.json or next.config.js)](https://vercel.com/docs/edge-network/redirects#configuration-redirects) are evaluated.

防火墙重定向（Firewall redirects）的执行优先级高于边缘网络配置级重定向（例如通过 [`vercel.json`](https://vercel.com/docs/edge-network/redirects#configuration-redirects) 或 [`next.config.js`](https://vercel.com/docs/edge-network/redirects#configuration-redirects) 配置的重定向）。

Custom rules are available for free on all plans.

所有套餐均免费提供自定义规则功能。