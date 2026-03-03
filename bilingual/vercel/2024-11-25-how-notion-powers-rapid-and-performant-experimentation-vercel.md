---
title: "How Notion powers rapid and performant experimentation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-notion-powers-rapid-and-performant-experimentation"
date: "2024-11-25"
scraped_at: "2026-03-02T09:39:22.401555720+00:00"
language: "en-zh"
translated: true
description: "Notion runs hundreds of experiments per year with Statsig and Next.js on Vercel. Learn how they maintain Core Web Vitals on marketing pages while testing new content with users."
---

Nov 25, 2024

2024 年 11 月 25 日

Using Next.js, Vercel, and Statsig to increase iteration velocity and run hundreds of experiments per year.

借助 Next.js、Vercel 和 Statsig 提升迭代速度，并每年运行数百项实验。

#### 300%

#### 300%

Increase in speed to deploy hotfixes

热修复部署速度提升 300%

#### 0.09

#### 0.09

Average Cumulative Layout Shift score

平均累积布局偏移（CLS）得分为 0.09

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[Notion](https://www.notion.so/) is a connected workspace that allows users to write, plan, and organize, all enhanced with built-in AI. With a platform as flexible as Notion, the challenge for their website team lies in communicating the vast range of use cases—from personal projects like planning trips to enterprise-level tasks like managing company documentation. That’s a huge total addressable market that attracts many millions of diverse visitors to their website every week. As these numbers continue to rapidly grow and personas expand, Notion needed a website capable of rapid iteration and experimentation to help their message resonate with more people.

[Notion](https://www.notion.so/) 是一个互联式工作空间，支持用户写作、规划与组织，所有功能均深度集成原生 AI。Notion 平台高度灵活，其官网团队面临的挑战在于：如何清晰传达其覆盖范围极广的使用场景——从个人用途（如旅行规划）到企业级任务（如公司文档管理）。这一广阔的目标市场吸引了每周数百万背景各异的访客访问其网站。随着用户规模持续快速增长、用户画像不断扩展，Notion 急需一个支持快速迭代与实验的网站，以让其核心信息触达更广泛的受众。

## Improving iteration velocity with Vercel

## 借助 Vercel 提升迭代速度

With a small team focused on the marketing site, Notion required an infrastructure solution that enabled quick updates without compromising performance.

Notion 的营销网站由一支精干团队负责，因此亟需一种基础设施方案：既能实现快速更新，又不牺牲性能。

Previously, Notion deployed its marketing site using ECS. The team of engineers were web experience specialists and didn't have the resources to spend on configuring infrastructure, leading to challenges with handling traffic spikes, autoscaling issues, and long deployment times. Moving to Vercel simplified these processes by abstracting away infrastructure maintenence. As a result, the team could focus on faster iterations without worrying about complex deployment setups.

此前，Notion 使用 ECS 部署其营销网站。该工程团队由网页体验专家组成，缺乏配置基础设施所需的人力资源，导致在应对流量高峰、自动扩缩容以及长部署周期等方面面临诸多挑战。迁移到 Vercel 后，基础设施运维被完全抽象化，大幅简化了上述流程。因此，团队得以专注于快速迭代，无需再为复杂的部署配置操心。

Vercel provided the perfect solution to Notion’s need for speed. With Vercel, the marketing team saw a significant boost in development velocity thanks to features like fast deploys and [Instant Rollbacks](https://vercel.com/docs/deployments/instant-rollback). **What once took an hour to deploy a hotfix now takes just 15 minutes (a 75% decrease), and rolling back changes happens in seconds.**

Vercel 完美契合了 Notion 对“速度”的迫切需求。借助 Vercel，营销团队的开发效率显著提升——这得益于快速部署、[即时回滚（Instant Rollbacks）](https://vercel.com/docs/deployments/instant-rollback) 等功能。**过去需耗时一小时才能完成的热修复部署，如今仅需 15 分钟（降幅达 75%），而变更回滚更可在数秒内完成。**

## Statsig and Edge Config for seamless experimentation

## 借助 Statsig 与 Vercel Edge Config 实现无缝实验

Notion's marketing sites are built with Next.js and integrated with [Statsig](https://www.statsig.com/) for experimentation. This integration automatically updates experiments to Vercel's Edge Config store, with [Middleware](https://vercel.com/docs/functions/edge-middleware) handling real-time experimentation at the edge. By using [Vercel Edge Config](https://vercel.com/docs/storage/edge-config) in combination with Statsig's target apps to experiment [server-side](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr), they minimize payload sizes and latency, ensuring no negative impacts to performance or Core Web Vitals. Notion now consistently averages **0.09 or better for** [Cumulative Layout Shift](https://web.dev/articles/cls), placing their site in the top tier for user experience.

Notion 的营销网站基于 Next.js 构建，并集成了 [Statsig](https://www.statsig.com/) 以支持 A/B 实验。该集成可将实验配置自动同步至 Vercel 的 Edge Config 存储；同时，借助 [Middleware](https://vercel.com/docs/functions/edge-middleware)，实验逻辑可在边缘节点实时执行。通过将 [Vercel Edge Config](https://vercel.com/docs/storage/edge-config) 与 Statsig 的目标应用结合，实现 [服务端实验（Server-Side Experimentation）](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr)，Notion 显著减小了页面载荷体积与网络延迟，从而确保性能及核心网页指标（Core Web Vitals）不受负面影响。目前，Notion 网站的 [累积布局偏移（Cumulative Layout Shift, CLS）](https://web.dev/articles/cls) 指标稳定保持在 **0.09 或更优水平**，使其用户体验稳居行业第一梯队。

![Middleware makes routing decisions based on Statsig. Statsig SDK is bootstrapped from Edge Config instead of fetching from the Statsig API.](images/how-notion-powers-rapid-and-performant-experimentation-vercel/img_001.jpg)![Middleware makes routing decisions based on Statsig. Statsig SDK is bootstrapped from Edge Config instead of fetching from the Statsig API.](images/how-notion-powers-rapid-and-performant-experimentation-vercel/img_002.jpg)Middleware makes routing decisions based on Statsig. Statsig SDK is bootstrapped from Edge Config instead of fetching from the Statsig API.

![Middleware 根据 Statsig 决定路由策略。Statsig SDK 从 Edge Config 初始化，而非调用 Statsig API 获取配置。](images/how-notion-powers-rapid-and-performant-experimentation-vercel/img_001.jpg)![Middleware 根据 Statsig 决定路由策略。Statsig SDK 从 Edge Config 初始化，而非调用 Statsig API 获取配置。](images/how-notion-powers-rapid-and-performant-experimentation-vercel/img_002.jpg)Middleware 根据 Statsig 决定路由策略。Statsig SDK 从 Edge Config 初始化，而非调用 Statsig API 获取配置。

Feature flags are a crucial component of Notion's setup. Vercel's integrated [Toolbar](https://vercel.com/docs/workflow-collaboration/feature-flags#step-2.-managing-feature-flags-from-the-toolbar) allows both developers and non-developers to easily toggle experiments for testing and iteration, streamlining the rollout process. Notion's marketing team utilizes this integration to run tests aimed at growing their top-of-funnel metrics, specifically increasing the number of new onboarded users.

功能开关（Feature Flags）是 Notion 技术架构中的关键组件。Vercel 内置的 [Toolbar](https://vercel.com/docs/workflow-collaboration/feature-flags#step-2.-managing-feature-flags-from-the-toolbar) 使开发者与非技术人员均可轻松启用或禁用实验，极大简化了测试与迭代流程，加速功能上线。Notion 营销团队正利用这一能力开展各类实验，旨在提升漏斗顶端（top-of-funnel）关键指标——尤其是新增用户注册量。

Toggling on a feature flag from a Vercel Preview Deployment to test a new version of Notion's homepage.

在 Vercel Preview 部署环境中启用一个功能开关，以测试 Notion 新版首页。

Notion is data-driven and has a strong broader culture of experimentation, **running hundreds of tests per year across their team**. By choosing Statsig and Vercel, the team gets seamless integration, with holistic metrics analysis that offers both top-line and detailed views of performance from feature flags.

Notion 坚持数据驱动决策，并在全公司范围内形成了浓厚的实验文化——**团队每年运行数百项实验**。选择 Statsig 与 Vercel 的组合，不仅实现了开箱即用的无缝集成，更提供了全面的指标分析能力：既可纵览功能开关对整体业务指标的影响，亦能深入洞察其对各项细分性能指标的具体作用。

[**Start interacting with your application’s feature flags.**\\
\\
Unlock the new workflow today: Use the Vercel Toolbar to read and set feature flag overrides for your application.\\
\\
Get started](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar)

[**立即开始与您应用的功能开关交互。**\\
\\
即刻启用全新工作流：使用 Vercel Toolbar 读取并设置您应用的功能开关覆写（overrides）。\\
\\
立即开始](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar)

In addition, Notion uses Vercel’s [monitoring](https://vercel.com/docs/observability/monitoring#monitoring) tools to track performance and resolve issues on their website overall. Weekly queries and ad-hoc dashboards help the engineering team monitor key metrics, such as page errors and caching issues, ensuring the site is always performing at its best even with experiments running.

此外，Notion 还借助 Vercel 的 [监控（Monitoring）](https://vercel.com/docs/observability/monitoring#monitoring) 工具，全面追踪网站性能并及时排查问题。通过定期运行的周度查询及按需创建的临时仪表板，工程团队可持续监测关键指标（如页面错误率、缓存异常等），确保即便在大量实验并行运行的情况下，网站仍始终维持最优性能表现。

## Get started with Vercel

## 开始使用 Vercel

Since adopting Vercel, Notion has seen substantial improvements in its development process. The implementation has reduced infrastructure concerns and decreased deployment times, allowing the team to focus on iterating quickly and ship updates that truly speak to their users.

自采用 Vercel 以来，Notion 的开发流程实现了显著提升。该方案大幅降低了基础设施运维负担，缩短了部署时间，使团队得以更快速地迭代，并发布真正契合用户需求的更新。

[**Want to add Vercel to your composable stack?**\\
\\
Talk to an expert to learn how you can improve your site’s performance and UX.\\
\\
Get in touch](https://vercel.com/contact/sales)

[**想将 Vercel 加入您的可组合技术栈？**\\
\\
联系专家，了解如何提升您网站的性能与用户体验。\\
\\
立即联系](https://vercel.com/contact/sales)