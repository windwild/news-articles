---
title: "Extra Space Storage's build times became 17x faster with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/extra-space-storages-build-times-became-17x-faster-with-vercel"
date: "2024-12-11"
scraped_at: "2026-03-02T09:38:41.923898813+00:00"
language: "en-zh"
translated: true
description: "Extra Space Storage cut build times by 95% after migrating to Next.js on Vercel.   See how features like Incremental Static Regeneration and per-branch environments enable faster and more confident re..."
---
{% raw %}

Dec 11, 2024

2024 年 12 月 11 日

Next.js on Vercel 缩短了部署时间，并提升了 Extra Space Storage 网站的可靠性。

#### $1.7 Million

每日数字营收

#### 250K

每日页面浏览量

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[**Powered by** AWS](https://vercel.com/partners/aws)

[由 AWS 提供支持](https://vercel.com/partners/aws)

作为美国规模最大的自助仓储公司，[Extra Space Storage](https://www.extraspace.com/) 在全美运营超过 3,800 家门店。为客户提供一致、高质量的数字化体验至关重要；其工程团队也意识到，必须提升客户获取渠道（包括公共网站与自助服务终端）的迭代速度与系统稳定性。

然而，其传统架构正造成多重瓶颈，拖慢新功能上市节奏，制约开发效率。通过与 Vercel 合作，Extra Space Storage 成功实现了优化网站 DevOps 流程的目标，并加快了客户反馈闭环。

![Extra Space Storage's website and kiosks are hosted on Vercel, providing fast, reliable, scalable, and secure app delivery.](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_001.jpg)  
Extra Space Storage 的网站与自助服务终端（kiosks）均托管在 Vercel 上，从而实现快速、可靠、可扩展且安全的应用交付。

### Improving build times and stability with Vercel  
### 借助 Vercel 提升构建速度与系统稳定性

Before migrating to Vercel, Extra Space Storage faced challenges with the stability of their platform. The lack of reliable pre-production environments, and long developer build times all contributed to delays in delivering new features.  
在迁移到 Vercel 之前，Extra Space Storage 面临平台稳定性方面的挑战：缺乏可靠的预发布（pre-production）环境，加之开发者构建耗时过长，导致新功能上线频频延迟。

The search for a solution led them to explore Vercel, starting with smaller projects such as their kiosk platform and annual reports. These early successes built confidence in Vercel’s performance, and the team decided to move their flagship site to Vercel following the acquisition of Life Storage in 2023.  
为寻求解决方案，他们开始探索 Vercel，并率先将其应用于规模较小的项目，例如自助服务终端平台和年度报告网站。这些早期成功增强了团队对 Vercel 性能的信心；2023 年收购 Life Storage 后，团队随即决定将旗舰网站迁移至 Vercel。

> “Our success with the Life Storage site showed us how much we could gain from Vercel. Moving extraspace.com was a no-brainer.”  
> “我们在 Life Storage 网站上的成功实践，让我们充分认识到 Vercel 所能带来的巨大价值。将 extraspace.com 迁移至 Vercel 是顺理成章的决定。”

> ![](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_002.svg)  
> ![](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_002.svg)

> **Nate Green,**  Sr. Director of Software Engineering at Extra Storage Space  
> **内特·格林（Nate Green）**，Extra Space Storage 首席软件工程总监

The migration was seamless. Extra Space Storage stood up the new site on Vercel and, when ready, controlled traffic through DNS routing. There was no need to revert back to their previous environment—the Vercel platform worked from the start.  
此次迁移过程无缝顺畅。Extra Space Storage 在 Vercel 上快速搭建起新网站，并在准备就绪后通过 DNS 路由精细调控流量。整个过程中无需回退至原有环境——Vercel 平台自启动起即稳定运行。

### A lean, efficient architecture powered by Next.js and Vercel  
### 基于 Next.js 与 Vercel 构建精简高效的技术架构

Now, Extra Space Storage’s frontend architecture is streamlined with Vercel. Their Next.js application is powered by Vercel's global [Edge Network](https://vercel.com/blog/life-of-a-vercel-request-navigating-the-edge-network), and they leverage features like [Incremental Static Regeneration (ISR)](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content) for primary sales flow pages, ensuring optimal performance without constant server-side re-renders. [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) handles routing and cookies for personalization, and they use Next.js’s powerful configuration options for redirects and rewrites.  
如今，Extra Space Storage 的前端架构已全面依托 Vercel 实现精简化与高效化。其 Next.js 应用运行于 Vercel 全球 [边缘网络（Edge Network）](https://vercel.com/blog/life-of-a-vercel-request-navigating-the-edge-network) 之上；针对核心销售流程页面，他们采用 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content) 功能，在避免频繁服务端重新渲染的前提下保障极致性能；[边缘中间件（Edge Middleware）](https://vercel.com/docs/functions/edge-middleware) 则负责个性化所需的路由控制与 Cookie 管理；此外，他们还充分利用 Next.js 强大的配置能力实现重定向（redirects）与路径重写（rewrites）。

[**Understanding Vercel's infrastructure**  
**深入理解 Vercel 的基础设施**  

Learn how Vercel's framework-defined infrastructure automatically handles user traffic.  
了解 Vercel 如何依托框架定义的基础设施，自动处理用户请求流量。  

Read the blog  
阅读博客](https://vercel.com/blog/life-of-a-vercel-request-navigating-the-edge-network)

ISR has become a cornerstone of their architecture, allowing Extra Space Storage to serve pages quickly while refreshing stale content in the background. This strategy improves performance, particularly when redeploying production code.  
ISR 已成为其架构的核心支柱：它使 Extra Space Storage 能够快速响应页面请求，同时在后台异步更新陈旧内容。该策略显著提升了整体性能，尤其在生产环境代码重新部署期间效果尤为突出。

> “ISR was the most obvious feature that improved our performance, especially with production deployments.”  
> “ISR 是最显著提升我们性能的功能，尤其是在生产环境部署中。”

> ![](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_002.svg)  
> ![](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_002.svg)

**Craig Kendall,** Senior Software Engineer at Extra Space Storage  
**克雷格·肯德尔（Craig Kendall）**，Extra Space Storage 高级软件工程师

Their checkout process behaves like a single-page application, optimizing for speed and user experience where SEO isn’t a priority, while other pages maintain strict SEO standards to ensure optimal performance and search visibility.  
其结账流程采用单页应用（SPA）模式，在无需优先考虑搜索引擎优化（SEO）的场景下，专注于提升加载速度与用户体验；而其他页面则严格遵循 SEO 最佳实践，以确保卓越的性能表现和搜索可见性。

### Accelerating deployment, reducing overhead and downtime  
### 加速部署、降低开销与停机时间

Vercel’s impact on Extra Space Storage’s development workflow has been significant, with a 95% decrease in build times. With Vercel’s [per-branch environments](https://vercel.com/docs/deployments/preview-deployments), testing on branch deployments has become a seamless part of the workflow, allowing the team to test changes in isolation before merging.  
Vercel 对 Extra Space Storage 开发工作流产生了显著影响——构建时间大幅缩短了 95%。借助 Vercel 的[按分支部署环境（Per-Branch Environments）](https://vercel.com/docs/deployments/preview-deployments)，在分支上开展测试已无缝融入日常开发流程，使团队可在代码合并前独立验证各项变更。

These improvements allow Extra Space Storage to release more frequently and with confidence, improving agility and responsiveness to customer feedback.  
这些改进使 Extra Space Storage 能够更频繁、更自信地发布新版本，从而提升了研发敏捷性，并增强了对客户反馈的响应能力。

> “Testing is so much easier now. We no longer rely on shared environments, and the speed of deployments is incredible.”  
> “如今测试变得轻松多了。我们不再依赖共享环境，而且部署速度令人惊叹。”

> ![](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_002.svg)  
> ![](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_002.svg)

**Nate Green,** Sr. Director of Software Engineering at Extra Space Storage  
**内特·格林（Nate Green）**，Extra Space Storage 软件工程高级总监

The migration to Vercel has also improved site reliability and stability. With Vercel handling caching and serverless functions, Extra Space Storage can focus on delivering features without the overhead of managing complex infrastructure.  
迁移到 Vercel 还显著提升了网站的可靠性与稳定性。得益于 Vercel 对缓存机制与无服务器函数（Serverless Functions）的原生支持，Extra Space Storage 能够专注于功能交付，无需再为运维复杂基础设施而分心。

Extra Space Storage’s site sees around 250,000 page views daily and drives $1.7 million in revenue per day. With Vercel, they’re able to scale to meet this demand without worrying about performance or stability.  
Extra Space Storage 网站日均页面浏览量约 25 万次，日均营收达 170 万美元。依托 Vercel，他们可从容应对这一规模的业务增长，无需担忧性能瓶颈或系统稳定性问题。

### Looking Ahead  
### 展望未来

Extra Space Storage’s migration to Vercel has improved their development workflow and set the stage for future innovation. While they’re still exploring the full range of Vercel’s capabilities, they are excited about the potential to leverage more advanced features as their application continues to grow.  
Extra Space Storage 迁移至 Vercel 不仅优化了当前的开发工作流，更为未来的持续创新奠定了坚实基础。尽管团队仍在深入探索 Vercel 的全部能力，但他们已满怀期待——随着应用规模不断扩大，将逐步启用更多高级功能，释放更大技术潜力。

For Extra Space Storage, the journey from a self-hosted architecture to Vercel has been transformative. The platform’s ease of use, rapid deployment times, and integrated features have unlocked new efficiencies for their engineering team, allowing them to deliver a better experience for both their developers and their customers.

对于 Extra Space Storage 而言，从自托管架构迁移到 Vercel 的历程具有变革性。该平台的易用性、极快的部署速度以及深度集成的功能，为他们的工程团队释放了全新效率，使其能够为开发者和终端用户均提供更优质的体验。

Blog post

博客文章

Sep 20, 2024

2024 年 9 月 20 日

### From CDNs to Frontend Clouds

### 从 CDN 到前端云

![](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_005.jpg)![](images/extra-space-storage_s-build-times-became-17x-faster-with-vercel-vercel/img_006.jpg)

Malte and Dan

Malte 与 Dan

Blog post

博客文章

Nov 21, 2023

2023 年 11 月 21 日

### The foundations of the Frontend Cloud

### 前端云的基础

Alice Alexandra Moore

爱丽丝·亚历山德拉·摩尔
{% endraw %}
