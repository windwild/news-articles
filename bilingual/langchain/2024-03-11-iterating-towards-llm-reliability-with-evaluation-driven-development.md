---
title: "Iterating Towards LLM Reliability with Evaluation Driven Development"
source: "LangChain Blog"
url: "https://blog.langchain.com/iterating-towards-llm-reliability-with-evaluation-driven-development/"
date: "2024-03-11"
scraped_at: "2026-03-03T08:09:19.664592390+00:00"
language: "en-zh"
translated: true
---

_Editor's Note: the following is a guest blog post from Devin Stein, CEO of_ [_Dosu_](https://dosu.dev/?ref=blog.langchain.com) _._ _Dosu is an engineering teammate that helps you develop, maintain, and support software._

_编辑注：以下为 Dosu 公司首席执行官 Devin Stein 撰写的客座博客文章。_ [_Dosu_](https://dosu.dev/?ref=blog.langchain.com) _是一款工程协作助手，可协助您开发、维护与支持软件。_

It’s well known at this point that building production-grade LLM products is hard. Reliability is critical for any product to succeed, but when your product is underpinned by a series of probabilistic functions, ensuring reliability is far from straightforward.

目前业界已普遍认识到：构建面向生产环境的大型语言模型（LLM）产品极具挑战性。任何产品的成功都高度依赖可靠性；然而，当您的产品底层由一系列概率性函数构成时，保障其可靠性便远非易事。

At [Dosu](https://dosu.dev/?ref=blog.langchain.com), we are continuously iterating on our product. For every change we make, we need to understand it’s impact on end users. Evaluation driven development (EDD) allow us to ship with confidence. Over the last few months, LangSmith has allowed us to scale EDD by enabling us to easily monitor and search Dosu’s activity.

在 [Dosu](https://dosu.dev/?ref=blog.langchain.com)，我们持续迭代优化产品。每一次变更，我们都需精准评估其对终端用户的影响。评估驱动开发（Evaluation Driven Development, EDD）使我们得以自信地交付新版本。过去几个月中，LangSmith 帮助我们规模化落地 EDD——它让我们能够轻松监控并检索 Dosu 的全部运行活动。

## What is Dosu?

## 什么是 Dosu？

If you’ve spent any time on the LangChain GitHub repository, you may have already met [Dosu](https://github.com/langchain-ai/langchain/issues/10943?ref=blog.langchain.com), an AI teammate that helps develop, maintain, and support software projects.

如果您曾浏览过 LangChain 的 GitHub 仓库，或许早已结识 [Dosu](https://github.com/langchain-ai/langchain/issues/10943?ref=blog.langchain.com) ——一位助力软件项目开发、维护与支持的 AI 协作伙伴。

Dosu was born out of my time as an open source software maintainer, a rewarding, but notoriously time-consuming role. As my OSS project grew in popularity, I found myself spending far more time playing support instead of developing new features.

Dosu 源自我担任开源软件（OSS）维护者的亲身经历——这是一份富有成就感却也以耗时著称的工作。随着我的开源项目日益流行，我发现自己越来越多地陷入支持性事务，而非专注于新功能开发。

For maintainers, this responsibility frequently [causes burnout](https://github.com/pi0/tired-maintainer?ref=blog.langchain.com) and has driven some to [declare issue bankruptcy](https://twitter.com/danielcroe/status/1703127430523703432?ref=blog.langchain.com), a process that involves simply closing all open issues and PRs. The OSS community also suffers from this situation, as people often wait days, weeks, or even months for a maintainer to respond to their issues.

对维护者而言，此类职责极易引发[职业倦怠](https://github.com/pi0/tired-maintainer?ref=blog.langchain.com)，甚至促使部分维护者[宣布“议题破产”](https://twitter.com/danielcroe/status/1703127430523703432?ref=blog.langchain.com)——即直接关闭所有待处理的问题（issues）和拉取请求（PRs）。开源社区亦深受其害：用户常需等待数天、数周乃至数月，方能等到维护者对其问题的回应。

This phenomenon isn’t exclusive to open source. Within the industry, up to [85% of developers’ time](https://www.microsoft.com/en-us/research/uploads/prod/2019/04/devtime-preprint-TSE19.pdf?ref=blog.langchain.com) is spent on non-coding tasks, like answering ad-hoc questions, triaging issues, and processing overhead.

这一现象并非开源领域独有。在产业界，开发者高达[85% 的工作时间](https://www.microsoft.com/en-us/research/uploads/prod/2019/04/devtime-preprint-TSE19.pdf?ref=blog.langchain.com)被消耗在非编码任务上，例如解答临时性问题、分类处理问题报告，以及应对各类流程性开销。

Dosu takes these tasks off developers’ plates, so they can do what they love: stay in flow, code, and ship great features. At the same time, Dosu is a resource to the OSS community, giving community members immediate feedback whenever they run into an unforeseen issue or have novel questions that only code can answer.

Dosu 将上述任务从开发者肩上卸下，使其得以专注所爱：保持心流状态、高效编码、快速交付卓越功能。与此同时，Dosu 亦成为开源社区的重要资源——每当社区成员遭遇意外问题，或提出唯有代码本身才能解答的新颖问题时，Dosu 都能即时提供反馈。

## Early Days

## 初创阶段

Dosu launched in late June, 2023. Back then, our volume was low enough for us to inspect every single response. Each day, armed with just `grep` and `print` statements, we meticulously combed through logs to identify areas for improvement.

Dosu 于 2023 年 6 月下旬正式上线。彼时，我们的请求量尚小，足以让我们人工审阅每一条响应。每天，我们仅依靠 `grep` 命令和 `print` 语句，细致梳理日志，以识别待优化环节。

The work was painstaking, but it was important for designing and developing Dosu's architecture. It helped our team deeply understand how people were trying to use Dosu, which types of requests it excelled at, and ones where it fell short.

这项工作虽耗时费力，却对 Dosu 架构的设计与开发至关重要。它帮助团队深入理解用户如何使用 Dosu、Dosu 在哪些类型的请求上表现优异，以及在哪些场景下尚存不足。

Once we knew what we needed to improve, the question was how to improve it. Unlike traditional code updates, changing LLM logic is not straightforward. It’s difficult to know how a small change might affect performance as a whole. Many times we saw that a slight tweak to a prompt led to better results in one domain but caused regression in another.

明确需改进之处后，关键问题便转向“如何改进”。与传统代码更新不同，调整大语言模型（LLM）逻辑并非易事：微小改动可能对整体性能产生难以预估的影响。我们多次观察到，提示词（prompt）的细微调整虽能提升某一领域的效果，却同时导致另一领域的性能退化。

We needed a way to measure the impact of our changes. For every change, we wanted to make sure that we were:

1. Maintaining performance in areas where we were doing well  
2. Improving performance in areas where we were struggling  

我们需要一种方法来量化每次变更的实际影响。对于每一项改动，我们都希望确保：

1. 在原有优势领域维持既有性能表现  
2. 在薄弱环节切实提升性能表现  

It was during these early days that we turned to evaluation driven development to benchmark our progress.

正是在这一早期阶段，我们开始采用“评估驱动开发”（Evaluation Driven Development, EDD）来衡量自身进展。

## Evaluation Driven Development

## 评估驱动开发（EDD）

Evaluation driven development (EDD), like test driven development, gives us end goal to develop against. The evaluations — or “evals” — are our baseline for understanding updates and new functionality. EDD helps us understand the impact of any change we make to Dosu’s core logic, models, or prompts.

评估驱动开发（EDD）与测试驱动开发（TDD）类似，为我们的开发工作设定了明确的目标导向。这些评估任务（即“evals”）构成了我们理解功能更新与新增能力的基准线。EDD 帮助我们全面把握对 Dosu 核心逻辑、模型或提示词所作任何变更带来的实际影响。

With EDD, we have a well-defined process for improving Dosu:

1. Create a new behavior with a handful of initial evals  
2. Launch the new behavior to users  
3. Monitor results in production and identify failure modes  
4. Add examples for each failure mode to our offline evals  
5. Iterate on the updated evals to improve performance  
6. Relaunch & repeat  

借助 EDD，我们建立起一套清晰、可复现的 Dosu 优化流程：

1. 针对新行为设计若干初始评估用例（evals）  
2. 将该新行为灰度发布给用户  
3. 在生产环境中持续监控效果，并识别各类失败模式（failure modes）  
4. 为每类失败模式补充对应示例，纳入离线评估集  
5. 基于更新后的评估集反复迭代优化，提升实际性能  
6. 重新发布并循环执行上述步骤

This development workflow worked well for us when Dosu started, but as our usage grew, it became difficult to keep up with Dosu’s activity.

Dosu 刚启动时，这一开发工作流运行良好；但随着使用规模扩大，我们越来越难以跟上 Dosu 的活跃节奏。

## Keeping the Quality Bar High at Scale

## 在规模化场景下持续保障高质量输出

Today, Dosu is installed on thousands of repositories and generates responses at all hours of the day. We’ve built dozens of submodules to intelligently handle different types of scenarios, and we’re constantly iterating on our approach to problem solving as models and the research in the field evolve.

如今，Dosu 已部署于数千个代码仓库中，并在全天候持续生成响应。我们构建了数十个子模块，以智能应对各类使用场景；同时，随着大语言模型及领域内研究的不断演进，我们也在持续迭代优化自身的问题解决方法论。

While the growth of Dosu was exciting, it came with challenges. Dosu’s increased activity made it nearly impossible to monitor responses and identify failure modes in production, which is critical to our EDD workflow.

尽管 Dosu 的快速增长令人振奋，但也带来了诸多挑战：其活动量激增使得我们在生产环境中几乎无法有效监控响应质量、识别失效模式——而这恰恰是保障我们“Engineering-Driven Development（EDD，工程驱动开发）”工作流的关键环节。

We decided it was time to upgrade our LLM monitoring stack. We looked for a tool that could not only help us monitor Dosu’s activity, but that was flexible enough to fit into our existing workflow. Some of our criteria included:

我们决定是时候升级我们的大语言模型（LLM）监控技术栈了。我们需要一款不仅能帮助我们监控 Dosu 的运行活动，还能灵活嵌入现有工作流的工具。我们的核心选型标准包括：

- Prompts must live in Git — In the ethos of EDD, we treat prompts as code. Any changes to a prompt must be treated with the same standards as code changes.  
- 提示词（Prompts）必须托管于 Git —— 秉承 EDD 理念，我们将提示词视作代码；任何提示词变更都须遵循与代码变更同等的规范和流程。

- Code-level tracing — There is more to Dosu than a series of LLM requests. We wanted to track metadata between LLM requests within a single trace.  
- 代码级追踪（Code-level tracing）—— Dosu 的行为远不止一系列 LLM 请求的简单组合；我们希望在单次完整调用链（trace）内，跨多个 LLM 请求追踪上下文元数据。

- Easy to export data — We had existing evaluation datasets and tooling that we wanted keep.  
- 数据导出便捷 —— 我们已拥有成熟的评估数据集与配套工具链，希望新工具能无缝兼容并复用这些资产。

- Customizable and extensible — The LLM space is rapidly evolving. There is no standard way of building LLM apps. We wanted to have control over what metadata is tracked and the ability tailor the tool to meet our needs.  
- 高度可定制与可扩展 —— 大语言模型领域正飞速演进，尚无构建 LLM 应用的统一范式；我们期望完全掌控所追踪的元数据类型，并能按需深度定制该工具以契合自身需求。

We explored the LLM monitoring and evaluation landscape, trying to find a product that satisfied our requirements. After a call with the LangChain team, one of our early partners, we were pleased to hear that LangSmith seemed to check all the boxes.

我们全面调研了当前 LLM 监控与评估领域的主流方案，积极寻找满足上述全部要求的产品。在与早期合作伙伴 LangChain 团队的一次沟通后，我们欣喜地发现：LangSmith 几乎完美契合我们所有关键诉求。

## Implementing LangSmith via the SDK

## 基于 SDK 集成 LangSmith

What got us most excited about LangSmith wasn’t its sleek UI or extensive feature set, but actually its SDK. The LangSmith SDK gave us the fine-grain controls and customizability we were looking for.

真正让我们对 LangSmith 振奋不已的，并非其简洁美观的用户界面或功能丰富的开箱即用能力，而是其软件开发工具包（SDK）。LangSmith SDK 正好提供了我们所渴求的细粒度控制能力与高度可定制性。

To try out LangSmith, we just had to add a `@traceable` decorator to a few of our LLM-related functions. It only took us minutes to instrument, and immediately upon pushing these changes to production we saw traces flooding into the LangSmith UI.

为快速试用 LangSmith，我们仅需在若干与 LLM 相关的函数上添加 `@traceable` 装饰器。整个接入过程耗时仅数分钟；一旦将这些变更推送至生产环境，海量调用链（traces）便立即涌入 LangSmith 的用户界面。

![](images/iterating-towards-llm-reliability-with-evaluation-driven-development/img_001.png)

An unexpectedly awesome feature of the `@traceable` decorator is it can send the function _and_ LLM call traces to LangSmith. This allows us to see the raw function inputs, rendered prompt templates, and LLM output all in a single trace in the LangSmith UI.

`@traceable` 装饰器一个出人意料却极为实用的功能是：它能将函数调用轨迹 _以及_ 大语言模型（LLM）调用轨迹一并发送至 LangSmith。这使得我们能够在 LangSmith 用户界面中，于单条追踪记录中同时查看原始函数输入、渲染后的提示词模板（prompt templates）以及 LLM 的输出结果。

![](images/iterating-towards-llm-reliability-with-evaluation-driven-development/img_002.png)

Out-of-the-box, LangSmith gave us visibility into all of Dosu’s activity. The next step was to leverage LangSmith to identify failure modes and integrate it into our EDD workflow.

开箱即用的 LangSmith 已为我们提供了对 Dosu 全部运行活动的可观测性。下一步，便是借助 LangSmith 识别各类故障模式，并将其深度整合进我们的“评估驱动开发”（Evaluation-Driven Development, EDD）工作流中。

## Finding Failures

## 定位故障

Dosu 接收来自用户的海量请求——涵盖从关于代码库的简单提问，到因升级至新版本库而产生的错误堆栈信息，再到有关某项功能当前状态的咨询。Dosu 可能接收的输入越多样，潜在的故障模式也就越丰富。

在尝试识别故障模式（即 Dosu 处理效果不佳的请求类型）时，我们可以关注多种信号，例如：

- 显式反馈（Explicit Feedback）：即 ChatGPT 等产品广为采用的经典“点赞/点踩”反馈机制。
- 用户情绪（User Sentiment）：当用户在 GitHub Issues 中与 Dosu 交互时，其回复内容通常能直观反映 Dosu 是否提供了有效帮助（参见 [Dosu 用户好评集锦](https://www.notion.so/Dosu-Rave-Reviews-851e0323d90149bcb9260fd536aa0fd3?pvs=21&ref=blog.langchain.com)）。
- 内部错误（Internal Errors）：大语言模型可能因多种原因失败，例如：输入或输出内容超出长度限制？生成的响应未能符合预设的数据结构（schema）？
- 响应耗时（Response Time）：在 Dosu，我们始终将响应质量置于响应速度之上；但理解响应为何缓慢同样至关重要。某些请求需快速响应，而另一些则需更慢但更精准的响应。

LangSmith 强大的高级搜索功能，使我们能轻松识别异常行为。我们可基于多种条件执行搜索，包括：用户的显式反馈、近期发生的错误事件、响应延迟、或负面情绪倾向等。此外，LangSmith 还支持为每条追踪记录附加额外元数据（metadata），从而进一步拓展其搜索能力。

![](images/iterating-towards-llm-reliability-with-evaluation-driven-development/img_003.png)

Already, we’ve identified a number of unforeseen failure modes. For example, we found a pattern of extremely slow responses when users would share thousands of lines of logs or the raw float values of an OpenAI embedding.

目前，我们已识别出多种意料之外的失效模式。例如，当用户分享数千行日志或 OpenAI embedding 的原始浮点数值时，我们观察到系统响应异常缓慢的现象。

One of our team’s favorite failures happened when Dosu was asked to label a pull request. Rather than labeling the pull request, Dosu decided it should tell the user about the concert it was excited to go to the concert that night. Jury is still out on whether Dosu is a Swiftie.

我们团队最喜爱的一次“失败”发生在 Dosu 被要求为一个 Pull Request 打标签时：它没有执行打标签任务，反而兴致勃勃地告诉用户——它当晚很期待去听一场演唱会。至于 Dosu 究竟是不是一位“Swiftie”（泰勒·斯威夫特粉丝），目前尚无定论。

![](images/iterating-towards-llm-reliability-with-evaluation-driven-development/img_004.png)

![](images/iterating-towards-llm-reliability-with-evaluation-driven-development/img_004.png)

Once we find a failure mode, the EDD workflow is the same as before.

一旦发现某种失效模式，评估驱动开发（EDD）的工作流程与此前完全一致。

1. We search LangSmith for additional examples  
2. Add them to our eval datasets  
3. Iterate against the evals  
4. Push a new version of Dosu, and repeat.

1. 我们在 LangSmith 中搜索更多同类案例  
2. 将这些案例加入我们的评估数据集（eval datasets）  
3. 基于评估结果持续迭代优化  
4. 发布 Dosu 的新版本，并重复上述流程。

## Automating Evaluation Dataset Collection

## 自动化评估数据集构建

The future of evaluation driven development at Dosu is bright. Our team is customizing LangSmith even further to allow us to automatically build evaluation datasets from production traffic. We want it to be as simples as possible for engineers at Dosu to curate datasets based on conversation topics, user segments, request categories, and more.

Dosu 的评估驱动开发（EDD）前景广阔。我们的团队正对 LangSmith 进行更深度的定制，使其能够直接从线上生产流量中自动构建评估数据集。我们的目标是让 Dosu 工程师能以最简单的方式，基于对话主题、用户分群、请求类型等维度，高效地筛选和构建高质量评估数据集。

There is a fun flywheel effect in Dosu’s collaboration with LangChain. LangSmith helps us iterate faster to improve Dosu’s performance. Improvements to Dosu directly translates to reducing the maintenance and support burden on the LangChain team, allowing them to spend more time shipping features for LangSmith, which in turn speeds up the development of Dosu. And so the process continues!

Dosu 与 LangChain 的协作中存在一个有趣的“飞轮效应”：LangSmith 加速了 Dosu 的迭代进程，从而提升了 Dosu 的性能；而 Dosu 性能的提升，又直接减轻了 LangChain 团队在维护与支持方面的负担，使他们得以将更多精力投入 LangSmith 新功能的开发；LangSmith 功能越强大，Dosu 的开发效率也就越高——如此循环往复，持续加速。

PS: Dosu’s hiring! Reach out at jobs\*@dosu.dev\*

附注：Dosu 正在招聘！欢迎发送邮件至 jobs\*@dosu.dev\* 联系我们。