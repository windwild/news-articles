---
title: "Incrementally adopting Next.js at one of Europe's fastest growing brands - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/incrementally-adopting-next-js-at-one-of-europes-fastest-growing-brands"
date: "2023-06-23"
scraped_at: "2026-03-02T09:51:48.816255795+00:00"
language: "en-zh"
translated: true
description: "reMarkable goes composable "
---

Jun 23, 2023

2023 年 6 月 23 日

了解 reMarkable 的技术栈如何在提升开发者体验的同时，也交付卓越的用户体验。

#### 87%

构建时间减少 87%

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Next.js

Next.js

Preview Deployments

预览部署

ISR

增量静态再生（ISR）

Integrations

集成

While [reMarkable](https://remarkable.com/), pioneers of the next-generation paper tablet, can credit much of their initial success to their original website, they knew they’d need to improve key elements of their stack and workflow to reach new heights. The team opted for a composable stack—comprised of [Sanity](https://vercel.com/integrations/sanity), Next.js, and Vercel—to meet the needs of their developers while empowering their content creators to deliver truly delightful digital experiences.

尽管下一代纸张平板电脑先驱 [reMarkable](https://remarkable.com/) 的早期成功在很大程度上归功于其原始网站，但他们深知，若想再攀高峰，必须优化技术栈与工作流中的关键环节。为此，团队选择了一套可组合式技术栈——由 [Sanity](https://vercel.com/integrations/sanity)、Next.js 和 Vercel 构成——既满足开发者的专业需求，又赋能内容创作者打造真正令人愉悦的数字体验。

## **The case for headless: empowering every team to create**

## **采用无头架构的理由：赋能每个团队自主创作**

reMarkable’s developers were excited to benefit from the flexibility and power of a modern composable architecture. After migrating from Gatsby, Vercel and [Sanity](https://vercel.com/integrations/sanity) allowed reMarkable to speed up build times with a faster frontend stack. The improvements to their web team’s development experience allowed them to ship faster and more efficiently.

reMarkable 的开发者们对现代可组合式架构所赋予的灵活性与强大能力倍感振奋。在从 Gatsby 迁移后，Vercel 与 [Sanity](https://vercel.com/integrations/sanity) 协同助力 reMarkable 搭建起更快速的前端技术栈，显著缩短了构建耗时。Web 团队开发体验的整体提升，使其能够更快速、更高效地交付产品。

### **Streamlined review cycles**

### **精简评审流程**

The design team had always used Figma to display new site designs for stakeholders to review. However, the static, Figma mockup is just a fragment of what the team wanted to show. [Vercel Preview Deployments](https://vercel.com/features/previews) helped speed up review cycles, facilitate more stakeholder feedback, and really show what reMarkable’s team can do. While they still use Figma, Previews paired with instant content updates from Sanity give them a whole other dimension to showcase ideas and get buy-in.

设计团队过去一直使用 Figma 向利益相关方展示新网站设计方案。然而，静态的 Figma 原型仅能呈现团队构想的一小部分。[Vercel 预览部署（Preview Deployments）](https://vercel.com/features/previews) 加速了评审周期，促进了更多来自利益相关方的反馈，并真正展现了 reMarkable 团队的实力。尽管他们仍在使用 Figma，但将预览功能与 Sanity 提供的实时内容更新相结合，为创意展示与共识达成开辟了全新维度。

> “Preview comments have been a great tool for us to collaborate. It’s been an easy way for us to push changes. We can tell stakeholders: Just log in and comment straight on the solution. Preview comments have been a great tool for us to collaborate. It’s been an easy way for us to push changes. We can tell stakeholders: Just log in and comment straight on the solution. ”
>
> > “预览评论（Preview Comments）已成为我们协作的一大利器。它为我们推送变更提供了极为便捷的方式。我们可以直接告诉利益相关方：‘请登录，在解决方案页面上直接留言评论即可。’ 预览评论已成为我们协作的一大利器。它为我们推送变更提供了极为便捷的方式。我们可以直接告诉利益相关方：‘请登录，在解决方案页面上直接留言评论即可。’”
>
> ![](images/incrementally-adopting-next_js-at-one-of-europe_s-fastest-growing-brands-vercel/img_001.png)
>
> **Kristi Faye-Lund,** Full Stack Developer at reMarkable
>
> **克里斯蒂·法耶-伦德（Kristi Faye-Lund）**，reMarkable 全栈开发工程师

### **Self-sufficient editorial team**

### **自主高效的编辑团队**

If reMarkable’s editorial team wanted to make certain website changes in the past, they’d need the help of developers and designers. As reMarkable Full-Stack Developer Kristi shares, "We didn't want to have so many dependencies in the process. We wanted our content people to actually be able to work on _content—_ not wait for a developer." With Sanity as part of their composable architecture, content creators can create as many custom landing pages as they need on their own. This allows their entire organization to move faster, with less tech debt.

过去，若 reMarkable 的编辑团队希望对网站进行某些调整，往往需要依赖开发人员与设计师协助。正如 reMarkable 全栈开发工程师克里斯蒂所言：“我们不希望整个流程中存在过多依赖关系。我们希望内容团队能真正专注于 _内容本身_，而非被动等待开发人员介入。” 借助 Sanity 作为其可组合式架构的重要一环，内容创作者得以完全自主创建所需数量的定制化落地页。这不仅大幅提升了整个组织的响应速度，也显著降低了技术债务。

### **Faster builds for faster ships**

### **更快的构建，更敏捷的交付**

Development builds were slow to start in the beginning, and at times, reMarkable’s engineers would have to start them multiple times to get them going. After switching to Vercel, the initial startup time of development builds dropped. John, full-stack developer at reMarkable, explains, “This was a dramatic change that improved the lives of all our developers. It makes working on projects much more pleasant.” Production times improved as well through Next.js—going from **5m 55s** to just **39s**.

项目初期，开发环境构建启动缓慢，有时 reMarkable 的工程师甚至需反复多次触发构建才能成功启动。切换至 Vercel 后，开发构建的初始启动时间显著下降。reMarkable 全栈开发工程师约翰解释道：“这一变化堪称巨大，切实改善了所有开发人员的工作体验，让项目开发过程变得愉悦得多。” 同时，借助 Next.js，生产环境构建耗时亦大幅优化——从原先的 **5 分 55 秒** 缩短至仅 **39 秒**。

### **De-risking headless transition with an incremental migration**

### **通过渐进式迁移降低无头架构转型风险**

reMarkable’s developers chose to incrementally migrate from Gatsby to Next.js and Sanity so they could ensure a smooth, manageable transition.  
reMarkable 的开发团队选择从 Gatsby 渐进式迁移到 Next.js 和 Sanity，以确保整个转型过程平稳、可控。

First, they modified their website’s structure as much as possible to prepare for the change, moving to a pages folder and lifting the datafetching to the pages-level.  
首先，他们尽可能调整网站结构为迁移做好准备：将代码迁移至 `pages` 目录，并将数据获取逻辑提升至页面层级（pages-level）。

They then started their development in a separate branch, with rewriting the queries as the main bulk of work.  
随后，他们在独立分支中启动开发工作，其中重写查询语句构成了主要开发任务。

Once that chunk of work was done, they swapped in the new framework, and onboarded the rest of the development team.  
待该部分工作完成后，他们正式切换至新框架，并让其余开发人员加入新栈的协作流程。

This allowed them to move to a new stack, in place, only changing hosting and a few other parameters on the outside. No long living branches or new repos needed.  
这使得他们得以原地升级技术栈，仅需变更托管服务及少量外部配置参数——无需长期维护的分支，也无需新建代码仓库。

Going forward, reMarkable’s team is excited to continue future-proofing their content structure.  
展望未来，reMarkable 团队期待持续优化其内容结构，以保障长期可扩展性与前瞻性。

They’re ready to achieve new levels of success with their freshly-empowered editorial team, and the eCommerce brand is eager to continue making strides with their agile composable stack.  
他们已准备好借助全新赋能的编辑团队实现更高水平的成功；这家电子商务品牌亦热切期望依托其敏捷、可组合的技术栈持续取得突破进展。

[**Ready to redefine your digital experiences with Vercel?**\\  
\\  
If you're curious about how Vercel can uplift your team's specific use case, our experts are ready for a conversation.\\  
\\  
Let's Talk](https://vercel.com/contact/sales)  

[**准备好借助 Vercel 重塑您的数字体验了吗？**\\  
\\  
若您想了解 Vercel 如何助力您的团队应对特定业务场景，我们的专家随时准备与您深入交流。\\  
\\  
立即对话](https://vercel.com/contact/sales)

Blog post  
博客文章  

Jan 13, 2023  
2023 年 1 月 13 日  

### Sanity balances experimentation and performance with Vercel Edge Middleware  

### Sanity 借助 Vercel Edge 中间件，在实验探索与性能表现之间取得平衡  

![](images/incrementally-adopting-next_js-at-one-of-europe_s-fastest-growing-brands-vercel/img_002.jpg)  

Grace Madlinger  
格蕾丝·马德林格  

Vercel Template  
Vercel 模板

Deploy this template

部署此模板

### A clean Next.js + Sanity starter with visual editing, drag-and-drop page builder, live content updates, and AI-powered media support.

### 一个简洁的 Next.js + Sanity 入门模板，支持可视化编辑、拖放式页面构建、实时内容更新以及 AI 驱动的媒体支持。

Sanity + Next.js Clean App

Sanity + Next.js 简洁应用