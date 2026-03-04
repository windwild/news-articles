---
title: "Using Zig in our incremental Turborepo migration from Go to Rust - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-we-continued-porting-turborepo-to-rust"
date: "2023-09-08"
scraped_at: "2026-03-02T09:51:09.407972284+00:00"
language: "en-zh"
translated: true
description: "In this Turborepo migration update, we explore the innovative strategies, such as the \"Go Sandwich\" approach and leveraging Zig's cross-compilation, guiding our gradual shift from Go to Rust, aiming t..."
---
&#123;% raw %}

Sep 8, 2023

2023 年 9 月 8 日

了解我们如何将一个“Rust-Go-Rust”三层架构交叉编译至六个平台。

我们一直在将 [Turborepo](https://turbo.build/repo)（一款面向 JavaScript 和 TypeScript 的高性能构建系统）从 Go 迁移至 Rust。此前我们已介绍过[迁移工作的启动过程](https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust?nxtPslug=how-turborepo-is-porting-from-go-to-rust)，现在让我们深入探讨：我们是如何开始迁移两个核心命令——`run` 和 `prune` 的。

## 自上次更新以来

上一次更新时，我们已通过在 Rust 中实现全局 `turbo` 命令及命令行参数解析，正式启动了迁移工作。但由于静态链接存在若干问题，加之 [Go 与 `musl` 不兼容](https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust?nxtPslug=how-turborepo-is-porting-from-go-to-rust#alpine-linux)（而 `musl` 是 Alpine Linux 兼容性的关键要求），我们最终将 Turborepo 拆分为两个二进制文件：一个用 Rust 编写，另一个仍用 Go 编写。

此后，我们陆续完成了辅助命令（如 `login`、`link`、`unlink`）的迁移。这些命令迁移起来相对简单，因为它们仅需一个基础 HTTP 客户端和一些配置管理逻辑。我们分别通过[一次](https://github.com/vercel/turbo/pull/3500)或[两次](https://github.com/vercel/turbo/pull/3372) Pull Request 就完成了全部迁移。

## `run` 和 `prune`

然而，在完成上述辅助命令的迁移后，我们面临一个新挑战：如何迁移 `run` 和 `prune`？这两个命令承担了 `turbo` 工具中绝大部分核心工作。`run` 命令负责执行各类任务，例如 `build`、`lint` 和 `test`；而 `prune` 命令则接收整个 Turborepo 项目，并生成其子集——该子集仅包含指定的一个包及其直接依赖项。这一功能在你只想使用某个特定包（例如在 Docker 容器中）且不希望将整个 Turborepo 复制进容器时尤为有用。

![一张图展示了一个含抽象包的完整单体仓库（monorepo）；另一张有向图则展示了对该 monorepo 执行 \`turbo prune\` 后得到的子集](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_001.jpg)![一张图展示了一个含抽象包的完整单体仓库（monorepo）；另一张有向图则展示了对该 monorepo 执行 \`turbo prune\` 后得到的子集](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_002.jpg)一张图展示了一个含抽象包的完整单体仓库（monorepo）；另一张有向图则展示了对该 monorepo 执行 \`turbo prune\` 后得到的子集

因此，这两个命令的代码体量相当庞大。以 `run` 为例，它需完成以下工作：

1. 从命令行参数、您的 `turbo.json` 文件、环境变量等处读取配置。

2. 构建 Turborepo 中各个包之间的依赖关系图，即“包图”（package graph）。

3. 判定哪些包已被修改。

4. 基于任务依赖关系图（即 [任务图（Task Graph）](https://turbo.build/repo/docs/core-concepts/monorepos/task-graph)），确定需要执行哪些任务以及它们的执行顺序。

5. 并行执行这些任务。

6. 将这些任务的输出保存至文件系统缓存和/或远程缓存。

7. 生成本次执行的汇总报告。

以上只是一个简化、高层次的概述！实际上，背后还涉及大量其他工作，例如过滤（filtering）、试运行（dry runs）、哈希计算（hashing）等。我们无法像之前迁移认证（auth）相关命令那样，仅通过一两次 Pull Request 就完成这些命令的迁移；我们必须采用一种能够逐步推进的方式。

## 增量迁移策略

我们针对将 `run` 和 `prune` 命令迁移到 Rust，评估了若干种策略，所有策略均基于 [增量迁移原则](https://vercel.com/blog/incremental-migrations)。

### Option 1: The same strategy

### 方案一：沿用原有策略

The first strategy that we considered was to continue what we were already doing for command-line parsing: Do more work in the Rust code and pass the result to the Go code. However, this had a fatal flaw. Almost all of the work that we were doing in `run` involved either the package dependency graph or the task dependency graph. Graphs can get large extremely quickly, so serializing them over JSON would induce a lot of overhead.

我们最先考虑的策略是延续当前命令行参数解析的做法：在 Rust 代码中承担更多工作，再将结果传递给 Go 代码。然而，该方案存在一个致命缺陷：`run` 中几乎所有的逻辑都涉及包依赖图（package dependency graph）或任务依赖图（task dependency graph）。而图结构极易迅速膨胀，若通过 JSON 序列化传输，将带来巨大的性能开销。

Also, from a stability perspective, the package graph is the core abstraction within `turbo`. We needed to build up enough infrastructure and testing to make sure that it was rock-solid before we could ship a ported version.

此外，从稳定性角度看，包图是 `turbo` 内部的核心抽象。我们必须先构建起足够完善的基础设施与测试体系，确保其坚如磐石，才能发布迁移后的版本。

### Option 2: Write from scratch

### 方案二：完全重写

Another option would be to build up a Rust version of `run` / `prune` from scratch, then switch over once it’s completed. We didn’t want to do this, since, as stated in [the previous blog post](https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust?nxtPslug=how-turborepo-is-porting-from-go-to-rust), we weren’t confident that we could produce a full rewrite that kept the same behavior.

另一方案是完全从零开始用 Rust 重写 `run` / `prune`，待完成后再整体切换。但我们不愿采用此方案——正如[上一篇博客文章](https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust?nxtPslug=how-turborepo-is-porting-from-go-to-rust)所述，我们无法确信能实现一次行为完全一致的完整重写。

### Option 3: Trampoline

### 方案三：跳板机制（Trampoline）

We also had some ideas that involved reusing our existing infrastructure, such as creating a [trampoline](https://en.wikipedia.org/wiki/Trampoline_(computing)) where the Go binary would have an entry-point function that could redirect to different parts of the `run` pipeline, so the Rust code could call the Go binary, get a result, process that more, then call the Go binary again. This would allow us to reuse the two binary setup that we already had. If you’re familiar with JavaScript callbacks, you can think of this as the Rust code producing events that the Go code handles with a callback.

我们还提出了一些可复用现有基础设施的构想，例如构建一个[跳板（trampoline）](https://en.wikipedia.org/wiki/Trampoline_(computing))机制：让 Go 二进制文件提供一个入口函数，能够将控制权动态重定向至 `run` 流水线的不同阶段；这样 Rust 代码便可调用 Go 二进制文件获取结果，进一步处理后再次调用 Go 二进制文件。该方式使我们得以继续沿用已有的双二进制架构。如果你熟悉 JavaScript 的回调函数，可将其类比为：Rust 代码负责“触发事件”，而 Go 代码以回调方式响应并处理这些事件。

![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_003.jpg)![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_004.jpg)

![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_003.jpg)![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_004.jpg)

### Option 4: Use the daemon

### 方案四：复用守护进程（Daemon）

Similarly to the previous option, we considered adapting Turborepo’s daemon for porting. The daemon is a performance optimization that runs in the background and watches the files in your Turborepo. That way, when you run a task, `turbo` already knows which files have changed and, therefore, which tasks to run. Our strategy would be to port the daemon to Rust, and then add more and more functionality to the daemon, such as having it create the package graph and task graph. However, the daemon is meant as an optional performance improvement, so making it an essential part of the `run` pipeline would be a significant shift in architecture.

与前一方案类似，我们也曾考虑将 Turborepo 的守护进程（daemon）纳入迁移路径。该 daemon 是一项性能优化机制：它在后台持续运行，并监控你项目中所有 Turborepo 相关文件的变化。因此，当你执行某项任务时，`turbo` 已预先知晓哪些文件发生了变更，从而可立即确定需执行哪些任务。我们的设想是：先将 daemon 迁移至 Rust，再逐步为其扩展功能——例如，由 daemon 负责构建包依赖图与任务依赖图。但需注意，daemon 原本仅作为可选的性能增强组件；若使其成为 `run` 流水线不可或缺的一环，则意味着整个系统架构将发生重大转变。

## The winning solution: The Go sandwich

## 制胜方案：“Go 三明治”

After considering these options, we settled on building what we call the “Rust-Go-Rust sandwich” or the “Go sandwich” for short. It consists of a Rust binary that calls a Go binary, which in turn calls Rust libraries that are statically linked into the Go binary. This allows us to split up the `run` and `prune` code between the two languages and port individual dependencies. This way, we could tackle `run` and `prune` incrementally, allowing for better testing and debugging through the migration.

在权衡这些方案后，我们最终决定构建一种我们称之为“Rust-Go-Rust 三明治”（简称“Go 三明治”）的架构。该架构由一个 Rust 二进制程序调用一个 Go 二进制程序组成，而该 Go 二进制程序又调用被静态链接进其自身的 Rust 库。这使我们得以将 `run` 和 `prune` 的逻辑分别拆分到两种语言中，并逐个迁移依赖项。由此，我们可以以增量方式逐步完成 `run` 和 `prune` 的迁移，从而在迁移过程中实现更完善的测试与调试。

![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_005.jpg)![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_006.jpg)

The Rust dependencies that we’ve ported are contained in [the `turborepo-ffi` crate](https://github.com/vercel/turbo/tree/main/crates/turborepo-ffi). We compile that crate to a C static library, (a `staticlib` in Rust terms). From there, we link it to our Go binary using CGO. [Unlike last time](https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust#alpine-linux), we didn’t run into any [segfault issues](https://en.wikipedia.org/wiki/Segmentation_fault) because, while linking Go to Rust is broken with `musl`, linking Rust to Go is fine.

我们已迁移的 Rust 依赖均封装在 [`turborepo-ffi` crate](https://github.com/vercel/turbo/tree/main/crates/turborepo-ffi) 中。我们将该 crate 编译为一个 C 静态库（即 Rust 所谓的 `staticlib`），再通过 CGO 将其链接至我们的 Go 二进制程序。[与上一次不同](https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust#alpine-linux)，此次我们未遇到任何 [段错误（segfault）问题](https://zh.wikipedia.org/wiki/%E6%AE%B5%E9%94%99%E8%AF%AF)，原因是：虽然在 `musl` 环境下将 Go 链接到 Rust 存在缺陷，但将 Rust 链接到 Go 却完全可行。

To communicate between Go and Rust, we decided to use `protobuf`, as it was platform-independent, relatively compact, and had an explicit schema that could be used to generate Rust and Go types, keeping our types in sync across languages. This was especially important since we had a lot more surface area between Rust and Go than when we were porting the command line arguments.

为实现 Go 与 Rust 之间的通信，我们选择采用 `protobuf`：它具备跨平台特性、序列化体积相对紧凑，且拥有明确的 Schema 定义，可据此自动生成 Rust 和 Go 的类型定义，从而确保两类语言中的数据结构保持同步。这一点尤为关键——相较于此前仅迁移命令行参数时的接口规模，当前 Rust 与 Go 之间的交互面要大得多。

Finally, we modified our build process so that we could toggle the Go sandwich on or off. That way, we could always revert back to the Go code if we encountered bugs in the Rust implementation. This did mean that we had to keep the Go code around, but we knew that this was ultimately temporary.

最后，我们调整了构建流程，使其支持动态启用或禁用“Go 三明治”模式。如此一来，一旦 Rust 实现中出现 Bug，我们便可随时回退至原有 Go 代码。当然，这也意味着我们必须暂时保留 Go 代码；但我们清楚，这只是过渡阶段的权宜之计。

## Sandwich porting process

## “三明治”式迁移流程

Let’s walk through an example of porting to Rust. We have code to include environment variables in what’s called our global hash, which determines whether or not we have a global change that necessitates re-running all of our tasks. This is a nice, self-contained chunk of code, so it was a good candidate for porting.

让我们以一个迁移到 Rust 的具体示例展开说明。我们有一段代码用于将环境变量纳入所谓“全局哈希（global hash）”的计算中；该哈希值决定了是否存在影响全局的变更，进而判断是否需要重新执行全部任务。这段代码逻辑清晰、边界明确，因此非常适合作为首批迁移目标。

To start, we needed to determine what exactly we wanted to port. Ideally, we should be porting non-trivial chunks, as we don’t want to be inducing the `protobuf` overhead for a trivial function—but it shouldn’t be so large that it’s out of the scope of a single PR. In this case, we decided to port the `getGlobalHashableEnvVars` function, which takes [the user's environment variable configuration](https://turbo.build/repo/docs/reference/configuration#globalenv) and determines which environment variables to provide as inputs to the global hash.

首先，我们需要明确究竟要迁移哪些内容。理想情况下，应优先迁移具有一定复杂度的模块——既避免为简单函数引入 `protobuf` 序列化开销，又不宜过大而超出单个 Pull Request 的合理范围。本例中，我们选定迁移 `getGlobalHashableEnvVars` 函数：该函数接收用户配置的[环境变量列表](https://turbo.build/repo/docs/reference/configuration#globalenv)，并据此判定哪些变量应作为输入参与全局哈希的计算。

Next, we split up the existing code into the [old Go implementation (`global_hash_go.go`)](https://github.com/vercel/turbo/pull/5166/files#diff-815f123763ca59163acca24037c949086b06fe07f203032c6a38eddeaec3c189) and the new Go code that calls [the Rust implementation (`global_hash_rust.go`)](https://github.com/vercel/turbo/pull/5166/files#diff-d0541bae6afdec09cfb6913066410385b55d2976b45112856700f92fe52ac707). We use [Go build tags](https://pkg.go.dev/go/build#hdr-Build_Constraints) to decide which implementation to build so we can always toggle back to the old Go implementation if the new Rust implementation contains a bug.

接下来，我们将原有代码拆分为两部分：[旧版 Go 实现（`global_hash_go.go`）](https://github.com/vercel/turbo/pull/5166/files#diff-815f123763ca59163acca24037c949086b06fe07f203032c6a38eddeaec3c189) 与调用 [Rust 实现的新版 Go 代码（`global_hash_rust.go`）](https://github.com/vercel/turbo/pull/5166/files#diff-d0541bae6afdec09cfb6913066410385b55d2976b45112856700f92fe52ac707)。我们借助 [Go 构建标签（build tags）](https://pkg.go.dev/go/build#hdr-Build_Constraints) 控制实际编译哪一版本，从而确保一旦新版 Rust 实现存在 Bug，即可立即无缝回退至旧版 Go 实现。

Then, we wrote the [Rust implementation](https://github.com/vercel/turbo/pull/5166/files#diff-6ee8c8df758308489eee2fb88a16392ed765a1de5a2817c4d668e13a6f6db552), added the necessary input and output types to our [`protobuf` schema](https://github.com/vercel/turbo/pull/5166/files#diff-19682a19ede4a33835e912c03c79aba9bbc9c09c7fcd427961d633c8b396ed14), created an [exported function in `turborepo-ffi`](https://github.com/vercel/turbo/pull/5166/files#diff-1e11b40725ad470dde0277e05ba9df21c1c3ce99230845ba1f7e967d774846f2), and called that function in [`ffi.go`](https://github.com/vercel/turbo/pull/5166/files#diff-573c0c60a25977ffa8b2216634274494ba12038f32e1ddec7f3d87a4a1f5e2d4). And of course, [we made sure to write tests](https://github.com/vercel/turbo/pull/5166/files#diff-06a37a82a5abdbea12d8798e27a56c182923a5a8dfde4b70cb650d93e680252e)! If you want to check out the full process, you can [find the pull request here](https://github.com/vercel/turbo/pull/5166/files#diff-815f123763ca59163acca24037c949086b06fe07f203032c6a38eddeaec3c189).

然后，我们编写了 [Rust 实现](https://github.com/vercel/turbo/pull/5166/files#diff-6ee8c8df758308489eee2fb88a16392ed765a1de5a2817c4d668e13a6f6db552)，将必需的输入与输出类型添加到了我们的 [`protobuf` 模式定义](https://github.com/vercel/turbo/pull/5166/files#diff-19682a19ede4a33835e912c03c79aba9bbc9c09c7fcd427961d633c8b396ed14)中，在 [`turborepo-ffi`](https://github.com/vercel/turbo/pull/5166/files#diff-1e11b40725ad470dde0277e05ba9df21c1c3ce99230845ba1f7e967d774846f2) 中创建了一个导出函数，并在 [`ffi.go`](https://github.com/vercel/turbo/pull/5166/files#diff-573c0c60a25977ffa8b2216634274494ba12038f32e1ddec7f3d87a4a1f5e2d4) 中调用了该函数。当然，[我们也确保编写了完备的测试](https://github.com/vercel/turbo/pull/5166/files#diff-06a37a82a5abdbea12d8798e27a56c182923a5a8dfde4b70cb650d93e680252e)！如果你想了解整个流程，可[在此查看该 Pull Request](https://github.com/vercel/turbo/pull/5166/files#diff-815f123763ca59163acca24037c949086b06fe07f203032c6a38eddeaec3c189)。

With all of this setup, we were able to port more and more pieces of `run` and `prune` to Rust in a relatively straightforward process. However, when it came to shipping the Go sandwich, we ran into some release issues. Here’s how we solved them with an unlikely ally.

借助上述全部准备工作，我们得以以一种相对直接的方式，逐步将 `run` 和 `prune` 的更多功能模块迁移至 Rust。然而，当真正要发布“Go 三明治”（即 Go-Rust 混合二进制）时，我们却遇到了一些发布难题。下面介绍我们如何借助一位意想不到的“盟友”解决了这些问题。

## The Turborepo release process

## Turborepo 发布流程

Turborepo is distributed as a native binary on Windows, Linux, and macOS for both x86-64 and aarch64, the two predominant CPU architectures. Doing the math, that's 6 targets to build and support—not an easy task. As we detailed in [our post about why we’re moving from Go to Rust](https://vercel.com/blog/turborepo-migration-go-rust), it’s quite difficult to write code that handles low-level features like file systems and processes in a cross-platform manner. However, what’s more challenging is building and releasing this cross-platform code for 6 different targets, especially when you’re using two different languages with two different toolchains.

Turborepo 以原生二进制形式分发，支持 Windows、Linux 和 macOS 三大操作系统，同时兼容 x86-64 和 aarch64 这两种主流 CPU 架构。粗略计算，这意味着需要构建并维护共计 6 种目标平台——绝非易事。正如我们在 [《为何我们将 Turborepo 从 Go 迁移至 Rust》一文](https://vercel.com/blog/turborepo-migration-go-rust) 中所详述：编写能跨平台处理文件系统、进程等底层特性的代码本身就颇具挑战；而更困难的是，为这 6 种不同目标平台构建并发布跨平台代码——尤其当项目同时使用两种语言、依赖两套不同的工具链时。

![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_007.jpg)![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_008.jpg)

![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_007.jpg)![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_008.jpg)

Generally, when you write code and build it, you are doing a native compilation. You're building the code for the operating system and architecture of the computer that you're currently using. This works just fine for local development; you build and immediately run it on your computer. But for releases, this process needs to change. We can’t spin up 6 different machines for each of the targets we support. It would take a really long time, and waste compute resources, and our release pipeline is on GitHub Actions which does not support `aarch64` anyway.

通常，当你编写并构建代码时，执行的是**本地编译（native compilation）**：即针对你当前所用计算机的操作系统和 CPU 架构进行构建。这种方式对本地开发非常友好——你构建完即可立即在本机运行。但面向正式发布的场景，这一流程必须改变。我们不可能为每种支持的目标平台都单独启动一台专用机器（共需 6 台），那样不仅耗时极长、浪费大量计算资源，而且我们的发布流水线基于 GitHub Actions，而它本身并不支持 `aarch64` 架构。

Instead, we do what’s called a cross-compilation. Cross-compilation involves building your code for an operating system and/or architecture that is **not** the same as the computer you're currently using. For instance, you can cross-compile an x86-64 Linux binary on an aarch64 macOS computer.

因此，我们采用所谓**交叉编译（cross-compilation）**：即构建运行于**不同于当前开发机**的操作系统和/或 CPU 架构上的可执行程序。例如，你完全可以在一台搭载 aarch64 架构的 macOS 计算机上，交叉编译出一个适用于 x86-64 架构的 Linux 二进制文件。

To handle cross-compilation for our Go code, we use a tool called Go Releaser. As the name indicates, Go Releaser releases Go code by building binaries for multiple targets, then releases them (in our case to npm).

为支持 Go 代码的交叉编译，我们使用了一款名为 **Go Releaser** 的工具。顾名思义，Go Releaser 通过为多个目标平台构建二进制文件来完成 Go 项目的发布（在我们的场景中，最终发布到 npm）。

## Go sandwich complications

## “Go 三明治”的发布难题

With the Go sandwich, we had a new problem: how can we release a hybrid Go-Rust binary?

引入“Go 三明治”后，我们面临一个新问题：如何发布一个 Go 与 Rust 混合的二进制程序？

We had designed our Go sandwich to use a Rust crate, `turborepo-ffi`, compiled to a `staticlib`, a native C library, which we then linked to our Go code via CGO. This worked just fine locally. However, when it came to releasing, we ran into a few issues.

我们原本设计了 Go “夹心层”（Go sandwich）方案，使其调用一个 Rust crate `turborepo-ffi`，该 crate 被编译为 `staticlib`（即原生 C 静态库），再通过 CGO 将其链接到 Go 代码中。这一方案在本地运行完全正常；但在发布阶段，我们却遇到了若干问题。

### Windows ARM

### Windows ARM 平台

As you may recall [from the last post](https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust#windows-difficulties), there are two main toolchains with Windows: [Microsoft Visual C++ (MSVC)](https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B) and [Minimalist GNU for Windows (MinGW)](https://en.wikipedia.org/wiki/MinGW). The former, MSVC, is written and maintained by Microsoft with a specific Application Binary Interface (ABI), while the latter, MinGW, ports the GNU software suite to Windows. MinGW has its own ABI meaning things compiled for MSVC and for MinGW are not interoperable.

如您可能从[上一篇文章](https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust#windows-difficulties)中所知，Windows 平台主要有两大工具链：[Microsoft Visual C++（MSVC）](https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B) 和 [Minimalist GNU for Windows（MinGW）](https://en.wikipedia.org/wiki/MinGW)。前者（MSVC）由微软开发并维护，采用特定的应用二进制接口（ABI）；后者（MinGW）则将 GNU 软件套件移植到 Windows 上，拥有自己独立的 ABI——这意味着为 MSVC 编译的产物与为 MinGW 编译的产物彼此不兼容。

Unfortunately, Go only uses MinGW, while Rust only has support for MSVC on ARM. This meant that we could not link the two languages. Fortunately, Windows on ARM comes with x86-64 emulation, so we could release an x86-64 binary for Windows and let the operating system work its magic to have it run on ARM. There is a performance impact associated, but only until we reach a full Rust binary, or Rust releases a MinGW ARM target.

遗憾的是，Go 仅支持 MinGW 工具链，而 Rust 在 ARM 架构上仅支持 MSVC。这导致我们无法将 Go 与 Rust 代码进行链接。幸运的是，Windows on ARM 内置了 x86-64 指令集模拟功能，因此我们可以为 Windows 发布一个 x86-64 架构的二进制文件，并交由操作系统自动完成在 ARM 设备上的运行。这会带来一定的性能开销，但仅是过渡期权宜之计——待我们最终迁移到纯 Rust 二进制，或 Rust 官方正式发布 MinGW ARM 目标平台支持后，该问题即可彻底解决。

### C Dependencies

### C 依赖项

The second challenge arose when using C dependencies within our Rust code. The process of native compilation typically involves compilers creating object files, which are then linked—or combined—together to form a binary. However, in our case, `turborepo-ffi` is compiled into an object file, not a binary. As a result, it can't directly link its own C dependencies.

第二个挑战出现在 Rust 代码中引入 C 依赖项时。原生编译过程通常包含：编译器生成目标文件（object files），再经链接器将这些目标文件“链接”（即合并）为最终可执行二进制。然而，在我们的场景中，`turborepo-ffi` 被编译为单个目标文件，而非完整二进制；因此，它无法直接链接自身所依赖的 C 库。

Let's [take `zlib` as an example](https://www.zlib.net/). If `turborepo-ffi` uses `zlib` as a C dependency, it doesn't directly link `zlib` within its own object file. Instead, it expects that when you integrate `turborepo-ffi` into a binary (in this case, the Go binary) you'll also supply it with an object file containing the compiled version of `zlib`. This expectation arises from the fact that C static libraries are not standalone entities but are designed to be inputs to a linker, serving as building blocks in the creation of a binary.

以 [`zlib`](https://www.zlib.net/) 为例：若 `turborepo-ffi` 依赖 `zlib` 这一 C 库，它并不会在自身的目标文件中直接嵌入或链接 `zlib`；相反，它期望——当你将 `turborepo-ffi` 集成进某个二进制（此处即 Go 二进制）时——你同时提供一份已编译好的 `zlib` 目标文件。这种设计源于 C 静态库的本质：它们并非自包含的独立实体，而是专为链接器准备的输入，作为构建最终二进制的“积木块”。

![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_009.jpg)![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_010.jpg)

![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_009.jpg)![](images/using-zig-in-our-incremental-turborepo-migration-from-go-to-rust-vercel/img_010.jpg)

Okay, understood, don’t use C dependencies in `turborepo-ffi`. Well, that’s not so easy. Many libraries such as `git2` and `openssl` use C dependencies. Even Rust itself uses C dependencies! To handle stack unwinding after a panic, Rust uses a library called `libunwind`. There’s no escaping C no matter how hard you try.

明白了，那就别在 `turborepo-ffi` 中使用 C 依赖项好了。——话虽如此，实际操作却远非易事。大量常用库（例如 `git2`、`openssl`）均依赖 C 代码；甚至 Rust 自身也离不开 C 依赖！例如，Rust 在发生 panic 后执行栈展开（stack unwinding）时，就依赖名为 `libunwind` 的 C 库。无论你如何努力规避，C 语言始终如影随形，无可回避。

As we’ve emphasized before, this is all much simpler with native compilation. Either the pre-built libraries are already installed on your computer, or they’re easily installable with your system package manager (`apt-get`, `brew`, `apk`, etc.).

正如我们此前反复强调的那样，若采用原生编译方式，这一切都会简单得多：所需预编译库要么已预装于你的系统中，要么只需借助系统包管理器（如 `apt-get`、`brew`、`apk` 等）即可轻松安装。

With cross-compilation, this all goes out the window. You can’t easily install pre-built libraries for different platforms than your native one. You can build from source (more cross-compilation!) but C compilers are not usually the greatest at statically linked cross-compilation.

在交叉编译环境下，上述便利性全部失效。你无法轻松地为不同于本机平台的其他目标平台安装预构建的库。虽然你可以从源码构建（又是一轮交叉编译！），但 C 编译器通常并不擅长静态链接式的交叉编译。

But it turns out there’s an exception.

但事实证明，存在一个例外。

## Enter `zig cc`

## 引入 `zig cc`

You may have heard of Zig, a new systems programming language that’s been gaining some adoption recently. It’s fast, simple, and most importantly, has great interoperability with C. So much so, that it actually comes with its own C compiler, `zig cc`.

你可能听说过 Zig——一门新兴的系统编程语言，近年来正逐步获得开发者采用。它运行快速、设计简洁，最重要的是，与 C 语言具有极佳的互操作性。其互操作能力之强，以至于 Zig 自带了一个 C 编译器：`zig cc`。

But `zig cc` is no ordinary C compiler. It’s a C compiler that has **easy, out-of-the-box support for cross-compilation**. As we just saw, cross-compilation in C is quite painful, requiring installing a compiler for a specific target (or building it from source), finding versions of libraries for the target platform, and writing a whole lot of compiler flag magic.

但 `zig cc` 并非普通的 C 编译器。它是一款**开箱即用、原生支持便捷交叉编译**的 C 编译器。正如我们刚才所见，C 语言的交叉编译过程相当痛苦：你需要为特定目标平台安装专用编译器（或从源码自行构建）、寻找适配该目标平台的库版本，还要编写大量晦涩难懂的编译器标志（flag）。

Erasing all of these concerns practically made us jump with joy. `zig cc` even comes with a nice long list of targets that it handles out of the box, with bundled libraries—including, you guessed it, all of the targets that we need to build!

消除所有这些顾虑，几乎让我们欣喜若狂。`zig cc` 甚至内置了一份详尽的目标平台列表，开箱即支持完整交叉编译流程（含配套库）——没错，其中就包括我们所需构建的所有目标平台！

I’ll admit, there was some skepticism about using Zig to build our codebase. Would using Zig _and_ Go _and_ Rust be too much programmer hipsterism? Would Hacker News and developer Twitter judge us too harshly?

我必须承认，起初我们对使用 Zig 构建代码库确实心存疑虑：同时使用 Zig、Go 和 Rust，是否显得过于“程序员式小众炫技”？Hacker News 和开发者圈的 Twitter 是否会对我们过于苛刻地评头论足？

But the ultimate test is whether the code works. And indeed it worked! Zig allowed us to build our Go sandwich for all our supported platforms, including the C dependencies. Zig is even smart enough to bundle a platform-specific version of `libunwind`, so all you have to do is pass the flag `-lunwind` and it’ll just work.

但最终检验标准只有一个：代码能否正常工作。而事实证明，它真的成功了！Zig 帮助我们为所有受支持平台构建出了完整的 “Go sandwich”，包括其中的 C 依赖项。Zig 甚至足够智能，能自动打包对应平台版本的 `libunwind`；你只需传入 `-lunwind` 标志，一切即可无缝运行。

On the Go side, we had to pass some flags to indicate that instead of Go linking everything, we wanted to rely on an external linker, i.e. Zig. The [magic combination](https://github.com/vercel/turbo/blob/main/cli/cross-release.yml#L34) here was `linkmode external -extldflags="-static"`.

在 Go 一侧，我们需要传入若干标志，以明确告知 Go：不要使用其默认链接器完成全部链接工作，而是交由外部链接器（即 Zig）来处理。此处的[关键组合](https://github.com/vercel/turbo/blob/main/cli/cross-release.yml#L34)是：`linkmode external -extldflags="-static"`。

With the help of just _one more_ language toolchain, we were able to ship our Go sandwich to our users and continue on our porting journey. The first version of `turbo` that shipped with the Go sandwich was [version 1.8.6](https://github.com/vercel/turbo/releases/tag/v1.8.4).

借助**仅仅一种额外的语言工具链**，我们便成功将 “Go sandwich” 发布给用户，并持续推进我们的移植工作。首个搭载 “Go sandwich” 的 `turbo` 版本是 [1.8.6 版](https://github.com/vercel/turbo/releases/tag/v1.8.4)。

## Why all the effort?

## 为何要付出如此多的努力？

This may seem like a lot of complexity to accommodate a port—an entire new toolchain along with `protobuf` is nothing to sneeze at—but it allowed us to fulfill our top-line goal: keep shipping code to users. A complete rewrite would have stalled the release of new features for months and risked accumulating unused code. No matter how much testing, no matter how rigorous your type system, code that is not used is code that is ripe for bugs. The Go sandwich ensured that as we ported code, each new piece was actively used and validated.

这看似为适配一次移植而引入了大量复杂性——整套新工具链，再加上 `protobuf`，绝非小事——但它使我们得以实现最核心的目标：持续向用户交付代码。若彻底重写，新功能的发布将被推迟数月，并可能积压大量未使用的代码。无论测试多么充分、类型系统多么严谨，未被使用的代码恰恰是最容易滋生缺陷的代码。所谓“Go 三明治”（Go sandwich）策略确保了：在代码移植过程中，每一处新增代码都处于活跃使用与实际验证之中。

Vercel.com landing page

Vercel.com 首页

### Visit turborepo.com

### 访问 turborepo.com

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### This is an official starter Turborepo with two Next.js sites and three local packages

### 这是一个官方入门级 Turborepo 项目，包含两个 Next.js 站点和三个本地包

Turborepo & Next.js Starter

Turborepo 与 Next.js 入门模板
&#123;% endraw %}
