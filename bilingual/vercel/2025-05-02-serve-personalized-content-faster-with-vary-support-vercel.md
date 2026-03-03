---
title: "Serve personalized content faster with Vary support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/serve-personalized-content-faster-with-vary-support"
date: "2025-05-02"
scraped_at: "2026-03-02T09:34:28.491320173+00:00"
language: "en-zh"
translated: true
description: "Vercel now supports the HTTP Vary header, enabling faster delivery of personalized, cached content based on location and language. Improve site performance and reduce compute automatically with Edge N..."
---

May 2, 2025

2025年5月2日

![](images/serve-personalized-content-faster-with-vary-support-vercel/img_001.jpg)![](images/serve-personalized-content-faster-with-vary-support-vercel/img_002.jpg)

Vercel now fully supports the HTTP `Vary` header, making it easier to cache personalized content across all plans with no configuration required.

Vercel 现已全面支持 HTTP `Vary` 响应头，无需任何配置，即可在所有套餐中更轻松地缓存个性化内容。

The `Vary` header tells caches which request headers to include when generating cache keys. This allows Vercel’s application delivery network to store and serve different versions of a page based on headers like `X-Vercel-IP-Country` or `Accept-Language`, so users get fast, localized content without recomputation.

`Vary` 响应头用于告知缓存系统：在生成缓存键（cache key）时，应将哪些请求头纳入考量。这使得 Vercel 的应用分发网络能够依据 `X-Vercel-IP-Country` 或 `Accept-Language` 等请求头，存储并分发不同版本的页面，从而让用户无需重复计算即可快速获取本地化内容。

```bash
Vary: X-Vercel-IP-Country

Cache-Control: s-maxage=60
```

```bash
Vary: X-Vercel-IP-Country

Cache-Control: s-maxage=60
```

By returning the above headers your site caches and serves country-specific content.

通过返回上述响应头，您的网站即可缓存并分发面向特定国家/地区的版本内容。

A visitor from the United States receives the US-specific cached version, and visitors from other countries receive the version for their locale, with no recomputation required.

来自美国的访问者将收到专为美国缓存的版本；而来自其他国家/地区的访问者则会收到对应其所在地区（locale）的缓存版本，全程无需重新计算。

Learn more about caching personalized content in [Vercel's application network documentation](https://vercel.com/docs/edge-network/caching).

欲了解个性化内容缓存的更多详情，请参阅 [Vercel 应用网络文档](https://vercel.com/docs/edge-network/caching)。