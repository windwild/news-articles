---
title: "Tray.ai cut build times from a day to minutes with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/tray-ai-cut-build-times-from-a-day-to-minutes-with-vercel"
date: "2025-06-16"
scraped_at: "2026-03-02T09:32:40.948134592+00:00"
language: "en-zh"
translated: true
description: "Tray.ai cut build times from a full day to just two minutes after migrating to Vercel. By consolidating infrastructure and updating their tech stack, they now deliver over a million monthly page views..."
---
{% raw %}

Jun 16, 2025

2025年6月16日

How Roboto Studio simplified infrastructure, improved developer experience, and consolidated thousands of pages for Tray.ai

Roboto Studio 如何帮助 Tray.ai 简化基础设施、提升开发者体验，并整合数千个页面

#### 99.86%

decrease in build times

#### 构建耗时降低 99.86%

#### Over 1 million

monthly page views

#### 月均页面浏览量超 100 万次

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[Tray.ai](https://tray.ai/) is a composable AI integration and automation platform that enterprises use to build smart, secure AI agents at scale.

[Tray.ai](https://tray.ai/) 是一个可组合的 AI 集成与自动化平台，企业借助该平台可大规模构建智能、安全的 AI 智能体。

To modernize their marketing site, they partnered with [Roboto Studio](https://vercel.com/partners/solution-partners/roboto-studio) to migrate off their legacy solution and outdated version of Next.js. The goal: simplify the architecture, consolidate siloed repos, and bring content and form management into one unified system.

为实现营销网站的现代化升级，Tray.ai 与 [Roboto Studio](https://vercel.com/partners/solution-partners/roboto-studio) 展开合作，将其从陈旧的遗留系统及过时版本的 Next.js 迁移出来。目标是：简化架构、整合彼此孤立的代码仓库，并将内容管理与表单管理统一到一个集成系统中。

After moving to Vercel, builds went from a full day to just two minutes.

迁移至 Vercel 后，构建时间从整整一天缩短至仅需两分钟。

## From fragile pipelines to fast deploys

## 从脆弱的流水线到快速部署

Before the migration, [Tray.ai](http://tray.ai/)’s infrastructure was held together by legacy decisions. An older version of Next.js coupled with [Serverless](https://www.serverless.com/), 250MB package builds, and a rigid dev–stage–prod pipeline slowed development to a crawl. Previewing changes required full deploys. Form logic lived in a separate repo. Builds failed often, and when they didn’t, they took a full day.

迁移之前，[Tray.ai](http://tray.ai/) 的基础设施依赖于一系列历史遗留决策：老旧版本的 Next.js 与 [Serverless](https://www.serverless.com/) 框架耦合、高达 250MB 的包构建体积，以及僵化的开发–预发布–生产三阶段流水线，严重拖慢了开发节奏。预览任何变更都需执行完整部署；表单逻辑则分散在独立代码仓库中；构建频繁失败，即便成功，也需耗费整整一天时间。

> “Moving to Vercel reduced build times from a full day to just 2 minutes for faster rollouts and more agile updates.”  
>  
> “迁移到 Vercel 后，构建时间从一整天大幅缩短至仅需 2 分钟，从而实现更快速的上线发布和更敏捷的迭代更新。”  
>  
> ![](images/tray_ai-cut-build-times-from-a-day-to-minutes-with-vercel-vercel/img_001.png)  
>  
> **Co-founder & CEO,** Tray.ai  
>  
> **联合创始人兼首席执行官**，Tray.ai

Roboto Studio rebuilt the site from the ground up using [Next.js](https://nextjs.org/). They consolidated everything into a single [Turborepo](https://turborepo.com/) monorepo, with custom page resolution and deeply nested dynamic routing to handle the complexity of over 500,000 pages.

Roboto Studio 基于 [Next.js](https://nextjs.org/) 从零开始重构了整个网站。他们将所有代码整合进一个统一的 [Turborepo](https://turborepo.com/) 单体仓库（monorepo），并实现了自定义页面解析机制与深度嵌套的动态路由，以应对超过 50 万页面所带来的复杂性挑战。

![](images/tray_ai-cut-build-times-from-a-day-to-minutes-with-vercel-vercel/img_002.jpg)![](images/tray_ai-cut-build-times-from-a-day-to-minutes-with-vercel-vercel/img_003.jpg)

On Vercel, the team now uses [automatic git-based deployments](https://vercel.com/docs/git) on every branch push. Developers get to see their changes using [preview deployments](https://vercel.com/products/previews) that mimics production, allowing them to find and fix issues before they merge.

在 Vercel 平台上，团队现已启用 [基于 Git 的自动部署](https://vercel.com/docs/git)，每次向任意分支推送代码即触发部署。开发者可通过高度拟真的 [预览部署（Preview Deployments）](https://vercel.com/products/previews) 实时查看变更效果，从而在代码合并前及时发现并修复问题。

## Unified infrastructure, fewer unknowns

## 统一基础设施，减少未知风险

The new site architecture uses a hybrid approach with Static Site Generation (SSG), Server-Side Rendering (SSR), and Client-Side Rendering (CSR), each applied where it makes sense. Roboto also rebuilt Tray’s forms engine using [Vercel Functions](https://vercel.com/docs/functions), integrated with recaptcha for added protection.

新网站架构采用混合渲染策略——静态站点生成（SSG）、服务端渲染（SSR）与客户端渲染（CSR）各司其职，按需应用。Roboto 还基于 [Vercel Functions](https://vercel.com/docs/functions) 重构了 Tray 的表单引擎，并集成 reCAPTCHA 以增强安全防护能力。

With [Vercel Analytics](https://vercel.com/docs/analytics) and [Speed Insights](https://vercel.com/docs/speed-insights), the team can now understand how real users interact with the site. Performance insights right in the Vercel Dashboard became a north star.

借助 [Vercel Analytics](https://vercel.com/docs/analytics) 和 [Speed Insights](https://vercel.com/docs/speed-insights)，团队如今能够深入洞察真实用户如何与网站交互。Vercel 控制台中实时呈现的性能数据，已成为团队持续优化体验的“北极星指标”。

![](images/tray_ai-cut-build-times-from-a-day-to-minutes-with-vercel-vercel/img_004.jpg)![](images/tray_ai-cut-build-times-from-a-day-to-minutes-with-vercel-vercel/img_005.jpg)

In addition, reliability has drastically improved. The team now catches build errors instantly, no more digging through layers of abstraction or chasing down broken deploys. What used to take extra steps and time is now visible the moment it happens, making fixes faster and more straightforward.

此外，系统可靠性已大幅提升。团队如今能即时捕获构建错误，无需再层层穿透抽象层，也无需费力追踪失败的部署。过去需要额外步骤和耗时排查的问题，如今在发生瞬间即可被察觉，从而让修复更快、更直接。

> “We are shipping far faster, far more often, and we’re giving Tray visibility into every change, right in the workflow.  
> We are shipping far faster, far more often, and we’re giving Tray visibility into every change, right in the workflow.”  
>  
> “我们交付速度大幅加快，发布频率显著提升；同时，我们将每一次变更都实时呈现给 Tray，直接嵌入工作流之中。  
> 我们交付速度大幅加快，发布频率显著提升；同时，我们将每一次变更都实时呈现给 Tray，直接嵌入工作流之中。”

> ![](images/tray_ai-cut-build-times-from-a-day-to-minutes-with-vercel-vercel/img_006.png)  
>  
> **Founder of Roboto Studio**  
>  
> **Roboto Studio 创始人**

## Resilience at the edge  

## 边缘韧性

When the team spotted a DDoS attack targeting dynamic SSR routes through [Firewall Observability](https://vercel.com/docs/vercel-firewall/firewall-observability), they quickly refactored the most vulnerable pages to static, cached versions. The problem resolved without any infrastructure intervention. This kind of flexibility is built into the architecture, powered by [Vercel’s Edge Network](https://vercel.com/docs/edge-network).  

当团队通过 [防火墙可观测性（Firewall Observability）](https://vercel.com/docs/vercel-firewall/firewall-observability) 发现针对动态 SSR 路由的 DDoS 攻击时，他们迅速将最易受攻击的页面重构为静态、可缓存的版本。问题在无需任何基础设施干预的情况下即告解决。这种灵活性是架构原生具备的能力，由 [Vercel 边缘网络（Vercel’s Edge Network）](https://vercel.com/docs/edge-network) 提供支撑。

They now serve over one million page views monthly with a setup designed to scale.  

目前，他们每月服务超百万次页面浏览，整套架构专为弹性扩展而设计。

## Results  

## 成果

Tray’s migration wasn’t just about fixing broken builds, it was about unlocking a better way to work. With a modern Next.js architecture on Vercel, they now deploy faster, validate ideas quicker with preview deployments, and debug issues with real-time visibility.  

Tray 的迁移远不止于修复崩溃的构建流程，更在于开启一种更高效的工作方式。依托 Vercel 上现代化的 Next.js 架构，他们如今实现了更快的部署、借助预览部署（preview deployments）更快速地验证创意，并通过实时可观测性更高效地调试问题。

Consolidating multiple repos into a single codebase reduced complexity and made it easier to manage forms, content, and shared logic in one place. Combined with analytics, performance insights, and edge caching, the new stack gives Tray a faster, more reliable foundation built for iteration, scale, and speed.  

将多个代码仓库整合为单一代码库，显著降低了系统复杂度，使表单、内容与共享逻辑得以统一管理。再结合分析工具、性能洞察（performance insights）与边缘缓存（edge caching），这一全新技术栈为 Tray 打造了一个更快速、更可靠的基础平台——专为持续迭代、规模化扩展与极致交付速度而生。

[**Talk to a migration expert**\\  
\\  
Start building a cleaner enterprise-grade stack.\\  
\\  
Contact Sales](https://vercel.com/contact/sales)  
[**联系迁移专家**\\  
\\  
开始构建更简洁、更专业的企业级技术栈。\\  
\\  
联系销售](https://vercel.com/contact/sales)
{% endraw %}
