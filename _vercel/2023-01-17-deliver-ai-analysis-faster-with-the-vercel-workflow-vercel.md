---
title: "Deliver AI analysis faster with the Vercel workflow - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/delivering-ai-analysis-faster-with-the-vercel-workflow"
date: "2023-01-17"
scraped_at: "2026-03-02T09:56:39.612797279+00:00"
language: "en-zh"
translated: true
description: "Viable customer story"
---

Jan 17, 2023

2023年1月17日

Innovate and scale faster with the right tools.

借助合适的工具，更快地创新与规模化发展。

[Viable](https://www.askviable.com/) is an AI company that analyzes customer feedback and presents insights to businesses to improve products and services. With just six engineers, they’ve already processed 3.8 million data points for businesses like Latch, Uber, and AngelList.

[Viable](https://www.askviable.com/) 是一家人工智能公司，专注于分析客户反馈，并向企业输出可落地的洞察，以优化其产品与服务。仅凭六名工程师，他们已为 Latch、Uber 和 AngelList 等企业处理了 380 万条数据点。

Founded in 2020, Viable’s team has been using Vercel since the beginning. Their whole AI product is built with Next.js and deployed to Vercel, helping them [rapidly innovate and scale](https://vercel.com/resources/iterate-faster-with-a-streamlined-development-workflow) their infrastructure with high demand from customers.

Viable 创立于 2020 年，其团队自成立之初便开始使用 Vercel。整个 AI 产品均基于 Next.js 构建，并部署至 Vercel，从而助力他们在客户高需求背景下，[快速迭代并扩展基础设施](https://vercel.com/resources/iterate-faster-with-a-streamlined-development-workflow)。

However, as demand for their services grows, slow feedback cycles were creating a bottleneck that was starting to get in the way of scaling further. **But after leveraging** [**comments**](https://vercel.com/docs/concepts/deployments/comments) **for feedback in Vercel** [**Preview Deployments**](https://vercel.com/features/previews) **, they’ve been able to reduce back and forth by 80%.** With all this time saved, they’re able to provide their game-changing insights to businesses far more efficiently.

然而，随着服务需求持续增长，缓慢的反馈周期逐渐形成瓶颈，开始阻碍其进一步规模化发展。**但在 Vercel 的 [预览部署（Preview Deployments）](https://vercel.com/features/previews) 中启用 [评论（comments）](https://vercel.com/docs/concepts/deployments/comments) 功能收集反馈后，他们的反复沟通次数减少了 80%。** 节省下来的大量时间，使他们能更高效地将这些颠覆性的业务洞察交付给客户。

![Receive feedback on your Preview Deployments from Team members and invited collaborators with comments.](images/deliver-ai-analysis-faster-with-the-vercel-workflow-vercel/img_001.jpg)  
![通过评论功能，接收团队成员及受邀协作者对您的预览部署（Preview Deployments）的反馈。](images/deliver-ai-analysis-faster-with-the-vercel-workflow-vercel/img_001.jpg)  
Receive feedback on your Preview Deployments from Team members and invited collaborators with comments.  
通过评论功能，接收团队成员及受邀协作者对您的预览部署（Preview Deployments）的反馈。

Taking advantage of Vercel’s pre-production environment for one means the Viable team does not have to waste resources building a custom staging setup. And with comments available for feedback on Preview Deployments, the complete UI review process happens all in one place. Originally, this workflow aided by automatically generated Preview URLs but feedback was still getting lost in Slack DMs, emails, and Zoom calls.

充分利用 Vercel 的预生产（pre-production）环境，意味着 Viable 团队无需耗费资源自行搭建定制化预发布（staging）环境。而借助预览部署中内置的评论反馈功能，整个 UI 审查流程得以在统一平台内完成。此前，该工作流虽已依托自动生成的预览 URL 实现初步协同，但反馈仍常散落在 Slack 私信、电子邮件和 Zoom 会议中，极易丢失。

> “Once we starting using them during their beta period, it was such a clear value prop for us to start using comments for feedback across our entire product. Once we starting using them during their beta period, it was such a clear value prop for us to start using comments for feedback across our entire product. ”
>
> > “在评论功能处于 Beta 测试阶段时，我们便开始试用；它所带来的价值一目了然——我们随即决定在整个产品线中全面采用评论功能进行反馈收集。”
>
> ![](images/deliver-ai-analysis-faster-with-the-vercel-workflow-vercel/img_002.jpg)
>
> **Dan Erickson,** CEO
>
> **Dan Erickson**，首席执行官（CEO）

Thanks to comments for Preview Deployments, the team’s back and forths have been reduced exponentially. Since comments can be made directly on designs, there are fewer additional questions about where changes are located. “It’s so much easier to preserve context,” says Erickson.

得益于预览部署中的评论功能，团队间的反复沟通已呈指数级下降。由于评论可直接添加在设计界面上，关于“修改位置在哪里”的额外提问大幅减少。“上下文信息得以更轻松地保留”，Erickson 表示。

With a more efficient feedback loop on Vercel, Viable is able to ship insights to their customers faster—and scale as more businesses realize the value of their analyses.

凭借 Vercel 上更高效的反馈闭环，Viable 能够更快地将洞察交付客户；同时，随着越来越多企业认识到其分析的价值，Viable 的业务规模也得以持续扩大。

Want to see how your frontend team could achieve a better workflow? [Get in touch](https://vercel.com/contact).

想了解您的前端团队如何实现更高效的工作流？[联系我们](https://vercel.com/contact)。