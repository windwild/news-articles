---
title: "Why Turborepo is migrating from Go to Rust - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/turborepo-migration-go-rust"
date: "2023-03-07"
scraped_at: "2026-03-02T09:54:09.822475853+00:00"
language: "en-zh"
translated: true
description: "How we're migrating from Go to Rust for better alignment with our tools and work"
---

render_with_liquid: false
Mar 7, 2023

2023 年 3 月 7 日

How we're aligning our tools to our work.

我们如何让工具与工作方式保持一致。

[Turborepo](https://turbo.build/repo?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) is a high-performance build system for JavaScript and TypeScript codebases. We're reimagining build systems, taking inspiration from tools like Buck and Bazel, to make them accessible for everyone. At the heart of Turborepo is a very simple idea: **never do the same work twice**. We accomplish this through incremental builds, parallel execution, and [Remote Caching](https://vercel.com/docs/concepts/monorepos/remote-caching).

[Turborepo](https://turbo.build/repo?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) 是一个面向 JavaScript 和 TypeScript 代码库的高性能构建系统。我们正重新构想构建系统，借鉴 Buck 和 Bazel 等工具的设计理念，使其对每位开发者都触手可及。Turborepo 的核心思想极为简洁：**绝不重复执行相同的工作**。我们通过增量构建、并行执行以及[远程缓存（Remote Caching）](https://vercel.com/docs/concepts/monorepos/remote-caching)来实现这一目标。

![Turborepo's caching makes your longest builds near-instant.](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_001.jpg)![Turborepo's caching makes your longest builds near-instant.](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_002.jpg)Turborepo's caching makes your longest builds near-instant.

![Turborepo 的缓存可使你最耗时的构建近乎瞬时完成。](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_001.jpg)![Turborepo 的缓存可使你最耗时的构建近乎瞬时完成。](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_002.jpg)Turborepo 的缓存可使你最耗时的构建近乎瞬时完成。

As usage has grown and product needs have shifted, we've decided to start an incremental migration from Go to Rust in [the 1.7 version](https://turbo.build/blog/turbo-1-7-0?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust). In this article, you'll learn about our motivations for this migration and problems that we are finding Rust solves for our team.

随着用户规模扩大及产品需求演进，我们决定自 [1.7 版本](https://turbo.build/blog/turbo-1-7-0?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) 起，逐步将 Turborepo 从 Go 迁移至 Rust。本文将介绍我们此次迁移的动因，以及 Rust 如何帮助我们团队解决实际问题。

## **Why are we migrating?**

## **为何要进行迁移？**

The original decision for Turborepo to use Go followed in the footsteps of [`esbuild`](https://esbuild.github.io/). As a JavaScript bundler written in Go, `esbuild` is fast and avoids much of the initialization overhead of Node.js. Additionally, Go's developer experience is tailored for iteration, something we needed as we learned more and more about what developers wanted from `turbo`.

Turborepo 最初选择 Go，是追随 [`esbuild`](https://esbuild.github.io/) 的脚步。作为一款用 Go 编写的 JavaScript 打包器，`esbuild` 性能优异，且避免了 Node.js 大量的初始化开销。此外，Go 的开发者体验专为快速迭代而设计——这正是我们在不断了解开发者对 `turbo` 的真实需求过程中所迫切需要的。

In the early days of Turborepo, these properties of Go gave us exactly what we needed for the project to be successful. However, as [the Turborepo codebase](https://github.com/vercel/turbo?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) has scaled and merged with [Turbopack](https://vercel.com/blog/turbopack), Go has begun to underserve both our core team and users in the areas that matter most to Turbo.

在 Turborepo 发展初期，Go 的这些特性恰好满足了项目成功所需的一切条件。然而，随着 [Turborepo 代码库](https://github.com/vercel/turbo?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) 规模持续扩大，并与 [Turbopack](https://vercel.com/blog/turbopack) 深度整合，Go 在 Turbo 最关键的几个领域中，已逐渐难以充分满足核心团队和用户的需求。

## Comparing Go and Rust

## Go 与 Rust 的对比

We've been working on several other migrations lately and have enjoyed the opportunity to refine our approach:  

近期，我们还推进了多项其他迁移工作，并乐于借此机会持续优化我们的技术选型与工程实践方法：

- Doing [a mock migration for the BBC's open-source frontend](https://vercel.com/blog/migrating-a-large-open-source-react-application-to-next-js-and-vercel) from React to Next.js  
- 对 BBC 开源前端项目进行[一次模拟迁移](https://vercel.com/blog/migrating-a-large-open-source-react-application-to-next-js-and-vercel)，从 React 迁移到 Next.js

- Dogfooding [the Next.js 13 App Router](https://vercel.com/blog/nextjs-app-router-data-fetching) for vercel.com  
- 在 vercel.com 上“以自身产品为试验田”，实际采用并验证 [Next.js 13 的 App Router](https://vercel.com/blog/nextjs-app-router-data-fetching)

In any major technical migration, there's _a lot_ to consider and the decision shouldn't be taken lightly. In particular, a language migration is quite demanding, asking you to weigh dimensions like the strengths, weaknesses, and community of a given language according to your specific business and technical context.  
在任何重大的技术迁移中，都有**大量因素**需要权衡，相关决策绝不可轻率作出。尤其是编程语言的迁移，要求极高——你必须结合自身具体的业务需求与技术场景，全面评估目标语言的优势、劣势及其社区生态。

In our case, we needed to compare Go and Rust to figure out which language was going to serve us best.  
就我们而言，需在 Go 和 Rust 之间进行比对，从而确定哪一种语言更能满足我们的核心需求。

![](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_003.jpg)![](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_004.jpg)  
![](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_003.jpg)![](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_004.jpg)

### Go's language design priorities  
### Go 的语言设计优先级

Go's strength is network computing in data centers and it **excels** at this task, powering these workloads at the world's largest scales. The goroutine-per-request model, Context API, and the standard library inclusion of server infrastructure is testament to this community focus.  
Go 的优势在于数据中心内的网络计算，它在此类任务上**表现卓越**，支撑着全球规模最大的在线服务。每个请求对应一个 goroutine 的模型、Context API，以及标准库中对服务器基础设施的原生支持，都印证了该语言社区对这一方向的专注。

Additionally, Go favors simplicity over expressiveness. A side effect of that decision means more errors are caught at runtime where other languages might catch them at compilation. With a service running in a data center, you can roll back, fix, and roll forward at your convenience. But, when building software that users install, the cost of each mistake is higher.  
此外，Go 倾向于**简洁性而非表达力**。这一设计取舍的副作用是：相比其他能在编译期捕获的错误，Go 中更多错误会推迟到运行时才暴露。对于运行在数据中心的服务而言，你可随时回滚、修复并重新上线；但当我们构建的是用户需自行安装的本地软件时，每一次失误的代价都更高。

For us, it's worth using tools that prioritize up-front correctness. We fully recognize the mismatch of **Go's priorities** and **what we are prioritizing** as a problem that we created for ourselves to solve.  
对我们而言，采用那些**将“前置正确性”置于首位**的工具是值得的。我们充分意识到：**Go 的设计优先级**与**我们自身所强调的核心诉求**之间存在错位——这正是我们为自己设定、亟待解决的关键问题。

### Our needs align with Rust  
### 我们的需求与 Rust 高度契合

The Rust language and community has prioritized correctness over API abstraction—a tradeoff that we care a lot about when working with:

- Process management

- Filesystems

- Other low level OS concepts

- Shipping software to our users' machines

Rust 语言及其社区将“正确性”置于 API 抽象之上——这一权衡，正是我们在处理以下场景时尤为重视的：

- 进程管理  
- 文件系统  
- 其他底层操作系统概念  
- 将软件分发至用户机器  

This means additional complexity is surfaced into our codebase, but it's _necessary_ complexity for the problems we're trying to solve.

这意味着额外的复杂性会直接反映在我们的代码库中，但这种复杂性对于我们所要解决的问题而言是 _必需的_。

Rust's type system and safety features allow us to put guardrails in place in our codebase where we need them. The language's expressiveness allows our developers to encode constraints that catch errors at compile time rather than in GitHub issues.

Rust 的类型系统与安全性特性，使我们能够在代码库中需要的位置设置防护机制（guardrails）。该语言强大的表现力，使开发者能够将约束条件直接编码进程序中，从而在编译期捕获错误，而非等到错误以 GitHub Issue 的形式暴露出来。

### Comparing by example: file permissions

### 以文件权限为例进行对比

Go's preference for simplicity at the filesystem was creating problems for us when it came to file permissions. Go lets users set a Unix-style file permission code: a short number that describes who can read, write, or execute a file.

Go 在文件系统层面追求简洁的设计取向，反而在文件权限方面给我们带来了问题。Go 允许用户设置类 Unix 风格的文件权限码：一个简短的数字，用于描述谁可以读取、写入或执行该文件。

```text
1> ls -l turbo.json

2-rw-r--r--  1 anthonyshew  users  247 Jan 1 00:01 turbo.json  
2-rw-r--r--  1 anthonyshew  users  247 1月 1日 00:01 turbo.json  

```

While this sounds convenient, this abstraction does not work across platforms; Windows actually doesn't have the precise concept of file permissions. Go ends up allowing us to set a file permission code on Windows, even when doing so will have no effect.

虽然这听起来很方便，但这种抽象在跨平台场景下并不适用；Windows 实际上并没有与 Unix 系统完全对应的文件权限概念。Go 允许我们在 Windows 上设置文件权限码，即使这样做根本不会产生任何效果。

In contrast, Rust's explicitness in this area not only made things simpler for us but also more correct. If you want to set a file permission code in Rust, you have to explicitly annotate the code as Unix-only. If you don't, the code won't even compile on Windows. This surfacing of complexity helps us understand what our code is doing before we ever ship our software to users.

相比之下，Rust 在这一领域的显式设计不仅让我们的工作更简单，也使代码行为更准确。如果你想在 Rust 中设置文件权限码，就必须显式地将相关代码标注为仅限 Unix 平台。否则，这段代码在 Windows 上甚至无法编译通过。这种将复杂性“暴露”出来的机制，帮助我们在软件交付用户之前就真正理解代码的实际行为。

## -ecosystem) Rust's strong (and growing) ecosystem

## -生态体系）Rust 强大（且持续壮大）的生态系统

Rust has a fantastic ecosystem of high-quality, open-source crates (Rust's equivalent to an npm package) that have clear focus on what we care about. An example of where we benefit from this alignment is when we have to interface with native libraries written in C or C++.

Rust 拥有一个极为出色的开源 crate 生态系统（crate 是 Rust 对应于 npm package 的概念），这些 crate 高质量、目标明确，恰好契合我们的核心需求。一个典型受益于这种高度契合的场景，是我们需要与用 C 或 C++ 编写的原生库进行交互时。

As we've built out Turborepo, we've started to rely more often on native C packages like [`zstd`](https://github.com/facebook/zstd), a library that helps us compress our cache files. Interoperating with these native libraries in Go requires the use of CGO, which switches us from a pure Go toolchain to a much slower C toolchain. Moreover, this switch is a **global** process, meaning that if we use a single native library, we have to build our entire codebase with CGO.

随着 Turborepo 的持续开发，我们越来越多地依赖诸如 [`zstd`](https://github.com/facebook/zstd) 这样的原生 C 库——它帮助我们压缩缓存文件。而在 Go 中与这类原生库交互，必须启用 CGO，这会迫使我们从纯 Go 工具链切换到明显更慢的 C 工具链。更关键的是，这种切换是**全局性**的：只要项目中使用了任意一个原生库，整个代码库就必须通过 CGO 构建。

[**Check out Turbo on GitHub**\\  
\\  
Enter the Turboverse.\\  
\\  
Star the Repo](https://github.com/vercel/turbo?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust)

[**前往 GitHub 查看 Turbo**\\  
\\  
欢迎进入 Turboverse！\\  
\\  
为仓库点亮 Star ⭐](https://github.com/vercel/turbo?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust)

In Rust, this interfacing with native C libraries is far more contained. Libraries such as [`bindgen`](https://github.com/rust-lang/rust-bindgen) or [`cxx`](https://github.com/dtolnay/cxx) create safe wrappers and don't require global changes to our builds. Even better, many libraries come with this wrapper already generated.

而在 Rust 中，与原生 C 库的交互则要收敛得多。像 [`bindgen`](https://github.com/rust-lang/rust-bindgen) 或 [`cxx`](https://github.com/dtolnay/cxx) 这样的库能自动生成安全的封装层，且无需对构建流程做任何全局性修改。更棒的是，许多常用库已自带了预先生成好的封装。

For example, we ported our `git` interface using the [`git2`](https://github.com/rust-lang/git2-rs) crate. `git2` interfaces with the C library [`libgit2`](https://libgit2.org/) underneath the hood, but exposes a safe, idiomatic Rust API. This allows us to get the benefits of both the Rust and C ecosystems while still maintaining a great internal developer experience.

例如，我们使用 [`git2`](https://github.com/rust-lang/git2-rs) crate 重构了 `git` 接口。`git2` 在底层调用 C 库 [`libgit2`](https://libgit2.org/)，却向我们暴露了一个安全、符合 Rust 风格的 API。这让我们得以同时享受 Rust 和 C 两大生态的优势，同时保持卓越的内部开发者体验。

### The Turbo ecosystem

### Turbo 生态体系

Internally, we share a codebase and work closely with the [Turbopack](https://vercel.com/blog/turbopack) team.

在内部，我们共享同一套代码库，并与 [Turbopack](https://vercel.com/blog/turbopack) 团队紧密协作。

For their work, Rust was a clear choice from day one. This meant that, as we both continued our work on build tooling for JavaScript and TypeScript codebases, we were solving the same problems twice: once in Go and once in Rust.

对他们的工作而言，Rust 从第一天起就是明确的选择。这意味着，当双方持续为 JavaScript 和 TypeScript 项目开发构建工具时，我们实际上在重复解决同一组问题：一次用 Go，一次用 Rust。

[**Connect with the community**\\
\\
Stay up to date with the latest in build tooling.\\
\\
Join Discord](https://discord.gg/w2N4Da9nZy?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust)

[**加入社区交流**\\
\\
及时了解构建工具领域的最新动态。\\
\\
加入 Discord](https://discord.gg/w2N4Da9nZy?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust)

Getting aligned means both teams can ship faster by sharing development and maintenance of common utilities in our problem space. For instance, we're taking a lot of inspiration from the Turbopack team when it comes to file-watching so we can build a feature for smart hot-reloading across workspaces sooner.

达成技术对齐意味着两个团队可通过共享问题域内通用工具的开发与维护，更快地交付成果。例如，在文件监听（file-watching）方面，我们大量借鉴了 Turbopack 团队的设计思路，从而能更早实现跨工作区的智能热重载（smart hot-reloading）功能。

## Rust makes the core team happier

## Rust 让核心团队更快乐

Another great perk: our team **wants** to write Rust. It's a language that solves what we care about and brings us joy. The fact that we enjoy writing Rust is valuable, by itself, in more ways than one.

另一项显著优势是：我们的团队**主动希望**使用 Rust 编程。这门语言精准解决了我们所关注的问题，也为我们带来愉悦感。单就“享受编写 Rust”这一事实本身，其价值已远不止一种。

- Happier developers deliver better software. Your brain is [better at complex problem-solving](https://www.psychologicalscience.org/news/releases/a-positive-mood-allows-your-brain-to-think-more-creatively.html) when it's happy.

- 更快乐的开发者能产出更优质的软件。当人处于积极情绪时，大脑[解决复杂问题的能力更强](https://www.psychologicalscience.org/news/releases/a-positive-mood-allows-your-brain-to-think-more-creatively.html)。

- If we're happier while we work, we're much less likely to burn out.

- 如果我们在工作中更快乐，那么职业倦怠（burnout）的风险就会大幅降低。

- Rust's efficiency means [less energy consumption](https://aws.amazon.com/blogs/opensource/sustainability-with-rust/), letting us do our part in global sustainability.

- Rust 的高效性意味着[更低的能源消耗](https://aws.amazon.com/blogs/opensource/sustainability-with-rust/)，使我们能在全球可持续发展中贡献自己的一份力量。

## Rust makes other developers happier

## Rust 让其他开发者更快乐

Looking at the past seven years of [StackOverflow survey results](https://insights.stackoverflow.com/survey), we're not alone.

回顾过去七年来的 [Stack Overflow 调查结果](https://insights.stackoverflow.com/survey)，我们并不孤单。

![Rust's user satisfaction from 2016 to 2022 per StackOverflow Survey.](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_005.jpg)![Rust's user satisfaction from 2016 to 2022 per StackOverflow Survey.](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_006.jpg)![Rust's user satisfaction from 2016 to 2022 per StackOverflow Survey.](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_005.jpg)![Rust's user satisfaction from 2016 to 2022 per StackOverflow Survey.](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_008.jpg)Rust's user satisfaction from 2016 to 2022 per StackOverflow Survey.

![2016 至 2022 年 Stack Overflow 调查中 Rust 用户满意度趋势图。](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_005.jpg)![2016 至 2022 年 Stack Overflow 调查中 Rust 用户满意度趋势图。](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_006.jpg)![2016 至 2022 年 Stack Overflow 调查中 Rust 用户满意度趋势图。](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_005.jpg)![2016 至 2022 年 Stack Overflow 调查中 Rust 用户满意度趋势图。](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_008.jpg)2016 至 2022 年 Stack Overflow 调查中 Rust 用户满意度趋势图。

We also made this choice with _future_ developers of Turborepo in mind.

我们做出这一选择时，也充分考虑了 Turborepo 未来的开发者群体。

Web developers are **strongly** looking towards Rust as a second language to learn after JavaScript, making it more accessible for those coming from JS-tooling-in-JS land. This enables web-focused developers to be able to get involved, enabling the Turbo community to grow.

前端开发者正**强烈地**将 Rust 视为继 JavaScript 之后最值得学习的第二语言，这使得那些长期深耕于“用 JavaScript 构建 JavaScript 工具链”生态的开发者也能更轻松上手。此举有助于吸引更多以 Web 开发为核心的工程师参与进来，从而推动 Turbo 社区持续壮大。

## Continuing the migration

## 迁移工作持续推进

We're migrating incrementally, so it's not a complete rewrite overnight.

我们正采用渐进式迁移策略，而非一夜间彻底重写整个代码库。

Right now, we have what we call a "Rust-Go-Rust Sandwich." Rust is the entry point, allowing us to choose whether the implementation for a particular command is in Rust or Go. Our Go code is able to call Rust code, too, giving us paths to keep Go around but always be able to get to Rust. Check out [the turborepo-ffi crate](https://github.com/vercel/turbo/tree/d5665f6eeb85bfb131d9913a46194e3743d5b93d/crates/turborepo-ffi?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) and [ffi.g](https://github.com/vercel/turbo/blob/d5665f6eeb85bfb131d9913a46194e3743d5b93d/cli/internal/ffi/ffi.go?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) [o](https://github.com/vercel/turbo/blob/d5665f6eeb85bfb131d9913a46194e3743d5b93d/cli/internal/ffi/ffi.go?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) to learn more.

目前，我们的架构被形象地称为“Rust–Go–Rust 三明治”：Rust 作为统一入口点，使我们能灵活决定每个命令的具体实现是采用 Rust 还是 Go；同时，Go 代码也可调用 Rust 编写的模块，从而在保留现有 Go 代码的同时，确保随时可无缝接入 Rust。欲了解详情，请参阅 [turborepo-ffi crate](https://github.com/vercel/turbo/tree/d5665f6eeb85bfb131d9913a46194e3743d5b93d/crates/turborepo-ffi?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust) 和 [ffi.go](https://github.com/vercel/turbo/blob/d5665f6eeb85bfb131d9913a46194e3743d5b93d/cli/internal/ffi/ffi.go?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust)。

We're excited about what Rust has already unlocked for our team and can't wait to finish the oxidation and [carcinization](https://www.google.com/search?q=define+carcinization&oq=define+carcinization&aqs=chrome..69i57.4146j1j7&sourceid=chrome&ie=UTF-8) of our codebase.

Rust 已为我们的团队释放出巨大潜力，我们热切期待完成整个代码库的“氧化”（oxidation）与“甲壳化”（[carcinization](https://www.google.com/search?q=define+carcinization&oq=define+carcinization&aqs=chrome..69i57.4146j1j7&sourceid=chrome&ie=UTF-8)）进程。

If you're a high-performance engineering team building developer tooling or doing systems work and you're debating Rust or Go, we hope our experience can be a helpful reference for you.

如果你是一支专注于高性能工程的团队，正在构建开发者工具或从事系统级开发，并在 Rust 与 Go 之间犹豫不决，我们希望自身的实践经历能为你提供有价值的参考。

## Try out Turborepo today

## 立即试用 Turborepo

Turborepo 1.8 was recently released with more features written in Rust. Learn more about what's new to the Turboverse on [the 1.8 release post](https://turbo.build/blog/turbo-1-8-0?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust).

Turborepo 1.8 版本近期已发布，其中新增的多项功能采用 Rust 编写。欲了解 Turboverse 的最新变化，请参阅 [1.8 版本发布文章](https://turbo.build/blog/turbo-1-8-0?utm_source=vercel_site&utm_medium=blog&utm_campaign=turbo_migration_go_rust)。

If you're looking to create a distributed caching system for your team and CI in three minutes, you can [check out our post here](https://vercel.com/blog/vercel-remote-cache-turbo).

若您希望在三分钟内为您的团队及持续集成（CI）环境搭建一套分布式缓存系统，欢迎 [阅读我们的相关文章](https://vercel.com/blog/vercel-remote-cache-turbo)。

[**Want to get started with your team?**\\
\\
Build 85% faster.\\
\\
Let's Talk](https://vercel.com/contact/sales)

[**想立即为您的团队启用 Turborepo？**\\
\\
构建速度提升 85%。\\
\\
立即咨询](https://vercel.com/contact/sales)

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### This is an official starter Turborepo with two Next.js sites and three local packages

### 这是一个官方入门级 Turborepo 项目，包含两个 Next.js 网站和三个本地包

Turborepo & Next.js Starter

Turborepo 与 Next.js 入门模板

Blog post

博客文章

Jan 24, 2023

2023 年 1 月 24 日

### How Supabase elevated their developer experience with Turborepo

### Supabase 如何借助 Turborepo 显著提升开发者体验

![](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_009.png)![](images/why-turborepo-is-migrating-from-go-to-rust-vercel/img_010.jpg)

Alli 和 Anthony