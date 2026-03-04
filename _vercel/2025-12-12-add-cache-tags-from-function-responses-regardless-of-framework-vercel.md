---
title: "Add cache tags from Function responses, regardless of framework - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/add-cache-tags-from-function-responses-regardless-of-framework"
date: "2025-12-12"
scraped_at: "2026-03-02T09:24:03.697364560+00:00"
language: "en-zh"
translated: true
description: "You can now add tag(s) to cached responses from serverless functions using `addCacheTag()` and later invalidate the cache associated with these tag(s) using `invalidateByTag()`."
---
&#123;% raw %}

Dec 12, 2025

2025 年 12 月 12 日

您现在可以通过从 [@vercel/functions](https://www.npmjs.com/package/@vercel/functions) npm 包中导入 [addCacheTag](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#addcachetag) 函数，为您的 Function 响应添加一个或多个缓存标签。

`import { addCacheTag } from '@vercel/functions'`

一旦缓存的响应关联了某个标签，您即可通过以下几种方式之一后续使该缓存失效：

- [控制台设置](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)

- [Vercel CLI](https://vercel.com/docs/cli/cache)

- [Function API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebytag)

- [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache)

**所有套餐及所有框架均支持此功能。**

了解更多关于[缓存失效（缓存清除）](https://vercel.com/docs/edge-cache/purge#understanding-cache-purging)的信息。
&#123;% endraw %}
