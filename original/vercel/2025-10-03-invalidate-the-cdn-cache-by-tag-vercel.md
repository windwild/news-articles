---
title: "Invalidate the CDN cache by tag - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/invalidate-the-cdn-cache-by-tag"
date: "2025-10-03"
scraped_at: "2026-03-02T09:27:41.186291644+00:00"
language: "en"
translated: false
description: "You can now invalidate the CDN cache contents by tag providing a way to revalidate content without increasing latency for your users"
---




Oct 3, 2025

![](images/invalidate-the-cdn-cache-by-tag-vercel/img_001.jpg)![](images/invalidate-the-cdn-cache-by-tag-vercel/img_002.jpg)

You can now invalidate CDN cache contents by tag.

This marks all cached content associated with the tag as stale. The next request serves stale content instantly while revalidation happens in the background, with no latency impact for users.

There are several ways to invalidate content:

- [Dashboard Settings](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)

- [Vercel CLI](https://vercel.com/docs/cli/cache)

- [Function API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebytag)

- [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache)


In addition to invalidating by tag if the origin content changes, you can also delete by tag if the origin content is gone. However, deleting the cache can increase latency while new content is generated or cause downtime if your origin is unresponsive, so use with caution.

**Available on all plans.** Learn more about [cache invalidation](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache).