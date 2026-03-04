---
title: "Turbopack updates: Moving homes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/turbopack-moving-homes"
date: "2024-07-23"
scraped_at: "2026-03-02T09:42:51.866259654+00:00"
language: "en-zh"
translated: true
description: "An update on our progress with Turbopack, details on where we’re headed, and a planned move of Turbopack to the Next.js repository."
---
{% raw %}

Jul 23, 2024

2024 年 7 月 23 日

Turbopack 的进展、当前优先事项，以及代码库迁移至新仓库的说明。

Turbopack 是 Vercel 正在开发的一款全新的 JavaScript/TypeScript 打包工具。它基于 webpack 十余年的经验积累，旨在打造一款可与多种框架协同使用的通用打包器。

我们将把 Turbopack 的代码库迁入 Next.js 仓库——同时借此机会，向大家同步 Turbopack 当前的开发进展及后续规划。

## 项目更新

## 项目更新

- **您今天即可在 Next.js 中试用 Turbopack。** 如果您使用的是[受支持的 webpack loader](https://nextjs.org/docs/app/api-reference/next-config-js/turbo#webpack-loaders)，或未配置任何自定义 webpack 选项，则可通过运行 `next dev --turbo` 启动 Next.js 开发服务器，从而显著提升开发体验。为获得全部最新修复，请推荐搭配使用 Next.js Canary（预发布）渠道。我们即将发布更新版的 [Next.js 15.0 发布候选版本（RC）](https://nextjs.org/blog/next-15-rc)，其中将集成最新版 Turbopack。

- [**Turbopack 已通过 Next.js 全套开发测试用例（100%）**](https://areweturboyet.com/)，且 **所有** [**Next.js 示例项目**](https://github.com/vercel/next.js/tree/canary/examples) **均已兼容 Turbopack。** 我们正快速推进解决[用户报告但尚未被现有测试覆盖的问题](https://github.com/vercel/next.js/issues/new/choose)。

- **我们已验证：Next.js 应用中使用频率最高的 300 个 `npm` 包均可由 Turbopack 成功编译。**

- **我们每天都在使用 Turbopack 开发 vercel.com。** 对团队而言，Turbopack 在服务首次启动和代码热更新两个环节，均明显快于 webpack。

我们亦已启动生产环境构建（production builds）的相关工作。如需跟进该方向进展，请访问 [https://areweturboyet.com/build](https://areweturboyet.com/build)。

## Moving homes

## 搬迁代码仓库

In the coming weeks, we will move the source code for the Turbopack bundler out of [the](https://github.com/vercel/turbo/) [`vercel/turbo`](https://github.com/vercel/turbo/) [repository](https://github.com/vercel/turbo/) and into [the](https://github.com/vercel/next.js) [`vercel/next.js`](https://github.com/vercel/next.js) [monorepo](https://github.com/vercel/next.js). We believe that co-locating the source code will enable us to iterate faster and get Turbopack to a stable release with support for production builds sooner, both in Next.js and as a standalone bundler for the rest of the JavaScript ecosystem.

在接下来的几周内，我们将把 Turbopack 打包器（bundler）的源代码从 [vercel/turbo](https://github.com/vercel/turbo/) 仓库迁移至 [vercel/next.js](https://github.com/vercel/next.js/) 单体仓库（monorepo）。我们相信，将源代码集中存放将有助于我们加速迭代，并更快地推动 Turbopack 达到稳定版本——不仅在 Next.js 中全面支持生产构建，同时也作为独立打包器服务于整个 JavaScript 生态系统。

We have not begun moving the code yet, as we felt it was important to inform the community of these changes before they are made.

目前我们尚未启动代码迁移工作，因为我们认为有必要在实施变更前先行向社区通报这一调整。

**There will be no change to** [**the Turborepo build system**](https://turbo.build/repo/docs) **project**, which will remain where it is in the `vercel/turbo` repository. **There will also be no change to how you interact with Turbopack, Turborepo, or Next.js.**

**Turborepo 构建系统**（[项目主页](https://turbo.build/repo/docs)）**本身不会发生任何变动**，它将继续保留在 `vercel/turbo` 仓库中。**您与 Turbopack、Turborepo 或 Next.js 的交互方式也完全保持不变。**

## Why are we moving?

## 为何要进行此次迁移？

Initially, we believed that putting Turbopack (the bundler) and Turborepo (the build system) into the same repository would assist with sharing code between both projects, [especially as Turborepo has recently migrated from Go to Rust](https://vercel.com/blog/turborepo-migration-go-rust).

最初，我们认为将 Turbopack（打包器）与 Turborepo（构建系统）置于同一仓库中，有助于两个项目之间共享代码——尤其是考虑到 Turborepo 近期已从 Go 迁移至 Rust。

However, as Next.js is Turbopack’s primary user during this phase of development, we found that internal changes in Turbopack affect Next.js more often than Turborepo. Since Next.js is in a separate repository, we often have to spend time synchronizing dependencies or coordinating changes between these two repositories.

然而，在当前开发阶段，Next.js 是 Turbopack 最主要的使用者；我们发现 Turbopack 的内部变更对 Next.js 的影响远超 Turborepo。由于 Next.js 位于独立的仓库中，我们常常不得不耗费大量时间同步依赖项，或协调这两个仓库之间的变更。

![An example of how we must cross repository boundaries to make breaking changes today.](images/turbopack-updates-moving-homes-vercel/img_001.jpg)![An example of how we must cross repository boundaries to make breaking changes today.](images/turbopack-updates-moving-homes-vercel/img_002.jpg)![An example of how we must cross repository boundaries to make breaking changes today.](images/turbopack-updates-moving-homes-vercel/img_003.jpg)![An example of how we must cross repository boundaries to make breaking changes today.](images/turbopack-updates-moving-homes-vercel/img_004.jpg)An example of how we must cross repository boundaries to make breaking changes today.

![今天我们为实施破坏性变更而不得不跨越仓库边界的示例。](images/turbopack-updates-moving-homes-vercel/img_001.jpg)![今天我们为实施破坏性变更而不得不跨越仓库边界的示例。](images/turbopack-updates-moving-homes-vercel/img_002.jpg)![今天我们为实施破坏性变更而不得不跨越仓库边界的示例。](images/turbopack-updates-moving-homes-vercel/img_003.jpg)![今天我们为实施破坏性变更而不得不跨越仓库边界的示例。](images/turbopack-updates-moving-homes-vercel/img_004.jpg)今天我们为实施破坏性变更而不得不跨越仓库边界的示例。

Over time, we developed hacks to work around some of these problems. We created tools to check out both repositories, combine our `Cargo.toml` files (Rust’s equivalent of `package.json`) into a unified workspace, and merge our Cargo lockfiles. Unfortunately, these hacks are fragile partial solutions, and the bespoke nature of our tooling made it harder for us to onboard new engineers. In some cases, [we’ve even had to upstream changes to IDE plugins](https://github.com/mrcjkb/rustaceanvim/pull/402) to fix issues with our workflow.

久而久之，我们开发出了一些临时性方案来应对上述部分问题：例如创建工具以同时检出两个仓库，将各自的 `Cargo.toml` 文件（Rust 中相当于 JavaScript 的 `package.json`）合并为统一的工作区，并合并 Cargo 锁文件（lockfiles）。遗憾的是，这些临时方案脆弱且仅能解决局部问题；而定制化程度过高的工具链，也加大了新工程师上手的难度。在某些情况下，我们甚至不得不向 IDE 插件（如 [rustaceanvim](https://github.com/mrcjkb/rustaceanvim/pull/402)）提交上游补丁，以修复工作流中的问题。

Moving forward, we will utilize a top-level `Cargo.toml` configuration with [Cargo workspaces](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html), similar to how one might [organize packages in a JavaScript workspace](https://turbo.build/repo/docs/crafting-your-repository/structuring-a-repository).

后续，我们将采用顶层 `Cargo.toml` 配置并借助 [Cargo 工作区（workspaces）](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html) 进行管理——其组织方式类似于在 JavaScript 工作区中[组织多个包](https://turbo.build/repo/docs/crafting-your-repository/structuring-a-repository)。

When creating and maintaining release branches in Next.js, we’ll be able to backport both Next.js and Turbopack hotfixes into the same Git branch, without needing to maintain a separate branch in the `vercel/turbo` repo with it’s own release tags.

在 Next.js 中创建和维护发布分支时，我们将能够将 Next.js 和 Turbopack 的热修复（hotfixes）一并合入同一 Git 分支，而无需在 `vercel/turbo` 仓库中单独维护一个拥有独立发布标签（release tags）的分支。

## Does this mean Turbopack will only support Next.js?

## 这是否意味着 Turbopack 将仅支持 Next.js？

No. The core of Turbopack remains framework-agnostic. We still want to support other frameworks and standalone bundler usage, but our immediate focus is on Next.js to start. Ensuring this clear focus helps Turbopack users in a few ways:

否。Turbopack 的核心依然保持框架无关性（framework-agnostic）。我们仍致力于支持其他框架以及独立的打包器（bundler）使用场景；但现阶段我们的首要重点是 Next.js。明确这一聚焦方向，能从以下几个方面更好地服务 Turbopack 用户：

- **Helping as many developers as soon as possible.** We're seeing increasingly large applications built with Next.js over time, and we want to make sure Turbopack helps users at scale. By using Next.js as a boundary to our current development scope, we have better clarity on how to help a cohort of millions of developers as soon as we can.

- **尽快帮助尽可能多的开发者。** 我们观察到，随时间推移，基于 Next.js 构建的大型应用日益增多；我们希望 Turbopack 能在规模化场景下切实助力用户。以 Next.js 作为当前开发范围的边界，有助于我们更清晰地规划路径，从而尽早为数百万开发者群体提供有效支持。

- **Crafting better APIs for Turbopack.** With Turbopack and Next.js in the same monorepo, it will be easier for us to make changes and iterate on our APIs in one pull request, validated against the Next.js test suite in CI.

- **打造更优的 Turbopack API。** 当 Turbopack 与 Next.js 共处于同一单体仓库（monorepo）中时，我们便可在一次 Pull Request 中同步修改并迭代 Turbopack 的 API，并直接通过 CI 中的 Next.js 测试套件进行验证。

In time, we will reach a stable state for the general-purpose bundler to be used outside of Next.js. At that point, we will move Turbopack to its own separate repository.

未来，我们将使 Turbopack 作为通用型打包器达到稳定可用的状态，从而支持在 Next.js 之外的场景中使用。届时，我们将把 Turbopack 迁移至其独立的专属代码仓库。

## How will this migration be performed?

## 此次迁移将如何执行？

We intend to [use `git-subtree`](https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt) in combination [with `git-filter-branch`](https://git-scm.com/docs/git-filter-branch) to copy over all of the Turbopack source code, along with its commit history. In preparation for the change, we’ll need to make changes to our CI configuration and build scripts to ensure all of our testing infrastructure moves with our source code.

我们计划结合使用 [`git-subtree`](https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt) 与 [`git-filter-branch`](https://git-scm.com/docs/git-filter-branch)，将 Turbopack 的全部源代码及其完整提交历史迁移过去。为确保顺利过渡，我们还需调整 CI 配置与构建脚本，以保证所有测试基础设施随源代码一同迁移。

## Looking forward: Priorities for Turbopack

## 展望未来：Turbopack 的发展重点

We’re close to marking Turbopack as stable for development when used with Next.js. When this happens, Turbopack will initially remain opt-in for existing Next.js projects and we will align any breaking changes to the default bundler with a future major release of Next.js, with continued webpack support after the defaults are changed.

我们已非常接近将 Turbopack 标记为“与 Next.js 搭配使用时开发就绪（stable for development）”的状态。届时，Turbopack 在现有 Next.js 项目中仍将默认保持可选启用（opt-in）；任何针对默认打包器的重大变更，都将与 Next.js 的下一次主版本（major release）同步推出；同时，在默认打包器切换后，Webpack 支持仍将持续保留。

Current priorities for the team are:

团队当前的重点工作包括：

- **解决用户报告的剩余 Bug 及边缘场景下的性能退化问题。** 如果您在使用 Turbopack 时遇到任何问题，[请务必告知我们](https://github.com/vercel/next.js/issues/new/choose)！我们正密切关注所有已报告的问题，而 Turbopack 1.0 的发布离不开您的帮助。

- **降低内存占用。** Turbopack 采用受其他工具（如 [Rust 编译器](https://rustc-dev-guide.rust-lang.org/salsa.html) 和 [rust-analyzer](https://rustc-dev-guide.rust-lang.org/salsa.html)）启发的[细粒度函数级缓存机制](https://turbo.build/pack/docs/core-concepts)。我们正在扩展缓存框架，以优化缓存淘汰策略，并避免缓存那些极不可能被复用的中间计算结果。

- **完成持久化的磁盘缓存功能。** Turbopack 的缓存框架已支持序列化与反序列化，我们也已为计算图（computation graph）初步实现了若干种磁盘存储格式的原型；但这项工作尚未收尾，还需将其默认启用。令人惊讶的是，即便尚无磁盘缓存，Turbopack 在绝大多数场景下的冷启动速度仍快于已预热缓存的 webpack。

- **完善生产环境构建（production builds）支持。** 我们正致力于将 Next.js 针对生产构建的测试套件在 Turbopack 上的通过率提升至 [100%](https://areweturboyet.com/build)。实现生产构建支持需引入面向优化型生产构建的关键特性，例如 [Tree Shaking（摇树优化）](https://github.com/vercel/turbo/pull/8523)。[Tobias Koppers](https://github.com/sokra) 最近在 JSNation 2024 大会上[就“增量式生产优化所面临的挑战”发表了主题演讲](https://portal.gitnation.org/contents/challenges-for-incremental-production-optimizations)。

We look forward to continuing our work on Turbopack to help improve the development velocity of your web applications.

我们期待持续推进 Turbopack 的开发工作，助力提升您 Web 应用的开发效率。
{% endraw %}
