---
title: "From minutes to seconds: How Meter accelerates delivery with Vercel and Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next"
date: "2024-11-26"
scraped_at: "2026-03-02T09:39:28.280286138+00:00"
language: "en-zh"
translated: true
description: "Meter's updated tech stack with Vercel"
---
{% raw %}

Nov 26, 2024

2024年11月26日

From complex deployments to streamlined workflows, learn how Meter builds with rapid innovation.

从复杂的部署流程到简化的开发工作流，了解 Meter 如何依托快速创新构建产品。

#### 98.33%

#### 构建耗时降低 98.33%

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[Meter](https://www.meter.com/) provides a full-stack networking solution that makes it easy for any business, organization, or school—of any size—to get access to the internet. They have two application layers built on top of their vertically integrated technical architecture: Meter [Command](https://www.meter.com/command), a generative UI for IT and Networking teams, and Meter [Dashboard](https://www.meter.com/dashboard), their main web interface. Meter’s adoption of Vercel has enhanced performance, simplified workflows, and empowered their team to iterate rapidly—not only across Command and Dashboard, but throughout their interconnected stack of hardware, software, and operations.

[Meter](https://www.meter.com/) 提供一套全栈式网络解决方案，使任何规模的企业、机构或学校都能轻松接入互联网。其技术架构采用垂直整合设计，并在此之上构建了两层应用：面向 IT 与网络团队的生成式用户界面——Meter [Command](https://www.meter.com/command)，以及其主 Web 界面——Meter [Dashboard](https://www.meter.com/dashboard)。Meter 采用 Vercel 后，显著提升了性能、简化了工作流，并赋能团队实现快速迭代——不仅覆盖 Command 和 Dashboard，更贯穿其硬件、软件与运维高度互联的技术栈。

## Choosing Vercel for speed and integrations

## 基于速度与集成能力选择 Vercel

Prior to migrating, Meter’s Dashboard product was hosted through various AWS solutions, with long build times and limited visibility into changes. When evaluating options, Meter's team prioritized fast iteration, speed of deployment, and the seamless integration that Vercel provides for both frontend and backend processes.

迁移前，Meter 的 Dashboard 产品依托多种 AWS 方案托管，存在构建耗时长、变更可见性低等问题。在评估替代方案时，Meter 团队将快速迭代能力、部署速度，以及 Vercel 对前后端流程提供的无缝集成能力列为首要考量因素。

![Meter's web application, an intuitive dashboard for network management, hosted on Vercel.](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_001.jpg)  
Meter's web application, an intuitive dashboard for network management, hosted on Vercel.

![Meter 的 Web 应用——一款直观的网络管理仪表盘，托管于 Vercel。](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_001.jpg)  
Meter 的 Web 应用——一款直观的网络管理仪表盘，托管于 Vercel。

### Monorepo management made easier

### 单体仓库（Monorepo）管理更轻松

The team implemented a two-phase migration of Dashboard to Vercel, first transferring over core components and then integrating additional features. Challenges such as managing remote caching and consolidating to a monorepo were handled with Vercel’s support for React, Vite builds, and [previews for every feature branch](https://vercel.com/docs/deployments/preview-deployments).

团队实施了 Dashboard 向 Vercel 的两阶段迁移：首先迁移核心组件，随后集成其他功能。在应对远程缓存管理、向单体仓库（monorepo）整合等挑战时，团队充分利用了 Vercel 对 React 和 Vite 构建的支持，以及为每个功能分支提供的[预览部署能力](https://vercel.com/docs/deployments/preview-deployments)。

Today, all of Meter's deployed assets live in a unified repository, enabling easier code management and collaboration across teams. Improved build times— **down from over 10 minutes to less than a minute**—and Vercel’s [flexible rollback capabilities](https://vercel.com/docs/deployments/instant-rollback#performing-an-instant-rollback-on-a-deployment) have increased the reliability and scalability of their deployments.

如今，Meter 所有已部署的资产均集中于一个统一的代码仓库中，显著简化了代码管理，并提升了跨团队协作效率。构建时间从**超过 10 分钟大幅缩短至不到 1 分钟**；加之 Vercel 提供的[灵活回滚能力](https://vercel.com/docs/deployments/instant-rollback#performing-an-instant-rollback-on-a-deployment)，其部署的可靠性与可扩展性也得到显著增强。

![Command's current tech stack and architecture.](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_002.jpg)![Command's current tech stack and architecture.](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_003.jpg)Command's current tech stack and architecture.

![Command 当前的技术栈与架构图。](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_002.jpg)![Command 当前的技术栈与架构图。](images/from-minutes-to-seconds-how-meter-accelerates-delivery-with-vercel-and-next_js-v/img_003.jpg)Command 当前的技术栈与架构。

### Moving and shipping faster

### 更快地迁移与交付

Since the Dashboard migration, the team has noted substantial benefits in CI/CD iteration speed, which helps them quickly push and review code in a production-like environment. Vercel's integrated [git workflow](https://vercel.com/docs/deployments/git) allows for daily production pushes, enabling faster feature releases and reduced need for manual QA.

自完成 Dashboard 迁移以来，团队在 CI/CD 迭代速度方面获得了显著提升，使其能够快速推送和评审代码，并在类生产环境中高效验证。Vercel 深度集成的 [Git 工作流](https://vercel.com/docs/deployments/git) 支持每日向生产环境发布，从而加速新功能上线，并大幅降低人工 QA 的依赖。

Meter built Command, on Next.js and Vercel. Command enables Meter users to get information about their networks, take action, and create custom, real-time software—all in natural language and at the speed of a web search.

Meter 基于 Next.js 和 Vercel 构建了 Command。Command 使 Meter 用户能够以自然语言、如同网页搜索般迅捷的方式，获取其网络相关信息、执行操作，并创建定制化、实时运行的软件。

Vercel and Next.js allow for rapid iteration on the frontend and easily sync with the backend data processing that powers these interactions via Next.js' [API Routes](https://nextjs.org/docs/pages/building-your-application/routing/api-routes). The engineering team can focus on refining the model architecture that powers the product’s backend without worrying about underlying infrastructure details.

Vercel 与 Next.js 支持前端的快速迭代，并可通过 Next.js 的 [API 路由（API Routes）](https://nextjs.org/docs/pages/building-your-application/routing/api-routes) 无缝对接后端数据处理逻辑，从而驱动上述交互。工程团队得以专注于优化支撑产品后端的模型架构，而无需操心底层基础设施细节。

The ability to push changes quickly, view updates immediately on their dev site, and iterate efficiently has been transformative for the team working on Command. Vercel ensures that Command remains performant by maintaining a clear separation between client-side and server-side logic, while still allowing seamless communication between the two.

快速推送变更、即时在开发站点查看更新、高效迭代——这一能力彻底改变了 Command 团队的工作方式。Vercel 通过清晰分离客户端与服务端逻辑，在保障 Command 高性能的同时，仍支持二者之间无缝通信。

## Get started with Vercel

## 开始使用 Vercel

Meter’s engineering team has observed a marked increase in performance, scalability, and user experience. With every feature branch previewed and reviewed before going live, the team has found a reliable process for maintaining high standards across their products.

Meter 工程团队观察到，系统性能、可扩展性及用户体验均实现了显著提升。借助“每个功能分支均在上线前完成预览与评审”这一实践，团队已建立起一套可靠流程，持续保障其各款产品的高质量标准。

As Meter continues to refine its vertically integrated hardware, firmware, and software stack, the streamlined workflow and increased speed on Vercel will enable them to deliver even more powerful products to their customers and partners.

随着 Meter 持续优化其垂直整合的硬件、固件与软件技术栈，Vercel 上简化的开发流程和更高的构建速度将助力其向客户与合作伙伴交付更强大的产品。

[**Looking to upgrade your infrastructure?**  
**是否考虑升级您的基础设施？**

Connect with a Next.js expert and learn about Vercel's best-in-class tooling for site performance and org-wide collaboration.  
联系 Next.js 专家，了解 Vercel 在网站性能优化与组织级协作方面业界领先的工具能力。

Contact us](https://vercel.com/contact)  
联系我们](https://vercel.com/contact)
{% endraw %}
