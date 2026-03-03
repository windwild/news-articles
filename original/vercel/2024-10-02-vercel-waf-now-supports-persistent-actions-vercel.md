---
title: "Vercel WAF now supports persistent actions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-waf-now-supports-persistent-actions"
date: "2024-10-02"
scraped_at: "2026-03-02T09:40:46.431558952+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Oct 2, 2024

![](images/vercel-waf-now-supports-persistent-actions-vercel/img_001.jpg)![](images/vercel-waf-now-supports-persistent-actions-vercel/img_002.jpg)

Vercel [Web Application Firewall (WAF)](https://vercel.com/docs/security/vercel-waf) now supports persistent actions to block repeat offenders who trigger firewall rules.

These persistent actions enforce specific responses—such as blocking—against clients for a defined period, ranging from 1-60 minutes. While active, these actions prevent unnecessary processing by blocking requests earlier in their lifecycle, reducing edge request load.

You can apply persistence to existing rules for actions like deny, challenge, and rate-limiting, adding an extra layer of control to your firewall logic.

Learn more about [persistent actions](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions).