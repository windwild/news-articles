---
title: "ISR on Vercel is now faster and more cost-efficient - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/isr-on-vercel-is-now-faster-and-more-cost-efficient"
date: "2025-01-30"
scraped_at: "2026-03-02T09:37:09.210084677+00:00"
language: "en-zh"
translated: true
description: "We've optimized how ISR cache updates are managed on Vercel, making them faster and more cost-efficient. "
---
{% raw %}

Jan 30, 2025

2025 年 1 月 30 日

When [Next.js introduced Incremental Static Regeneration (ISR)](https://nextjs.org/blog/next-9-4) in 2020, it changed how developers build for the web. ISR combines the speed of static generation with the flexibility of dynamic rendering, enabling sites to update content without requiring full rebuilds.

2020 年，当 [Next.js 首次推出增量静态再生（Incremental Static Regeneration，ISR）](https://nextjs.org/blog/next-9-4) 时，它彻底改变了开发者构建 Web 应用的方式。ISR 将静态生成的速度优势与动态渲染的灵活性相结合，使网站无需完整重建即可更新内容。

Vercel has supported ISR from day one, making it easy for teams at [The Washington Post](https://vercel.com/blog/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news), [Algolia](https://vercel.com/blog/algolia-cuts-build-times-in-half-with-isr-using-next-js-on-vercel), and [Sonos](https://vercel.com/blog/how-sonos-amplified-their-devex) to serve fresh content while keeping page loads fast.

Vercel 自 ISR 推出首日便提供原生支持，助力 [《华盛顿邮报》](https://vercel.com/blog/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news)、[Algolia](https://vercel.com/blog/algolia-cuts-build-times-in-half-with-isr-using-next-js-on-vercel) 和 [Sonos](https://vercel.com/blog/how-sonos-amplified-their-devex) 等团队在保障页面加载速度的同时，高效交付最新内容。

Now, we’ve optimized how ISR cache updates work, leading to:

现在，我们已全面优化 ISR 缓存更新机制，带来以下改进：

- Faster revalidations with lower Time to First Byte (TTFB)

- 更快的重新验证，显著降低首字节时间（Time to First Byte，TTFB）

- More efficient cache updates, reducing compute overhead

- 更高效的缓存更新，降低计算资源开销

- Greater cost efficiency, with up to 65% savings on ISR reads and writes

- 更高的成本效益，ISR 读写操作最高可节省 65% 的费用

These improvements require no configuration changes—just redeploy to get the benefits.

上述改进无需任何配置变更——只需重新部署，即可立即享受全部优化效果。

## What’s new: Faster, more efficient ISR

## 新特性：更快、更高效的 ISR

Vercel has been continuously improving our support for ISR since it was first introduced. Our latest updates focus on speed and cost efficiency, with two major improvements:

自 ISR 首次发布以来，Vercel 持续增强对其的支持。本次最新更新聚焦于性能提速与成本优化，包含两大关键改进：

### Faster: Regionalized caching

### 更快：区域化缓存

ISR cache entries are now stored in the same region as your functions, meaning:

ISR 缓存条目现在与其对应函数部署在同一地理区域，这意味着：

- Lower latency for cache retrieval

- 缓存读取延迟更低

- Faster revalidations when regenerating content

- 内容重新生成时的重新验证速度更快

- Better performance for global users, especially those outside North America

- 全球用户（尤其是北美以外地区用户）的整体性能更优

Regionalized ISR improves TTFB latency by up to 80% when an ISR cache read occurs within the same geographic area. These improvements are especially visible for those outside the United States.

区域化 ISR 可将首字节时间（TTFB）延迟最多降低 80%（当 ISR 缓存读取发生在同一地理区域内时）。这些性能提升在美利坚合众国以外的地区尤为显著。

### More cost-efficient: Automatic compression

### 更具成本效益：自动压缩

We’ve enabled **automatic compression** for ISR cache entries, reducing:

我们已为 ISR 缓存条目启用 **自动压缩** 功能，从而减少：

- ISR write units

- ISR 写入单元用量

- ISR read units

- ISR 读取单元用量

- Fast Origin Transfer (FOT) costs

- 快速源站传输（FOT）费用


This can reduce ISR spend by up to 65%, making ISR more efficient and affordable for high-traffic applications.

这可将 ISR 成本降低高达 65%，从而让 ISR 在高流量应用中更高效、更具成本效益。

## Why ISR: Balancing speed and freshness

## 为何选择 ISR：在速度与内容新鲜度之间取得平衡

ISR was designed to adapt the benefits of Static Site Generation (SSG) to a dynamic web. SSG is great for site performance. By pre-building pages at deploy time, static sites load instantly and scale effortlessly. But for large sites—especially ecommerce stores, media platforms, and marketplaces—SSG creates bottlenecks:

ISR 的设计初衷是将静态站点生成（SSG）的优势适配到动态 Web 环境中。SSG 对站点性能极为有利：通过在部署时预先构建页面，静态站点可实现瞬时加载并轻松扩展。但对于大型网站——尤其是电商平台、媒体平台和在线市场——SSG 会带来以下瓶颈：

- Slow builds: Rebuilding thousands of pages every time content updates is inefficient.

- 构建缓慢：每次内容更新都需重建成千上万的页面，效率低下。

- Outdated content: Static sites serve stale pages until the next deploy.

- 内容过期：静态站点在下一次部署前持续提供陈旧页面。

- Complex cache management: Manually configuring cache headers adds operational overhead.

- 缓存管理复杂：手动配置缓存头会增加运维负担。

ISR solves this by enabling on-demand content updates, preserving the speed of static pages without requiring full rebuilds.

ISR 通过支持按需内容更新来解决上述问题，在无需完整重建的前提下，保留了静态页面的加载速度。

### How ISR works

### ISR 的工作原理

Instead of regenerating every page at build time, ISR updates pages only when needed. Here’s what happens behind the scenes:

ISR 并非在构建时重新生成所有页面，而仅在需要时更新相应页面。其背后的工作机制如下：

1. 用户请求一个页面。如果该页面已被缓存，Vercel 会立即提供该页面——无需额外计算资源。

2. 如果缓存已过期（stale），Vercel 将在后台触发页面再生（regeneration），同时继续向用户返回缓存中的旧版本。

3. 一旦新版本生成完成，它将自动替换旧缓存，确保后续访问者获取到最新内容。

On Vercel, this all happens through [framework-defined Infrastructure (FDI)](https://vercel.com/blog/framework-defined-infrastructure).  
在 Vercel 上，上述全部流程均通过 [框架定义的基础设施（Framework-Defined Infrastructure，FDI）](https://vercel.com/blog/framework-defined-infrastructure) 实现。

If the [frontend framework you are using supports ISR](https://vercel.com/docs/frameworks/more-frameworks#frameworks-infrastructure-support-matrix), then there’s no additional infrastructure configuration required beyond the caching behavior specified in your framework code.  
如果你所使用的前端框架[支持增量静态再生（ISR）](https://vercel.com/docs/frameworks/more-frameworks#frameworks-infrastructure-support-matrix)，那么除在框架代码中声明的缓存行为外，无需进行任何额外的基础设施配置。

You can get the performance benefits of serving cached static content while updating dynamic data in the background, all without needing to specify complex cache control headers.  
你既能享受缓存静态内容带来的高性能优势，又可在后台异步更新动态数据——整个过程无需手动设置复杂的缓存控制（Cache-Control）响应头。

![Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_001.jpg)![Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_002.jpg)![Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_003.jpg)![Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_004.jpg)Vercel Edge Cache automatically stores static assets and dynamic responses based on your framework code, removing the need for manual configuration and management.  
![Vercel Edge Cache 自动根据你的框架代码缓存静态资源和动态响应，无需手动配置与管理。](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_001.jpg)![Vercel Edge Cache 自动根据你的框架代码缓存静态资源和动态响应，无需手动配置与管理。](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_002.jpg)![Vercel Edge Cache 自动根据你的框架代码缓存静态资源和动态响应，无需手动配置与管理。](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_003.jpg)![Vercel Edge Cache 自动根据你的框架代码缓存静态资源和动态响应，无需手动配置与管理。](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_004.jpg)Vercel Edge Cache 自动根据你的框架代码缓存静态资源和动态响应，无需手动配置与管理。

This reduces build times, eliminates downtime, and automates content freshness. Whether it’s a breaking news article, an out-of-stock product, or a trending blog post, ISR ensures users always get the latest version without slowing down your site.  
这显著缩短构建时间、彻底消除停机窗口，并自动保障内容时效性。无论是突发新闻报道、售罄商品信息，还是热门博客文章，ISR 均可确保用户始终获得最新版本，且完全不影响网站加载速度。

Common use cases for ISR include:  
ISR 的典型应用场景包括：

- Ecommerce: Keep product listings, stock levels, and pricing up to date.  
- 电商：实时同步商品列表、库存数量与价格信息。

- Media and publishing: Update articles in real-time without full redeploys.  
- 媒体与出版：无需全站重新部署，即可实时更新文章内容。

- Marketplaces and directories: Refresh listings dynamically while keeping page loads fast.  
- 市场平台与目录类网站：在保持页面极速加载的同时，动态刷新条目列表。

- Dashboards and analytics: Serve near-real-time data efficiently.  
- 仪表板与数据分析：高效提供近实时数据。

## What’s next  

## 下一步

We’re continuing to make ISR easier to use, more performant, and cost effective for our customers. We’re also working on addressing feedback from the community on how to improve ISR and improve the developer experience with hybrid rendering strategies, with advancements such as [Partial Prerendering (PPR)](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model).  

我们正持续优化增量静态再生（ISR），使其对客户而言更易用、性能更强、成本效益更高。同时，我们也在积极回应社区反馈，致力于改进 ISR，并通过混合渲染策略提升开发者体验，相关进展包括 [部分预渲染（Partial Prerendering, PPR）](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) 等创新。

The improvements described above are enabled automatically for all Vercel customers. To learn more about ISR, you can visit the [Vercel documentation](https://vercel.com/docs/incremental-static-regeneration), [Next.js documentation](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration), or [learn how to use ISR in real-world use cases](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content).  

上述改进已自动为所有 Vercel 客户启用。如需深入了解 ISR，欢迎查阅 [Vercel 官方文档](https://vercel.com/docs/incremental-static-regeneration)、[Next.js 官方文档](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration)，或了解 [ISR 在真实业务场景中的应用实践](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)。

These latest ISR improvements are live now for all Vercel users, just redeploy to take advantage of these improvements.  

本次最新的 ISR 改进现已面向所有 Vercel 用户正式上线——只需重新部署，即可立即享受这些优化。

Blog post  
博客文章  

Sep 16, 2024  
2024 年 9 月 16 日  

### ISR: A flexible way to cache dynamic content  

### ISR：一种灵活的动态内容缓存方案  

![](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_005.jpg)  

Alice Alexandra Moore  
爱丽丝·亚历山德拉·摩尔

Blog post

博客文章

Mar 7, 2023

2023年3月7日

### Framework-defined infrastructure

### 框架定义的基础设施

![](images/isr-on-vercel-is-now-faster-and-more-cost-efficient-vercel/img_006.jpg)

Malte Ubl

Malte Ubl
{% endraw %}
