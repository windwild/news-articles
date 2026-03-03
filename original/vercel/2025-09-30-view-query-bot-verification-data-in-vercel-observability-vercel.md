---
title: "View & query bot verification data in Vercel Observability - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/view-and-query-bot-verification-data-in-vercel-observability"
date: "2025-09-30"
scraped_at: "2026-03-02T09:28:16.544268735+00:00"
language: "en"
translated: false
description: "Analyze traffic to your Vercel projects by bot name, bot category, and bot verification status in Vercel Observability"
---




Sep 30, 2025

![](images/view-query-bot-verification-data-in-vercel-observability-vercel/img_001.jpg)![](images/view-query-bot-verification-data-in-vercel-observability-vercel/img_002.jpg)

Vercel inspects every request to identify bot traffic. For requests claiming to come from a verified source, Vercel cross-checks against its directory of [verified bots](https://vercel.com/docs/bot-management#verified-bots) and validates them against strict verification criteria.

We've added three new dimensions to the query builder when analyzing Edge Requests to help you understand bot activity to your projects:

- **Bot name:** Identify specific bots

- **Bot category:** Group bots by type

- **Bot verified:** Distinguish between verified, spoofed, and unverifiable bots


Additionally, the Edge Requests dashboard in Observability now displays verification badges next to bot names.

All users can view bot verification badge while Observability Plus subscribers can query this data at no extra cost.

[Try it out](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%2Fnotebooks) or learn more about [Observability](https://vercel.com/docs/observability) and [Observability Plus](https://vercel.com/docs/observability/observability-plus).