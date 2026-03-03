---
title: "The developer experience of the Frontend Cloud - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud"
date: "2023-12-21"
scraped_at: "2026-03-02T09:48:52.978804228+00:00"
language: "en-zh"
translated: true
description: "Vercel's Frontend Cloud offers a complete Developer Experience (DX) Platform, to automate complex systems and offer best-in-market iteration velocity."
---

Dec 21, 2023

2023 年 12 月 21 日

Part 3 of the developer's guide to a future-proofed stack.

面向未来技术栈的开发者指南（第三部分）

In a large team, creating new code should never be scary. Finding where to place code shouldn't be difficult. And _deploying_ new code certainly shouldn't break anything.

在大型团队中，编写新代码绝不应令人畏惧；定位代码应放置的位置不应困难重重；而 _部署_ 新代码更绝不能导致任何故障。

**Ideally, your codebase feels transparent: easy to create, adjust, and monitor.**

**理想状态下，您的代码库应具备高度透明性：易于创建、便于调整、方便监控。**

The Frontend Cloud offers a complete [Developer Experience (DX) Platform](https://vercel.com/products/dx-platform), so you don't have to spend so much developer time curating and maintaining systems that can be easily automated.

Frontend Cloud 提供一套完整的 [开发者体验（DX）平台](https://vercel.com/products/dx-platform)，让您无需耗费大量开发人员时间去人工维护和管理那些本可轻松自动化的系统。

Instead, you get centrally-located and collaborative tooling—Git-based workflows with automatic staging environments and more—where you can easily leverage the self-serve tools in front of you that just work by default.

取而代之的是，您将获得集中化、协作式的工具链——基于 Git 的工作流、自动化的预发布环境等——并能即开即用地、便捷地调用眼前这些开箱即用的自助式工具。

[**The web's Developer Experience Platform**\\
\\
Traditional deployment tools weren’t built for Frontend development. Get the DX Platform that has teams shipping 6x faster.\\
\\
Explore the Product](https://vercel.com/products/dx-platform)

[**面向 Web 的开发者体验平台**\\
\\
传统部署工具并非为前端开发而构建。选择这一 DX 平台，助您的团队交付速度提升 6 倍。\\
\\
探索产品详情](https://vercel.com/products/dx-platform)

## Git-based workflow

## 基于 Git 的工作流

Vercel's Frontend Cloud uses [framework-defined infrastructure (FdI)](https://vercel.com/blog/framework-defined-infrastructure) to automatically transform your [framework code](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-fit-your-frontend-into-a-framework) into a globally served application. But how do you integrate your existing codebase with the Frontend Cloud?

Vercel 的 Frontend Cloud 采用 [框架定义基础设施（FdI）](https://vercel.com/blog/framework-defined-infrastructure)，可自动将您的 [框架代码](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-fit-your-frontend-into-a-framework) 转化为全球可访问的应用程序。但您该如何将自己的现有代码库接入 Frontend Cloud 呢？

The answer turns out to be straightforward: GitHub ( [or any Git version control provider](https://vercel.com/docs/deployments/git)). Adding your repo to the Frontend Cloud is as easy as [adding an integration on GitHub](https://vercel.com/docs/getting-started-with-vercel/import).

答案其实非常简单：GitHub（或 [任意 Git 版本控制服务提供商](https://vercel.com/docs/deployments/git)）。将您的代码仓库接入 Frontend Cloud，只需像 [在 GitHub 上添加集成](https://vercel.com/docs/getting-started-with-vercel/import) 那样轻松即可。

The simple steps to deploy your code onto the Frontend Cloud.

将代码部署到前端云（Frontend Cloud）的简易步骤。

This allows for immutable, persistent infrastructure provisioned for every single `git push` any developer makes within your codebase. Because of [serverless architecture's ability to scale to zero](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#what-is-serverless-architecture), these deployments don't take up resources when unused.

这使得每次开发者向您的代码库执行 `git push` 操作时，都能自动创建一份不可变、持久化的基础设施。得益于[无服务器架构（serverless architecture）可伸缩至零的能力](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#what-is-serverless-architecture)，这些部署在未被访问时不会占用任何计算资源。

The best part is that each deployment, when visited, exists in **true-to-production conditions**, with access to [the Frontend Cloud’s global infrastructure](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#vercel's-edge-network).

最棒之处在于：每次部署一经访问，即运行于**与生产环境完全一致的条件之下**，并可直接接入[前端云的全球基础设施](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#vercel's-edge-network)。

Any code you push to any branch can therefore be observed as its own unique deployment.

因此，您推送到任意分支的代码，均可作为一次独立、唯一的部署进行观测。

## Observability

## 可观测性（Observability）

![The frontend cloud gives you updates about your application's speed for your actual user base—in realtime.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_001.jpg)![The frontend cloud gives you updates about your application's speed for your actual user base—in realtime.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_002.jpg)The frontend cloud gives you updates about your application's speed for your actual user base—in realtime.

![前端云实时向您反馈应用在真实用户群体中的运行速度。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_001.jpg)![前端云实时向您反馈应用在真实用户群体中的运行速度。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_002.jpg)前端云实时向您反馈应用在真实用户群体中的运行速度。

Crucial to application transparency is the ability to see how your deployed code is performing _in realtime for your actual users_. The Frontend Cloud gives centrally-located tools to [monitor usage](https://vercel.com/docs/observability/monitoring), [track performance](https://vercel.com/docs/speed-insights), and [decipher user traffic](https://vercel.com/docs/analytics)—all in service of helping you make better decisions and iterate faster.

实现应用透明性的关键，在于能够实时观测已部署代码在**真实用户**身上的实际表现。前端云提供集中式工具，助您[监控用量](https://vercel.com/docs/observability/monitoring)、[追踪性能](https://vercel.com/docs/speed-insights)以及[解析用户流量](https://vercel.com/docs/analytics)——所有这些功能，都是为了帮助您做出更优决策，并加速迭代进程。

You also have access to a [robust integration marketplace](https://vercel.com/integrations) to quickly plug in observability tools you may already be using.

您还可使用[功能完备的集成市场](https://vercel.com/integrations)，快速接入您已在使用的各类可观测性工具。

Keep in mind that all these tools are available, like everything else, on a _per-deployment_ basis. This makes [experimentation far easier to maintain](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#decouple-deploy-from-release) and keeps the focus on the developer, who wants to see how a specific change affects the application.

请牢记：所有这些工具——如同前端云的其他一切能力一样——均以**单次部署为单位**提供。这使得[实验性工作更易于维护](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#decouple-deploy-from-release)，并将关注点牢牢聚焦于开发者本身——他们真正关心的是：某项具体变更究竟会对应用产生怎样的影响。

![Custom (and saveable) monitoring queries mean you can visualize data from any deployment in all the detail you need.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_003.jpg)![Custom (and saveable) monitoring queries mean you can visualize data from any deployment in all the detail you need.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_004.jpg)Custom (and saveable) monitoring queries mean you can visualize data from any deployment in all the detail you need.

![自定义（且可保存）的监控查询，让您能按需以任意粒度可视化任一部署的数据。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_003.jpg)![自定义（且可保存）的监控查询，让您能按需以任意粒度可视化任一部署的数据。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_004.jpg)自定义（且可保存）的监控查询，让您能按需以任意粒度可视化任一部署的数据。

This level of code transparency means bugs are easy to find, and with the Frontend Cloud’s [focus on developer velocity](https://vercel.com/blog/iterating-from-design-to-deploy), they’re also quick to fix. Code should never be a mystery, and everyone on your team—developer or not—should have easy access to the iteration process.

这种程度的代码透明性意味着漏洞易于发现；而借助前端云（Frontend Cloud）对[开发者效能（developer velocity）的高度关注](https://vercel.com/blog/iterating-from-design-to-deploy)，这些漏洞也能被迅速修复。代码绝不应成为谜团，您团队中的每一位成员——无论是否为开发者——都应能轻松参与并访问迭代过程。

## Collaboration

## 协作

Within the Frontend Cloud, role-based access to secure deployments is managed from a central dashboard, where you can see vital information about all branches, merges, and pushes of your repo, as well as the deployments themselves.

在前端云中，面向安全部署的基于角色的访问权限通过统一的中心仪表板进行管理。您可在该仪表板中实时查看仓库所有分支、合并（merge）与推送（push）的关键信息，以及各次部署本身的详细状态。

Since there’s production infrastructure for each deployment, accessing that deployment is as simple as navigating to its automatically provisioned URL.

由于每次部署均配备生产级基础设施，访问该部署只需跳转至其自动分配的 URL，操作极为简便。

The power of this can’t be understated: Any unreleased version of your application—or an experiment or side project—can instantly be shared with whichever team members or external clients need to see it in a true-to-production environment.

这一能力的重要性不容低估：您应用的任意未发布版本——无论是实验性功能还是附属项目——均可即时共享给需要在真实生产环境中审阅的团队成员或外部客户。

![The frontend cloud brings the feedback cycle right to the relevant page of your application.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_005.jpg)![The frontend cloud brings the feedback cycle right to the relevant page of your application.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_006.jpg)The frontend cloud brings the feedback cycle right to the relevant page of your application.

![前端云将反馈闭环直接带到您应用的相关页面上。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_005.jpg)![前端云将反馈闭环直接带到您应用的相关页面上。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_006.jpg)前端云将反馈闭环直接带到您应用的相关页面上。

Plus, that environment comes with more features, such as:

此外，该环境还提供一系列增强功能，例如：

- [类似 Figma 的评论功能](https://vercel.com/docs/workflow-collaboration/comments)，可直接绑定至部署页面中的 DOM 元素。来自技术与非技术人员的利益相关方（stakeholders）均可在真实网页上直接提交和处理反馈，并一键将其转化为 Slack、Linear 或 Jira 中的任务工单；还可选择性地[阻止后续部署](https://vercel.com/docs/workflow-collaboration/comments/integrations)。

- 支持[预览尚未发布的 CMS 内容](https://vercel.com/docs/workflow-collaboration/draft-mode)。

- 支持 CMS 内容的[页面内所见即所得（WYSIWYG）编辑](https://vercel.com/docs/workflow-collaboration/visual-editing)。

In the Frontend Cloud, the [iteration process is truly collaborative](https://vercel.com/blog/iterating-from-design-to-deploy), with all stakeholders having access exactly as they need.

在前端云（Frontend Cloud）中，[迭代流程真正实现了协同合作](https://vercel.com/blog/iterating-from-design-to-deploy)，所有相关方均可按需获得精确匹配的访问权限。

> “Comments have greatly improved our feedback process both internally among our marketers and designers and externally with our global clients—everything happens in the Preview and nothing gets lost in screenshots being sent back and forth.Comments have greatly improved our feedback process both internally among our marketers and designers and externally with our global clients—everything happens in the Preview and nothing gets lost in screenshots being sent back and forth.”
>
> “评论功能极大优化了我们的反馈流程——无论是在内部营销人员与设计师之间，还是在面向全球客户的外部协作中。所有反馈均直接发生在预览（Preview）环境中，再也不会因来回发送截图而丢失任何信息。”
>
> ![](images/the-developer-experience-of-the-frontend-cloud-vercel/img_007.jpg)
>
> **Wunderman Thompson**

## Unlimited environments

## 无限环境

Since each deployment, when unused, doesn’t take up substantive resources, the Frontend Cloud can take things a step further: providing [unlimited deployment environments](https://vercel.com/docs/deployments/environments) for different kinds of work.

由于每次部署在闲置时几乎不占用实质性资源，前端云可更进一步：为各类工作提供[无限数量的部署环境](https://vercel.com/docs/deployments/environments)。

Each immutable environment gets its own set of environment variables (`.env`), meaning you can have significantly different deploys, just by tweaking these variables. Hydrow, for instance, uses this to [create a completely separate “authoring” environment](https://vercel.com/customers/hydrow), away from the tweaks of developers, allowing content creators to work in a truly WYSIWYG space, saving hours of time for each piece of content.

每个不可变环境都拥有独立的一组环境变量（`.env`），因此仅通过调整这些变量，即可实现差异显著的部署。例如，Hydrow 就利用该能力[构建了一个完全独立的“内容创作”环境](https://vercel.com/customers/hydrow)，使其脱离开发人员的代码调整，让内容创作者得以在一个真正所见即所得（WYSIWYG）的空间中高效工作，每篇内容均可节省数小时时间。

This translates to production, too, since **any environment can be assigned to a domain.** Wunderman Thompson uses this strategy to [deploy fully localized versions of their websites all from the same CMS](https://vercel.com/blog/wunderman-thompson-composable-workflow), just by tweaking a language variable.

这一能力同样延伸至生产环境，因为**任意环境均可绑定至一个域名**。Wunderman Thompson 正是采用这一策略，[仅通过调整语言变量，便能从同一套 CMS 中一键发布网站的全部本地化版本](https://vercel.com/blog/wunderman-thompson-composable-workflow)。

## Decouple deploy from release

## 解耦部署与发布

Within the Frontend Cloud, it’s good to think about [decoupling your deploys from your releases](https://vercel.com/blog/how-to-scale-a-large-codebase). Deploys are an unlimited resource, full of testing opportunities in a true-to-prod environment. Releases are just for the end-user—upgrades or new features that go live and affect customers.

在前端云中，建议深入思考如何[将部署（deploy）与发布（release）解耦](https://vercel.com/blog/how-to-scale-a-large-codebase)。部署是一种近乎无限的资源，在高度贴近生产环境（true-to-prod）的条件下，提供了丰富的测试机会；而发布则专为终端用户服务——即正式上线并影响客户的真实升级或新功能。

Companies like Upstart make 12,000 deployments per month, but only 1,000 of those are actual releases to consumers. These deployments offer them the ability to run end-to-end testing, share work easily among colleagues, and generally have a more public, iterative workflow.

例如 Upstart 这类公司每月执行 12,000 次部署，但其中仅有约 1,000 次是面向消费者的正式发布。这些高频部署使他们得以开展端到端测试、便捷地在团队成员间共享工作进展，并整体形成一种更开放、更具迭代性的协作流程。

However, you can also release to some of your end users without releasing to all. To keep iteration velocity high, you need the confidence to deploy code early and often ( [and be able to rollback](https://vercel.com/docs/deployments/instant-rollback)). Feature flags further separate deployments from releases, by making code in your deployment render [only after meeting your custom conditions](https://vercel.com/blog/how-to-scale-a-large-codebase#releasing-with-confidence-through-feature-flags).

然而，您亦可选择仅向部分终端用户发布，而非全体用户。为持续保持高速迭代节奏，您需要具备尽早、频繁部署代码的信心（[并确保随时可回滚](https://vercel.com/docs/deployments/instant-rollback)）。功能开关（Feature flags）则进一步强化了部署与发布的分离：它确保部署中的代码仅在满足您自定义条件后才实际生效与渲染（[详见《如何规模化管理大型代码库》中“借助功能开关自信发布”章节](https://vercel.com/blog/how-to-scale-a-large-codebase#releasing-with-confidence-through-feature-flags)）。

These flags can be easily toggled on/off by developers, allowing your team to experiment without rebuilding the code. They also allow you to roll out new features to select customers, to make sure the release works with a few before releasing to all.

这些功能开关可由开发者轻松启用或禁用，使您的团队无需重新构建代码即可开展实验；同时，您还可将新功能率先面向部分客户发布，以确保在全面上线前已通过小范围验证。

The power of unlimited environments plus unlimited [fast-as-edge feature flags](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config) makes your codebase truly a joy to experiment with and develop great features—if it’s accessible to use, kept organized, and safe to scale.

无限环境叠加无限的[边缘级快速功能开关](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config)，让您的代码库真正成为实验与开发卓越功能的愉悦之所——前提是它易于访问、组织有序，且具备安全的可扩展性。

## Monorepos

## 单体仓库（Monorepos）

With all this power, how do you keep your teams organized? At Vercel, we’ve helped [thousands of large organizations](https://vercel.com/customers) scale up and manage their codebases, and we believe that monorepos are the optimal code architecture for frontends.

在拥有如此强大能力的同时，您又该如何保持团队的高效协同？Vercel 已助力[数千家大型组织](https://vercel.com/customers)实现代码库的规模化扩展与统一管理；我们坚信，单体仓库（monorepo）是前端开发最理想的代码架构。

![Monorepos gather your org's code into one place, maximizing reusability, conformance, and efficiency.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_008.jpg)![Monorepos gather your org's code into one place, maximizing reusability, conformance, and efficiency.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_009.jpg)Monorepos gather your org's code into one place, maximizing reusability, conformance, and efficiency.

![单体仓库将您组织的全部代码汇聚于一处，最大限度提升可复用性、一致性与开发效率。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_008.jpg)![单体仓库将您组织的全部代码汇聚于一处，最大限度提升可复用性、一致性与开发效率。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_009.jpg)单体仓库将您组织的全部代码汇聚于一处，最大限度提升可复用性、一致性与开发效率。

A [monorepo](https://vercel.com/docs/monorepos) is a codebase with multiple projects contained in a single unified repository. Instead of having possibly hundreds of codebases on a per-project basis, monorepos allow for new and existing engineers to onboard in a single place, set up their local environment, and contribute to any project.

[单体仓库（monorepo）](https://vercel.com/docs/monorepos) 是一种将多个项目整合于单一统一代码仓库中的代码库架构。相比按项目各自维护可能多达数百个独立代码库的传统方式，单体仓库使新老工程师均可在同一个地方完成入职、配置本地开发环境，并为任意项目贡献代码。

Historically, though, monorepos have only been for the largest companies, like Google or Meta. The tooling and best practices have not been accessible to all teams until the past few years.

然而，历史上单体仓库仅被 Google 或 Meta 等超大型企业所采用；相关工具链与最佳实践直到近几年才逐步向所有规模的团队开放。

With the advent of open-source build tools like [Turborepo](https://turbo.build/repo/docs), teams of any size can adopt and manage monorepos without hassle. Turborepo takes the lessons and development workflows from the giants of the web and brings them to every developer.

随着 [Turborepo](https://turbo.build/repo/docs) 等开源构建工具的出现，任何规模的团队都能轻松采用并高效管理单体仓库。Turborepo 提炼了互联网巨头们的工程经验与开发工作流，并将其普惠至每一位开发者。

Turborepo's core concepts explained in just 2 minutes.

Turborepo 核心概念，两分钟讲清楚。

Turborepo is a high-performance build system with sensible defaults and robust escape hatches for custom configuration. It simplifies splitting your codebase into different sections, such as a component library, frontend slices for each team, and any other shared business logic.

Turborepo 是一款高性能构建系统，内置合理默认配置，同时提供强大而灵活的自定义配置机制（“逃生舱口”）。它大幅简化了代码库的模块化拆分——例如拆分为组件库、各团队专属的前端模块，以及其他共享业务逻辑等不同部分。

When a team makes a change to their section of the UI, only the code they’ve changed will build or trigger CI runs, thanks to Turborepo’s powerful caching system. No more wasted time (and money) waiting for scripts or builds to complete for unrelated changes.

当某个团队修改其负责的 UI 模块时，得益于 Turborepo 强大的缓存机制，**仅修改过的代码**会触发构建或 CI 流程。再也不会因无关变更而白白耗费时间（和金钱）等待脚本执行或构建完成。

![With Turborepo, if a build has been cached on any user's machine, the cache is available to all users within the monorepo.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_010.jpg)![With Turborepo, if a build has been cached on any user's machine, the cache is available to all users within the monorepo.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_011.jpg)With Turborepo, if a build has been cached on any user's machine, the cache is available to all users within the monorepo.

![使用 Turborepo 时，只要任一用户的机器上已缓存某次构建结果，该缓存即对整个单体仓库（monorepo）内的所有用户可用。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_010.jpg)![使用 Turborepo 时，只要任一用户的机器上已缓存某次构建结果，该缓存即对整个单体仓库（monorepo）内的所有用户可用。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_011.jpg)使用 Turborepo 时，只要任一用户的机器上已缓存某次构建结果，该缓存即对整个单体仓库（monorepo）内的所有用户可用。

Each team can own their part of the UI, with appropriate code reviews, scripts, and tests just for that section of the codebase. When any code needs to be reused across different teams, it's just an `import` statement away.

每个团队可独立负责其 UI 模块，并为该部分代码库配备专属的代码审查、脚本与测试。当任意代码需被多个团队复用时，只需一条 `import` 语句即可引入。

Monorepos are a superpower when you need to make updates across shared code, or sweeping changes that affect different parts of the UI. You can orchestrate a single change to roll out code safely (ideally behind a [feature flag](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#decouple-deploy-from-release)), without breaking existing versions.

单体仓库（monorepo）在需要跨共享代码同步更新，或对 UI 多个模块实施大规模变更时，堪称“超级能力”。你可借助一次统一变更安全地发布代码（理想情况下配合使用 [功能开关（feature flag）](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#decouple-deploy-from-release)），而不会破坏现有版本。

Turborepo also handles [running your tasks in the correct order](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)—a common pain point with monorepos. No need to remember if you built package A before running package B. Turborepo understands your dependency graph and when to run each script.

Turborepo 还能自动处理 [任务的正确执行顺序](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)——这正是单体仓库开发中一个常见痛点。你无需再费心记忆：是否先构建了 package A，才能运行 package B？Turborepo 能理解你的依赖图谱，并精准判断每个脚本的执行时机。

Finally, Turborepo uses a shared Remote Cache between all members of your team, meaning that if one team member's computer has done the work to run tasks, compile, or build your application, those results are shared between all machines. The Vercel team, for instance, by using the [Vercel Remote Cache](https://vercel.com/blog/vercel-remote-cache-turbo), saved **25,000 hours of compute time last month.**

最后，Turborepo 在团队全员间共享一个远程缓存（Remote Cache）：只要某位成员的机器已完成某项任务的执行、编译或应用构建，其结果便会自动同步至所有其他机器。例如，Vercel 团队通过采用 [Vercel 远程缓存（Vercel Remote Cache）](https://vercel.com/blog/vercel-remote-cache-turbo)，**上个月节省了 25,000 小时的计算时间**。

## Conformance

## 一致性规范（Conformance）

So, your code is highly accessible to all engineers. But this creates another challenge: how do you know who owns what code? If a new engineer makes a PR that includes a piece of code their team doesn’t own, who do they reach out to?

因此，你的代码对所有工程师都高度开放可访问。但这又带来另一个挑战：如何明确每段代码的归属权？若一名新入职工程师提交的 PR 中包含其所属团队并不负责维护的代码，他该联系谁？

![Visualize who owns code in your organization.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_012.jpg)![Visualize who owns code in your organization.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_013.jpg)Visualize who owns code in your organization.

![直观呈现组织内各段代码的负责人。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_012.jpg)![直观呈现组织内各段代码的负责人。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_013.jpg)直观呈现组织内各段代码的负责人。

The Frontend Cloud allows you to [build conformance rules](https://vercel.com/blog/introducing-conformance) directly into your codebase and track who is responsible for maintaining certain parts of the application.

前端云（Frontend Cloud）支持你将 [一致性规范规则（conformance rules）](https://vercel.com/blog/introducing-conformance) 直接嵌入代码库，并持续追踪应用中特定模块的维护责任人。

Onboarding and interaction with the codebase should be a safe and straightforward experience for all, and anyone who needs assistance, regardless of department, should know exactly where to turn.

所有人员的入职流程及与代码库的交互体验都应安全、简洁、直观；无论来自哪个部门，任何需要协助的人员都应清楚地知道该向何处寻求帮助。

The [Frontend Cloud has you covered](https://vercel.com/docs/workflow-collaboration/vercel-spaces#code-owners), with tools that provide detailed information about what team owns what, who to contact, and how to review code from different departments.

[前端云已为您全面覆盖](https://vercel.com/docs/workflow-collaboration/vercel-spaces#code-owners)，提供各类工具，清晰呈现各团队的职责归属、关键联系人以及跨部门代码评审流程。

But let’s say an engineer doesn’t want to deal with the hassle of reaching out to the right people in the org, especially for a tiny change. [This is why the Frontend Cloud provides ways to manage conformance](https://vercel.com/docs/workflow-collaboration/vercel-spaces#conformance) (linting rules and other CI/CD tasks) from an easy location, to prevent errors from ever making it into the codebase.

但假设某位工程师不愿为一次微小变更而费力联系组织内正确的对接人。[正因如此，前端云提供了集中化管理合规性（conformance）的能力](https://vercel.com/docs/workflow-collaboration/vercel-spaces#conformance)（例如代码规范检查 linting 规则及其他 CI/CD 任务），从而在源头杜绝错误流入代码库。

![Frontend clouds should provide a bird's eye view of your code that makes it easy to dive into the details you need.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_014.jpg)![Frontend clouds should provide a bird's eye view of your code that makes it easy to dive into the details you need.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_015.jpg)Frontend clouds should provide a bird's eye view of your code that makes it easy to dive into the details you need.

![前端云应为您提供代码的全局概览，使您能轻松深入所需细节。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_014.jpg)![前端云应为您提供代码的全局概览，使您能轻松深入所需细节。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_015.jpg)前端云应为您提供代码的全局概览，使您能轻松深入所需细节。

Errors in build can be easy to debug, too, with [each build having its own shareable run log](https://vercel.com/docs/workflow-collaboration/vercel-spaces#runs). This makes it far easier to optimize builds in the first place since each unique run can be compared.

构建过程中的错误同样易于调试——[每次构建均拥有独立且可共享的运行日志（run log）](https://vercel.com/docs/workflow-collaboration/vercel-spaces#runs)。由于每次构建均可单独比对，因此从源头优化构建流程也变得更为简单。

[**Ready to move fast and break nothing?**\\
\\
Try out Conformance with your enterprise team.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**准备好快速迭代，同时确保万无一失？**\\
\\
立即为您的企业团队试用 Conformance 功能。\\
\\
联系我们](https://vercel.com/contact/sales)

## Testing

## 测试

Then, we have a set of challenges that come from decoupled architecture. Yes, [decoupling the frontend and backend](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend...) is a better way to work, but how do you make sure your frontend and backend align perfectly, 100% of the time?

接下来，我们面临一系列源于解耦架构的挑战。诚然，[将前端与后端解耦](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend...) 是更优的工作方式，但您又如何确保前端与后端始终 100% 完全对齐？

Luckily, end-to-end testing through CI/CD is [easy to set up in the Frontend Cloud](https://vercel.com/guides/how-can-i-run-end-to-end-tests-after-my-vercel-preview-deployment). Even though your frontend and backend are decoupled, because you have each instance of your application running in a true-to-prod environment, you can use fully automated services like Github Actions to test the app within that environment, before ever merging to production.

幸运的是，借助 CI/CD 实现端到端测试在前端云中[设置极为简便](https://vercel.com/guides/how-can-i-run-end-to-end-tests-after-my-vercel-preview-deployment)。即便您的前端与后端彼此解耦，只要每个应用实例均运行于真实生产环境（true-to-prod environment）中，您即可利用 GitHub Actions 等全自动服务，在合并至生产环境前，直接在该环境中对应用进行完整测试。

Any test, as preferred, can be [mandatory to pass before deploying to production](https://vercel.com/docs/observability/checks-overview), but they don’t have to block non-production builds. A failing test, then, has a full deployment dedicated to it, where your team can more easily see what’s going wrong.

您可根据需要，将任意测试[设为部署至生产环境前的强制通过项](https://vercel.com/docs/observability/checks-overview)，但这些测试无需阻塞非生产环境的构建。当某项测试失败时，系统会为其自动创建专属的完整部署环境，便于您的团队更清晰地定位问题所在。

![You can implement various checks that run after successful deployments to the frontend cloud. They can define your application's quality metrics, run end-to-end tests, investigate APIs' reliability, and directly check your deployment code.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_016.jpg)  
![您可以在前端云成功部署后实施各类检查。这些检查可用于定义应用的质量指标、运行端到端测试、评估 API 的可靠性，并直接校验您的部署代码。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_016.jpg)  

![You can implement various checks that run after successful deployments to the frontend cloud. They can define your application's quality metrics, run end-to-end tests, investigate APIs' reliability, and directly check your deployment code.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_017.jpg)  
![您可以在前端云成功部署后实施各类检查。这些检查可用于定义应用的质量指标、运行端到端测试、评估 API 的可靠性，并直接校验您的部署代码。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_017.jpg)  

You can implement various checks that run after successful deployments to the frontend cloud. They can define your application's quality metrics, run end-to-end tests, investigate APIs' reliability, and directly check your deployment code.  

您可以在前端云成功部署后实施各类检查。这些检查可用于定义应用的质量指标、运行端到端测试、评估 API 的可靠性，并直接校验您的部署代码。

End-to-end testing is vital to implement on large codebases where teams share code within a monorepo. Since changes can sometimes ripple out or have unexpected effects on other teams, building [Atomic components](https://atomicdesign.bradfrost.com/chapter-2/) that are easy to test is a recommended pattern within the Frontend Cloud.  

在大型代码库中（尤其是团队通过单体仓库共享代码的场景），端到端测试至关重要。由于代码变更有时会波及或对其他团队产生意外影响，构建易于测试的 [原子组件（Atomic components）](https://atomicdesign.bradfrost.com/chapter-2/) 是前端云中推荐采用的设计模式。

With testing coverage of your application, individual teams can be freed up to have even better DX, since anyone can push changes with confidence they aren’t breaking anything in the codebase.  

当您的应用具备充分的测试覆盖时，各团队便可更专注于提升开发者体验（DX）：任何成员都能自信地提交变更，而无需担心破坏代码库中的现有功能。

A brief walkthrough of setting up end-to-end testing within a Turborepo-powered monorepo.  

在基于 Turborepo 的单体仓库中配置端到端测试的简要指南。

## Version skew  

## 版本偏移（Version Skew）

Another more subtle challenge can arise with decoupled frontends: version skew.  

解耦式前端还会引发另一类更隐蔽的挑战：版本偏移（version skew）。

Version skew happens whenever two components of a software system communicate, but they aren’t running at exactly the same version. Often this is benign, but it can lead to hard-to-predict problems.  

当软件系统的两个组件相互通信，但运行的并非完全相同的版本时，便会发生版本偏移。多数情况下该问题无害，却可能引发难以预测的故障。

Imagine, for example, that your app has a form. One day you realize you misspelled the name of the email field. It’s not a huge deal because the code on the backend that reads the field has the same misspelling. But still, you decide to fix the spelling on both backend and frontend.  

举例来说，假设您的应用中有一个表单。某天您发现邮箱字段名拼写有误。这原本并不严重——因为后端读取该字段的代码也使用了同样的错误拼写。但您仍决定同时修复前后端的拼写。

Now, we have potential version skew: if a user loaded the form before the change, but submits it after the deployment happened, they will get an error because the email field won’t be recognized (the backend expects the new spelling and the frontend sends the old name).  

此时便存在潜在的版本偏移风险：若用户在变更发布前已加载表单，却在部署完成后才提交，则会收到错误提示——因邮箱字段名无法被识别（后端期望新拼写，而前端仍发送旧名称）。

![Applications are bound to the version that originally generated them every time a user initially navigates to the app. Subsequent requests from this instance of the app are then automatically routed to be served from that same version.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_018.jpg)  
![每次用户首次访问应用时，该应用实例即被绑定至最初生成它的版本；此后，该实例发出的所有后续请求将自动路由至同一版本进行响应。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_018.jpg)  

![Applications are bound to the version that originally generated them every time a user initially navigates to the app. Subsequent requests from this instance of the app are then automatically routed to be served from that same version.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_019.jpg)  
![每次用户首次访问应用时，该应用实例即被绑定至最初生成它的版本；此后，该实例发出的所有后续请求将自动路由至同一版本进行响应。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_019.jpg)  

Applications are bound to the version that originally generated them every time a user initially navigates to the app. Subsequent requests from this instance of the app are then automatically routed to be served from that same version.  

每次用户首次访问应用时，该应用实例即被绑定至最初生成它的版本；此后，该实例发出的所有后续请求将自动路由至同一版本进行响应。

The Frontend Cloud [provisions infrastructure to protect from version skew](https://vercel.com/blog/version-skew-protection), ensuring that users are always sent to the backend that matches the frontend version.

前端云通过[配置基础设施来防范版本偏移问题](https://vercel.com/blog/version-skew-protection)，确保用户始终被路由至与前端版本相匹配的后端服务。

## Third-party tooling

## 第三方工具生态

Standardized architecture in the Frontend Cloud also opens the door to a massive ecosystem of third-party tooling:

前端云的标准化架构，也为海量第三方工具生态打开了大门：

- Any plugins, community or commercial, written for [your framework](https://vercel.com/docs/frameworks#list-of-supported-frameworks) work by default, since they by definition must output to your framework code.

- 任何为[您所用框架](https://vercel.com/docs/frameworks#list-of-supported-frameworks)开发的插件（无论来自社区还是商业供应商）均可开箱即用，因为这些插件在设计上就必须输出符合该框架规范的代码。

- Integrations to tools, such as CMS, databases, analytics, ecommerce, and more, become easy to set up and manage from within your framework code. Your codebase can [integrate or exchange an ever-growing number of these tools without fuss](https://vercel.com/integrations).

- 与内容管理系统（CMS）、数据库、分析平台、电商平台等各类工具的集成，均可直接在您的框架代码中轻松完成配置与管理。您的代码库可[无缝集成或替换日益增长的各类工具](https://vercel.com/integrations)，全程无需繁琐操作。

Crucially, since all these tools can easily be swapped out for each other, **you gain a truly future-proof codebase, without vendor lock-in**.

尤为关键的是，由于所有这些工具均可灵活互换，**您将获得真正面向未来的代码库，彻底摆脱厂商锁定（vendor lock-in）**。

### What about AI?

### 那 AI 呢？

At Vercel, we're working on AI-driven solutions to speed up existing tools and enhance workflows. We’re continually excited to [innovate within the AI ecosystem](https://v0.dev/).

Vercel 正致力于开发由 AI 驱动的解决方案，以加速现有工具运行、优化开发工作流。我们持续满怀热情地[在 AI 生态系统中开展创新](https://v0.dev/)。

![Vercel's v0, now available in public beta, allows users to leverage AI to generate starter UIs—complete with the ability to copy and paste the working code directly into your product.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_020.jpg)![Vercel's v0, now available in public beta, allows users to leverage AI to generate starter UIs—complete with the ability to copy and paste the working code directly into your product.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_021.jpg)Vercel's v0, now available in public beta, allows users to leverage AI to generate starter UIs—complete with the ability to copy and paste the working code directly into your product.

![Vercel 的 v0 已进入公开测试阶段，它允许用户借助 AI 快速生成初始用户界面（UI），并支持一键复制粘贴可直接投入产品使用的完整代码。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_020.jpg)![Vercel 的 v0 已进入公开测试阶段，它允许用户借助 AI 快速生成初始用户界面（UI），并支持一键复制粘贴可直接投入产品使用的完整代码。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_021.jpg)Vercel 的 v0 已进入公开测试阶段，它允许用户借助 AI 快速生成初始用户界面（UI），并支持一键复制粘贴可直接投入产品使用的完整代码。

We see AI as the future of software development, and we're actively researching ways to securely integrate machine learning into our product to make the automation of the Frontend Cloud even _more_ efficient.

我们认为 AI 是软件开发的未来；我们正积极研究如何安全地将机器学习能力集成到产品中，从而让前端云的自动化能力变得**更加高效**。

Even without generative AI features, the Frontend Cloud is the [best way to deploy AI-driven applications onto the web](https://vercel.com/blog/introducing-the-vercel-ai-sdk) _**.**_ Features like Edge Functions (which allow extended streaming from sources like OpenAI) and the speed and efficiency of the Frontend Cloud workflow allow for rapid adoption of and iteration with an ever-changing ecosystem of AI tools.

即使不启用生成式 AI 功能，前端云（Frontend Cloud）仍是将 AI 驱动的应用部署到 Web 的[最佳方式](https://vercel.com/blog/introducing-the-vercel-ai-sdk) _**。**_ 诸如边缘函数（Edge Functions，支持从 OpenAI 等来源进行扩展流式传输）等功能，加之前端云工作流本身所具备的速度与效率，使得开发者能够快速采用并持续迭代——从容应对 AI 工具生态日新月异的变化。

![Vercel's AI SDK offers an interoperable, streaming-enabled, edge-ready software development kit for AI apps built with JavaScript.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_022.jpg)![Vercel's AI SDK offers an interoperable, streaming-enabled, edge-ready software development kit for AI apps built with JavaScript.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_023.jpg)Vercel's AI SDK offers an interoperable, streaming-enabled, edge-ready software development kit for AI apps built with JavaScript.

![Vercel 的 AI SDK 提供一套可互操作、支持流式传输、面向边缘计算就绪的软件开发工具包（SDK），专为使用 JavaScript 构建的 AI 应用而设计。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_022.jpg)![Vercel 的 AI SDK 提供一套可互操作、支持流式传输、面向边缘计算就绪的软件开发工具包（SDK），专为使用 JavaScript 构建的 AI 应用而设计。](images/the-developer-experience-of-the-frontend-cloud-vercel/img_023.jpg)Vercel 的 AI SDK 提供一套可互操作、支持流式传输、面向边缘计算就绪的软件开发工具包（SDK），专为使用 JavaScript 构建的 AI 应用而设计。

If you want to build AI-driven applications, the Frontend Cloud will give you the [fastest time-to-market](https://vercel.com/ai) and best user experience.

如果您希望构建 AI 驱动的应用，前端云将为您提供[最快的上市速度](https://vercel.com/ai)和最佳用户体验。

[**v0 现已向所有人开放。**\\
\\
仅需几秒钟，即可通过文本或图像生成 UI。您将交付什么？\\
\\
草图构思时间](https://v0.dev/)

[**v0 现已向所有人开放。**\\
\\
仅需几秒钟，即可通过文本或图像生成 UI。您将交付什么？\\
\\
草图构思时间](https://v0.dev/)

## DX takeaways

## 开发者体验（DX）要点总结

In this section, we’ve covered why the Frontend Cloud gives better DX through:

本节中，我们阐述了前端云为何能提供更优的开发者体验（DX），关键在于以下几点：

- A familiar Git-based workflow  
- 熟悉的基于 Git 的工作流  

- Unlimited, production-grade preview environments  
- 无限量、生产级的预览环境  

- Extremely high observability of your application  
- 应用程序具备极高的可观测性  

- Native collaboration  
- 原生协作能力

- Built-in experimentation through environments and feature flags  
- 通过环境和功能标志实现内置的实验能力  

- Accessible monorepo support to deduplicate effort and onboard faster  
- 易于使用的单体仓库（monorepo）支持，以减少重复工作并加速团队成员上手  

- Conformance rules to help engineers stay organized in large codebases  
- 合规性规则，帮助工程师在大型代码库中保持条理清晰  

- Automatic end-to-end testing to make sure bugs don’t make it to production  
- 自动化的端到端测试，确保缺陷不会进入生产环境  

- Easy integration with best-in-class third-party tools, including the latest AI models  
- 轻松集成业界顶尖的第三方工具（包括最新的 AI 模型）  

Perhaps the most important takeaway is this: if you’re not using the Frontend Cloud, you’re spending a lot of time tinkering with infrastructure that should be fully automated—globally at industry-leading speeds.  
或许最重要的启示在于：如果你尚未采用前端云（Frontend Cloud），你正耗费大量时间手动调试本应完全自动化——且在全球范围内以行业领先速度运行的基础设施。  

In the final article of this series (to be published soon), we'll dive into the core promises of the Frontend Cloud: reliability and security.  
在本系列的最后一篇文章（即将发布）中，我们将深入探讨前端云的核心承诺：可靠性与安全性。  

Blog post  
博客文章  

Sep 12, 2023  
2023 年 9 月 12 日  

### How to create an optimal developer workflow  
### 如何构建高效的开发者工作流

![](images/the-developer-experience-of-the-frontend-cloud-vercel/img_024.jpg)![](images/the-developer-experience-of-the-frontend-cloud-vercel/img_025.jpg)

林赛（Lindsey）和马克（Mark）

Vercel.com 首页

### 亲身体验