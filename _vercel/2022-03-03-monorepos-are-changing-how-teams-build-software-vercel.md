---
render_with_liquid: false
title: "Monorepos are changing how teams build software - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/monorepos"
date: "2022-03-03"
scraped_at: "2026-03-02T10:02:38.176240448+00:00"
language: "en-zh"
translated: true
description: "Monorepos are codebases containing multiple projects in a single unified code repository. This post explores how monorepos can improve your development workflow."
---
render_with_liquid: false
render_with_liquid: false

Mar 3, 2022

2022 年 3 月 3 日

Developing, shipping, and iterating is faster in a monorepo

在单体仓库（monorepo）中开发、交付和迭代更快。

全球规模最大的软件公司均采用单体仓库。但历史上，除 Facebook 或 Google 这类超大规模企业外，其他团队若想采用单体仓库，往往面临重重困难：实施过程耗时漫长，且常常令人头疼不已。

自 Turborepo [加入 Vercel](https://turborepo.org/blog/joining-vercel) 以来，我们已看到各类规模的开发团队纷纷采用 Turborepo，以实现[更快的构建速度](https://twitter.com/RobEasthope/status/1486994338290847745)，并通过在 Vercel 上远程缓存部署产物，累计节省了超过 200 天的构建时间。

Turborepo 提炼并整合了 Web 领域巨头们的实践经验与开发工作流，并将其以开源形式向 _每一位_ 开发者开放。它显著降低了单体仓库的使用门槛，让这项强大能力真正触手可及。

接下来，让我们一起探索单体仓库如何优化您的开发工作流。

## What are monorepos?

## 什么是单体仓库（monorepo）？

Monorepos are codebases containing multiple projects, often using multiple frameworks, in a single unified code repository. Rather than having 100+ separate repositories, teams instead choose to consolidate to a monorepo for a number of reasons:

单体仓库是指将多个项目（通常基于多种框架）统一存放于一个代码仓库中的代码库形态。相比维护 100 多个彼此独立的代码仓库，团队选择整合为单体仓库，原因众多，例如：

1. [跨包更新更轻松](https://vercel.com/blog/monorepos#1.-easier-updates-across-packages)

1. [跨包更新更轻松](https://vercel.com/blog/monorepos#1.-easier-updates-across-packages)

2. [协作与调试更高效](https://vercel.com/blog/monorepos#2.-easier-collaboration-and-debugging)

2. [协作与调试更高效](https://vercel.com/blog/monorepos#2.-easier-collaboration-and-debugging)

3. [Easier local development](https://vercel.com/blog/monorepos#3.-easier-local-development)

3. [更轻松的本地开发](https://vercel.com/blog/monorepos#3.-easier-local-development)

4. [Faster builds with remote caching](https://vercel.com/blog/monorepos#4.-faster-builds-with-remote-caching)

4. [借助远程缓存实现更快的构建](https://vercel.com/blog/monorepos#4.-faster-builds-with-remote-caching)

![The architecture of a monorepo deployed to Vercel.](images/monorepos-are-changing-how-teams-build-software-vercel/img_001.jpg)![The architecture of a monorepo deployed to Vercel.](images/monorepos-are-changing-how-teams-build-software-vercel/img_002.jpg)The architecture of a monorepo deployed to Vercel.

![部署到 Vercel 的单体仓库（monorepo）架构图。](images/monorepos-are-changing-how-teams-build-software-vercel/img_001.jpg)![部署到 Vercel 的单体仓库（monorepo）架构图。](images/monorepos-are-changing-how-teams-build-software-vercel/img_002.jpg)部署到 Vercel 的单体仓库（monorepo）架构图。

Monorepos empower software teams to be more collaborative and productive with improved transparency, discoverability, code sharing, and standardization. But colocation of code doesn’t solve every problem.

单体仓库（monorepo）赋能软件团队，通过提升透明度、可发现性、代码共享能力及标准化水平，促进协作并提高生产力。但将代码集中存放并不能解决所有问题。

## Turborepo

## Turborepo

[Turborepo](https://www.youtube.com/watch?v=YX5yoApjI3M&t=225s) is a high-performance build system for JavaScript and TypeScript codebases. It was designed after the workflows used by massive software engineering organizations to ship code at scale. Turborepo abstracts the complex configuration needed for monorepos and provides fast, incremental builds with zero-configuration remote caching.

[Turborepo](https://www.youtube.com/watch?v=YX5yoApjI3M&t=225s) 是面向 JavaScript 和 TypeScript 代码库的高性能构建系统。其设计灵感源自大型软件工程组织在规模化交付代码时所采用的工作流。Turborepo 抽象了单体仓库所需的复杂配置，提供开箱即用的远程缓存功能，从而实现快速、增量式的构建。

Instead of wasting days worrying about _how_ you're shipping, Turborepo lets you focus on _what_ you're shipping by abstracting configuration, scripts, and tooling on your behalf.

与其耗费数日纠结于“如何”交付代码，不如让 Turborepo 代您完成配置、脚本与工具链的抽象工作，使您得以专注于“交付什么”。

> “Turborepo has drastically improved developer productivity at Makeswift, helping us get to market faster.Turborepo has drastically improved developer productivity at Makeswift, helping us get to market faster.”
>
> ![](images/monorepos-are-changing-how-teams-build-software-vercel/img_003.jpg)
>
> **Lindsay Trinkle,** Co-founder of Makeswift

> “Turborepo 极大地提升了 Makeswift 的开发者生产力，助力我们更快地推向市场。”
>
> ![](images/monorepos-are-changing-how-teams-build-software-vercel/img_003.jpg)
>
> **Lindsay Trinkle**，Makeswift 联合创始人

Let’s look at some of the advantages of using monorepos and explore how Turborepo makes them easy to adopt.

接下来，让我们了解采用单体仓库（monorepo）的一些优势，并探讨 Turborepo 如何让这些优势更易于落地。

## Advantages of monorepos

## 单体仓库（monorepo）的优势

### 1. Easier updates across packages

### 1. 跨包更新更轻松

Let’s say you have a component library being reused across 100 different repositories, distributed as an npm package. Publishing a new version of the component library and updating all 100 repositories can turn into a nightmare. Different repos quickly get out of date and discrepancies in your application begin to appear. ( _Why does the button look different on this page? Oh, it’s using a different version of the component library._)

假设你有一个组件库，作为 npm 包被复用于 100 个不同的代码仓库中。发布该组件库的新版本，并同步更新全部 100 个仓库，可能演变成一场噩梦：各仓库版本迅速脱节，你的应用中开始出现不一致现象。（_为什么这个页面上的按钮样式不同？哦，原来它使用了组件库的不同版本。_）

With monorepos, updating the version of a package can happen in a single place and cascade to all other dependencies. This helps ensure consistency across products and features and prevents the pain of trying to coordinate commits across multiple repositories.

在单体仓库（monorepo）中，只需在一个地方更新某个包的版本，即可自动级联至所有依赖该包的其他模块。这有助于保障产品与功能间的一致性，也避免了跨多个仓库协调提交所带来的困扰。

> “With Turborepo, we were able to give each workspace its own build, test, and typecheck scripts and not worry about manually managing when they execute — Turbo handles the pipelining and caching. Turbo remote caching has drastically sped up our CI runs when a code change only touches one or a few workspaces.”  
>  
> “借助 Turborepo，我们得以让每个工作区（workspace）拥有独立的构建、测试和类型检查脚本，无需手动管理其执行时机——Turbo 自动处理流水线编排与缓存。当代码变更仅影响一个或少数几个工作区时，Turbo 的远程缓存显著加快了我们的 CI 构建速度。”  
>  
> ![](images/monorepos-are-changing-how-teams-build-software-vercel/img_004.jpg)  
>  
> **Spike Brehm,** Software Engineer at Watershed  
>  
> **斯派克·布雷姆（Spike Brehm）**，Watershed 公司软件工程师

Try out the [Turborepo design system starter](https://github.com/vercel/turborepo/tree/main/examples/design-system) to build your own component library.

不妨尝试 [Turborepo 设计系统入门模板](https://github.com/vercel/turborepo/tree/main/examples/design-system)，快速搭建你自己的组件库。

### 2. Easier collaboration and debugging

### 2. 协作与调试更轻松

When critical pieces of your system are distributed across many repositories, it’s hard to find the code you’re looking for. With all code living in a single place, it’s easier to search, share, and reuse code across different systems, applications, or libraries. Plus, it’s easier to enforce standards across the organization in a centralized location.

当系统的关键模块分散在多个仓库中时，定位所需代码往往十分困难。而将全部代码集中于单一仓库后，跨系统、跨应用或跨库的代码搜索、共享与复用都变得更加便捷；同时，组织层面的规范也能在统一位置高效落地与强制执行。

### 3. Easier local development

### 3. 本地开发更轻松

With separately published repositories, the current tooling (`npm link`) makes it difficult to make changes to shared components or services. This method struggles to scale as the number of repositories grows. It’s not feasible to globally [symlink](https://en.wikipedia.org/wiki/Symbolic_link) 100 repositories together to run an end-to-end test on your local machine.

在各自独立发布的仓库模式下，当前主流工具（如 `npm link`）难以支持对共享组件或服务的高效修改。随着仓库数量增长，该方法的可扩展性迅速下降——你不可能在本地机器上全局地将 100 个仓库通过 [符号链接（symlink）](https://zh.wikipedia.org/wiki/%E7%AC%A6%E5%8F%B7%E9%93%BE%E6%8E%A5) 关联起来，以运行端到端测试。

With monorepos, we can set up testing, linting, formatting, publishing, and other tasks _once_ in a single place where dependencies can be easily managed and upgraded together. This helps prevent toolchains for less active applications from falling behind, making it easy to run locally when revisiting the application later.

而在单体仓库中，我们可以将测试、代码检查（linting）、格式化、发布及其他任务**一次性**统一配置于同一位置，使依赖关系更易管理、协同升级。这有效防止了低活跃度应用所用工具链逐渐过时，也让你日后重新打开该应用时，能轻松完成本地运行。

> “Turborepo has saved us 67 hours of CI since we adopted it. That's for a team of only four full-time developers.”  
> “自采用 Turborepo 以来，我们已节省了 67 小时的 CI 时间——而这仅是一个仅有四名全职开发人员的团队。”

> ![](images/monorepos-are-changing-how-teams-build-software-vercel/img_005.jpg)  
> ![](images/monorepos-are-changing-how-teams-build-software-vercel/img_005.jpg)

> **Matt Pocock,** Lead Developer of Stately.ai  
> **Matt Pocock**，Stately.ai 首席开发者

Try out the [Turborepo example with pnpm](https://github.com/vercel/turborepo/tree/main/examples/with-pnpm) for the fastest local development experience.  
试用 [支持 pnpm 的 Turborepo 示例](https://github.com/vercel/turborepo/tree/main/examples/with-pnpm)，获得最快的本地开发体验。

### 4\. Faster builds with remote caching  
### 4．借助远程缓存实现更快的构建

Turborepo caches the output of any previously run command such as testing and building, so it can replay the cached results instantly instead of rerunning them. Normally, this cache lives on the same machine executing the command.  
Turborepo 会缓存所有已执行过的命令（例如测试和构建）的输出结果，从而可在下次直接复用缓存结果，而无需重新运行。通常情况下，该缓存仅保存在执行命令的同一台机器上。

However, with remote caching, you can share the Turborepo cache across your entire team and CI, resulting in even _faster_ builds and days of time saved. This [speeds up your workflow](https://vercel.com/resources/iterate-faster-with-a-streamlined-development-workflow) by avoiding the need to constantly re-compile, re-test, or re-execute your code if it is unchanged.  
然而，借助远程缓存，您可将 Turborepo 缓存共享给整个团队及 CI 系统，从而实现**更快速的构建**，并节省数天时间。这 [显著提升了您的工作流效率](https://vercel.com/resources/iterate-faster-with-a-streamlined-development-workflow)，因为当代码未发生变更时，您无需反复重新编译、重新测试或重新执行。

![](images/monorepos-are-changing-how-teams-build-software-vercel/img_006.jpg)![](images/monorepos-are-changing-how-teams-build-software-vercel/img_007.jpg)  
![](images/monorepos-are-changing-how-teams-build-software-vercel/img_006.jpg)![](images/monorepos-are-changing-how-teams-build-software-vercel/img_007.jpg)

## Get started with monorepos  
## 开始使用单体仓库（Monorepo）

[Try out Turborepo](https://turborepo.org/docs/getting-started) today, enable [Remote Caching](https://vercel.com/docs/concepts/monorepos/remote-caching), and experience a faster workflow for your team paired with an improved developer experience.  
立即 [试用 Turborepo](https://turborepo.org/docs/getting-started)，启用 [远程缓存](https://vercel.com/docs/concepts/monorepos/remote-caching)，为您的团队带来更高效的工作流，同时提升开发者体验。

Watch Turborepo Remote Caching in action and get started with your monorepo today.  
观看 Turborepo 远程缓存的实际运行效果，并即刻开启您的单体仓库之旅。