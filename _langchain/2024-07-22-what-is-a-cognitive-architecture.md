---
title: "What is a \"cognitive architecture\"?"
source: "LangChain Blog"
url: "https://blog.langchain.com/what-is-a-cognitive-architecture/"
date: "2024-07-22"
scraped_at: "2026-03-03T07:58:13.666946304+00:00"
language: "en-zh"
translated: true
description: "The second installment in our \"In the Loop\" series, focusing on what cognitive architecture means."
tags: ["Harrison Chase", "Harrison's Hot Takes"]
---
&#123;% raw %}

**_Update: Several readers have pointed out that the term "cognitive architecture" has a_** [**_rich history_**](https://en.wikipedia.org/wiki/Cognitive_architecture?ref=blog.langchain.com) **_in neuroscience and computational cognitive science. Per Wikipedia, "a cognitive architecture refers to both a theory about the structure of the human mind and to a computational instantiation of such a theory". That definition (and corresponding research and articles on the topic) are more comprehensive than any definition I attempt to offer here, and this blog should instead be read as a mapping of my experience building and helping build LLM-powered applications over the past year to this area of research._**

**_更新：多位读者指出，“认知架构”（cognitive architecture）一词在神经科学与计算认知科学领域拥有_** [**_深厚的历史渊源_**](https://en.wikipedia.org/wiki/Cognitive_architecture?ref=blog.langchain.com) **_。据维基百科定义：“认知架构既指关于人类心智结构的一种理论，也指该理论的一种计算实现。”这一定义（以及围绕该主题的相关研究与文献）远比我在本文中尝试给出的任何定义更为全面；因此，本文更应被视作将我过去一年间构建及协助构建大语言模型（LLM）驱动应用的实践经验，映射到这一研究领域的尝试。_**

One phrase I’ve used a lot over the past six months (and will likely use more) is “cognitive architecture”. It’s a term I first heard from [Flo Crivello](https://x.com/Altimor?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor&ref=blog.langchain.com) \- all credit for coming up with it goes to him, and I think it's a fantastic term. So what exactly do I mean by this?

过去六个月里，我频繁使用（且未来很可能继续使用）的一个短语是“cognitive architecture”（认知架构）。这个词我最初是从[Flo Crivello](https://x.com/Altimor?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor&ref=blog.langchain.com)那里听到的——这个术语的提出完全归功于他，而我认为它确实是一个极佳的表述。那么，我究竟想用它表达什么含义呢？

What I mean by cognitive architecture is _how your system thinks —_ in other words, the flow of code/prompts/LLM calls that takes user input and performs actions or generates a response.

我所指的“认知架构”，即 _系统如何进行思考_ —— 换言之，就是接收用户输入、执行操作或生成响应所依赖的代码/提示词/大语言模型调用的整体流程。

I like the word “cognitive” because agentic systems rely on using an LLM to reason about what to do.

我喜欢“cognitive”（认知）一词，是因为具身智能体（agentic）系统依赖大语言模型进行推理，以决定下一步该做什么。

I like the word “architecture” because these agentic systems still involve a good amount of engineering similar to traditional system architecture.

我喜欢“architecture”（架构）一词，是因为这类具身智能体系统仍需大量工程实践，其复杂性与传统系统架构颇为相似。

## Mapping levels of autonomy to cognitive architectures

## 将自主性层级映射至认知架构

If we refer back to this slide (originally from [my TED Talk](https://www.ted.com/talks/harrison_chase_the_magical_ai_assistants_of_the_future_and_the_engineering_behind_them?ref=blog.langchain.com)) on the different levels of autonomy in LLM applications, we can see examples of different cognitive architectures.

若我们回溯这张幻灯片（最初出自[我的TED演讲](https://www.ted.com/talks/harrison_chase_the_magical_ai_assistants_of_the_future_and_the_engineering_behind_them?ref=blog.langchain.com)），其中展示了大语言模型应用中不同层级的自主性，便可从中看到各类认知架构的具体示例。

![](images/what-is-a-cognitive-architecture/img_001.png)

![](images/what-is-a-cognitive-architecture/img_001.png)

First is just code - everything is hard coded. Not even really a cognitive architecture.

第一类仅依赖纯代码——所有逻辑均被硬编码。严格来说，这甚至还不构成一种“认知架构”。

Next is just a single LLM call. Some data preprocessing before and/or after, but a single LLM call makes up the majority of the application. Simple chatbots likely fall into this category.

第二类则仅涉及一次大语言模型调用：调用前和/或调用后可能包含少量数据预处理，但整个应用的核心功能几乎完全由这一次LLM调用完成。简单的聊天机器人通常就属于此类。

Next is a chain of LLM calls. This sequence can be either breaking the problem down into different steps, or just serve different purposes. More complex RAG pipelines fall into this category: use a first LLM call to generate a search query, then a second LLM call to generate an answer.

接下来是一系列大语言模型（LLM）调用。该序列既可以将问题分解为多个步骤，也可以服务于不同目的。更复杂的 RAG（检索增强生成）流水线即属于此类：首先调用一次 LLM 生成搜索查询，再调用另一次 LLM 生成最终答案。

After that, a router. Prior to this, you knew all the steps the application would take _ahead_ of time. Now, you no longer do. The LLM decides which actions to take. This adds in a bit more randomness and unpredictability.

随后是一个路由器（router）。在此之前，你已预先明确应用程序将执行的所有步骤；而在此之后，你不再能提前预知全部流程——LLM 将自主决定采取哪些动作。这为系统引入了更多随机性与不可预测性。

The next level is what I call a state machine. This is combining an LLM doing some routing with a loop. This is even more unpredictable, as by combining the router with a loop, the system could (in theory) invoke an unlimited number of LLM calls.

再上一层，我称之为“状态机”（state machine）。它将 LLM 的路由能力与循环机制相结合。由于路由器与循环耦合，系统的运行路径变得更为不可预测——理论上，系统可触发无限次 LLM 调用。

The final level of autonomy is the level I call an _agent_, or really an “autonomous agent”. With state machines, there are still constraints on which actions can be taken and what flows are executed after that action is taken. With autonomous agents, those guardrails are removed. The system itself starts to decide which steps are available to take and what the instructions are: this can be done by updating the prompts, tools, or code used to power the system.

自主性的最高层级，我称之为“智能体”（_agent_），更准确地说是“自主智能体”（autonomous agent）。在状态机中，仍存在对可执行动作及后续执行流程的约束；而在自主智能体中，这些限制被彻底移除。系统自身开始决定当前可选的操作步骤，以及相应的指令内容——这一过程可通过动态更新提示词（prompts）、工具（tools）或驱动系统运行的代码来实现。

## **Choosing a cognitive architecture**

## **选择认知架构**

When I talk about "choosing a cognitive architecture,” I mean choosing which of these architectures you want to adopt. None of these are strictly “better” than others - they all have their own purpose for different tasks.

当我提到“选择认知架构”时，指的是从上述几种架构中选择一种作为你的应用基础。这些架构并无绝对优劣之分——每种都针对特定任务而设计，各有所长。

When building LLM applications, you’ll probably want to experiment with different cognitive architectures just as frequently as you experiment with prompts. We’re building [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) and [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) to enable that. Most of our development efforts over the past year have gone into building low-level, highly controllable orchestration frameworks (LCEL and LangGraph).

在构建 LLM 应用时，你很可能需要像反复调试提示词一样，频繁尝试不同的认知架构。为此，我们正在开发 [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) 和 [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com)。过去一年中，我们的大部分研发精力都投入到了构建底层、高度可控的编排框架（即 LCEL 和 LangGraph）之中。

This is a bit of a departure from early LangChain which focused on easy-to-use, off-the-shelf chains. These were great for getting started but tough to customize and experiment with. This was fine early on, as everyone was just trying to get started, but as the space matured, the design pretty quickly hit its limits.

这一方向与早期 LangChain 的设计理念略有不同——彼时 LangChain 侧重于提供开箱即用、易于上手的链式组件（chains）。这类组件非常适合快速入门，但在定制化和实验探索方面却显得力不从心。初期这并无大碍，因为当时大家普遍处于摸索阶段；但随着整个领域日趋成熟，该设计很快便触及了其能力边界。

I’m extremely proud of the changes we’ve made over the past year to make LangChain and LangGraph more flexible and customizable. If you’ve only ever used LangChain through the high level wrappers, check out the low-level bits. They are much more customizable, and will really let you control the cognitive architecture of your application.

我对过去一年中我们为提升 LangChain 和 LangGraph 的灵活性与可定制性所做出的改进深感自豪。如果你此前仅通过高层封装（high-level wrappers）使用 LangChain，那么请务必尝试一下底层接口（low-level bits）——它们具备更强的可定制能力，真正赋予你掌控应用认知架构的权力。

_If you’re building straight-forward chains and retrieval flows, check out LangChain in_ [_Python_](https://python.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) _and_ [_JavaScript_](https://js.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) _. For more complex agentic workflows, try out LangGraph in_ [_Python_](https://langchain-ai.github.io/langgraph/tutorials/introduction/?ref=blog.langchain.com) _and_ [_JavaScript_](https://langchain-ai.github.io/langgraphjs/tutorials/quickstart/?ref=blog.langchain.com) _._

_若你正构建结构清晰的链式流程或检索流程，请查阅 LangChain 的_ [_Python 版本_](https://python.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) _和_ [_JavaScript 版本_](https://js.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) _；若需实现更复杂的智能体（agent）工作流，则推荐尝试 LangGraph 的_ [_Python 版本_](https://langchain-ai.github.io/langgraph/tutorials/introduction/?ref=blog.langchain.com) _和_ [_JavaScript 版本_](https://langchain-ai.github.io/langgraphjs/tutorials/quickstart/?ref=blog.langchain.com) _。_

### Tags

### 标签

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) [Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) [Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/what-is-a-cognitive-architecture/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![论智能体框架与智能体可观测性](images/what-is-a-cognitive-architecture/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**论智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/what-is-a-cognitive-architecture/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪数据到深度洞察：规模化理解智能体行为](images/what-is-a-cognitive-architecture/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/what-is-a-cognitive-architecture/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码记录应用行为；在人工智能中，追踪数据（traces）承担这一角色。](images/what-is-a-cognitive-architecture/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用；在 AI 中，追踪（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/what-is-a-cognitive-architecture/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与封装器——天哪！](images/what-is-a-cognitive-architecture/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与封装器——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/what-is-a-cognitive-architecture/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/what-is-a-cognitive-architecture/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/what-is-a-cognitive-architecture/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不，这次不一样！](images/what-is-a-cognitive-architecture/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不，这次不一样！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟
&#123;% endraw %}
