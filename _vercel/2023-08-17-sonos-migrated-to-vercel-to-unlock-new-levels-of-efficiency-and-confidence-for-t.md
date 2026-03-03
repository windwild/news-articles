---
title: "Sonos migrated to Vercel to unlock new levels of efficiency and confidence for their developers. - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-sonos-amplified-their-devex"
date: "2023-08-17"
scraped_at: "2026-03-02T09:51:11.688373299+00:00"
language: "en-zh"
translated: true
description: "By switching to Vercel, Sonos leveled up their headless Next.js stack, cutting build times by 75%."
---

Aug 17, 2023

2023年8月17日

Learn how Sonos improved build times, saved developer time, and optimized their digital presence by migrating to Next.js and Vercel.

了解 Sonos 如何通过迁移到 Next.js 和 Vercel，显著缩短构建时间、节省开发者时间，并优化其数字业务表现。

#### 75%

Improvement in build times

#### 75%

构建时间提升幅度

#### 10%

Improvement in performance scores

#### 10%

性能评分提升幅度

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Next.js

Next.js

Routing Middleware

路由中间件

Monitoring

监控

Comments

评论

Preview Deployments

预览部署

Web Analytics

网页分析

ISR

增量静态再生（Incremental Static Regeneration）

As the world’s leading sound experience company with a 20-year legacy of innovation and over 3,000 patents, [Sonos](https://www.sonos.com/) understands the importance of a robust digital presence that reflects the brand’s cutting-edge ethos.

作为全球领先的音效体验公司，Sonos 拥有长达 20 年的创新历史和逾 3,000 项专利，深刻理解一个强大、稳健的数字形象对于彰显品牌前沿精神的重要性。

However, for years, the high costs and slow builds of their web infrastructure hindered developers from making critical site updates. The solution: a transition to a headless, composable architecture using Vercel and Next.js.

然而多年来，其网站基础设施高昂的运维成本与缓慢的构建速度，严重阻碍了开发人员及时完成关键的网站更新。解决方案是：采用基于 Vercel 和 Next.js 的无头（headless）、可组合式架构进行重构。

The switch resulted in a remarkable 75% improvement in build times, empowering developers to innovate with ease and confidence.

此次转型带来了构建时间高达 75% 的显著提升，使开发人员得以更轻松、更自信地开展创新工作。

> “It’s just a pity we didn’t go sooner. Next.js and Vercel make our developers happier, make us go to market quicker, and let us move with confidence. It’s just a pity we didn’t go sooner. Next.js and Vercel make our developers happier, make us go to market quicker, and let us move with confidence. ”
>
> “真遗憾我们没有更早迈出这一步。Next.js 与 Vercel 让我们的开发人员更快乐，让我们更快地推向市场，也让我们更有信心地快速迭代。”
>
> ![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_001.png)
>
> **Jonathan Lemon,** Software Engineering Manager at Sonos
>
> **乔纳森·莱蒙（Jonathan Lemon）**，Sonos 软件工程经理

## Going headless with Next.js

## 借助 Next.js 实现无头架构

When Sonos' Brand team envisioned a fresh take on their website, developers recognized that relying solely on Salesforce Commerce Cloud would be too constraining and limit their ability to maintain performance. The team needed more frontend flexibility to express the brand's vision while optimizing for SEO and performance metrics.

当 Sonos 品牌团队构想其网站的全新面貌时，开发人员意识到，仅依赖 Salesforce Commerce Cloud 将过于受限，难以持续保障性能表现。团队需要更强的前端灵活性，以充分呈现品牌愿景，同时优化搜索引擎优化（SEO）与各项性能指标。

> “Next.js really suits the ecommerce world; it gives you the flexibility to build on the server or the client, to choose how you want to build. It's a really great fit, and when you tie in a CMS like Sanity, they go hand-in-hand.Next.js really suits the ecommerce world; it gives you the flexibility to build on the server or the client, to choose how you want to build. It's a really great fit, and when you tie in a CMS like Sanity, they go hand-in-hand.”
>
> “Next.js 非常契合电商领域；它赋予你灵活选择在服务端或客户端构建的能力，让你自由决定开发方式。它确实是极佳的选择——而当你将其与 Sanity 这类 CMS 集成时，二者更是相得益彰。”
>
> ![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_001.png)
>
> **Jonathan Lemon,** Software Engineering Manager at Sonos
>
> **Jonathan Lemon**，Sonos 软件工程经理

Switching to open-source Next.js as a part of their headless solution also allowed the team to fully migrate while avoiding lock-in with a single service provider. This would prove crucial in Sonos’ journey.

将开源的 Next.js 作为其无头架构（headless solution）的一部分进行切换，还使团队得以完成全面迁移，同时避免被单一服务商锁定。这一决策在 Sonos 的演进之路上被证明至关重要。

## Removing friction for better DX

## 降低开发体验（DX）摩擦，提升效率

Initially, the team attempted to build a CI/CD, global edge, and caching system to self-host their refactored Next.js application. However, after creating a proof-of-concept in AWS, they realized this would be more of a time and maintenance commitment than they were willing to make.

起初，团队曾尝试自行构建一套 CI/CD 流水线、全球边缘网络及缓存系统，以托管重构后的 Next.js 应用。然而，在 AWS 上完成概念验证（proof-of-concept）后，他们意识到这将带来远超预期的时间投入与长期运维负担。

Their previous solution led to several points of friction, including:

此前的方案带来了诸多开发摩擦点，包括：

- **Build Times:** The team was experiencing 20 minute builds for each environment. This meant for every preview, and then again for every production build, each developer hit friction points  
- **构建耗时：** 团队在每个环境中的构建均需耗时约 20 分钟。这意味着每次预览构建、以及随后的每次生产环境构建，每位开发者都会遭遇明显的效率瓶颈。

- **Next.js Support:** The previous solution did not support Next.js 12 or 13 at the time of migration, which meant the team couldn’t adopt new features like [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware). Features like [Incremental Static Regeneration](https://vercel.com/docs/concepts/incremental-static-regeneration) (ISR) were also not supported, forcing the team to hand-roll their own infrastructure  
- **Next.js 版本支持：** 迁移当时，原有方案尚不支持 Next.js 12 或 13，导致团队无法采用诸如 [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) 等新特性；[增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration) 等功能亦未获支持，迫使团队不得不自行搭建底层基础设施。

- **Cache Management:** Issues with cache busting between preview and production led to recurring 307 (temporary redirect) errors, due to constant rebuilding of pages in AWS CloudFront  
- **缓存管理：** 预览环境与生产环境之间存在缓存失效（cache busting）问题，导致 AWS CloudFront 中页面频繁重建，反复触发 HTTP 307（临时重定向）错误。

- **Observability and Debugging:** Debugging and [monitoring](https://vercel.com/docs/concepts/observability/monitoring) was a constant struggle for the team, as information was spread across multiple products  
- **可观测性与调试：** 调试与 [监控（monitoring）](https://vercel.com/docs/concepts/observability/monitoring) 对团队而言始终是一大挑战——相关日志与指标分散于多个平台，缺乏统一视图。

> “We were wasting the equivalent of an entire year's worth of a developer’s time chasing down and fixing the constant errors.  
> 我们耗费了相当于一名开发者整整一年的时间，反复排查和修复层出不穷的错误。”

> ![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_001.png)

> **Jonathan Lemon**, Software Engineering Manager at Sonos  
> **Jonathan Lemon**，Sonos 软件工程经理

## **Incremental migration to Vercel**  
## **分阶段迁移到 Vercel**

Sonos 需要一个更完整、更统一的前端云（Frontend Cloud）体验，并具备更强的 [monorepo](https://vercel.com/docs/concepts/monorepos) 支持能力，以帮助其开发团队提升交付速度。因此，他们选择了打造并持续开发 Next.js 的平台——Vercel。

> “We needed a quality product for a quality product. We evaluated other options, but really Vercel was a no-brainer. We wanted to make sure we didn’t cut any corners.  
> 我们需要一款高品质的产品来支撑我们自己的高品质产品。我们评估过其他方案，但 Vercel 显然是不二之选——这根本无需犹豫。我们希望确保在迁移过程中不走捷径、不降低标准。”

> ![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_001.png)

> **Jonathan Lemon**, Software Engineering Manager at Sonos  
> **Jonathan Lemon**，Sonos 软件工程经理

在接下来的三个月内，Sonos 将十余个网站资产迁移至 Vercel，包括主站首页、订阅页面、帮助文档（helpsheets）以及产品使用指南。整个迁移过程无缝顺畅，团队迅速体会到 Vercel [Preview Deployments（预览部署）](https://vercel.com/features/previews) 带来的显著优势。

![Sonos' migration path (from top-left to bottom-right) ended with 75% faster build times on a feature-complete Vercel.](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_005.jpg)  
![Sonos' migration path (from top-left to bottom-right) ended with 75% faster build times on a feature-complete Vercel.](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_006.jpg)  
Sonos 的迁移路径（从左上角到右下角）最终实现了功能完备的 Vercel 平台下构建耗时**降低 75%**。

> “Once we got the GitHub connection set up, all we needed to do was move the environment variables over and cut over the DNS. We were able to use Preview Deployments to see it all working—it was all really straightforward. Even on launch day it just worked great. We all got on the call, we switched over, and it was done.  
> 一旦配置好 GitHub 连接，我们只需迁移环境变量并切换 DNS 解析即可。我们借助 Preview Deployments 实时验证全部功能——整个过程极为简洁直观。甚至在正式上线当天，一切也运行得无比顺利：我们全员接入会议，完成切换，迁移即告完成。”

> ![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_001.png)

> **Jonathan Lemon**, Software Engineering Manager at Sonos  
> **Jonathan Lemon**，Sonos 软件工程经理

Vercel 的前端云能力助力 Sonos 大幅提速：**构建时间从 20 分钟缩短至仅需 5 分钟**。此外，外包人员与新团队的上手周期显著缩短，反馈闭环也大幅加快——团队充分利用 Vercel 为每一次 Git 提交自动生成的协作式 Preview Deployments。

团队还借助 Vercel 内置的日志系统与 [Web Analytics（网页分析）](https://vercel.com/docs/concepts/analytics)，获得了更清晰的站点可观测性，并据此绘制出性能提升曲线：**整体性能提升 10%，移动端 Lighthouse 评分跃升至 90 分**。

或许最重要的是，团队在 Vercel 上开展的压力测试未发现任何问题；即便在节日期间遭遇海量用户涌入，网站性能也始终保持稳定，毫无衰减。

\
通过产品导览、试用或个性化演示，亲身体验 Vercel 的强大功能。  
\
[探索产品](https://vercel.com/try-enterprise)

## **黑色星期五及之后的销售旺季**

迁移工作完成后，Sonos 以全新的信心迎接高流量的假日购物季，其中包括至关重要的“黑色星期五”销售期。Vercel 平台为其提供了所需的稳定性与可扩展性，确保客户获得无缝流畅的体验。

> “能够实时追踪性能指标和日志，这一点意义重大。我非常喜欢看到所有数据，并能直接对日志进行查询。过去我们查找日志简直是一场噩梦——因为之前的解决方案只是大量其他产品的‘外壳’而已。能够实时追踪性能指标和日志，这一点意义重大。我非常喜欢看到所有数据，并能直接对日志进行查询。过去我们查找日志简直是一场噩梦——因为之前的解决方案只是大量其他产品的‘外壳’而已。”  
>  
> ![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_001.png)  
>  
> **Jonathan Lemon**，Sonos 软件工程经理

Vercel 提供的预览环境（Preview Environment）与 Pull Request（PR）集成流程，显著提升了开发工作流效率，为团队营造了协作高效的新环境。开发者可在已部署的环境中即时验证代码变更效果，而评审人员也能在代码审查过程中轻松访问预览构建版本。这一新流程直接带来了 **更高品质的代码** 和 **更短的产品上市周期**。

> “日常开发中，你随时都能获得预览构建版本；你立刻就能看到改动在已部署环境中是否正常运行。团队对此充满信心：只要它在预览环境中运行无误，上线后也必然稳定可靠。这使得 PR 流程和整体开发流程变得更轻松、更优质、更可靠。日常开发中，你随时都能获得预览构建版本；你立刻就能看到改动在已部署环境中是否正常运行。团队对此充满信心：只要它在预览环境中运行无误，上线后也必然稳定可靠。”  
>  
> ![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_001.png)  
>  
> **Jonathan Lemon**，Sonos 软件工程经理

Sonos 迁移至 Vercel，为其公司释放了全新层级的创新力、运营效率与技术信心。Next.js 与 Vercel 的强强联合，使 Sonos 能够充分展现品牌愿景、优化数字平台表现，并为全球用户交付卓越的数字体验。

回顾整个迁移历程，团队内部共识明确：迁移到 Vercel 是完全正确的决定；唯一的遗憾，就是没有更早做出这一转变。如今，Vercel 已成为 Sonos 的核心开发平台，助力其持续引领音频技术行业，并向全球用户交付非凡的产品体验。

[**立即安全启程**  
\\  
我们的专家可为您团队的独特需求量身定制 Vercel 解决方案。  
\\  
联系我们](https://vercel.com/contact/sales)

博客文章

Feb 23, 2023

2023年2月23日

### The Next.js SEO Playbook: Ranking higher with Next.js on Vercel

### Next.js SEO 实战指南：在 Vercel 上使用 Next.js 实现更高搜索排名

![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_010.jpg)![](images/sonos-migrated-to-vercel-to-unlock-new-levels-of-efficiency-and-confidence-for-t/img_011.jpg)

Alice and Thom

Alice 和 Thom

Vercel.com landing page

Vercel.com 官网首页

### Learn more about Vercel Preview Deployments

### 了解更多关于 Vercel 预览部署的信息