---
render_with_liquid: false
title: "You can now invalidate the CDN cache by providing a source image - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/you-can-now-invalidate-the-cdn-cache-by-providing-a-source-image"
date: "2025-11-20"
scraped_at: "2026-03-02T09:25:57.294998135+00:00"
language: "en-zh"
translated: true
description: "You can now invalidate the CDN cache contents by providing a source image allowing you to revalidate image optimization content without increasing latency for your users"
---
render_with_liquid: false
render_with_liquid: false

Nov 20, 2025

2025 年 11 月 20 日

![Purge CDN Cache by Source Image Screenshot](images/you-can-now-invalidate-the-cdn-cache-by-providing-a-source-image-vercel/img_001.jpg)![Purge CDN Cache by Source Image Screenshot](images/you-can-now-invalidate-the-cdn-cache-by-providing-a-source-image-vercel/img_002.jpg)

![按源图像清除 CDN 缓存截图](images/you-can-now-invalidate-the-cdn-cache-by-providing-a-source-image-vercel/img_001.jpg)![按源图像清除 CDN 缓存截图](images/you-can-now-invalidate-the-cdn-cache-by-providing-a-source-image-vercel/img_002.jpg)

Vercel [Image Optimization](https://vercel.com/docs/image-optimization) dynamically transforms source images to reduce file size while maintaining high quality on the visitor's browser.

Vercel [图像优化](https://vercel.com/docs/image-optimization) 可动态转换源图像，在确保访客浏览器中图像高质量显示的同时，显著减小文件体积。

You can now invalidate the CDN cache by providing a source image.

现在，您可通过提供源图像来使 CDN 缓存失效。

This feature marks all transformed images derived from that source image as stale. The next request serves stale content instantly while revalidation happens in the background, with no latency impact for users.

该功能会将所有由该源图像生成的已转换图像标记为“过期”。下一次请求将立即返回过期内容，同时在后台异步执行重新验证，全程对用户无任何延迟影响。

There are several ways to invalidate a source image:

有多种方式可使源图像失效：

- [Dashboard Settings](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)

- [控制台设置](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)

- [Vercel CLI](https://vercel.com/docs/cli/cache)

- [Vercel CLI](https://vercel.com/docs/cli/cache)

- [Function API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebysrcimage)

- [函数 API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebysrcimage)

- [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache/invalidate-by-source-image)

- [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache/invalidate-by-source-image)

In addition to invalidating by source image, you can also delete by source image if the origin is gone. Deleting the cache can increase latency while new content is generated, or cause downtime if your origin is unresponsive. We recommend you use with caution.

除了通过源图像使缓存失效外，如果源站已不可用，您还可以通过源图像直接删除缓存。删除缓存可能导致新内容生成期间延迟增加，或者在源站无响应时引发服务中断。我们建议您谨慎使用此功能。

This is available on all plans using the [new image optimization price](https://vercel.com/changelog/faster-transformations-and-reduced-pricing-for-image-optimization).

此功能在所有套餐中均可用，采用[新版图像优化定价](https://vercel.com/changelog/faster-transformations-and-reduced-pricing-for-image-optimization)。

Learn more about [cache invalidation](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache).

了解更多关于[缓存失效](https://vercel.com/docs/edge-cache/purge#manually-purging-vercel-cache)的信息。