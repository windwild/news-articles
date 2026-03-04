---
title: "Supabase improves their DX with Turborepo - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-supabase-elevated-their-developer-experience-with-turborepo"
date: "2023-01-24"
scraped_at: "2026-03-02T09:56:18.941292678+00:00"
language: "en-zh"
translated: true
description: "Supabase and Turborepo"
---
{% raw %}

Jan 24, 2023

2023 年 1 月 24 日

[Supabase](https://supabase.com/) 是一个开源的 Firebase 替代方案，提供项目在周末内即可上线所需的所有后端功能。这支持续壮大的、由 60 名开发者组成的团队，自创立之初便采用 [Vercel 上的 Next.js](https://vercel.com/solutions/nextjs)，快速向数千名用户交付其文档、营销网站与管理控制台。而随着用户基数持续增长，团队正准备以更快的速度发布新功能。

![Turborepo + Supabase](images/supabase-improves-their-dx-with-turborepo-vercel/img_001.jpg)![Turborepo + Supabase](images/supabase-improves-their-dx-with-turborepo-vercel/img_002.jpg)Turborepo + Supabase

借助 [Turborepo](https://turbo.build/repo)，对 UI 的修改从未如此轻松。过去，哪怕只是更改某个 UI 组件的类名，开发人员也需先在代码仓库中更新代码，再发布一个 npm 版本，最后从 npm 拉取该版本，才能最终部署至生产环境。这样一个看似简单的变更，却需要经历复杂流程，带来过高的工程开销。

如今，单个开发者只需在一个地方、通过一次 Pull Request 即可完成全部修改——大幅降低了外部贡献的门槛，并显著提升了开发体验。整个 Supabase 系统仅需一条终端命令即可本地运行；而来自核心团队之外的 Supabase 社区成员，也能直接贡献高质量、可一键部署至生产环境的代码。

> “在引入 Turborepo 之前，修改 UI 需要经过审慎规划和多个步骤。而现在，得益于 Turborepo，我们的 Tailwind CSS、TypeScript 和代码规范（linting）配置在仓库中‘神奇地’自动生效——无需人工维护，一切运转如常。这简直令人惊叹！”  
>  
> ![](images/supabase-improves-their-dx-with-turborepo-vercel/img_003.png)  
>  
> **Terry Sutton**，前端开发工程师

Supabase 的开发者还充分利用 [Vercel 预览部署（Preview Deployments）](https://vercel.com/features/previews) 及其内置评论功能，实现与外部团队的高效协作。通过分享实时预览链接，并在评论区收集利益相关方的反馈，这支分布在全球的 60 人团队得以快速交付专业级成果。

作为一家在销售旺季日均部署数百次的公司，Jonathan 及其团队深知：优化这一流程，无异于一场范式变革。

> “Vercel 与 Next.js 的一大优势在于：你只需发起一个 PR，合并之后，变更即刻上线。”  
>  
> ![](images/supabase-improves-their-dx-with-turborepo-vercel/img_004.png)  
>  
> **Jonathan Summers-Muir**，前端开发工程师

那么，Supabase 开发团队下一步计划是什么？他们正满怀期待地探索 Turborepo 的更多能力：例如在 Vercel 上启用远程缓存（Remote Caching）、进一步缩短构建时间，以及其他全新特性。

**If you’d like to experience how Turborepo and Vercel can improve your own developer experience,** [**get in touch**](https://vercel.com/contact) **.**

**如果您希望亲身体验 Turborepo 和 Vercel 如何提升您自身的开发体验，**[**请联系我们**](https://vercel.com/contact)**。**
{% endraw %}
