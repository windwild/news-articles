---
title: "Invalidate the CDN cache by tag - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/invalidate-the-cdn-cache-by-tag"
date: "2025-10-03"
scraped_at: "2026-03-02T09:27:41.186291644+00:00"
language: "en-zh"
translated: true
description: "You can now invalidate the CDN cache contents by tag providing a way to revalidate content without increasing latency for your users"
---
{% raw %}

Oct 3, 2025

2025 年 10 月 3 日

![](images/invalidate-the-cdn-cache-by-tag-vercel/img_001.jpg)![](images/invalidate-the-cdn-cache-by-tag-vercel/img_002.jpg)

You can now invalidate CDN cache contents by tag.

您现在可以通过标签（tag）使 CDN 缓存内容失效。

This marks all cached content associated with the tag as stale. The next request serves stale content instantly while revalidation happens in the background, with no latency impact for users.

这会将所有与该标签关联的缓存内容标记为“过期”。下一次请求将立即返回过期内容，同时在后台异步执行重新验证，用户完全不会感知延迟。

There are several ways to invalidate content:

使内容失效有多种方式：

- [Dashboard Settings](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)

- [控制台设置（Dashboard Settings）](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)

- [Vercel CLI](https://vercel.com/docs/cli/cache)

- [Vercel CLI](https://vercel.com/docs/cli/cache)

- [Function API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebytag)

- [函数 API（Function API）](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebytag)

- [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache)

- [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache)

In addition to invalidating by tag if the origin content changes, you can also delete by tag if the origin content is gone. However, deleting the cache can increase latency while new content is generated or cause downtime if your origin is unresponsive, so use with caution.

除了在源站内容发生变化时通过标签使缓存失效外，当源站内容已彻底移除时，您也可通过标签直接删除缓存。但请注意：删除缓存可能导致新内容生成期间延迟上升，或在源站无响应时引发服务中断，因此请谨慎使用。

**Available on all plans.**

**所有套餐均支持。**

Learn more about [cache invalidation](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache).

了解更多关于[缓存失效](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)的信息。
{% endraw %}
