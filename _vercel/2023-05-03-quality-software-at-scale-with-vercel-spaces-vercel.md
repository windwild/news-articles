---
render_with_liquid: false
title: "Quality software at scale with Vercel Spaces - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-spaces"
date: "2023-05-03"
scraped_at: "2026-03-02T09:52:47.403798633+00:00"
language: "en-zh"
translated: true
description: "Spaces from Vercel"
---
render_with_liquid: false
render_with_liquid: false

May 3, 2023

2023年5月3日

Unite your team with powerful tools and conventions for better collaboration and faster iteration in large codebases.

借助强大工具与规范，助力团队更高效协作，在大型代码库中实现更快的迭代。

As companies and codebases grow, it becomes hard to sustain a fast release cycle without letting errors slip in to production. It shouldn't be this way. We should be able to move fast _without_ breaking things—making quick updates while retaining great performance, security, and accessibility.

随着企业规模与代码库体量不断增长，若想维持快速发布节奏，同时又避免错误流入生产环境，变得愈发困难。这本不该如此。我们理应能够“**快速前进，而不破坏任何东西**”——在保持卓越性能、安全性和可访问性的同时，敏捷地完成更新。

Today, we're introducing Vercel Spaces, the biggest evolution of Vercel's workflow yet. Introducing powerful tools and conventions designed to integrate with your [monorepo](https://vercel.com/blog/monorepos) setup, to help you scale efficiently while retaining quality.

今天，我们正式推出 **Vercel Spaces** —— 迄今为止 Vercel 工作流最重大的一次演进。它提供一系列强大工具与工程规范，专为深度集成您的 [单体仓库（monorepo）](https://vercel.com/blog/monorepos) 架构而设计，助您在规模化扩张过程中持续保障软件质量。

With [Vercel Spaces](https://vercel.com/docs/workflow-collaboration/vercel-spaces), you'll find insights on your development workflows, code health and build logs, and brand new functionality to boost efficiency and remove blockers with **Conformance**, **Code Owners**, and **Vercel Runs**. These products, currently available in early private beta for Enterprises, can be used with Vercel regardless of where you host your application.

借助 [Vercel Spaces](https://vercel.com/docs/workflow-collaboration/vercel-spaces)，您将获得关于开发流程、代码健康度及构建日志的深度洞察；并首次体验三大全新功能：**合规性检查（Conformance）**、**代码负责人（Code Owners）** 与 **Vercel Runs**，显著提升效率、消除协作阻塞。目前，这些功能正面向 Vercel 企业客户开放早期私测（early private beta），且无论您的应用托管于何处，均可与 Vercel 配合使用。

![The Spaces Dashboard surfaces information about the codebase and development workflows to developers. ](images/quality-software-at-scale-with-vercel-spaces-vercel/img_001.jpg)![The Spaces Dashboard surfaces information about the codebase and development workflows to developers. ](images/quality-software-at-scale-with-vercel-spaces-vercel/img_002.jpg)The Spaces Dashboard surfaces information about the codebase and development workflows to developers.

![Spaces 仪表板向开发者呈现有关代码库和开发工作流的信息。](images/quality-software-at-scale-with-vercel-spaces-vercel/img_001.jpg)![Spaces 仪表板向开发者呈现有关代码库和开发工作流的信息。](images/quality-software-at-scale-with-vercel-spaces-vercel/img_002.jpg)Spaces 仪表板向开发者呈现有关代码库和开发工作流的信息。

[**Get started**\\
\\
If you're interested in Vercel Spaces, it is available for early access for Vercel Enterprise customers. Contact our team to learn more.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**立即开始**\\
\\
若您对 Vercel Spaces 感兴趣，现面向 Vercel 企业客户开放早期试用。欢迎联系我们的团队，了解更多信息。\\
\\
联系我们](https://vercel.com/contact/sales)

## Reimagining Vercel for large codebases

## 为大型代码库重新构想 Vercel

Teams need a single place to find information about code, owners, and build logs.

团队亟需一个统一入口，集中获取代码、负责人及构建日志等关键信息。

As more teams turned to monorepos to efficiently scale projects, it became clear that we needed to rethink how our dashboard surfaced their data. Spaces provides new monorepo and code-first views in the Vercel dashboard, making it easy to improve collaboration and productivity.

随着越来越多团队采用单体仓库（monorepo）以高效扩展项目，我们意识到：必须重新思考仪表板如何呈现其数据。Spaces 在 Vercel 仪表板中引入了全新的单体仓库视图与以代码为中心（code-first）的视图，让团队协作与开发效率的提升变得轻而易举。

With the Spaces Dashboard, we've designed a workspace to make information discovery easier, help with cross-team collaboration, and ensure a better onboarding experience for new team members.

借助 Spaces 仪表板，我们设计了一个工作区，旨在简化信息发现过程、促进跨团队协作，并为新团队成员提供更优质的入职体验。

![](images/quality-software-at-scale-with-vercel-spaces-vercel/img_003.jpg)![](images/quality-software-at-scale-with-vercel-spaces-vercel/img_004.jpg)

### Better best practices: Conformance for your code

### 更优的最佳实践：为您的代码提供一致性保障（Conformance）

Maintaining frontend code quality is hard to do at scale. With [Conformance](https://vercel.com/docs/workflow-collaboration/vercel-spaces#conformance), Vercel Spaces will automate detection of critical issues for your frontend products early in the development lifecycle and prevent them from ever reaching production.

在规模化场景下，维持前端代码质量极具挑战。借助 [Conformance](https://vercel.com/docs/workflow-collaboration/vercel-spaces#conformance)，Vercel Spaces 可在开发周期早期自动识别您前端产品中的关键问题，并阻止这些问题进入生产环境。

We do this by codifying and extending Vercel's deep knowledge of the framework ecosystem and tools like [Next.js](https://vercel.com/solutions/nextjs) and [Turbopack](https://turbo.build/pack) to automatically identify the most common issues impacting product and code quality.

我们通过将 Vercel 在框架生态及工具（如 [Next.js](https://vercel.com/solutions/nextjs) 和 [Turbopack](https://turbo.build/pack)）方面的深厚专业知识进行规范化与扩展，自动识别影响产品与代码质量的最常见问题。

For example, Conformance will detect when imports can be moved to be lazy loaded to reduce bundle sizes and improve page performance or when important security headers are missing from your Next.js application before merging to production.

例如，Conformance 可在合并至生产环境前，检测出哪些模块导入可改为懒加载以减小包体积、提升页面性能，或识别您的 Next.js 应用中是否缺失关键的安全响应头。

![](images/quality-software-at-scale-with-vercel-spaces-vercel/img_005.jpg)![](images/quality-software-at-scale-with-vercel-spaces-vercel/img_006.jpg)

### Granularly-defined code ownership with Code Owners

### 基于 Code Owners 的精细化代码所有权管理

As a company grows, it can become difficult for any one person to be familiar with the entire codebase. As the growing teams start to specialize, it can be a common pain point to not know who is responsible for a given piece of code anymore.

随着公司规模扩大，任何单个开发者都很难全面熟悉整个代码库。当团队不断壮大并开始专业化分工时，“某段代码究竟由谁负责”便成为常见的协作痛点。

With [Code Owners](https://vercel.com/docs/workflow-collaboration/vercel-spaces#code-owners), Vercel Spaces will help your organization collaborate better by making it easy to find who is responsible for code and make sure that code changes are reviewed by the right people, all the time.

借助 [Code Owners](https://vercel.com/docs/workflow-collaboration/vercel-spaces#code-owners)，Vercel Spaces 将助力您的组织实现更高效的协作——轻松定位每段代码的责任人，并确保每次代码变更均由恰当的人员进行评审。

Code Owners files are colocated with the code which makes it easy to contact the owner of a piece of code.  
Code Owners 文件与对应代码存放于同一位置，便于快速联系相关代码的所有者。

Since code owners are stored in the directory tree of the code, code owners who are higher up in the directory tree act as broader stewards over the codebase and are the fallback if owners files go out of date.  
由于代码所有者信息存储在代码目录树中，位于目录树更高层级的 Code Owners 对整个代码库承担更广泛的维护职责；当低层级的 OWNERS 文件过期或缺失时，他们将作为默认后备责任人。

Additionally, Code Owners is integrated into Git hosting platforms to automatically add the appropriate people to code reviews.  
此外，Code Owners 已深度集成至主流 Git 托管平台，可自动将合适的人员添加至代码评审（code review）流程中。

Code Owners also provides flexible reviewer selection algorithms, such as round robin assignment, team assignment, primary on-call assignment, and more.  
Code Owners 还提供灵活的审阅者分配算法，例如轮询分配（round robin）、团队分配（team assignment）、主备班（primary on-call）分配等。

![Visualize who owns code in your organization.](images/quality-software-at-scale-with-vercel-spaces-vercel/img_007.jpg)![Visualize who owns code in your organization.](images/quality-software-at-scale-with-vercel-spaces-vercel/img_008.jpg)Visualize who owns code in your organization.  
![可视化您组织中各模块的代码负责人](images/quality-software-at-scale-with-vercel-spaces-vercel/img_007.jpg)![可视化您组织中各模块的代码负责人](images/quality-software-at-scale-with-vercel-spaces-vercel/img_008.jpg)可视化您组织中各模块的代码负责人。

### A better way to debug: Vercel Runs

### 更高效的调试方式：Vercel Runs

You may be familiar with the pain of scrolling through endless terminal logs to find the source of a build failure.  
您可能深有体会：为定位构建失败的根本原因，不得不在冗长的终端日志中反复滚动查找。

[Vercel Runs](https://vercel.com/docs/workflow-collaboration/vercel-spaces#runs) offers a better solution, a new system for sending a user’s builds from any tool (local, continuous integration (CI), or deployments) to Vercel for visualization all in one dashboard.  
[Vercel Runs](https://vercel.com/docs/workflow-collaboration/vercel-spaces#runs) 提供了更优解——这是一套全新系统，支持将用户来自任意工具（本地开发环境、持续集成 CI 系统或部署流程）的构建任务统一发送至 Vercel，并在一个集中式仪表盘中实现全量可视化。

You'll get an easier way to debug a task through an interactive UI, and stores historical build logs allowing you to easily look back at past runs or view aggregate insights.  
您可通过交互式 UI 更便捷地调试单个任务；系统同时持久化存储历史构建日志，助您轻松回溯过往运行记录，或查看聚合分析洞察。

It includes the ability to debug individual builds, see insights from aggregate information, and improve the critical path by fixing slow tasks, such as bottleneck tasks.  
其功能涵盖：单次构建的精细化调试、基于聚合数据的深度洞察分析，以及通过优化慢任务（如性能瓶颈任务）来提升关键路径执行效率。

Any build tool will be able to integrate with the Vercel Runs API. This means that Turborepo users, for example, can send their Turbo runs data to Vercel dashboard for visualization with an easy reference to old builds to help debug issues.  
任何构建工具均可通过 Vercel Runs API 实现集成。例如，Turborepo 用户即可将其 Turbo 构建运行数据推送至 Vercel 仪表盘进行可视化展示，并能便捷关联历史构建记录，从而高效定位和解决各类问题。

![](images/quality-software-at-scale-with-vercel-spaces-vercel/img_009.jpg)![](images/quality-software-at-scale-with-vercel-spaces-vercel/img_010.jpg)

![](images/quality-software-at-scale-with-vercel-spaces-vercel/img_009.jpg)![](images/quality-software-at-scale-with-vercel-spaces-vercel/img_010.jpg)

Vercel Spaces gives you the tools to move fast as a team—without breaking things. Get started today.  
Vercel Spaces 为您提供团队协同加速所需的全套工具——在飞速迭代的同时，确保系统稳定可靠。立即开始使用吧。

[**Get started**\\
\\
If you're interested in Vercel Spaces, it is available for early access for Vercel Enterprise customers. Contact our team to learn more.\\
\\
Contact Us](https://vercel.com/contact/sales)  
[**立即开始**\\
\\
若您对 Vercel Spaces 感兴趣，目前该功能已面向 Vercel Enterprise 客户开放早期试用。欢迎联系我们的销售团队了解详情。\\
\\
联系我们](https://vercel.com/contact/sales)