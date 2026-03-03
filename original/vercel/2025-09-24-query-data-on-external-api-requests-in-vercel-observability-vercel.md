---
title: "Query data on external API requests in Vercel Observability - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/query-data-on-external-api-requests-in-vercel-observability"
date: "2025-09-24"
scraped_at: "2026-03-02T09:28:00.934823121+00:00"
language: "en"
translated: false
description: "It's now possible to run custom queries against all external API requests that where made from Vercel Functions"
---




Sep 24, 2025

Observability Plus now supports querying and visualizing external API requests.

Observability Plus's [query builder](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%3Fbuilder%3Dtrue%26by%3DprojectId) allows customers to explore their Vercel data and visualize traffic, performance, and other key metrics. You can now author custom queries on request counts or time to first byte (TTFB) for external API calls, such as `fetch` requests to an AI provider.

TTFB queries include breakdowns by average, min, max, p75, p90, p95, and p99. You can also filter or group results by `request hostname` to focus on specific APIs.

The query builder is available to Pro and Enterprise teams using Observability Plus.

Learn more about [Observability](https://vercel.com/docs/observability) and [Observability Plus](https://vercel.com/docs/observability/observability-plus).