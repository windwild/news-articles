---
title: "How Whop improved their Real Experience Score by 200% with the Next.js App Router - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-whop-improved-their-real-experience-score-by-200-with-the-next-js-app"
date: "2023-09-21"
scraped_at: "2026-03-02T09:50:31.131732654+00:00"
language: "en-zh"
translated: true
description: "Whop improved developer experience with Vercel and Next.js"
---
&#123;% raw %}

Sep 21, 2023

2023 年 9 月 21 日

#### 30s to high 90s

RES 提升效果

#### 13% to 47%

优质 URL 比例提升

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Next.js

Next.js

Routing Middleware

路由中间件

Comments

评论

Preview Deployments

预览部署

ISR

增量静态再生（ISR）

Integrations

集成

[Whop](https://whop.com/), an online marketplace for digital products, recognized the importance of having a seamless developer and end-user experience and aimed to transform their platform with a modern tech stack.

[Whop](https://whop.com/) 是一个面向数字产品的在线市场，认识到打造无缝的开发者与终端用户体验至关重要，并致力于借助现代化技术栈重构其平台。

To achieve this, they focused on migrating from Ruby on Rails to [Next.js](https://vercel.com/solutions/nextjs), quickly followed by the incremental adoption of [App Router](https://nextjs.org/docs/app) for even better page speed and developer experience.

为实现这一目标，他们率先将技术栈从 Ruby on Rails 迁移至 [Next.js](https://vercel.com/solutions/nextjs)，随后逐步采用 [App Router](https://nextjs.org/docs/app)，以进一步提升页面加载速度和开发者体验。

![](images/how-whop-improved-their-real-experience-score-by-200-with-the-next_js-app-router/img_001.jpg)

## **The initial migration to Next.js for speed, SEO, and DX**

## **首次迁移至 Next.js：提速、优化 SEO 与改善开发者体验**

Whop's journey with Next.js and Vercel began with a desire to accelerate their dev process while boosting SEO and performance.

Whop 与 Next.js 及 Vercel 的合作始于对加速开发流程、同时提升搜索引擎优化（SEO）效果与整体性能的迫切需求。

Previously, they were using a full-stack Ruby on Rails application but wanted to explore React for its better developer experience (DX). After extensive research, they decided that Next.js was the ideal choice for their frontend needs, thanks to its strong focus on SEO and speed.

此前，他们使用的是全栈式 Ruby on Rails 应用，但希望尝试 React——因其更出色的开发者体验（DX）。经过深入调研，他们最终认定 Next.js 是前端需求的理想选择，这得益于其对 SEO 和页面加载速度的卓越支持。

Next.js offers [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) (ISR), which allows updates on specific pages as needed—while maintaining page load speeds as fast as statically generated sites. This functionality would give Whop faster pages and better search engine ranking.

Next.js 提供 [增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration)，支持按需更新特定页面，同时保持与纯静态生成网站相当的页面加载速度。该功能将助力 Whop 实现更快的页面响应与更优的搜索引擎排名。

They split their tech stack, with Next.js powering the frontend and their existing Rails API handling the backend. This migration to Next.js took just three months of work, and the results were unveiled in a single release.

他们将技术栈进行了拆分：前端由 Next.js 驱动，后端则继续由其现有的 Rails API 承担。此次向 Next.js 的迁移仅耗时三个月，最终成果通过一次发布全面上线。

[**Want to talk to an expert?**  
**想与专家交流？**

Brainstorm with our team about your unique use case of Next.js.  
与我们的团队一起，围绕您独特的 Next.js 使用场景展开头脑风暴。

Send us a message](https://vercel.com/contact/sales)  
[联系我们](https://vercel.com/contact/sales)

## **Adopting App Router for speed and efficiency**  
## **采用 App Router 以提升速度与效率**

Whop initially started with Next.js using the Pages Router, and they continue to use it for certain parts of their application. They also incrementally migrated much of the Pages Router to App Router, which offers enhanced speed and support for [React Server Components](https://vercel.com/blog/understanding-react-server-components).

Whop 最初基于 Next.js 的 Pages Router 启动项目，并至今仍在应用的某些模块中沿用该路由方案。与此同时，他们也逐步将大量 Pages Router 代码迁移到 App Router —— 后者不仅性能更优，还原生支持 [React Server Components（React 服务端组件）](https://vercel.com/blog/understanding-react-server-components)。

In order to incrementally migrate, they used [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) to route traffic between an App Router project and their existing pages project on [whop.com](http://whop.com/). The strategic use of Edge Middleware allowed them to gradually roll out significant site changes while still supporting legacy components.

为实现渐进式迁移，他们借助 [Edge Middleware（边缘中间件）](https://vercel.com/docs/functions/edge-middleware)，在 App Router 项目与现有 Pages Router 项目（部署于 [whop.com](http://whop.com/)）之间智能分流流量。这种对 Edge Middleware 的战略性运用，使他们得以平稳、分阶段地推行重大站点变更，同时持续兼容遗留功能模块。

### React Server Components for a more cohesive DX  
### React Server Components：打造更统一的开发者体验（DX）

Whop's decision to move to App Router was motivated by their commitment to DX, citing solutions like React Server Components. This transition allowed them to bridge the gap between frontend and backend within a single framework.

Whop 迁移至 App Router 的决策，源于其对开发者体验（DX）的高度重视，而 React Server Components 正是其中关键推动力之一。此次升级使他们得以在单一框架内弥合前端与后端之间的鸿沟。

> “At Whop, our mission is to make everyone an internet entrepreneur. To match the pace of the ever-evolving web, we are successfully leveraging the Vercel ecosystem, including Next.js and Vercel, to build software incredibly quickly, leading to rapid growth.”  
> “Whop 的使命是让每个人都能成为互联网创业者。为跟上日新月异的 Web 发展节奏，我们成功依托 Vercel 生态系统（包括 Next.js 与 Vercel 平台），极速构建软件产品，从而实现业务的飞速增长。”

> ![](https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/5q21v6zMFkxFKE6SNbTSGQ/bc661778b6d143a4c7d835e8060b2104/image.png)  
> ![](https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/5q21v6zMFkxFKE6SNbTSGQ/bc661778b6d143a4c7d835e8060b2104/image.png)

> **Tristan Pfannschmidt,** Head of Frontend  
> **Tristan Pfannschmidt**，前端负责人

While Whop was aware of React Server Components before the migration, they were pleasantly surprised by the power they brought to their development workflow. The ability to fetch and [mutate data directly alongside JSX code](https://vercel.com/blog/understanding-react-server-components#server-actions-react%E2%80%99s-first-steps-into-mutability) means writing less overall code and having a central location for managing and rendering data.

尽管 Whop 在迁移前已了解 React Server Components，但其实际带来的开发效能提升仍令团队倍感惊喜。得益于可直接在 JSX 代码中[获取并修改数据](https://vercel.com/blog/understanding-react-server-components#server-actions-react%E2%80%99s-first-steps-into-mutability)的能力，整体代码量显著减少，数据管理与渲染逻辑也得以高度集中、统一。

## **The results**  
## **成果成效**

The transition to App Router has transformed Whop's development process by combining frontend and backend functionalities into a unified platform with reusable patterns—making Next.js feel more like a full-stack framework than just a frontend framework—without the complexities of having to know the backend language.

迁移到 App Router 彻底改变了 Whop 的开发流程：它将前端与后端功能整合到一个统一平台中，并通过可复用的模式，使 Next.js 更像一个全栈框架，而不仅仅是一个前端框架——同时无需开发者掌握后端语言，从而规避了相关复杂性。

This has resulted in:

这一转变带来了以下成果：

- A remarkable **increase in their** [**Real Experience Score**](https://vercel.com/docs/speed-insights#real-user-monitoring-with-real-experience-score-res) **(RES), soaring from the 30s to the high 90s**. Like Lighthouse scores, Vercel's RES gives you performance insights. But unlike Lighthouse, RES is generated from real data points collected from your users' devices, resulting in an authentic evaluation of your users' actual experiences with your application.

- **[真实体验评分（Real Experience Score, RES）](https://vercel.com/docs/speed-insights#real-user-monitoring-with-real-experience-score-res) 实现惊人跃升：从 30 多分飙升至 90 多分**。与 Lighthouse 评分类似，Vercel 的 RES 提供性能洞察；但不同于 Lighthouse，RES 基于从用户设备实际采集的真实数据生成，因而能真实反映用户在使用您的应用时的实际体验。

- Whop's **percentage of** [**Good URLs**](https://support.google.com/webmasters/answer/10218333?hl=en#:~:text=Good%20URLs%3A%20Percentage%20of%20URLs,in%20the%20Mobile%20Usability%20report) **increasing from 13% to 47%**, meaning they showed good [Core Web Vitals](https://vercel.com/docs/speed-insights#core-web-vitals-explained) and contributed to an overall positive user experience.

- Whop 的 **[优质 URL（Good URLs）](https://support.google.com/webmasters/answer/10218333?hl=en#:~:text=Good%20URLs%3A%20Percentage%20of%20URLs,in%20the%20Mobile%20Usability%20report) 占比从 13% 提升至 47%**，表明其网站在 [核心网页指标（Core Web Vitals）](https://vercel.com/docs/speed-insights#core-web-vitals-explained) 方面表现优异，整体显著提升了用户体验。

- The team also saw **less Cumulative Layout Shift and better Core Web Vitals** overall.

- 团队整体观察到 **累积布局偏移（Cumulative Layout Shift, CLS）明显降低，核心网页指标（Core Web Vitals）全面改善**。

Whop's journey from a monolithic Ruby on Rails application to a Next.js-powered frontend with App Router integration showcases the power of modern, open-source web development tools. Their commitment to speed, scalability, and DX has paid off with impressive performance gains and a more streamlined development process.

Whop 从单体式 Ruby on Rails 应用，演进为集成 App Router 的 Next.js 前端架构，充分彰显了现代开源 Web 开发工具的强大能力。他们对速度、可扩展性及开发者体验（DX）的坚定承诺，已转化为卓越的性能提升和更高效的开发流程。

[**Want to add Vercel to your composable stack?**\\
\\
Talk to an expert to learn how you can improve your site’s performance and UX.\\
\\
Get in touch](https://vercel.com/contact/sales)

[**希望将 Vercel 加入您的可组合技术栈？**  
\\  
联系专家，了解如何提升您网站的性能与用户体验。  
\\  
立即联系](https://vercel.com/contact/sales)

Vercel.com landing page

Vercel.com 着陆页

### Incrementally adopt the App Router

### 渐进式采用 App Router

Vercel.com landing page

Vercel.com 着陆页

### Turn your frontend into a profit center

### 将您的前端转变为盈利中心

![](images/how-whop-improved-their-real-experience-score-by-200-with-the-next_js-app-router/img_003.svg)

Download the whitepaper

下载白皮书
&#123;% endraw %}
