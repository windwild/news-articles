---
title: "Incremental Static Regeneration (ISR) is now faster and more cost-efficient - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/incremental-static-regeneration-is-now-faster-and-cheaper"
date: "2025-01-30"
scraped_at: "2026-03-02T09:37:06.238302730+00:00"
language: "en-zh"
translated: true
description: "Incremental Static Regeneration (ISR) now faster and cheaper on Vercel. Writes to the ISR cache are now compressed by default, and the ISR cache location is now available in all regions and "
---
&#123;% raw %}

Jan 30, 2025

2025 年 1 月 30 日

[Incremental Static Regeneration (ISR)](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)

[增量静态再生（ISR）](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)

enables you to update content in the background without needing to redeploying your application. You can scale CMS or content-backed applications to millions of pages without having slow builds.

使您能够在后台更新内容，而无需重新部署应用程序。您可将基于 CMS 或内容驱动的应用扩展至数百万页面，且不会导致构建速度变慢。

We've optimized our infrastructure to make ISR faster and more cost-efficient:

我们已优化基础设施，以提升 ISR 的性能并降低其使用成本：

- **Smaller writes**: ISR cache writes are now compressed by default, using fewer ISR write and read units (8KB chunks) per update and lowering Fast Origin Transfer (FOT) costs. Both reads and writes are now compressed.

- **更小的写入量**：ISR 缓存写入现已默认启用压缩，每次更新所消耗的 ISR 写入与读取单元（以 8KB 为单位）更少，从而降低了快速源站传输（Fast Origin Transfer, FOT）成本；目前读取与写入操作均已启用压缩。

- **Region-aware caching**: The ISR cache is now available in all regions and automatically aligns with your functions' region. If your project spans multiple regions, the most cost-effective location is chosen automatically. This improves performance, especially for traffic outside North America, and regional pricing applies.

- **区域感知缓存**：ISR 缓存现已在所有地域可用，并自动与您的函数所在地域保持一致。若您的项目跨多个地域部署，系统将自动选择最具成本效益的地域。此举显著提升了性能——尤其对北美以外地区的流量效果明显，且适用各区域对应的定价策略。

Redeploy your project to apply these updates or learn more about [ISR](https://vercel.com/docs/incremental-static-regeneration).

请重新部署您的项目以应用上述更新，或进一步了解 [ISR](https://vercel.com/docs/incremental-static-regeneration)。

_Update: The rollout of this change completed on February 5th, 2025 around 8am PST._

_更新：本次变更已于 2025 年 2 月 5 日上午 8 点（太平洋标准时间，PST）完成全量发布。_
&#123;% endraw %}
