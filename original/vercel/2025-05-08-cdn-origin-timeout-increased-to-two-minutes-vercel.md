---
title: "CDN origin timeout increased to two minutes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/cdn-origin-timeout-increased-to-two-minutes"
date: "2025-05-08"
scraped_at: "2026-03-02T09:34:11.537526265+00:00"
language: "en"
translated: false
description: "Vercel’s CDN proxy read timeout now increased to 120 seconds across all plans, enabling long-running AI workloads and reducing 504 gateway timeout errors. Available immediately at no cost, including..."
---




May 8, 2025

Vercel’s CDN will now wait up to 120 seconds for your backend to start sending data, up from 30 seconds. This extended proxied request timeout is now available on all plans at no additional cost.

The [proxied request timeout](https://vercel.com/docs/limits#proxied-request-timeout) defines how long our CDN allows your [external backend](https://vercel.com/docs/rewrites) to respond before canceling the request. After the initial byte is received, your backend can take longer than two minutes to complete the request, as long as it continues sending data at least once every 120 seconds.

This update improves reliability for workloads with long processing times, such as LLM generation or complex data queries, and reduces the chance of 504 gateway timeouts.

This change is effective immediately, with no action or configuration required.