---
title: "How we used Codex to build Sora for Android in 28 days | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/shipping-sora-for-android-with-codex"
date: "2025-12-12"
scraped_at: "2026-03-02T10:08:50.085100342+00:00"
language: "en-US"
translated: true
description: "OpenAI shipped Sora for Android in 28 days using Codex. AI-assisted planning, translation, and parallel coding workflows helped a nimble team deliver rapid, reliable development."
---
&#123;% raw %}

December 12, 2025

2025年12月12日

[Engineering](https://openai.com/news/engineering/) [Company](https://openai.com/news/company-announcements/)

[工程](https://openai.com/news/engineering/) [公司公告](https://openai.com/news/company-announcements/)

# How we used Codex to build Sora for Android in 28 days

# 我们如何借助 Codex 在 28 天内构建出 Sora 的 Android 版应用

By Patrick Hum and RJ Marsan, Members of the Technical Staff

作者：Patrick Hum 与 RJ Marsan，技术团队成员

In November, we launched the Sora Android app to the world, giving anyone with an Android device the ability to turn a short prompt into a vivid video. On launch day, the app reached #1 in the Play Store. Android users generated more than a million videos in the first 24 hours.

今年 11 月，我们向全球发布了 Sora Android 应用，让任何拥有 Android 设备的用户都能仅凭一段简短提示词，生成生动逼真的视频。发布当日，该应用即登顶 Google Play 商店排行榜首位；Android 用户在上线首 24 小时内便生成了逾百万条视频。

Behind the launch is a story: the initial version of Sora’s production Android app was built in 28 days, thanks to the same agent that’s available to any team or developer: Codex.

此次发布的背后，是一个引人注目的故事：Sora 生产环境级 Android 应用的初版，仅耗时 28 天即完成开发——而这正是得益于面向所有团队与开发者开放的同一智能体：Codex。

From October 8 to November 5, 2025, a lean engineering team working alongside Codex and consuming roughly 5 billion tokens, shipped Sora for Android from prototype to global launch. Despite its scale, the app has a crash-free rate of 99.9 percent and an architecture we’re proud of. If you’re wondering whether we used a secret model, we used an early version of the GPT‑5.1‑Codex model – the same version that any developer or business can use today via CLI, IDE extension, or web app.

2025 年 10 月 8 日至 11 月 5 日间，一支精干的工程团队协同 Codex 共同工作，消耗约 50 亿 token，便将 Sora Android 应用从原型快速推进至全球正式发布。尽管应用规模可观，其无崩溃率仍高达 99.9%，且整体架构令我们深感自豪。若您好奇我们是否动用了某种“内部专属模型”，答案是否定的：我们使用的是 GPT‑5.1‑Codex 模型的早期版本——该版本目前已全面开放，任何开发者或企业均可通过命令行界面（CLI）、IDE 插件或网页应用直接调用。

Prompt: figure skater performs a triple axle with a cat on her head

提示词：一名花样滑冰运动员头顶一只猫，完成一个三周半跳（Triple Axel）

#### Embracing Brooks’ Law: Staying nimble to move fast

#### 拥抱布鲁克斯定律：以敏捷应变实现高速交付

When Sora launched on iOS, usage exploded. People immediately began generating a stream of videos. On Android, by contrast, we had only a small internal prototype and a mounting number of pre-registered users on Google Play.

Sora 在 iOS 平台上线后，用户使用量激增。人们立刻开始持续生成大量视频。相比之下，在 Android 平台，我们当时仅有一个小型内部原型，而 Google Play 上预注册用户的数量却与日俱增。

A common response to a high stakes, time-pressured launch is to pile on resources and add process. A production app of this scope and quality would typically involve many engineers working for months, slowed down by coordination.

面对高风险、强时效性的发布任务，一种常见应对方式是堆叠人力、增加流程。通常，一个达到同等规模与质量要求的生产级应用，需要多名工程师协作数月之久，而协调成本往往会拖慢整体进度。

American computer architect Fred Brooks famously warned that “adding more people to a late software project makes it later.” In other words, when trying to ship a complex project quickly, adding more engineers can often slow down efficiency by adding to communication overhead, task fragmentation, and integration costs. We leaned into this insight instead of ignoring it; we assembled a strong team of four engineers – all equipped with Codex to drastically increase each engineer’s impact.

美国计算机架构师弗雷德·布鲁克斯（Fred Brooks）曾著名地警示：“向一个已延期的软件项目中增加人手，只会让它更加延期。”换言之，当试图快速交付一个复杂项目时，盲目增派工程师反而常因加剧沟通开销、任务碎片化及集成成本而降低整体效率。我们没有忽视这一洞见，而是主动将其作为指导原则：组建了一支由四名资深工程师构成的精干团队——每位成员均配备 Codex 工具，从而极大提升单个工程师的产出效能。

Working this way, we shipped an internal build of Sora for Android to employees in 18 days and launched publicly 10 days later. We maintained a high bar on Android engineering practices, invested in maintainability, and held the app to the same reliability bar we would expect from a more traditional project. (We also continue to use Codex extensively today to evolve and bring new features to the app).

采用这种工作方式，我们仅用 18 天便向内部员工交付了 Sora 的 Android 内部版本，并于 10 天后正式面向公众发布。我们在 Android 工程实践中始终坚持高标准，高度重视可维护性投入，并将该应用的可靠性标准，严格对标于更传统的工程项目。（时至今日，我们仍在广泛使用 Codex，持续迭代应用并引入新功能。）

#### Onboarding a new senior engineer

#### 新晋高级工程师的入职引导

To make sense of how we worked with Codex, it helps to know where it shines and where it needs direction. Treating it like a newly hired senior engineer was a good approach. Codex’s ability meant we could spend more time directing and reviewing code than writing it ourselves.

要理解我们如何与 Codex 协同工作，关键在于厘清它的优势所在与需人工引导之处。将 Codex 视作一名刚入职的高级工程师，是一种行之有效的思路。正因其强大能力，我们得以将更多精力投入代码方向把控与审查环节，而非亲自动手编写。

**Where Codex needs guidance**

**Codex 需要人工引导的方面**

1. Codex isn’t yet great at inferring what it hasn’t been told (e.g., your preferred architecture patterns, product strategy, real user behavior, and internal norms or shortcuts).

1. Codex 尚不擅长推断那些它未曾被告知的信息（例如：你偏好的架构模式、产品战略、真实用户行为，以及团队内部规范或快捷实践）。

2. Similarly, Codex couldn’t see the app actually run: It couldn’t open Sora on a device, notice that a scroll felt off, or sense that a flow was confusing. Only our team could cover these experiential tasks.

2. 同样，Codex 无法真正“看到”应用的实际运行状态：它无法在设备上打开 Sora，无法察觉某处滚动体验生硬，也无法感知某个操作流程令人困惑。唯有我们的团队才能完成这些依赖实际体验的任务。

3. Each instance requires onboarding. Sharing context with clear goals, constraints, and guidance on “how we do things” was essential to making Codex execute well.

3. 每一次使用 Codex 均需进行“入职引导”。向其清晰传达目标、约束条件，以及关于“我们如何做事”的指导原则，是确保 Codex 高效执行的关键。

4. In the same vein, Codex struggled with deep architectural judgment: Left on its own, it might introduce an extra view model where we really wanted to extend an existing one or push logic into the UI layer that clearly belonged in a repository. Its instinct is to get something working, not to prioritize long‑term cleanliness.

4. 同理，Codex 在深层次架构判断方面仍显不足：若完全放任其自主决策，它可能在本应扩展已有 View Model 的场景下，错误地新建一个；或把本该置于 Repository 层的逻辑，错误地塞入 UI 层。它的本能是“先让功能跑起来”，而非优先保障长期代码整洁性。

We found it useful to have Codex create and maintain a generous amount of AGENT.md files throughout the codebase. This made it easy to apply the same guidance and best practices across sessions. For example, to ensure Codex wrote code in our style guidelines, we added the following to our top-level AGENTS.md:

我们发现，让 Codex 在整个代码库中创建并持续维护大量 `AGENT.md` 文件十分有益。这使得我们在不同会话间轻松复用统一的指导原则与最佳实践。例如，为确保 Codex 编写的代码符合我们的编码规范，我们在顶层 `AGENTS.md` 文件中加入了如下内容：

#### Plain Text

#### 纯文本

``1## Formatting and static checks

``1## 格式化与静态检查

2- **提交前务必运行** `./gradlew detektFix`（或仅对受影响的模块执行该命令）。若存在格式化问题或 detekt 检查失败，CI 将直接报错。

2- **提交前务必运行** `./gradlew detektFix`（或仅对受影响的模块执行该命令）。若存在格式化问题或 detekt 检查失败，CI 将直接报错。

**Where Codex excels**

**Codex 的优势所在**

1. Reading and understanding large codebases rapidly: Codex knows essentially all major programming languages, which makes it easier to leverage the same concepts across many platforms without complex abstractions.

1. 快速阅读与理解大型代码库：Codex 精通几乎所有主流编程语言，这使得我们无需借助复杂抽象，即可在多个平台间复用相同概念。

2. Testing coverage: Codex is (uniquely) enthusiastic about writing unit tests to cover a broad variety of cases. Not every test was deep, but having breadth of coverage was helpful in preventing regressions.

2. 测试覆盖率：Codex（尤为独特地）热衷于编写单元测试，以覆盖大量不同场景。尽管并非每个测试都深入底层，但广度上的覆盖对防止回归缺陷极为有效。

3. Applying feedback: In a similar vein, Codex is good at reacting to feedback. When CI failed, we could paste log output into a prompt and ask Codex to propose fixes.

3. 响应反馈：同理，Codex 擅长响应反馈。当 CI 构建失败时，我们可以将日志输出粘贴至提示词中，要求 Codex 提出修复建议。

4. Massively parallel, disposable execution: Most won’t push the limits of the number of sessions they could actually run at any one time. It’s highly feasible to test multiple ideas in parallel and view code as disposable.

4. 高度并行、可弃置的执行方式：多数人并不会触及单次可运行会话数的上限。因此，完全可行地并行验证多种思路，并将代码视为可随时丢弃的临时产物。

5. Offering new perspective: In design discussions, we used Codex as a generative tool to explore potential failure points and discover new ways to solve a problem. For example, while we designed video player memory optimizations, Codex sifted through multiple SDKs to propose approaches we wouldn’t have had time to parse. The insights from Codex’s research proved invaluable in minimizing memory footprint in the final app.

5. 提供全新视角：在设计讨论中，我们将 Codex 作为生成式工具，用于探索潜在的失败点并发现解决问题的新路径。例如，在设计视频播放器内存优化方案时，Codex 快速梳理了多个 SDK，提出了我们本无暇深入研读的可行方案。Codex 研究所得的洞见，对最终应用内存占用的最小化起到了关键作用。

6. Enabling higher‑leverage work: In practice, we ended up spending more time reviewing and directing code than writing it ourselves. That said, Codex is very good at code review, too, often catching bugs before they’re merged, improving reliability.

6. 支撑更高杠杆价值的工作：实践中，我们花在代码审查与方向引导上的时间，远超亲自编写代码的时间。值得一提的是，Codex 在代码审查方面同样表现出色，常常能在代码合入前就发现潜在缺陷，从而提升系统可靠性。

Once we acknowledged these characteristics, our working model became more straightforward. We leaned on Codex to do a huge amount of heavy lifting inside well‑understood patterns and well‑bounded scopes, while our team focused on architecture, user experience, systemic changes, and final quality.

一旦我们明确了这些特性，我们的协作模式便愈发清晰：我们让 Codex 在已充分理解的设计模式和边界明确的任务范围内承担大量繁重工作；而团队则专注于架构设计、用户体验、系统性变更以及最终质量把控。

#### Laying the foundation by hand

#### 手动夯实基础

Even the best new, senior hire doesn’t have the right vantage point for making long-term trade-offs right away. To leverage Codex and ensure its work was robust and maintainable, it was key that we oversaw the app’s systems design and key trade-offs ourselves. These included shaping the app’s architecture, modularization, dependency injection, and navigation; we also implemented authentication and base networking flows.

即便是最优秀的新晋高级工程师，也无法在入职初期就具备做出长期权衡决策所需的全局视角。为充分发挥 Codex 的能力，并确保其产出稳健且易于维护，我们必须亲自主导应用的系统设计与关键权衡决策——包括整体架构设计、模块化策略、依赖注入方案及导航机制；同时，我们也亲手实现了身份认证与基础网络通信流程。

From this foundation, we wrote a few representative features end‑to‑end. We used the rules we wanted the entire codebase to follow and documented project‑wide patterns as we went. By pointing Codex to representative features, it was able to work more independently within our standards. For a project that we estimate was 85% written by Codex, a carefully planned foundation avoided costly backtracking and refactoring. It was one of the most important decisions we made.

在此基础上，我们端到端地手写了若干典型功能模块。过程中，我们贯彻了希望整个代码库遵循的规范，并同步记录了项目级的设计模式。通过向 Codex 提供这些代表性功能作为参考，它得以更独立地在其标准框架内开展工作。对于一个我们估算约 85% 由 Codex 编写的项目而言，这一精心规划的基础建设，成功避免了高昂的返工与重构成本——这也是我们所做过的最重要决策之一。

The idea was not to make “something that works” as quickly as possible, rather to make “something that gets how we want things to work.” There are many “correct” ways to write code. We didn’t need to tell Codex exactly what to do; we needed to show Codex what’s “correct” on our team. Once we had established our starting point and how we liked to build, Codex was ready to start.

我们的目标并非“尽快做出能跑通的东西”，而是“做出真正体现我们期望工作方式的东西”。编写代码的方式本就多种多样，且皆可称为“正确”。我们无需事无巨细地告诉 Codex 具体该怎么做；我们需要做的，是向 Codex 展示——在我们团队语境下，什么才是“正确”的。一旦我们确立了起点与偏好的构建方式，Codex 便已准备就绪，可以正式开始了。

To see what would happen, we did try prompting: “Build the Sora Android app based on the iOS code. Go,” but quickly aborted that path. While what Codex created technically worked, the product experience was sub-par. And without a clear understanding of endpoints, data, and user flows, Codex’s single-shot code was unreliable (Even without using an agent, it’s risky to merge thousands of lines of code.)

我们曾尝试输入提示词：“基于 iOS 代码构建 Sora Android 应用。开始吧。”以观察结果，但很快便中止了这一路径。尽管 Codex 生成的代码在技术上可以运行，但产品体验却差强人意。而且，由于 Codex 缺乏对端点、数据结构及用户流程的清晰理解，其一次性生成的代码并不可靠（即使不借助智能体，直接合并数千行代码也存在显著风险）。

We hypothesized Codex would thrive in a sandbox of well-written examples; and we were right. Asking Codex to “build this settings screen” with almost no context was unreliable. Asking Codex to “build this settings screen using the same architecture and patterns as this other screen you just saw” worked far better. Humans made the structural decisions and set the invariants; Codex then filled in large amounts of code inside that structure.

我们假设 Codex 在高质量示例构成的“沙盒”环境中将表现更佳；事实证明我们的假设是正确的。仅凭极少上下文就让 Codex “构建这个设置页面”，结果并不可靠；而若提示它“参照你刚刚看到的另一个页面所采用的相同架构与设计模式来构建这个设置页面”，效果则明显更好。人类负责做出结构性决策并确立系统不变量（invariants），Codex 则在此框架内填充大量具体实现代码。

#### Planning with Codex before coding

#### 编码前与 Codex 共同规划

Our next step in maximizing Codex’s potential was figuring out how to enable Codex to work for long periods of time (recently, [more than 24 hours⁠](https://openai.com/index/gpt-5-1-codex-max/)), unsupervised.

充分发挥 Codex 潜力的下一步，是探索如何使其能在无人监督的情况下持续工作较长时间（近期已实现[连续运行超 24 小时](https://openai.com/index/gpt-5-1-codex-max/)）。

Early on in using Codex, we jumped to prompts like, “Here is the feature. Here are some files. Please build it.” That sometimes worked, but mostly produced code that technically compiled, while straying from our architecture and goals.

早期使用 Codex 时，我们常直接给出类似这样的提示：“这是要实现的功能，这些是相关文件，请完成构建。”这种方式偶有奏效，但多数情况下生成的代码虽能通过编译，却偏离了我们的架构设计与业务目标。

So we changed the workflow. For any non‑trivial change, we first asked Codex to help us understand how the system and code work. For example, we’d ask it to read a set of related files and summarize how that feature works; for example, how data flows from the API through the repository layer, the view model, and into the UI. Then we would correct or refine its understanding. (For example, we’d point out that a particular abstraction really belongs in a different layer or that a given class exists only for offline mode and should not be extended.)

因此，我们调整了工作流程：对于任何非微小的变更，我们首先请 Codex 协助我们理解系统与代码的运作机制。例如，我们会要求它阅读一组相关文件，并总结该功能的实现逻辑——比如数据如何从 API 经由仓库层（repository layer）、视图模型（view model），最终流向用户界面（UI）。随后，我们再对其理解进行校正或细化。（例如，指出某项抽象本应归属另一层，或某个类仅为离线模式而设，不应被扩展。）

Similarly to how you might engage a new, highly capable teammate, we worked with Codex to create a solid implementation plan. That plan often looked like a miniature design document directing which files should change, what new states should be introduced, and how logic should flow. Only then did we ask Codex to start applying the plan, one step at a time. One helpful tip: for very long tasks, where we hit the limit of our context window, we’d ask Codex to save its plan to a file, allowing us to apply the same direction across instances.

这类似于你与一位新加入、能力极强的团队成员协作的方式：我们与 Codex 共同制定了一份扎实的实施计划。该计划通常形如一份微型设计文档，明确指出哪些文件需要修改、需引入哪些新状态，以及逻辑应如何流转。只有在完成该计划后，我们才请 Codex 开始逐步落实。一个实用技巧是：面对极其耗时的任务（超出当前上下文窗口容量时），我们会要求 Codex 将计划保存至文件，从而确保跨会话保持一致的执行方向。

This extra planning loop turned out to be worth the time. It allowed us to let Codex run “unsupervised” for long stretches, because we knew its plans. It made code review easier, because we could check the implementation against our plan rather than reading a diff without context. And when something went wrong, we could debug the plan first and the code second.

这一额外的规划环节最终被证明物有所值。它使我们得以放心让 Codex 在较长时段内“无人监督”地运行，因为我们始终掌握其计划内容；它也让代码评审变得更为轻松——我们可依据计划核查实现，而非在缺乏上下文的情况下逐行审阅差异（diff）；当问题发生时，我们也能优先调试计划本身，其次才是具体代码。

The dynamic felt similar to the way a good design document gives a tech lead confidence in a project. We weren’t just generating code: we were producing code that supported a shared roadmap.

这种协作动态，与一份优秀的设计文档赋予技术负责人项目信心的方式颇为相似。我们所做的，远不止于生成代码——我们产出的是支撑共同技术路线图的代码。

#### Distributed engineering

#### 分布式工程

At the peak of the project, we were often running multiple Codex sessions in parallel. One was working on playback, another on search, another on error handling, and sometimes another on tests or refactors. It felt less like using a tool and more like managing a team.

项目高峰期，我们常常并行运行多个 Codex 会话：一个负责播放功能，一个负责搜索功能，一个负责错误处理，有时还有一个专门负责测试或重构。这种体验已不再像是在使用一款工具，而更像是在管理一支团队。

Each session would periodically report back to us with progress. One might say, “I’m done planning out this module; here’s what I propose,” while another would offer a large diff for a new feature. Each required attention, feedback, and review. It was uncannily similar to being a tech lead with several new engineers, all making progress, all needing guidance.

每个会话都会定期向我们汇报进展。例如，一个会话可能说：“我已完成该模块的设计规划，这是我的方案建议”；另一个则可能提交一份涵盖新功能的大型代码差异（diff）。每个会话都需要我们投入关注、给予反馈并进行审查。这种协作方式与担任技术负责人、带领数名新工程师同步推进工作、为他们提供指导的情形惊人地相似。

The result was a collaborative flow. Codex’s raw coding capability freed us from a lot of manual typing. We had more time to think about architecture, read pull requests carefully, and test out the app.

最终形成了一种协同式开发流。Codex 强大的原生编码能力，使我们摆脱了大量重复性手动编码工作；我们因而拥有更多时间思考系统架构、细致审阅 Pull Request，以及对应用进行端到端测试。

At the same time, that extra speed meant we always had something waiting in our review queue. Codex didn’t get blocked by context switching, but we did. Our bottleneck in development shifted from writing code to making decisions, giving feedback, and integrating changes.

与此同时，这种额外的速度也意味着我们的代码审查队列中始终有任务在等待处理。Codex 不会因上下文切换而受阻，但我们人类会。开发过程中的瓶颈，已从“编写代码”悄然转变为“做出决策”“提供反馈”和“整合变更”。

This is where Brooks’s insights land in a new way. You can’t simply add Codex sessions and expect linear speedups any more than you can keep adding engineers to a project and expect the schedule to shrink linearly. Each additional “pair of hands,” even virtual ones, adds coordination overhead. We had become the conductor of an orchestra versus simply faster solo players.

此时，Brooks 的洞见以一种全新的方式应验了。你无法仅靠增加 Codex 会话数量就获得线性加速，正如你无法通过持续增派工程师来让项目工期按比例缩短一样。每多增加一双手——哪怕是虚拟的“双手”——都会带来额外的协调开销。我们已不再是更快的独奏者，而转变成了整个交响乐团的指挥。

#### Codex as a cross‑platform superpower

#### Codex：跨平台超级能力

We started our project with a huge stepping stone: Sora had already shipped on iOS. We frequently pointed Codex at the iOS and backend codebases to help it understand key requirements and constraints. Throughout the project we joked that we had reinvented the idea of a cross‑platform framework. Forget React Native or Flutter; _the future of cross‑platform is just Codex._

项目启动时，我们已拥有一块巨大的垫脚石：Sora 已在 iOS 平台正式发布。我们频繁地将 Codex 指向 iOS 和后端代码库，帮助它理解关键需求与约束条件。整个项目过程中，我们常开玩笑说，自己重新发明了“跨平台框架”的概念：忘掉 React Native 或 Flutter 吧；_跨平台的未来，就是 Codex。_

Beneath the quip are two principles:.

玩笑背后，蕴含着两条核心原则：

1. Logic is portable. Whether the code is written in Swift or Kotlin, the underlying application logic – data models, network calls, validation rules, business logic – are the same. Codex is very good at reading a Swift implementation and producing an equivalent in Kotlin that preserves semantics.

1. 逻辑具有可移植性。无论代码是用 Swift 还是 Kotlin 编写，其底层应用逻辑——数据模型、网络请求、校验规则、业务逻辑——本质上完全一致。Codex 擅长阅读 Swift 实现，并生成语义等价的 Kotlin 版本。

2. Concrete examples provide powerful context. A fresh Codex session that can see “here is exactly how this works on iOS” and “here is the Android architecture” is far more effective than one that’s only working from natural language descriptions.

2. 具体示例能提供强大的上下文。一个全新的 Codex 会话，若能同时看到“iOS 上这一功能的确切实现方式”和“Android 端的架构设计”，其效果远胜于仅依赖自然语言描述开展工作的会话。

Putting these principles to work, we made the iOS, backend and Android repos available in the same environment. We gave Codex prompts like:

我们基于这两条原则展开实践：将 iOS、后端和 Android 三个代码仓库统一纳入同一开发环境。我们向 Codex 提供如下形式的提示（prompt）：

“Read these models and endpoints in the iOS code and then propose a plan to implement the equivalent behavior on Android using our existing API client and model classes.”

“请先阅读 iOS 代码中的这些模型和端点，然后提出一个方案，利用我们现有的 API 客户端和模型类，在 Android 上实现等效行为。”

One small but useful trick was to detail in  `~/.codex/AGENTS.md` where local repos lived and what they contained. That made it easier for Codex to discover and navigate relevant code.

一个虽小却十分实用的技巧是：在 `~/.codex/AGENTS.md` 文件中详细记录本地代码仓库的位置及其内容。这大大提升了 Codex 发现和导航相关代码的效率。

We were effectively doing cross-platform development through translation instead of shared abstraction. Because Codex handled most of the translation, we avoided doubling implementation costs.

我们实际上是以“翻译”而非“共享抽象”的方式开展跨平台开发。由于 Codex 承担了大部分翻译工作，我们成功避免了实现成本翻倍的问题。

The broader lesson is that for Codex, context is everything. Codex did its best work when it understood how the feature already worked in iOS, paired with an understanding of how our Android app was structured. When Codex lacked that context, it wasn’t “refusing to cooperate”; it was guessing. The more we treated it like a new teammate and invested in giving it the right inputs, the better it performed.

更深层的启示在于：对 Codex 而言，上下文就是一切。当 Codex 既理解该功能在 iOS 上的现有实现逻辑，又清楚我们 Android 应用的整体架构时，它才能发挥最佳水平。而当 Codex 缺乏这一上下文时，它并非“拒绝配合”，而是在盲目猜测。我们越将它视作一位新加入的团队成员，并越用心地为其提供准确、充分的输入信息，它的表现就越出色。

#### The software engineering of tomorrow, today

#### 今日实践明日之软件工程

By the end of our four‑week sprint, using Codex stopped feeling like an experiment and became our default development loop. We used it to understand existing code, plan changes, and implement features. We reviewed its output the same way we’d review a teammate’s. It was simply how we shipped software.

经过为期四周的冲刺开发，使用 Codex 已不再像一场实验，而成为我们默认的开发流程。我们用它来理解既有代码、规划变更、实现功能；我们以审阅队友代码的方式审阅它的输出。它已自然而然地融入我们的软件交付过程。

It became clear that AI‑assisted development does not reduce the need for rigor; it increases it. As capable as Codex is, its objective is to get from A to B, now. This is why AI-assisted coding doesn’t work without humans. Software engineers can understand and apply the real-world constraints of systems, the best ways to architect software, and how to build with future development and product plans in mind. The super powers of tomorrow’s software engineer will be deep systems understanding and the ability to work collaboratively with AI over long time horizons.

我们愈发清晰地认识到：AI 辅助开发非但没有降低对严谨性的要求，反而提高了这一要求。尽管 Codex 能力出众，但其目标始终是“立刻从 A 到达 B”。正因如此，脱离人类工程师的 AI 编程无法真正落地。软件工程师能够理解并应用系统在真实世界中的各种约束条件，掌握最优的软件架构方法，并能在构建当下功能时兼顾未来开发节奏与产品演进规划。未来软件工程师的核心超能力，将是深厚的系统级理解力，以及与 AI 在长期时间维度上协同工作的能力。

The most interesting parts of software engineering are building compelling products, designing scalable systems, writing complex algorithms, and experimenting with data, patterns, and code. However, the realities of software engineering of the past and present often lean more mundane: centering buttons, wiring endpoints, and writing boilerplate. Now, Codex makes it possible to focus on the most meaningful parts of software engineering and the reasons we love our craft.

软件工程中最富吸引力的部分，是打造令人信服的产品、设计可扩展的系统、编写复杂的算法，以及围绕数据、模式与代码展开探索性实验。然而，过去乃至当下的软件工程现实往往更为琐碎：居中按钮、对接接口、编写样板代码……如今，Codex 让我们得以重新聚焦于软件工程中最具意义的部分——也正是我们热爱这份职业的根本原因。

Once Codex is set up in a context-rich environment where it understands your goals and how you like to build, any team can multiply its capabilities. Our launch retro isn’t a one‑size‑fits‑all recipe, and we're not claiming to have solved AI‑assisted development. But we hope our experience makes it easier to find the best ways to empower Codex to empower you.

一旦 Codex 被部署在上下文丰富的环境中——即它能准确理解你的目标，以及你偏好的构建方式——任何团队都能成倍提升自身能力。本次发布复盘并非放之四海而皆准的通用配方，我们亦不宣称已彻底解决 AI 辅助开发的所有挑战。但我们衷心希望，我们的实践经验能助你更轻松地找到最适配的方式，让 Codex 成为你真正的赋能者。

When Codex launched in a research preview seven months ago, software engineering looked very different. Through Sora, we got to explore the next chapter of engineering. As our models and harness keep improving, AI will become an increasingly indispensable part of building.

七个月前 Codex 以研究预览版形式发布时，软件工程的面貌还截然不同。借助 Sora，我们得以率先探索工程实践的下一章。随着我们模型与运行框架（harness）持续迭代升级，AI 将日益成为软件构建过程中不可或缺的一环。

What will you make with your own team of Codex?

你将用属于你自己的 Codex 团队创造出什么？

- [Sora](https://openai.com/news/?tags=sora)  
- [Sora](https://openai.com/news/?tags=sora)  
- [2025](https://openai.com/news/?tags=2025)  
- [2025](https://openai.com/news/?tags=2025)

## Acknowledgements

## 致谢

_Special thanks to the entire team that helped build Sora for Android._

_特别感谢为 Android 版 Sora 的开发提供支持的全体团队成员。_
&#123;% endraw %}
