---
title: "LangGraph: Multi-Agent Workflows"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-multi-agent-workflows/"
date: "2025-02-26"
scraped_at: "2026-03-03T07:38:35.995827349+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

**Links**

**链接**

- [Python 示例](https://github.com/langchain-ai/langgraph/tree/main/examples/multi_agent?ref=blog.langchain.com)
- [JS 示例](https://github.com/langchain-ai/langgraphjs/blob/main/examples/multi_agent?ref=blog.langchain.com)
- [YouTube 视频](https://youtu.be/hvAPnpSfSGo?ref=blog.langchain.com)

Last week we highlighted [LangGraph](https://blog.langchain.com/langgraph/) \- a new package (available in both [Python](https://pypi.org/project/langgraph/?ref=blog.langchain.com) and [JS](https://www.npmjs.com/package/@langchain/langgraph?ref=blog.langchain.com)) to better enable creation of LLM workflows containing _cycles_, which are a critical component of most agent runtimes. As a part of the launch, we highlighted two simple runtimes: one that is the equivalent of the AgentExecutor in `langchain`, and a second that was a version of that aimed at message passing and chat models.

上周，我们重点介绍了 [LangGraph](https://blog.langchain.com/langgraph/) —— 一个全新发布的软件包（同时支持 [Python](https://pypi.org/project/langgraph/?ref=blog.langchain.com) 和 [JS](https://www.npmjs.com/package/@langchain/langgraph?ref=blog.langchain.com)），旨在更高效地构建包含 **循环（cycles）** 的大语言模型（LLM）工作流；而循环正是绝大多数智能体（agent）运行时的核心组件。在发布之际，我们展示了两种简易的运行时实现：其一等效于 `langchain` 中的 `AgentExecutor`；其二则专为消息传递与对话模型（chat models）优化的变体。

Today, we're excited to highlight a second set of use cases for `langgraph` \- multi-agent workflows. In this blog we will cover:

今天，我们非常高兴地向大家介绍 `langgraph` 的第二类典型应用场景——**多智能体（multi-agent）工作流**。本文将涵盖以下内容：

- What does "multi-agent" mean?  
- “多智能体”是什么意思？
- Why are "multi-agent" workflows interesting?  
- 为何“多智能体”工作流值得关注？
- Three concrete examples of using LangGraph for multi-agent workflows  
- 使用 LangGraph 构建多智能体工作流的三个具体示例
- Two examples of third-party applications built on top of LangGraph using multi-agent workflows (GPT-Newspaper and CrewAI)  
- 基于 LangGraph、采用多智能体工作流构建的两个第三方应用实例（GPT-Newspaper 和 CrewAI）
- Comparison to other frameworks (Autogen and CrewAI)  
- 与其他框架（Autogen 和 CrewAI）的对比

## What is "multi-agent"?

## 什么是“多智能体”？

💡

When we are talking about "multi-agent", we are talking about **multiple independent actors** **powered by language models** **connected in a specific way**.

💡

当我们谈论“多智能体”时，指的是 **多个彼此独立的智能体角色**，它们 **由大语言模型驱动**，并 **以特定方式相互连接**。

Each agent can have its own prompt, LLM, tools, and other custom code to best collaborate with the other agents.

每个智能体均可拥有专属的提示词（prompt）、大语言模型（LLM）、工具集及其他自定义代码，从而实现与其他智能体的最优协同。

That means there are two main considerations when thinking about different multi-agent workflows:

这意味着，在设计或评估各类多智能体工作流时，需重点关注以下两个核心要素：

1. 什么是多个独立智能体（multiple independent agents）？  
2. 这些智能体之间如何连接？

This thinking lends itself incredibly well to a graph representation, such as that provided by `langgraph`. In this approach, each agent is a node in the graph, and their connections are represented as an edge. The control flow is managed by edges, and they communicate by adding to the graph's state.

这种思路天然契合图（graph）结构的表达方式，例如 `langgraph` 所提供的图模型。在此范式中，每个智能体对应图中的一个节点（node），而它们之间的连接则以边（edge）表示。控制流由边来管理，各智能体则通过向图的状态（state）中添加数据实现通信。

Note: a very related concept here is the concept of _state machines,_ which we explicitly called out as a category of cognitive architectures. When viewed in this way, the independent agent nodes become the states, and how those agents are connected is the transition matrices. [Since a state machine can be viewed as a labeled, directed graph](https://www.cs.cornell.edu/courses/cs211/2006sp/Lectures/L26-MoreGraphs/state_mach.html?ref=blog.langchain.com#:~:text=State%20machine%20as%20a%20graph,labeled%20with%20the%20corresponding%20events.), we will think of these things in the same way.

注意：与此高度相关的一个概念是**状态机（state machines）**，我们此前已明确将其归类为一类认知架构（cognitive architectures）。若从该视角出发，这些独立的智能体节点即对应状态机中的各个“状态（states）”，而智能体之间的连接方式则对应“状态转移矩阵（transition matrices）”。[由于状态机本身可被建模为一种带标签的有向图（labeled, directed graph）](https://www.cs.cornell.edu/courses/cs211/2006sp/Lectures/L26-MoreGraphs/state_mach.html?ref=blog.langchain.com#:~:text=State%20machine%20as%20a%20graph,labeled%20with%20the%20corresponding%20events.)，我们将统一采用图结构的视角来理解这两者。

## Benefits of multi-agent designs

## 多智能体设计的优势

"If one agent can't work well, then why is multi-agent useful?"

“如果单个智能体都无法良好工作，那么多智能体设计又有何用？”

- Grouping tools/responsibilities can give better results. An agent is more likely to succeed on a focused task than if it has to select from dozens of tools.  
- 对工具或职责进行分组可提升整体效果。相较于需从数十种工具中自行选择的通用型智能体，专注于单一任务的智能体更有可能成功完成任务。

- Separate prompts can give better results. Each prompt can have its own instructions and few-shot examples. Each agent could even be powered by a separate fine-tuned LLM!  
- 独立设计的提示词（prompts）可带来更优结果。每个提示词均可配备专属指令与少样本示例（few-shot examples）；甚至每个智能体都可由一个独立微调过的大型语言模型（fine-tuned LLM）驱动！

- Helpful conceptual model to develop. You can evaluate and improve each agent individually without breaking the larger application.  
- 提供有益的抽象建模方式。你可对每个智能体单独评估与优化，而不会破坏整个应用系统的稳定性。

Multi-agent designs allow you to divide complicated problems into tractable units of work that can be targeted by specialized agents and LLM programs.

多智能体设计使你能够将复杂问题拆解为若干可处理的工作单元，并交由专业化的智能体及 LLM 程序分别处理。

## Multi-agent examples

## 多智能体示例

We've added three separate example of multi-agent workflows to the `langgraph` repo. Each of these has slightly different answers for the above two questions, which we will go over when we highlight the examples. It's important to note that these three examples are only a few of the possible examples we could highlight - there are almost assuredly other examples out there and we look forward to seeing what the community comes up with!

我们已在 `langgraph` 代码仓库中新增了三个独立的多智能体工作流（multi-agent workflow）示例。针对前述两个核心问题（“什么是多个独立智能体？”与“这些智能体如何连接？”），每个示例均提供了略有差异的解答——我们将在逐一介绍这些示例时详细展开说明。需要特别指出的是，这三项示例仅是我们所能列举的众多可能性中的一小部分；现实中必然还存在大量其他可行方案，我们也热切期待社区成员贡献更多创新实践！

### Multi Agent Collaboration

### 多智能体协同

**Code links**:

**代码链接**：

- [Python](https://github.com/langchain-ai/langgraph/blob/main/examples/multi_agent/agent_supervisor.ipynb?ref=blog.langchain.com)
- [JS](https://github.com/langchain-ai/langgraphjs/blob/main/examples/multi_agent/multi-agent-collaboration.ipynb?ref=blog.langchain.com)

In this example, the different agents collaborate on a **shared** scratchpad of messages. This means that all the work either of them do is visible to the other. This has the benefit that other agents can see all the individual steps done. This has the downside that sometimes is it overly verbose and unnecessary to pass ALL this information along, and sometimes only the final answer from an agent is needed. We call this **collaboration** because of the shared nature the scratchpad.

本示例中，不同智能体在一个**共享**的消息草稿区（scratchpad）上协同工作。这意味着任一智能体所执行的所有操作均对另一方可见。其优势在于：其他智能体可完整观察到每个步骤；其劣势在于：有时传递全部信息过于冗长且不必要，而往往仅需某个智能体的最终答案即可。我们之所以称其为**协作式（collaboration）**，正是源于该草稿区的共享特性。

**What are the multiple independent agents?**

**什么是多个独立智能体？**

In this case, the independent agents are actually just a single LLM call. Specifically, they are a specific prompt template (to format inputs in a specific way with a specific system message) plus an LLM call.

本例中，这些“独立”智能体实际上各自仅对应一次大语言模型（LLM）调用。具体而言，每个智能体由一个特定提示模板（用于以特定格式组织输入，并配以特定的系统消息）与一次 LLM 调用共同构成。

**How are those agents connected?**

**这些智能体如何连接？**

Here is a visualization of how these agents are connected:

以下是这些智能体之间连接关系的可视化示意图：

![](images/langgraph-multi-agent-workflows/img_001.png)

The main thing controlling the state transitions is the _router_, but it is a rule-based router and so is rather quite simple. Basically, after each LLM call it looks at the output. If a tool is invoked, then it calls that tool. If no tool is called and the LLM responds "FINAL ANSWER" then it returns to the user. Otherwise (if no tool is called and the LLM does not respond "FINAL ANSWER") then it goes to the other LLM.

主导状态流转的核心组件是 _路由器（router）_；但该路由器基于规则实现，因此逻辑相当简洁：每次 LLM 调用后，它会检查输出结果——若输出指示调用某工具，则立即执行该工具；若未调用任何工具，且 LLM 返回 “FINAL ANSWER”，则将结果返回给用户；其余情况下（即未调用工具，且 LLM 未返回 “FINAL ANSWER”），则将流程交由另一 LLM 继续处理。

### Agent Supervisor

### 智能体监督器（Agent Supervisor）

**Examples:**

**示例：**

- [Python](https://github.com/langchain-ai/langgraph/blob/main/examples/multi_agent/agent_supervisor.ipynb?ref=blog.langchain.com)
- [JS](https://github.com/langchain-ai/langgraphjs/blob/main/examples/multi_agent/agent_supervisor.ipynb?ref=blog.langchain.com)

In this example, multiple agents are connected, but compared to above they do NOT share a shared scratchpad. Rather, they have their own independent scratchpads, and then their final responses are appended to a global scratchpad.

本示例中，多个智能体相互连接，但与前述示例不同，它们**不共享同一个暂存区（scratchpad）**；相反，每个智能体拥有各自独立的暂存区，其最终响应结果则被追加至一个全局暂存区中。

**What are the multiple independent agents?**

**多个独立智能体是什么？**

In this case, the independent agents are a LangChain agent. This means they have their own individual prompt, LLM, and tools. When called, it's not just a single LLM call, but rather a run of the AgentExecutor.

本例中的独立智能体是 LangChain 智能体，即每个智能体都拥有专属的提示词（prompt）、大语言模型（LLM）及工具集。调用时，并非仅执行一次 LLM 推理，而是完整运行一次 `AgentExecutor`。

**How are those agents connected?**

**这些智能体如何连接？**

An **agent supervisor** is responsible for routing to individual agents.

一个**智能体监管者（agent supervisor）** 负责将任务路由至各个独立智能体。

![](images/langgraph-multi-agent-workflows/img_002.png)

In this way, the supervisor can also be thought of an agent whose tools are other agents!

由此，该监管者本身也可被视为一种特殊的智能体——其“工具”正是其他智能体！

### Hierarchical Agent Teams

### 分层式智能体团队

**Examples:**

**示例：**

- [Python](https://github.com/langchain-ai/langgraph/blob/main/examples/multi_agent/hierarchical_agent_teams.ipynb?ref=blog.langchain.com)
- [JS](https://github.com/langchain-ai/langgraphjs/blob/main/examples/multi_agent/hierarchical_agent_teams.ipynb?ref=blog.langchain.com)

This is similar to the above example, but now the agents in the nodes are actually other `langgraph` objects themselves. This provides even more flexibility than using LangChain AgentExecutor as the agent runtime. We call this _hierarchical teams_ because the subagents can in a way be thought of as teams.

此例与上述示例类似，但节点中的智能体（agents）本身即为其他 `langgraph` 对象。相比使用 LangChain 的 `AgentExecutor` 作为智能体运行时，这种方式提供了更高的灵活性。我们将这种结构称为**分层团队（hierarchical teams）**，因为子智能体在某种意义上可被视为独立的团队。

**What are the multiple independent agents?**

**多个独立智能体指什么？**

These are now other `langgraph` agents.

这些现在是其他 `langgraph` 智能体。

**How are those agents connected?**

**这些智能体如何连接？**

A supervisor agent connects them.

由一个**主管智能体（supervisor agent）** 将它们连接起来。

![](images/langgraph-multi-agent-workflows/img_003.png)

## YouTube Walkthrough

## YouTube 演示视频

We've added a YouTube video to walk through these three examples. Hopefully this helps makes these complex topics a little easier to understand!

我们已添加一段 YouTube 视频，逐个讲解这三个示例。希望这有助于您更轻松地理解这些复杂概念！

## Third Party Applications

## 第三方应用

As part of this launch, we're also excited to highlight a few applications built on top of LangGraph that utilize the concept of multiple agents.

作为本次发布的一部分，我们也很高兴重点介绍几款基于 LangGraph 构建、并运用了多智能体（multiple agents）理念的应用。

### [GPT-Newspaper](https://github.com/assafelovic/gpt-newspaper?ref=blog.langchain.com)

### [GPT-Newspaper](https://github.com/assafelovic/gpt-newspaper?ref=blog.langchain.com)

This is a new project by the minds by [GPT-Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com). GPT-Newspaper is an innovative autonomous agent designed to create personalized newspapers tailored to user preferences. GPT Newspaper revolutionizes the way we consume news by leveraging the power of AI to curate, write, design, and edit content based on individual tastes and interests. The architecture consists of six specialized sub-agents. There is one key step - a writer <> critique loop which adds in a helpful cycle.

这是由 [GPT-Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) 团队推出的全新项目。GPT-Newspaper 是一款创新的自主智能体，旨在根据用户偏好生成高度个性化的电子报纸。它借助 AI 的强大能力，对新闻内容进行筛选、撰写、排版与编辑，彻底革新了我们获取新闻的方式。其系统架构包含六个专业化的子智能体；其中关键一步是“作者 ↔ 批评者”循环（writer <> critique loop），该机制引入了一个富有成效的反馈闭环。

![](images/langgraph-multi-agent-workflows/img_004.png)

![](images/langgraph-multi-agent-workflows/img_004.png)

## Other Frameworks

## 其他框架

LangGraph is not the first framework to support multi-agent workflows. Most of the difference between these frameworks largely lies in the mental models and concepts they introduce.

LangGraph 并非首个支持多智能体工作流的框架。这些框架之间的主要差异，大多体现在它们所引入的思维模型（mental models）与核心概念上。

### Autogen

### Autogen

Autogen emerged as perhaps the first multi-agent framework. The biggest difference in mental model between LangGraph and Autogen is in construction of the agents. LangGraph prefers an approach where you explicitly define different agents and transition probabilities, preferring to represent it as a graph. Autogen frames it more as a "conversation". We believe that this "graph" framing makes it more intuitive and provides better developer experience for constructing more complex and opinionated workflows where you really want to control the transition probabilities between nodes. It also supports workflows that _aren't_ explicitly captured by "conversations."

Autogen 或许是最早出现的多智能体框架。LangGraph 与 Autogen 在思维模型上的最大区别，体现在智能体的构建方式上：LangGraph 倾向于显式定义各类智能体及其状态转移概率，并将整个流程建模为一张图（graph）；而 Autogen 则更倾向于将其视为一场“对话”（conversation）。我们认为，“图”这一建模方式更为直观，在构建复杂且具有明确设计意图的工作流时——尤其是当你需要精细控制节点间转移概率时——能为开发者提供更佳的体验。此外，LangGraph 还支持那些无法被简单归类为“对话”的工作流场景。

Another key difference between Autogen and LangGraph is that LangGraph is fully integrated into the LangChain ecosystem, meaning you take fully advantage of all the LangChain integrations and LangSmith observability.

Autogen 与 LangGraph 的另一关键区别在于：LangGraph 深度集成于 LangChain 生态系统之中，这意味着你可以无缝使用 LangChain 提供的所有集成能力，以及 LangSmith 提供的完整可观测性（observability）功能。

### CrewAI

### CrewAI

Another key framework we want to highlight is CrewAI. CrewAI has emerged recently as a popular way to create multi-agent "teams". Compared to LangGraph, CrewAI is a higher-level framework, while LangGraph gives much more lower-level controllability over your agents.

我们想重点介绍的另一个关键框架是 CrewAI。CrewAI 近期崭露头角，成为构建多智能体“团队”的一种流行方式。与 LangGraph 相比，CrewAI 是一个更高层级的框架，而 LangGraph 则为开发者提供了对智能体更底层、更精细的控制能力。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](images/langgraph-multi-agent-workflows/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/langgraph-multi-agent-workflows/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langgraph-multi-agent-workflows/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/langgraph-multi-agent-workflows/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/langgraph-multi-agent-workflows/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/langgraph-multi-agent-workflows/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/langgraph-multi-agent-workflows/img_008.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/langgraph-multi-agent-workflows/img_008.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/langgraph-multi-agent-workflows/img_009.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更轻松的评估](images/langgraph-multi-agent-workflows/img_009.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更轻松的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langgraph-multi-agent-workflows/img_010.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台处于 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/langgraph-multi-agent-workflows/img_010.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台处于 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟