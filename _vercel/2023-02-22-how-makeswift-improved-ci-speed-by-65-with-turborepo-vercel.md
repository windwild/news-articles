---
title: "How Makeswift improved CI speed by 65% with Turborepo - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-makeswift-improved-ci-speed-by-65-with-turborepo"
date: "2023-02-22"
scraped_at: "2026-03-02T09:54:36.542132575+00:00"
language: "en-zh"
translated: true
description: "makeswift"
---
&#123;% raw %}

Feb 22, 2023

2023 年 2 月 22 日

深受卡特彼勒（Caterpillar）和 Render 等公司信赖的 [Makeswift](https://www.makeswift.com/)，以向客户交付简单易用的可视化或无代码 Next.js 网站构建工具而自豪。当这支小型团队开始因漫长的构建时间及欠佳的开发体验而举步维艰时，他们转向了 [Turborepo](https://turbo.build/repo)。采用 Turborepo 后，Makeswift **整体 CI 流水线耗时缩短了 65%**。

Makeswift 最初依赖一套由 Kubernetes 和 Bazel 构建的自定义构建流程。他们采用“多单体仓库（multi-monorepo）”架构；在引入 Turborepo 之前，主要依靠 GitHub Actions（配合文件路径通配符忽略机制）与精巧的 Docker 构建策略来管理各项任务。这些方案虽 _基本可行_，但维护困难、协作成本高。

当 Bazel 下的 CI 构建时间攀升至约 20 分钟时，团队开始着手优化其构建流程、工作流以及整体开发体验。他们花费数月尝试在原有架构基础上打造一套解决方案，但很快意识到：所需配置复杂度已超出团队当前可承受范围。

在发现 Turborepo 后，迁移过程极为迅速。包括代码检查（linting）、类型校验（typechecking）、构建（building）、代码生成（codegen）、本地开发（dev）、静态资源生成（generate）、提交前检查（pre-commit）及推送前检查（pre-push）在内的所有流水线任务，如今无论在本地还是 CI 环境中均可自动调度执行——开发者完全无需手动干预。

> “Turborepo 开箱即用，配置之简易远超我们的预期，体验极佳。Turborepo 开箱即用，配置之简易远超我们的预期，体验极佳。”  
>  
> ![](images/how-makeswift-improved-ci-speed-by-65-with-turborepo-vercel/img_001.png)  
>  
> **米格尔·奥勒尔（Miguel Oller），联合创始人兼首席执行官**

### Makeswift 如何结合使用 Turborepo 与 Vercel

Makeswift 的开发者需要尽可能快速地完成迭代——平均每天执行约 50 次构建，并实现每日向生产环境部署。**在采用 Turborepo 之前，从代码提交到完成部署平均耗时约 20 分钟；如今这一过程已压缩至不到 1 分钟。** 由于 Vercel 为每个 Pull Request 自动创建预览部署（Preview Deployment），Makeswift 的迭代周期大幅缩短，内部代码评审与团队协作也因此变得更为顺畅高效。

Turborepo 同样显著提升了 Makeswift 的本地开发体验。如今，团队仅需一条命令即可一键启动端到端开发栈，彻底告别过去需手动打开多个终端分别运行各服务组件的繁琐操作。所有节省下来的时间，都转化为宝贵的开发工时——Makeswift 可将这些时间投入下一代新功能的研发，或为即将到来的版本发布做更充分准备。

### 下一步：持续深度优化

While Makeswift was the first Turborepo customer, they’re still looking forward to exploring more that Turborepo and Vercel has to offer.  

尽管 Makeswift 是 Turborepo 的首位客户，但他们仍热切期待进一步探索 Turborepo 与 Vercel 所提供的更多功能。

They’re excited to start using [Vercel Edge Middleware](https://vercel.com/features/edge-functions) for multi-tenancy and features like internal packages and publishing to npm in their open-source repo.  

他们已迫不及待地希望在开源仓库中启用 [Vercel Edge 中间件（Edge Middleware）](https://vercel.com/features/edge-functions)，以支持多租户架构，并实现内部包管理、发布至 npm 等功能。

Would your team's platform benefit from faster iterations and seamless scaling? [Get in touch](https://vercel.com/contact/sales).  

您的团队平台是否也能从更快的迭代速度与无缝的弹性扩展中获益？[立即联系](https://vercel.com/contact/sales)
&#123;% endraw %}
