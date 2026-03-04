---
render_with_liquid: false
title: "LangChain v0.2: A Leap Towards Stability"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-v02-leap-to-stability/"
date: "2024-05-16"
scraped_at: "2026-03-03T08:02:33.121690299+00:00"
language: "en-zh"
translated: true
description: "LangChain v0.2 decouples langchain and langchain-community packages. Includes versioned docs, standardized tool calling, and LangGraph."
---
render_with_liquid: false
render_with_liquid: false

Four months ago, we released the [first stable version of LangChain](https://blog.langchain.com/langchain-v0-1-0/).

四个月前，我们发布了 [LangChain 的首个稳定版本](https://blog.langchain.com/langchain-v0-1-0/)。

Today, we are following up by announcing a pre-release of `langchain` v0.2.

今天，我们紧接着宣布 `langchain` v0.2 的预发布版本。

This release builds upon the foundation laid in v0.1 and incorporates community feedback. We’re excited to share that v0.2 brings:

本次发布在 v0.1 打下的基础之上进一步演进，并充分吸纳了社区反馈。我们很高兴地向大家介绍，v0.2 带来了以下重要更新：

- A [much-desired](https://github.com/langchain-ai/langchain/discussions/19083?ref=blog.langchain.com) full separation of `langchain` and `langchain-community`

- 一项[社区长期期待](https://github.com/langchain-ai/langchain/discussions/19083?ref=blog.langchain.com)的、`langchain` 与 `langchain-community` 的彻底解耦

- New (and versioned!) docs

- 全新（且支持版本管理！）的文档

- A more mature and controllable agent framework

- 更加成熟、更易掌控的智能体（Agent）框架

- Improved LLM interface standardization, particularly around tool calling

- 对大语言模型（LLM）接口标准的进一步优化，尤其在工具调用（tool calling）方面

- Better streaming support

- 更完善的流式响应（streaming）支持

- 30+ new partner packages.

- 超过 30 个全新合作伙伴包（partner packages）

This is just a pre-release, with the [full v0.2 release](https://github.com/langchain-ai/langchain/discussions/21437?ref=blog.langchain.com) coming in a few weeks. Let’s dive into what `langchain` v0.2 will include.

这仅是一次预发布；[正式版 v0.2](https://github.com/langchain-ai/langchain/discussions/21437?ref=blog.langchain.com) 将于数周后正式推出。接下来，让我们深入了解一下 `langchain` v0.2 将包含哪些内容。

## Embracing stability: The evolution of LangChain architecture

## 拥抱稳定性：LangChain 架构的演进

One of the most notable changes in `langchain` v0.2 is the decoupling of the `langchain` package from `langchain-community`. As a result, `langchain-community` now depends on `langchain-core` and `langchain`. This is a continuation of [the work we began with `langchain` v0.1.0](https://blog.langchain.com/langchain-v0-1-0/) to create a more robust and self-contained package.

`langchain` v0.2 中最显著的变化之一，是将 `langchain` 主包与 `langchain-community` 彻底解耦。由此，`langchain-community` 现在转而依赖 `langchain-core` 和 `langchain`。这一调整延续了我们自 [`langchain` v0.1.0](https://blog.langchain.com/langchain-v0-1-0/) 起所开展的工作——致力于构建一个更健壮、更自包含的软件包体系。

💡

💡

As a reminder, `langchain` v0.1.0 broke down the `langchain` package into component packages to improve the usability of LangChain in production environments. These included `langchain-core`, `langchain`, `langchain-community`, and partner packages. [Read here](https://blog.langchain.com/langchain-v0-1-0/) to learn more.

需要提醒的是，`langchain` v0.1.0 已将原先单一的 `langchain` 包拆分为多个组件包，以提升 LangChain 在生产环境中的可用性。这些组件包括 `langchain-core`、`langchain`、`langchain-community` 以及各类合作伙伴包（partner packages）。[点击此处](https://blog.langchain.com/langchain-v0-1-0/)了解详情。

`langchain-community` contains a lot of third party integrations. This means there are a lot of (optional) dependencies, a lot of files, and due to the nature of the integrations, the package is occasionally vulnerable to CVEs. Hence, removing the dependency of `langchain` on `langchain-community` makes `langchain` more lightweight, more focused, and more secure.

`langchain-community` 包含大量第三方集成模块。这意味着它附带大量（可选）依赖项、大量文件；同时，由于集成本身的特性，该包偶尔会面临 CVE（通用漏洞披露）风险。因此，解除 `langchain` 对 `langchain-community` 的依赖，可使 `langchain` 主包变得更轻量、更专注、也更安全。

We tried to do this reorganization in a minimally disruptive way by continuing to expose the pre-existing entry points, which can be accessed from `langchain.chat_models import ChatOpenAI`. Under the hood, this involves a conditional import from `langchain_community`; essentially, it checks if `langchain-community` is installed, and if so, it does the import. This means that if you have `langchain-community` installed, **there will be no breaking changes.**

我们力求以最小干扰的方式完成此次重构：继续保留所有原有入口点（entry points），例如仍可通过 `langchain.chat_models import ChatOpenAI` 正常调用。其底层实现采用条件导入（conditional import）机制——即先检测 `langchain-community` 是否已安装，若已安装则执行相应导入。这意味着，只要您已安装 `langchain-community`，**您的现有代码将完全不受影响，不会产生任何破坏性变更（no breaking changes）**。

This idea came from a community member - thanks [Jacob](https://github.com/JacobFV?ref=blog.langchain.com)!

这个想法来自一位社区成员——感谢 [Jacob](https://github.com/JacobFV?ref=blog.langchain.com)！

![](images/langchain-v0_2-a-leap-towards-stability/img_001.png)

## Improving discoverability: Better versioned documentation

## 提升可发现性：更完善的版本化文档

We’ve also revamped our documentation based on community feedback. This effort started [over a month ago](https://blog.langchain.com/langchain-documentation-refresh/), and we’re continuing in two main ways.

我们还根据社区反馈全面重构了文档。这项工作早在[一个多月前](https://blog.langchain.com/langchain-documentation-refresh/)就已启动，目前正从以下两个主要方向持续推进。

First, documentation will now be versioned. This has been a constant community request, and we’ve worked hard to make this a reality. We will maintain the existing documentation as a v0.1 build, and start building a separate v0.2 build. For now the documentation will default to v0.1 — but once the full 0.2 release is out, we will begin to default to the new documentation. Our versioned docs should better reflect the state of the package, and we hope to only improve from here.

首先，文档现在支持版本化。这是社区长期提出的一项需求，我们为此付出了大量努力，终于使其成为现实。我们将把现有文档保留为 v0.1 版本，并同步构建独立的 v0.2 版本文档。目前文档默认显示 v0.1 版本；待 v0.2 全量发布后，我们将切换默认版本至新版文档。版本化文档将更准确地反映对应 LangChain 包的实际状态，我们也期待在此基础上持续优化。

Second, documentation is now more flat and simple. There are four main sections: tutorials, how-to guides, conceptual guides, and API reference. This should make it easier to find documentation, and for us to keep a minimal set of consistent guides. This was also a community suggestion - thank you Reddit user @Zealousideal\_Wolf624!

其次，文档结构更加扁平、简洁。新版文档分为四大核心板块：教程（Tutorials）、操作指南（How-to Guides）、概念指南（Conceptual Guides）和 API 参考（API Reference）。这不仅有助于用户更高效地查找所需内容，也便于我们维护一套精简且风格统一的文档体系。这一改进同样源自社区建议——感谢 Reddit 用户 @Zealousideal\_Wolf624！

![](images/langchain-v0_2-a-leap-towards-stability/img_002.png)A suggestion on Reddit for the LangChain documentation

![](images/langchain-v0_2-a-leap-towards-stability/img_002.png)Reddit 上关于 LangChain 文档的一条建议

We’re also working on a [“LangChain over time” documentation page](https://python.langchain.com/v0.2/docs/versions/overview/?ref=blog.langchain.com) to better highlight changes to LangChain. We hope this helps assist in explaining and relating concepts across versions.

我们还在开发一个名为 [“LangChain over time”（LangChain 演进历程）](https://python.langchain.com/v0.2/docs/versions/overview/?ref=blog.langchain.com) 的文档页面，以更清晰地呈现 LangChain 各版本间的演进与变化。我们希望该页面能帮助用户更好地理解不同版本中相关概念的异同与关联。

## Increasing power: LangGraph agents

## 增强能力：LangGraph 智能体

Since the early days of LangChain, one of the biggest points of feedback has been that it’s tough to customize the internals of pre-built chains and agents. We introduced LCEL last summer to solve that for chains, making it easy to create arbitrary composable sequences.

自 LangChain 诞生之初，社区反馈最集中的问题之一便是：难以深度定制预构建链（pre-built chains）和智能体（agents）的内部逻辑。去年夏天，我们推出了 LCEL（LangChain Expression Language），专门用于解决链（chains）的定制难题，使用户能够轻松构建任意可组合的执行序列。

Up until this point, agents in LangChain have always been based around AgentExecutor, a single class with hard coded logic for how to run an agent. We’ve added more and more arguments to this class to support increasingly advanced agents, but it’s still not truly composable.

截至目前，LangChain 中的智能体（agents）始终围绕 `AgentExecutor` 构建——这是一个逻辑硬编码的单一类，用于定义智能体的运行方式。我们不断为该类添加越来越多的参数，以支持日益复杂的智能体，但它仍未真正实现可组合性（composability）。

A few months ago we introduced [LangGraph](https://blog.langchain.com/langgraph/), an extension of LangChain specifically aimed at creating agentic workloads. Think of it as an “LCEL for agents”. It builds on top of LCEL adding in two important components: the ability to easily define cycles (important for agents, but not needed for chains) and built-in memory.

几个月前，我们推出了 [LangGraph](https://blog.langchain.com/langgraph/) —— 这是 LangChain 的一项专门面向构建智能体工作负载（agentic workloads）的扩展。你可以将其理解为“专为智能体设计的 LCEL”。它在 LCEL 基础之上新增了两个关键组件：一是轻松定义循环（cycle）的能力（这对智能体至关重要，但对普通链式调用 chain 并非必需），二是内置内存（built-in memory）。

In `langchain` v0.2, we are keeping the old AgentExecutor — but LangGraph is becoming the recommended way to build agents. We’ve added a prebuilt LangGraph object that is equivalent to AgentExecutor — which, by being built on LangGraph, is far easier to customize and modify. See [here](https://python.langchain.com/v0.2/docs/how_to/migrate_agent/?ref=blog.langchain.com) for documentation on how to migrate.

在 `langchain` v0.2 版本中，我们保留了原有的 `AgentExecutor`，但 LangGraph 已成为构建智能体的**推荐方式**。我们新增了一个预构建的 LangGraph 对象，其功能与 `AgentExecutor` 完全等价；而由于它基于 LangGraph 构建，因此远比旧版更易于定制与修改。有关迁移方法的详细文档，请参见 [此处](https://python.langchain.com/v0.2/docs/how_to/migrate_agent/?ref=blog.langchain.com)。

## Evolving v0.1.0: Improved support for streaming, standardized tool calling, and more

## v0.1.0 的演进：流式响应支持增强、工具调用标准化，及其他改进

Since the release of `langchain` v0.1.0 earlier this year in January, we’ve made sizable improvements in the following areas:

自今年 1 月发布 `langchain` v0.1.0 以来，我们在以下方面实现了显著改进：

- **Standard Chat Model Interface:** We want to make it as easy as possible to switch seamlessly between different LLMs. In order to do this, we’ve [standardized tool calling support](https://blog.langchain.com/tool-calling-with-langchain/) as well as added a standardized interface for [structuring output](https://github.com/langchain-ai/langchain/discussions/18154?ref=blog.langchain.com).

- **标准聊天模型接口（Standard Chat Model Interface）**：我们的目标是让用户能在不同大语言模型（LLM）之间无缝切换，尽可能简单便捷。为此，我们已[统一规范了工具调用（tool calling）的支持方式](https://blog.langchain.com/tool-calling-with-langchain/)，并新增了用于[结构化输出（structuring output）的标准接口](https://github.com/langchain-ai/langchain/discussions/18154?ref=blog.langchain.com)。

- **Async Support:** We’ve improved our async support for many core abstractions. Here’s [an example](https://github.com/langchain-ai/langchain/pull/19332?ref=blog.langchain.com) or [two](https://github.com/langchain-ai/langchain/pull/20037?ref=blog.langchain.com). Huge thanks and shout out to [@cbornet](https://github.com/cbornet?ref=blog.langchain.com) for helping make this a reality!

- **异步支持（Async Support）**：我们增强了众多核心抽象层的异步能力。可参考 [示例一](https://github.com/langchain-ai/langchain/pull/19332?ref=blog.langchain.com) 或 [示例二](https://github.com/langchain-ai/langchain/pull/20037?ref=blog.langchain.com)。特别感谢 [@cbornet](https://github.com/cbornet?ref=blog.langchain.com) 的鼎力协助，让这些改进得以落地！

- **Streaming Support:** Streaming is crucial for LLM applications, and we’ve improved our streaming support by adding in an [Event Streaming API](https://python.langchain.com/docs/expression_language/streaming/?ref=blog.langchain.com#using-stream-events).

- **流式响应支持（Streaming Support）**：流式响应对大语言模型应用至关重要。我们通过引入 [事件流式 API（Event Streaming API）](https://python.langchain.com/docs/expression_language/streaming/?ref=blog.langchain.com#using-stream-events)，大幅提升了流式响应能力。

- **Partner Packages:** Having stable and reliable integrations is a top priority for us. We’ve worked closely with ecosystem partners to add dedicated packages for 20+ providers in Python including MongoDB, Mistral, and Together AI – as well as 17 providers in JavaScript including Google VertexAI, Weaviate, and Cloudflare.

- **合作伙伴集成包（Partner Packages）**：提供稳定可靠的第三方集成是我们工作的重中之重。我们与生态合作伙伴紧密协作，在 Python 中为 MongoDB、Mistral、Together AI 等 **20 多家服务商**提供了专用集成包；在 JavaScript 中则为 Google VertexAI、Weaviate、Cloudflare 等 **17 家服务商**提供了专用集成包。

## How to upgrade

## 如何升级

v0.2 contains many improvements, and we designed it to be largely backwards compatible with minimal breaking changes. We’ve also worked to add a migration CLI to ease any issues, as well as documentation highlighting what has changed between versions.

v0.2 版本包含大量改进，我们在设计时力求最大程度保持向后兼容，仅引入极少破坏性变更。此外，我们还开发了迁移命令行工具（migration CLI）以简化升级过程，并配套提供了详尽的版本变更说明文档。

Check out our [GitHub Discussions thread](https://github.com/langchain-ai/langchain/discussions/21437?ref=blog.langchain.com) for details on how to test the CLI and install the v0.2 pre-release. And stay tuned for a full migration guide on the week of May 20th.

请查阅我们的 [GitHub 讨论帖](https://github.com/langchain-ai/langchain/discussions/21437?ref=blog.langchain.com)，了解如何测试该 CLI 工具及安装 v0.2 预发布版本。敬请期待——完整迁移指南将于 **5 月 20 日当周正式发布**。

## Why stability matters to us

## 为何稳定性对我们至关重要

We value the trust of our 1M+ developers relying on LangChain. As we evolve LangChain, we’re committed to delivering industry-leading solutions while ensuring a foundational framework for engineering teams to confidently use in production.

我们非常珍视全球超过 100 万开发者对 LangChain 的信任。随着 LangChain 的持续演进，我们致力于提供业界领先的解决方案，同时确保构建一个坚实可靠的基础框架，让工程团队能够自信地将其投入生产环境使用。

While `langchain` and `langchain-core` are currently in a pre-1.0 state, we strive to minimize breaking changes and deprecate classes at least 1 full breaking release ahead of time (3–6 months). Our release cadence also ensures regular updates and bug fixes, keeping the LangChain platform reliable and production-ready. We’ll also continue to maintain a 0.1 version, to which we’ll push critical bug fixes for 3 months. [See here](https://langchain-k76cqa5gs-langchain.vercel.app/v0.2/docs/upgrading/release_policy/?ref=blog.langchain.com) for more on our release and deprecation policy.

尽管 `langchain` 和 `langchain-core` 当前仍处于预 1.0 版本阶段，我们仍努力将破坏性变更降至最低，并至少提前一个完整的大版本（3–6 个月）对类进行弃用标记。我们的发布节奏也确保了定期更新与缺陷修复，从而保障 LangChain 平台的稳定性与生产就绪性。此外，我们还将继续维护 0.1 版本，并在该版本上推送关键缺陷修复，持续支持 3 个月。[点击此处](https://langchain-k76cqa5gs-langchain.vercel.app/v0.2/docs/upgrading/release_policy/?ref=blog.langchain.com)了解我们的版本发布与弃用策略详情。

* * *

[**We’d love to hear from you**](https://github.com/langchain-ai/langchain/discussions/21437?ref=blog.langchain.com) **on GitHub on all things LangChain v2.0. And if you’re new to LangChain, follow our** [**quickstart guide**](https://python.langchain.com/v0.1/docs/get_started/quickstart/?ref=blog.langchain.com) **to get started.**

[**诚挚邀请您参与讨论**](https://github.com/langchain-ai/langchain/discussions/21437?ref=blog.langchain.com)——欢迎在 GitHub 上就 LangChain v2.0 的所有相关话题分享您的见解与反馈。若您是 LangChain 新用户，可参考我们的[**快速入门指南**](https://python.langchain.com/v0.1/docs/get_started/quickstart/?ref=blog.langchain.com)立即开始使用。

### Tags

### 标签