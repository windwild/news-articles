---
title: "How Remote Caching decreased publish times by 80% - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/turborepo-remote-cache-nextjs-publish-times-80-percent"
date: "2022-12-22"
scraped_at: "2026-03-02T09:57:18.495624823+00:00"
language: "en-zh"
translated: true
description: "The Next.js release process got 80% faster using Turborepo Remote Caching."
---

render_with_liquid: false
Dec 22, 2022

2022 年 12 月 22 日

Next.js 让开发者能更快地迭代自己的项目——但我们同样希望更快地迭代 **Next.js 自身**。

今年，Next.js 首次单月 npm 下载量突破 400 万次。在超过 2400 名贡献者的支持下，Vercel 团队的核心工程师必须精心打造一套开发者体验，以满足如此庞大社区在开发、测试、构建和发布 Next.js 过程中的需求。

Next.js 今年还实现了另一项“首次”：在其核心中引入 Rust。虽然 Rust 的加入显著提升了使用 Next.js 的开发者的运行性能，但代价是持续集成（CI）构建与发布新版本所需的时间大幅增加——原因在于编译跨平台 Rust 二进制文件的过程十分耗时。

**直到我们启用** [**Turborepo 远程缓存（Turborepo Remote Caching）**](https://vercel.com/docs/concepts/monorepos/remote-caching) **，发布耗时降低了 80%。**

![Next.js 在 Vercel 上借助 Turborepo 远程缓存将发布耗时降低 80%。](images/how-remote-caching-decreased-publish-times-by-80-vercel/img_001.jpg)  
![Next.js 在 Vercel 上借助 Turborepo 远程缓存将发布耗时降低 80%。](images/how-remote-caching-decreased-publish-times-by-80-vercel/img_002.jpg)  
Next.js 在 Vercel 上借助 Turborepo 远程缓存将发布耗时降低 80%。

## 仅在 CI 中缓存 SWC 二进制文件并不足够

Turborepo 远程缓存并非我们为缩短发布耗时所尝试的第一个方案。在 Turborepo 出现之前，我们已预先部署了一些既有策略，并首先尝试复用它们。

SWC 是一个基于 Rust、可扩展的 Web 平台，因其需为多个平台构建耗时较长的 Rust 二进制文件，成为拖慢 Next.js 核心构建速度的主要因素。

SWC 的 Rust 库作为内置组件直接集成于 Next.js 包中，并通过 [针对 React 项目的额外代码转换功能](https://swc.rs/docs/configuration/compilation#jsctransform) 对其进行了增强。这使得 Next.js 开发者可以专注于应用逻辑本身，而无需为常见的代码转换任务额外配置自定义插件或工具。

We were building these binaries for Windows, Mac, and Linux and committing them to the Next.js repository to make testing easier without needing to publish canaries. This worked well enough but the sizes of the binaries were bloating the overall size of the repository, hurting git cloning times.

我们曾为 Windows、macOS 和 Linux 构建这些二进制文件，并将它们提交至 Next.js 仓库，以便在无需发布预发布版本（canaries）的情况下更便捷地进行测试。这一做法虽基本可行，但二进制文件的体积不断膨胀，显著增加了整个仓库的大小，拖慢了 `git clone` 的速度。

To work around this, we stopped committing the SWC binaries to the repo in favor of testing Next.js with **development** binaries of SWC (which can be built much quicker). Our development builds got somewhat faster but we still weren’t satisfied.

为应对这一问题，我们停止将 SWC 二进制文件提交至仓库，转而使用 SWC 的**开发版**二进制文件来测试 Next.js（其构建速度快得多）。我们的开发构建速度因此略有提升，但仍未能令我们满意。

At this point, we began caching these development builds in our CI, hoping for improved build times. This also gave us only moderately positive results as we noticed high cache miss rates due to CI cache limits causing purging. We also, at worst, saw failing publishes for canary and stable releases due to the slight differences in platform handling for the binaries.

此时，我们开始在 CI 中缓存这些开发构建产物，以期进一步缩短构建时间。然而收效仅属中等：由于 CI 缓存容量限制导致缓存被强制清理，我们观察到缓存命中率偏低；更严重的是，在某些情况下，因各平台对二进制文件处理存在细微差异，甚至导致预发布（canary）及正式版（stable）的发布流程失败。

## Leveraging Vercel Remote Caching

## 借力 Vercel 远程缓存

With all of our smaller, incremental wins, we still found ourselves wanting to explore better solutions. We quickly realized Turborepo would bring us what we needed, solving three key problems.

尽管已取得若干小幅、渐进式的优化成果，我们仍渴望探索更优的解决方案。我们很快意识到，Turborepo 正是我们所需要的工具——它能一举解决三大关键问题。

![](images/how-remote-caching-decreased-publish-times-by-80-vercel/img_003.jpg)![](images/how-remote-caching-decreased-publish-times-by-80-vercel/img_004.jpg)

### 1\. Task management for per-platform binaries

### 1. 面向各平台二进制文件的任务管理

Turborepo can cache virtually any task since caches are isolated using the inputs for the task. Those inputs can include source code, dependencies, environment variables, and [other arguments](https://turbo.build/repo/docs/core-concepts/caching#hashing).

Turborepo 几乎可缓存任意任务，因为其缓存机制基于任务输入实现完全隔离。这些输入包括源代码、依赖项、环境变量，以及[其他参数](https://turbo.build/repo/docs/core-concepts/caching#hashing)。

In our case, we were compiling Rust code with a `--target` flag to create binaries for the various platforms that Next.js supports. With Turborepo, this flag ensures that we don’t pick up the wrong caches for our `cargo build` when it comes time to publish canaries.

在我们的场景中，我们通过 Rust 的 `--target` 标志编译代码，为 Next.js 所支持的各个平台生成对应二进制文件。借助 Turborepo，该标志确保我们在发布预发布版本（canaries）执行 `cargo build` 时，不会误用错误平台的缓存。

### 2\. No more cache purges

### 2. 彻底告别缓存清理

The hashes that Turborepo creates and stores are tiny compared to the actual builds produced, letting us avoid purging the cache altogether.  
Turborepo 生成并存储的哈希值相较于实际构建产物而言极其微小，使我们能够完全避免清空缓存。

If we have performed one of our SWC builds before, we know that we can restore it from cache for the next time no matter how many other variations of our builds we’ve performed since then.  
只要我们此前已执行过某次 SWC 构建，那么无论此后又执行了多少种其他变体的构建，我们都知道下次仍可直接从缓存中恢复该构建。

### 3\. Eagerly pre-seeding the Remote Cache

### 3. 主动预填充远程缓存

There’s still one more problem left to solve: When our SWC code _does_ change, we will have a cache miss when we go to publish a canary, resulting in that slow publish again. To avoid this, we set up a GitHub Action to eagerly build the SWC binaries whenever we create a change with its code. We even found that these eager builds have some other great side-effects:  
还有一个问题有待解决：当我们的 SWC 代码 _确实_ 发生变更时，在发布预发布版本（canary）时将发生缓存未命中，从而再次导致发布速度变慢。为避免这一情况，我们配置了一个 GitHub Action，在每次修改 SWC 代码时即主动构建其二进制文件。我们甚至发现，这些主动构建还带来了其他诸多额外好处：

- They’re non-blocking, allowing us to continue to iterate without having to wait on them while we work towards the next canary.  
  - 它们是非阻塞式的，使我们能在推进下一个预发布版本的过程中持续迭代，而无需等待这些构建完成。

- When a cache does miss and we see a build failure, we can fix it much earlier than when we are trying to publish a canary.  
  - 当缓存未命中并出现构建失败时，我们可以比在尝试发布预发布版本时更早地发现并修复问题。

## Next.js can now iterate faster than ever before

## Next.js 现在的迭代速度比以往任何时候都更快

After creating a few custom scripts for our specific use case (building for FreeBSD, no cache invalidation when only package versions change), we were able to achieve **an 80% drop in publish times with a Turborepo Remote Cache hit**. This quality of life change not only feels great for those of us on the core team but also results in faster iterations for Next.js users so we can add more features and fix more bugs sooner.  
在为我们的特定使用场景（例如：针对 FreeBSD 构建、仅包版本号变更时不使缓存失效）编写了若干自定义脚本后，我们成功实现了 **在命中 Turborepo 远程缓存时发布耗时降低 80%**。这一显著提升不仅极大改善了核心团队成员的开发体验，也让 Next.js 用户受益于更快的迭代节奏——从而让我们能更早地添加新功能、修复更多缺陷。

Hit a Remote Cache using [the Turborepo and Next.js starter template](https://vercel.com/templates/next.js/turborepo-next-basic) or [visit the Vercel Remote Cache docs](https://vercel.com/docs/concepts/monorepos/remote-caching) to learn more.  
通过使用 [Turborepo 与 Next.js 入门模板](https://vercel.com/templates/next.js/turborepo-next-basic)，或访问 [Vercel 远程缓存文档](https://vercel.com/docs/concepts/monorepos/remote-caching)，进一步了解如何启用远程缓存。