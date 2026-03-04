---
render_with_liquid: false
title: "Building LangGraph: Designing an Agent Runtime from first principles"
source: "LangChain Blog"
url: "https://blog.langchain.com/building-langgraph/"
date: "2025-10-19"
scraped_at: "2026-03-03T07:22:32.962661055+00:00"
language: "en-zh"
translated: true
description: "In this blog piece, you’ll learn why and how we built LangGraph for production agents—focusing on control, durability, and the core features needed to scale."
---
render_with_liquid: false
render_with_liquid: false

_By Nuno Campos_

_作者：Nuno Campos_

**Summary:** We launched LangGraph as a low level agent framework nearly two years ago, and have already seen companies like LinkedIn, Uber, and Klarna use it to build production ready agents. LangGraph builds upon feedback from the super popular LangChain framework, and rethinks how agent frameworks should work for production. We aimed to find the right abstraction for AI agents, and decided that was little to no abstraction at all. Instead, we focused on control and durability. This post shares our design principles and approach to designing LangGraph based on what we’ve learned about building reliable agents.

**摘要：** 我们近两年前推出了 LangGraph——一个底层智能体（agent）框架，如今 LinkedIn、Uber 和 Klarna 等公司已将其用于构建可投入生产的智能体。LangGraph 基于广受欢迎的 LangChain 框架所积累的大量用户反馈而设计，重新思考了面向生产环境的智能体框架应如何运作。我们的目标是为 AI 智能体找到恰到好处的抽象层级，最终结论是：尽可能减少甚至完全不引入抽象。取而代之，我们聚焦于**可控性**与**持久性**。本文将分享我们在构建高可靠性智能体过程中总结出的设计原则，以及 LangGraph 的整体设计思路。

LangGraph ALPHA

LangGraph ALPHA 版本

We just launched an alpha version of LangGraph 1.0!

我们刚刚发布了 LangGraph 1.0 的 Alpha 版本！

[Try it out now](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com)

[立即试用](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com)

—

We started [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) as a reboot of LangChain’s super popular chains and agents more than two years ago. We decided that starting fresh would give us the most leeway to address all the feedback we had received since the launch of the original `langchain` open source library (in countless GitHub issues, discussions, Discord, Slack and Twitter posts). The main thing we heard was that `langchain` was easy to get started but hard to customize and scale.

——  
我们早在两年多前便启动了 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 项目，旨在对 LangChain 中广受好评的“链（chains）”与“智能体（agents）”功能进行彻底重构。我们判断，从零开始构建，才能最大程度地回应自原始开源库 `langchain` 发布以来所收到的海量反馈（涵盖数以千计的 GitHub Issues、Discussion 讨论区、Discord、Slack 及 Twitter 帖子）。用户最常提及的一点是：`langchain` 上手容易，但定制困难、难以规模化。

This time around, our top goal was to make LangGraph what you’d use to run your agents in production. When we had to make tradeoffs, we prioritized production-readiness over how easy it would be for people to get started.

这一次，我们的首要目标是让 LangGraph 成为真正适用于生产环境智能体运行的框架。当面临权衡取舍时，我们始终将**生产就绪性（production-readiness）**置于“上手简易度”之上。

In this post, we’ll share our process for scoping and designing LangGraph.

在本文中，我们将分享 LangGraph 的范围界定（scoping）与设计过程：

- First: we cover what’s different about building agents compared to traditional software.  
- 首先：阐述构建智能体与开发传统软件的关键差异；  

- Next: we discuss how we turned these differences into required features.  
- 接着：说明我们如何将这些差异转化为框架必须支持的核心功能；  

- Finally: we show how we designed and tested our framework for these requirements.  
- 最后：展示我们如何围绕上述需求开展框架设计与验证测试。

The result is a low-level, production ready agent framework that scales with both the size and throughput of your agents.

结果是一个低层级、可投入生产的智能体（agent）框架，能够随您智能体的规模与吞吐量同步扩展。

## 1\. What do agents need?

## 1. 智能体需要什么？

The first two questions we asked were, “Do we actually need to build LangGraph?” And, “Why can’t we use an existing framework to put agents in production?” To answer these questions, we had to define what makes an agent different (or similar) to previous software. By building many agents ourselves and working with [teams like Uber, LinkedIn, Klarna, and Elastic](https://blog.langchain.com/top-5-langgraph-agents-in-production-2024/), we boiled these down to 3 key differences.

我们最先提出的两个问题是：“我们真的有必要构建 LangGraph 吗？”以及“为什么不能直接使用现有框架将智能体投入生产？”要回答这些问题，我们必须先厘清：智能体与以往的软件究竟有何不同（或相似）？通过亲自构建大量智能体，并与 [Uber、LinkedIn、Klarna 和 Elastic 等团队](https://blog.langchain.com/top-5-langgraph-agents-in-production-2024/)协作，我们将这些差异凝练为三大核心要点。

- More latency makes it harder to keep users engaged  
- 延迟越高，越难维持用户参与度  
- Retrying long-running tasks when they fail is expensive and time-consuming  
- 长时任务失败后重试成本高昂且耗时  
- The non-deterministic nature of AI requires checkpoints, approvals, and testing  
- 人工智能固有的不确定性，要求设置检查点（checkpoints）、人工审批（approvals）及系统性测试  

### Managing latency

### 延迟管理

The first defining quality and challenge of LLM-based agents is **latency**. We used to measure the latency of our backend endpoints in milliseconds. Now, we need to measure agent run times in seconds, minutes, or soon hours.

基于大语言模型（LLM）的智能体，其首要标志性特征与核心挑战便是 **延迟（latency）**。过去，我们以毫秒（ms）为单位衡量后端接口的响应延迟；如今，智能体的运行时间则需以秒、分钟，乃至不久后的小时为单位来衡量。

This is because LLMs themselves are slow and are becoming slower with test-time compute. It’s also because we often need multiple LLM calls to achieve our desired results, with looping agents, and chaining LLM prompts to fix earlier output. And, we usually need to add non-LLM steps before and after the LLM call. For instance, you might need to get database rows into the context or create guardrails and verifiers to check the LLM call for accuracy.

这背后的原因有三：其一，LLM 本身响应缓慢，且随着推理时计算（test-time compute）的增强，其延迟还在持续增加；其二，为达成理想结果，我们往往需发起多次 LLM 调用——例如借助循环型智能体（looping agents），或串联多个提示词（prompt chaining）来修正前序输出；其三，LLM 调用前后通常还需嵌入非 LLM 步骤，例如将数据库记录载入上下文，或构建护栏（guardrails）与校验器（verifiers）以确保 LLM 输出的准确性。

All this latency enables building new things, but you do still need to keep end users engaged throughout. So, we identified two features that would come in handy when building agents:

上述所有延迟虽催生了全新能力，但您仍须全程维系终端用户的参与感与体验。因此，我们在构建智能体时提炼出两项关键能力：

- **Parallelization.** Whenever there were multiple steps to your agent, when the next step doesn’t need the output of the previous one, then you could run them in parallel. But to do this reliably in production you want to avoid data races between your parallel steps.  
- **并行化（Parallelization）**：当智能体包含多个步骤，且后续步骤无需依赖前一步骤的输出时，即可并行执行。但在生产环境中可靠地实现并行，必须避免各并行步骤间发生数据竞争（data races）。  
- **Streaming.** When you can’t reduce the actual latency of your agent any further without making it produce worse results, then you turn to perceived latency. Here the key unlock comes from showing useful information to the user while the agent is running, which can go all the way from a progress bar, or key actions taken by the agent, all the way to streaming LLM messages token-by-token in real-time to the end-user.  
- **流式响应（Streaming）**：当无法在不损害输出质量的前提下进一步降低智能体的实际延迟时，便需转向“感知延迟（perceived latency）”优化。其关键在于：在智能体运行过程中，向用户实时呈现有价值的信息——从简单的进度条、智能体执行的关键动作，直至将 LLM 的生成内容以逐 Token 方式实时流式推送至终端用户。

### **Managing reliability**

### **可靠性管理**

The slowness of LLM agents had other implications, too. As we all know all too well, inevitably all software bugs out. Long-running agents fail more often because, the longer they run, the more opportunity there is for something to go wrong.

LLM 代理的运行缓慢还带来了其他影响。我们所有人都再清楚不过：软件终究不可避免地会出现故障。而长时间运行的代理失败概率更高，因为运行时间越长，出错的可能性就越大。

When traditional software bugs out, you usually want to retry. With AI agents? That may not be the best approach. If your agent fails on minute 9 of 10, going back to the beginning is pretty time consuming and also expensive.

传统软件出错时，你通常会选择重试；但对于 AI 代理呢？这未必是最佳策略。如果你的代理在第 10 分钟的第 9 分钟失败了，重新从头开始不仅耗时，而且成本高昂。

So we knew we had to add two more features to the list:

因此，我们意识到必须在功能清单中再增加两项能力：

- **Task queue.** Queues eliminate one common source of failure by disconnecting the running of the agent from the request that triggered it. They provide the primitives to retry the agent reliably and fairly when needed.

- **任务队列（Task queue）**：通过将代理的执行过程与触发它的请求解耦，队列消除了一个常见的故障来源；它提供了基础机制，使代理在需要时能够被可靠、公平地重试。

- **Checkpointing.** This saves snapshots of the computation state at intermediate stages and makes it a lot cheaper to retry when it does fail.

- **检查点（Checkpointing）**：该机制在计算过程的中间阶段保存状态快照，从而大幅降低代理失败后重试的成本。

### Managing non-deterministic LLMs

### 应对 LLM 的非确定性

Next, the non-deterministic nature of LLMs creates two more challenges. When you write traditional software, you at least know what the code is supposed to do and what should result if you built it as you hoped. Generative AI obviously changes this.

接下来，LLM 固有的非确定性又带来了两项新挑战。编写传统软件时，你至少清楚代码本应完成什么任务，以及若按预期构建完成，其结果应当如何。而生成式 AI 显然彻底改变了这一点。

With LLMs, both input and their output is open-ended. You can imagine when you’ve used ChatGPT, and the same prompt you used a day before produces a different result, or, how easy it is to ask your question in many different ways and get back similar results.

对于 LLM 而言，输入和输出都是开放式的。你可以回想自己使用 ChatGPT 的经历：前一天用过的相同提示词，第二天可能产生截然不同的结果；又或者，你只需用多种不同方式提出同一个问题，就能得到高度相似的回答。

This is a very big part of what makes LLM agents so powerful compared other previous software, but it also introduces challenges when taking them to production.

这恰恰是 LLM 代理相较于以往各类软件更加强大的关键所在；但与此同时，也将其推向生产环境时带来了新的挑战。

The testing you do while developing will almost certainly miss many surprising ways in which your users will use your agent. You truly can’t plan for all the ways users will interact with your agent or how the LLM will respond. And so, two more features then become very useful when going to production:

开发阶段所进行的测试，几乎必然无法覆盖用户使用代理时可能出现的诸多出人意料的方式。你确实无法预先设想用户与代理交互的所有可能路径，也无法预判 LLM 将如何响应。因此，以下两项能力在迈向生产环境时变得尤为关键：

- **Human-in-the-loop.** Having the tools to interrupt and resume the agent at any point, without having to redo work done until then, enables many essential UX patterns for AI agents. For example, you can approve or reject actions, edit the next action, ask clarifying questions, or even time travel to re-do things from a previous step.

- **人在回路中（Human-in-the-loop）**：提供可在任意时刻中断并恢复代理执行的工具，且无需重复此前已完成的工作——这一能力支撑了 AI 代理所需的诸多核心用户体验模式。例如，你可以批准或否决某项操作、编辑下一步动作、提出澄清性问题，甚至“时间旅行”回到上一步重新执行。

- **Tracing.** To build for scale, developers need clear visibility into what's happening within the details of their agent loops. You need to see inputs, trajectories, and outputs of the agent, otherwise you won’t know what users are asking of it, how the agent is handling it, and if users are happy with the outcome.

- **追踪（Tracing）**：为实现规模化部署，开发者必须清晰掌握代理内部循环各环节的详细运行状况。你需要能观察到代理的输入、执行轨迹（trajectories）及输出；否则，你将无从知晓用户究竟提出了什么请求、代理是如何处理的，以及用户是否对最终结果感到满意。

### What developers need to build agents

### 开发者构建智能体所需的核心能力

This is how we built our shortlist of the six features most developers need when taking agents to production.

这是我们梳理出的、开发者将智能体投入生产环境时最常需要的六大核心功能。

- Parallelization – to save actual latency  
- 并行化——降低实际延迟  
- Streaming – to save perceived latency  
- 流式响应——降低用户感知延迟  
- Task queue – to reduce number of retries  
- 任务队列——减少重试次数  
- Checkpointing – to reduce the cost of each retry  
- 断点续训（检查点机制）——降低每次重试的开销  
- Human-in-the-loop - to collaborate with the user  
- 人工介入（人在环路）——支持与用户协同协作  
- Tracing - to learn how users use it  
- 追踪（Tracing）——理解用户如何使用该智能体  

If the agent you’re building doesn’t need most of these features (eg. because it’s a very short agent without tools and a single prompt), then you might not need LangGraph, or any other framework.

如果你正在构建的智能体并不需要上述大多数功能（例如：它是一个极简智能体，不调用工具、仅依赖单次提示），那么你可能根本不需要 LangGraph，也不需要任何其他框架。

As we thought about building for each of these features, we also realized that developers wouldn’t adopt a framework that provided all those features at the cost of making their LLM app perceivably slower to end users. Especially for agents deployed as chatbots. That made **low latency** our final overarching requirement.

在为每一项功能进行架构设计时，我们也意识到：开发者不会采纳一个虽提供全部功能、却导致其大语言模型应用对终端用户明显变慢的框架——尤其是以聊天机器人形式部署的智能体。因此，“**低延迟**”成为我们最终确立的全局性核心要求。

Next, we'll cover how we built these capabilities into LangGraph.

接下来，我们将介绍这些能力是如何被集成进 LangGraph 的。

## 2. Why build LangGraph at all?

## 2. 为何要专门构建 LangGraph？

Back to our existential question, should we build something new, or adopt one of the existing open source frameworks built before LLMs? Armed with our feature shortlist, it became pretty easy to make that decision.

回到那个根本性问题：我们究竟应该从头构建一个新框架，还是直接采用 LLM 时代之前已有的某个开源框架？借助我们已明确的六大功能短名单，这一决策变得非常清晰。

### Why was a new framework needed?

### 为何必须构建一个新框架？

Existing frameworks were mostly split between two categories:  

现有框架大致可分为两类：

**DAG frameworks (made popular by Apache Airflow and many others)**

**DAG 框架（由 Apache Airflow 及众多其他工具带火）**

These we had to exclude just based on the name, as LLM agents really benefit from looping, ie. the computation graph for an LLM agent is cyclical, and thus cannot be handled by DAG algorithms.

仅凭名称我们就不得不排除这类框架，因为 LLM 智能体天然受益于循环机制——换言之，LLM 智能体的计算图是环状的（cyclical），因而无法被 DAG（有向无环图）类算法所处理。

**Durable execution engines (made popular by Temporal and others)**

**持久化执行引擎（由 Temporal 等工具带火）**

These options were closer, but in the end, as they were designed before LLM agents, so they were lacking some of those specific features — namely streaming. In addition, these engines introduced latency between steps which would have been noticeable to chatbot developers. Lastly, due to their design, the performance degrades the more steps there are in the history, which sounded like a bad bet to make as LLM agents get longer and more complicated.

这些方案更接近我们的需求，但最终仍被排除：它们诞生于 LLM 智能体兴起之前，因此缺乏若干关键特性——尤其是**流式处理（streaming）能力**。此外，这类引擎在各步骤之间引入了可观的延迟，对聊天机器人开发者而言十分明显。最后，受其架构设计所限，历史步骤越多，整体性能衰减越严重；而随着 LLM 智能体日趋变长、愈发复杂，这种设计显然不是一个明智的选择。

So in the end our answer was, yes LLMs are different enough that previous production infrastructure needed some new ideas injected into it to become relevant for the new era. And so we embarked on building LangGraph.

因此，我们最终的答案是：没错，LLM 确实足够不同——此前的生产级基础设施必须注入一些全新理念，才能适配这个新时代。于是，我们开启了 LangGraph 的构建之旅。

## 3\. Our design philosophy

## 3. 我们的设计哲学

We designed LangGraph with two leading principles.

LangGraph 的设计遵循两大核心原则：

- **We don’t know what the future holds for AI.** The fewer assumptions we make about the future the better. No one really knows what it will look like to build with LLMs one, two, three years from now, so the fewer assumptions we bake into the design of the framework, the more relevant it will be in the future. The only assumptions we wanted to bake into it were the realizations we talked about above, i.e. that **LLMs are slow, flaky, and open-ended.**

- **我们无法预知 AI 的未来走向。** 对未来的假设越少越好。没人真正知道一、二、三年后基于 LLM 构建应用会是什么样子；因此，我们在框架设计中嵌入的假设越少，它在未来就越具适应性与相关性。我们唯一愿意写进设计中的假设，正是前文所强调的那些洞察——即：**LLM 运行缓慢、行为不稳定（flaky），且输出具有开放性（open-ended）。**

- **It should feel like writing code.** The public API for the framework should be as close as possible to writing regular framework-less code. Every requirement we place on the developer’s code needs to be justified by enabling a really high-value feature. Otherwise the pull of skipping the framework altogether is just too strong. The biggest competitor to any code framework is always no framework.

- **它应当让人感觉就像在写原生代码。** 框架的公共 API 应尽可能贴近不依赖任何框架的常规编码体验。我们对开发者代码施加的每一项约束，都必须以支撑某项真正高价值的功能为前提；否则，开发者绕过框架、直接手写代码的倾向将过于强烈。对任何代码框架而言，最大的竞争对手永远是“零框架”（no framework）。

These principles impacted a few key design decisions that have stayed with us ever since.

这两大原则深刻影响了若干关键设计决策，并一直延续至今：

- **First, the runtime of the library is independent from the developer SDKs.** The SDKs are the public interfaces (classes, functions, methods, constants, etc) that developers use when building their agents. We currently offer two – **StateGraph** and the **imperative/functional API**. The runtime (which we call PregelLoop) implements each of the features listed earlier, plans the computation graph for each agent invocation, and executes it. This design enables us to evolve the developer APIs and the runtime independently. For instance, on the SDK side, it has allowed us to introduce the imperative SDK, and deprecate the very first SDK we offered, a Graph interface without shared state. On the runtime side, it has enabled us to implement many performance improvements over the last 2 years without any impact to the public APIs, and enabled experimentation with more radical changes to the runtime – more about this later when we get to distributed execution.

- **第一，库的运行时（runtime）与面向开发者的 SDK 彼此解耦。** SDK 是开发者构建智能体时所使用的公共接口（包括类、函数、方法、常量等）。目前我们提供两类 SDK：**StateGraph** 和 **命令式/函数式 API（imperative/functional API）**。而运行时（我们称之为 *PregelLoop*）则负责实现前述全部功能、为每次智能体调用规划计算图，并执行该图。这一设计使我们得以独立演进开发者 API 与运行时：例如，在 SDK 层面，它让我们得以引入命令式 SDK，并弃用最初发布的那个不支持共享状态的 Graph 接口；而在运行时层面，它使我们过去两年间在不破坏任何公共 API 的前提下，持续落地多项性能优化，并开展更具颠覆性的运行时重构实验——关于后者，我们将在后续介绍分布式执行时进一步展开。

- **Second, we wanted to provide each of the 6 features as building blocks, with the developer free to pick which to use in their agent at any point in time.** For instance, the ability to interrupt/resume for human-in-the-loop scenarios doesn’t get in your way until you reach for it (which is as easy as adding a call to the `interrupt()` function in one of your nodes). So LangGraph ended up as a uniquely low-level framework in a sea of other frameworks trying to convince developers to bet everything on the high-level abstraction du jour. We have seen these come and go, and LangGraph remaining relevant, so we’re happy with our approach so far.

- **第二，我们希望将前述六大特性作为可自由选用的积木式组件，开发者可在构建智能体的任意阶段按需启用其中任一特性。** 举例来说，针对“人在回路”（human-in-the-loop）场景所需的中断/恢复能力，只有当你主动调用它时才会介入——而这只需在某个节点中简单添加一行 `interrupt()` 函数调用即可。因此，LangGraph 最终成为一片充斥着各类框架的海洋中一个独特的低层级框架：其他框架往往试图说服开发者将全部赌注押在当下最时髦的高层抽象上，而 LangGraph 则选择保持克制与灵活。我们已见证诸多此类高层框架潮起潮落，LangGraph 却始终保有生命力——就目前而言，我们对自己的这条路径深感满意。

## 4. LangGraph 运行时

## 4. LangGraph 运行时

在了解上述背景之后，我们来考察 LangGraph 如何实现我们最初希望具备的全部 6 项功能（为便于回顾，这六项功能分别是：并行化、流式输出、检查点（checkpointing）、人工介入（human-in-the-loop）、追踪（tracing）以及任务队列）。

在了解上述背景之后，我们来考察 LangGraph 如何实现我们最初希望具备的全部 6 项功能（为便于回顾，这六项功能分别是：并行化、流式输出、检查点（checkpointing）、人工介入（human-in-the-loop）、追踪（tracing）以及任务队列）。

### **具有离散步骤的结构化智能体（Structured agents with discrete steps）**

### **具有离散步骤的结构化智能体**

如果有一个核心理念贯穿了我们所有其他架构决策，那便是“结构化智能体”（structured agents）这一理念。计算机程序长期以来都在不断引入更多结构——以牺牲部分灵活性为代价，换取一系列全新能力。曾几何时，[if 语句和 while 循环](https://en.wikipedia.org/wiki/Structured_programming?ref=blog.langchain.com)这类基础控制结构也曾是崭露头角的新事物。同理，智能体也可以直接写成一个包含大型 while 循环的单一函数。但一旦如此实现，你便会丧失实现检查点或人工介入等关键功能的能力。（注：尽管从技术上讲，某些子例程（例如生成器）的执行过程或许可以被中断，但其执行状态无法以可移植格式保存，因而无法在另一台机器、另一个时间点准确恢复。）

如果有一个核心理念贯穿了我们所有其他架构决策，那便是“结构化智能体”（structured agents）这一理念。计算机程序长期以来都在不断引入更多结构——以牺牲部分灵活性为代价，换取一系列全新能力。曾几何时，[if 语句和 while 循环](https://en.wikipedia.org/wiki/Structured_programming?ref=blog.langchain.com)这类基础控制结构也曾是崭露头角的新事物。同理，智能体也可以直接写成一个包含大型 while 循环的单一函数。但一旦如此实现，你便会丧失实现检查点或人工介入等关键功能的能力。（注：尽管从技术上讲，某些子例程（例如生成器）的执行过程或许可以被中断，但其执行状态无法以可移植格式保存，因而无法在另一台机器、另一个时间点准确恢复。）

### **执行算法（Execution algorithm）**

### **执行算法**

一旦你决定将智能体拆分为多个离散步骤，就必须选择某种算法来协调其执行流程。哪怕最初采用一种看似“无算法”的朴素方式——这恰恰是 LangGraph 在正式发布前的起点。然而，“无算法”方式的问题在于：表面看似更简单，实则是在运行中即兴发挥，最终导致意料之外的结果。（例如，LangGraph 的早期雏形版本就曾因并发节点而表现出非确定性行为。）常规的有向无环图（DAG）算法（如拓扑排序及其变体）在此并不适用，因为我们必须支持循环（loops）。最终，我们基于 [BSP](https://en.wikipedia.org/wiki/Bulk_synchronous_parallel?ref=blog.langchain.com) / [Pregel](https://dl.acm.org/doi/10.1145/1807167.1807184?ref=blog.langchain.com) 算法构建了执行引擎，因为它能提供确定性的并发执行能力，并完整支持循环（即图中的环路）。

一旦你决定将智能体拆分为多个离散步骤，就必须选择某种算法来协调其执行流程。哪怕最初采用一种看似“无算法”的朴素方式——这恰恰是 LangGraph 在正式发布前的起点。然而，“无算法”方式的问题在于：表面看似更简单，实则是在运行中即兴发挥，最终导致意料之外的结果。（例如，LangGraph 的早期雏形版本就曾因并发节点而表现出非确定性行为。）常规的有向无环图（DAG）算法（如拓扑排序及其变体）在此并不适用，因为我们必须支持循环（loops）。最终，我们基于 [BSP](https://en.wikipedia.org/wiki/Bulk_synchronous_parallel?ref=blog.langchain.com) / [Pregel](https://dl.acm.org/doi/10.1145/1807167.1807184?ref=blog.langchain.com) 算法构建了执行引擎，因为它能提供确定性的并发执行能力，并完整支持循环（即图中的环路）。

我们的执行算法工作原理如下：

我们的执行算法工作原理如下：

- **通道（Channels）** 存储数据（任意 Python/JS 数据类型），每个通道具有名称及当前版本号（一个单调递增的字符串）；  
- **节点（Nodes）** 是待执行的函数，它们订阅一个或多个通道，并在所订阅通道的数据更新时触发执行；  
- 一个或多个通道被映射为 **输入（input）**：即智能体的初始输入会被写入这些通道，从而触发所有订阅了这些通道的节点；  
- 一个或多个通道被映射为 **输出（output）**：即当执行终止时，智能体的返回值即为这些通道当前所持有的值。

- **通道（Channels）** 存储数据（任意 Python/JS 数据类型），每个通道具有名称及当前版本号（一个单调递增的字符串）；  
- **节点（Nodes）** 是待执行的函数，它们订阅一个或多个通道，并在所订阅通道的数据更新时触发执行；  
- 一个或多个通道被映射为 **输入（input）**：即智能体的初始输入会被写入这些通道，从而触发所有订阅了这些通道的节点；  
- 一个或多个通道被映射为 **输出（output）**：即当执行终止时，智能体的返回值即为这些通道当前所持有的值。

执行过程以循环方式进行，每一轮迭代包含以下步骤：

执行过程以循环方式进行，每一轮迭代包含以下步骤：

- 根据各通道当前版本与各订阅者上次所见版本的比对结果，选出本轮需执行的一个或多个节点；  
- 并行执行所选节点，每个节点拥有各自独立的通道值副本（即局部状态，确保彼此执行互不干扰）；  
- 各节点在运行过程中修改其本地状态副本；  
- 所有节点执行完毕后，按确定性顺序将各本地状态副本的更新合并至对应通道（该机制保证了无数据竞争），并提升相应通道的版本号。

- 根据各通道当前版本与各订阅者上次所见版本的比对结果，选出本轮需执行的一个或多个节点；  
- 并行执行所选节点，每个节点拥有各自独立的通道值副本（即局部状态，确保彼此执行互不干扰）；  
- 各节点在运行过程中修改其本地状态副本；  
- 所有节点执行完毕后，按确定性顺序将各本地状态副本的更新合并至对应通道（该机制保证了无数据竞争），并提升相应通道的版本号。

The execution loop stops when there are no more nodes to run (ie. after comparing channels with their subscriptions we find all nodes have seen the most recent version of their subscribed channels), or when we run out of iteration steps (a constant the developer can set).

执行循环在以下两种情况下停止：（1）没有更多节点需要运行（即，在将各 channel 与其订阅关系进行比对后，发现所有节点均已看到其订阅 channel 的最新版本）；或（2）迭代步数耗尽（该上限为开发者可配置的常量）。

### **Validating framework features**

### **框架特性的验证**

Let’s see how this maps to the 6 features we wanted to implement.

下面我们来看这一设计如何对应我们最初希望实现的六大特性。

- **Parallelization**. This algorithm is designed for safe parallelization without data races, it automatically selects parallel execution whenever the dependencies between the nodes allow, it executes parallel nodes with isolated state copies, and it applies updates from nodes in an order which doesn’t depend on which one started or finished first (as that can change between executions). This ensures that the execution order and latency of each node never influences the final output of the agent. Given LLMs are non-deterministic, we felt this was an important property, to ensure that variability in your outputs is never the fault of the agent framework, making it a lot easier to debug issues.

- **并行化（Parallelization）**。该算法专为安全并行化而设计，可避免数据竞争；当节点间依赖关系允许时，自动启用并行执行；并行为各节点提供隔离的状态副本；且以一种与节点启动/完成顺序无关的方式应用其更新（因该顺序可能在不同执行中发生变化）。这确保了每个节点的执行顺序与延迟绝不会影响智能体（agent）的最终输出。鉴于大语言模型（LLM）本身具有非确定性，我们认为此特性至关重要——它能确保输出的波动永远不是由智能体框架自身导致，从而极大简化问题排查与调试工作。

- **Streaming**. Structured execution models (ie. where the computation is split into discrete steps and/or nodes) offer many more opportunities for emitting intermediate output and updates throughout. Our execution engine collects streaming output from inside nodes while they are running, as well as at the step boundaries, without requiring any custom developer code. This has enabled us to offer 6 distinct stream modes in LangGraph, values, updates, messages, tasks, checkpoints and custom. A streaming chatbot might use messages stream mode, while a longer running agent might use updates mode.

- **流式输出（Streaming）**。结构化执行模型（即：将计算划分为离散步骤和/或节点）为全程输出中间结果与状态更新提供了远更丰富的可能性。我们的执行引擎可在节点运行过程中，以及在各步骤边界处，自动采集其内部产生的流式输出，全程无需开发者编写任何定制代码。正因如此，LangGraph 目前已支持六种互不相同的流式模式：`values`、`updates`、`messages`、`tasks`、`checkpoints` 和 `custom`。例如，一个流式聊天机器人通常采用 `messages` 模式，而一个运行时间较长的智能体则更适合使用 `updates` 模式。

- **Checkpointing**. Again, structured execution is what makes this feasible. We want to save checkpoints that can be resumed on any machine, an arbitrary amount of time after they were saved – ie. checkpoints that don’t rely on keeping a process running in a specific machine, or keeping any live data in memory. To enable this we record serialised channel values (by default serialised to MsgPack, optionally encrypted), their version strings, and a record of which channel versions each node has most recently seen.

- **检查点（Checkpointing）**。同样，结构化执行是实现该能力的前提。我们希望保存的检查点可在任意机器上、任意时间（如数小时、数天甚至数月之后）被恢复——即：检查点不应依赖于在某台特定机器上持续运行某个进程，也不应依赖于内存中始终驻留任何实时数据。为此，我们持久化记录以下内容：序列化的 channel 值（默认使用 MsgPack 格式，可选加密）、其版本字符串（version strings），以及每条 channel 各节点最近所见版本的完整记录。

- **Human-in-the-loop**. The same checkpointing that enables fault tolerance can also be used to power “expected interruptions” of the agent, ie. giving the agent the ability to interrupt itself to ask the user or developer for input before continuing. Usually this capability is implemented by leaving the agent running while it waits for the input to arrive, but sadly that scales neither in time nor in volume. If you have many agents interrupted simultaneously, or if you want to wait several days (or months!) before replying, then actual interruption (powered by checkpointing to resume again from the same point) is the only way to go.

- **人工介入（Human-in-the-loop）**。前述用于容错的检查点机制，同样可用于支持智能体的“预期中断”——即：赋予智能体主动暂停自身执行、向用户或开发者请求输入后再继续的能力。传统做法通常是让智能体保持运行状态、等待输入到达，但遗憾的是，这种方案在时间维度与并发规模上均难以扩展。若你同时有大量智能体处于中断等待状态，或需等待数天（甚至数月！）才回复，则唯有借助检查点实现真正意义上的中断与断点续跑（resume from the exact same point），才是唯一可行路径。

- **Tracing**. Another nice property of using structured execution is you get very clear steps to inspect the progress of your agent, while it runs and after the fact. We had previously built [LangSmith](https://docs.langchain.com/langsmith/home?ref=blog.langchain.com) as the first LLM observability platform, so naturally LangGraph integrates natively with it. Today we have also LangGraph Studio, where you can debug your agent while it’s running, and LangGraph can also emit OTEL traces for wider compatibility.

- **追踪（Tracing）**。采用结构化执行的另一大优势在于：你能在智能体运行过程中及运行结束后，清晰地观察其每一步进展。此前我们已构建了 [LangSmith](https://docs.langchain.com/langsmith/home?ref=blog.langchain.com) ——业界首个面向大语言模型的可观测性平台，因此 LangGraph 原生集成 LangSmith 是水到渠成之举。如今我们还推出了 LangGraph Studio，支持你在智能体运行时实时调试；此外，LangGraph 还可原生输出 OpenTelemetry（OTEL）标准追踪数据，以满足更广泛的生态兼容需求。

- **Task queue**. This was out of scope for a Python library such as LangGraph, so we ended up creating LangGraph Platform to answer this need.

- **任务队列（Task queue）**。此类功能超出了 LangGraph 这一 Python 库的设计范畴，因此我们另行构建了 LangGraph Platform 来专门满足该需求。

All in all, this architecture delivers the 6 key features needed for agents. At the same time, it makes creating and debugging agents faster, thanks to the structured approach, and the tools to explore it. And finally, it does so with an excellent performance profile, which scales with the size of your agent, and the throughput you need in production –  more on this in the next section.

总而言之，该架构全面实现了智能体所需的六大核心特性。与此同时，依托结构化设计及其配套探索工具，它显著加快了智能体的开发与调试速度。最后，它还具备卓越的性能表现：性能随智能体规模与生产环境所需吞吐量线性扩展——更多细节详见下一节。

## 5\. Performance characteristics

## 5. 性能特征

Like we mentioned earlier, developers want reliability, but not at the expense of latency. So we need to look at how our approach is working against these tradeoffs. LangGraph scales very gracefully with all size measures of the agents you build with it. This is a great place to be in for a future where agents are becoming ever longer, with more steps, more interruptions, larger state, etc.

正如前文所述，开发者既追求可靠性，又不愿以牺牲延迟为代价。因此，我们必须审视本方案在这些权衡取舍中的实际表现。LangGraph 在你构建的所有智能体尺寸指标上均展现出极为优雅的可扩展性。在智能体日趋复杂（步骤更多、中断更频繁、状态更庞大等）的未来图景中，这一特性尤为宝贵。

How is the execution of a LangGraph agent affected by the key variables that control its size?

LangGraph 智能体的执行性能受哪些关键尺寸变量影响？

First, let’s list the key **size variables** in StateGraph, the most common LangGraph developer SDK:

首先，我们列出最常用的 LangGraph 开发者 SDK —— `StateGraph` 中的关键**尺寸变量**：

- The number of nodes (individual steps, usually functions)  
- 节点数量（即独立步骤，通常为函数）

- The number of edges (or the connections between nodes, which can be fixed or conditional)  
- 边的数量（即节点之间的连接关系，可以是固定或条件分支）

- The number of channels (or the keys in your state object)  
- channel 数量（即状态对象 `state` 中的键数量）

- The number of active nodes (to be executed in parallel in a given step)  
- 活跃节点数量（即在某一步骤中需并行执行的节点数）

- The length of invocation history (previous steps of the current invocation)  
- 调用历史长度（即当前调用已执行的前置步骤数）

- The number of threads (independent invocations on different inputs and context)  
- 线程数量（即在不同输入与上下文上发起的独立调用数）

Now, let’s list the key **moments in an invocation** of a LangGraph agent, and see how each scales with each variable:

现在，让我们列出 LangGraph 智能体（agent）一次调用（invocation）中的关键**执行时刻**，并分析每个时刻随各变量变化的复杂度：

- Starting or resuming invocation, which consists of transferring from storage the most recent checkpoint for that thread, and deserializing it  
- 启动或恢复调用：从存储中加载该线程（thread）最新的检查点（checkpoint），并对其进行反序列化。

- Planning the next invocation step, where we decide which nodes to execute next, and prepare their inputs  
- 规划下一步调用：决定接下来需执行哪些节点，并为其准备输入数据。

- Running the active nodes for a step, where we execute the code for each node, producing writes to channels and edges  
- 执行当前激活的节点：运行每个节点的代码，向通道（channels）和边（edges）写入数据。

- Finishing an invocation step, which consists of applying updates to each channel (running channel reducers and bumping channel versions) and saving the latest checkpoint (serializing and transferring to storage)  
- 完成当前调用步骤：对每个通道应用更新（运行通道规约器 channel reducers，并递增通道版本号），并保存最新检查点（序列化后写入存储）。

Note there is no ‘finishing invocation’ action as execution simply stops when the planning action returns no nodes to execute next.

注意：不存在单独的“完成整个调用”操作；当规划阶段返回空节点列表时，执行即自然终止。

In summary, this is how each action scales with agent size:

综上，下表展示了各项操作随智能体规模（agent size）增长的渐进时间复杂度：

| Metric / Action | Starting invocation | Planning a step | Running a step | Finishing a step |
| --- | --- | --- | --- | --- |
| Number of nodes | O(n) | O(1) | O(1) | O(n) |
| 节点数量 | O(n) | O(1) | O(1) | O(n) |
| Number of edges | O(1) | O(1) | O(n) | O(1) |
| 边数量 | O(1) | O(1) | O(n) | O(1) |
| Number of channels | O(n) | O(n) | O(n) | O(n) |
| 通道数量 | O(n) | O(n) | O(n) | O(n) |
| Active nodes | O(1) | O(n) | O(n) | O(n) |
| 当前激活节点数 | O(1) | O(n) | O(n) | O(n) |
| Length of history | O(1) | O(1) | O(1) | O(1) |
| 历史长度 | O(1) | O(1) | O(1) | O(1) |
| Number of threads | O(1) | O(1) | O(1) | O(1) |
| 线程数量 | O(1) | O(1) | O(1) | O(1) |

Now, let’s look more in detail at some of these. First, starting an invocation:

接下来，我们更详细地分析其中几项操作。首先，启动一次调用：

- Scales **linearly with number of nodes**, for each node there is one hidden control channel holding the current state of its incoming edges  
- 随**节点数量呈线性增长**：每个节点对应一个隐藏的控制通道（control channel），用于保存其所有入边（incoming edges）的当前状态。

- **Constant on the number of edges** as the state of all edges for each destination node is collapsed into a single control channel  
- **与边数量无关（O(1)）**：因为每个目标节点的所有入边状态都被聚合到单个控制通道中。

- Scales **linearly with number of channels**, for each channel there is a serialized representation of its current value  
- 随**通道数量呈线性增长**：每个通道均需保存其当前值的序列化表示。

- **Constant on the number of active nodes**, there is no relation to this variable  
- **与当前激活节点数无关（O(1)）**：该变量与启动过程无直接关联。

- **Constant on the length of history**, as we only fetch the latest checkpoint, and don’t need to replay steps before it  
- **与历史长度无关（O(1)）**：我们仅加载最新检查点，无需重放此前的任何步骤。

- **Constant on number of threads**, as threads are completely independent, and each invocation only touches a single one  
- **与线程数量无关（O(1)）**：各线程完全独立，每次调用仅涉及单一线程。

Second, planning the next step:

其次，规划下一步：

- **Constant on the number of nodes**, when finishing the previous step we store the list of updated channels, which lets us avoid iterating over all nodes when planning the next one  
- **与节点数量无关（O(1)）**：在上一步结束时，我们已记录被更新的通道列表，因此规划下一步时无需遍历全部节点。

- **Constant on the number of edges**, as all edges are collapsed into a single trigger channel per node  
- **与边数量无关（O(1)）**：所有边均被聚合为每个节点对应的单个触发通道（trigger channel）。

- Scales **linearly with the number of channels**, when assembling the input for each node we loop over channels to check which are currently set  
- 随**通道数量呈线性增长**：为每个节点组装输入时，需遍历所有通道以判断哪些当前已被设置（set）。

- Scales **linearly with number of active nodes**, for each node to execute in this step we assemble the input and configuration to use for its invocation  
- 随**当前激活节点数呈线性增长**：对本步中每个待执行节点，均需为其组装输入数据与调用配置。

- **Constant on the length of history**, as we only deal with the latest checkpoint, which aggregates all previous writes  
- **与历史长度无关（O(1)）**：我们仅处理最新检查点，而该检查点已聚合了此前所有写入。

- **Constant on number of threads**, as threads are completely independent, and each invocation only touches a single one  
- **与线程数量无关（O(1)）**：各线程完全独立，每次调用仅涉及单一线程。

Third, running a step:  
第三，执行一个步骤：

- **Constant on the number of nodes**, only nodes active in a step influence the running of that step  
- **节点数量为常数**：仅在当前步骤中处于活跃状态的节点会影响该步骤的执行。

- Scales **linearly on the number of edges** of the nodes active in this step, each active node publishes to each of its outgoing edges  
- **与当前步骤中活跃节点的边数呈线性关系**：每个活跃节点向其所有出边发布消息。

- Scales **linearly on the number of channels**, for each active node we check if the node returned an update to its value (when using a dictionary return value we optimize this to be constant on the number of channels, and just iterate over the keys of the return value)  
- **与通道数量呈线性关系**：对每个活跃节点，我们检查其是否返回了值更新（若返回值为字典类型，则此检查被优化为与通道总数无关，仅遍历返回字典的键）。

- Scales **linearly with the number of active nodes**, each active node is executed concurrently  
- **与活跃节点数量呈线性关系**：每个活跃节点被并发执行。

- **Constant on the length of history**, we don’t deal with history at this time  
- **历史长度为常数**：当前实现不处理历史数据。

- **Constant on number of threads**, as threads are completely independent, and each invocation only touches a single one  
- **线程数量为常数**：各线程完全独立，每次调用仅操作单个线程。

Lastly, finishing a step:  
最后，完成一个步骤时：

- Scales **linearly with number of nodes**, for each node there is one hidden control channel holding the current state of its incoming edges  
- **与节点数量呈线性关系**：每个节点对应一条隐藏的控制通道，用于保存其所有入边的当前状态。

- **Constant on the number of edges** as the state of all edges for each destination node is collapsed into a single control channel  
- **边数量为常数**：每个目标节点的所有入边状态被聚合至单条控制通道中。

- Scales **linearly with number of channels**, each channel is updated with the writes from the active nodes, and its version is bumped  
- **与通道数量呈线性关系**：每条通道根据活跃节点的写入进行更新，并递增其版本号。

- Scales **linearly with number of active nodes**, as we collect writes from each active node  
- **与活跃节点数量呈线性关系**：我们从每个活跃节点收集写入数据。

- **Constant on the length of history**, as we only deal with the latest checkpoint, which aggregates all previous writes  
- **历史长度为常数**：我们仅处理最新检查点（checkpoint），该检查点已聚合所有先前的写入。

- **Constant on number of threads**, as threads are completely independent, and each invocation only touches a single one  
- **线程数量为常数**：各线程完全独立，每次调用仅操作单个线程。

These performance characteristics have been the result of both our choice of design for the library, as well as numerous performance optimizations we have made over the past two years.  
上述性能特征既源于我们对该库的整体架构设计选择，也得益于过去两年中实施的大量性能优化工作。

## Getting started  

## 入门指南  

In summary, we thought deeply about what is different about building with LLMs and what it takes your agent to run in production. These ideas led us to build and iterate on LangGraph. LangGraph focuses on control and durability, so you have the best chance of your agent doing what you intended.  
总而言之，我们深入思考了使用大语言模型（LLM）构建应用的独特之处，以及你的智能体（agent）在生产环境中稳定运行所需的关键能力。这些思考促使我们设计并持续迭代 LangGraph。LangGraph 聚焦于**流程控制**与**状态持久性**，从而最大程度确保你的智能体按预期行为执行。

If you want to learn more about LangGraph and test it out for your own projects, head on over to the [docs](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) to get started.  
如果你想进一步了解 LangGraph，并将其应用于自己的项目中，请访问 [文档页面](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 开始上手。