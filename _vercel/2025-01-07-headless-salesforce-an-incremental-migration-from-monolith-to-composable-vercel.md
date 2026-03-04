---
title: "Headless Salesforce: An incremental migration from monolith to composable - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/salesforce-incremental-migration"
date: "2025-01-07"
scraped_at: "2026-03-02T09:38:20.256389729+00:00"
language: "en-zh"
translated: true
description: "Go headless with your Salesforce storefront while keeping your commerce backend intact. Learn how to de-risk migration to Next.js and Vercel, reducing load times & boosting conversions."
---

render_with_liquid: false
Jan 7, 2025

2025 年 1 月 7 日

Keep your commerce backend and de-risk your migration.

保持您的电商后端稳定，同时降低迁移风险。

For ecommerce teams running Salesforce Commerce Cloud, the platform's monolithic design can feel like a double-edged sword. While its out-of-the-box capabilities promise rapid deployments, they often hinder frontend flexibility and innovation. But what if you could unlock a new level of performance—without risking your core business?

对于运行 Salesforce Commerce Cloud 的电商团队而言，该平台的单体式架构犹如一把双刃剑：开箱即用的功能虽能实现快速部署，却常常制约前端的灵活性与创新力。但倘若您能在不危及核心业务的前提下，释放出更高层级的性能表现，又当如何？

That’s exactly what a global sportswear brand achieved. Their headless Salesforce migration strategy halved their load times, cut cart abandonment by 28%, and increased mobile conversion rates by 15%. All without a disruptive, big-bang migration.

这正是某全球知名运动服饰品牌所实现的成果：其无头化 Salesforce 迁移策略将页面加载时间缩短一半，购物车放弃率降低 28%，移动端转化率提升 15%——整个过程未采用高风险、全盘替换式的“大爆炸式”迁移。

Here’s how they did it and how you can too.

以下便是他们实现这一目标的具体路径，以及您同样可以借鉴的方法。

> “We now have visibility into our performance we never had before. When issues arise, we can pinpoint and fix them faster. That said, during BFCM, we're so bored because nothing's happening—we're just watching the sales go up.We now have visibility into our performance we never had before. When issues arise, we can pinpoint and fix them faster. That said, during BFCM, we're so bored because nothing's happening—we're just watching the sales go up.”
>
> ![](images/headless-salesforce-an-incremental-migration-from-monolith-to-composable-vercel/img_001.png)
>
> **Lead Developer,** Sportswear Retailer

> “如今，我们拥有了前所未有的系统性能可见性。一旦出现问题，我们能更快地精准定位并修复。话说回来，每逢‘黑色星期五+网络星期一’（BFCM）大促期间，我们反而觉得有点无聊——因为一切风平浪静，我们只需静静看着销售额持续攀升。”  
>   
> ![](images/headless-salesforce-an-incremental-migration-from-monolith-to-composable-vercel/img_001.png)  
>   
> **首席开发工程师**，运动服饰零售商

## The case for migration

## 迁移的必要性

Ecommerce teams often outgrow Salesforce Commerce Cloud's monolithic architecture for a few reasons:

电商团队之所以常常超越 Salesforce Commerce Cloud 单体架构的能力边界，主要原因有以下几点：

- **Architectural constraints:** Teams are forced to implement personalization client-side, leading to duplicate downloads and slower page loads

- **架构限制**：团队被迫在客户端实现个性化功能，导致资源重复下载、页面加载速度变慢；

- **Limited tooling choices:** Integrating best-in-class solutions often requires clunky workarounds, leaving engineers feeling constrained in technical choices to build better features and experiences

- **工具链选择受限**：集成业界领先解决方案时，往往需依赖笨拙的变通方案，致使工程师在技术选型上束手束脚，难以构建更优的功能与用户体验。

- **Scalability struggles:** During peak traffic events, issues like bloated tag managers, inefficient data pipelines, and unoptimized assets make Salesforce sites prone to slowdowns or worse—downtime  

- **可扩展性困境：** 在流量高峰期，臃肿的标签管理器、低效的数据管道以及未优化的静态资源等问题，会使 Salesforce 网站极易出现响应迟缓，甚至更严重的——服务中断。

These limitations affect more than just performance and sales. They hurt developer experience by requiring specialized skills and tribal knowledge, which limits your ability to hire and retain talent.

这些限制所影响的远不止系统性能与销售转化。它们还严重损害开发者体验——要求团队掌握高度专业化的技能和仅在内部流传的“隐性知识”，从而制约了您吸引和留住优秀人才的能力。

This prevents you from setting a strong foundation for the future, and it contributes to poor user experiences that frustrate customers and drive them away.

这使您难以构建面向未来发展的坚实基础，同时加剧了糟糕的用户体验，令客户感到沮丧，最终导致客户流失。

## Migration strategy: Moving forward without the risks  

## 迁移策略：在规避风险的前提下稳步推进

Replacing an ecommerce platform wholesale is daunting, especially when it handles millions or billions in annual revenue. Instead, teams can take an incremental approach, focusing on these key areas:

全面替换一个电商平台令人望而生畏，尤其当该平台承载着每年数百万乃至数十亿美元的营收时。取而代之的是，团队可采用渐进式迁移路径，聚焦于以下关键领域：

- **Choosing the right frontend framework:** While Salesforce offers PWA Kit as a frontend solution, [Next.js](https://nextjs.org/) provides a more robust and flexible approach for large-scale ecommerce sites and benefits from an active open-source community. Next.js includes server-side rendering, image optimization, built-in routing, and vast community libraries of pre-built components. This accelerates development and allows for seamless integration with various backend systems, including Salesforce Commerce Cloud.

- **选择合适的前端框架：** 尽管 Salesforce 提供了 PWA Kit 作为前端解决方案，但 [Next.js](https://nextjs.org/) 为大规模电商网站提供了更稳健、更灵活的技术路径，并得益于活跃的开源社区支持。Next.js 内置服务端渲染（SSR）、图片优化、路由系统，以及海量由社区维护的预构建组件库。这不仅显著加快开发速度，还能与包括 Salesforce Commerce Cloud 在内的各类后端系统实现无缝集成。

- **Planning for incremental traffic management:** Edge Middleware—built into Next.js and supported by the Vercel platform—allows for intelligent and gradual traffic rerouting between your new Vercel-hosted application and your existing application.

- **规划渐进式流量管理：** 内置于 Next.js 并由 Vercel 平台原生支持的边缘中间件（Edge Middleware），可实现在您的新 Vercel 托管应用与现有应用之间进行智能、平滑的流量分流与迁移。

- **Ensuring business continuity:** Preserve existing data and integrations while progressively introducing a new headless layer.

- **保障业务连续性：** 在逐步引入全新无头架构（headless layer）的同时，完整保留现有数据与系统集成。

This strategy enables you to migrate one page or route at a time, minimizing risk during the transition. You get immediate access to modern frontend capabilities while maintaining your existing Salesforce backend infrastructure, allowing you to upgrade at your own pace.

该策略支持以单页或单路由为单位逐个迁移，最大限度降低过渡期风险。您可即刻获得现代化前端能力，同时继续沿用现有的 Salesforce 后端基础设施，从而按自身节奏稳步推进升级。

## Technical strategies for a smooth migration  

## 平滑迁移的技术策略

Transitioning your ecommerce platform can feel overwhelming, but these practical tips ensure a smooth transition while minimizing risks.

将您的电商平台进行迁移可能令人望而生畏，但以下实用建议可确保迁移过程平稳顺畅，同时最大限度降低风险。

### **Start with the frontend**

### **从前端入手**

Build a new presentation with Next.js while keeping Salesforce Commerce Cloud as the backend. This approach allows you to tackle performance issues incrementally without a full system overhaul.

使用 Next.js 构建全新的前端界面，同时保留 Salesforce Commerce Cloud 作为后端。该方案使您能够逐步解决性能问题，而无需对整个系统进行彻底重构。

Start small with a single page or route of your application. You can choose a less critical or lower-traffic page to ensure everything works correctly.

从小处着手，先迁移应用中的单个页面或路由。您可以选择一个非核心功能页面或流量较低的页面，以确保各项功能正常运行。

![The Next.js, Vercel, and headless Salesforce stack.](images/headless-salesforce-an-incremental-migration-from-monolith-to-composable-vercel/img_002.jpg)![The Next.js, Vercel, and headless Salesforce stack.](images/headless-salesforce-an-incremental-migration-from-monolith-to-composable-vercel/img_003.jpg)The Next.js, Vercel, and headless Salesforce stack.

![Next.js、Vercel 与无头 Salesforce 技术栈。](images/headless-salesforce-an-incremental-migration-from-monolith-to-composable-vercel/img_002.jpg)![Next.js、Vercel 与无头 Salesforce 技术栈。](images/headless-salesforce-an-incremental-migration-from-monolith-to-composable-vercel/img_003.jpg)Next.js、Vercel 与无头 Salesforce 技术栈。

### **Use Edge Middleware for traffic control**

### **利用 Edge Middleware 实现流量管控**

Use [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) to create a reverse proxy by defining rewrites directly in your Next.js configuration. This dynamically routes traffic between your existing app and your new Next.js app on Vercel. For further control, you can also add A/B testing or use percentage-based rollouts.

使用 [Edge Middleware](https://vercel.com/docs/functions/edge-middleware)，通过在 Next.js 配置中直接定义重写规则（rewrites）来构建反向代理。该机制可动态地在现有应用与部署于 Vercel 的新 Next.js 应用之间分配流量。如需更精细的控制，您还可进一步集成 A/B 测试，或采用基于百分比的渐进式发布策略。

This approach enables you to incrementally migrate and test features progressively. Deploying your app to Vercel also enables [near-instant rollback capabilities](https://vercel.com/docs/deployments/instant-rollback) if something goes wrong.

该方法支持您以渐进方式完成迁移与功能验证。此外，将应用部署至 Vercel 还可提供 [近乎即时的回滚能力](https://vercel.com/docs/deployments/instant-rollback)，一旦出现问题即可迅速恢复。

### **Synchronize user sessions**

### **同步用户会话**

Implement shared session strategies, such as encrypted cookies and centralized session storage, to ensure a consistent user experience across both platforms. This prevents users from experiencing issues like having to log in twice or losing shopping cart items.

实施共享会话策略，例如加密 Cookie 和集中式会话存储，以保障用户在两个平台间切换时获得一致的体验。此举可避免用户遭遇重复登录、购物车内容丢失等问题。

Additionally, you can set up JWT-based authentication to pass user data securely between apps without database lookups. Edge validation ensures consistent user states across the platform while maintaining sub-100ms response times.

此外，您还可以配置基于 JWT 的身份认证，以便在应用之间安全地传递用户数据，且无需查询数据库。边缘验证（Edge validation）确保平台各处的用户状态保持一致，同时维持低于 100 毫秒的响应时间。

### **Preserve SEO rankings**

### **保持搜索引擎优化（SEO）排名**

To [avoid disrupting search engine visibility](https://vercel.com/resources/how-to-plan-a-successful-composable-commerce-migration#plan-for-seo), maintain existing URL structures and manage redirects carefully, using Edge Middleware to ensure minimal latency for users. Implement proper canonical tags and monitor Google Search Console as you move pages and compare old data to new data to ensure continuity.

为[避免影响搜索引擎可见性](https://vercel.com/resources/how-to-plan-a-successful-composable-commerce-migration#plan-for-seo)，请保留现有 URL 结构，并谨慎管理重定向；可借助 Edge Middleware 确保终端用户延迟最低。迁移页面时，请正确设置规范标签（canonical tags），并持续监控 Google 搜索控制台（Google Search Console），将旧数据与新数据进行比对，以保障 SEO 连续性。

### **Test in real-world conditions**

### **在真实场景下测试**

Use Salesforce Commerce Cloud's sandbox environments to create pre-production instances with representative data. This allows you to thoroughly test your Next.js frontend against realistic data sets without affecting your live store.

利用 Salesforce Commerce Cloud 的沙盒环境，创建具备代表性数据的预发布实例。这使您能够在不影响线上商店的前提下，使用贴近真实的数据集对 Next.js 前端进行全面测试。

Vercel’s [preview deployments](https://vercel.com/docs/deployments/preview-deployments) create a unique URL, allowing you to test changes before they go live. You may also configure [custom environments](https://vercel.com/docs/deployments/custom-environments) on Vercel to mimic your organization’s workflow.

Vercel 的[预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments) 会生成唯一 URL，让您可在变更上线前先行测试。您还可于 Vercel 配置[自定义环境（Custom Environments）](https://vercel.com/docs/deployments/custom-environments)，以精准模拟组织内部的工作流。

### Mitigate Salesforce API challenges

### 缓解 Salesforce API 相关挑战

Next.js's composability provides granular control over [data fetching and caching](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching). By strategically caching API responses and leveraging [Incremental Static Regeneration (ISR)](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content), you can significantly reduce the number of requests to Salesforce Commerce Cloud, minimize API rate limit issues, and improve overall performance.

Next.js 的可组合性（composability）为您提供了对[数据获取与缓存](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching)的精细化控制能力。通过策略性地缓存 API 响应，并结合使用[增量静态再生（Incremental Static Regeneration, ISR）](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)，您可大幅降低对 Salesforce Commerce Cloud 的请求次数，缓解 API 调用频率限制问题，并全面提升系统性能。

## Results: Performance and business gains

## 成果：性能提升与业务增长

When we recently helped a global sportswear brand through this migration, they saw measurable improvements in site performance, developer productivity, and revenue.

近期，我们协助一家全球知名运动服饰品牌完成此次迁移后，其网站性能、开发人员生产力及营收均实现了可量化的显著提升。

They began with their homepage as an isolated test case, but when they saw great results, **they accelerated their entire migration timeline from five months to two month.**

他们最初仅将首页作为独立的测试用例，但当看到显著成效后，**便将整体迁移时间表从五个月大幅缩短至两个月。**

### Performance metrics

### 性能指标

During high-traffic periods, the new architecture proved to be 10x faster than Salesforce Commerce Cloud alone in load testing. This improvement came from edge computing, server-side rendering, and optimized data management.

在高流量时段，新架构在负载测试中展现出比纯 Salesforce Commerce Cloud 快 10 倍的性能。这一提升得益于边缘计算、服务端渲染（SSR）以及优化的数据管理。

Core Web Vitals directly relate to [search ranking](https://vercel.com/blog/how-core-web-vitals-affect-seo) and [site usability](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud). All metrics saw sizable improvements:

核心网页指标（Core Web Vitals）直接影响[搜索引擎排名](https://vercel.com/blog/how-core-web-vitals-affect-seo)和[网站可用性](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud)。所有指标均实现了显著提升：

- Time to First Byte (TTFB): 2.0s → 0.8s  
- 首字节时间（TTFB）：2.0 秒 → 0.8 秒  

- First Contentful Paint (FCP): 3.2s → 1.8s  
- 首次内容绘制（FCP）：3.2 秒 → 1.8 秒  

- Largest Contentful Paint (LCP): 4.0s → 2.4s  
- 最大内容绘制（LCP）：4.0 秒 → 2.4 秒  

- Interaction to Next Paint (INP): 350ms → 200ms  
- 下一次绘制前的交互延迟（INP）：350 毫秒 → 200 毫秒  

- Cumulative Layout Shift (CLS): 0.1 (maintained)  
- 累积布局偏移（CLS）：0.1（保持稳定）

### Productivity improvements

### 生产力提升

Development teams were able to release more frequently—and with more confidence—in a more enjoyable working environment.

开发团队得以更频繁地发布版本——且信心更足——同时工作环境也更加愉悦。

- Deployment times reduced from hours to minutes

- 部署时间从数小时缩短至数分钟

- Rollback times reduced to seconds

- 回滚时间缩短至秒级

- Feature deployment controlled via feature flags

- 功能发布通过功能开关（feature flags）进行管控

- 40% improvement in development team retention

- 开发团队人员保留率提升 40%

### Business impact

### 商业影响

Improving the infrastructure and user experience directly translated to better converts and revenue.

基础设施与用户体验的优化，直接转化为更高的转化率与营收。

- 28% decrease in cart abandonment rates

- 购物车放弃率降低 28%

- 15% increase in mobile conversion rates

- 移动端转化率提升 15%

- $10M in incremental quarterly online sales

- 季度线上销售额增量达 1000 万美元

- Black Friday 期间零停机，即使并发用户数超过 125,000  

- 黑色星期五期间零停机，即使并发用户数超过 12.5 万。

Like most major platform transitions, this migration is an ongoing journey. The team plans several upcoming improvements, including a microservices-based checkout system, optimization of third-party scripts, and moving personalization to the edge.

与大多数大型平台迁移一样，此次迁移是一场持续进行的旅程。团队已规划多项后续优化，包括基于微服务的结账系统、第三方脚本的性能优化，以及将个性化能力迁移至边缘（edge）。

The team remains confident in their direction, thanks to their enhanced capability to quickly spot, evaluate, and fix issues through better [monitoring](https://vercel.com/docs/observability) and [regular performance audits](https://vercel.com/blog/technical-audits) with our professional services team.

得益于更完善的监控能力以及与 Vercel 专业服务团队合作开展的定期性能审计，团队得以更快地发现、评估并修复问题，因此对当前技术路线充满信心。  
（相关文档：[监控](https://vercel.com/docs/observability)｜[定期技术审计](https://vercel.com/blog/technical-audits)）

## The key takeaways

## 核心启示

Migrating away from Salesforce Commerce Cloud doesn’t have to mean starting over. By focusing on the frontend and leveraging tools that allow an at-your-own-pace approach, you can unlock a faster, more scalable platform—without the risks of full re-platforming. The key to success is to start small and partner with experts who have done this before.

从 Salesforce Commerce Cloud 迁移，并不意味着一切归零重来。通过聚焦前端架构，并借助支持渐进式演进的工具，您即可构建出更快速、更具可扩展性的新平台，同时规避全量重构（full re-platforming）带来的风险。成功的关键在于小步快跑、稳步推进，并携手拥有同类项目实战经验的专家团队。

Ready to see what a migration looks like for you? [Contact our team to start your migration today.](https://vercel.com/contact/sales)

您是否想了解本次迁移将如何适配您的业务？[立即联系我们的团队，开启您的迁移之旅。](https://vercel.com/contact/sales)

Vercel.com landing page

Vercel.com 官网落地页

### Salesforce Commerce Cloud + Vercel

### Salesforce Commerce Cloud + Vercel

Blog post

博客文章

Nov 27, 2024

2024 年 11 月 27 日

### Retailer sees $10M increase in sales on Vercel

### 零售商在 Vercel 上实现销售额增长 1000 万美元

![](images/headless-salesforce-an-incremental-migration-from-monolith-to-composable-vercel/img_004.jpg)

Alina Weinstein

阿莉娜·魏因斯坦