---
title: "How to remove roadblocks to create better developer workflow and experience - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/improving-developer-workflow"
date: "2023-09-12"
scraped_at: "2026-03-02T09:50:44.875798123+00:00"
language: "en-zh"
translated: true
description: "The way your team builds software matters: Create a developer experience that promotes iteration"
---
{% raw %}

Sep 12, 2023

2023 年 9 月 12 日

您的团队构建软件的方式至关重要。

软件工程师致力于打造令客户愉悦并深度参与的体验，但现实中却存在诸多工作流障碍，严重阻碍了高质量软件的快速交付。

在本文中，我们将深入剖析糟糕的开发者体验（Developer Experience, DX）所带来的实际成本，并分享一些有助于构建健康开发工作流的有效策略。

![](images/how-to-remove-roadblocks-to-create-better-developer-workflow-and-experience-verc/img_001.jpg)

## 糟糕的开发者体验所带来的成本

贵组织的开发者体验（DX）直接影响企业的最终盈利。一旦 DX 不尽如人意——例如配置流程繁琐、工作流效率低下——团队士气与迭代速度便会双双受损。

以下是糟糕 DX 将给企业带来的四大成本：

### -real-costs-from-slow-builds) 1) 缓慢构建带来的真实成本

**我们的利益相关方要求我们快速交付产品并及时收集反馈。**

The tech giants release thousands of production deployments daily, and those companies know that build speed matters in order to keep up with the competition.

科技巨头每天发布数千次生产部署，这些公司深知：构建速度至关重要，是保持竞争优势的关键。

In addition to slow builds, it’s imperative to minimize the refresh time between making a change and seeing the result when a developer is working locally. Even small lags here can significantly harm productivity for teams and individuals, removing developers and their collaborators from their flow state and causing context switches.

除了构建缓慢之外，开发者在本地开发时，从修改代码到看到结果之间的刷新延迟也必须尽可能缩短。此处哪怕微小的延迟，也会显著损害团队及个人的工作效率——使开发者及其协作者脱离“心流状态”，并引发频繁的上下文切换。

But there are also hidden costs to slow builds, including the culture it creates. When developers are faced with slow builds, they become hesitant to ship and take extra time out of their day to make iterative changes. They create larger and larger pull requests (PRs), feel disconnected, and become frustrated.

但构建缓慢还带来诸多隐性成本，其中就包括它所塑造的团队文化。当开发者面对缓慢的构建流程时，他们会变得犹豫是否要发布代码，并额外花费大量时间进行迭代式修改；他们提交的拉取请求（PR）越来越庞大，逐渐感到与团队脱节，最终陷入挫败。

### -sunk-costs-from-tech-debt) 2) Sunk costs from tech debt

### -sunk-costs-from-tech-debt) 2) 技术债带来的沉没成本

**If I had a friend who had lost their paycheck gambling, I wouldn’t tell them to keep trying—I’d tell them to step away from the blackjack table.**

**如果我的朋友因赌博输掉了整个月薪，我不会劝他“再试一次”，而会劝他立刻离开那张二十一点赌桌。**

The same is true with technical debt. In this case, the blackjack table is your outdated tech stack. While the sunk costs of outdated infrastructure can be a tough pill to swallow, accumulated tech debt means that new tech can’t be implemented and adopted efficiently, blocking teams across your organization from moving quickly. In fact, developers lose two days a week on average to managing tech debt, according to a [2018 report by Stripe.](https://stripe.com/files/reports/the-developer-coefficient.pdf)

技术债亦是如此。此时，那张“二十一点赌桌”就是你陈旧的技术栈。尽管淘汰过时基础设施所带来的沉没成本令人难以接受，但持续累积的技术债意味着新技术无法被高效地实施与采纳，从而阻碍组织内各团队快速推进工作。事实上，据 Stripe 于 [2018 年发布的《开发者效能报告》](https://stripe.com/files/reports/the-developer-coefficient.pdf) 显示，开发者平均每周需耗费两天时间来应对技术债。

Tech debt is a nebulous concept, but here are a few common causes and effects:

技术债是一个模糊而宽泛的概念，但以下是一些常见成因及其影响：

- Complex dependencies make simple changes too complex.

- 复杂的依赖关系让原本简单的变更变得异常复杂。

- Missing test coverage makes it hard to move quickly because errors and regressions are more easily introduced from each change.

- 缺乏测试覆盖使得快速迭代变得困难，因为每次变更都更容易引入错误和回归问题。

- A lack of monitoring or debugging tools makes it hard to see and catch mistakes.

- 缺少监控或调试工具，导致问题难以被及时发现与定位。

### -opportunity-costs-from-configuration-and-maintenance-) 3) Opportunity costs from configuration and maintenance

### -配置与维护带来的机会成本-) 3) 配置与维护带来的机会成本

**Your business doesn’t need to be a software infrastructure company.**

**你的业务无需成为一家软件基础设施公司。**

From setting up staging and pre-production environments, to entire DevOps teams managing CI/CD and pipeline management, a bespoke, customized system will bog down your workflow, costing you time and money.

从搭建预发布（staging）和准生产（pre-production）环境，到整支 DevOps 团队负责 CI/CD 和流水线管理，一套定制化、专属构建的系统将拖慢你的工作流，耗费你的时间与金钱。

There are so many solutions in today’s market that allow you to leverage cost-efficient and robust solutions, instead of building that infra in-house.

当今市场上已有大量成熟方案，让你得以采用高性价比、高可靠性的现成解决方案，而非自行从零构建此类基础设施。

Your framework controls your global infrastructure, not the other way around.

你的框架掌控着你的全球基础设施，而非相反。

### -hidden-costs-from-friction-in-collaboration) 4) Hidden costs from friction in collaboration

### -协作摩擦带来的隐性成本-) 4) 协作摩擦带来的隐性成本

**Siloed communication is a devastating blocker of fast iteration and hurts your DX in the process.**

**信息孤岛式的沟通，会严重阻碍快速迭代，并在此过程中损害你的开发者体验（DX）。**

When your organization is giving design feedback in one tool, copy suggestions in another, and code changes somewhere else, you’ll ship more slowly.

当你的组织在一款工具中提供设计反馈、在另一款工具中提出文案建议、又在别处提交代码变更时，你的交付速度必然变慢。

At smaller organizations, dev teams might be able to modify any part of the codebase themselves. But when a business expands, collaboration becomes essential in order to understand different parts of the codebase, which includes documentation, discerning correct points of contact, and overall communication.

在小型组织中，开发团队或许能自主修改代码库的任意部分；但随着企业规模扩大，协作变得至关重要——唯有如此，团队才能理解代码库的不同模块，而这包括查阅文档、明确正确的对接人，以及整体高效的沟通。

## Creating a developer experience that promotes iteration

## 构建促进快速迭代的开发者体验

A powerful and seamless front-end workflow with a rich developer experience is possible.

一种强大而流畅的前端工作流，配合丰富的开发者体验，是完全可行的。

When you focus on the goal of fast iteration, everything else will fall into place. Here are some tips on how to overcome these roadblocks:

当你将目标聚焦于快速迭代时，其他一切都会水到渠成。以下是一些克服这些障碍的实用建议：

### Speed up feedback loops

### 加快反馈循环

When you give your team the right tools to build, merge, and deploy, slow builds become a thing of the past.

当你为团队提供恰当的构建、合并与部署工具时，“缓慢的构建”将成为历史。

Your software delivery is only as fast as the slowest part of your toolchain. As you and your teams work towards optimizing your deployment pipelines, CI automations can keep pace with your developers, instead of holding them back.

你的软件交付速度，取决于工具链中最慢的一环。当你和团队致力于优化部署流水线时，CI 自动化应与开发者步调一致，而非拖慢他们的节奏。

**For example, our entire engineering organization recently saved 2,600 hours in a week when we used** [**Turborepo**](https://turbo.build/) **,** an open-source incremental bundler and build system.

**例如，我们整个工程组织最近在一周内通过使用开源的增量打包与构建系统** [**Turborepo**](https://turbo.build/) **，节省了 2,600 小时。**

Fast and lightweight testing infrastructure can also speed up iteration cycles, as developers can ship with confidence, knowing that their changes won’t break anything.

快速轻量的测试基础设施同样能加速迭代周期——开发者可以信心十足地发布代码，因为他们清楚自己的修改不会破坏任何功能。

Finally, refresh time should be measured in milliseconds, not minutes. In the web world, for example, hot module reload (HMR) enables React developers to refresh the results of their code nearly instantly, allowing them quick feedback loops to the updates they are making to their user interfaces.

最后，刷新时间应以毫秒计，而非分钟。例如在 Web 开发领域，热模块替换（HMR）能让 React 开发者近乎即时地刷新代码效果，从而快速获得其用户界面更新的实时反馈。

### Choose open-source and zero-configuration solutions

### 选用开源且零配置的解决方案

Opt for tools your developers love, without extra configuration or custom tooling. This will become your biggest weapon against tech debt.

选择开发者真正喜爱的工具，无需额外配置，也无需定制化开发。这将成为你对抗技术债最有力的武器。

Thanks to the breadth of modern software offerings, infrastructure that was previously only feasible for enterprises and the tech giants is now accessible to anyone.  
得益于现代软件产品的丰富多样，过去仅大型企业和科技巨头才能负担得起的基础设施，如今已向所有人开放。

In other words, companies no longer have to settle when it comes to the best monitoring, alerting, and analytics solutions.  
换言之，企业在选择最佳监控、告警与数据分析解决方案时，再也不必将就。

Open-source and zero-configuration tools with strong communities allow new employees to easily get up to speed and leverage the larger community for improvements.  
拥有活跃社区的开源工具和零配置工具，能让新员工快速上手，并借助更广泛的社区力量持续优化改进。

You also won’t need to worry about maintaining custom, in-house solutions when there’s turnover.  
此外，当团队人员流动时，您也无需再为维护定制化、内部开发的解决方案而担忧。

Open-source has quickly become a differentiator for leading organizations. [90% percent of Fortune 500 companies use open-source software](https://octoverse.github.com/)—with libraries like React, Webpack, and Vercel-owned Next.js among them.  
开源已迅速成为领先组织的关键差异化优势。[《财富》500 强企业中，90% 使用开源软件](https://octoverse.github.com/)——其中包括 React、Webpack，以及 Vercel 拥有的 Next.js 等知名库。

### Prioritize and de-risk innovation

### 优先推进创新，并降低其风险

Having a compelling frontend requires craft and care—it’s your differentiator in a crowded market.  
打造富有吸引力的前端需要精雕细琢与悉心投入——它正是您在竞争激烈的市场中脱颖而出的关键所在。

Make sure you’re investing in making it a delightful experience for your customers by giving devs time to innovate and code, instead of focusing on tech debt and infrastructure management.  
请确保将资源投入到为客户创造愉悦体验之中：给予开发者充足时间进行创新与编码，而非让他们深陷技术债务与基础设施运维的泥潭。

Our CTO, Malte Ubl, often says, “Iteration velocity is the answer to all software problems.”  
我们的首席技术官（CTO）Malte Ubl 常说：“迭代速度是解决一切软件问题的答案。”

We’ve tried to create an engineering organization that empowers our developers to embrace that philosophy by making it easy to fail fast.  
我们致力于构建一种工程文化，赋能开发者践行这一理念——让“快速试错”变得轻而易举。

We prioritize experimentation at Vercel, but that means having the tools to roll back instantly, track across versions, and make fast, data-driven decisions.  
Vercel 将实验探索置于优先地位；但这也意味着我们必须配备能即时回滚、跨版本追踪、并支持快速数据驱动决策的工具。

### Enable collaborative feedback

### 支持协作式反馈

Choose front-end tools that enable collaboration across teams, so that you can speed up review cycles, eliminate bottlenecks, and ensure that staging and production infrastructure is always aligned.  
请选择支持跨团队协作的前端工具，从而加快评审周期、消除流程瓶颈，并确保预发布环境（staging）与生产环境（production）的基础设施始终保持一致。

Identifying the right points of contact, having good documentation, and communicating are all vital to fast feedback cycles.  
明确关键对接人、提供完善的文档、保持顺畅沟通——这些对实现高效反馈闭环都至关重要。

Don’t forget about your teammates outside of the engineering team either. Other parts of the business like design, marketing, and legal must be accounted for in feedback loops.  
也请勿忽视工程团队之外的同事。设计、市场、法务等业务部门，同样必须被纳入反馈闭环之中。

Additionally, choose tools that make staging and pre-production environment creation a breeze.  
此外，请选用能轻松创建预发布与预上线环境的工具。

Developers should have a staging environment automatically set up for every PR, so they can share their work with others around the company, receive prompt feedback, and see their work in the product.  
每位开发者提交 Pull Request（PR）后，系统应自动为其创建一个预发布环境，以便他们将工作成果分享给公司内其他同事、及时获取反馈，并直观看到自己的代码如何呈现在最终产品中。

## Just code

## 仅需编写代码

Our teams prioritize a culture of efficiency and iteration. We know that the best developer experience is one where your tools enhance your work, not slow it down. It's been interesting to watch our developers build for developers, and we’ve learned these important lessons along the way. Remove bad workflows and let your developers be creative through code.

我们的团队高度重视高效与快速迭代的文化。我们深知，最佳的开发者体验，是工具能助力工作、而非拖慢进度。目睹我们的开发者为其他开发者构建产品，这一过程令人深感振奋；在此过程中，我们也收获了若干重要经验：摒弃低效的工作流，让开发者通过代码自由发挥创造力。

Now you can go and break down workflow roadblocks and give your team the time to focus on what makes your product unique.

现在，您可以着手消除工作流中的障碍，为团队腾出宝贵时间，专注于打造您产品的独特价值。

[**Upgrade your workflow today**\\
\\
Reach out to learn more about how you can improve your frontend workflow and empower your team to ship better web experiences with Vercel.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**立即升级您的工作流**\\
\\
联系我们，深入了解如何优化您的前端工作流，并借助 Vercel 赋能团队，交付更出色的 Web 体验。\\
\\
联系我们](https://vercel.com/contact/sales)
{% endraw %}
