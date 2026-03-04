---
title: "How to scale a large codebase - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/how-to-scale-a-large-codebase"
date: "2023-11-16"
scraped_at: "2026-03-02T09:49:42.102638028+00:00"
language: "en-zh"
translated: true
description: "Transition from monolithic to monorepo architectures with Vercel. Explore feature flags for safe releases, incremental builds for quick iterations, and skew protection for version consistency to ease ..."
---

render_with_liquid: false
Nov 16, 2023

2023 年 11 月 16 日

构建与扩展大型软件项目的建议

Scaling a codebase is an integral, and inevitable, part of growing a software company.

代码库的规模化扩展是软件公司发展过程中不可或缺、且不可避免的一环。

You may have heard many terms thrown around as answers — monoliths, monorepos, micro frontends, module federation, and more.

你可能已听过许多术语被当作解决方案提出——单体架构（monoliths）、单体仓库（monorepos）、微前端（micro frontends）、模块联邦（module federation）等等。

At Vercel, we’ve helped [thousands of large organizations](https://vercel.com/customers) evolve their codebases, and we have an opinion on the optimal way to build software.

在 Vercel，我们已协助[数千家大型组织](https://vercel.com/customers)演进其代码库，并形成了我们对构建软件最优方式的明确观点。

In this post, we’ll share common issues encountered when scaling a codebase over time, useful open-source tools you can leverage, and the best practices and architectural patterns to follow.

本文将分享在代码库长期规模化扩展过程中常见的问题、可借助的实用开源工具，以及应遵循的最佳实践与架构模式。

This post will cover:

本文涵盖以下主题：

- [**Organizing and reusing code across teams with monorepos**](https://vercel.com/blog/how-to-scale-a-large-codebase#organizing-and-reusing-code-across-teams-with-monorepos)

- [**使用单体仓库（monorepos）跨团队组织与复用代码**](https://vercel.com/blog/how-to-scale-a-large-codebase#organizing-and-reusing-code-across-teams-with-monorepos)

- [**Releasing with confidence through feature flags**](https://vercel.com/blog/how-to-scale-a-large-codebase#releasing-with-confidence-through-feature-flags)

- [**通过特性开关（feature flags）实现自信发布**](https://vercel.com/blog/how-to-scale-a-large-codebase#releasing-with-confidence-through-feature-flags)

- [**De-risking experimentation with incremental builds**](https://vercel.com/blog/how-to-scale-a-large-codebase#de-risking-experimentation-with-incremental-builds)

- [**借助增量构建（incremental builds）降低实验风险**](https://vercel.com/blog/how-to-scale-a-large-codebase#de-risking-experimentation-with-incremental-builds)

- [**Releasing code without affecting existing versions through Skew Protection**](https://vercel.com/blog/how-to-scale-a-large-codebase#deploying-code-without-breaking-existing-versions-through-skew-protection)  
- [**通过倾斜保护（Skew Protection）发布代码，而不影响现有版本**](https://vercel.com/blog/how-to-scale-a-large-codebase#deploying-code-without-breaking-existing-versions-through-skew-protection)

- [**Incrementally adopting new technology**](https://vercel.com/blog/how-to-scale-a-large-codebase#incrementally-adopting-new-technology)  
- [**渐进式采用新技术**](https://vercel.com/blog/how-to-scale-a-large-codebase#incrementally-adopting-new-technology)


## Where teams struggle today

## 当前团队面临的困境

Teams struggle to evolve their codebase without sacrificing iteration velocity.  
团队在演进代码库的同时，难以维持快速迭代的速度。

It's common to see frontend performance degrade over time as multiple teams work on a single large codebase. Releasing code can become time-consuming, taking anywhere from a few hours to several days.  
当多个团队共同维护一个庞大的单一代码库时，前端性能随时间推移而下降的情况十分普遍。代码发布过程可能变得异常耗时，耗时从数小时到数天不等。

Teams often lack confidence in releasing code, particularly if new features are not behind [feature flags](https://vercel.com/blog/how-to-scale-a-large-codebase#releasing-with-confidence-through-feature-flags). Each team may end up developing their own configuration and tooling for every new project, rather than reusing and sharing common bits among teams.  
团队往往对发布代码缺乏信心——尤其是当新功能未通过[功能开关（feature flags）](https://vercel.com/blog/how-to-scale-a-large-codebase#releasing-with-confidence-through-feature-flags)进行管控时。各团队常常为每个新项目重复开发专属的配置与工具链，而非在团队间复用和共享通用组件与基础设施。

It can be challenging to even _find_ the code when there are dozens, hundreds, or even thousands of repositories to sift through. On top of this, frontend teams may then struggle to share code across different teams and parts of the UI.  
当需要在数十、数百甚至数千个代码仓库中检索时，仅是“找到代码”本身都可能成为一项挑战。此外，前端团队还可能难以在不同团队及 UI 的不同模块之间共享代码。

While there isn’t one single solution to fix all of these issues, we believe in an architecture that _increases_ velocity, rather than slowing it over time.  
尽管并不存在能一劳永逸解决所有这些问题的“银弹”，但我们坚信：应构建一种能随时间推移而**持续提升**研发效能的架构，而非使其日渐迟滞。

## What success can look like

## 成功的样貌

Many teams are starting their transformation from a large, monolithic codebase.  
许多团队正从庞大而单一的单体代码库出发，开启自身的架构转型之旅。

Monoliths have lots of great qualities, so it’s important to not throw out an architecture based on the latest trends. Instead, focus on the pain points you’re seeing and understand the ideal state for software development at your company.

单体架构具备诸多优秀特性，因此切勿仅仅因为追随最新技术潮流就轻易抛弃现有架构。相反，应聚焦于当前所面临的痛点，并深入理解贵公司软件开发的理想状态。

For example, success might look like:

例如，“成功”可能体现为以下几点：

- Releasing new changes frequently, with fast iterations

- 频繁发布新变更，实现快速迭代

- Adopting new technology easily into the existing codebase

- 轻松将新技术集成到现有代码库中

- Enabling teams to independently work on different parts of the UI

- 使各团队能够独立开发用户界面（UI）的不同部分

- Sharing and reusing scripts and configuration, rather than reinventing every time

- 共享并复用脚本与配置，而非每次重复造轮子

Regardless of your stage of growth, we believe you don’t need to sacrifice any of these points. We’ll talk about some of the tradeoffs later on, but let’s first start with the core architecture choice that enables this: a **monorepo**.

无论您处于哪个发展阶段，我们都认为您无需在上述任何一点上做出妥协。后文我们将探讨其中一些权衡取舍；但首先，让我们从支撑这一切的核心架构选择入手：**单体仓库（monorepo）**。

## Organizing and reusing code across teams with monorepos

## 借助单体仓库（monorepo）实现跨团队的代码组织与复用

Scaling a large codebase begins with making it easy for _anyone_ to locate code and make contributions. We don’t want to give up this quality of monoliths.

规模化大型代码库的第一步，是让 _任何人_ 都能轻松定位代码并参与贡献。我们不愿放弃单体架构所具备的这一优势。

But a single, monolithic codebase, rather than smaller, independent pieces organized inside a monorepo, violates two of the points on our success criteria.

然而，若采用一个庞大、紧耦合的单一代码库，而非将更小、更独立的模块组织在单体仓库（monorepo）内，则会违背我们前述“成功标准”中的两点。

Monoliths make it difficult to:

单体架构使得以下工作变得困难：

- Adopt new technology in the monolith without major, [big bang migrations](https://vercel.com/blog/how-to-scale-a-large-codebase#incrementally-adopting-new-technology)

- 在不进行大规模“一次性迁移”（[big bang migrations](https://vercel.com/blog/how-to-scale-a-large-codebase#incrementally-adopting-new-technology)）的情况下，在单体中引入新技术

- Enable teams to independently work on different parts of the UI

- 使各团队能够独立开发用户界面（UI）的不同部分

Our recommendation is to adopt a monorepo architecture.

我们建议采用单体仓库（monorepo）架构。

### What is a monorepo?

### 什么是单体仓库（monorepo）？

Monorepos are codebases with multiple projects contained in a single unified repository.

单体仓库是指将多个项目整合在一个统一代码仓库中的代码库形式。

Instead of having 100+ separate codebases, a new engineer on your team has a single place to onboard, set up their local development environment, and start contributing on day one.

相比维护 100 多个彼此分离的代码库，采用单体仓库后，新加入团队的工程师只需在一个地方完成入职流程、配置本地开发环境，并在第一天即可开始贡献代码。

### Aren't monorepos only for the biggest companies?

### 单体仓库难道只适用于规模最大的公司吗？

Historically, yes. Companies like Google and Meta use monorepos to manage their incredibly large codebases. The tooling and best practices for enabling this architecture were not easily accessible to all teams until recently.

历史上确实如此。Google 和 Meta 等公司使用单体仓库来管理其规模极其庞大的代码库。但直到最近，支撑该架构所需的工具链和最佳实践才逐渐向所有团队开放。

Now, open source build tools like [Turborepo](https://turbo.build/repo/docs) enable teams of all sizes to adopt monorepos.

如今，诸如 [Turborepo](https://turbo.build/repo/docs) 这样的开源构建工具，已让各种规模的团队都能轻松采用单体仓库架构。

Turborepo takes the lessons and development workflows from the giants of the web and brings them to every developer. It simplifies monorepos and makes them accessible to all.

Turborepo 吸取了互联网巨头们的实践经验与开发工作流，并将其带给每一位开发者。它简化了单体仓库（monorepo）的使用，使其对所有开发者都触手可及。

### Why use Turborepo?

### 为何选择 Turborepo？

Turborepo is a high-performance build system with sensible defaults and robust escape hatches for custom configuration. It simplifies splitting your codebase into different sections, like your component library, your frontend slices for each team, and any other shared business logic.

Turborepo 是一个高性能构建系统，内置合理默认配置，同时提供强大且灵活的自定义配置机制（“逃生舱口”）。它让代码库拆分变得轻而易举——例如，可将组件库、各团队负责的前端模块，以及其他共享业务逻辑分别独立管理。

When a team makes a change to their section of the UI, only the code they’ve changed will build or trigger CI runs, thanks to Turborepo’s powerful caching system. No more wasted time (and money) waiting for scripts or builds to complete for unrelated changes.

得益于 Turborepo 强大的缓存机制，当某个团队修改其负责的 UI 模块时，仅该部分代码会触发构建或 CI 流水线运行。再也不会因无关变更而白白耗费时间（和金钱）等待脚本执行或构建完成。

![Turborepo's caching makes your longest builds near-instant.](images/how-to-scale-a-large-codebase-vercel/img_001.jpg)![Turborepo's caching makes your longest builds near-instant.](images/how-to-scale-a-large-codebase-vercel/img_002.jpg)Turborepo's caching makes your longest builds near-instant.

![Turborepo 的缓存机制让你最耗时的构建近乎瞬时完成。](images/how-to-scale-a-large-codebase-vercel/img_001.jpg)![Turborepo 的缓存机制让你最耗时的构建近乎瞬时完成。](images/how-to-scale-a-large-codebase-vercel/img_002.jpg)Turborepo 的缓存机制让你最耗时的构建近乎瞬时完成。

Each team can own their part of the UI, with appropriate code reviews and ownership just for that section of the codebase. When they need to reuse code across different teams, it's just an `import` statement away.

每个团队均可自主负责其 UI 模块，对该部分代码库实施专属的代码审查与所有权管理。当需要跨团队复用代码时，只需一条 `import` 语句即可轻松实现。

Monorepos are a superpower when you need to make updates across shared code, or larger sweeping changes that affect different parts of the UI. You can orchestrate a single change to roll out code safely, without breaking existing versions, and ideally behind a feature flag.

单体仓库（monorepo）是你进行共享代码统一升级，或实施影响 UI 多个模块的大规模重构时的“超能力”。你可通过一次协调变更，安全地发布新代码，既不会破坏现有版本，又可理想地配合功能开关（feature flag）渐进式启用。

Turborepo also handles running your tasks in the correct order—a common pain point with monorepos. No need to remember if you built package A before running package B. Turborepo understands your dependency graph and how to orchestrate running your scripts.

Turborepo 还能自动按正确顺序执行各项任务——这正是单体仓库中常见的痛点。你无需再费心记忆是否先构建了 package A，再运行 package B。Turborepo 深刻理解你的依赖图谱，并能智能编排脚本执行流程。

### Recommendations

### 推荐方案

- **Monorepo tooling:** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos)

- **单体仓库（monorepo）工具：** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos)

- **Build scripts:** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)  
- **构建脚本：** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)

- **Code generation:** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos/code-generation)  
- **代码生成：** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos/code-generation)

- **Package manager:** [pnpm](https://pnpm.io/)  
- **包管理器：** [pnpm](https://pnpm.io/)

- **Conformance tooling:** [Vercel](https://vercel.com/docs/workflow-collaboration/conformance)  
- **合规性工具：** [Vercel](https://vercel.com/docs/workflow-collaboration/conformance)

## Releasing with confidence through feature flags  

## 通过功能开关（Feature Flags）实现自信发布

Monorepos enable teams to independently release code, whether it’s a single component or an entire piece of an application. To keep iteration velocity high, you need confidence to deploy code early and often ( [and rollback!](https://vercel.com/docs/deployments/instant-rollback)). We believe the correct solution to separate deployments from releases is feature flags.  
单体仓库（Monorepo）使团队能够独立发布代码——无论是单个组件，还是应用程序的完整模块。为保持高速迭代，你需要对“尽早、频繁地部署代码”（[并随时回滚！](https://vercel.com/docs/deployments/instant-rollback)）充满信心。我们认为，将部署（deployment）与发布（release）解耦的正确方案是采用功能开关（Feature Flags）。

### What are feature flags?  

### 什么是功能开关（Feature Flags）？

Feature flags help your team safely release new code and experiment with changes.  
功能开关帮助你的团队安全地发布新代码，并对变更进行实验。

This architecture separates the deployment of new code from releasing features. You can change the UI and behavior of the application without needing to redeploy.  
该架构将新代码的部署与功能的发布分离开来。你可以在无需重新部署的前提下，动态调整应用的用户界面（UI）和行为逻辑。

Compile-time checks in your monorepo ensure safety and performance, without sacrificing the ability to change runtime behavior through feature flags. The best of both worlds.  
单体仓库中的编译期检查可保障安全性与性能，同时不牺牲通过功能开关动态调整运行时行为的能力——真正实现了两全其美。

Revisiting our success criteria, flags enable releasing new changes frequently, with fast iterations.

回顾我们的成功标准，功能开关（feature flags）使我们能够高频次地发布新变更，并实现快速迭代。

### Do feature flags slow down my application?

### 功能开关会拖慢我的应用吗？

It’s valid to question if dynamically reading flags to see which features are enabled will affect site performance. We’ve been obsessed with this problem and how to enable global feature flags with low latency. Here’s the architecture we recommend.

动态读取开关以判断哪些功能已启用，是否会影响网站性能？提出这一疑问是完全合理的。我们长期专注于解决这一问题，并致力于以低延迟方式实现全球范围的功能开关。以下是我们的推荐架构。

Regardless of the flag provider you choose, flag values should be **pushed to low-latency data storage in every region**. With Vercel, this is 18 regions and 190+ points of presence globally.

无论您选择哪家开关服务提供商，开关值都应**推送至每个区域的低延迟数据存储中**。在 Vercel 平台上，这覆盖全球 18 个区域及 190 多个边缘节点（Points of Presence）。

Low latency reads are important as flag values are read dynamically on every request. With Vercel, feature flag values are stored in Edge Config. Most reads take **~5ms**, with **99% of reads happening in ~15ms**. When flags change in your provider, changes are automatically synchronized (through integrations) and pushed to all Edge Network regions.

低延迟读取至关重要，因为每次请求都会动态读取开关值。在 Vercel 上，功能开关值存储于 Edge Config 中。大多数读取耗时约 **5 毫秒**，**99% 的读取可在约 15 毫秒内完成**。当您的开关服务提供商中的开关状态发生变化时，这些变更将通过集成自动同步，并实时推送至所有 Edge Network 区域。

> “The combination of Vercel Edge Config and the LaunchDarkly integration for Vercel lets us update our feature flagging configurations comfortably and automatically push them to our Edge Config store in real time. We are able to change the UI and behavior of our application without the need to re-deploy, which keeps us highly flexible. The low latency that Edge Config provides reduces the overhead of fetching flag configurations over HTTP, allowing us to have minimal latency and create a better experience for our users.The combination of Vercel Edge Config and the LaunchDarkly integration for Vercel lets us update our feature flagging configurations comfortably and automatically push them to our Edge Config store in real time. We are able to change the UI and behavior of our application without the need to re-deploy, which keeps us highly flexible. The low latency that Edge Config provides reduces the overhead of fetching flag configurations over HTTP, allowing us to have minimal latency and create a better experience for our users.”
>
> “Vercel Edge Config 与 Vercel 版本的 LaunchDarkly 集成相结合，让我们能轻松更新功能开关配置，并实时、自动地将其推送到我们的 Edge Config 存储中。我们无需重新部署即可更改应用的用户界面（UI）和行为，从而保持高度灵活性。Edge Config 提供的低延迟特性显著降低了通过 HTTP 获取开关配置的开销，使我们得以实现极低延迟，为用户打造更佳体验。”

> ![](images/how-to-scale-a-large-codebase-vercel/img_003.png)
>
> **Vincent Derks,** Lead Engineer at Joyn
>
> **Vincent Derks**，Joyn 公司首席工程师

### Recommendations

### 推荐方案

- **Feature flag providers:** [LaunchDarkly, Statsig, Hypertune, and more](https://vercel.com/docs/storage/edge-config/edge-config-integrations)

- **功能开关服务提供商：**[LaunchDarkly、Statsig、Hypertune 等](https://vercel.com/docs/storage/edge-config/edge-config-integrations)

- **Feature flag storage:** [Vercel Edge Config](https://vercel.com/docs/storage/edge-config)

- **功能开关存储：**[Vercel Edge Config](https://vercel.com/docs/storage/edge-config)

- **CDN / Edge Network:** [Vercel](https://vercel.com/docs/edge-network/overview)

- **CDN / 边缘网络：**[Vercel](https://vercel.com/docs/edge-network/overview)

## De-risking experimentation with incremental builds

## 通过增量构建降低实验风险

High-performance teams experiment and iterate quickly. However, long build and deploy times slow everyone down and inhibit experimentation.

高性能团队能够快速开展实验并持续迭代。然而，漫长的构建与部署时间会拖慢所有人的节奏，并抑制实验探索。

The only way to scale a large codebase is to make it as incremental as possible, reusing work that’s already been completed (through caching) and only running code that’s changed.

扩展大型代码库的唯一方法，是尽可能使其具备增量性：复用已完成功能（借助缓存），且仅执行发生变更的代码。

As your application grows in size, so, too, do all parts of your build process:

随着应用规模不断增长，构建流程的各个环节也随之膨胀：

- Type checking, testing, prerendering static pages, bundling assets together

- 类型检查、测试、静态页面预渲染、资源打包

- Downloading and installing dependencies, restoring build caches

- 下载并安装依赖、恢复构建缓存

- Uploading build outputs, populating build caches

- 上传构建产物、填充构建缓存

With incremental builds through Turborepo, we can avoid re-computing work by separating each “microfrontend” or shared library into its own package.

借助 Turborepo 的增量构建能力，我们可通过将每个“微前端”或共享库拆分为独立包的方式，避免重复计算。

### How do incremental builds with Turborepo work?

### Turborepo 的增量构建是如何工作的？

Turborepo schedules independent tasks to execute in parallel. The result of each task is fingerprinted and cached to avoid re-computing the same work.

Turborepo 会调度相互独立的任务并行执行；每个任务的结果均经过指纹识别（fingerprinting）并缓存，从而避免重复执行相同工作。

When any of the inputs change, Turborepo invalidates the task and re-executes it. These value changes can then propagate throughout the entire graph of dependencies, updating the graph with minimal re-execution.

当任意输入发生变化时，Turborepo 会令该任务失效并重新执行。这些值的变化随后会在整个依赖图中传播，从而以最少的重新执行完成依赖图的更新。

Turborepo is able to save work that’s already been done in a remote cache, enabling faster CI times across all builds (and in local development). Turborepo’s remote cache on Vercel has already saved customers [**over a decade of CI time**](https://vercel.com/blog/vercel-remote-cache-turbo). That’s time your team gets back to build better product experiences.

Turborepo 能够将已完成的工作保存至远程缓存中，从而显著缩短所有构建（包括本地开发）的 CI 时间。Turborepo 在 Vercel 上的远程缓存已为用户节省了[**超过十年的 CI 时间**](https://vercel.com/blog/vercel-remote-cache-turbo)。这些被节省下来的时间，能让您的团队专注于打造更出色的产品体验。

### Recommendations

### 推荐资源

- **Incremental builds:** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)

- **增量构建：** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)

- **Running tasks:** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)

- **运行任务：** [Turborepo](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)

- **CI/CD:** [Vercel](https://vercel.com/docs/deployments/builds)

- **CI/CD：** [Vercel](https://vercel.com/docs/deployments/builds)

- **Remote Cache:** [Vercel](https://vercel.com/docs/monorepos/remote-caching)

- **远程缓存：** [Vercel](https://vercel.com/docs/monorepos/remote-caching)


## Deploying code without breaking existing versions through skew protection

## 通过“倾斜保护”（skew protection）实现代码部署，避免破坏现有版本

High performance teams have confidence releasing new code frequently. However, there’s a widely known and accepted side effect to releasing frequently: version skew.

高性能团队能够自信地高频发布新代码。然而，高频发布也存在一个广为人知且普遍接受的副作用：版本倾斜（version skew）。

### What is version skew?

### 什么是版本倾斜？

[Version skew](https://www.industrialempathy.com/posts/version-skew/) occurs when different versions of your application run on client and server, causing application errors and other unexpected behavior.

[版本偏差（Version skew）](https://www.industrialempathy.com/posts/version-skew/) 指客户端与服务端运行着应用程序的不同版本，从而引发应用错误及其他意外行为。

For example, imagine your newest deployment modifies the data structure by adding a required field to a user's profile. Older clients wouldn't expect this new field, leading to errors when they submit it.

例如，假设你最新的一次部署修改了数据结构，在用户档案中新增了一个必填字段。旧版客户端并未预期该字段的存在，因此在提交数据时将引发错误。

### How can we prevent version skew?

### 如何防止版本偏差？

At Vercel, we’ve had the opportunity to work with thousands of teams facing this problem, with customers deploying over 6 million times per month.

在 Vercel，我们有幸与数千支面临此问题的团队合作，客户每月部署次数超过 600 万次。

Vercel's Skew Protection resolves this problem at the platform and framework layer by using [version locking](https://www.industrialempathy.com/posts/version-skew/#version-locking), which ensures the client and server use the exact same version. In our example, outdated clients continue to communicate with servers that understand the old data structure, while updated clients are served the most recent deployment.

Vercel 的“偏差防护（Skew Protection）”通过在平台层与框架层采用 [版本锁定（version locking）](https://www.industrialempathy.com/posts/version-skew/#version-locking) 技术来解决该问题，确保客户端与服务端始终使用完全相同的版本。在上述示例中，过时的客户端仍可与理解旧数据结构的服务端通信；而更新后的客户端则会获得最新部署的服务。

Learn more about [how skew protection works](https://vercel.com/blog/version-skew-protection#the-mechanism-explained).

进一步了解 [偏差防护的工作原理](https://vercel.com/blog/version-skew-protection#the-mechanism-explained)。

### Recommendations:

### 建议：

- **Skew protection:** [Vercel](https://vercel.com/docs/deployments/skew-protection)

- **偏差防护：** [Vercel](https://vercel.com/docs/deployments/skew-protection)

## Incrementally adopting new technology

## 渐进式采用新技术

The era of large-scale, [one-time migrations](https://vercel.com/blog/incremental-migrations#understanding-big-bang-migrations) is over. The risk and cost of a failed migration are too high. The most responsible way to evolve a large codebase is through [incremental migrations](https://vercel.com/blog/incremental-migrations). This requires your codebase to be composed of smaller, independent pieces that can be updated or replaced over time.

大规模、[一次性迁移（one-time migrations）](https://vercel.com/blog/incremental-migrations#understanding-big-bang-migrations) 的时代已经结束。一次失败迁移所带来风险与成本过高。对大型代码库进行演进最稳妥的方式，是采用 [渐进式迁移（incremental migrations）](https://vercel.com/blog/incremental-migrations)。这要求你的代码库由更小、彼此独立的模块组成，以便随时间逐步更新或替换。

A composable architecture allows your team to choose the best tools for the job and continue to evolve them as needed. Most architectures today comprise the best tools for each use case across different cloud verticals.

可组合式架构（composable architecture）使您的团队能够为具体任务选择最合适的工具，并根据需要持续优化和演进这些工具。当前大多数架构都融合了面向不同云垂直领域（cloud verticals）各类使用场景的最优工具。

Vercel's frontend cloud connects and orchestrates all these composable pieces to deliver your user-facing product experience. Our goal is to make it as fast as possible for your engineering team to iterate changes and safely release code.

Vercel 的前端云（frontend cloud）将所有这些可组合组件连接并协调起来，从而交付面向用户的完整产品体验。我们的目标是让您的工程团队能够以最快的速度迭代变更，并安全地发布代码。

### Recommendations

### 推荐实践

- [Incremental migrations](https://vercel.com/blog/incremental-migrations)

- [渐进式迁移（Incremental migrations）](https://vercel.com/blog/incremental-migrations)

- [Frontend cloud integrations](https://vercel.com/integrations)

- [前端云集成（Frontend cloud integrations）](https://vercel.com/integrations)

- [Composable architecture through monorepos](https://vercel.com/docs/monorepos)

- [通过单体仓库（monorepos）实现可组合式架构](https://vercel.com/docs/monorepos)


## Applying this strategy for your team

## 将该策略应用于您的团队

Scaling a codebase isn't just about managing growth—it’s about building a foundation to raise the baseline for iteration velocity. It's about making sure that your team can keep delivering value to your customers, no matter how large your organization becomes.

扩展代码库（scaling a codebase）绝不仅仅是应对规模增长——它更关乎构建坚实基础，从而提升迭代速度的基准线；它关乎确保无论您的组织规模如何扩大，团队始终能持续为客户交付价值。

With the right tools and strategies, it can be transformational for your business. The biggest challenge is the organizational change required to make this change. It requires a shift in mindset. It's about viewing these challenges not as obstacles, but as opportunities for continuous iteration and improvement.

借助恰当的工具与策略，这一转变将对您的业务产生变革性影响。而最大的挑战在于推动所需的组织变革——这要求思维方式的根本转变：即不再将这些挑战视作障碍，而是将其视为持续迭代与改进的契机。

Embrace monorepos, leverage feature flags, implement incremental builds, and adopt skew protection to achieve the success criteria:

拥抱单体仓库（monorepos），善用功能开关（feature flags），实施增量构建（incremental builds），并采用偏移防护（skew protection），以达成成功标准：

- Releasing new changes frequently, with fast iterations  

- 频繁发布新变更，实现快速迭代

- Adopting new technology easily into the existing codebase  

- 轻松将新技术整合进现有代码库

- Enabling teams to independently work on different parts of the UI  

- 使团队能够独立开发 UI 的不同模块

- Sharing and reusing scripts and configuration, rather than reinventing every time  

- 共享与复用脚本及配置，而非每次重复造轮子

If you want to learn more about these practices, [we'd love to speak with you](https://vercel.com/contact/sales) and help your team adopt these patterns.  

如果您想深入了解这些实践方式，[我们非常期待与您交流](https://vercel.com/contact/sales)，并协助您的团队采用这些模式。

Vercel.com landing page  

Vercel.com 着陆页

### See for yourself  

### 亲身体验

Vercel.com landing page  

Vercel.com 着陆页

### Talk to a migration expert  

### 与迁移专家沟通