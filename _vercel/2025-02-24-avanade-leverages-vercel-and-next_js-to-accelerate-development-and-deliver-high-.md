---
render_with_liquid: false
title: "Avanade leverages Vercel and Next.js to accelerate development and deliver high-performance experiences - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/integrating-vercel-and-sitecore-for-2x-faster-development-times-and-111"
date: "2025-02-24"
scraped_at: "2026-03-02T09:36:17.217829060+00:00"
language: "en-zh"
translated: true
description: "Learn how Avanade achieved 90+ Lighthouse Scores by moving away from monolith legacy systems to Sitecore XM Cloud and Vercel."
---
render_with_liquid: false
render_with_liquid: false

Feb 24, 2025

2025 年 2 月 24 日

Learn how Avanade achieved 90+ Lighthouse scores by going headless with Sitecore XM Cloud and Vercel.

了解 Avanade 如何通过采用无头架构（headless architecture），结合 Sitecore XM Cloud 与 Vercel，实现 Lighthouse 评分 90 分以上。

[Avanade](https://www.avanade.com/en-us) is the world’s leading expert on Microsoft which delivers AI-driven solutions for cloud, data analytics, cybersecurity, and ERP.

[Avanade](https://www.avanade.com/en-us) 是全球首屈一指的 Microsoft 解决方案专家，致力于为云服务、数据分析、网络安全及企业资源规划（ERP）提供由人工智能驱动的解决方案。

The team at Avanade started on a comprehensive transformation, ultimately adopting [Next.js](https://vercel.com/frameworks/nextjs), Vercel, and [Sitecore XM Cloud](https://vercel.com/docs/integrations/cms/sitecore) to establish a modern, composable system capable of delivering highly responsive experiences to global clients. This migration helped replace monolithic systems with tightly coupled components and manual deployments, which hurt performance and feature rollouts.

Avanade 团队启动了一项全面的数字化转型，最终采用 [Next.js](https://vercel.com/frameworks/nextjs)、Vercel 与 [Sitecore XM Cloud](https://vercel.com/docs/integrations/cms/sitecore)，构建起一套现代化、可组合（composable）的技术体系，从而为全球客户提供高度响应式的数字体验。此次迁移成功取代了原有单体式（monolithic）系统——这类系统组件耦合度高、依赖人工部署，严重制约了性能表现与新功能上线速度。

![](images/avanade-leverages-vercel-and-next_js-to-accelerate-development-and-deliver-high-/img_001.jpg)

## Seeing the value after digital transformation

## 数字化转型后的实际成效

Vercel integrates with Avanade’s Microsoft-first operations, like [Azure DevOps](https://vercel.com/changelog/vercel-extension-for-azure-devops-now-available), and enables a more flexible, cloud-native approach. It eliminates siloed content workflows, delayed updates, and monolithic dependencies that prevented teams from quickly incorporating new features or responding to market shifts.

Vercel 深度集成 Avanade 以 Microsoft 为核心的技术生态（例如 [Azure DevOps](https://vercel.com/changelog/vercel-extension-for-azure-devops-now-available)），赋能更灵活、更原生的云架构实践。它消除了内容工作流彼此割裂、更新延迟以及单体式依赖等问题，使团队得以快速引入新功能，并敏捷响应市场变化。

The new stack combines edge computing, automatic scaling, and user-friendly [CI/CD workflows](https://vercel.com/products/previews). Vercel’s Edge Network intelligently caches and delivers content, improving page load times for Avanade’s global clients. Tight integration with [Next.js](https://nextjs.org/) allows the company to use [Server-Side Rendering](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr) (SSR), [Static Site Generation](https://vercel.com/docs/infrastructure/compute#static-site-generation---ssg) (SSG), and [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration#incremental-static-regeneration-isr) (ISR) for an [ideal balance](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app) of speed and real-time data capabilities.

这套全新技术栈融合了边缘计算（edge computing）、自动扩缩容（automatic scaling）以及用户友好的 [CI/CD 工作流](https://vercel.com/products/previews)。Vercel 边缘网络（Edge Network）智能缓存并分发内容，显著提升了 Avanade 全球客户的页面加载速度。其与 [Next.js](https://nextjs.org/) 的深度集成，使公司能够灵活运用 [服务端渲染（SSR）](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr)、[静态站点生成（SSG）](https://vercel.com/docs/infrastructure/compute#static-site-generation---ssg) 和 [增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration#incremental-static-regeneration-isr)，在极致性能与实时数据能力之间达成 [理想平衡](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app)。

![Avanade's Core Web Vitals results after migrating to Vercel and Next.js.](images/avanade-leverages-vercel-and-next_js-to-accelerate-development-and-deliver-high-/img_002.jpg)![Avanade's Core Web Vitals results after migrating to Vercel and Next.js.](images/avanade-leverages-vercel-and-next_js-to-accelerate-development-and-deliver-high-/img_003.jpg)

Avanade's Core Web Vitals results after migrating to Vercel and Next.js.

Avanade 迁移至 Vercel 与 Next.js 后的 Core Web Vitals 表现结果。

[Vercel functions](https://vercel.com/docs/functions) handle backend logic, reducing the need for dedicated server infrastructure. This approach allows the architecture to scale automatically based on traffic demands and **resulted in a 42% decrease in carbon emissions.**

[Vercel 函数](https://vercel.com/docs/functions) 负责处理后端逻辑，从而减少了对专用服务器基础设施的需求。该方案使架构能够根据流量需求自动伸缩，并**使碳排放量降低了 42%**。

> “Vercel transformed our development workflow, providing seamless deployments, optimized performance, and a fantastic developer experience. The scalability and speed unlocked by this combination allowed us to focus on building great user experiences rather than managing infrastructure.Vercel transformed our development workflow, providing seamless deployments, optimized performance, and a fantastic developer experience. The scalability and speed unlocked by this combination allowed us to focus on building great user experiences rather than managing infrastructure.”
>
> “Vercel 彻底革新了我们的开发工作流，实现了无缝部署、性能优化以及卓越的开发者体验。这种组合所释放的可扩展性与速度，使我们得以专注于打造出色的用户体验，而非耗费精力管理基础设施。”

> ![](images/avanade-leverages-vercel-and-next_js-to-accelerate-development-and-deliver-high-/img_004.png)
>
> ![](images/avanade-leverages-vercel-and-next_js-to-accelerate-development-and-deliver-high-/img_004.png)

> **Hing Yon,** Platform Owner & Technical Lead
>
> **Hing Yon**，平台负责人兼技术主管

Additionally, content is managed in [Sitecore XM Cloud and Content Hub](https://vercel.com/partners/sitecore), centralizing asset management and editorial workflows. The headless architecture bridges communication between these platforms and the frontend using modern APIs.

此外，内容由 [Sitecore XM Cloud 和 Content Hub](https://vercel.com/partners/sitecore) 统一管理，实现了数字资产管理和编辑工作流的集中化。这种无头架构（headless architecture）借助现代化 API，在上述平台与前端之间构建起高效通信桥梁。

Other user experience improvements include:

其他用户体验提升成果包括：

- **9%** increase in site visits  
- 网站访问量提升 **9%**

- **13%** more returning visitors  
- 回访用户增长 **13%**

- customers able to find products **14%** quicker  
- 用户查找商品的速度提升 **14%**

- **43%** longer time on site per visitor  
- 每位访客的平均停留时长延长 **43%**

- **56%** higher sales from returning customers  
- 回访用户的销售额提升 **56%**

- **111%** higher conversions  
- 转化率提升 **111%**

This transition to Next.js also provided Avanade with a decoupled frontend framework, paving the way for a more modular, adaptable architecture.

此次向 Next.js 的迁移还为 Avanade 提供了一个解耦的前端框架，为构建更模块化、更灵活的架构铺平了道路。

### Improving the developer experience

### 提升开发者体验

Automated CI/CD pipelines have accelerated development cycles, as code commits now trigger instant [Preview Deployments](https://vercel.com/docs/deployments/preview-deployments) that facilitate real-time collaboration and early feedback. The operations team noted a substantial decrease in maintenance overhead, having moved away from manually provisioning servers and troubleshooting load-related issues.

自动化的 CI/CD 流水线显著加快了开发周期：如今每次代码提交都会即时触发 [预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments)，从而支持实时协作与早期反馈。运维团队观察到，随着不再需要手动配置服务器及排查负载相关问题，日常维护开销大幅降低。

Key developer experience improvements include:

关键的开发者体验提升包括：

- **2x** faster site development time  
- 站点开发时间提升 **2 倍**

- **2x** faster content delivery at scale  
- 大规模内容交付速度提升 **2 倍**

- **33%** faster content changes  
- 内容更新速度提升 **33%**

Avanade’s adoption of Vercel delivers new levels of performance agility, empowering teams to innovate more freely. By streamlining deployments and embracing a composable architecture, Avanade can now respond more quickly to market needs while retaining its existing technology foundations.

Avanade 采用 Vercel 实现了前所未有的性能敏捷性，赋能团队更自由地开展创新。通过简化部署流程并拥抱可组合式架构，Avanade 现在能够更快速响应市场需求，同时保留其既有的技术基础。

[**Let us know how we can help**\\
\\
Whether you're starting a migration, need help optimizing, or want to add AI to your apps and workflows, we're here to partner with you.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**告诉我们如何为您提供帮助**\\
\\
无论您正启动迁移项目、需要优化支持，还是希望为您的应用与工作流集成 AI 能力，我们都愿成为您值得信赖的合作伙伴。\\
\\
立即联系](https://vercel.com/contact/sales)

Customer case study  

客户案例研究

**30x** Faster response times

**30 倍更快的响应速度**

### Demant achieves global scalability and 30x faster response times with Vercel

### Demant 借助 Vercel 实现全球可扩展性，并将响应速度提升 30 倍

![](images/avanade-leverages-vercel-and-next_js-to-accelerate-development-and-deliver-high-/img_005.png)

Alli Pope

Alli Pope

Blog post

博客文章

Jan 12, 2023

2023 年 1 月 12 日

### Vercel + Sitecore: Partnering on a composable future

### Vercel + Sitecore：携手共建可组合的未来

![](images/avanade-leverages-vercel-and-next_js-to-accelerate-development-and-deliver-high-/img_006.jpg)

Guillermo Rauch

Guillermo Rauch