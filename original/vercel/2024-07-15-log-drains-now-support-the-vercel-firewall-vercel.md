---
title: "Log Drains now support the Vercel Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/log-drains-now-support-the-vercel-firewall"
date: "2024-07-15"
scraped_at: "2026-03-02T09:42:55.886823424+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 15, 2024

![](images/log-drains-now-support-the-vercel-firewall-vercel/img_001.jpg)![](images/log-drains-now-support-the-vercel-firewall-vercel/img_002.jpg)

You can now drain [Vercel Firewall](https://vercel.com/docs/security/vercel-firewall) actions to external providers through Log Drains.

Requests denied by the Vercel Firewall will be drained with the `firewall` source. This includes the following events:

- Requests blocked by a Custom Rule

- Requests blocked by Challenge Mode

- Requests blocked Managed Rules (e.g. [OWASP CRS](https://vercel.com/docs/security/vercel-waf/managed-rulesets#configure-owasp-core-ruleset))

- Requests blocked by an IP Rule


If a rule is set to `log` or to `bypass`, requests will not be sent to Log Drains. Firewall actions are also surfaced inside of [Monitoring](https://vercel.com/docs/observability/monitoring).

Learn more about the [Log Drains](https://vercel.com/docs/observability/log-drains).