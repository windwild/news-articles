---
title: "Request collapsing for ISR cache misses - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/request-collapsing-for-isr-cache-misses"
date: "2025-09-25"
scraped_at: "2026-03-02T09:28:22.098722398+00:00"
language: "en-zh"
translated: true
description: "Vercel now does regional request collapsing on cache miss for Incremental Static Regeneration (ISR)."
---

Sep 25, 2025

2025 年 9 月 25 日

The Vercel CDN now prevents cache stampedes through [request collapsing](https://vercel.com/docs/request-collapsing) on an expired [Incremental Static Regeneration (ISR)](https://vercel.com/docs/incremental-static-regeneration) page into a single function invocation per region. Without collapsing, simultaneous requests each trigger regeneration, wasting compute and overloading backends. With collapsing, one request regenerates the page while others wait and return the cached result.

Vercel CDN 现已通过[请求合并（request collapsing）](https://vercel.com/docs/request-collapsing)，在过期的[增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration)页面上防止缓存雪崩现象——即每个区域仅触发一次函数调用。若不启用请求合并，多个并发请求将各自触发页面再生，不仅浪费计算资源，还会使后端过载；而启用后，仅由一个请求执行页面再生，其余请求则等待并直接返回已缓存的结果。

This improves reliability, reduces backend load, and saves significant compute at scale.

此举提升了系统可靠性，降低了后端负载，并在大规模部署场景下显著节省了计算资源。

The feature is applied automatically for cacheable routes. Cacheability is inferred from framework metadata, so no configuration is required.

该功能对所有可缓存路由自动生效。是否可缓存由框架元数据推断得出，因此无需任何手动配置。

Implementation details are available in the [Preventing the stampede: Request collapsing in the Vercel CDN blog post](https://vercel.com/blog/cdn-request-collapsing).

具体实现细节请参阅博客文章：[防止雪崩：Vercel CDN 中的请求合并](https://vercel.com/blog/cdn-request-collapsing)。