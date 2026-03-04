---
title: "How Consensys rebuilt MetaMask.io with Vercel and Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-consensys-rebuilt-metamask-io-with-vercel-and-next-js"
date: "2025-05-14"
scraped_at: "2026-03-02T09:33:48.088614876+00:00"
language: "en-zh"
translated: true
description: "Learn how Consensys modernized MetaMask.io using Vercel and Next.js—cutting deployment times, improving collaboration across teams, and unlocking dynamic content with serverless architecture."
---
&#123;% raw %}

May 14, 2025

2025年5月14日

Faster workflows, dynamic content, and fewer bottlenecks: Learn more about MetaMask's move to Vercel

更快的工作流、动态化内容、更少的性能瓶颈：深入了解 MetaMask 迁移至 Vercel 的背后故事

Since 2014, Consensys has shaped the web3 movement with tools like and [Linea](https://linea.build/), [Infura](https://www.infura.io/), and [MetaMask](https://metamask.io/)—the most widely used [self-custodial wallet](https://metamask.io/) on the web, with millions of users across the globe.

自2014年起，ConsenSys 便凭借 Linea（[https://linea.build/](https://linea.build/)）、Infura（[https://www.infura.io/](https://www.infura.io/)）和 MetaMask（[https://metamask.io/](https://metamask.io/)）等工具持续推动 Web3 发展——其中 MetaMask 是目前全球用户量最大的[自主托管钱包](https://metamask.io/)，拥有数百万遍布全球的用户。

As the blockchain ecosystem quickly matured, the need for a site that could move as fast as the teams building it became clear. To meet that demand, Consensys migrated MetaMask.io to Next.js and Vercel, creating an architecture built for scale, speed, and continuous iteration.

随着区块链生态系统的快速成熟，一个能与开发团队同步高速演进的网站架构变得尤为迫切。为满足这一需求，ConsenSys 将 MetaMask.io 迁移至 Next.js 与 Vercel，构建起一套面向规模化、高性能与持续迭代的现代化架构。

## **Moving towards migration**

## **迈向迁移之路**

Before migrating, MetaMask.io was built with Static Site Generation (SSG) and hosted on GitHub Pages. While this approach served its purpose early on, as the product grew, it began to face limitations. Deployments slowed, dynamic content like API events were difficult to support, and the CMS struggled to keep up with the pace of internal development. Even small updates often needed manual workarounds.

迁移前，MetaMask.io 采用静态站点生成（SSG）方式构建，并托管在 GitHub Pages 上。该方案在项目初期尚能满足需求；但随着产品规模扩大，其局限性日益凸显：部署速度变慢、难以支持 API 事件等动态内容、CMS 系统亦难以跟上内部开发节奏。即便是微小更新，也常需依赖人工干预与临时变通方案。

Consensys had already proven Vercel’s value with other MetaMask initiatives like [MetaMask Learn](https://learn.metamask.io/). Expanding the use of [Next.js with Server-Side Rendering](https://vercel.com/docs/frameworks/nextjs) (SSR) and standardizing on Vercel was a clear next step.

ConsenSys 此前已在 [MetaMask Learn](https://learn.metamask.io/) 等其他 MetaMask 项目中验证了 Vercel 的价值。因此，进一步推广采用支持服务端渲染（SSR）的 [Next.js](https://vercel.com/docs/frameworks/nextjs)，并全面统一使用 Vercel 平台，成为顺理成章的下一步战略。

## **Rebuilding MetaMask**

## **重构 MetaMask 官网**

The migration was focused on improving operational reliability, ensuring the site could scale safely through product launches and rapid growth.

此次迁移聚焦于提升系统运行的可靠性，确保网站能够安全、稳健地支撑产品发布及业务的快速增长。

- [Next.js](https://vercel.com/frameworks/nextjs) 为前端提供支持，采用动态渲染（Dynamic Rendering），使团队对性能与内容交付拥有完全控制权。

- [Contentful](https://vercel.com/integrations/contentful) 提供了一套现代化的内容管理系统（CMS），让非开发人员也能更快速地管理与更新内容，同时不牺牲灵活性。

- [Vercel](https://vercel.com/enterprise) 承担了持续集成/持续部署（CI/CD）、托管、全球分发及可观测性（observability）等任务，使团队能够以极低的运维开销，在全球范围内完成网站的部署、弹性伸缩与实时监控。

通过此次迁移，团队在性能、可靠性与搜索引擎优化（SEO）方面树立了更高标准。他们采用灰度发布（canary rollout）策略：首先将 1% 的流量导入新系统以验证系统稳定性，随后在四小时内平稳扩展至 100% 流量，全程无需任何一次回滚操作。

## **新架构在实践中的应用**

如今，MetaMask.io 运行于 Vercel 全球 [边缘网络（Edge Network）](https://vercel.com/products/rendering) 之上，可极速交付静态资源；而动态端点则由 [Vercel Functions](https://vercel.com/docs/functions) 承载。借助 [增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/docs/incremental-static-regeneration) 和智能缓存等能力，团队得以向终端用户交付更丰富、更动态的内容与实时数据（例如代币价格），而这在原先仅依赖静态站点生成（SSG）的旧架构中是无法实现的。

此外，工程、设计与内容等跨职能团队可实现实时协同。带内联评论功能的预览链接（Preview URLs）与并发构建（concurrent builds）机制，显著加快了迭代速度，并大幅降低了质量保障（QA）环节的协作摩擦。

> “我们已切实感受到多方面的提升——不仅体现在核心网页指标（Core Web Vitals）上，更体现在团队交付速度的显著加快。开发者体验更加顺畅，基础设施更具韧性，网站整体性能也明显提升。”  
>  
> ![](images/how-consensys-rebuilt-metamask_io-with-vercel-and-next_js-vercel/img_001.png)  
>  
> **Nazan Kurt**，ConsenSys 网站产品与工程负责人

## **真正重要的成果**

性能提升立竿见影：系统可用性（Uptime）提高、部署周期大幅缩短，团队还实现了更优的 SEO 效果。Speed Insights 工具的数据验证了这些进步；内部反馈亦十分明确：产品、市场与设计等各团队如今行动更快、协作更高效、贡献更显著。

Going forward, Consensys is confident in a setup that scales with their vision. With Vercel, their teams are free to focus on what’s next, not infrastructure.

展望未来，ConsenSys 对能够随其愿景同步扩展的架构充满信心。借助 Vercel，其团队得以专注于下一步发展，而非基础设施。

[**Vercel works hard to serve the best-performing sites on the web.**\\
\\
Our experts can help you learn how your site can rank among them.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**Vercel 致力于为网络上性能最优的网站提供卓越服务。**\\
\\
我们的专家可协助您了解如何让您的网站跻身其中。\\
\\
联系我们](https://vercel.com/contact/sales)
&#123;% endraw %}
