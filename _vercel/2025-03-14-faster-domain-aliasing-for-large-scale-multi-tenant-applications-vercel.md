---
title: "Faster domain aliasing for large-scale multi-tenant applications - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-domain-aliasing-for-large-scale-multi-tenant-applications"
date: "2025-03-14"
scraped_at: "2026-03-02T09:35:29.662244047+00:00"
language: "en-zh"
translated: true
description: "Bulk aliasing for multi-tenant applications now runs significantly faster, reducing total aliasing time by up to 95%."
---

render_with_liquid: false
Mar 14, 2025

2025年3月14日

面向多租户应用的批量别名配置（bulk aliasing）现在运行速度显著提升，整体别名配置耗时最多可减少 **95%**。

Vercel 上的多租户应用可在后台通过单个项目为众多客户同时提供服务。这类应用通常需支持数百甚至数千个域名。此前，别名配置（即把某个域名指向不同部署版本的过程）是一个缓慢的操作，会为每次部署带来显著的额外开销。

此项优化现已对所有客户正式上线，并带来了极为显著的性能提升，例如：

- **拥有 13,254 个域名的应用：** 约 10 分钟 → 28 秒  
- **拥有 23,743 个域名的应用：** 8 分 37 秒 → 26 秒  

了解更多关于 Vercel 上的[多租户应用](https://vercel.com/solutions/multi-tenant-saas)。

[**如何使用 Next.js 构建支持自定义域名的多租户应用**  
使用 Next.js App Router、Vercel Postgres 和 Vercel Domains API，构建一个支持多租户与自定义域名的全栈应用。  
阅读指南](https://vercel.com/guides/nextjs-multi-tenant-application)