---
title: "Improved resiliency for Vercel Functions with inter-region failover support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-resiliency-for-vercel-functions-with-failover-support"
date: "2024-01-26"
scraped_at: "2026-03-02T09:48:14.951967874+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 26, 2024

![](images/improved-resiliency-for-vercel-functions-with-inter-region-failover-support-verc/img_001.jpg)![](images/improved-resiliency-for-vercel-functions-with-inter-region-failover-support-verc/img_002.jpg)

Vercel Functions can now [automatically failover to the next healthy region](https://vercel.com/docs/functions/configuring-functions/region#automatic-failover).

Vercel's Edge Network is resilient to regional outages by automatically rerouting traffic to static assets. Vercel Functions also have multiple availability zone redundancy by default. We are now enhancing this further with support for multi-region redundancy for Functions.

In the instance of a regional outage, traffic directed towards your Vercel Function using the Node.js runtime will be automatically re-routed to the next healthy region, ensuring continuous service delivery and uptime without manual intervention.

Failover regions are also supported through [Vercel Secure Compute](https://vercel.com/docs/security/secure-compute), which allows you to create private connections between your databases and other private infrastructure.

You can configure which regions to failover to in your `vercel.json` file. For example, you might want to fallback to many different regions, or specific regions in a country.

vercel.json

```json
1{

2  "functionFailoverRegions": ["iad1", "cle1"]

3}
```

Defining your fallback regions in your configuration file.

Enterprise teams can enable this feature in their project settings. If you are not on Enterprise, [get in touch](https://vercel.com/contact/sales) to upgrade and enable function failover.