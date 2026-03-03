---
title: "Proxied responses now cacheable via CDN-Cache-Control headers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/proxied-responses-now-cacheable-via-cdn-cache-control-headers"
date: "2025-05-13"
scraped_at: "2026-03-02T09:33:24.475600578+00:00"
language: "en"
translated: false
description: "Vercel's CDN now supports CDN-Cache-Control headers for external backends, giving you simple, powerful caching control without any configuration changes."
---




May 13, 2025

![](images/proxied-responses-now-cacheable-via-cdn-cache-control-headers-vercel/img_001.jpg)![](images/proxied-responses-now-cacheable-via-cdn-cache-control-headers-vercel/img_002.jpg)

Vercel’s CDN, which can proxy requests to external backends, now caches proxied responses using the `CDN-Cache-Control` and `Vercel-CDN-Cache-Control` headers. This aligns caching behavior for external backends with how Vercel Functions are already cached.

This is available starting today, on all plans, at no additional cost.

Per the Targeted HTTP Cache Control spec ( [RFC 9213](https://httpwg.org/specs/rfc9213.html)), these headers support standard directives like `max-age` and `stale-while-revalidate`, enabling fine-grained control over CDN caching without affecting browser caches.

You can return the headers directly from your backend, or define them in `vercel.json` under the `headers` key if your backend can't be modified.

No configuration changes or redeployments required. Return the header (or set it in `vercel.json`) to improve performance, reduce origin load, and ensure fresh content.

Learn more about [CDN-Cache-Control headers](https://vercel.com/docs/rewrites#caching-external-rewrites).