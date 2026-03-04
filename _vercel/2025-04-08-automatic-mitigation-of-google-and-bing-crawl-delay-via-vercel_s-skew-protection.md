---
title: "Automatic mitigation of Google and Bing crawl delay, via Vercel’s Skew Protection - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-mitigation-of-crawler-delay-via-skew-protection"
date: "2025-04-08"
scraped_at: "2026-03-02T09:35:18.686022731+00:00"
language: "en-zh"
translated: true
description: "The maximum age for Skew Protection is now extended to 60 days for requests coming from web crawlers such as Googlebot or Bingbot."
---

render_with_liquid: false
Apr 8, 2025

2025 年 4 月 8 日

Google 和 Bing 的网络爬虫会不定期抓取某个文档，但通常需延迟数周才通过无头浏览器（headless browser）对其进行渲染。这种“文档抓取”与“资源下载”（发生在渲染阶段）之间的时间差，可能导致索引失败——尤其当网站在被抓取后已重新部署时。

**Vercel 现已为启用 [Skew Protection](https://vercel.com/docs/skew-protection) 的项目自动防范此类索引失败问题。**

该能力通过一项关键改进实现：针对 Googlebot、Bingbot 等主流搜索引擎爬虫发起的请求，将 Skew Protection 的资源最大缓存有效期延长至 60 天。这意味着：即使您的静态资源是在 60 天前部署的，在搜索引擎渲染您的网页时，这些资源仍可被正常访问。

无论控制台中配置的最大缓存有效期为何值，所有启用 Skew Protection 的 Pro 与 Enterprise 计划账户均将自动获得此项保护，从而提升 SEO 效果。

了解更多关于 [Skew Protection](https://vercel.com/docs/skew-protection) 的信息，并[在您的项目中启用它](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fadvanced%23skew-protection&title=Enable+Skew+Protection)。此外，欢迎阅读我们的[SEO 研究报告《Google 在整个索引过程中如何处理 JavaScript》](https://vercel.com/blog/how-google-handles-javascript-throughout-the-indexing-process)，深入解析搜索引擎的渲染机制。