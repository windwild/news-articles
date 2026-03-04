---
title: "Autonomous Agents & Agent Simulations"
source: "LangChain Blog"
url: "https://blog.langchain.com/agents-round/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:00:30.488321324+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

Over the past two weeks, there has been a massive increase in using LLMs in an agentic manner. Specifically, projects like [AutoGPT](https://github.com/Significant-Gravitas/Auto-GPT?ref=blog.langchain.com), [BabyAGI](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com), [CAMEL](https://github.com/lightaime/camel?ref=blog.langchain.com), and [Generative Agents](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2304.xml?ref=blog.langchain.com) have popped up. The LangChain community has now implemented some parts of all of those projects in the LangChain framework. While researching and implementing these projects, we’ve tried to best understand what the differences between them are and what the novel features of each are. This blog is an explanation of what we’ve learned.

过去两周，以“智能体（agent）”方式使用大语言模型（LLM）的实践呈现爆发式增长。具体而言，[AutoGPT](https://github.com/Significant-Gravitas/Auto-GPT?ref=blog.langchain.com)、[BabyAGI](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com)、[CAMEL](https://github.com/lightaime/camel?ref=blog.langchain.com) 和 [Generative Agents](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2304.xml?ref=blog.langchain.com) 等项目相继涌现。LangChain 社区目前已在 LangChain 框架中实现了上述所有项目的部分功能。在研究与实现这些项目的过程中，我们力求深入理解它们之间的差异，以及各自所引入的创新特性。本文即是对我们所获认知的系统性梳理与阐释。

Note: this is a fairly technical blog. It assumes some familiarity with LangChain and these related projects. If you are not familiar with these projects, it may be helpful to read a more introductory piece (like [this fantastic one](https://t.co/vgZhvKhscG?ref=blog.langchain.com) by Sophia Yang).

注：本文技术性较强，预设读者已对 LangChain 及相关项目具备一定了解。若您尚不熟悉这些项目，建议先阅读一篇更入门的介绍（例如 Sophia Yang 撰写的 [这篇精彩文章](https://t.co/vgZhvKhscG?ref=blog.langchain.com)）。

**TL;DR:**

**简而言之：**

- **“[自主智能体（autonomous agents）](https://python.langchain.com/en/latest/use_cases/autonomous_agents.html?ref=blog.langchain.com)”类项目（如 BabyAGI、AutoGPT）的核心创新在于其长期目标设定，这催生了新型规划技术，并要求采用不同于传统范式的记忆机制。**  
- **“[智能体模拟（agent simulation）](https://python.langchain.com/en/latest/use_cases/agent_simulations.html?ref=blog.langchain.com)”类项目（如 CAMEL、Generative Agents）的核心创新则体现在其模拟环境的设计，以及能够基于事件持续反思、动态演化的长期记忆机制。**

We also discuss what parts of each project we’ve replicated in the LangChain framework, and why we chose those parts. Implementing these in the LangChain framework has the benefits of:

我们还详细说明了在 LangChain 框架中复现了各项目的哪些组件，以及做出这些选择的原因。将这些能力集成至 LangChain 框架，带来如下优势：

- Allowing easy switching between [LLM providers](https://python.langchain.com/docs/modules/model_io/models/?ref=blog.langchain.com)  
  支持便捷切换各类 [大语言模型提供商（LLM providers）](https://python.langchain.com/docs/modules/model_io/models/?ref=blog.langchain.com)；

- Allowing easy switching of [VectorStore providers](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com) (or, [alternative retrieval methods](https://python.langchain.com/docs/modules/data_connection/retrievers/?ref=blog.langchain.com))  
  支持便捷切换各类 [向量数据库提供商（VectorStore providers）](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com)（或采用其他 [检索方法](https://python.langchain.com/docs/modules/data_connection/retrievers/?ref=blog.langchain.com)）；

- Allowing connectivity to LangChain’s collection of [tools](https://python.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com)  
  可无缝接入 LangChain 提供的丰富 [工具集（tools）](https://python.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com)；

- Allowing connectivity to the LangChain ecosystem in general  
  可全面融入 LangChain 整体生态体系。

## Background

## 背景介绍

First, let’s start with some background context. What are “agents” and why are they important? For this discussion, we will use LangChain nomenclature, although it’s worth noting that this field is so new there’s no super standard terminology.

首先，让我们从一些背景知识入手：什么是“智能体（agents）”，以及为何它如此重要？在本文讨论中，我们将采用 LangChain 的术语体系；但需指出的是，该领域尚处于早期阶段，尚未形成高度统一的标准术语。

Agents generally refer to the idea of using a language model as a reasoning engine and connecting it to two key components: tools and memory.

智能体通常指将语言模型作为推理引擎，并将其与两大核心组件——工具（tools）和记忆（memory）——相连接的理念。

Tools help connect the LLM to other sources of data or computation. Examples of tools include search engines, APIs, and other datastores. Tools are useful because LLMs only have knowledge of what they were trained on. This knowledge can quickly get out-of-date. In order to overcome this limitations, tools can fetch up-to-date data and insert it as context into the prompt. Tools can also be used to take actions (e.g. run code, modify files, etc), and the outcome of that action can then be observed by the LLM and factored into their decision on what to do next.

工具用于将大语言模型连接至外部数据源或计算资源。典型工具包括搜索引擎、各类 API 及其他数据存储系统。工具之所以重要，是因为大语言模型的知识仅限于其训练数据；而这些知识极易过时。为克服这一局限，工具可实时获取最新信息，并将其作为上下文注入提示（prompt）。此外，工具还可执行具体操作（例如运行代码、修改文件等），其执行结果可被大语言模型观测，并纳入后续决策考量。

Memory helps the agent remember previous interactions. These interactions can either be with other entities (humans or other agents) or with tools. These memories can either be short term (e.g. a list of the previous 5 tool usages) or long term (tool usages from the past that seem most similar to the current situation).

记忆帮助智能体（agent）记住以往的交互。这些交互对象既可以是其他实体（人类或其他智能体），也可以是工具。此类记忆可分为短期记忆（例如：最近 5 次工具调用的列表）和长期记忆（过去发生、且与当前情境最相似的工具调用记录）。

Within LangChain, we refer to an “Agent” as the LLM that decides what actions to take; “Tools” as the actions an Agent can take; “Memory” the act of pulling in previous events, and an AgentExecutor as the logic for running an Agent in a while-loop until some stopping criteria is met.

在 LangChain 中，我们将“智能体（Agent）”定义为负责决定执行何种操作的大语言模型（LLM）；“工具（Tools）”指智能体可执行的操作；“记忆（Memory）”指引入过往事件的过程；而“智能体执行器（AgentExecutor）”则指以 while 循环方式持续运行智能体，直至满足某种终止条件的逻辑机制。

The stereotypical LangChain Agent is based on the [Reasoning and Acting (ReAct) framework](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2210.xml?ref=blog.langchain.com) proposed by Yao et al. in November of 2022. This approach is characterized by the following algorithm:

典型的 LangChain 智能体基于 Yao 等人于 2022 年 11 月提出的 [推理与行动（ReAct）框架](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2210.xml?ref=blog.langchain.com)。该方法具有如下算法特征：

1. User gives an agent a task  
1. 用户向智能体分配一项任务  

2. **Thought**: The agent “thinks” about what to do  
2. **思考（Thought）**：智能体“思考”应采取何种行动  

3. **Action/Action Input**: The agent decides what action to take (aka what tool to use) and what the input to that tool should be  
3. **行动/行动输入（Action/Action Input）**：智能体决定执行何种行动（即调用哪个工具），以及该工具所需的输入参数  

4. **Observation**: The output of the tool  
4. **观察（Observation）**：工具执行后的输出结果  

5. Repeat steps 2–4 until the Agent “thinks” it is done  
5. 重复步骤 2–4，直至智能体“认为”任务已完成  

When discussing other implementations and frameworks we will compare them to this algorithm.

在讨论其他实现方案与框架时，我们将均以此算法为基准进行对比分析。

## AutoGPT

## AutoGPT

**Links:**  
**相关链接：**

- [Original Repo](https://github.com/Significant-Gravitas/Auto-GPT?ref=blog.langchain.com)  
- [原始代码仓库](https://github.com/Significant-Gravitas/Auto-GPT?ref=blog.langchain.com)

- [LangChain Implementation](https://python.langchain.com/docs/use_cases/autonomous_agents/autogpt?ref=blog.langchain.com)  
- [LangChain 实现文档](https://python.langchain.com/docs/use_cases/autonomous_agents/autogpt?ref=blog.langchain.com)

**What is novel about this project?**  
**该项目有何创新之处？**

The main differences between the AutoGPT project and traditional LangChain agents can be attributed to different objectives. In AutoGPT, the goals are often more open ended and long running. This means that AutoGPT has a different AgentExecutor and different way of doing memory (both of which are more optimized for long running tasks). Previously, memory of agents in LangChain had two forms:  
AutoGPT 项目与传统 LangChain 智能体的主要差异源于其设计目标的不同。在 AutoGPT 中，目标往往更具开放性，且需长时间持续运行。这意味着 AutoGPT 采用了不同的智能体执行器（AgentExecutor）和不同的记忆机制（二者均针对长期运行任务进行了优化）。此前，LangChain 中智能体的记忆形式主要有两种：

- Memory of agent steps: this was done by keeping a list of intermediate agent steps relevant for that task, and passing the full list to the LLM calls  
- 代理步骤记忆：通过维护一个与当前任务相关的中间代理步骤列表，并将该完整列表传入大语言模型（LLM）调用中来实现。

- Memory of system: this remembered the final inputs and outputs (but forgot the intermediate agent steps)  
- 系统记忆：仅保存最终的输入与输出（但会遗忘中间代理步骤）。

Because AutoGPT is more long running, passing the full list of agent steps to the LLM call is no longer feasible. Instead, AutoGPT added a retrieval-based memory over the intermediate agent steps. Under the hood, this retrieval-based memory is doing semantic search over embeddings, using a VectorStore. Note that LangChain has this type of retrieval-based memory, but it was previously applied to **user-agent** interactions, not [agent-tool](https://python.langchain.com/docs/use_cases/autonomous_agents/autogpt?ref=blog.langchain.com) interactions.  
由于 AutoGPT 运行周期更长，将全部代理步骤列表传入每次 LLM 调用已不再可行。取而代之的是，AutoGPT 引入了一种基于检索的中间代理步骤记忆机制。其底层实现是利用向量数据库（VectorStore）对嵌入向量（embeddings）执行语义搜索。需注意，LangChain 本身已支持此类基于检索的记忆机制，但此前仅应用于 **用户-代理**（user-agent）交互场景，而非 [代理-工具](https://python.langchain.com/docs/use_cases/autonomous_agents/autogpt?ref=blog.langchain.com) 交互场景。

**How did we incorporate this into LangChain?**  
**我们如何将这一机制整合进 LangChain？**

We added a version of this to `langchain.experimental` \- a place where we are putting more experimental and newer code while we figure out the proper abstractions. Specifically, we’ve implemented the prompt templating logic used, as well as `while` loop used to run the agent. We’ve made it compatible with LangChain LLM wrappers, LangChain VectorStores, and LangChain tools.  
我们将该机制的一个实现版本加入到了 `langchain.experimental` 模块中——这是 LangChain 专门用于存放实验性及较新代码的区域，以便我们在确立成熟抽象之前持续迭代验证。具体而言，我们实现了所用的提示词模板逻辑（prompt templating logic），以及用于运行代理的 `while` 循环。该实现已全面兼容 LangChain 的 LLM 封装器（LLM wrappers）、向量数据库（VectorStores）和工具（tools）。

We’ve also created [this](https://python.langchain.com/docs/use_cases/autonomous_agents/autogpt?ref=blog.langchain.com) notebook showing how to use it.  
我们还创建了[此 Notebook](https://python.langchain.com/docs/use_cases/autonomous_agents/autogpt?ref=blog.langchain.com)，演示其具体使用方法。

## BabyAGI  
## BabyAGI

**Links:**  
**相关链接：**

- [Original Repo](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com)  
- [原始代码仓库](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com)

- [LangChain Implementation](https://python.langchain.com/docs/use_cases/autonomous_agents/baby_agi?ref=blog.langchain.com)  
- [LangChain 实现版本](https://python.langchain.com/docs/use_cases/autonomous_agents/baby_agi?ref=blog.langchain.com)

- [LangChain Implementation with Tools](https://python.langchain.com/docs/use_cases/autonomous_agents/baby_agi_with_agent?ref=blog.langchain.com)  
- [集成工具的 LangChain 实现版本](https://python.langchain.com/docs/use_cases/autonomous_agents/baby_agi_with_agent?ref=blog.langchain.com)

**What is novel about this project?**  
**该项目的创新点是什么？**

The BabyAGI project differs from traditional LangChain Agents in the following regards:  
BabyAGI 项目在以下方面区别于传统的 LangChain Agent：

- Similar to AutoGPT, it applies retrieval-based memory to intermediate agent-tool steps.  
- 与 AutoGPT 类似，它在智能体（agent）与工具交互的中间步骤中应用基于检索的记忆机制。

- It has separate planning and execution steps, where it plans a sequence of actions all at once (rather than just the next one).  
- 它将规划（planning）与执行（execution）步骤明确分离，一次性规划出一连串动作（而非仅规划下一步动作）。

Similar to AutoGPT, BabyAGI is designed for more long running tasks, which lead to both of these differences.  
与 AutoGPT 类似，BabyAGI 面向更长时间运行的任务，这也导致了上述两项差异。

Let’s expand on the second point, since that is one of the more important and substantial differences. In the traditional LangChain Agent framework (and the AutoGPT framework), the agent thinks one step ahead at a time. For a given state of the world it think about what its next immediate action should be, and then does that action.  
我们来重点展开第二点，因为这是其中一项更为重要且实质性的差异。在传统的 LangChain Agent 框架（以及 AutoGPT 框架）中，智能体每次仅向前思考一步：针对当前世界状态，它仅考虑下一步应采取的即时动作，然后执行该动作。

BabyAGI differs in that it explicitly plans out a sequence of actions. It then executes on the first one, and then uses the result of that to do another planning step and update it’s task list. Our intuition is that this enables it to execute better on more complex and involved tasks, by using the planning steps essentially as a state tracking system. We’ve observed (anecdotally) that for tasks that require many steps, the traditional LangChain Agent can sometimes forget its original objective after a few steps, so planning all the steps ahead of time could be beneficial.  
BabyAGI 的不同之处在于，它会显式地预先规划出一整套动作序列；随后仅执行其中第一步，并利用该步执行结果开展下一轮规划，进而更新其任务列表。我们的直觉是：这种机制本质上将“规划步骤”用作一种状态追踪系统，从而使其在处理更复杂、更耗时的任务时表现更优。我们曾（基于经验性观察）发现：对于需多步完成的任务，传统 LangChain Agent 有时在几步之后便会遗忘原始目标；因此，提前规划全部步骤可能带来显著益处。

**How did we incorporate this into LangChain?**  
**我们如何将这一机制集成进 LangChain？**

Similar to AutoGPT, we added this to `langchain.experimental`. Specifically, we’ve implemented the prompt templating logic used, as well as `while` loop used to run the agent. We’ve made it compatible with LangChain LLM wrappers, LangChain vectorstores, and LangChain tools.  
与 AutoGPT 类似，我们将其实现添加至 `langchain.experimental` 模块。具体而言，我们实现了所用的提示词模板（prompt templating）逻辑，以及用于驱动智能体运行的 `while` 循环。该实现已兼容 LangChain 的 LLM 封装器（LLM wrappers）、向量数据库（vectorstores）及工具（tools）。

## Camel  

## CAMEL  

**Links:**  
**相关链接：**

- [Original Paper](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/camel.pdf?ref=blog.langchain.com)  
- [原始论文](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/camel.pdf?ref=blog.langchain.com)

- [Original Repo](https://github.com/lightaime/camel?ref=blog.langchain.com)  
- [原始代码仓库](https://github.com/lightaime/camel?ref=blog.langchain.com)

- [LangChain Implementation](https://python.langchain.com/docs/use_cases/agent_simulations/camel_role_playing?ref=blog.langchain.com)  
- [LangChain 实现文档](https://python.langchain.com/docs/use_cases/agent_simulations/camel_role_playing?ref=blog.langchain.com)

**What is novel about this project?**  
**该项目的创新点是什么？**

The main novelty in this project comes from taking two agents, each with their own personality, and having them chat with each other. In this sense there are two novel components: the idea of having two agents interact with each other in a collaborative manner, and the specific simulation environment.

本项目的主要创新点在于：引入两个各自具备独特人格的智能体，并让它们彼此对话。从这个角度看，本项目包含两个创新性要素：一是让两个智能体以协作方式相互交互的理念；二是所构建的特定仿真环境。

The idea of two agents interacting is not entirely new. Given the modular nature of LangChain, we have long been proponents of having agents use other agents as tools. However, what is novel about this type of interaction is that the two agents are poised as equals—in previous LangChain implementations there has always been one agent which calls the other as a tool, in a ["stacking"](https://twitter.com/mathemagic1an/status/1645096275392745477?s=20&ref=blog.langchain.com) approach. This idea of putting both agents on equal footing, rather than having one use the other as a tool strikes a chord of being particularly interesting to see evolving behavior emerge.

两个智能体相互交互的理念并非完全崭新。鉴于 LangChain 的模块化特性，我们长期以来一直倡导将智能体作为工具供其他智能体调用。然而，本项目中此类交互的创新之处在于：两个智能体被设定为地位平等的对等主体——而在以往的 LangChain 实现中，始终是一个智能体将另一个智能体作为工具来调用，即采用一种“堆叠式”（["stacking"](https://twitter.com/mathemagic1an/status/1645096275392745477?s=20&ref=blog.langchain.com)）架构。将两个智能体置于平等地位、而非单向工具化调用的设计理念，尤其令人期待其催生出更具涌现性的协同行为。

Note that these agents can have different tools available to them and could be specialized around that. For example, you could have one agent that is armed with tools needed for coding, another with tools needed for interacting with linear, etc. So it is still possible to achieve a "stacking" effect (where you have different agents responsible for different things).

需要注意的是，这些智能体可配备不同的工具集，并据此实现功能专业化。例如，一个智能体可集成编程所需的各种工具，另一个则配备与线性系统交互所需的工具，等等。因此，“堆叠式”效果（即不同智能体各司其职）依然可以实现。

The second novel component was the particular simulation environment. This is a two sided conversation, and is not terribly complex but still the first implementation of this in a research setting we have seen.

第二个创新性要素是所构建的特定仿真环境。该环境支持双向对话，虽不十分复杂，但据我们所知，这是学术研究场景中首次实现此类双智能体交互的实践。

**How did we incorporate this into LangChain?**

**我们如何将这一设计融入 LangChain？**

We added a notebook, largely reflecting the simulation environment (having two agents chatting with each other). We may look into making this simulation environment more available off-the-shelf in the future.

我们新增了一个 Jupyter Notebook，基本复现了上述仿真环境（即两个智能体彼此对话）。未来我们或将探索将该仿真环境进一步封装为开箱即用（off-the-shelf）的组件。

## Generative Agents

## 生成式智能体（Generative Agents）

**Links:**

**相关链接：**

- [Original Paper](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2304.xml?ref=blog.langchain.com)  
- [原始论文](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2304.xml?ref=blog.langchain.com)

- [Retriever Implementation](https://python.langchain.com/docs/modules/data_connection/retrievers/how_to/time_weighted_vectorstore?ref=blog.langchain.com)  
- [检索器（Retriever）实现](https://python.langchain.com/docs/modules/data_connection/retrievers/how_to/time_weighted_vectorstore?ref=blog.langchain.com)

- [LangChain Memory Implementation](https://python.langchain.com/docs/use_cases/agent_simulations/characters?ref=blog.langchain.com)  
- [LangChain 记忆模块（Memory）实现](https://python.langchain.com/docs/use_cases/agent_simulations/characters?ref=blog.langchain.com)

**What is novel about this project?**

**本项目的创新性体现在哪些方面？**

There are two novel (and fairly complex) aspects to this project.  
该项目有两个新颖（且相当复杂）的方面。

The first is the simulation environment, which consists of 25 different agents. This seems fairly specific, and very complex, so we did not dive into this too much.  
第一个是模拟环境，由 25 个不同的智能体（agents）组成。这一设计显得非常特定，且极为复杂，因此我们并未对此深入探究。

The other aspect that is novel is the **long-term memory** they created for these agents.  
另一个新颖之处在于他们为这些智能体构建的**长期记忆**（long-term memory）。

We did a deep dive on this [earlier this week](https://twitter.com/hwchase17/status/1647987713449263106?s=20&ref=blog.langchain.com). The agents’ memory is made up of:  
我们本周早些时候已就此做过深度剖析：[链接](https://twitter.com/hwchase17/status/1647987713449263106?s=20&ref=blog.langchain.com)。这些智能体的记忆系统包含以下三部分：

1. Importance reflection steps, to give each observation an importance score. This score can be used in retrieval down the line to fetch particularly important memories and ignore basic ones  
1. **重要性反思步骤**（Importance reflection steps）：为每次观察赋予一个“重要性得分”。该得分可在后续检索中用于优先提取特别重要的记忆，同时忽略基础性、低价值的记忆。

2. Reflection steps, to “pause” and think about what generalizations the agent has learned. These reflections can then be retrieved alongside normal memories. This reflection step can serve to condense information and observe patterns in recent memories  
2. **反思步骤**（Reflection steps）：让智能体“暂停”并思考其已习得的通用规律或抽象结论。这些反思结果可与常规记忆一同被检索。该反思步骤有助于信息压缩，并识别近期记忆中的潜在模式。

3. A retriever that combines recency, relevancy to the situation, and importance. This can allow for surfacing of memories that similar to the situation at hand, happened a short while ago, and particularly important. All of these seem to be attributes that naturally reflect how we as human “retrieve” memories  
3. 一种融合了**时效性**（recency）、**情境相关性**（relevancy to the situation）和**重要性**（importance）的检索器。它能有效浮现那些与当前情境相似、发生在较近时间、且尤为关键的记忆。上述三项属性，恰好契合人类自身“回忆”记忆时的自然机制。

All of these memory components are fairly novel, and extremely exciting to us.  
所有这些记忆组件均颇具原创性，令我们倍感振奋。

**How did we incorporate this into LangChain?**  
**我们是如何将这一机制整合进 LangChain 的？**

The retriever logic seemed generalizable so we added it as a `TimeWeightedVectorStoreRetriever`.  
由于该检索逻辑具备良好的通用性，我们将其封装为 `TimeWeightedVectorStoreRetriever`。

We added a [notebook](https://python.langchain.com/docs/use_cases/agent_simulations/characters?ref=blog.langchain.com) showing off how to use the reflection steps + the new retriever to replicate part of the setup the paper described.  
我们新增了一个 [示例 Notebook](https://python.langchain.com/docs/use_cases/agent_simulations/characters?ref=blog.langchain.com)，演示如何结合反思步骤（reflection steps）与新型检索器，复现论文中所描述的部分架构。

The simulation environment seemed complex and not super generalizable so we did not do any thing there.  
模拟环境则显得过于复杂、泛化能力有限，因此我们未在该部分开展任何工作。

## Conclusion  
## 结论

All of these projects rightfully garnered a lot of attention. We view them as two separate categories:  
上述所有项目理所当然地引发了广泛关注。我们将它们划分为两个独立的类别：

- [Autonomous Agents](https://python.langchain.com/docs/use_cases/autonomous_agents/?ref=blog.langchain.com), which have improved planning abilities  
- [自主智能体（Autonomous Agents）](https://python.langchain.com/docs/use_cases/autonomous_agents/?ref=blog.langchain.com)，具备更强的规划能力  

- [Agent Simulations](https://python.langchain.com/docs/use_cases/agent_simulations/?ref=blog.langchain.com), which have novel simulation environments and complex, evolving memory  
- [智能体仿真（Agent Simulations）](https://python.langchain.com/docs/use_cases/agent_simulations/?ref=blog.langchain.com)，提供新颖的仿真环境，以及复杂且持续演化的记忆机制  

We’re excited to have started implementing parts of these projects in the LangChain ecosystem, and look forward to seeing how the community uses these, adds to these, and combines these 🙂  
我们非常高兴已开始在 LangChain 生态系统中落地实现这些项目中的部分功能，并热切期待社区如何使用、扩展及融合这些能力🙂  

### Tags  

### 标签  

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  
[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)  

[![Evaluating Deep Agents: Our Learnings](images/autonomous-agents-agent-simulations/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[![评估深度智能体：我们的经验总结](images/autonomous-agents-agent-simulations/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read  
[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长 7 分钟  

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/autonomous-agents-agent-simulations/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)  
[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/autonomous-agents-agent-simulations/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)  

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)  
[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/autonomous-agents-agent-simulations/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/autonomous-agents-agent-simulations/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/autonomous-agents-agent-simulations/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/autonomous-agents-agent-simulations/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/autonomous-agents-agent-simulations/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/autonomous-agents-agent-simulations/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/autonomous-agents-agent-simulations/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台处于 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/autonomous-agents-agent-simulations/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台处于 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟
{% endraw %}
