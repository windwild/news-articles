---
title: "Vercel WAF rate limiting now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-waf-rate-limiting-now-generally-available"
date: "2024-10-02"
scraped_at: "2026-03-02T09:40:49.195709975+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Oct 2, 2024

![](images/vercel-waf-rate-limiting-now-generally-available-vercel/img_001.jpg)![](images/vercel-waf-rate-limiting-now-generally-available-vercel/img_002.jpg)

Vercel Web Application Firewall (WAF) rate limiting is now generally available, giving you precise control over request volumes to your applications.

With over 15 parameters, including target path, headers, method, and cookies, you can define the business logic for rate limiting. Then, apply a rate-limiting algorithm tied to IP, JA4 digest, headers, or user agent to control the frequency of matching traffic within your set limits.

When paired with [persistent actions](https://vercel.com/changelog/vercel-waf-now-supports-persistent-actions), rate limiting can help reduce resource abuse across Edge Requests, Middleware, Data Transfer, and Function execution.

Rate limiting with a fixed-window algorithm is available today for Pro customers, with an additional token-bucket algorithm available to Enterprise customers. [Pricing for rate limiting](https://vercel.com/docs/security/vercel-waf/rate-limiting#pricing) is regional starting at $.50 per 1 million allowed requests.

Add rate limiting [using a template](https://vercel.com/templates/vercel-firewall/rate-limit-api-requests-firewall-rule) or read the [rate limiting documentation](https://vercel.com/docs/security/vercel-waf/rate-limiting) to learn more.