---
title: "Introducing the Runtime Cache API - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-the-runtime-cache-api"
date: "2025-08-13"
scraped_at: "2026-03-02T09:29:47.257246383+00:00"
language: "en"
translated: false
description: "Vercel RuntimeCache API that's available in all runtimes, including build, edge, middleware, & serverless."
---




Aug 13, 2025

You can now access Vercel's [Runtime Cache via API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#getcache).

The Runtime Cache is an ephemeral cache for storing and retrieving data across [Functions](https://vercel.com/docs/functions), [Routing Middleware](https://vercel.com/docs/routing-middleware), and [Builds](https://vercel.com/docs/builds) within the same region. It supports tag-based invalidation for precise and efficient cache control.

You can get started with the API like this:

```javascript
import { getCache } from "@vercel/functions";



export async function GET(request) {

4  const cache = getCache();

5  const cacheKey = 'blog';



7  const value = await cache.get(cacheKey);



9  if (value) {

10    return value;

11  }



13  const res = await fetch("https://api.vercel.app/blog");

14  const originValue = await res.json();



16  await cache.set(cacheKey, originValue, {

17    ttl: 3600,

18    tags: ['blogs'],

19  });



21  return originValue;

22}
```

You can monitor hit rates, invalidation patterns, and storage usage across your applications in the Observability dashboard's Runtime Cache tab.

Runtime Cache reads and writes are [billed regionally](https://vercel.com/docs/pricing/regional-pricing) based on the runtime region.

The Vercel Data Cache, used by `unstable_cache()` and `fetch()` caching in Next.js 13, remains in beta and is not billed during this period.

You can still view your Vercel Data Cache usage under the Runtime Cache tab via the toggle at the top of the page.

Learn more about [Runtime Cache in the docs](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#getcache).