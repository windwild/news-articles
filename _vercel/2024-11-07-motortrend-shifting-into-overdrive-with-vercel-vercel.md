---
title: "MotorTrend: Shifting into overdrive with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/motortrend-shifting-into-overdrive-with-vercel"
date: "2024-11-07"
scraped_at: "2026-03-02T09:39:52.151645812+00:00"
language: "en-zh"
translated: true
description: "How a performance-first approach drives business value. By migrating to Vercel, MotorTrend improved release times from 18 days to 10 minutes. As velocity improved, ad impressions grew, translating int..."
---
{% raw %}

Nov 7, 2024

2024 年 11 月 7 日

How a performance-first approach drives business value.

以性能为先的方法如何驱动商业价值。

#### 18 days to 10 min

#### 从 18 天缩短至 10 分钟

Feature release timeline

功能发布周期

#### 7x faster

#### 构建速度提升 7 倍

Build times

构建耗时

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

[**Powered by** AWS](https://vercel.com/partners/aws)

[**由** AWS **提供支持**](https://vercel.com/partners/aws)

[MotorTrend](https://www.motortrend.com/)—a Warner Bros. Discovery company and the world’s leading media company on all things automotive—needed a digital experience as powerful as the vehicles they showcase. Bogged down by a legacy tech stack, their development team faced frustratingly long build times and a cumbersome release process. They knew a complete redesign wasn't the answer—they needed a platform upgrade.

[MotorTrend](https://www.motortrend.com/) — 华纳兄弟探索公司（Warner Bros. Discovery）旗下企业，也是全球首屈一指的汽车领域媒体公司 —— 需要打造一种数字体验，其强大程度须与他们所展示的车辆相匹配。然而，受限于陈旧的技术栈，其开发团队长期饱受构建耗时过长、发布流程繁琐之苦。他们深知，彻底重构并非解决方案——真正需要的是平台升级。

![](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_001.jpg)

## **Reducing build times and accelerating developer iteration**

## **缩短构建时间，加速开发者迭代**

MotorTrend's previous infrastructure and CI/CD pipelines—a self-managed setup using GitHub, Jenkins, and AWS—resulted in long build times and lengthy release cycles, delaying feature development and deployments. With Vercel, they saw a dramatic improvement, reducing build times by up to 7 times and enabling rapid feature releases.

MotorTrend 此前的基础设施与 CI/CD 流水线——一套基于 GitHub、Jenkins 和 AWS 的自托管架构——导致构建耗时漫长、发布周期冗长，严重拖慢了功能开发与上线进度。借助 Vercel，其构建效率实现显著跃升：构建时间最多缩短至原来的 1/7，并支持功能的快速发布。

![Before Vercel, MotorTrend's deployment process hinged on a single Release Candidate, where any feature failure could delay the entire release for weeks.](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_002.jpg)![Before Vercel, MotorTrend's deployment process hinged on a single Release Candidate, where any feature failure could delay the entire release for weeks.](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_003.jpg)![Before Vercel, MotorTrend's deployment process hinged on a single Release Candidate, where any feature failure could delay the entire release for weeks.](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_004.jpg)![Before Vercel, MotorTrend's deployment process hinged on a single Release Candidate, where any feature failure could delay the entire release for weeks.](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_005.jpg)Before Vercel, MotorTrend's deployment process hinged on a single Release Candidate, where any feature failure could delay the entire release for weeks.

![迁移至 Vercel 前，MotorTrend 的发布流程依赖单一发布候选版本（Release Candidate），任一功能出现故障都可能导致整版发布延迟数周。](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_002.jpg)![迁移至 Vercel 前，MotorTrend 的发布流程依赖单一发布候选版本（Release Candidate），任一功能出现故障都可能导致整版发布延迟数周。](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_003.jpg)![迁移至 Vercel 前，MotorTrend 的发布流程依赖单一发布候选版本（Release Candidate），任一功能出现故障都可能导致整版发布延迟数周。](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_004.jpg)![迁移至 Vercel 前，MotorTrend 的发布流程依赖单一发布候选版本（Release Candidate），任一功能出现故障都可能导致整版发布延迟数周。](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_005.jpg)迁移至 Vercel 前，MotorTrend 的发布流程依赖单一发布候选版本（Release Candidate），任一功能出现故障都可能导致整版发布延迟数周。

The faster build times and automatic [preview deployments](https://vercel.com/docs/deployments/preview-deployments) enabled the team to move from idea to prototype to preview, and ultimately production at a much faster pace. The team now focuses on feature development and iteration without being slowed by lengthy build and deployment processes and timed-release constraints.

更快的构建速度与自动化的[预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments)，使团队得以大幅提速：从创意构思 → 原型开发 → 预览验证 → 最终上线，全流程显著加速。如今，团队可专注于功能开发与持续迭代，不再受制于冗长的构建与部署流程，也无需受限于固定发布时间窗口。

The team's average feature release timeline from 18.9 days to just 10 minutes. This improvement transformed cross-team collaboration at MotorTrend by allowing teams to focus less on technical details and more on strategic, high-impact discussions.

团队平均功能发布周期从原先的 18.9 天大幅压缩至仅需 10 分钟。这一突破性提升重塑了 MotorTrend 的跨团队协作模式：各团队得以减少对底层技术细节的关注，转而聚焦于更具战略意义和高影响力的核心议题讨论。

> “With Vercel, Instant Rollbacks and Preview URLs are top-notch. We've been able to release and test so much faster.With Vercel, Instant Rollbacks and Preview URLs are top-notch. We've been able to release and test so much faster.”
>
> ![](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_006.jpg)
>
> **Arun Kambhammettu,** Senior Software Engineering Manager at Warner Bros. Discovery

> “借助 Vercel，即时回滚（Instant Rollbacks）与预览链接（Preview URLs）功能堪称业界标杆。我们已能以前所未有的速度完成发布与测试。”

> ![](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_006.jpg)
>
> **阿伦·坎巴梅图（Arun Kambhammettu）**，华纳兄弟探索公司（Warner Bros. Discovery）高级软件工程经理

With [development previews](https://vercel.com/products/previews) available [per git push](https://vercel.com/docs/deployments/git), per branch, even large companies can iterate quickly without conflicts. Vercel creates deployments on a per-branch basis, with only the "main" branch promoting deployments to production and being assigned to customer domains. This allows isolated environments for testing production-grade code, protected by authentication. This workflow is embedded by default for all plans, eliminating the need for custom CI/CD pipelines or integrating seamlessly into existing ones.

借助 [开发预览（Development Previews）](https://vercel.com/products/previews) 功能——支持每次 Git 提交（[per git push](https://vercel.com/docs/deployments/git)）、每个分支独立触发——即便是大型企业也能实现无冲突的快速迭代。Vercel 按分支创建部署环境，仅“main”分支可将部署推送至生产环境并绑定客户域名。该机制为生产级代码提供了受身份认证保护的隔离测试环境。此工作流已作为默认能力内置于所有服务计划中，既无需搭建定制化 CI/CD 流水线，也可与现有流水线无缝集成。

Once prototyped, the MotorTrend team shares the idea with Product and QA for approval. After receiving a reviewer's OK, passing component tests, and resolving comments via the Vercel Toolbar, a pull request can be approved. Finally, Vercel builds and deploys the application.

原型开发完成后，MotorTrend 团队即向产品与质量保障（QA）团队同步方案以待审批。在获得评审人批准、通过组件测试，并借助 Vercel 工具栏（Vercel Toolbar）完成意见回复与问题闭环后，即可批准对应 Pull Request。最终，Vercel 自动完成应用构建与部署。

![With Vercel, MotorTrend developers can now push, preview, and promote features to production anytime, independently of other features or branches.](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_007.jpg)![With Vercel, MotorTrend developers can now push, preview, and promote features to production anytime, independently of other features or branches.](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_008.jpg)![With Vercel, MotorTrend developers can now push, preview, and promote features to production anytime, independently of other features or branches.](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_009.jpg)![With Vercel, MotorTrend developers can now push, preview, and promote features to production anytime, independently of other features or branches.](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_010.jpg)With Vercel, MotorTrend developers can now push, preview, and promote features to production anytime, independently of other features or branches.

![借助 Vercel，MotorTrend 开发者如今可随时推送、预览并上线任意功能，全程完全独立于其他功能或分支。](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_007.jpg)![借助 Vercel，MotorTrend 开发者如今可随时推送、预览并上线任意功能，全程完全独立于其他功能或分支。](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_008.jpg)![借助 Vercel，MotorTrend 开发者如今可随时推送、预览并上线任意功能，全程完全独立于其他功能或分支。](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_009.jpg)![借助 Vercel，MotorTrend 开发者如今可随时推送、预览并上线任意功能，全程完全独立于其他功能或分支。](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_010.jpg)借助 Vercel，MotorTrend 开发者如今可随时推送、预览并上线任意功能，全程完全独立于其他功能或分支。

Previously, building the application—compiling the approved code for production—was a significant bottleneck in MotorTrend's workflow, often taking around 42 minutes. By adopting Next.js and deploying on Vercel, this process was streamlined to a mere 6 minutes. This rapid turnaround allowed developers to see their changes reflected almost instantly, minimizing context switching and further accelerating development cycles.

此前，构建应用——即编译已批准的代码以供生产环境使用——是 MotorTrend 工作流中的关键瓶颈，单次构建通常耗时约 42 分钟。通过采用 Next.js 并部署于 Vercel，该过程被大幅优化至仅需 6 分钟。如此迅捷的反馈闭环，使开发者几乎能实时看到自身修改效果，极大减少了上下文切换开销，进一步加快了整体开发节奏。

> “Previously, we faced challenges with environment differences across staging, development, pre-production, and production, but once we moved everything to Vercel, it was seamless. We didn't notice any environment differences at all. Previously, we faced challenges with environment differences across staging, development, pre-production, and production, but once we moved everything to Vercel, it was seamless. We didn't notice any environment differences at all.”  
>   
> “过去，我们在预发布（staging）、开发（development）、准生产（pre-production）和生产（production）等不同环境中曾面临环境差异带来的挑战；但一旦我们将所有内容迁移至 Vercel，整个过程便变得无缝顺畅——我们完全未察觉到任何环境差异。”  

> ![](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_006.jpg)  

> **Arun Kambhammettu**, Senior Software Engineering Manager at Warner Bros. Discovery  
> **Arun Kambhammettu**，华纳兄弟探索公司（Warner Bros. Discovery）高级软件工程经理  

## **Fueling business growth with performance**  
## **以卓越性能驱动业务增长**

Vercel’s [Framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) (Fdi) allows MotorTrend to deploy their [Next.js](https://nextjs.org/) application efficiently, removing the need for complex cloud infrastructure management. By utilizing the [Vercel Edge Network](https://vercel.com/docs/edge-network/overview), MotorTrend's site loads faster for users, leading to more ad impressions per page view and boosting revenue without requiring a redesign. This demonstrates the strong connection between optimized workflows, website performance, and business growth. The increase in ad impressions is directly linked to faster site speeds.  
Vercel 的 [框架定义基础设施（Framework-defined Infrastructure, FDI）](https://vercel.com/blog/framework-defined-infrastructure) 使 MotorTrend 能够高效部署其 [Next.js](https://nextjs.org/) 应用，彻底免除了对复杂云基础设施管理的需求。借助 [Vercel 边缘网络（Vercel Edge Network）](https://vercel.com/docs/edge-network/overview)，MotorTrend 网站的用户加载速度显著提升，从而在单次页面浏览中获得更高广告曝光量（ad impressions），在无需重新设计网站的前提下直接推动营收增长。这充分印证了优化工作流、网站性能与业务增长之间的紧密关联——广告曝光量的提升，正是网站加载速度加快的直接结果。

MotorTrend continues to optimize by using Vercel's Real Experience data within [Vercel Speed Insights](https://vercel.com/docs/speed-insights), providing detailed insights into their site's performance from real users. This data-driven strategy ensures continuous user experience improvements. They are also migrating their APIs to Next.js, enhancing performance, scalability, and maintainability. With sections like News and Buyers Guides already on Vercel—and the rest soon to follow—MotorTrend is committed to a performance-first future.  
MotorTrend 持续依托 [Vercel Speed Insights](https://vercel.com/docs/speed-insights) 中的“真实用户体验（Real Experience）”数据进行深度优化，从而获取来自真实用户的详尽性能洞察。这一数据驱动策略保障了用户体验的持续改进。同时，MotorTrend 正将其 API 迁移至 Next.js，进一步提升系统性能、可扩展性与可维护性。目前，其“新闻（News）”与“购车指南（Buyers Guides）”等栏目已全面运行于 Vercel 平台，其余部分也即将完成迁移——MotorTrend 坚定践行“性能优先”的未来战略。

Vercel is proud to partner with MotorTrend, enabling them to effortlessly handle increased demand, ensure top-tier performance, accelerate feature releases, and drive continuous improvement with data-driven insights, all while delivering exceptional digital experiences to automotive enthusiasts worldwide.  
Vercel 很荣幸与 MotorTrend 携手合作，助力其轻松应对激增的流量需求、确保业界顶尖的性能表现、加速新功能上线节奏，并依托数据驱动的深度洞察实现持续优化——与此同时，为全球汽车爱好者交付卓越的数字体验。

Vercel.com landing page  
Vercel.com 官网落地页  

### Learn more about Vercel Preview Deployments  
### 了解更多关于 Vercel 预览部署（Preview Deployments）的信息  

Blog post  
博客文章  

Mar 7, 2023  
2023 年 3 月 7 日  

### Framework-defined infrastructure  
### 框架定义基础设施

![](images/motortrend-shifting-into-overdrive-with-vercel-vercel/img_012.jpg)

Malte Ubl  
马尔特·乌布爾
{% endraw %}
