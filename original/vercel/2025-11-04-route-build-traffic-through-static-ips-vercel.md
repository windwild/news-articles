---
title: "Route build traffic through Static IPs - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/route-build-traffic-through-static-ips"
date: "2025-11-04"
scraped_at: "2026-03-02T09:26:10.934328140+00:00"
language: "en"
translated: false
description: "You can now choose whether build traffic, such as calls to external APIs or CMS data sources during the build process, routes through your Static IPs."
---




Nov 4, 2025

You can now choose whether build traffic, such as calls to external APIs or CMS data sources during the build process, routes through your Static IPs.

To enable this, go to your Project Settings → Connectivity → toggle "Use static IPs for builds."

By default, this setting is disabled. When enabled, both build and function traffic will route through Static IPs and count toward [Private Data Transfer](https://vercel.com/docs/pricing/regional-pricing) usage.

This is available to all teams using Static IPs.

[Try it out](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fconnectivity&title=) or learn more [here](https://vercel.com/docs/connectivity/static-ips#routing-build-traffic).