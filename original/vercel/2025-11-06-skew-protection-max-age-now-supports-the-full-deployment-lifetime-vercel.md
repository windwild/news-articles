---
title: "Skew Protection max age now supports the full deployment lifetime - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/skew-protection-max-age-now-supports-the-full-deployment-lifetime"
date: "2025-11-06"
scraped_at: "2026-03-02T09:26:13.332322892+00:00"
language: "en"
translated: false
description: "You can now configure skew protection max age to any value less than or equal to your deployment retention. Previously this was limited to 12 hours for Pro and 7 days for Enterprise."
---




Nov 6, 2025

Skew Protection helps ensure that requests for a user's session are consistently routed to the same deployment, even when new versions are being rolled out.

You can now configure your project's [Skew Protection](https://vercel.com/docs/skew-protection) max age to persist for the entire lifetime of your deployments. This removes the previous limits of 12 hours on Pro and 7 days on Enterprise.

Set the value to any duration less than or equal to your project's [Deployment Retention](https://vercel.com/docs/deployment-retention) policy.

Learn more about [Skew Protection](https://vercel.com/docs/skew-protection) and [enable it in your project](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fadvanced%23skew-protection&title=Enable+Skew+Protection).