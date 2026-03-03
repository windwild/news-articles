---
title: "You can now invalidate the CDN cache by providing a source image - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/you-can-now-invalidate-the-cdn-cache-by-providing-a-source-image"
date: "2025-11-20"
scraped_at: "2026-03-02T09:25:57.294998135+00:00"
language: "en"
translated: false
description: "You can now invalidate the CDN cache contents by providing a source image allowing you to revalidate image optimization content without increasing latency for your users"
---




Nov 20, 2025

![Purge CDN Cache by Source Image Screenshot](images/you-can-now-invalidate-the-cdn-cache-by-providing-a-source-image-vercel/img_001.jpg)![Purge CDN Cache by Source Image Screenshot](images/you-can-now-invalidate-the-cdn-cache-by-providing-a-source-image-vercel/img_002.jpg)

Vercel [Image Optimization](https://vercel.com/docs/image-optimization) dynamically transforms source images to reduce file size while maintaining high quality on the visitor's browser.

You can now invalidate the CDN cache by providing a source image.

This feature marks all transformed images derived from that source image as stale. The next request serves stale content instantly while revalidation happens in the background, with no latency impact for users.

There are several ways to invalidate a source image:

- [Dashboard Settings](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)

- [Vercel CLI](https://vercel.com/docs/cli/cache)

- [Function API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebysrcimage)

- [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache/invalidate-by-source-image)


In addition to invalidating by source image, you can also delete by source image if the origin is gone. Deleting the cache can increase latency while new content is generated, or cause downtime if your origin is unresponsive. We recommend you use with caution.

This is available on all plans using the [new image optimization price](https://vercel.com/changelog/faster-transformations-and-reduced-pricing-for-image-optimization).

Learn more about [cache invalidation](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache).