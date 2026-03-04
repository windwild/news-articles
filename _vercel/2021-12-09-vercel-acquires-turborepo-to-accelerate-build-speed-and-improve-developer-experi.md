---
title: "Vercel acquires Turborepo to accelerate build speed and improve developer experience  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-acquires-turborepo"
date: "2021-12-09"
scraped_at: "2026-03-02T10:03:47.071900212+00:00"
language: "en-zh"
translated: true
description: "Vercel acquires Turborepo to accelerate build speed and improve developer experience"
---
{% raw %}

Dec 9, 2021

2021年12月9日

We're thrilled to announce our acquisition of [Turborepo](https://www.turborepo.org/) to join us on our mission to make the Web. Faster.

我们非常激动地宣布，Vercel 已完成对 [Turborepo](https://www.turborepo.org/) 的收购，携手推进“让 Web 更快”的使命。

Turborepo is a high-performance build system for JavaScript and TypeScript codebases. Through incremental builds, intelligent remote caching, and optimized task scheduling, Turborepo can boost build speeds by 85% or more, enabling teams of all sizes to maintain a fast and efficient build system that scales as codebases and teams grow.

Turborepo 是面向 JavaScript 和 TypeScript 代码库的高性能构建系统。借助增量构建、智能远程缓存和优化的任务调度，Turborepo 可将构建速度提升 85% 或更高，助力各种规模的团队在代码库与团队持续扩大的过程中，始终维持快速、高效的构建系统。

![Announcing Vercel's acquisition of Turborepo, a powerful build system for JavaScript and TypeScript codebases. ](images/vercel-acquires-turborepo-to-accelerate-build-speed-and-improve-developer-experi/img_001.jpg)![Announcing Vercel's acquisition of Turborepo, a powerful build system for JavaScript and TypeScript codebases. ](images/vercel-acquires-turborepo-to-accelerate-build-speed-and-improve-developer-experi/img_002.jpg)Announcing Vercel's acquisition of Turborepo, a powerful build system for JavaScript and TypeScript codebases.

![宣布 Vercel 收购 Turborepo —— 一款面向 JavaScript 和 TypeScript 代码库的强大构建系统。](images/vercel-acquires-turborepo-to-accelerate-build-speed-and-improve-developer-experi/img_001.jpg)![宣布 Vercel 收购 Turborepo —— 一款面向 JavaScript 和 TypeScript 代码库的强大构建系统。](images/vercel-acquires-turborepo-to-accelerate-build-speed-and-improve-developer-experi/img_002.jpg)宣布 Vercel 收购 Turborepo —— 一款面向 JavaScript 和 TypeScript 代码库的强大构建系统。

With the acquisition, we're making [Turborepo's CLI](https://turborepo.org/docs/getting-started) open source and available for everyone to use today. [Jared Palmer](https://twitter.com/jaredpalmer), founder of Turborepo and creator of popular open-source projects like Formik and TSDX, will also be joining Vercel. Jared will keep delivering on Turborepo's capabilities as well as [lead a team](https://www.vercel.com/careers) dedicated to advancing Vercel's world-class build performance.

此次收购后，我们将 [Turborepo 的命令行工具（CLI）](https://turborepo.org/docs/getting-started) 开源，并即日起向所有开发者免费开放使用。Turborepo 创始人、知名开源项目 Formik 与 TSDX 的作者 [Jared Palmer](https://twitter.com/jaredpalmer) 也将加入 Vercel。Jared 将继续推动 Turborepo 功能演进，并将 [领导一支团队](https://www.vercel.com/careers)，致力于进一步提升 Vercel 业界领先的构建性能。

## Unlocking the power of monorepos

## 释放单体仓库（monorepo）的强大能力

We've seen the use of monorepos skyrocket as teams embrace flexibility at scale. With projects managed through a shared repository, teams get improved transparency, discoverability, code sharing, and standardization across the organization or project, leading to increased collaboration and iteration speed.

随着团队在规模化发展中追求更高灵活性，单体仓库（monorepo）的采用率正迅猛攀升。通过共享代码仓库统一管理多个项目，团队可显著提升协作透明度、代码可发现性、跨项目代码复用能力以及组织或项目范围内的标准化水平，从而加快协同开发与迭代速度。

But this comes at a cost. As codebases and teams grow in complexity, the burden of configuring, maintaining, and scaling monorepo architectures becomes increasingly prohibitive.

但这一优势也伴随着代价：随着代码库与团队复杂度不断上升，配置、维护和扩展 monorepo 架构的负担也日益沉重，渐成难以承受之重。

> “Turborepo is just a better way to build our code. It's saved us countless hours of our developer's time and improved our workflows.Turborepo is just a better way to build our code. It's saved us countless hours of our developer's time and improved our workflows.”
>
> ![](images/vercel-acquires-turborepo-to-accelerate-build-speed-and-improve-developer-experi/img_003.jpg)
>
> **Eric Koslow,** CTO and Co-Founder of Lattice

> “Turborepo 让我们的代码构建方式变得更优——它为我们开发者节省了数不清的工时，并显著优化了工作流。”  
> “Turborepo 让我们的代码构建方式变得更优——它为我们开发者节省了数不清的工时，并显著优化了工作流。”
>
> ![](images/vercel-acquires-turborepo-to-accelerate-build-speed-and-improve-developer-experi/img_003.jpg)
>
> **Eric Koslow**，Lattice 公司首席技术官兼联合创始人

With powerful capabilities like intelligent caching, optimized task scheduling, and an accessible API, Turborepo unlocks the power of monorepos for _everyone_. By abstracting the complex configuration needed for most monorepos into a single cohesive build system, Turborepo gives you a world-class development experience without the maintenance cost.

凭借智能缓存、优化的任务调度以及易用的 API 等强大能力，Turborepo 让单体仓库（monorepo）的强大优势惠及每一位开发者。它将绝大多数 monorepo 所需的复杂配置，抽象为一个统一、内聚的构建系统，让您无需承担高昂的维护成本，即可享受世界级的开发体验。

## The future of frontend infrastructure

## 前端基础设施的未来

Vercel's mission is to make it easier for anyone to join the developer process and give teams the tooling and capabilities they need to make the Web. Faster. As we continue to build out its capabilities, Turborepo has the potential to change how teams collaborate and work. [Remote caching](https://turborepo.org/docs/features/remote-caching), now in beta, is just the beginning of the task sharing that is possible when leveraging Vercel’s infrastructure.

Vercel 的使命是让任何人都能更轻松地参与开发流程，并为团队提供构建更快速 Web 所需的工具与能力。随着我们持续拓展其功能，Turborepo 有望彻底改变团队协作与工作的方式。目前处于测试阶段的 [远程缓存（Remote caching）](https://turborepo.org/docs/features/remote-caching)，仅仅是借助 Vercel 基础设施实现任务共享的起点。

```bash
1$ npx create-turbo@latest
```

```bash
1$ npx create-turbo@latest
```

Create your first monorepo with the Turbo CLI.

使用 Turbo CLI 创建您的第一个单体仓库（monorepo）。

The [Turborepo CLI](https://turborepo.org/docs/getting-started) is available for anyone to start using today. We'll be reaching out to existing Turborepo customers with more information on how you can seamlessly move from Turborepo's cloud-based caching infrastructure to Vercel.

[Turborepo CLI](https://turborepo.org/docs/getting-started) 现已开放，任何人都可立即开始使用。我们将主动联系现有 Turborepo 用户，提供更详细的迁移指南，助您无缝地从 Turborepo 基于云的缓存基础设施过渡至 Vercel。

To hear more about the future of Turborepo and build systems at Vercel, [join Jared and Vercel's Head of Developer Relations Lee Robinson on YouTube](https://youtu.be/YX5yoApjI3M) on Friday, December 10 at 1pm PT \| 9pm GMT.

如想进一步了解 Turborepo 及 Vercel 构建系统的发展前景，请于 12 月 10 日（星期五）太平洋时间下午 1 点（GMT 晚上 9 点）[在 YouTube 上观看 Jared 与 Vercel 开发者关系主管 Lee Robinson 的联合分享](https://youtu.be/YX5yoApjI3M)。
{% endraw %}
