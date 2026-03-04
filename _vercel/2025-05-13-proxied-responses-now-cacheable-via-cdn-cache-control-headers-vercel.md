---
title: "Proxied responses now cacheable via CDN-Cache-Control headers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/proxied-responses-now-cacheable-via-cdn-cache-control-headers"
date: "2025-05-13"
scraped_at: "2026-03-02T09:33:24.475600578+00:00"
language: "en-zh"
translated: true
description: "Vercel's CDN now supports CDN-Cache-Control headers for external backends, giving you simple, powerful caching control without any configuration changes."
---
{% raw %}

May 13, 2025

2025 年 5 月 13 日

![](images/proxied-responses-now-cacheable-via-cdn-cache-control-headers-vercel/img_001.jpg)![](images/proxied-responses-now-cacheable-via-cdn-cache-control-headers-vercel/img_002.jpg)

Vercel’s CDN, which can proxy requests to external backends, now caches proxied responses using the `CDN-Cache-Control` and `Vercel-CDN-Cache-Control` headers. This aligns caching behavior for external backends with how Vercel Functions are already cached.

Vercel 的 CDN 支持将请求代理至外部后端，现可通过 `CDN-Cache-Control` 和 `Vercel-CDN-Cache-Control` 响应头缓存代理响应。此举使外部后端的缓存行为与 Vercel Functions 当前的缓存机制保持一致。

This is available starting today, on all plans, at no additional cost.

该功能自今日起对所有套餐免费开放，无需额外费用。

Per the Targeted HTTP Cache Control spec ( [RFC 9213](https://httpwg.org/specs/rfc9213.html)), these headers support standard directives like `max-age` and `stale-while-revalidate`, enabling fine-grained control over CDN caching without affecting browser caches.

依据《定向 HTTP 缓存控制规范》（[RFC 9213](https://httpwg.org/specs/rfc9213.html)），这些响应头支持 `max-age`、`stale-while-revalidate` 等标准指令，可在不影响浏览器缓存的前提下，实现对 CDN 缓存行为的精细化控制。

You can return the headers directly from your backend, or define them in `vercel.json` under the `headers` key if your backend can't be modified.

您可直接从后端返回这些响应头；若后端无法修改，也可在 `vercel.json` 文件的 `headers` 字段中进行定义。

No configuration changes or redeployments required. Return the header (or set it in `vercel.json`) to improve performance, reduce origin load, and ensure fresh content.

无需更改任何配置，也无需重新部署。只需返回对应响应头（或在 `vercel.json` 中设置），即可提升性能、降低源站负载，并确保内容始终新鲜。

Learn more about [CDN-Cache-Control headers](https://vercel.com/docs/rewrites#caching-external-rewrites).

了解更多关于 [CDN-Cache-Control 响应头](https://vercel.com/docs/rewrites#caching-external-rewrites) 的信息。
{% endraw %}
