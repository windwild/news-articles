---
title: "Introducing the Runtime Cache API - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-the-runtime-cache-api"
date: "2025-08-13"
scraped_at: "2026-03-02T09:29:47.257246383+00:00"
language: "en-zh"
translated: true
description: "Vercel RuntimeCache API that's available in all runtimes, including build, edge, middleware, & serverless."
---
&#123;% raw %}

Aug 13, 2025

2025 年 8 月 13 日

You can now access Vercel's [Runtime Cache via API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#getcache).

现在，您可通过 API 访问 Vercel 的 [Runtime Cache（运行时缓存）](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#getcache)。

The Runtime Cache is an ephemeral cache for storing and retrieving data across [Functions](https://vercel.com/docs/functions), [Routing Middleware](https://vercel.com/docs/routing-middleware), and [Builds](https://vercel.com/docs/builds) within the same region. It supports tag-based invalidation for precise and efficient cache control.

Runtime Cache 是一种临时性缓存，用于在**同一地域内**的 [Functions（函数）](https://vercel.com/docs/functions)、[Routing Middleware（路由中间件）](https://vercel.com/docs/routing-middleware) 和 [Builds（构建）](https://vercel.com/docs/builds) 之间存储与检索数据。它支持基于标签（tag）的缓存失效机制，从而实现精准、高效的缓存控制。

You can get started with the API like this:

您可按如下方式快速开始使用该 API：

```javascript
import { getCache } from "@vercel/functions";



export async function GET(request) {

4  const cache = getCache();

5  const cacheKey = 'blog';
```

7  const value = await cache.get(cacheKey);

7  const value = await cache.get(cacheKey);

9  if (value) {

9  如果 value 存在（非空）：

10    return value;

10    返回 value；

11  }

11  }

13  const res = await fetch("https://api.vercel.app/blog");

13  const res = await fetch("https://api.vercel.app/blog");

14  const originValue = await res.json();

14  const originValue = await res.json();

16  await cache.set(cacheKey, originValue, {

16  await cache.set(cacheKey, originValue, {

17    ttl: 3600,

17    ttl: 3600,

18    tags: ['blogs'],

18    tags: ['blogs'],

19  });



19  });



21  return originValue;

21  return originValue;

22}
```

22}
```

You can monitor hit rates, invalidation patterns, and storage usage across your applications in the Observability dashboard's Runtime Cache tab.

您可以在可观测性（Observability）仪表板的“运行时缓存（Runtime Cache）”标签页中，监控您所有应用的缓存命中率、失效模式及存储使用情况。

Runtime Cache reads and writes are [billed regionally](https://vercel.com/docs/pricing/regional-pricing) based on the runtime region.

运行时缓存（Runtime Cache）的读写操作按运行时所在区域计费，详情请参阅[区域定价说明](https://vercel.com/docs/pricing/regional-pricing)。

The Vercel Data Cache, used by `unstable_cache()` and `fetch()` caching in Next.js 13, remains in beta and is not billed during this period.

Vercel 数据缓存（Vercel Data Cache）——即 Next.js 13 中由 `unstable_cache()` 和 `fetch()` 缓存机制所使用的缓存——目前仍处于 Beta 阶段，此期间暂不计费。

You can still view your Vercel Data Cache usage under the Runtime Cache tab via the toggle at the top of the page.

您仍可通过页面顶部的切换开关，在“运行时缓存（Runtime Cache）”标签页中查看 Vercel 数据缓存的使用情况。

Learn more about [Runtime Cache in the docs](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#getcache).

请在文档中了解有关 [运行时缓存（Runtime Cache）](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#getcache) 的更多信息。
&#123;% endraw %}
