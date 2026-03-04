---
title: "Memory for agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/memory-for-agents/"
date: "2024-12-04"
scraped_at: "2026-03-03T07:46:30.980205531+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---
{% raw %}

_在三月举行的红杉资本（Sequoia）AI Ascend 大会上，我谈到了智能体（agents）的三大局限性：规划（planning）、用户体验（UX）和记忆（memory）。欢迎观看该演讲_ [_此处_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com) _。本文将深入探讨“记忆”这一主题。关于“规划”的上一篇博文请见_ [_此处_](https://blog.langchain.com/planning-for-agents/) _；关于“用户体验”的系列文章请分别参阅_ [_第一篇_](https://blog.langchain.com/ux-for-agents-part-1-chat-2/) _、_ [_第二篇_](https://blog.langchain.com/ux-for-agents-part-2-ambient/) _和_ [_第三篇_](https://blog.langchain.com/ux-for-agents-part-3/) _。_

如果“智能体”是 2024 年大语言模型（LLM）应用开发领域最热门的关键词，那么“记忆”或许就是紧随其后的第二大热词。但究竟什么是“记忆”？

从宏观层面来看，记忆不过是一套用于记录过往交互信息的系统。这对构建优质的智能体体验至关重要。试想一下，如果你有一位同事，每次交谈都完全不记得你之前告诉过他什么，迫使你反复重复相同的信息——这无疑会令人极度沮丧！

人们常常默认大语言模型系统天然具备记忆能力，或许是因为 LLM 本身已展现出极强的人类般的表现力。然而，LLM 本身**并不具备内在的记忆功能**——因此，我们必须主动为其添加记忆机制。但具体该如何设计和实现这种记忆呢？

## 记忆是面向具体应用场景的

我们对“记忆”这一问题已思考良久，并坚信：**记忆必须是面向具体应用场景的（application-specific）**。

例如，[Replit 的编程智能体](https://blog.langchain.com/customers-replit/) 可能选择记住某位用户偏好的 Python 库；而 [Unify 的研究型智能体](https://blog.langchain.com/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/) 则可能选择记住该用户正在调研的公司所属行业。二者所记忆的内容截然不同。

不仅如此，**智能体“记忆什么”因应用而异，其“如何记忆”的方式也同样因应用而异**。正如我们在[此前一篇博文](https://blog.langchain.com/ux-for-agents-part-1-chat-2/)中所讨论的，智能体的关键特性之一正是其围绕用户体验（UX）所构建的交互范式。不同的 UX 设计，提供了各异的信息采集与反馈更新路径。

那么，在 LangChain，我们是如何应对“记忆”这一挑战的呢？

💡

Much like our approach to agents: we aim to give users low-level control over memory and the ability to customize it as they see fit.

正如我们对待智能体（agents）的方式一样：我们致力于为用户提供对记忆的底层控制能力，并使其能够按需自定义记忆。

This philosophy guided much of our development of the [Memory Store](https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/), which we added into LangGraph last week.

这一理念深刻影响了我们对 [Memory Store](https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/) 的开发工作——该功能已于上周集成至 LangGraph。

## Types of memory

## 记忆的类型

While the **exact** shape of memory that your agent has may differ by application, we do see different high level types of memory. These types of memory are nothing new - they mimic [human memory types](https://www.psychologytoday.com/us/basics/memory/types-of-memory?ref=blog.langchain.com).

尽管您的智能体所采用的记忆结构可能因应用场景而异，但我们确实观察到若干高层次的记忆类型。这些记忆类型并非新概念——它们借鉴并模拟了[人类记忆的分类方式](https://www.psychologytoday.com/us/basics/memory/types-of-memory?ref=blog.langchain.com)。

There’s been some great work to map these human memory types to agent memory. My favorite is the [CoALA paper](https://arxiv.org/pdf/2309.02427?ref=blog.langchain.com). Below is my rough, ELI5 explanation of each type and **practical ways** for how todays agents may use and update this memory type.

目前已有一些出色的研究工作，将人类记忆类型映射到智能体记忆中。我最推崇的是 [CoALA 论文](https://arxiv.org/pdf/2309.02427?ref=blog.langchain.com)。以下是我以“像解释给五岁孩子听”（ELI5）的方式，对每类记忆所做的简明阐释，以及当今智能体**实际可行**地使用和更新此类记忆的方法。

![](images/memory-for-agents/img_001.png)

Decision procedure diagram from CoALA paper (Sumers, Yao, Narasimhan, Griffiths 2024)

来自 CoALA 论文的决策流程图（Sumers、Yao、Narasimhan、Griffiths，2024）

### Procedural Memory

### 程序性记忆

This term refers to long-term memory for how to perform tasks, similar to a brain’s core instruction set.

该术语指代一种长期记忆，用于存储“如何执行任务”的知识，类似于大脑的核心指令集。

Procedural memory in humans: remembering how to ride a bike.

人类的程序性记忆：例如记住如何骑自行车。

Procedural memory in Agents: the CoALA paper describes procedural memory as the combination of LLM weights and agent code, which fundamentally determine how the agent works.

代理中的程序性记忆：CoALA 论文将程序性记忆定义为大语言模型（LLM）权重与代理代码的结合，这从根本上决定了代理的工作方式。

In practice, we don’t see many (any?) agentic systems that update the weights of their LLM automatically or rewrite their code. We do, however, see some examples of an agent updating its own system prompt. While this is the closest practical example, it remains relatively uncommon.

在实践中，我们并未见到太多（甚至可能完全没有？）能够自动更新其 LLM 权重或自行重写代码的代理系统。不过，我们确实观察到一些代理会自主更新其系统提示（system prompt）的实例。尽管这是目前最接近的实用案例，但此类做法仍相对少见。

### Semantic Memory

### 语义记忆

This is someone’s long-term store of knowledge.

这是个体长期存储知识的机制。

Semantic memory in humans: it’s composed of pieces of information such as facts learned in school, what concepts mean and how they are related.

人类的语义记忆：由各类信息片段构成，例如在学校习得的事实、概念的含义及其相互关系。

Semantic memory in agents: the CoALA paper describes semantic memory as a repository of facts about the world.

代理中的语义记忆：CoALA 论文将其描述为一个关于世界事实的知识库。

Today, this is most often used by agents to personalize an application.

如今，代理最常利用语义记忆来实现应用程序的个性化。

Practically, we see this being done by using an LLM to extract information from the conversation or interactions the agent had. The exact shape of this information is usually application-specific. This information is then retrieved in future conversations and inserted into the system prompt to influence the agent’s responses.

实践中，这通常通过使用大语言模型从代理参与的对话或交互中提取信息来实现。此类信息的具体结构通常因应用而异；随后，这些信息将在后续对话中被检索，并插入系统提示中，以影响代理的响应。

### Episodic Memory

### 情景记忆

This refers to recalling specific past events.

这指的是对特定过往事件的回忆。

Episodic memory in humans: when a person recalls a particular event (or “episode”) experienced in the past.

人类的情景记忆：指一个人回忆起过去亲身经历的某个特定事件（即“情节”）。

Episodic memory in agents: the CoALA paper defines episodic memory as storing sequences of the agent’s past actions.

智能体的情景记忆：CoALA 论文将情景记忆定义为存储智能体过往行为的序列。

This is used primarily to get an agent to perform as intended.

这一机制主要用于引导智能体按预期方式执行任务。

In practice, episodic memory is implemented as few-shot example prompting. If you collect enough of these sequences, then this can be done via dynamic few-shot prompting. This is usually great for guiding the agent if there is a **correct** way to perform specific actions that have been done before. In contrast, semantic memory is more relevant if there isn’t necessarily a correct way to do things, or if the agent is constantly doing new things so the previous examples don’t help much.

实践中，情景记忆通常通过少样本示例提示（few-shot example prompting）来实现。若收集到足够多的行为序列，还可进一步采用动态少样本提示（dynamic few-shot prompting）。当某类具体操作存在明确的、已被验证过的**正确**执行方式时，该方法对引导智能体尤为有效。相比之下，若任务本身并无唯一“正确”解法，或智能体持续执行全新任务（致使历史示例参考价值有限），则语义记忆（semantic memory）更为适用。

## How to update memory

## 如何更新记忆

Besides just thinking about the type of memory to update in their agents, we also see developers thinking about **how** to update agent memory.

开发者不仅关注应更新哪一类记忆，也开始深入思考**如何**更新智能体的记忆。

One way to update agent memory is [“in the hot path”](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#writing-memories-in-the-hot-path). This is where the agent system explicitly decides to remember facts (usually via tool calling) before responding. This is the approach taken by ChatGPT.

一种更新智能体记忆的方式是[“在热路径中更新”（in the hot path）](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#writing-memories-in-the-hot-path)：即智能体系统在生成响应前，主动决定记录某些事实（通常通过调用工具实现）。ChatGPT 即采用此方式。

Another way to update memory is [“in the background”](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#writing-memories-in-the-background). In this case, a background process runs either during or after the conversation to update memory.

另一种方式是[“在后台更新”（in the background）](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#writing-memories-in-the-background)：即在对话进行中或结束后，由一个后台进程异步执行记忆更新。

![](images/memory-for-agents/img_002.png)

![](images/memory-for-agents/img_002.png)

Comparing these two approaches, the “in the hot path” approach has the downside of introducing some extra latency before any response is delivered. It also requires combining the memory logic with the agent logic.

对比这两种方式，“在热路径中更新”的缺点在于：会在响应返回前引入额外延迟；同时要求将记忆逻辑与智能体逻辑耦合在一起。

However, running in the background avoids those issues - there’s no added latency, and memory logic remains separate. But running “in the background” also has its own drawbacks: the memory is not updated immediately, and extra logic is needed to determine when to kick off the background process.

然而，在后台运行可避免上述问题——不会引入额外延迟，且内存逻辑保持独立。但“在后台运行”本身也存在缺点：内存无法即时更新，还需额外逻辑来判断何时触发后台进程。

Another way to updating memory involves user feedback, which is particularly relevant to episodic memory. For example, if the user marks an interaction as a positive one, you can save that feedback to recall in the future.

另一种更新内存的方式是借助用户反馈，这对情景记忆（episodic memory）尤为关键。例如，若用户将某次交互标记为正面体验，你便可保存该反馈，以便未来调用。

## Why do we care about memory for agents?

## 为何要关注智能体（agent）的内存？

How does this impact what we’re building at LangChain? Well, memory greatly affects the usefulness of an agentic system, so we’re extremely interested in making it as easy as possible to leverage memory for applications.

这将如何影响 LangChain 正在构建的产品？事实上，内存会极大影响智能体系统的实用性，因此我们高度关注如何让开发者尽可能便捷地在应用中利用内存功能。

To this end, we’ve built a lot of functionality for this into our products. This includes:

为此，我们已在产品中集成了大量相关功能，包括：

- [Low-level abstractions for a memory store](https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/) in LangGraph to give you full control over your agent’s memory  
- LangGraph 中面向内存存储的[底层抽象接口](https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/)，助你全面掌控智能体的内存行为  

- [Template](https://github.com/langchain-ai/memory-template?ref=blog.langchain.com) for running memory both “in the hot path” and “in the background” in LangGraph  
- LangGraph 中支持内存既“运行于热路径（hot path）”又“运行于后台”的[模板](https://github.com/langchain-ai/memory-template?ref=blog.langchain.com)  

- [Dynamic few shot example selection](https://blog.langchain.com/dynamic-few-shot-examples-langsmith-datasets/) in LangSmith for rapid iteration  
- LangSmith 中支持[动态少样本示例选择](https://blog.langchain.com/dynamic-few-shot-examples-langsmith-datasets/)，助力快速迭代  

We’ve even built [a few applications of our own](https://github.com/langchain-ai/open-canvas?ref=blog.langchain.com) that leverage memory! It’s still early though, so we’ll keep on learning about agent memory and the areas it can be used effectively 🙂

我们甚至已开发出[若干自有应用](https://github.com/langchain-ai/open-canvas?ref=blog.langchain.com)，均深度整合了内存能力！不过目前仍处于早期阶段，我们将持续探索智能体内存的潜力及其高效适用场景🙂

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)  

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/memory-for-agents/img_003.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/memory-for-agents/img_004.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：大规模理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/memory-for-agents/img_005.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用行为；在 AI 中，追踪数据（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses— oh my!](images/memory-for-agents/img_006.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses— oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses—oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**代理框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/memory-for-agents/img_007.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/memory-for-agents/img_007.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/memory-for-agents/img_008.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？别再来了！](images/memory-for-agents/img_008.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？别再来了！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟
{% endraw %}
