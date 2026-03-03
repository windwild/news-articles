---
title: "Incremental Static Regeneration (ISR) is now faster and more cost-efficient - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/incremental-static-regeneration-is-now-faster-and-cheaper"
date: "2025-01-30"
scraped_at: "2026-03-02T09:37:06.238302730+00:00"
language: "en"
translated: false
description: "Incremental Static Regeneration (ISR) now faster and cheaper on Vercel. Writes to the ISR cache are now compressed by default, and the ISR cache location is now available in all regions and "
---




Jan 30, 2025

[Incremental Static Regeneration (ISR)](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content) enables you to update content in the background without needing to redeploying your application. You can scale CMS or content-backed applications to millions of pages without having slow builds.

We've optimized our infrastructure to make ISR faster and more cost-efficient:

- **Smaller writes**: ISR cache writes are now compressed by default, using fewer ISR write and read units (8KB chunks) per update and lowering Fast Origin Transfer (FOT) costs. Both reads and writes are now compressed.

- **Region-aware caching**: The ISR cache is now available in all regions and automatically aligns with your functions' region. If your project spans multiple regions, the most cost-effective location is chosen automatically. This improves performance, especially for traffic outside North America, and regional pricing applies.


Redeploy your project to apply these updates or learn more about [ISR](https://vercel.com/docs/incremental-static-regeneration).

_Update: The rollout of this change completed on February 5th, 2025 around 8am PST._