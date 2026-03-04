---
title: "Managing major traffic spikes during ticket drops with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/managing-major-traffic-spikes-during-ticket-drops-with-vercel"
date: "2023-03-31"
scraped_at: "2026-03-02T09:54:12.072507054+00:00"
language: "en-zh"
translated: true
description: "Shotgun"
---
&#123;% raw %}

Mar 31, 2023

2023年3月31日

Managing the complex scaling needs of an online ticketing platform can be challenging. For the French end-to-end ticketing solution [Shotgun](https://shotgun.live/), ticket drops used to involve stress around scaling and server provisioning. As a company dedicated to providing artists and their fans with the _best_ service, Shotgun now relies on Vercel for seamless launches. So when they drop tickets for artists like Billie Eilish, the team can rest assured their site can handle the traffic.

管理一个在线票务平台复杂的弹性伸缩需求可能颇具挑战性。对于法国端到端票务解决方案 [Shotgun](https://shotgun.live/) 而言，以往开票活动常令团队为资源伸缩与服务器配置而倍感压力。作为一家致力于为艺术家及其粉丝提供 _最佳_ 服务的公司，Shotgun 现已依托 Vercel 实现无缝发布。因此，当他们为比莉·艾利什（Billie Eilish）等艺人开启售票时，团队可完全放心——网站足以从容应对瞬时洪峰流量。

## **The need for scalability**

## **弹性伸缩的迫切需求**

In the beginning, Shotgun’s small dev team relied on Heroku. They appreciated its setup simplicity, but soon realized that Heroku couldn’t always scale to handle the traffic their website receives. It’s not uncommon for Shotgun’s consumer site to experience extreme traffic spikes when tickets go live for an event—jumping by 200x in just a few minutes. To prevent site crashes, Shotgun’s engineers would need to manually scale before ticket drops.

起初，Shotgun 规模较小的开发团队依赖 Heroku。他们欣赏其部署简便，但很快意识到 Heroku 并非总能按需弹性伸缩，以应对网站所承受的巨大流量。每当某场演出开票时，Shotgun 面向消费者的官网往往遭遇极端流量激增——短短几分钟内流量飙升达 200 倍。为避免网站崩溃，Shotgun 工程师不得不在开票前手动扩容。

The switch to Vercel took the pressure off of Shotgun’s developers. Instead of manually scaling ahead of time, they can now count on Vercel’s serverless autoscaling during traffic spikes. By using Vercel as their frontend platform and Next.js for their consumer website and dashboard, the team can feel confident during major ticket launches.

转向 Vercel 极大缓解了 Shotgun 开发者的压力。他们不再需要提前手动扩容，而是可完全信赖 Vercel 在流量高峰期间提供的无服务器自动伸缩能力。通过将 Vercel 作为前端平台，并采用 Next.js 构建消费者网站与后台管理仪表盘，团队在大型票务发布期间亦能信心十足。

> “Vercel allows us to focus on innovating and building our products, rather than spending time on DevOps.Vercel allows us to focus on innovating and building our products, rather than spending time on DevOps.”
>
> ![](images/managing-major-traffic-spikes-during-ticket-drops-with-vercel-vercel/img_001.png)
>
> **Lucas Gerard,** Cofounder and CTO at Shotgun

> “Vercel 让我们得以专注于产品创新与开发，而非耗费时间在 DevOps 运维工作上。”
>
> ![](images/managing-major-traffic-spikes-during-ticket-drops-with-vercel-vercel/img_001.png)
>
> **卢卡斯·热拉尔（Lucas Gerard）**，Shotgun 联合创始人兼首席技术官

## **A better workflow for faster development**

## **更优的工作流，加速开发进程**

A crucial part of Shotgun's deployment workflow is the use of deployment branches that Vercel automatically provisions upon each \`git commit\`. Opening a pull request generates a corresponding Vercel Preview Deployment, which the team uses for testing, staging, and ultimately deployment to production. It’s a simple and familiar workflow.

Shotgun 部署流程中至关重要的一环，是利用 Vercel 在每次 \`git commit\` 后自动创建的部署分支。发起 Pull Request 即自动生成对应的 Vercel 预览部署（Preview Deployment），团队借此开展测试、预发布验证，并最终上线至生产环境。这一流程简洁直观，且广为开发者所熟悉。

[The team at Shotgun](https://shotgun.teamtailor.com/jobs) has improved the rest of their dev workflow, too. They use [Edge Config](https://vercel.com/blog/edge-config-public-beta) to quickly configure new waiting rooms in preparation for ticket drops. This prevents them from having to deploy each time a new waiting room is needed. When combined with [Vercel Instant Rollbacks](https://vercel.com/docs/concepts/deployments/instant-rollback) and [Edge Functions](https://vercel.com/features/edge-functions), Shotgun’s new workflow has given them more time to iterate at scale. As Lucas explains, “Using Vercel has made us more confident in serving larger and larger clients. Vercel has really unlocked that scalability for us.”

[Shotgun 团队](https://shotgun.teamtailor.com/jobs) 同样优化了其余开发工作流。他们借助 [Edge Config](https://vercel.com/blog/edge-config-public-beta) 快速配置新的排队等候页面（waiting room），为开票活动做好准备——从而避免每次新增等候页都需重新部署。再结合 [Vercel 即时回滚（Instant Rollbacks）](https://vercel.com/docs/concepts/deployments/instant-rollback) 与 [Edge Functions（边缘函数）](https://vercel.com/features/edge-functions)，Shotgun 全新的工作流显著节省了时间，使其得以在更大规模上持续快速迭代。正如卢卡斯所言：“采用 Vercel 让我们更有信心服务日益庞大的客户群体。Vercel 真正为我们解锁了这种可扩展性。”

## **Simplifying their setup**

## **简化系统架构**

With its accessibility for small and large companies alike, Shotgun can experience the many Vercel features developers love. One example: [Vercel Cron Jobs](https://vercel.com/blog/cron-jobs). Migrating from Shotgun’s previous Firebase function to Cron was seamless—taking just five minutes. On a macro level, the team enjoys how intuitive using Vercel has been. They don’t have to fight with the UI or struggle to find what they’re looking for. Everything just works.

凭借对小型与大型公司同样友好的易用性，Shotgun 能够充分体验开发者所钟爱的众多 Vercel 功能。其中一个典型示例是：[Vercel 定时任务（Cron Jobs）](https://vercel.com/blog/cron-jobs)。从 Shotgun 此前使用的 Firebase 函数迁移至 Vercel Cron 任务过程极为顺畅——仅耗时五分钟。从宏观层面来看，团队十分欣赏 Vercel 的直观易用性：无需与用户界面“搏斗”，也无需费力寻找所需功能——一切皆可开箱即用。

> “Vercel 凭借出色的用户体验（UX）和用户界面（UI），使用起来极为便捷。我们真切感受到，这是一款由开发者为开发者打造的产品。”  
> “Vercel 凭借出色的用户体验（UX）和用户界面（UI），使用起来极为便捷。我们真切感受到，这是一款由开发者为开发者打造的产品。”  
>  
> ![](images/managing-major-traffic-spikes-during-ticket-drops-with-vercel-vercel/img_002.png)  
>  
> **Antoine Rousseau**，高级软件工程师

## **下一步：进军美国与巴西——拓展至其他市场**

## **下一步：进军美国与巴西——拓展至其他市场**

While the team is based in Europe, they have a large user base growing in the United States and in Brazil that they’re looking forward to expanding. Features like [Edge Middleware](https://vercel.com/features/edge-functions) and Vercel’s [Real Experience Score](https://vercel.com/analytics) are helping Shotgun confidently grow that user base. They rely on Edge Middleware to fine-tune cookie handling, and they can see the impact of site updates in real time on actual users with [Vercel Analytics](https://vercel.com/analytics). Being able to track their site and app performance in these specific countries helps them better optimize for these new markets.

尽管团队总部位于欧洲，但他们正迎来美国与巴西两地日益增长的庞大用户群，并已着手积极拓展这两大市场。诸如 [Edge 中间件（Edge Middleware）](https://vercel.com/features/edge-functions) 以及 Vercel 的 [真实体验评分（Real Experience Score）](https://vercel.com/analytics) 等功能，正助力 Shotgun 更加自信地扩大其用户规模。团队借助 Edge 中间件精细调控 Cookie 处理逻辑；同时，通过 [Vercel Analytics](https://vercel.com/analytics)，他们能实时观测网站更新对真实用户产生的实际影响。针对这些特定国家的网站与应用性能进行精准追踪，使团队得以更高效地优化产品，以适配新兴市场的需求。

From Brazil to France, consumers around the world can continue encountering seamless buying experiences when they’re shopping with Shotgun. Next.js is the main framework for the startup’s site and dashboard. After recently upgrading their consumer site to Next.js 13 on React 18, the dev team experienced even more performance gains.

从巴西到法国，全球各地的消费者在使用 Shotgun 购物时，将持续享受流畅无阻的购物体验。Next.js 是该初创公司官网与管理后台所采用的核心框架。在近期将面向消费者的网站升级至基于 React 18 的 Next.js 13 后，开发团队进一步收获了显著的性能提升。

[**Ready to scale at the edge?**\\  
\\  
Talk to an expert about improving your own site's performance. \\  
\\  
Get in touch](https://vercel.com/contact)

[**准备好在边缘端实现规模化扩展了吗？**\\  
\\  
联系专家，探讨如何提升您自身网站的性能表现。\\  
\\  
立即联系](https://vercel.com/contact)
&#123;% endraw %}
