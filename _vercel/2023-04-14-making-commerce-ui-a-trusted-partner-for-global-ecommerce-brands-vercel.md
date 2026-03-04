---
title: "Making Commerce-UI a trusted partner for global ecommerce brands - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/making-commerce-ui-a-trusted-partner-for-global-ecommerce-brands"
date: "2023-04-14"
scraped_at: "2026-03-02T09:53:23.050821042+00:00"
language: "en-zh"
translated: true
description: "commerce ui"
---
{% raw %}

Apr 14, 2023

2023年4月14日

[Commerce-UI](https://commerce-ui.com/) is a boutique agency focused on composable eCommerce that specializes in creating optimized, performant experiences for design-driven brands. Thanks to Next.js and Vercel, they’re able to help clients—like viral sensation Lift Foils—discover headless commerce, while providing a seamless shopping experience to users around the world.

[Commerce-UI](https://commerce-ui.com/) 是一家专注于可组合式电子商务（composable eCommerce）的精品代理机构，专精于为注重设计的品牌打造优化、高性能的用户体验。得益于 Next.js 和 Vercel，他们成功帮助客户——例如走红全球的水上电动冲浪板品牌 Lift Foils——迈入无头电商（headless commerce）领域，同时为全球用户提供了流畅无缝的购物体验。

### Providing performance

### 性能保障

The team at Commerce-UI understands the importance of site speed (and maintaining that site speed) for eCommerce websites, especially when they’re packed with images, videos, and other multimedia. This is where Vercel comes in, keeping their sites fast and responsive even when rendering heavy content.

Commerce-UI 团队深知网站加载速度（以及持续维持该速度）对电子商务网站至关重要——尤其当页面充斥着大量图片、视频及其他多媒体内容时。此时，Vercel 的价值便凸显出来：它确保网站即使在渲染高负载内容时依然保持高速与响应灵敏。

Many Commerce-UI clients start with Wordpress or custom PHP, but quickly find these technologies hinder growth when they want to start serving more personalized experiences. As modern eCommerce demands reliable and maintainable solutions, CTO Michal Wolczecki-Klim asserts, "it wouldn't be possible to build a sustainable system using their old technologies."  Plus, they needed to invest in maintaining a full DevOps team to serve their old sites. For a solution that can handle the infrastructure for both dynamic and static content, they recommend Next.js and Vercel as the perfect performant pair.

许多 Commerce-UI 客户最初采用 WordPress 或自定义 PHP 构建网站，但很快发现这些技术在需要提供更个性化体验时严重制约业务增长。正如现代电子商务所要求的那样，解决方案必须兼具可靠性与可维护性。CTO Michal Wolczecki-Klim 明确指出：“使用原有技术根本无法构建可持续的系统。”此外，他们还需投入资源组建并维护一支完整的 DevOps 团队来支撑旧有站点。而 Next.js 与 Vercel 的组合，则完美满足了动态与静态内容基础设施的双重需求，成为他们力荐的高性能搭档。

### Managing scale on a viral level

### 应对病毒式传播带来的规模化挑战

One of Commerce-UI’s biggest success stories is the global brand Lift Foils, which needed a solution for expanding into new regions quickly after it went viral and doubled site traffic overnight. Using [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware), Commerce-UI was able to help Lift Foils create dedicated pages for each region, which were then localized and personalized. This allowed Lift Foils to provide a fast and seamless experience for their customers everywhere, even during traffic spikes of 200%.

Commerce-UI 最成功的案例之一是全球品牌 Lift Foils。该品牌在一夜爆红后，网站流量翻倍，亟需快速拓展至新市场。借助 [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware)，Commerce-UI 协助 Lift Foils 为每个目标区域创建专属页面，并完成本地化与个性化适配。这使得 Lift Foils 能够在全球范围内为顾客提供快速、流畅的体验，即便遭遇高达 200% 的流量激增亦能从容应对。

And it’s not just Commerce-UI that gets the benefits of Vercel and Next.js: their clients do too. That means with features like [Incremental Static Regeneration](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) (ISR), Commerce-UI’s team and their users can easily create or update content without having to redeploy their site. All while maintaining strong Core Web Vitals and keeping metrics like Cumulative Layout Shift at zero.

受益于 Vercel 和 Next.js 的，不仅有 Commerce-UI 自身，还有其客户。这意味着借助 [增量静态再生](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)（ISR）等功能，Commerce-UI 团队及其客户均可轻松创建或更新内容，而无需重新部署整个网站。与此同时，网站仍能保持优异的核心网页指标（Core Web Vitals），并将累积布局偏移（Cumulative Layout Shift）等关键性能指标稳定控制在零值。

> “ISR is vital for building our ecommerce sites in terms of performance and stability. Being able to first statically build all sites and spot some potential bugs is a win. It’s a non-complex and reliable system for us.ISR is vital for building our ecommerce sites in terms of performance and stability. Being able to first statically build all sites and spot some potential bugs is a win. It’s a non-complex and reliable system for us.”
>
> > “对于构建我们的电商平台而言，ISR 在性能与稳定性方面至关重要。能够首先以静态方式构建全部站点，并借此提前发现潜在缺陷，是一大优势。对我们而言，这是一个结构简洁、高度可靠的系统。”
>
> ![](images/making-commerce-ui-a-trusted-partner-for-global-ecommerce-brands-vercel/img_001.png)
>
> ![](images/making-commerce-ui-a-trusted-partner-for-global-ecommerce-brands-vercel/img_001.png)
>
> **Michal Wolczecki-Klim CTO**
>
> **Michal Wolczecki-Klim，CTO**

### **Improving the developer experience**

### **提升开发者体验**

But Commerce-UI isn’t only concerned with providing their clients with a seamless experience—they want to make sure their developers are taken care of, too.

但 Commerce-UI 关注的并不仅仅是为客户提供无缝体验——他们同样希望确保开发者的需求也得到充分关照。

From [Preview Deployments](https://vercel.com/features/previews), which make it simple to collaborate with stakeholders to building webhooks that trigger a site rebuild when, say, Shopify configurations change, Vercel makes sharing work across teams simple, decreases time to production, and offers out-of-the-box support for modern tech stacks.

借助 [预览部署（Preview Deployments）](https://vercel.com/features/previews) 功能——例如，当 Shopify 配置发生变化时，可轻松协同相关方构建触发网站重建的 Webhook——Vercel 简化了跨团队协作流程，缩短了上线时间，并原生支持各类现代技术栈。

All of this makes the developer experience better, which keeps the whole system running smoothly, whether a site is just launching or becoming an overnight viral sensation.

所有这些举措共同提升了开发者体验，从而保障整个系统平稳运行——无论网站正处于上线初期，还是突然爆红、流量激增。

Want to learn more about improving your team's developer experience? [Reach out to our sales team today](https://vercel.com/contact/sales).

想进一步了解如何提升您团队的开发者体验？[立即联系我们的销售团队](https://vercel.com/contact/sales)。
{% endraw %}
