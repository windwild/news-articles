---
title: "Helly Hansen migrated to Vercel and drove 80% Black Friday growth  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth"
date: "2025-09-15"
scraped_at: "2026-03-02T09:28:34.910845430+00:00"
language: "en-zh"
translated: true
description: "The 150-year-old Norwegian brand leveraged Next.js and Vercel to achieve 154% Black Friday growth and 30%+ conversion lift while competing against industry titans in a crowded space"
---

Sep 15, 2025

2025年9月15日

The 150-year-old Norwegian brand leveraged Next.js and Vercel to achieve 30%+ conversion lift while competing against industry titans

这家拥有150年历史的挪威品牌借助 Next.js 和 Vercel，成功将转化率提升超30%，在与行业巨头的竞争中脱颖而出。

Founded in 1877, Helly Hansen is a global leader in technical apparel, but its digital experience wasn't living up to its legacy. Operating across 38 global markets with multiple brands (including [HellyHansen.com](https://www.hellyhansen.com/), [HHWorkwear.com](https://www.hhworkwear.com/), and [Musto.com](https://www.musto.com/)), the company was being held back by an outdated tech stack that slowed site speeds and frustrated customers.

成立于1877年的 Helly Hansen 是专业户外服饰领域的全球领导者，但其数字用户体验却未能匹配其悠久的品牌传承。公司业务覆盖全球38个市场，旗下运营多个品牌（包括 [HellyHansen.com](https://www.hellyhansen.com/)、[HHWorkwear.com](https://www.hhworkwear.com/) 和 [Musto.com](https://www.musto.com/)），然而陈旧的技术栈严重拖慢网站加载速度，令顾客倍感沮丧。

Through an incremental migration to Next.js and Vercel, Helly Hansen improved Core Web Vitals from red to green, increased developer agility, and delivered a record-breaking Black Friday Cyber Monday, building a foundation for future innovation.

通过分阶段、渐进式地迁移到 Next.js 和 Vercel，Helly Hansen 将核心网页指标（Core Web Vitals）从“红色”（不合格）全面提升至“绿色”（达标），显著提升了开发团队的敏捷性，并打造出破纪录的“黑色星期五—网络星期一”大促表现，为未来持续创新奠定了坚实基础。

![](images/helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth-vercel/img_001.jpg)

Helly Hansen saw 80% year-over-year growth on Black Friday Cyber Monday with zero downtime after migrating to Next.js and Vercel.

迁移至 Next.js 和 Vercel 后，Helly Hansen 在“黑色星期五—网络星期一”期间实现同比增长80%，且全程零宕机。

## Core performance issues destroying customer experience

## 摧毁客户体验的核心性能问题

Helly Hansen's performance issues stemmed from its architecture. The Adobe Commerce PWA relied on client-side rendering for personalization and A/B testing, triggering heavy scripts on every load. This blocked rendering and caused major layout shifts.

Helly Hansen 的性能问题源于其技术架构：基于 Adobe Commerce 构建的渐进式 Web 应用（PWA）依赖客户端渲染（CSR）来实现个性化推荐与 A/B 测试，导致每次页面加载均需执行大量重型脚本，进而阻塞页面渲染并引发严重的布局偏移（Layout Shift）。

The impact was severe: Core Web Vitals failed across the board, load times exceeded 4 seconds, and Cumulative Layout Shift spiked above 2.8. These issues degraded customer experience, hurt conversion on marketing spend, and jeopardized peak revenue events like Black Friday Cyber Monday.

影响极为严重：所有核心网页指标（Core Web Vitals）全面不达标；页面加载时间超过4秒；累积布局偏移（Cumulative Layout Shift, CLS）飙升至2.8以上。这些问题严重损害了用户体验，削弱了营销投入的转化效果，并危及“黑色星期五—网络星期一”等关键营收高峰节点。

### Incremental migration starting with checkout

### 从结账流程入手的渐进式迁移

Helly Hansen took an [incremental migration approach with Vercel](https://vercel.com/blog/incremental-migrations), proving value step by step instead of risking a single high-stakes launch. Working closely with our professional services team, they first completed an architecture review to define the optimal rendering and caching strategy.

Helly Hansen 采用了一种[与 Vercel 协同的渐进式迁移策略](https://vercel.com/blog/incremental-migrations)，通过分步验证价值，而非孤注一掷地进行一次高风险的整体上线。他们与我们的专业服务团队紧密协作，首先完成了一次架构评审，以明确最优的渲染与缓存策略。

The team chose to begin with checkout pages rather than the homepage, isolating their most critical conversion point while avoiding disruption to complex marketing attribution systems. Using server-side experimentation, they A/B tested different checkout flows in real-time. [The Vercel CDN](https://vercel.com/docs/cdn) ensured these critical pages loaded quickly for customers worldwide, while [Vercel Functions](https://vercel.com/docs/functions) ensured automatic scaling during traffic spikes.

团队选择从结算页（checkout pages）入手，而非首页——此举既聚焦于其最关键的转化环节，又避免了对复杂的营销归因系统造成干扰。借助服务端实验（server-side experimentation），他们实时对不同的结算流程进行了 A/B 测试。[Vercel CDN](https://vercel.com/docs/cdn) 确保这些关键页面能快速加载，为全球用户提供流畅体验；而 [Vercel Functions](https://vercel.com/docs/functions) 则在流量激增期间实现自动弹性伸缩。

### From red to green Core Web Vitals

### 核心网页指标（Core Web Vitals）：从全红到全绿

The biggest technical change was moving from client-side to server-side rendering using Vercel's Edge Network. This directly addressed the root cause of their performance issues. Within five months, their Core Web Vitals transformed from all red to all green across every metric.

最大的技术变革是利用 Vercel 的边缘网络（Edge Network），将渲染方式从客户端渲染（CSR）转向服务端渲染（SSR）。这一转变直接解决了其性能问题的根本成因。仅用五个月时间，其所有核心网页指标（Core Web Vitals）便从全部“不达标”（红色）跃升至全部“达标”（绿色）。

- **Load times** dropped from over 4 seconds to a consistent 1.8–2 seconds  
- **Cumulative Layout Shift** was virtually eliminated  

- **页面加载时间** 从超过 4 秒降至稳定在 1.8–2 秒之间  
- **累积布局偏移（CLS）** 几乎被完全消除  

By focusing the initial migration on a single part of the customer journey, Helly Hansen could precisely measure Next.js impact. Through [Vercel Web Analytics](https://vercel.com/docs/analytics), load times, conversion rates, and Core Web Vitals became quantifiable proof points that generated the evidence needed to justify continued investment and proceed with global rollout in under six months.

通过将初期迁移聚焦于客户旅程中的单一环节，Helly Hansen 能够精准衡量 Next.js 带来的实际影响。借助 [Vercel Web Analytics](https://vercel.com/docs/analytics)，页面加载时间、转化率及核心网页指标均转化为可量化的实证数据——这些证据有力支撑了后续持续投入的决策，并推动项目在不到六个月的时间内完成全球范围的上线部署。

![LCP improved by 30% immediately after launch by moving off Adobe Commerce's PWA to Next.js and Vercel](images/helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth-vercel/img_002.jpg)![LCP improved by 30% immediately after launch by moving off Adobe Commerce's PWA to Next.js and Vercel](images/helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth-vercel/img_003.jpg)

![将 Adobe Commerce 的 PWA 迁移至 Next.js 和 Vercel 后，LCP 在上线后立即提升 30%](images/helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth-vercel/img_002.jpg)![将 Adobe Commerce 的 PWA 迁移至 Next.js 和 Vercel 后，LCP 在上线后立即提升 30%](images/helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth-vercel/img_003.jpg)

LCP improved by 30% immediately after launch by moving off Adobe Commerce's PWA to Next.js and Vercel  

将 Adobe Commerce 的 PWA 迁移至 Next.js 和 Vercel 后，最大内容绘制（LCP）在上线后立即提升了 30%。

## Black Friday instability threatening peak revenue

## 黑色星期五期间系统不稳定，危及全年营收峰值

Q4 represents 55% of annual revenue for this seasonal outdoor business, making Black Friday Cyber Monday a high-stress, high-risk event. Pre-Vercel Black Fridays meant high stress, maintenance issues, and frequent site outages during their most critical revenue period.

Q4 占该季节性户外业务全年营收的 55%，使得“黑色星期五—网络星期一”（Black Friday Cyber Monday）成为压力巨大、风险极高的关键节点。在迁移到 Vercel 之前，每逢黑色星期五，团队都承受巨大压力，频繁遭遇运维问题和网站宕机，而此时恰恰是其营收最关键的时期。

### Leveraging Next.js and Vercel's performance and reliability infrastructure

### 借力 Next.js 与 Vercel 的高性能、高可靠性基础设施

Next.js automatically optimized product data and pricing information by leveraging [Vercel Data Cache](https://vercel.com/docs/edge-cache), while [Incremental Static Regeneration (ISR)](https://vercel.com/docs/incremental-static-regeneration) and cache shielding protected performance at the most critical moments, maintaining consistently strong web performance even during peak traffic.

Next.js 借助 [Vercel 数据缓存（Vercel Data Cache）](https://vercel.com/docs/edge-cache)，自动优化商品数据与价格信息；同时，借助 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/incremental-static-regeneration) 和缓存防护（cache shielding），在最关键的时刻保障性能稳定，即使在流量峰值期间，网站也能持续保持优异的响应表现。

Hosting on Vercel delivered the performance and stability to transform Black Friday from a high-stress event into a growth opportunity. When the team identified third-party scripts slowing the site during Black Friday, they executed a low-risk deploy to hard-code a fix during a code freeze, a move impossible on their old platform.

部署于 Vercel 平台，为业务带来了所需的性能与稳定性，成功将黑色星期五从一场高压危机转变为增长契机。当团队发现第三方脚本拖慢了黑色星期五期间的网站加载速度时，他们得以在代码冻结期执行一次低风险部署，通过硬编码方式快速修复问题——这在原有平台根本无法实现。

### Record-breaking Black Friday performance

### 创纪录的黑色星期五表现

The site's speed instantly recovered, securing a record-breaking sales period with:

网站速度瞬间恢复，助力达成破纪录的销售业绩，具体表现为：

- **80% year-over-year growth** with zero downtime  
- **同比增长 80%**，且全程零宕机  

- **2x lift in conversion rates**, allowing them to increase their marketing spend mid-campaign three times because it was so profitable  
- **转化率提升 2 倍**，使其得以在营销活动进行中三次追加投放预算——只因效果实在太好  

> “Conversion was so high because the site was so fast. During Black Friday, we increased our performance marketing spend three times because it was so profitable.Conversion was so high because the site was so fast. During Black Friday, we increased our performance marketing spend three times because it was so profitable.”
>
> “转化率之所以如此之高，正是因为网站加载速度极快。黑色星期五期间，我们三次追加了效果类营销投放预算——只因回报实在太过可观。”
>
> ![](images/helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth-vercel/img_004.jpg)
>
> **Anshika Jain - Chief Digital Officer**  
>
> **安希卡·贾因（Anshika Jain）——首席数字官**

This ability to scale marketing spend in real-time turned their high-performing site into a growth engine, bringing peace of mind, structured planning, and zero major issues.

这种实时扩大营销投入的能力，将高性能网站真正转化为强劲的增长引擎，不仅带来从容安心的运营体验、更科学的规划节奏，也彻底杜绝了重大故障的发生。

## Limited development velocity and experimentation capabilities

## 开发速度与实验能力受限

The old platform severely limited testing velocity, allowing only one A/B test per month. This constrained their ability to optimize the customer experience and respond quickly to market demands.

旧平台严重限制了测试速度，每月仅能运行一次 A/B 测试。这制约了他们优化客户体验及快速响应市场需求的能力。

### Building a modern, API-first foundation

### 构建现代化、以 API 为先的基础架构

By migrating to Next.js and Vercel, Helly Hansen established a modern, API-first foundation for their ecommerce platform. This transition to server-side rendering (SSR) enabled them to launch a full-scale server-side testing program with [feature flags](https://vercel.com/docs/feature-flags) to continuously optimize the customer experience.

通过迁移到 Next.js 和 Vercel，Helly Hansen 为其电商平台构建了一套现代化、以 API 为先的基础架构。此次向服务端渲染（SSR）的转型，使他们得以启动覆盖全栈的服务端测试计划，并借助 [功能开关（feature flags）](https://vercel.com/docs/feature-flags)，持续优化客户体验。

With this high-performance infrastructure in place, they improved developer velocity and deployed [**Constructor.io**](http://constructor.io/) to drive personalization in just 11 weeks.

在此高性能基础设施就绪后，团队显著提升了开发效率，并仅用 11 周便完成 [**Constructor.io**](http://constructor.io/) 的集成与部署，以驱动个性化体验。

### Accelerated growth and innovation

### 增长与创新加速

The team increased their testing velocity dramatically, running 5-6 A/B tests per sprint compared to just one per month previously. This modern foundation delivered:

团队将测试速度大幅提升，每个迭代周期可运行 5–6 次 A/B 测试，远超此前每月仅 1 次的水平。这一现代化基础架构带来了以下成果：

- **21% ecommerce growth** while others in the industry remained flat  
- 行业整体增长停滞之际，电商营收实现 **21% 的增长**

- Highly personalized customer experience at near-zero latency within a year of launch  
- 上线一年内即实现近乎零延迟的高度个性化客户体验

- Proof that speed and personalization can coexist without compromise  
- 验证了“速度”与“个性化”可并行不悖，无需任何取舍

## Leadership advice for CDOs and CTOs

## 面向首席数字官与首席技术官的领导力建议

Reflecting on the project, CDO of Helly Hansen, Anshika Jain offered advice for other Chief Digital Officers and Chief Technical Officers considering a digital transformation:

回顾该项目，Helly Hansen 首席数字官 Anshika Jain 为其他正考虑开展数字化转型的首席数字官（CDO）和首席技术官（CTO）提供了如下建议：

- **"Prioritize speed as your foundation"**\- Speed is a gift that never stops giving. Faster experiences not only convert better, they unlock personalization, experimentation, and rapid feature delivery. Vercel isn’t the finish line; it’s the starting point. Invest early in infrastructure that guarantees fast, reliable experiences

- **“以速度为基石”**——速度是一份永不枯竭的馈赠。更快的用户体验不仅能提升转化率，更能释放个性化、A/B 实验与功能快速交付的能力。Vercel 并非终点，而是起点。请尽早投资于能保障高速、稳定体验的基础设施。

- **“Test, learn, and scale”-** Don’t swing for the fences on day one. Use small, data-driven experiments to prove value, build momentum, and de-risk larger transformations. Scaling is easier, and more defensible when you have evidence in hand

- **“先验证、再学习、后规模化”**——切勿在第一天就追求一鸣惊人。应通过小规模、数据驱动的实验来验证价值、积累势能，并降低大规模转型的风险。当你手握实证依据时，规模化将更轻松，也更具说服力。

- **“Embrace change as the norm rather than the exception”-** Change isn’t a phase, it’s the new operating system. Organize for agility, expect resistance, and make adaptability muscle memory. The winners are those who normalize rapid response to constant change

- **“将变革视作常态，而非例外”**——变革并非一个阶段，而是全新的操作系统。组织架构需面向敏捷性而设计，要预见到阻力的存在，并将适应能力内化为本能反应。最终胜出者，正是那些能将“快速响应持续变化”视为日常的团队。

> “It's not that you won't fail. It's more about who's in it with you. And it has always felt like that with Vercel. That's the hallmark of a true partnership. It's not that you won't fail. It's more about who's in it with you. And it has always felt like that with Vercel. That's the hallmark of a true partnership. ”
>
> “失败不可避免；关键在于谁与你并肩同行。与 Vercel 的合作始终让我有此感受——这正是真正伙伴关系的标志。失败不可避免；关键在于谁与你并肩同行。与 Vercel 的合作始终让我有此感受——这正是真正伙伴关系的标志。”
>
> ![](images/helly-hansen-migrated-to-vercel-and-drove-80-black-friday-growth-vercel/img_004.jpg)
>
> **Anshika Jain,** Chief Digital Officer  
>
> **Anshika Jain**，首席数字官

By partnering with Vercel, Helly Hansen has not only solved its immediate performance challenges but has built a performant, scalable, and future-proof foundation that allows them to innovate and outperform their competition for years to come.

通过与 Vercel 合作，Helly Hansen 不仅解决了当下的性能瓶颈，更构建起一套高性能、可扩展且面向未来的技术基础架构，使其在未来多年中持续创新，并持续领先于竞争对手。

[**Interested in going headless?**\\
【是否考虑采用无头架构？】  
\\
Wherever you are in your headless migration journey, we can help. Talk to our team of experts about modernizing your ecommerce stack with Vercel.\\
无论您正处于无头迁移旅程的哪个阶段，我们都能提供支持。欢迎联系 Vercel 专家团队，共同探讨如何借助 Vercel 实现电商技术栈的现代化升级。  
\\