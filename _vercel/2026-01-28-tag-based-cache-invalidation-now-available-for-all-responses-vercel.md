---
render_with_liquid: false
title: "Tag-based cache invalidation now available for all responses - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/tag-based-cache-invalidation-now-available-for-all-responses"
date: "2026-01-28"
scraped_at: "2026-03-02T10:48:05.752940947+00:00"
language: "en-zh"
translated: true
description: "Cached responses can now assign a comma separated list of cache tags using the Vercel-Cache-Tag header. We recommend using the Vercel-Cache-Tag header for caching with external backends or for framewo..."
---
render_with_liquid: false
render_with_liquid: false

Jan 28, 2026

2026 年 1 月 28 日

Vercel 的 CDN 现已支持基于标签的缓存失效（tag-based cache invalidation），让您能够跨所有框架和后端，对缓存内容实施细粒度控制。

现在，响应可通过 `Vercel-Cache-Tag` 响应头进行标记，该头值为以英文逗号分隔的标签列表；这是一种全新的缓存组织机制，可用于将相关联的内容归组，并在内容变更时统一使其失效，而无需仅靠清空整个缓存来应对更新。

该功能是对现有缓存响应头（如 `Cache-Control`、`CDN-Cache-Control` 和 `Vercel-CDN-Cache-Control`）的有力补充，并将 Next.js 增量静态再生（ISR）所依赖的底层缓存技术，开放给任意框架或后端使用。

我们建议 Next.js 应用继续使用 [增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration#differences-between-isr-and-cache-control-headers)，以获得开箱即用的缓存标签与失效能力，无需手动管理缓存响应头。

## 工作原理

## 工作原理

当响应被赋予缓存标签后，您可通过以下任一方式使其失效：[控制台设置](https://vercel.com/docs/cdn-cache/purge#manually-purging-vercel-cdn-cache)、[Vercel CLI](https://vercel.com/docs/cli/cache)、[函数 API](https://vercel.com/docs/functions/functions-api-reference/vercel-functions-package#invalidatebytag)，或 [REST API](https://vercel.com/docs/rest-api/reference/endpoints/edge-cache)。

Vercel 的 CDN 会读取 `Vercel-Cache-Tag` 头，并在将响应发送至客户端前将其移除。若您通过 [重写（rewrites）](https://vercel.com/docs/rewrites) 将父 [项目](https://vercel.com/docs/projects) 的请求转发至子项目，且这两个项目同属于一个 [团队（team）](https://vercel.com/docs/accounts)，则父项目中缓存的响应也将自动包含子项目所指定的对应缓存标签。

该功能自今日起已在所有套餐中免费提供，不收取额外费用。欲了解详情，请参阅 [缓存失效文档](https://vercel.com/docs/cdn-cache/purge)。