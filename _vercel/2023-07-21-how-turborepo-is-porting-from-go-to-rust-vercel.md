---
title: "How Turborepo is porting from Go to Rust - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust"
date: "2023-07-21"
scraped_at: "2026-03-02T09:51:41.070075484+00:00"
language: "en-zh"
translated: true
description: "Our strategy for making updates and maintaining stability while we migrate languages."
---

render_with_liquid: false
Jul 21, 2023

2023 年 7 月 21 日

Our strategy for making updates and maintaining stability while we migrate languages.

我们在迁移编程语言过程中，兼顾功能更新与系统稳定性的策略。

In [a previous blog post](https://vercel.com/blog/turborepo-migration-go-rust), we talked about **why** we are porting [Turborepo, the high-performance build system for JavaScript and TypeScript](https://turbo.build/?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting), from Go to Rust. Now, let's talk about **how**.

在[此前的一篇博客文章](https://vercel.com/blog/turborepo-migration-go-rust)中，我们探讨了**为何**要将[Turborepo（面向 JavaScript 和 TypeScript 的高性能构建系统）](https://turbo.build/?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting)从 Go 迁移至 Rust。现在，让我们来谈谈**如何**实现这一目标。

Today, our porting effort is in full swing, moving more and more code to Rust. But when we were starting out, we had to make sure that porting was feasible for us to accomplish. A migration from one language to another is no small task and there's a lot of research to do up front to ensure that the end goal is attainable.

目前，我们的移植工作正全面展开，越来越多的代码正被迁移到 Rust。但在项目启动之初，我们必须首先确认：这一移植工作对我们而言是否切实可行。从一门语言整体迁移到另一门语言绝非易事，前期需开展大量调研，以确保最终目标可达成。

Here’s how we started the process, validated our current porting strategy, and made the call to port Turborepo to Rust.

以下是我们启动该过程、验证当前移植策略，并最终决定将 Turborepo 迁移至 Rust 的具体做法。

## Port vs. full rewrite

## 移植（Port） vs. 全面重写（Full Rewrite）

When we were planning our migration, we briefly considered a full, ground-up rewrite. But, talking the idea through, we realized it wouldn't fit our goals as well as an incremental port would.

在规划迁移方案时，我们曾短暂考虑过从零开始全面重写。但经过深入讨论后，我们意识到：相比全面重写，渐进式移植更能契合我们的目标。

### What is an incremental port?

### 什么是渐进式移植（Incremental Port）？

Incremental porting moves code piece-by-piece, running new and old code together at the same time. The goal for the chunk of code being moved is to keep the behavior exactly the same as before it was ported.

渐进式移植指将代码逐块迁移，新旧代码并行运行。对每一部分被迁移的代码，其核心目标是确保迁移前后行为完全一致。

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_001.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_002.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_003.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_004.jpg)

In our case, this means we need to have our Go code and Rust code interoperating with each other. We want to do a simple translation, explicitly avoiding making improvements or changing functionality when we're swapping out languages for the slice of code. That way, we can do intensive testing against both sets of code, and complete the migration as quickly as possible.

在我们的场景中，这意味着我们需要让 Go 代码与 Rust 代码相互协作。我们希望进行一次简单的翻译式迁移（translation-style port），明确避免在替换某段代码的语言时引入功能改进或行为变更。这样，我们便能对新旧两套代码进行高强度的对比测试，并尽可能快速地完成迁移。

### Why we didn't do a full rewrite

### 为何我们没有选择彻底重写

Full rewrites are very tempting. They are more simple to write and ship, as you don't need to worry about your "before" and "after" code working together. You also get a clean slate to write a new and improved version, without the warts and technical debt of the previous iteration. However, full rewrites also come with some serious downsides.

彻底重写极具诱惑力：它编写和发布起来更简单，因为你无需操心“旧版”与“新版”代码之间的协同问题；你还能获得一张白纸，从头构建一个更优的新版本，彻底摆脱前一版遗留的缺陷与技术债务。然而，彻底重写也伴随着一些严重弊端。

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_005.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_006.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_007.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_008.jpg)

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_005.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_006.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_007.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_008.jpg)

First, a full rewrite tends to require a complete halt to shipping new features. Otherwise, you run the risk of chasing a moving target as the old codebase grows while you try to catch up with your new code.

首先，彻底重写往往意味着必须完全暂停新功能的交付。否则，你将面临“追赶移动靶”的风险——当你的新代码仍在开发中时，旧代码库却持续演进，导致目标不断漂移。

A full rewrite also does not guarantee a better user experience. Often, a rewrite ends up less than seamless, as it's not feasible for the new version to match the old one, feature for feature, edge case for edge case. As the surface area of the rewrite grows, there's more room for error and users can end up frustrated with breaking changes and missing features.

其次，彻底重写并不能保证带来更佳的用户体验。现实中，重写后的版本常常难以做到无缝过渡——要让新版本在每个功能点、每种边界条件下都与旧版完全一致，几乎是不可能的。随着重写范围扩大，出错概率也随之上升，用户则可能因破坏性变更和缺失功能而感到沮丧。

Full rewrites also require building up an entirely new codebase, which is a large quantity of unused code. In our experience, unused code, even when verified with tests, can be a breeding ground for bugs. We wanted to make sure that any new Rust code was properly exercised as we moved through our porting effort.

此外，彻底重写还需从零构建一整套全新代码库，其中包含大量尚未投入实际使用的代码。根据我们的经验，即使经过充分测试，未被实际调用的代码仍极易成为 Bug 的温床。因此，我们希望确保在迁移过程中，所有新增的 Rust 代码都能得到真实、充分的运行验证。

## We chose to port

## 我们选择“移植”而非重写

Therefore, we decided to **port** Turborepo to Rust instead of doing a full rewrite.

因此，我们决定将 Turborepo **移植**（port）到 Rust，而非进行一次彻底重写。

Porting did necessitate some tradeoffs. We had to introduce a significant amount of complexity into our codebase, so that we could interoperate between Go and Rust. This complexity meant slower developer velocity to start, but we look forward to workflow improvements going forward, particularly when our porting effort has finished.

移植确实带来了一些权衡取舍：我们必须在代码库中引入相当程度的复杂性，以支撑 Go 与 Rust 之间的互操作。这种复杂性在初期拖慢了开发者的交付速度；但我们期待，在移植工作全部完成后，整体研发流程将迎来显著优化与提升。

More importantly, we knew we could continue shipping features to Turborepo users while porting. All things considered, we determined that this was a reasonable compromise and the path that we would take.

更重要的是，我们深知在迁移过程中仍可持续向 Turborepo 用户交付新功能。综合权衡之后，我们认为这是一个合理的折中方案，也是我们最终选择的路径。

### Starting the port

### 启动迁移工作

We chose to start by writing a small, new Turborepo feature in Rust. This way, we could add new functionality from the roadmap for users, integrate Rust into our build process, and interact with existing Go code as little as possible to reduce our initial complexity.

我们决定从用 Rust 编写一个小型、全新的 Turborepo 功能入手。这样，我们既能为用户交付路线图中的新功能，又能将 Rust 集成到构建流程中，同时尽可能减少与现有 Go 代码的交互，从而降低初期复杂度。

Once we'd laid this groundwork, we knew that we could slowly port more and more code to Rust over time.

一旦完成这一基础性工作，我们便确信可以随时间推移逐步将越来越多的代码迁移到 Rust。

## Global `turbo`

## 全局 `turbo`

We decided to have our first Rust feature be [global `turbo`](https://turbo.build/blog/turbo-1-7-0#global-turbo?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting), a feature that allows users to install Turborepo as a globally available command on their machine.

我们决定将首个 Rust 功能定为 [全局 `turbo`](https://turbo.build/blog/turbo-1-7-0#global-turbo?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting) —— 一项允许用户将 Turborepo 安装为机器上全局可用命令的功能。

A global installation of `turbo` will look for a locally installed `turbo` program in the repository, execute it if it exists, and otherwise fallback to the global `turbo` binary. That way, you can easily run `turbo` from anywhere in your repository, but also keep a specific version of `turbo` pinned in your `package.json`.

全局安装的 `turbo` 会首先在当前仓库中查找本地安装的 `turbo` 程序：若存在则直接执行；否则回退至全局 `turbo` 二进制文件。如此一来，你便可在仓库任意位置便捷地运行 `turbo` 命令，同时还能在 `package.json` 中锁定特定版本的 `turbo`。

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_009.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_010.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_011.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_012.jpg)

This feature is implemented through what we started calling "the Rust shim," a bit of Rust code that wraps the existing Go code. The Go portion is compiled via CGO as a C static library and then linked to the Rust binary. Luckily, global `turbo` only required a few features from the rest of Turborepo's code, such as reading configuration and navigating the file system.

该功能通过我们称之为“Rust shim”（Rust 胶水层）的一小段 Rust 代码实现——它封装了现有的 Go 代码。其中 Go 部分借助 CGO 编译为 C 静态库，再链接至 Rust 二进制文件。幸运的是，全局 `turbo` 仅需调用 Turborepo 其余代码中少量功能，例如读取配置和遍历文件系统。

## CLI parsing

## 命令行参数解析

As we implemented global `turbo`, we realized we needed to parse a few command line arguments like `--cwd`, the argument for setting `turbo`'s current working directory.

在实现全局 `turbo` 命令时，我们意识到需要解析若干命令行参数，例如 `--cwd`（用于设置 `turbo` 当前工作目录的参数）。

After global `turbo`, it made sense to continue by porting the rest of the CLI argument parser to Rust. To parse arguments, we use the [`clap` crate](https://docs.rs/clap/latest/clap/) (Rust’s equivalent of an npm package). `clap` lets you define a data type with the arguments, annotate it a little bit, and it will automatically create a parser.

在完成全局 `turbo` 后，顺势将整个 CLI 参数解析器迁移到 Rust 就成了顺理成章的选择。为解析命令行参数，我们采用了 [`clap` crate](https://docs.rs/clap/latest/clap/)（Rust 生态中与 npm 包功能相当的库）。`clap` 允许你定义一个承载参数的数据类型，稍加注解，即可自动生成参数解析器。

With the pieces in place, we had to work on sending the args from the Rust entry point to the Go code. For better or worse, [C is the standard for foreign function interfacing (FFI)](https://faultlore.com/blah/c-isnt-a-language/), so we had to use C to communicate between Rust and Go.

当各组件就绪后，我们需解决如何将参数从 Rust 入口点传递至 Go 代码的问题。无论优劣，[C 语言是外部函数接口（FFI）的事实标准](https://faultlore.com/blah/c-isnt-a-language/)，因此我们不得不借助 C 语言在 Rust 与 Go 之间建立通信。

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_013.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_014.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_015.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_016.jpg)

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_013.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_014.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_015.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_016.jpg)

We wanted to avoid having too many types in C, as we weren’t confident that we could write cross-platform C types that played well with both Rust and Go. Instead, we decided to serialize our arguments to JSON and send it to Go as a string. Even though JSON serialization does have some overhead, we knew that the arguments struct would only be a few hundred bytes in size, so the performance impact would be minimal.

我们希望尽量避免在 C 层定义过多类型，因为我们无法确信自己能写出既兼容 Rust 又兼容 Go 的跨平台 C 类型。因此，我们决定将参数序列化为 JSON 字符串，并以字符串形式传递给 Go。尽管 JSON 序列化存在一定开销，但我们清楚参数结构体大小仅数百字节，因此性能影响微乎其微。

On the Rust side, we used another cornerstone crate of the Rust ecosystem, [`serde`](https://docs.rs/serde/latest/serde/), which lets you serialize and deserialize data in various different formats, using some minimal annotation. For the Go side, we were already using JSON in the codebase, so it was easy to receive the JSON string and deserialize it into a Go struct.

在 Rust 端，我们使用了 Rust 生态系统的另一基石级 crate —— [`serde`](https://docs.rs/serde/latest/serde/)，它通过极简的注解即可支持多种格式的数据序列化与反序列化。而在 Go 端，代码库中早已广泛使用 JSON，因此接收该 JSON 字符串并将其反序列化为 Go 结构体也十分便捷。

## Ship it?

## 可以发布了？

With these two features ported, we were ready to ship our first hybrid Go-Rust release.

随着这两项功能迁移完成，我们已准备好发布首个 Go-Rust 混合版本。

However, before we could release, we needed to make sure the Go-Rust binary worked in all the various contexts that Turborepo is used, [like the different operating systems and Linux distros that we support](https://turbo.build/repo/docs/installing?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting). As we tested our code, we started noticing some issues on a couple platforms.

然而，在正式发布前，我们必须确保 Go-Rust 二进制文件能在 Turborepo 所有实际运行环境中正常工作，[包括我们所支持的各种操作系统及 Linux 发行版](https://turbo.build/repo/docs/installing?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting)。在测试过程中，我们开始在部分平台上发现一些问题。

### Windows difficulties

### Windows 平台的难题

On Windows, there are two main toolchains, [Microsoft Visual C++ (MSVC)](https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B) and [Minimalist GNU for Windows (MinGW)](https://en.wikipedia.org/wiki/MinGW).

在 Windows 上，主要有两种工具链：[Microsoft Visual C++（MSVC）](https://zh.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B) 和 [Minimalist GNU for Windows（MinGW）](https://zh.wikipedia.org/wiki/MinGW)。

Go **only** uses MinGW, but we were using Rust with MSVC. This caused some runtime issues, but, luckily, the solution was simple: we moved our Rust toolchain to MinGW.

Go **仅支持** MinGW，但我们此前使用的是基于 MSVC 的 Rust 工具链。这引发了一些运行时问题；幸运的是，解决方案很简单：我们将 Rust 工具链切换到了 MinGW。

Next up, we had some issues with paths. Windows has a couple concepts of paths, including what’s called a Universal Naming Convention (UNC) path. When you ask Windows to canonicalize a path (resolve all symlinks and normalize components of the path), it gives you a UNC path.

接下来，我们遇到了路径相关的问题。Windows 中存在多种路径概念，其中一种称为“通用命名约定”（Universal Naming Convention，UNC）路径。当你请求 Windows 对某路径进行规范化（即解析所有符号链接，并标准化路径各组成部分）时，系统返回的往往是一个 UNC 路径。

However, despite the name, UNC paths are not supported everywhere—sometimes not even by Windows itself! This caused a few bugs where we’d provide a UNC path and get an invalid path error. The solution was to use a helpful Rust crate called [dunce](https://docs.rs/dunce/latest/dunce/) that lets you canonicalize a path and get a non-UNC path back, handling the intricacies of this problem for us.

然而，尽管名称中带有 “Universal”，UNC 路径却并非处处受支持——有时甚至连 Windows 自身都不完全支持！这导致了若干 Bug：当我们传入一个 UNC 路径时，却收到“无效路径”的错误。解决方案是采用一个实用的 Rust crate —— [dunce](https://docs.rs/dunce/latest/dunce/)，它能在对路径进行规范化的同时，确保返回的是非-UNC 格式的路径，从而帮我们自动处理该问题的诸多细节。

### Alpine Linux

### Alpine Linux

The second set of challenges came with Alpine Linux. At Vercel, we use Alpine, a common operating system for cloud computing, to create lightweight containers for building your projects.

第二类挑战来自 Alpine Linux。在 Vercel，我们使用 Alpine —— 一种广泛应用于云计算场景的操作系统 —— 来构建轻量级容器，用于编译用户的项目。

Alpine, though, does not come with `glibc`, the de-facto implementation of the C standard library. This is a problem because many binaries assume `glibc` is installed and don’t package it themselves. There are some libraries that pave over this issue using packages like `gcompat` or `libc6-compat`, but they didn’t end up working for us because the version of `glibc` that Rust requires was too modern for our supported targets. When we’d try to run the binary, we’d get errors that the required `glibc` version was not available.

但 Alpine 系统默认不包含 `glibc`（C 标准库的事实标准实现）。这带来一个问题：许多二进制程序都假定系统已安装 `glibc`，自身并不打包该库。虽然存在一些兼容性方案（例如通过 `gcompat` 或 `libc6-compat` 等软件包弥补），但这些方案最终未能奏效——因为 Rust 所需的 `glibc` 版本过于新，超出了我们所支持目标平台的兼容范围。当我们尝试运行该二进制文件时，便会报错：“所需的 `glibc` 版本不可用”。

As a result, we decided to compile Turborepo as a fully static binary. This meant that we packaged our own C standard library implementation using `musl` (since you can't statically link `glibc` due to licensing issues). This seems to work just fine for both Rust and Go: Rust lets you set the C standard library in the target (`aarch64-unknown-linux-musl` vs. `aarch64-unknown-linux-gnu`) and Go does not use a C standard library by default.

因此，我们决定将 Turborepo 编译为完全静态链接的二进制文件。这意味着我们自行打包了一个 C 标准库实现 —— `musl`（由于许可证限制，`glibc` 无法进行静态链接）。这一方案对 Rust 和 Go 均表现良好：Rust 允许在目标平台配置中指定 C 标准库（如 `aarch64-unknown-linux-musl` 对应 `musl`，而 `aarch64-unknown-linux-gnu` 对应 `glibc`）；而 Go 默认根本不依赖 C 标准库。

However, when we ran this statically linked binary, it would return a segmentation fault. Even worse, when we inspected with a debugger, we’d find a corrupted stack. And, even worser, the segfault appeared to be coming from the Go runtime itself!

然而，当我们运行这个静态链接的二进制文件时，却触发了段错误（segmentation fault）。更糟的是，使用调试器检查时，我们发现栈已被破坏；而最糟糕的是，该段错误似乎直接源自 Go 运行时本身！

After a lot of searching, we tracked down a [seven year-old GitHub issue](https://github.com/golang/go/issues/13492) which explained that Go cannot be compiled as a C static library with `musl`. This posed a significant challenge, as Alpine Linux is an essential platform for Turborepo and its users. We had to go back to the drawing board and figure out how we could ship our Go-Rust combination.

经过大量排查，我们最终定位到一个[已有七年历史的 GitHub Issue](https://github.com/golang/go/issues/13492)，其中明确指出：Go 无法以 C 静态库形式与 `musl` 一同编译。这对 Turborepo 及其用户而言构成了重大挑战——毕竟 Alpine Linux 是 Turborepo 不可或缺的核心平台。我们不得不推倒重来，重新思考如何交付这套 Go-Rust 混合技术栈。

Eventually, after a ton more deliberation, we came up with a solution: we’d compile our Go code and our Rust code as two separate binaries. The Rust code would call the Go code and pass the args serialized to JSON via the CLI.

经过大量反复权衡后，我们最终提出了一种解决方案：将 Go 代码和 Rust 代码分别编译为两个独立的二进制文件。Rust 代码将通过命令行接口（CLI）调用 Go 代码，并以 JSON 格式序列化后传递参数。

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_017.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_018.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_019.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_020.jpg)

We knew that the args were small enough that they could be passed via CLI without too much of a performance hit. And because we were using a serialization format, the code changes were extremely small. All we had to do was change how Rust was sending the JSON string to Go.

我们深知，这些参数体积足够小，通过 CLI 传递不会带来显著的性能损耗。同时，由于采用了序列化格式，代码改动量极小——我们只需调整 Rust 向 Go 传递 JSON 字符串的方式即可。

With that, we were able to get our first hybrid Go-Rust release out the door. The first version of `turbo` that was shipped to you using these compilation strategies was [version 1.7.0](https://turbo.build/blog/turbo-1-7-0?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting).

由此，我们成功发布了首个 Go/Rust 混合版本。采用上述编译策略交付给您的首个 `turbo` 版本是 [1.7.0 版](https://turbo.build/blog/turbo-1-7-0?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting)。

## What we learned

## 我们学到的经验

Through this effort, we've learned a lot about moving from one language to another. Let's take note of what we've found.

通过此次迁移实践，我们对跨语言重构积累了大量宝贵经验。以下是我们总结出的关键要点。

### Serialization is useful for FFI

### 序列化在外部函数接口（FFI）中非常实用

Our first takeaway is that serialization formats are very useful for interoperability. By serializing to JSON, a format with robust support in both Go and Rust, we were able to minimize our FFI surface area, and avoid a whole class of cross-platform, cross-language bugs. When we had to switch from a single, linked binary to two binaries, we were able to do so with relative ease because our FFI surface area was so small.

我们的首要经验是：序列化格式在跨语言互操作中极为有效。通过采用 JSON 这一在 Go 和 Rust 中均有完善支持的序列化格式，我们大幅缩减了外部函数接口（FFI）的暴露面，从而规避了大量因跨平台、跨语言导致的潜在缺陷。当我们将原先的单体链接二进制文件切换为两个独立二进制文件时，正因 FFI 接口极其精简，整个迁移过程得以顺利推进。

The tradeoff here is that serialization and deserialization is slow. You can only depend on this technique if either you know your serialized payloads will be small or you don't care about the performance hit for your use case.

其权衡之处在于：序列化与反序列化本身存在性能开销。该技术仅适用于两种场景之一：一是你明确知晓待序列化的数据载荷体积很小；二是你的具体使用场景对这一性能损耗不敏感。

### Porting takes preparation

### 迁移需要充分准备

The second takeaway is that incremental porting is feasible but requires lots of careful testing and strategizing. We ran into quite a few tricky bugs and we caught these issues through lots of automated and manual testing. You can [check out our (and Turbopack's) testing suites in our GitHub workflows](https://github.com/vercel/turbo/tree/main/.github/workflows).

第二个要点是：渐进式迁移是可行的，但需要大量细致的测试和周密的规划。我们遇到了不少棘手的 Bug，而这些问题是通过大量自动化测试与人工测试发现的。您可[在我们的 GitHub 工作流中查看（我们及 Turbopack 的）测试套件](https://github.com/vercel/turbo/tree/main/.github/workflows)。

Testing is also extremely important for nailing down the behavior of your code, whether it’s the exact edge cases of CLI parsing, or the order in which configuration is loaded. These exact details are not so crucial when you’re writing your first implementation, but they’re absolutely paramount to avoid breaking changes during a port or rewrite. You should aim to write tests **before** you start porting code, so that you have a known specification to work against.

测试对于精确界定代码行为也极为关键——无论是 CLI 参数解析中的各种边界情况，还是配置加载的确切顺序。这些细节在初次实现时未必至关重要，但在迁移或重写过程中，却对避免破坏性变更起着决定性作用。因此，您应在启动代码迁移**之前**就编写好测试，从而获得一份明确、可依赖的行为规范。

### Cross-compatibility is difficult

### 跨平台兼容性难度极高

The third takeaway is that cross-platform, cross-language release engineering is extremely challenging. Every platform, language, and compiler has their own quirks that can make interoperability difficult and, the more things you have working together, the more opportunities you have for a new complication.

第三个要点是：跨平台、跨语言的发布工程极具挑战性。每个平台、每种语言、每个编译器都有其特有的“怪癖”，可能给互操作性带来障碍；而协同工作的组件越多，出现新问题的可能性也就越大。

### Porting is worth it for us

### 对我们而言，迁移是值得的

Finally, while porting from Go to Rust has been challenging, it has proven to be the correct choice for us strategically. Even with our porting effort going on, we've been able to ship new features, handle bugs in existing functionality, and keep helping our users while we migrate. It's required some extraordinarily tricky debugging, careful planning, and rigorous testing, but we believe it has been worth it.

最后，尽管从 Go 迁移到 Rust 充满挑战，但从战略层面看，这一选择已被证明是正确的。即便在迁移工作持续推进的同时，我们仍成功发布了新功能、修复了既有功能中的 Bug，并持续为用户保驾护航。这期间离不开极其复杂的调试、审慎的规划以及严格的测试——但我们坚信，这一切都是值得的。

## -turborepo) Try out (ported) Turborepo

## -turborepo）试用（已完成迁移的）Turborepo

This week, Turborepo saved 5,742 hours of time for the product engineers and CI machines at Vercel. If you want to try out the same technology in just a few minutes, [check out our article](https://vercel.com/blog/vercel-remote-cache-turbo) on how you can get started with [Vercel Remote Cache](https://vercel.com/docs/concepts/monorepos/remote-caching).

本周，Turborepo 为 Vercel 的产品工程师及 CI 机器节省了总计 5,742 小时的时间。若您希望仅用几分钟便体验相同技术，请[阅读我们的文章](https://vercel.com/blog/vercel-remote-cache-turbo)，了解如何快速上手使用 [Vercel 远程缓存（Vercel Remote Cache）](https://vercel.com/docs/concepts/monorepos/remote-caching)。

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### This is an official starter Turborepo with two Next.js sites and three local packages

### 这是一个官方的 Turborepo 入门模板，包含两个 Next.js 网站和三个本地包

Turborepo & Next.js Starter

Turborepo 与 Next.js 入门模板

Vercel.com landing page

Vercel.com 官网落地页

### Visit turborepo.com

### 访问 turborepo.com