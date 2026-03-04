---
title: "How Plex 6x their impressions deploying Next.js on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-plex-6x-their-impressions-deploying-next-js-on-vercel"
date: "2023-01-26"
scraped_at: "2026-03-02T09:56:46.553824639+00:00"
language: "en-zh"
translated: true
description: "Plex customer story"
---
{% raw %}

Jan 26, 2023

2023 年 1 月 26 日

Plex 是一个电视平台，提供全天候（24/7）直播与点播内容，涵盖动作片、喜剧、电影、新闻等各类节目。

#### 79 → 90

其“真实体验得分”（Real Experience Score）显著提升

#### 5 分钟

即可将 Vercel 接入 GitHub 代码仓库

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Web Analytics

网页分析

Routing Middleware

路由中间件

CDN Cache

CDN 缓存

Environment Variables

环境变量

Firewall

防火墙

In 2021 they set out to create a new unified foundation to build their web experiences for years to come.

2021 年，他们着手构建一个全新的统一基础架构，以支撑未来多年的网页体验建设。

With the goal of prioritizing user experience, Plex leveraged Next.js native optimizations like [Server-side rendering](https://vercel.com/docs/concepts/next.js/overview#server-side-rendering-ssr) (SSR) pages, on-demand [Incremental Static Regeneration](https://vercel.com/docs/build-output-api/v3#features/on-demand-incremental-static-regeneration-isr) (ISR), and [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware), ultimately improving their Google search ranking and increasing traffic after the relaunch.

为优先保障用户体验，Plex 充分利用了 Next.js 原生优化能力，包括 [服务端渲染（SSR）](https://vercel.com/docs/concepts/next.js/overview#server-side-rendering-ssr) 页面、按需 [增量静态再生（ISR）](https://vercel.com/docs/build-output-api/v3#features/on-demand-incremental-static-regeneration-isr)，以及 [边缘中间件（Edge Middleware）](https://vercel.com/docs/concepts/functions/edge-middleware)，最终在网站重新上线后显著提升了 Google 搜索排名与流量。

Their site, [watch.plex.tv](http://watch.plex.tv/), was originally deployed on Kubernetes auto-scaling clusters. While the performance met their business requirements, the developer experience led to wasted resources and headaches. By refactoring their site to Next.js on Vercel, Plex **decreased the number of lines in their codebase by roughly 40%, making it faster to develop new features.**

他们的网站 [watch.plex.tv](http://watch.plex.tv/) 最初部署在 Kubernetes 自动扩缩容集群上。尽管性能满足业务需求，但糟糕的开发者体验却导致资源浪费与开发困扰。通过将网站重构为基于 Vercel 的 Next.js 应用，Plex **将代码库行数减少了约 40%，从而显著加快了新功能的开发速度。**

> “Vercel had us immediately impressed. In less than 5 minutes, we had Vercel hooked into our GitHub repository with an integration that felt polished. Vercel had us immediately impressed. In less than 5 minutes, we had Vercel hooked into our GitHub repository with an integration that felt polished. ”
>
> > “Vercel 甫一亮相便令我们印象深刻。不到 5 分钟，我们就成功将 Vercel 接入 GitHub 仓库——整个集成流程流畅而精致。”
>
> ![](images/how-plex-6x-their-impressions-deploying-next_js-on-vercel-vercel/img_001.png)
>
> **Eric Matthys,** Principal Software Engineer
>
> **Eric Matthys**，首席软件工程师

And with the ability to serve content at the edge, Plex decreased page load times: amplifying their impressions and upgrading developer experience.

凭借边缘内容分发能力，Plex 显著缩短了页面加载时间：不仅大幅提升了曝光量，也全面升级了开发者体验。

### Improved DX leads to improved SEO

### 开发者体验（DX）提升 → 搜索引擎优化（SEO）提升

- **Less configuring, more product.** Plex used to manage a dense build configuration with difficult migrations—but now they lean on Next.js’ graceful, non-breaking adoption patterns.

- **减少配置，专注产品。** Plex 过去需维护一套复杂且难以迁移的构建配置；如今则依托 Next.js 温和、向后兼容的渐进式采用模式。

- **Hybrid rendering with Next.js.** They use Static Generation for maximum performance _without_ sacrificing the benefits of Server-side Rendering. The Plex team found that SSR maximizes crawlability (like [hard 404 responses](https://developers.google.com/search/docs/advanced/crawling/http-network-errors#soft-404-errors)) so they use it as a tool to improve SEO.

- **Next.js 混合渲染。** 他们采用静态生成（Static Generation）以实现极致性能，同时又不牺牲服务端渲染（Server-side Rendering, SSR）的优势。Plex 团队发现，SSR 能最大程度提升搜索引擎爬虫的可抓取性（例如 [硬性 404 响应](https://developers.google.com/search/docs/advanced/crawling/http-network-errors#soft-404-errors)），因此将其作为一项关键工具来优化 SEO。

- **Personalize wherever possible.** [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) allowed them to serve different content based on the geographical availability of titles. Additionally, they were able to run and track [A/B tests](https://vercel.com/templates/next.js/ab-testing-simple) for static pages without creating Cumulative Layout Shift or increasing page load times.

- **尽可能实现个性化。** 借助 [Edge Middleware（边缘中间件）](https://vercel.com/docs/concepts/functions/edge-middleware)，他们可根据影视内容在不同地区的可用性，向用户动态提供差异化内容。此外，他们还能对静态页面开展并跟踪 [A/B 测试](https://vercel.com/templates/next.js/ab-testing-simple)，且完全避免了累积布局偏移（Cumulative Layout Shift）或页面加载时间增加的问题。

- **Ship confidently with integrations.** [Vercel’s Checkly integration](https://vercel.com/integrations/checkly) enabled end-to-end tests when making any updates across the platform. The team also used the [Axiom integration](https://vercel.com/integrations/axiom) to monitor crawl requests immediately, removing the four-day delay that is observed through Google Search’s own crawl stats and giving quick feedback as changes are made.

- **依托集成能力，自信交付。** [Vercel 的 Checkly 集成](https://vercel.com/integrations/checkly) 支持在平台任意更新时自动执行端到端测试。团队还通过 [Axiom 集成](https://vercel.com/integrations/axiom) 实现了对爬虫请求的实时监控，彻底消除了依赖 Google Search 自有爬取统计所导致的长达四天的数据延迟，从而在每次变更后都能快速获得反馈。

- **Faster data propagation with ISR.** Generating pages for millions of movies, shows, and cast members can be costly. Changes to metadata, catalog availability, or images need to be picked up quickly by the site and shown to site visitors. If a new movie becomes available to stream at a certain time, Plex needs users to see it immediately.

- **借助增量静态再生（ISR）加速数据传播。** 为数以百万计的电影、剧集及演职人员生成页面成本高昂。元数据、目录可用性或图片等任何变更，都需被网站迅速捕获并即时呈现给访问者。例如，若某部新电影在特定时刻上线可播，Plex 必须确保用户能即刻看到它。

“We use on-demand ISR to balance these by increasing the revalidate time of our static pages while allowing our backend to revalidate these pages on demand as important changes happen. This reduces the time spent rebuilding pages that did not have any meaningful changes.” — Eric Matthys, Principal Software Engineer

“我们采用按需 ISR（on-demand ISR）来实现上述平衡：一方面延长静态页面的 `revalidate` 时间以减少重建频次；另一方面，当发生重要变更时，允许后端按需主动触发页面重新验证。此举显著减少了对未发生实质性变更页面的重建耗时。”——Eric Matthys，首席软件工程师

By using Vercel to provide not only a great developer experience but also a great end user experience, the Plex team continues to deliver fast and climb the Google search ranking.

借助 Vercel，Plex 团队不仅获得了卓越的开发者体验，更保障了终端用户的优质体验，持续交付高性能网站，并稳步提升其在 Google 搜索结果中的排名。

Want to see how your frontend team can improve your site's experience? [Get in touch](https://vercel.com/contact).

您的前端团队如何进一步提升网站用户体验？欢迎[联系我们](https://vercel.com/contact)。

Customer case study  
客户案例研究  

Feb 10, 2023  
2023 年 2 月 10 日  

### Runway enables next-generation content creation with AI and Vercel  

### Runway 借助 AI 与 Vercel 实现下一代内容创作

![](images/how-plex-6x-their-impressions-deploying-next_js-on-vercel-vercel/img_002.jpg)![](images/how-plex-6x-their-impressions-deploying-next_js-on-vercel-vercel/img_003.jpg)

Kiana and Steven

客户案例研究

2023年3月31日

### 借助 Vercel 应对票务发售期间的大幅流量激增

![](images/how-plex-6x-their-impressions-deploying-next_js-on-vercel-vercel/img_002.jpg)

Kiana Lewis
{% endraw %}
