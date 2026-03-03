---
title: "Add cache tags from Function responses, regardless of framework - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/add-cache-tags-from-function-responses-regardless-of-framework"
date: "2025-12-12"
scraped_at: "2026-03-02T09:24:03.697364560+00:00"
language: "en"
translated: false
description: "You can now add tag(s) to cached responses from serverless functions using `addCacheTag()` and later invalidate the cache associated with these tag(s) using `invalidateByTag()`."
---




Dec 12, 2025

You can now add one or more cache tags to your Function response by importing the [addCacheTag](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#addcachetag) function from [@vercel/functions](https://www.npmjs.com/package/@vercel/functions) npm package.

`import { addCacheTag } from '@vercel/functions'`

Once the cached response has a tag associated with it, you can later invalidate the cache in one of several ways:

- [Dashboard Settings](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)

- [Vercel CLI](https://vercel.com/docs/cli/cache)

- [Function API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebytag)

- [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache)


**Available on all plans and all frameworks.**

Learn more about [cache invalidation](https://vercel.com/docs/edge-cache/purge#understanding-cache-purging).