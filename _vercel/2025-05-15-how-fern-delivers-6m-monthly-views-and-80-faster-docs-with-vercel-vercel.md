---
title: "How Fern delivers 6M+ monthly views and 80% faster docs with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel"
date: "2025-05-15"
scraped_at: "2026-03-02T09:33:19.645597035+00:00"
language: "en-zh"
translated: true
description: "Fern used Vercel and Next.js to achieve efficient multi-tenancy, faster development cycles, and 50-80% faster load times"
---

May 15, 2025

2025年5月15日

Learn how this documentation provider uses Vercel and Next.js to achieve efficient multi-tenancy, faster development cycles, and 50–80% faster load times.

了解该文档服务提供商如何借助 Vercel 和 Next.js 实现高效的多租户架构、更短的开发周期，以及页面加载速度提升 50–80%。

#### 83%

Reduction in deploy times

#### 83%

部署耗时降低

#### 3x

Faster time to first byte

#### 3 倍

首字节时间（TTFB）缩短至原来的三分之一

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[Fern](https://buildwithfern.com/) is improving how teams build and host documentation. As a [multi-tenant platform](https://vercel.com/solutions/multi-tenant-saas), Fern enables companies like Webflow and ElevenLabs to create, customize, and serve API documentation from a single Next.js application—scaling seamlessly across multiple customer domains. With 6 million+ page views per month and 1 million+ unique visitors, performance and reliability are key.

[Fern](https://buildwithfern.com/) 正在革新团队构建与托管文档的方式。作为一款[多租户平台](https://vercel.com/solutions/multi-tenant-saas)，Fern 使 Webflow 和 ElevenLabs 等公司能够基于单一 Next.js 应用程序创建、定制并交付 API 文档，并无缝扩展至多个客户域名。平台每月页面浏览量超 600 万次，独立访客超 100 万人次，因此性能与可靠性至关重要。

By running on Vercel’s infrastructure, Fern benefits from automatic caching, optimized content delivery, and instant scalability, all while maintaining a fast iteration cycle for development. Additionally, their migration to [Next.js App Router](https://nextjs.org/docs/app) has driven a 50–80% reduction in page load times, improving navigation speed and [Lighthouse scores](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring) for customers worldwide.

依托 Vercel 的基础设施运行，Fern 可自动享受缓存优化、内容分发加速与即时弹性伸缩能力，同时保持高效的开发迭代节奏。此外，其迁移到 [Next.js App Router](https://nextjs.org/docs/app) 后，页面加载时间大幅缩短 50–80%，显著提升了全球客户的导航响应速度与 [Lighthouse 性能评分](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring)。

![Example of developer documentation built with Fern and hosted on Vercel. ](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_001.jpg)  
![使用 Fern 构建、托管于 Vercel 的开发者文档示例。](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_001.jpg)  
Example of developer documentation built with Fern and hosted on Vercel.  
使用 Fern 构建、托管于 Vercel 的开发者文档示例。

## **Building a multi-tenant platform on Vercel**

## **在 Vercel 上构建多租户平台**

Fern’s architecture is built around a single Next.js app running on Vercel, handling multi-tenant routing across various customer domains. Instead of deploying separate instances for each customer, Fern uses [Vercel Middleware](https://vercel.com/docs/edge-middleware) to dynamically route traffic, keeping infrastructure simple and efficient.

Fern 的架构围绕一个部署在 Vercel 上的单一 Next.js 应用构建，该应用负责在多个客户域名之间实现多租户路由。与为每位客户单独部署实例不同，Fern 利用 [Vercel 中间件（Edge Middleware）](https://vercel.com/docs/edge-middleware) 动态分发流量，从而保持基础设施简洁高效。

![The architecture behind prod.ferndocs.com](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_002.jpg)![The architecture behind prod.ferndocs.com](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_003.jpg)The architecture behind prod.ferndocs.com

![prod.ferndocs.com 背后的架构](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_002.jpg)![prod.ferndocs.com 背后的架构](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_003.jpg)prod.ferndocs.com 背后的架构

The team’s deployment strategy includes a main multi-tenant stack at `prod.ferndocs.com`, a performance-optimized version at `app.ferndocs.com` focused on CDN delivery, and a dedicated development environment at `dev.ferndocs.com`. With Vercel's [custom domain](https://vercel.com/docs/domains/working-with-domains/add-a-domain) support, they also give customers full control over their documentation URLs.

该团队的部署策略包括：主多租户服务部署在 `prod.ferndocs.com`；面向性能优化、专注 CDN 分发的版本部署在 `app.ferndocs.com`；以及专用于开发的环境 `dev.ferndocs.com`。借助 Vercel 的 [自定义域名（Custom Domain）](https://vercel.com/docs/domains/working-with-domains/add-a-domain) 支持，他们还赋予客户对其文档 URL 的完全控制权。

With Vercel's domain management tools, Fern supports both subdomains (docs.website.com) and subpaths (website.com/docs), enabling customers to bring their own domains with just a CNAME DNS record.

借助 Vercel 的域名管理工具，Fern 同时支持子域名（如 `docs.website.com`）和子路径（如 `website.com/docs`），客户仅需添加一条 CNAME DNS 记录，即可轻松绑定自有域名。

[**How to build a multi-tenant app with custom domains using Next.js**\\
\\
Create a full-stack application with multi-tenancy and custom domain support using Next.js App Router, Vercel Postgres, and the Vercel Domains API.\\
\\
Read the guide](https://vercel.com/guides/nextjs-multi-tenant-application)

[**如何使用 Next.js 构建支持自定义域名的多租户应用**\\
\\
使用 Next.js App Router、Vercel Postgres 和 Vercel Domains API，构建一个支持多租户与自定义域名的全栈应用。\\
\\
阅读指南](https://vercel.com/guides/nextjs-multi-tenant-application)

## **Optimized deployments for rapid iteration**

## **面向快速迭代的优化部署**

Fern used to rely on AWS Fargate to run backend services, including a critical indexing script that handled reads and writes to their database and populated Algolia. But deployment through AWS CDK came with a 30-minute feedback loop, from merge to live deploy, which made iteration painfully slow.

Fern 过去依赖 AWS Fargate 运行后端服务，其中包括一个关键的索引脚本——该脚本负责对数据库执行读写操作，并向 Algolia 推送数据。然而，通过 AWS CDK 进行部署会带来长达 30 分钟的反馈周期（从代码合并到上线部署），致使迭代过程异常缓慢。

By incrementally shifting this work to [Vercel Functions](https://vercel.com/docs/functions), Fern **cut deploy times down to five minutes** and gained the ability to test changes in preview environments before shipping to production.

通过逐步将这部分工作迁移至 [Vercel Functions](https://vercel.com/docs/functions)，Fern **将部署耗时缩短至五分钟**，并获得了在预览环境（Preview Environment）中测试变更的能力，从而确保变更在正式上线前经过充分验证。

Overall Vercel deployments have helped them:  

总体而言，Vercel 的部署能力已助力他们：

- **Deploy multiple times per day** to enabe tight feedback loops and continuous iteration

- 每天多次部署，以实现紧密的反馈循环和持续迭代

- [**Manual Promote**](https://vercel.com/docs/deployments/promoting-a-deployment) allows the team to confidently push updates to production

- [**手动发布（Manual Promote）**](https://vercel.com/docs/deployments/promoting-a-deployment) 使团队能够自信地将更新推送至生产环境

- [**Instant Rollbacks**](https://vercel.com/docs/deployments/promoting-a-deployment#instant-rollback) help avoid the impact of bugs or regressions

- [**即时回滚（Instant Rollbacks）**](https://vercel.com/docs/deployments/promoting-a-deployment#instant-rollback) 可有效规避缺陷或回归问题带来的影响

By leveraging Vercel’s monorepo support for their open-source [repo](https://github.com/fern-api/fern-platform/), Fern deploys updates across all customer sites in minutes, without managing infrastructure overhead.

借助 Vercel 对其开源 [代码仓库（repo）](https://github.com/fern-api/fern-platform/) 的单体仓库（monorepo）支持，Fern 能在几分钟内将更新部署至所有客户站点，且无需承担基础设施管理开销。

## **Enterprise-grade performance**

## **企业级性能**

For businesses, fast-loading documentation is critical. Fern’s customers choose its platform not just for the UI, but for the speed and performance advantages it inherits from Vercel’s CDN.

对业务而言，文档的快速加载至关重要。Fern 的客户选择该平台，不仅因其用户界面（UI），更因其继承自 Vercel 内容分发网络（CDN）的速度与性能优势。

Vercel delivers content globally to reduce latency, while automatic caching and [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) (ISR) ensure that documentation stays current without triggering full site rebuilds. Native video hosting adds another layer of polish to the developer experience, particularly for onboarding, by eliminating the need for third-party platforms and enabling faster, integrated playback.

Vercel 通过全球内容分发降低延迟；同时，自动缓存与 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/incremental-static-regeneration) 技术确保文档内容实时更新，而无需触发全站重建。原生视频托管功能进一步提升了开发者体验——尤其在新手引导（onboarding）环节，它消除了对第三方平台的依赖，并支持更快、更深度集成的视频播放。

## **One more thing, Next.js App Router**

## **还有一件事：Next.js App Router**

Recently, Fern successfully migrated 65% of its platform from Pages Router to App Router in just 7 days, unlocking major performance gains:

近期，Fern 仅用 7 天便成功将平台 65% 的功能从 Pages Router 迁移至 App Router，从而实现了显著的性能提升：

- **50–80% faster load times** for documentation pages

- 文档页面加载速度提升 **50–80%**

- **3x faster time to first byte** (1.63s → 0.55s at p95)

- **首字节时间提升至原来的 3 倍**（p95 延迟从 1.63 秒降至 0.55 秒）

- **React Suspense & loading.tsx** for smoother navigation

- 借助 **React Suspense 与 loading.tsx** 实现更流畅的页面导航

To validate these improvements, Fern stress-tested their API documentation platform with 6,000 simultaneous GET requests, ensuring fast, stable response times across all customer sites.

为验证上述优化效果，Fern 使用 6,000 个并发 GET 请求对其 API 文档平台进行了压力测试，确保所有客户站点均能获得快速、稳定的响应。

## **A platform built for growth**

## **专为规模化增长而构建的平台**

With 63% month-over-month growth, Fern is rapidly scaling to serve customers worldwide. Their ability to iterate quickly, handle customer-specific configurations, and optimize for performance has made them the go-to documentation platform for enterprise companies who demand speed, customization, and availability.

凭借月均 63% 的高速增长，Fern 正迅速扩展全球客户覆盖。其快速迭代能力、对客户定制化配置的支持，以及面向性能的深度优化，使其成为追求极致速度、高度可定制性与高可用性的企业级客户的首选文档平台。

> “Every single day customers ask for more features. Vercel lets us focus on shipping user-facing functionality, abstracting away the infrastructure that would otherwise slow us down. Every single day customers ask for more features. Vercel lets us focus on shipping user-facing functionality, abstracting away the infrastructure that would otherwise slow us down.”
>
> “每天都有客户提出更多功能需求。Vercel 让我们得以专注于交付面向用户的功能，将原本会拖慢开发节奏的底层基础设施抽象化处理。”
>
> ![](images/how-fern-delivers-6m-monthly-views-and-80-faster-docs-with-vercel-vercel/img_004.png)
>
> **Danny Sheridan,** Co-founder and CEO
>
> **丹尼·谢里登（Danny Sheridan）**，联合创始人兼首席执行官

By leveraging Vercel’s infrastructure, Next.js App Router, and edge caching, Fern delivers a high-performance, multi-tenant documentation experience without the complexity of managing traditional infrastructure.

通过深度整合 Vercel 基础设施、Next.js App Router 以及边缘缓存（edge caching），Fern 在无需管理传统基础设施复杂性的前提下，为多租户场景提供高性能的文档体验。

[**Talk to a web app building expert**  
\\  
Meet with a web app expert and see how your business can build better applications for your users.  
\\  
Let's Talk](https://vercel.com/contact)

[**与 Web 应用构建专家交流**  
\\  
预约一位 Web 应用专家，了解您的业务如何为用户打造更卓越的应用程序。  
\\  
立即交流](https://vercel.com/contact)