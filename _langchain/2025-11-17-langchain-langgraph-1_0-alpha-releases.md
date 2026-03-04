---
title: "LangChain & LangGraph 1.0 alpha releases"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-langchain-1-0-alpha-releases/"
date: "2025-11-17"
scraped_at: "2026-03-03T07:18:57.203831832+00:00"
language: "en-zh"
translated: true
---
{% raw %}

Today we are announcing alpha releases of v1.0 for [`langgraph`](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) and [`langchain`](https://github.com/langchain-ai/langchain?ref=blog.langchain.com), in both Python and JS.  

今天我们宣布 [`langgraph`](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 和 [`langchain`](https://github.com/langchain-ai/langchain?ref=blog.langchain.com) 的 v1.0 Alpha 版本正式发布，支持 Python 和 JavaScript 两种语言。

LangGraph is a low-level agent orchestration framework, giving developers durable execution and fine-grained control to run complex agentic systems in production.  

LangGraph 是一个底层的智能体（agent）编排框架，为开发者提供持久化执行能力与细粒度控制能力，助力在生产环境中运行复杂的智能体系统。

LangChain helps developers ship AI features fast with standardized model abstractions and prebuilt agent patterns, making it easy to build complex applications without vendor lock-in.  

LangChain 帮助开发者借助标准化的大模型抽象接口和预构建的智能体模式，快速交付 AI 功能，轻松构建复杂应用，同时避免厂商锁定（vendor lock-in）。

We are working towards an official 1.0 release in late October - please give us any feedback [here](https://forum.langchain.com/t/langchain-1-0-alpha/1436?ref=blog.langchain.com)!

我们正全力推进 v1.0 正式版发布，预计于十月底上线——欢迎通过 [此处](https://forum.langchain.com/t/langchain-1-0-alpha/1436?ref=blog.langchain.com) 提供您的宝贵反馈！

## LangGraph

## LangGraph

[`langgraph`](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com) has been battle tested as companies like [Uber](https://www.youtube.com/watch?v=8rkA5vWUE4Y&ref=blog.langchain.com), [LinkedIn](https://www.linkedin.com/blog/engineering/ai/practical-text-to-sql-for-data-analytics?ref=blog.langchain.com), and [Klarna](https://blog.langchain.com/customers-klarna/) use it in production.  

[`langgraph`](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com) 已经经过实战检验：优步（[Uber](https://www.youtube.com/watch?v=8rkA5vWUE4Y&ref=blog.langchain.com)）、领英（[LinkedIn](https://www.linkedin.com/blog/engineering/ai/practical-text-to-sql-for-data-analytics?ref=blog.langchain.com)）和 Klarna（[Klarna](https://blog.langchain.com/customers-klarna/)）等公司已在生产环境中部署使用。

We are promoting it to 1.0 with no breaking changes. It comes with a built in agent runtime ( [durable execution](https://docs.langchain.com/oss/python/langgraph/durable-execution?ref=blog.langchain.com), [short term memory](https://docs.langchain.com/oss/python/langgraph/persistence?ref=blog.langchain.com), [human in the loop patterns](https://docs.langchain.com/oss/python/langchain/human-in-the-loop?ref=blog.langchain.com), streaming), and be used to build [arbitrary workflows](https://docs.langchain.com/oss/python/langgraph/use-graph-api?ref=blog.langchain.com) and agentic patterns.

我们将它正式升级至 v1.0，且**不引入任何破坏性变更（no breaking changes）**。新版内置智能体运行时（[持久化执行](https://docs.langchain.com/oss/python/langgraph/durable-execution?ref=blog.langchain.com)、[短期记忆](https://docs.langchain.com/oss/python/langgraph/persistence?ref=blog.langchain.com)、[人工介入模式（human-in-the-loop）](https://docs.langchain.com/oss/python/langchain/human-in-the-loop?ref=blog.langchain.com)、流式响应），并支持构建[任意工作流](https://docs.langchain.com/oss/python/langgraph/use-graph-api?ref=blog.langchain.com)与各类智能体模式。

## LangChain

## LangChain

[`langchain`](https://docs.langchain.com/oss/javascript/langchain-overview?ref=blog.langchain.com) has always contained high level interfaces for getting started with different agent patterns as easily as possible.  

[`langchain`](https://docs.langchain.com/oss/javascript/langchain-overview?ref=blog.langchain.com) 一直以来都提供高层级接口，让开发者能以最简单的方式快速上手各类智能体模式。

Early on, there were a handful of these patterns (these made up all the chains and agents originally in `langchain`). Over the past two years, we have realized that:

早期，这类模式仅有寥寥数种（它们构成了 `langchain` 最初全部的 Chains 和 Agents）。过去两年中，我们逐渐认识到：

- A number of use cases need completely custom patterns. For these - we recommend `langgraph` and building your own  
- 许多实际场景需要完全定制化的模式——对此，我们推荐使用 `langgraph` 自行构建；

- The rest have consolidated around a particular implementation of an “agent”  
- 其余场景则逐步收敛到某一种特定的“智能体（agent）”实现方式上。

This "agent" abstraction is largely:

这一“智能体”抽象的核心逻辑大致如下：

1. Give an LLM access to some tools  
1. 向大语言模型（LLM）授予若干工具（tools）的调用权限；

2. Call it with some input  
2. 以某些输入调用该模型；

3. If it calls a tool:  
3. 若模型调用了某个工具：  
 1. Execute that tool  
 1. 执行该工具；  
 2. Return to step 2, adding back in the tool call and tool result  
 2. 返回第 2 步，将工具调用及执行结果一并传回；

4. If it doesn't call a tool: finish  
4. 若模型未调用任何工具，则任务结束。

We've had this abstraction in LangChain from the early days - in [November of 2022](https://x.com/hwchase17/status/1595456660507459585?ref=blog.langchain.com). It's evolved over the years as things like tool calling have emerged to make this easier.

这一抽象自 LangChain 诞生之初便已存在——最早可追溯至 [2022 年 11 月](https://x.com/hwchase17/status/1595456660507459585?ref=blog.langchain.com)。随着工具调用（tool calling）等能力的逐步成熟，该范式也在持续演进，变得愈发易用。

In LangChain 1.0 we are focusing the `langchain` package centered around this abstraction, and are introducing a new [`create_agent`](https://docs.langchain.com/oss/javascript/langchain/agents?ref=blog.langchain.com) implementation - same high level interface, different underpinning.  

在 LangChain v1.0 中，我们将 `langchain` 包的核心聚焦于上述智能体抽象，并推出全新的 [`create_agent`](https://docs.langchain.com/oss/javascript/langchain/agents?ref=blog.langchain.com) 实现方案——对外保持相同的高层级接口，但底层实现已全面重构。

We built this implementation on top of `langgraph` to take advantage of the underlying agent runtime. While this is new to the `langchain` package, it's not new to the LangChain ecosystem. This has been battle tested over the past year as part of `langgraph.prebuilts`.  

该实现构建于 `langgraph` 之上，从而充分利用其底层智能体运行时能力。虽然这对 `langchain` 包而言是全新功能，但在 LangChain 生态中早已不是新鲜事物——过去一年间，它作为 `langgraph.prebuilts` 的一部分，已在真实场景中历经充分验证。

You can try this out easily with:  

您可通过以下方式轻松体验：

**Python**: `from langchain.agents import create_agent`

**Python**: `from langchain.agents import create_agent`

**JS**: `import { createAgent } from "langchain"`

**JavaScript**: `import { createAgent } from "langchain"`

If you are using existing `langchain` chains and agents - don't worry. We will be releasing a `langchain-legacy` package, allowing developers to continue using these old chains and agents, while also updating the new and improved `langchain` 1.0 should they choose.

如果您正在使用现有的 `langchain` 链（chains）和智能体（agents），请放心。我们将发布一个 `langchain-legacy` 包，使开发者能够继续使用这些旧版链与智能体；同时，您也可根据需要升级至全新且更完善的 `langchain` 1.0 版本。

### LangChain Core

### LangChain 核心模块

A key part of `langchain` that is staying the same are the integration abstractions. LangChain contains 1000s of integrations with providers like OpenAI, Anthropic, etc. These abstractions technically live in `langchain-core` \- a base package we created for the sole purpose of containing these abstractions.

`langchain` 中保持不变的关键部分之一是集成抽象层（integration abstractions）。LangChain 目前已支持上千种与各类服务商（如 OpenAI、Anthropic 等）的集成。这些抽象层在技术上归属于 `langchain-core` —— 这是我们专门创建的基础包，唯一目的就是承载这些抽象定义。

We are promoting `langchain-core` to 1.0 with no breaking changes, but with a core addition.

我们将把 `langchain-core` 升级至 1.0 版本，此次升级不引入任何破坏性变更，但新增了一项核心功能。

A big part of `langchain-core` is the concept of “messages”, how we communicate with LLM apis. In 1.0, we are introducing more structure around how these messages are formatted (in a backwards compatible way). A big value prop of LangChain has always been standard ways to interact with LLMs. The ways to interact with LLMs has changed over time - it started as strings, then went to messages (where the `content` of each message was a string). Now, however, LLM APIs are returning lists of content _blocks_. As such, we are introducing a new `.content_blocks` property which has standard content types. You can read all about content blocks [here](https://docs.langchain.com/oss/python/langchain/messages?ref=blog.langchain.com#content).

`langchain-core` 的一大核心概念是“消息”（messages）——即我们与大语言模型（LLM）API 通信的方式。在 1.0 版本中，我们为消息格式引入了更严谨的结构化设计（完全向后兼容）。LangChain 的核心价值主张之一，始终是提供与 LLM 交互的标准方式。而这种交互方式本身也在不断演进：最初仅以纯字符串（string）形式传递；随后发展为消息对象（message），其中每条消息的 `content` 字段仍为字符串；如今，LLM API 则开始返回由多种内容块（content blocks）组成的列表。因此，我们新增了一个 `.content_blocks` 属性，用以统一承载标准化的内容类型。有关内容块的全部细节，请参阅[此处文档](https://docs.langchain.com/oss/python/langchain/messages?ref=blog.langchain.com#content)。

## Documentation

## 文档

Finally - we are also launching a [new docs site](https://docs.langchain.com/oss/python/releases/langchain-v1?ref=blog.langchain.com) for all these open source projects. These docs centralize our open source docs in one place, and also provide one unified page for both Python and Javascript. We've heard you ask for a more centralized and easy to follow documentation site. This has been - and will continue to be - a big focus of ours.

最后，我们还为所有这些开源项目同步上线了[全新的文档网站](https://docs.langchain.com/oss/python/releases/langchain-v1?ref=blog.langchain.com)。该网站将 LangChain 全部开源项目的文档集中整合于一处，并为 Python 和 JavaScript 提供统一的查阅页面。我们已收到大量用户反馈，呼吁构建一个更集中、更易浏览的文档站点。这一直是、也仍将持续是我们工作的重中之重。

## Try it out

## 立即体验

We're excited to announce the 1.0 alphas today. You can try them out easily:

我们很高兴地宣布今天发布 LangChain 和 LangGraph 的 1.0 alpha 版本。您可以轻松尝试：

**JavaScript**

**JavaScript**

LangChain: `npm install langchain@next`

LangChain：`npm install langchain@next`

LangGraph: `npm install @langchain/langgraph@alpha`

LangGraph：`npm install @langchain/langgraph@alpha`

**Python**

**Python**

LangChain: `pip install langchain==1.0.0a3`

LangChain：`pip install langchain==1.0.0a3`

LangGraph: `pip install langgraph==1.0.0a1`

LangGraph：`pip install langgraph==1.0.0a1`

Again - please give us feedback on these 1.0 releases (and docs) [here](https://forum.langchain.com/t/langchain-1-0-alpha/1436?ref=blog.langchain.com). You can also find GitHub discussion items ( [LangChain](https://github.com/langchain-ai/langchain/issues/32794?ref=blog.langchain.com), [LangGraph](https://github.com/langchain-ai/langgraph/issues/6062?ref=blog.langchain.com)). This is a big milestone - we are excited to work on this with the community over the next two months.

再次诚邀您就本次 1.0 版本（及配套文档）提供宝贵反馈，欢迎前往 [此处](https://forum.langchain.com/t/langchain-1-0-alpha/1436?ref=blog.langchain.com) 留言。您也可查阅 GitHub 上的相关讨论话题（[LangChain](https://github.com/langchain-ai/langchain/issues/32794?ref=blog.langchain.com)、[LangGraph](https://github.com/langchain-ai/langgraph/issues/6062?ref=blog.langchain.com)）。这是一个重要的里程碑——我们非常期待在未来两个月内与社区携手共进，持续推进这一版本的完善与发展。
{% endraw %}
