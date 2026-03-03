---
title: "Instantly redirect traffic using custom Vercel Firewall rules - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/instantly-redirect-traffic-using-custom-vercel-firewall-rules"
date: "2024-07-24"
scraped_at: "2026-03-02T09:42:57.305296583+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 24, 2024

![](images/instantly-redirect-traffic-using-custom-vercel-firewall-rules-vercel/img_001.jpg)![](images/instantly-redirect-traffic-using-custom-vercel-firewall-rules-vercel/img_002.jpg)

You can now redirect requests to a new page using [custom Firewall rules](https://vercel.com/docs/security/vercel-waf/custom-rules), adding to the existing challenge and block actions.

Publishing custom rules does not require a new deployment and will instantly propagate across the global Vercel Edge Network. Therefore, using custom rule redirects in moderation could provide a fast alternative to [Edge Network redirects](https://vercel.com/docs/edge-network/redirects), particularly in emergency situations.

Firewall redirects execute before Edge Network configuration redirects (e.g. [vercel.json or next.config.js)](https://vercel.com/docs/edge-network/redirects#configuration-redirects) are evaluated.

Custom rules are available for free on all plans.