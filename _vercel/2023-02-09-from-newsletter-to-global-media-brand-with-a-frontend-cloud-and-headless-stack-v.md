---
title: "From newsletter to global media brand with a frontend cloud and headless stack - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/from-newsletter-to-global-media-brand-with-a-headless-frontend"
date: "2023-02-09"
scraped_at: "2026-03-02T09:55:14.494735119+00:00"
language: "en-zh"
translated: true
description: "Morning brew"
---
&#123;% raw %}

Feb 9, 2023

2023 年 2 月 9 日

Morning Brew 是一家媒体品牌联合体，致力于为当代商业领袖提供最新、最必需的资讯内容。

#### 2.5 倍营收增长

前端云采用后实现

#### 100% 缓存命中率

依托 Vercel 的按需增量静态再生（ISR）功能

[Talk to an Expert](https://vercel.com/contact/sales)

[与专家交流](https://vercel.com/contact/sales)

在 Next.js 驱动其 [前端云](https://vercel.com/resources/the-frontend-cloud-advantage)、Sanity 担任其 [可组合式内容云](https://www.sanity.io/) 的技术架构下，Morning Brew 成功从一份电子邮件简报发展为全球性媒体品牌，并通过 YouTube、线下活动、播客等多元媒介拓展了全新业务线。

2021 年，公司营收达 5000 万美元，较 2020 年 2000 万美元的年营收增长逾一倍；随后被 Insider Inc.（前身为 Business Insider）收购。如今，Morning Brew 每月触达用户超 1800 万。

### 专为内容交付优化的无头技术栈

### 专为内容交付优化的无头技术栈

In 2021, Morning Brew started working with Vercel to boost a bespoke headless tech stack, focusing on content delivery for optimal UX, and prioritizing ads as their core revenue source. They also wanted to ensure a fantastic developer experience for their small-but-mighty team of engineers.

2021 年，Morning Brew 开始与 Vercel 合作，以增强其定制化的无头技术栈，聚焦于内容交付以实现最优用户体验，并将广告作为其核心收入来源。他们还希望为其规模虽小却实力强劲的工程师团队提供卓越的开发者体验。

Before growing and scaling, Morning Brew needed to upgrade their infrastructure to align with their growth strategy. A key issue was rigidity in their content experience. They were storing HTML in SQL, which was restrictive and created roadblocks to collaboration, reducing the team’s efficiency. To meet their goals, they would need a more flexible and customizable frontend.

在实现增长与规模化之前，Morning Brew 需要升级其基础设施，以契合其增长战略。一个关键问题是内容体验缺乏灵活性：他们将 HTML 直接存储在 SQL 数据库中，这种做法限制性强，阻碍了跨职能协作，降低了团队效率。为达成目标，他们亟需一套更灵活、更可定制的前端方案。

![](images/from-newsletter-to-global-media-brand-with-a-frontend-cloud-and-headless-stack-v/img_001.jpg)![](images/from-newsletter-to-global-media-brand-with-a-frontend-cloud-and-headless-stack-v/img_002.jpg)

![](images/from-newsletter-to-global-media-brand-with-a-frontend-cloud-and-headless-stack-v/img_001.jpg)![](images/from-newsletter-to-global-media-brand-with-a-frontend-cloud-and-headless-stack-v/img_002.jpg)

That’s why the Morning Brew team migrated their stack to Sanity and Vercel. Now, instead of having to wrangle a monolith every time they want to launch a new brand, they can use frontend cloud features to build instantly.

因此，Morning Brew 团队将其技术栈迁移至 Sanity 和 Vercel。如今，每当他们需要推出一个新品牌时，不再需要费力维护一个臃肿的单体架构，而是可借助前端云（Frontend Cloud）能力即时构建。

> “By thinking of content as data and removing the HTML semantics, we can let editors and content creators do what they do best. By thinking of content as data and removing the HTML semantics, we can let editors and content creators do what they do best.”
>
> “将内容视为数据，并剥离 HTML 的语义约束，我们便能让编辑人员和内容创作者专注于自己最擅长的工作。”
>
> ![](images/from-newsletter-to-global-media-brand-with-a-frontend-cloud-and-headless-stack-v/img_003.png)
>
> ![](images/from-newsletter-to-global-media-brand-with-a-frontend-cloud-and-headless-stack-v/img_003.png)
>
> **Drew Monroe,** Director of Engineering
>
> **德鲁·门罗（Drew Monroe）**，工程总监

### Features for launching new platforms at lightning speed

### 以闪电速度上线新平台的核心功能

Their use of a Next.js and Vercel frontend allows Morning Brew to instantly spin up new websites and lines of business. Features like Incremental Static Regeneration (ISR), Serverless Functions, and Preview Deployments empower their team to iterate and ship quickly, so they can go from app idea to execution in minutes—all while giving their developers and users the best experience possible.

借助基于 Next.js 与 Vercel 构建的前端，Morning Brew 能够即时启动全新网站及业务线。增量静态再生（ISR）、无服务器函数（Serverless Functions）以及预览部署（Preview Deployments）等功能，赋能团队快速迭代与发布——从应用构想到落地执行仅需数分钟，同时为开发者与终端用户带来极致体验。

**On-demand ISR for a top developer experience**

**按需 ISR：成就顶级开发者体验**

Morning Brew makes heavy use of Vercel’s [on-demand ISR](https://vercel.com/docs/concepts/incremental-static-regeneration/overview), which allows teams to create or update content without redeploying their site. They rehydrate content with ISR, resulting in the end user always seeing the most up-to-date content since changes propagate instantaneously.

Morning Brew 大量采用 Vercel 的[按需 ISR（On-Demand ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) 功能，使团队无需重新部署网站即可创建或更新内容。他们通过 ISR 对内容进行“再水化”（rehydration），确保终端用户始终看到最新内容——因为所有变更均可瞬时生效并全局同步。

**They’ve achieved a 100% cache hit rate with on-demand ISR.**

**他们已借助按需 ISR 实现 100% 的缓存命中率。**

[**Get started with ISR** Instantly update content without redeploying.](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration)

[**开始使用增量静态再生（ISR）** 无需重新部署即可即时更新内容。](https://vercel.com/templates/next.js/on-demand-incremental-static-regeneration)

**Serverless Functions for scaling fast sites**

**面向高性能网站的无服务器函数**

Morning Brew handles 15M cache requests and 2M [Serverless Function](https://vercel.com/docs/concepts/functions/serverless-functions) invocations per month—making their page loads are superfast, even with high traffic.

Morning Brew 每月处理 1500 万次缓存请求和 200 万次 [无服务器函数](https://vercel.com/docs/concepts/functions/serverless-functions) 调用——即使在高流量情况下，其页面加载速度依然极快。

**“Vercel gives you this serverless compute that scales up and down seamlessly. After you’ve got the dynamic pieces figured out, we’ve got an edge CDN available, serving content blazingly fast, regardless of where people are located,” says Monroe.**

**Monroe 表示：“Vercel 提供了这种可无缝自动扩缩容的无服务器计算能力。在您完成动态逻辑的开发后，我们还提供边缘 CDN，无论用户身处何地，都能以闪电般的速度交付内容。”**

[**Get started with Serverless Functions** Scale seamlessly with Next.js app and a Serverless Function API.](https://vercel.com/templates/next.js/nextjs-boilerplate)

[**开始使用无服务器函数** 通过 Next.js 应用与无服务器函数 API 实现无缝扩展。](https://vercel.com/templates/next.js/nextjs-boilerplate)

**Preview Deployments for instant collaboration**

**预览部署，实现即时协作**

Developers and content creators can preview sites automatically without configuration. Drew’s team can simply send a [Preview URL](https://vercel.com/features/previews) to content creators and editors, and the teams can make suggestions in real time.

开发者与内容创作者无需任何配置即可自动预览网站。Drew 的团队只需将一个 [预览 URL](https://vercel.com/features/previews) 发送给内容创作者和编辑人员，双方即可实时提出修改建议。

With the ability to comment directly on Previews, they are able to break down silos between teams, creating more transparency, and allowing stakeholders to join the collaboration seamlessly. Now, product managers, product designers, and even editors can think about how one piece of content or one design feature can fit into the overall schema.

借助直接在预览页面上添加评论的功能，他们得以打破团队间的壁垒，提升协作透明度，并让各相关方自然、顺畅地加入协作流程。如今，产品经理、产品设计师，甚至编辑人员，都能共同思考某一段内容或某一项设计功能如何融入整体架构之中。

[**Get started with Preview Deployments** Receive feedback on your Preview Deployments from Team members and invited collaborators.](https://vercel.com/docs/concepts/deployments/comments)

[**开始使用预览部署** 收到来自团队成员及受邀协作者对您预览部署的反馈意见。](https://vercel.com/docs/concepts/deployments/comments)

Going headless with the leading frontend cloud speed ups development without sacrificing performance. [Get in touch today](https://vercel.com/contact) to learn more.

采用业界领先的前端云实现“无头化”架构，在不牺牲性能的前提下显著加速开发进程。[立即联系我们](https://vercel.com/contact)，了解更多信息。
&#123;% endraw %}
