---
title: "Not Another Workflow Builder"
source: "LangChain Blog"
url: "https://blog.langchain.com/not-another-workflow-builder/"
date: "2025-10-10"
scraped_at: "2026-03-03T07:27:04.081367316+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes", "![Deep Agents", "**Deep Agents**"]
---

_By Harrison Chase_

_作者：Harrison Chase_

One of the most common requests we’ve gotten from day zero of LangChain has been a visual workflow builder. We never pursued it and instead let others (LangFlow, Flowise, n8n) build on top of us. With OpenAI launching a [workflow builder](https://openai.com/index/introducing-agentkit/?ref=blog.langchain.com) at Dev Day yesterday, I thought it would be interesting to write about why we haven’t built one to date, and what different (but related) directions we are more interested in.

LangChain 自诞生之初，用户最常提出的需求之一便是可视化工作流构建器（visual workflow builder）。我们从未亲自推进这一方向，而是选择让其他团队（如 LangFlow、Flowise、n8n）基于 LangChain 构建相关工具。昨日 OpenAI 在 Dev Day 上发布了其 [工作流构建器](https://openai.com/index/introducing-agentkit/?ref=blog.langchain.com)，这促使我思考并撰写本文：解释我们至今未自研此类工具的原因，以及我们更关注的、虽不同但密切相关的技术方向。

## The problem statement

## 问题定义

First of all, it’s worth aligning on the problem statement these no-code workflow builders solve. The main motivation is to allow non-technical users to build agents. There’s two main reasons people are interested in this:

首先，有必要明确这类“无代码工作流构建器”所要解决的核心问题。其主要目标是赋能非技术人员自主构建智能体（agents）。人们关注这一能力主要有两大原因：

1. Many companies are more resource constrained on engineering talent than others  
   1. 许多公司在工程人才方面比其他公司更为紧缺；  
2. Non-technical users are the ones who know what agents to build / what they should do  
   2. 真正了解“需要构建什么样的智能体”以及“智能体应完成哪些任务”的，恰恰是非技术人员。

We occasionally see other motivations, like allowing technical users to quickly prototype agents that will get ported into code later. But for the purpose of this blog let’s assume that the motivation is to enable everyone in an organization to build their own apps and widgets without support from engineering.

我们也偶尔见到其他动机，例如帮助技术人员快速搭建智能体原型，后续再将其转化为正式代码。但就本文而言，我们假设核心目标是：让组织内每一位成员——无论技术背景如何——都能在无需工程团队支持的前提下，自主开发属于自己的应用与小工具（apps and widgets）。

## Workflows vs agents

## 工作流（Workflows）vs 智能体（Agents）

Two words which I’ve used intentionally above are “workflows” and “agents”. We’ve written about this before - actually in a blog post [arguing for workflows](https://blog.langchain.com/how-to-think-about-agent-frameworks/) (ironically, in response to an OpenAI article arguing against workflows).

上文中有意使用的两个关键词是“工作流（workflows）”和“智能体（agents）”。我们此前已就此展开过讨论——事实上，我们曾专门发布一篇博客文章 [《如何思考智能体框架》](https://blog.langchain.com/how-to-think-about-agent-frameworks/) 来主张工作流的价值（颇具反讽意味的是，该文正是针对 OpenAI 一篇反对工作流理念的文章所作的回应）。

The developer community has largely settled on the [following definition of an agent](https://simonwillison.net/2025/Sep/18/agents/?ref=blog.langchain.com):

开发者社区目前已普遍接受如下关于“智能体（agent）”的定义：  
[参见 Simon Willison 的阐释](https://simonwillison.net/2025/Sep/18/agents/?ref=blog.langchain.com)

💡

An LLM agent runs tools in a loop to achieve a goal.

大型语言模型（LLM）智能体通过循环调用工具来实现目标。

Workflows give you more predictability at the expense of autonomy, while agents give you more autonomy at the expense of predictability. **Notably, when building agentic systems we are in pursuit of _reliably good_ outcomes, which neither predictability or autonomy alone guarantee.**

工作流以牺牲自主性为代价，换取更高的可预测性；而智能体则以牺牲可预测性为代价，换取更高的自主性。**值得注意的是，在构建智能体系统时，我们的目标是达成“稳定可靠的良好结果”，而仅靠可预测性或仅靠自主性，都无法单独保证这一点。**

Workflows are often complicated - branching logic, parallel edges, many different paths. This complexity is represented in the “graph” of the workflow, which is represented in some DSL.

工作流通常十分复杂——包含分支逻辑、并行路径、多种不同执行路径等。这种复杂性体现在工作流的“图结构”中，而该图结构通常由某种领域特定语言（DSL）来表达。

Agents can also contain complicated logic, but by contrast all that logic is abstracted away into natural language, which goes into the prompt. So the overall structure of an agent is simple (just a prompt + tools), though that “prompt” can often times be pretty complex.

智能体也可能包含复杂的逻辑，但与工作流不同，这些逻辑全部被抽象进自然语言中，并融入提示词（prompt）。因此，智能体的整体结构十分简洁（仅由一个提示词 + 一组工具构成），尽管这个“提示词”本身往往可能非常复杂。

OpenAI’s AgentKit - and n8n, Flowise, LangFlow - are all visual **workflow** builders - not _agent_ builders.

OpenAI 的 AgentKit，以及 n8n、Flowise、LangFlow 等，均为可视化**工作流**构建工具——而非 _智能体_ 构建工具。

## The issue with visual workflow builders

## 可视化工作流构建工具的问题

So, with all that context, what is the problem with workflow builders:

综上所述，在明确了上述背景之后，工作流构建工具究竟存在什么问题？

**1.Visual workflow builders are not “low” barrier to entry.**

**1. 可视化工作流构建工具并非真正“低门槛”。**

Despite being built for a mass audience, it is still not easy for the average non-technical user to use them.

尽管这些工具面向大众用户设计，但对普通非技术人员而言，使用它们依然并不容易。

**2.Complex tasks quickly get too complicated to manage in a visual builder.**

**2. 复杂任务会迅速超出可视化构建器的管理能力，变得难以驾驭。**

As soon as they pass a certain level of complexity (which happens pretty quickly) you end up with a mess of nodes and edges that you need to manage in the UI.

一旦其复杂度超过某个阈值（而这一阈值往往很快就会达到），你最终会面临一个由大量节点和边构成的混乱结构，需要在用户界面中进行管理。

## Other alternatives

## 其他替代方案

The goal is to create LLM powered systems (whether workflows or agents) that are _reliably good_. There are different types of problems that people may want to solve with LLM powered systems - ranging anywhere from low complexity to high complexity. The best alternative may depend on the level of complexity.

目标是构建由大语言模型（LLM）驱动的系统（无论是工作流还是智能体），使其具备**稳定可靠的性能**。人们希望借助 LLM 驱动的系统解决的问题类型多种多样——其复杂度可从低到高不等。因此，最优的实现方案可能取决于具体问题的复杂度。

**High Complexity: Workflows in Code**

**高复杂度：以代码实现的工作流**

For high complexity problems, we’ve found that in order to achieve a certain level of reliability the systems are not just pure agents, but rather involve some aspect of a workflow. These high complexity problems often require complex workflows. In these scenarios, where you want lots of branching, parallelism and modularity, code is the best option ( [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) is designed for this).

对于高复杂度问题，我们发现：若要达到一定的可靠性，相关系统不能仅依赖纯粹的智能体，而必须融入某种工作流机制。这类高复杂度问题通常需要高度复杂的工作流。在需要大量分支判断、并行执行与模块化设计的场景下，**以代码方式实现是最优选择**（[LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 正是为此类需求而设计）。

Traditionally this would mean that these types of problems just aren’t actually solvable by a non-technical builder. As the cost of code generation goes to zero, however, we expect that more and builders will find themselves capable of building these solutions.

传统上，这意味着非技术背景的构建者实际上无法解决此类问题。然而，随着代码生成成本趋近于零，我们预计越来越多的构建者将有能力自主开发这类解决方案。

**Low Complexity: No-Code Agents**

**低复杂度：无需编码的智能体**

For lower complexity use cases, I would assert that simple agents (prompt + tools) are getting reliably good enough to solve these use cases. Building these agents in a no-code way should be simpler than building a workflow in a no-code way.

对于低复杂度的应用场景，我认为，简单的智能体（即“提示词 + 工具”组合）目前已足够稳定可靠，足以胜任这些任务。以无代码方式构建此类智能体，理应比以无代码方式构建工作流更为简便。

As models get better and better, I would expect the ceiling of the type of problems these agents can solve to get higher and higher.

随着大语言模型持续进化，我预期这类智能体所能解决的问题类型上限也将不断提升。

## The squeeze

## “夹缝”困境

The issue with no code workflow builders are that I think they are getting squeezed from both directions.

无代码工作流构建工具面临的问题在于，我认为它们正受到来自两个方向的挤压。

| Complexity Level | Best Solution |
| --- | --- |
| Low | No-Code Agent |
| Medium | No-Code Workflow |
| High | Workflow in Code |

| 复杂度等级 | 最佳解决方案 |
| --- | --- |
| 低 | 无代码智能体（Agent） |
| 中 | 无代码工作流（Workflow） |
| 高 | 用代码编写的工作流 |

I think agents (prompt + tools) should be strictly easier to create in a no-code way than workflows. I expect models, agent harnesses, and our interfaces for creating, modifying, and _teaching_ these agents to get better. This means that these agents will be _reliably good_ at more and more tasks.

我认为，智能体（由提示词 + 工具构成）在无代码方式下理应比工作流更易于创建。我预计大模型、智能体运行框架（agent harnesses），以及我们用于创建、修改和 _训练_ 这些智能体的交互界面都将持续改进。这意味着这些智能体将在越来越多的任务上表现得 _稳定可靠_。

In the other direction, visual workflow builders become unmanageable for a certain level of complexity. The only real alternative to that is code. Writing code has historically been limited to a small set of people, with the barrier to entry being pretty high. As models get better and better at code generation, and the cost of code generation goes to zero, I expect the decision to go to code becomes easier and easier.

另一方面，当复杂度达到一定程度时，可视化工作流构建器将变得难以维护。真正可行的替代方案只有“写代码”。历史上，编程能力一直局限于一小部分人，入门门槛相当高。但随着大模型在代码生成方面的能力持续提升，且代码生成的成本趋近于零，我预计人们转向“用代码实现”的决策将变得越来越容易。

## The interesting problems

## 值得关注的问题

To be very clear - there are companies that have done a fantastic job at democratizing LLM powered workflow builders (n8n, Flowise, LangFlow, Gumloop, etc). Many of them have found product-market fit - they solve a real problem that exists today and empower non-technical users to build fantastic things.

需要明确指出的是——已有不少公司出色地推动了大语言模型驱动的工作流构建工具的普及化（例如 n8n、Flowise、LangFlow、Gumloop 等）。其中许多已成功实现产品与市场的契合（product-market fit）：它们切实解决了当下真实存在的问题，并赋能非技术人员构建出令人惊叹的应用。

I do not think the world needs yet another workflow builder. Rather, I think the interesting problems to solve next are:

我认为，世界并不需要又一个工作流构建工具。相反，接下来真正值得探索的关键问题有：

- How can we make it easier to create _reliably good_ agents in a no-code way. These should be agents! Not low code workflows.  
- 如何让非技术人员更轻松地创建 _稳定可靠_ 的智能体？这些必须是真正的智能体（Agents）！而非“低代码工作流”。

- How can we make code generation models better at writing LLM powered workflows/agents  
- 如何提升代码生成模型在编写大语言模型驱动的工作流/智能体方面的能力？

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)  
[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/not-another-workflow-builder/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![关于智能体框架与智能体可观测性](images/not-another-workflow-builder/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/not-another-workflow-builder/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪数据到深度洞察：规模化理解智能体行为](images/not-another-workflow-builder/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/not-another-workflow-builder/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码记录应用行为；在人工智能中，追踪数据承担这一职责。](images/not-another-workflow-builder/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码记录应用行为；在人工智能中，追踪数据承担这一职责。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses—oh my!](images/not-another-workflow-builder/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses—oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent 框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/not-another-workflow-builder/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Deep Agents](images/not-another-workflow-builder/img_006.png)](https://blog.langchain.com/deep-agents/)

[**Deep Agents**](https://blog.langchain.com/deep-agents/)

[**深度智能体（Deep Agents）**](https://blog.langchain.com/deep-agents/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟