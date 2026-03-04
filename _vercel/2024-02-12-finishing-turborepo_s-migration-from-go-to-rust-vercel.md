---
title: "Finishing Turborepo's migration from Go to Rust - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/finishing-turborepos-migration-from-go-to-rust"
date: "2024-02-12"
scraped_at: "2026-03-02T09:47:46.285031242+00:00"
language: "en-zh"
translated: true
description: "We've finished porting Turborepo, the high performance JavaScript and TypeScript build system, from Go to Rust."
---

render_with_liquid: false
Feb 12, 2024

2024 年 2 月 12 日

以基于 Rust 的 Turbo 解锁构建系统的未来。

我们已完成将 [Turborepo（高性能 JavaScript 和 TypeScript 构建系统）](https://turbo.build/) 从 Go 迁移至 Rust 的全部工作。此举为 Turbo 奠定了更优性能、更高稳定性以及强大新功能的基础。

![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_001.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_001.jpg)

以下是我们完成此次迁移并发布首个全 Rust 版本 `turbo` 的过程。

## 自上次以来

在[上一篇文章](https://vercel.com/blog/how-we-continued-porting-turborepo-to-rust)结尾处，我们已完成了“Rust–Go–Rust 三明治”架构（简称“Go 三明治”），并在 Zig 的协助下发布了该版本。“三明治”架构使我们得以持续增量式地将 Turborepo 的各个模块逐一迁移至 Rust。此后，我们又完成了更多组件的迁移，例如：

- 文件哈希（File Hashing）：Turborepo 用于为代码仓库内容生成指纹（fingerprint）的机制，从而加速缓存比对。

- 锁文件分析（Lockfile analysis）：当代码仓库中安装的依赖发生变化时，Turborepo 需对此作出响应。

- [缓存签名验证（Cache Signature Verification）](https://turbo.build/repo/docs/core-concepts/remote-caching#artifact-integrity-and-authenticity-verification)：可将您自己的私钥加入文件哈希计算，为缓存产物提供额外的安全保障层。

## Reaching the limits of the Go sandwich

## 达到 Go “三明治”架构的极限

However, as we completed these components, we started to reach the limit of what the sandwich could handle. For example, mixing asynchronous, multi-threaded code across languages wasn’t going to be viable. The Go sandwich got us to this point but, with so much of our code now moved to Rust, the sandwich had fulfilled its purpose.

然而，随着这些组件的逐步完成，我们开始触及该“三明治”架构所能承载的极限。例如，跨语言混合使用异步、多线程代码将不可行。Go “三明治”架构助我们走到了这一步；但如今，我们大量代码已迁移至 Rust，“三明治”架构的历史使命已然达成。

Therefore, we decided to build what we called “the run outline,” an all-Rust version of our `run` command with most of the functionality stubbed out (replaced with a fake, simple version). We gated this behind a feature flag, so we could build it for our local versions but not ship it to users just yet.

因此，我们决定构建所谓“运行骨架”（run outline）——一个完全基于 Rust 实现的 `run` 命令版本，其中大部分功能暂以桩代码（stub）形式实现（即用简易、模拟的逻辑替代真实逻辑）。我们通过特性开关（feature flag）控制该版本：允许我们在本地构建并测试它，但暂不向用户发布。

It was time to complete the switch to all Rust.

是时候全面切换至 Rust 了。

### Building the package graph

### 构建包依赖图（package graph）

The first big piece that we added to our run outline was the package graph. The package graph is a graph data structure of all the packages in your Turborepo, where the graph’s nodes are your packages and the edges are the dependency relationships between them. This allows us to deeply understand your monorepo and cache work so you never do it twice.

我们向“运行骨架”中加入的第一个重要模块是包依赖图（package graph）。该图是一种图数据结构，用于表示 Turborepo 中所有包之间的关系：图中的节点代表各个包，边则代表包之间的依赖关系。借助这一结构，我们得以深入理解您的单体仓库（monorepo），并对构建任务进行缓存，确保相同工作永不重复执行。

![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_003.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_003.jpg)

![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_003.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_003.jpg)

When we ported the package graph, we noticed that Rust’s features allowed us to build better types that more accurately model your repository. For example, in Go, we designated the workspace root (where your lockfile lives) with a magic string (`//`). Package names were stored as strings, so to check for the workspace root, we checked if the name was equal to `//`.

在将包依赖图迁移到 Rust 的过程中，我们发现 Rust 的语言特性使我们能够构建更精准、更能准确刻画仓库结构的类型系统。例如，在 Go 中，我们使用一个“魔法字符串”（`//`）来标识工作区根目录（即 lockfile 所在位置）；包名则统一以字符串形式存储，因此判断某个包是否为工作区根目录时，只需检查其名称是否等于 `//`。

In Rust, we were able to model this as an enum. [Enums in Rust](https://doc.rust-lang.org/book/ch06-00-enums.html) allow you to create a type that could be one of multiple values. In this case, our package name could either be the root package or a different package with a name. We can model this as:

而在 Rust 中，我们可将其建模为一个枚举类型（enum）。[Rust 中的枚举](https://doc.rust-lang.org/book/ch06-00-enums.html)允许你定义一种可取多个不同值之一的类型。在此场景下，包名要么是根包（root package），要么是具有具体名称的其他包。我们可以将其建模如下：

```text
enum PackageName {

2  Root,

3  Other(String)

4}
```

这不仅更加高效，还能确保正确性。每当 Rust 代码中使用包名时，我们都必须显式处理工作区根目录（workspace root）这一特殊情况；否则编译器会报错。而在 Go 中，开发者则更容易倾向于直接使用字符串，并以临时、零散的方式处理各类边界情况，从而留下更多出错空间。

### `prune` 命令

在完成包依赖图（package graph）的构建后，我们便着手实现 `prune` 命令的纯 Rust 版本。`prune` 命令的作用是：从你的 Turborepo 中移除除指定单个包及其所有依赖之外的所有内容。例如，执行 `turbo prune web-app` 后，系统将在 `out` 目录下生成**仅包含**该 Web 应用本身及其依赖项的精简代码副本。

![一张图展示完整的抽象化单体仓库（monorepo），另一张有向图则展示对该 monorepo 执行 `turbo prune` 后得到的子集](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_005.jpg)  
![一张图展示完整的抽象化单体仓库（monorepo），另一张有向图则展示对该 monorepo 执行 `turbo prune` 后得到的子集](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_006.jpg)  
一张图展示完整的抽象化单体仓库（monorepo），另一张有向图则展示对该 monorepo 执行 \`turbo prune\` 后得到的子集

这一功能在构建 Docker 镜像时尤为实用——你可借此显著减小镜像体积。此外，我们也很期待在此命令基础上拓展更多功能，例如：利用裁剪后的 lockfile，仅安装你真正关心的应用所依赖的那些包。

幸运的是，我们此前已通过“夹心法”（sandwich approach）完成了大部分 lockfile 相关代码的迁移，因此只需将现有 Rust 模块有机整合即可。如果你查看对应的 [Pull Request](https://github.com/vercel/turbo/pull/5531)，会发现 `prune` 功能的合并过程非常顺利，迭代次数极少。这正得益于 Go “夹心层”的存在——它让我们得以在原有 Go 代码环境中逐步构建、验证并打磨 Rust 依赖模块。

## 为 `run` 命令哈希任务（Hashing tasks for the `run` command）

Once we had completed `prune`, we reached one of the core pieces of Turborepo: hashing. Hashing is what allows Turborepo to determine whether you have run a task already.

在完成 `prune` 后，我们进入了 Turborepo 的核心功能之一：哈希计算（hashing）。哈希计算使 Turborepo 能够判断某项任务是否已被执行过。

### What is hashing?

### 什么是哈希计算？

A hashing algorithm takes some data, and produces a single value, known as a hash. With a very high degree of probability, these hashes will be unique to the input data. You end up with a **fingerprint** of your data that can be quickly compared to other fingerprints.

哈希算法接收一段数据，并生成一个单一值，称为“哈希值（hash）”。在极高概率下，不同输入数据将产生不同的哈希值。最终，你得到的是数据的一个**指纹（fingerprint）**，该指纹可被快速与其他指纹进行比对。

This is advantageous since hashes can be created quickly and are easy to compare against each other. Hashing shows up in a lot of different places, whether that’s mapping keys to values in a hash map, efficiently storing different versions of your code in git, or safely storing passwords.

这一特性具有显著优势：哈希值生成速度快，且彼此之间易于比对。哈希计算广泛应用于各类场景，例如哈希映射（hash map）中键到值的映射、Git 中高效存储代码的不同版本，或安全地存储密码等。

### Hashing In Turborepo

### Turborepo 中的哈希计算

We use hashing to implement our cache. When you use [`turbo run`](https://turbo.build/repo/docs/reference/command-line-reference/run) , Turborepo takes all of the different inputs that goes into building your packages, like source code, environment variables, and dependencies, and sends them through the hashing algorithm.

我们利用哈希计算实现缓存机制。当你运行 [`turbo run`](https://turbo.build/repo/docs/reference/command-line-reference/run) 时，Turborepo 会收集构建各软件包所需的所有输入信息——例如源代码、环境变量和依赖项——并将它们统一送入哈希算法进行处理。

![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_007.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_007.jpg)

![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_007.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_007.jpg)

We do this at two levels:

我们从两个层级执行该过程：

- At the global level, we produce a hash that determines if you’ve changed something that affects  

- 在全局层级，我们生成一个哈希值，用于判定你是否修改了影响  

**the entire repository.**  

**整个代码仓库** 的内容。

- We also create many task hashes to determine if you’ve changed something for a specific task. The global hash is included in calculating these hashes so it can potentially change all of them.

- 我们还会为每个任务生成多个哈希值，以判断您是否针对某项特定任务进行了更改。全局哈希值会参与这些任务哈希的计算，因此它有可能导致所有任务哈希均发生变化。

To use these hashes for your cache, we store outputs of your task in a tar file, a special file type that compresses an entire folder into one file. We store that file in both the local filesystem and in [Vercel Remote Cache](https://vercel.com/docs/monorepos/remote-caching), indexed by this task hash.

为利用这些哈希值实现缓存，我们将任务的输出保存为一个 tar 文件——这是一种特殊文件格式，可将整个文件夹压缩为单个文件。该文件同时存储在本地文件系统和 [Vercel 远程缓存（Vercel Remote Cache）](https://vercel.com/docs/monorepos/remote-caching) 中，并以该任务哈希值作为索引。

When it comes time to run a task, we first produce this task hash, and check if it’s in either the filesystem or the Remote Cache. If it is, we restore the task’s outputs in milliseconds. Otherwise, we run the task and store the outputs in the cache for next time.

当需要执行某项任务时，我们首先生成该任务的哈希值，并检查其是否已存在于本地文件系统或远程缓存中。若存在，则可在毫秒级时间内恢复该任务的输出结果；否则，我们将实际运行该任务，并将输出结果存入缓存，供下次使用。

### Ensuring hash stability while porting `run` and `prune`

### 在迁移 `run` 和 `prune` 功能时确保哈希稳定性

When it came to porting the hashing code, we wanted the hashes to stay the same between Rust and Go. It doesn't make sense for Turborepo users to miss cache just because the language that was used to write the tool changed under the hood. We had to prioritize stability.

在迁移哈希计算代码时，我们希望 Rust 与 Go 版本生成的哈希值完全一致。对 Turborepo 用户而言，仅仅因为底层工具实现语言由一种切换为另一种，就导致缓存失效，这显然不合理。因此，我们必须将稳定性置于最高优先级。

To keep hashes stable, we turned to Capnproto, a cross-platform, cross-language serialization format that is defined byte for byte. Moreover, capnproto has great support for Go and Rust!

为保障哈希稳定性，我们采用了 Capnproto —— 一种跨平台、跨语言的序列化格式，其规范严格定义到每一个字节。此外，Capnproto 对 Go 和 Rust 均提供了出色的支持！

After refactoring our hashing code to use Capnproto for both Rust and Go, we set up our CI to run our tasks on both code paths and compare the two hashes. If they ever diverged, our CI would fail and we would need to make some fixes.

在将哈希计算逻辑重构为同时在 Rust 和 Go 中使用 Capnproto 后，我们在持续集成（CI）环境中配置了双路径测试：即分别在两种语言实现上运行相同任务，并比对二者生成的哈希值。一旦出现不一致，CI 将立即失败，提示我们需要进行修复。

## Reaching the finish line

## 冲刺终点

When we started running the hash comparison code, we weren’t surprised to find we had bugs. Some bugs were minor, like ensuring `null` values contribute to the hash correctly. However, some bugs were more foundational like detecting which packages had changes or handling the `--filter` flag so you can only do the work you're looking for.

当我们开始运行哈希比对代码时，并不意外地发现了若干缺陷。其中一些属于轻微问题，例如确保 `null` 值能被正确纳入哈希计算；而另一些则更为根本，比如准确识别哪些包发生了变更，或正确处理 `--filter` 标志，从而仅执行您所关注的那部分工作。

We were glad to see our approach pay off here as these would have been incredibly difficult bugs to find otherwise. In the end, we were able to validate that our Rust hashing code was working and matched the Go behavior.

我们很高兴看到这一方法在此处取得了成效——否则，上述缺陷将极难被发现。最终，我们成功验证了 Rust 版本的哈希计算代码功能正常，且行为与 Go 版本完全一致。

![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_009.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_009.jpg)

![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_009.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_009.jpg)

Overall, this approach really paid off for us. We found a lot of bugs that otherwise we would have struggled to find. We were able to validate that our code was working and matched the Go behavior.

总体而言，这一方法为我们带来了显著回报。我们发现了大量原本难以定位的缺陷，并成功验证了 Rust 代码的功能正确性，确保其行为与 Go 版本完全一致。

## Dogfooding our way to a release

## 通过“自用”（Dogfooding）推进发布

At this point, we had ported enough code to run our tasks in our own CI behind a `--experimental-rust-codepath` flag. We began running our integration tests on the Rust codepath and burning down the test failures until we matched the Go version, log line for log line, output for output. Once all our tests were passing, we published a canary version and used it in Vercel’s internal monorepo. Once we reached 72 hours of no reported errors, we shipped Turborepo 1.11!

此时，我们已迁移了足够多的代码，可在内部 CI 中通过 `--experimental-rust-codepath` 标志启用 Rust 代码路径来执行各项任务。我们开始在 Rust 代码路径上运行集成测试，并逐一修复失败项，直至其日志输出逐行、结果输出逐项均与 Go 版本完全一致。待全部测试通过后，我们发布了预发布（canary）版本，并将其部署至 Vercel 内部的单体仓库（monorepo）中使用。在连续 72 小时未收到任何错误报告后，我们正式发布了 Turborepo 1.11！

## What we learned

## 我们的收获与反思

Looking back, the port was a major success. We managed to port about 70k lines of Go to Rust in 15 months with minimal disruption to users. Our porting strategies such as the Rust shim and the Go sandwich allowed us to incrementally port code for as long as possible.

回望整个迁移过程，这无疑是一次重大成功：我们在 15 个月内将约 7 万行 Go 代码迁移至 Rust，且对用户影响微乎其微。“Rust 填充层”（Rust shim）和“Go 三明治”（Go sandwich）等迁移策略，使我们得以尽可能长时间地以渐进方式完成代码迁移。

With that said, there are probably a few things we would have done differently with our newfound knowledge:

话虽如此，基于当前积累的新认知，我们或许会在以下几个方面做出不同选择：

- Invest in a single serialization format from the start. We took an iterative approach, starting with JSON, then using Protocol Buffers, and finally finishing with Capnproto. In the end, we realized that Capnproto would have served us best right from the beginning. We only discovered its value for our case near the end.

- 从项目伊始就选定并统一采用一种序列化格式。我们最初采取了迭代演进的方式：先使用 JSON，再切换为 Protocol Buffers，最终才落地为 Capnproto。但最终我们意识到，Capnproto 其实从一开始就最契合我们的需求——而这一认知，直到项目后期才真正形成。

- Ship each porting strategy faster. We waited a little too long to figure out our release strategy for the Rust shim and the Go sandwich. This meant that there were times where we had ported code that we could not ship to users due to release management bugs. If we had shipped an absolutely minimal version of each porting strategy as early as possible, we wouldn't have had these issues.

- 更早、更快地交付每种迁移策略。我们花费了过长时间才厘清“Rust 填充层”和“Go 三明治”的发布策略，导致部分已完成迁移的代码因发布管理环节的缺陷而迟迟无法面向用户发布。倘若我们能尽早交付每种策略的极简可用版本，此类问题本可避免。

- Realize the importance of code quality **before** porting. By and large, our Go code was in a good state with comprehensive testing and a fairly straightforward architecture. However, we came in thinking that we could refactor while porting, but that turned out not to be the case. Looking back, we might have been able to port faster had we improved our testing story and removed some bloat from the Go code before we started.

- 在启动迁移前，就充分认识到代码质量的关键意义。总体而言，我们的 Go 代码基础良好：测试覆盖全面，架构也相对清晰简洁。然而，我们起初误以为可以在迁移过程中同步重构，实践证明这并不可行。复盘来看，若能在迁移启动前进一步完善测试体系、精简 Go 代码中的冗余逻辑，迁移进程本可更加高效。

- 完全明确核心 Turborepo 行为，例如通配符匹配（globbing）、文件监听（file watching）和哈希计算（hashing）。在迁移过程中，我们发现许多场景下，Go 代码中这些行为究竟是有意设计还是偶然结果并不清晰。若此前已有明确定义和测试覆盖，将有助于提前识别这些当时未被文档记录、也未经测试的边缘情况——而如今，这些行为已在 Rust 中被正式固化。此外，我们本可借此进一步夯实跨平台支持能力，尤其是针对 Windows 平台的测试。

## The future of Turbo

## Turbo 的未来

我们对 Rust 将为 Turborepo 和 Turbopack 用户带来的未来前景感到无比振奋。每一天，我们都在发现新的机会：打造卓越功能、保障代码库更稳定的运行表现，并让您的 CI 流水线比以往任何时候都更加迅捷。

我们同样期待将 Turborepo 更深度地集成进 [Vercel 开发者体验平台（Vercel Developer Experience Platform）](https://vercel.com/products/dx-platform)。随着 [Conformance（合规性检查）与 Code Owners（代码负责人）功能的近期发布](https://vercel.com/blog/introducing-conformance)，工程团队即使在代码库持续扩大的情况下，也能更快地交付更高品质的代码。

![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_011.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_012.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_011.jpg)![](images/finishing-turborepo_s-migration-from-go-to-rust-vercel/img_012.jpg)

Vercel.com 首页

### Visit turborepo.com

### 访问 turborepo.com

Vercel 模板

部署此模板

### This is an official starter Turborepo with two Next.js sites and three local packages

### 这是一个官方入门级 Turborepo 示例，包含两个 Next.js 站点和三个本地包

Turborepo & Next.js Starter

Turborepo 与 Next.js 入门模板