---
title: "Near-zero latency using Vercel Edge Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/edge-functions-enable-read-cv-to-deliver-profiles-globally-with-near-zero"
date: "2023-01-13"
scraped_at: "2026-03-02T09:57:04.664254747+00:00"
language: "en-zh"
translated: true
description: "For Read.cv, showing is better than telling. The professional networking platform helps users add a more personal touch to the typical work profile—all made possible with Vercel and Edge Functions."
---
&#123;% raw %}

Jan 13, 2023

2023 年 1 月 13 日

Enhance user experience through application performance.

通过应用性能提升用户体验。

For Read.cv, showing is better than telling. The professional networking platform helps users add a more personal touch to the typical work profile—all made possible with Vercel and [Edge Functions](https://vercel.com/docs/functions).

对 Read.cv 而言，“展示胜于描述”。这一职业社交平台帮助用户为常规的职业档案增添更具个人特色的元素——这一切都依托于 Vercel 及其 [Edge Functions（边缘函数）](https://vercel.com/docs/functions) 实现。

An important component to the Read.cv app is allowing users to bring custom domains to the service, but to do so, the Read.cv team was considering making different deploys for each domain—an unsustainable practice. Engineers regularly made tweaks to the site’s core infrastructure while balancing high-priority work like building new features and improving user experience.

允许用户将自定义域名接入服务，是 Read.cv 应用的一项重要功能。但此前，Read.cv 团队曾考虑为每个域名单独部署——这显然不可持续。工程师们在持续优化网站核心基础设施的同时，还需兼顾高优先级任务，例如开发新功能和提升用户体验。

Moving to Vercel allowed them to incrementally adopt Next.js (moving from Create React App) for better performance and increased flexibility:

迁移到 Vercel 后，团队得以逐步采用 Next.js（从 Create React App 迁移而来），从而获得更优的性能与更高的灵活性：

- **Better performance:** Edge Functions allow Read.cv to deliver personalized content from a location close to their users, decreasing latency.

- **更优的性能：** Edge Functions 使 Read.cv 能够从靠近用户的边缘节点交付个性化内容，显著降低延迟。

- **Increased flexibility:** Read.cv was able to use the right tool for each job, with some pages served directly from the edge and others pre-generated as static assets ahead of time—all within the same toolkit of Next.js and Vercel.

- **更高的灵活性：** Read.cv 能针对不同场景选用最合适的工具——部分页面直接由边缘节点动态提供，另一些则提前预生成为静态资源——全部均在同一套 Next.js 与 Vercel 工具链中完成。

Plus, Vercel’s support for wildcard domains, automatic SSL cert generation, and management of DNS gave them the ability to create a multi-tenant platform. This meant users can bring their own personal domains to Read.cv and display their CV profile on their domain, with no custom infrastructure required.

此外，Vercel 对通配符域名（wildcard domains）的支持、自动 SSL 证书签发，以及 DNS 管理能力，使 Read.cv 能够构建一个真正的多租户平台。这意味着用户可将自己的个人域名接入 Read.cv，并在其自有域名下直接展示简历档案，全程无需任何定制化基础设施。

Not only is Read.cv benefitting from personalization at the Edge and [easy-to-manage multitenancy](https://github.com/vercel/platforms), but Vercel has also improved their site performance and Time to First Byte or TTFB.

Read.cv 不仅受益于边缘侧的个性化能力与 [易于管理的多租户架构](https://github.com/vercel/platforms)，Vercel 还显著提升了其网站性能与首字节时间（Time to First Byte，TTFB）。

**“We have a global customer base and it’s important to us that our speed is unbiased regardless of location. When we deploy with Vercel, users around the world are instantly served our latest site at an edge near them. With our previous provider, visitors were often being served from an edge in the U.S. even if they were in Asia or Europe.” — Mehdi Mulani, Software Engineer, Read.cv**

**“我们的客户遍布全球，因此确保访问速度不受地域影响至关重要。使用 Vercel 部署后，世界各地的用户都能即时从就近的边缘节点加载我们最新的网站。而此前使用的供应商，即便用户身处亚洲或欧洲，也常常被路由至美国的边缘节点。” — Mehdi Mulani，软件工程师，Read.cv**

If customization is critical to your site or application, let’s talk about how Edge Functions can give you the power of dynamic at the speed of static. [Reach out for more information here.](https://vercel.com/contact)

如果定制化对您的网站或应用程序至关重要，欢迎与我们探讨：Edge Functions 如何让您以静态内容的速度，获得动态内容的强大能力。[点击此处获取更多信息。](https://vercel.com/contact)
&#123;% endraw %}
