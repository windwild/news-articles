---
title: "Request collapsing for ISR cache misses - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/request-collapsing-for-isr-cache-misses"
date: "2025-09-25"
scraped_at: "2026-03-02T09:28:22.098722398+00:00"
language: "en"
translated: false
description: "Vercel now does regional request collapsing on cache miss for Incremental Static Regeneration (ISR)."
---




Sep 25, 2025

The Vercel CDN now prevents cache stampedes through [request collapsing](https://vercel.com/docs/request-collapsing) on an expired [Incremental Static Regeneration (ISR)](https://vercel.com/docs/incremental-static-regeneration) page into a single function invocation per region. Without collapsing, simultaneous requests each trigger regeneration, wasting compute and overloading backends. With collapsing, one request regenerates the page while others wait and return the cached result.

This improves reliability, reduces backend load, and saves significant compute at scale.

The feature is applied automatically for cacheable routes. Cacheability is inferred from framework metadata, so no configuration is required.

Implementation details are available in the [Preventing the stampede: Request collapsing in the Vercel CDN blog post](https://vercel.com/blog/cdn-request-collapsing).