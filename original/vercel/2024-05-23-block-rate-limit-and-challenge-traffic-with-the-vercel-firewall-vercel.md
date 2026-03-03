---
title: "Block, rate limit, and challenge traffic with the Vercel Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall"
date: "2024-05-23"
scraped_at: "2026-03-02T09:45:15.622730937+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 23, 2024

![](images/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall-vercel/img_001.jpg)![](images/block-rate-limit-and-challenge-traffic-with-the-vercel-firewall-vercel/img_002.jpg)

The [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) now allows you to create custom rules to log, block, challenge, or rate limit (beta) traffic. The Firewall is available on all plans for free.

You can define custom rules to handle incoming traffic:

- Rules can be based on 15+ fields including request path, user agent, IP address, JA4 fingerprint, geolocation, HTTP headers, and even target path.

- Firewall configuration changes propagate within 300ms globally. If you make a mistake, you can instantly rollback to previous rules.


You can now see requests automatically protected by the Firewall, as well as managed custom rules for the WAF. You can also access managed rulesets, included our first ruleset available for Enterprise to mitigate the OWASP core risks.

[Learn more](https://vercel.com/docs/security/vercel-waf) about the WAF and available configuration options. [Contact us](https://vercel.com/contact/sales) if you want to try our private beta for rate limiting.