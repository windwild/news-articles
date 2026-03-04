---
title: "Improve agent quality with Insights Agent and Multi-turn Evals, now in LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/insights-agent-multiturn-evals-langsmith/"
date: "2025-10-23"
scraped_at: "2026-03-03T07:20:58.309817012+00:00"
language: "en-zh"
translated: true
description: "LangSmith's new Insights Agent and Multi-turn Evals help you understand what your agents are doing in production and whether they're accomplishing user goals."
---
{% raw %}

**TL;DR:** We’re releasing new capabilities in **LangSmith** to help monitor agents in production. We’re making the concept of “threads” — representing a multi-turn agent interaction — a first-party concept, and we’re adding two new tools to monitor threads: **Insights Agent** for automatically categorizing agent usage patterns, and **Multi-turn Evals** for scoring complete agent conversations.

**简明摘要（TL;DR）：** 我们正在 **LangSmith** 中推出新功能，以帮助在生产环境中监控智能体（agents）。我们将“会话线程（threads）”——即代表多轮次智能体交互的概念——正式确立为平台原生支持的一等概念，并新增两款用于线程监控的工具：**Insights Agent（洞察智能体）**，可自动对智能体使用模式进行分类；以及 **Multi-turn Evals（多轮评估）**，用于对整段智能体对话进行打分评估。

* * *

More and more agents are moving to production. As they do so, AI teams find themselves needing better visibility into what’s happening across all user interactions. But, traditional observability and testing that focus on uptime can't tell whether your agent is actually accomplishing users’ goals. And testing your agent before it goes into production (what we call offline evals) only covers what you had in mind to start.

越来越多的智能体正陆续上线投入生产。随之而来的是，AI 团队亟需更全面地掌握所有用户交互的真实状况。然而，传统可观测性与测试方法往往聚焦于系统可用性（uptime），无法判断你的智能体是否真正达成了用户的实际目标；而上线前开展的智能体测试（我们称之为“离线评估”，offline evals）仅能覆盖你最初预设的测试场景。

Today, we’re releasing new features to help you understand what’s happening inside your agent _while it’s in production_, so you can prioritize improvements:

今天，我们推出全新功能，助你深入理解智能体在**生产环境运行期间**内部的实际行为，从而科学决策、优先推进关键优化：

- **Insight Agent**: automatically categorizes agent behavior patterns  
- **Insight Agent（洞察智能体）**：自动对智能体行为模式进行分类  

- **Multi-turn Evals**: helps you evaluate the complete agent trajectory in each conversation  
- **Multi-turn Evals（多轮评估）**：帮助你评估每一次对话中智能体的完整交互轨迹  

## **Discover patterns in production traces with the Insights Agent**

## **借助 Insights Agent，从生产追踪数据中发现行为模式**

Today's popular agents produce millions of traces per day—soon to be billions. These traces contain valuable signal about an agent's capabilities and how real users engage with it. If you could review each interaction, you would gain deep insight into how to improve your agent. Manual review is time-consuming and impossible at scale, so how can we automate this insight generation process?

当前主流智能体每日生成数百万条追踪记录（traces）——很快将达数十亿条。这些追踪数据蕴含着关于智能体能力表现及真实用户交互方式的宝贵信号。倘若你能逐一审阅每条交互记录，便能获得极具价值的优化洞见。但人工审查既耗时费力，又无法应对海量数据规模。那么，我们该如何自动化这一洞见生成过程？

**Insights Agent** is our first step towards helping LangSmith users find signal in their production traces. Insights Agent analyzes traces to discover and surface common usage patterns, agent behaviors, and failure modes.

**Insights Agent（洞察智能体）** 是我们助力 LangSmith 用户从生产追踪数据中挖掘有效信号迈出的第一步。它通过分析追踪数据，自动识别并呈现高频使用模式、典型智能体行为以及常见故障模式。

In agent engineering, you need to iterate rapidly to build reliable experiences. This new feature helps you answer questions like “What are users asking my agent?”, so you can determine where to focus your next set of tests based on real interactions your agent is having.

在智能体工程实践中，快速迭代是构建稳定可靠用户体验的关键。这一新功能可帮你回答诸如“用户都在向我的智能体询问什么？”之类的核心问题，从而基于智能体在真实场景中的交互数据，精准定位下一阶段测试工作的重点方向。

Once you [trace your data](https://docs.langchain.com/langsmith/observability-quickstart?ref=blog.langchain.com) to LangSmith, you have a few options for how to categorize usage insights.

一旦你将数据[接入 LangSmith 追踪系统](https://docs.langchain.com/langsmith/observability-quickstart?ref=blog.langchain.com)，即可灵活选择多种方式对使用洞察进行分类。

- **Group by usage patterns:** Cluster based on common usage patterns. This helps you understand how users are actually using your agent. When you put a chatbot in front of people, they can ask it anything. Now you can find out what they are asking.  
- **按使用模式分组：** 基于常见的使用模式进行聚类。这有助于您了解用户实际如何使用您的智能体（agent）。当您将一个聊天机器人部署给用户时，他们可以向其提出任何问题；而现在，您能准确获知他们究竟在问什么。

- **Group by poor interactions:** Cluster based on how your agent is messing up. We will look for signals in each conversation that indicate a negative interaction (user getting frustrated, etc), and then group the root causes. This helps you understand common ways your agent fails, so you can prioritize improvements.  
- **按不良交互分组：** 基于您的智能体出错的方式进行聚类。我们将从每段对话中识别表明负面交互的信号（例如用户表现出挫败感等），进而归类其根本原因。这有助于您掌握智能体常见的失败模式，从而有针对性地优先改进。

- **Customize configurations:** Insights Agent is highly configurable. You can specify which categories it should group by, filter on existing attributes (like traces from a particular time period or keywords in a chat), define new attributes, and save configs for future use.  
- **自定义配置：** Insights Agent 具有高度可配置性。您可以指定按哪些类别进行分组，基于现有属性进行筛选（例如特定时间段内的 trace，或聊天内容中的关键词），定义新的属性，并将配置保存以供后续复用。

Generating insights can take up to 15 minutes depending on how much data the agent is crunching. Once the report is ready, you’ll see traces organized into categories and subcategories based on your initial request. You can click into any category to explore the underlying traces and add them to datasets or annotation queues. You can also see other LangSmith metrics split by category, like latency, number of runs, and any evals you have set up.  
生成洞察结果所需时间最长可达 15 分钟，具体取决于智能体正在处理的数据量。报告就绪后，您将看到 trace 按照您的初始请求被组织为若干类别及子类别。您可以点击任一类别，深入查看其底层 trace，并将其添加至数据集或标注队列中。您还可按类别查看其他 LangSmith 指标，例如延迟（latency）、运行次数（number of runs），以及您已配置的各类评估（evals）结果。

Our goal in building this feature was to help you kick off exploration and ideas for improvements as quickly as possible.  
我们开发此功能的目标，是助您以最快速度启动探索工作，并激发改进思路。

**Insights Agent is now generally available** for LangSmith Plus and Enterprise cloud customers. [Sign up for LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) and [check out our docs](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com) to get started.  
**Insights Agent 现已全面开放使用**，面向 LangSmith Plus 及 LangSmith 企业云客户。[立即注册 LangSmith](https://smith.langchain.com/?ref=blog.langchain.com)，并[查阅我们的文档](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com)，即刻开始使用。

## Evaluate end-to-end agent interactions with Multi-turn Evals  
## 使用多轮评估（Multi-turn Evals）端到端评估智能体交互

Once you have a good sense of the top usage patterns your agent is handling, you can start to drill into how each complete conversation is performing. Until now, that’s been tricky — most other evaluation platforms only focus on individual traces or steps, making it hard to understand whether the overall interaction achieved the user’s goal.  
在您充分掌握智能体所处理的主要使用模式之后，便可进一步深入分析每一次完整对话的表现。此前，这项工作颇具挑战性——大多数其他评估平台仅聚焦于单个 trace 或单步操作，难以判断整体交互是否真正达成了用户的最终目标。

Today, we're launching **Multi-turn Evals** to help you measure whether your agent accomplished the user’s goal across an _entire_ interaction. You can do still evaluate at the trace level in LangSmith, but now you can also but also evaluate the whole interaction.  
今天，我们正式推出 **多轮评估（Multi-turn Evals）**，助您衡量智能体是否在整个交互过程中成功实现了用户目标。您仍可在 LangSmith 中对单个 trace 进行评估；而如今，您还可对整段交互进行端到端评估。

Multi-turn evals are online evaluations that let you measure things like:  
多轮评估是一种在线评估机制，支持您衡量以下维度：

- **Semantic intent**: What the user was actually trying to do.  
- **语义意图（Semantic intent）：** 用户实际试图完成的任务。

- **Semantic outcomes:** Whether the task was completed (and if not, why).  
- **语义结果（Semantic outcomes）：** 任务是否已完成（若未完成，原因何在）。

- **Agent trajectory:** How the interaction unfolded, including tool calls and decisions made along the way.  
- **智能体轨迹（Agent trajectory）：** 交互过程的展开路径，包括调用的工具及过程中做出的各项决策。

In LangSmith, we represent these multi-turn exchanges between users and agents as [**threads**](https://docs.langchain.com/langsmith/threads?ref=blog.langchain.com). If you’re already using threads, getting started is simple. Multi-turn evals run automatically once a conversation is complete, and you define the LLM-as-a-judge prompt to guide scoring.  
在 LangSmith 中，我们将用户与智能体之间的多轮交互表示为 [**线程（threads）**](https://docs.langchain.com/langsmith/threads?ref=blog.langchain.com)。若您已在使用线程功能，则上手多轮评估将十分简单：一旦对话结束，多轮评估便会自动运行；您只需定义一个由大语言模型（LLM）担任“裁判”的提示词（prompt），即可指导评分过程。

Insights Agent and Multi-turn evals are the first of several thread-level features we’re working on. Stay tuned for thread-level metrics and dashboards, automations to add threads to an annotation queue and datasets, and SDK support so you can programmatically pull and analyze threads.

Insights Agent 和多轮评估（Multi-turn evals）是我们正在开发的多项线程级（thread-level）功能中的首批功能。敬请期待后续推出的线程级指标与仪表盘、自动将线程加入标注队列及数据集的功能，以及 SDK 支持——您将能够通过编程方式拉取并分析线程。

**Multi-turn evals are live today for all LangSmith users.** [Visit our docs](https://docs.langchain.com/langsmith/online-evaluations?ref=blog.langchain.com#configure-multi-turn-online-evaluators) to get started.

**多轮评估（Multi-turn evals）现已面向所有 LangSmith 用户正式上线。** [请访问我们的文档](https://docs.langchain.com/langsmith/online-evaluations?ref=blog.langchain.com#configure-multi-turn-online-evaluators) 开始使用。

## **Iterate faster with LangSmith**

## **借助 LangSmith 更快迭代**

Our latest LangSmith updates work together to address tough challenges when engineering reliable agents. Now, you can understand what's happening in production (Insights Agent) and measure whether agents accomplish user goals (Multi-turn Evals). These features provide new levels of visibility to help you figure out what’s the best next step to improving your agent.

我们最新发布的 LangSmith 更新协同作用，共同应对构建高可靠性智能体（agents）过程中的关键挑战。现在，您可清晰掌握生产环境中的实际运行状况（Insights Agent），并精准衡量智能体是否真正达成了用户目标（Multi-turn Evals）。这些功能为您带来前所未有的可观测性，助您明确优化智能体的最优下一步行动。

Ready to ship reliable agents? Get started with [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) today.

准备好交付高可靠性的智能体了吗？立即开始使用 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 吧！
{% endraw %}
