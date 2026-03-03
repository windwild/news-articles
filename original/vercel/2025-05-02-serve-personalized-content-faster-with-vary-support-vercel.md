---
title: "Serve personalized content faster with Vary support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/serve-personalized-content-faster-with-vary-support"
date: "2025-05-02"
scraped_at: "2026-03-02T09:34:28.491320173+00:00"
language: "en"
translated: false
description: "Vercel now supports the HTTP Vary header, enabling faster delivery of personalized, cached content based on location and language. Improve site performance and reduce compute automatically with Edge N..."
---




May 2, 2025

![](images/serve-personalized-content-faster-with-vary-support-vercel/img_001.jpg)![](images/serve-personalized-content-faster-with-vary-support-vercel/img_002.jpg)

Vercel now fully supports the HTTP `Vary` header, making it easier to cache personalized content across all plans with no configuration required.

The `Vary` header tells caches which request headers to include when generating cache keys. This allows Vercel’s application delivery network to store and serve different versions of a page based on headers like `X-Vercel-IP-Country` or `Accept-Language`, so users get fast, localized content without recomputation.

```bash
Vary: X-Vercel-IP-Country

Cache-Control: s-maxage=60
```

By returning the above headers your site caches and serves country-specific content.

A visitor from the United States receives the US-specific cached version, and visitors from other countries receive the version for their locale, with no recomputation required.

Learn more about caching personalized content in [Vercel's application network documentation](https://vercel.com/docs/edge-network/caching).