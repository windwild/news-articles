---
title: "How to think about agent frameworks"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-to-think-about-agent-frameworks/"
date: "2026-02-17"
scraped_at: "2026-03-03T07:14:11.320953521+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---

**TL;DR:**

**简明摘要：**

- **构建可靠智能体（agentic）系统最难的部分，在于确保大语言模型（LLM）在每一步都拥有恰当的上下文。这既包括精确控制输入 LLM 的内容，也包括运行恰当的步骤以生成相关的内容。**  
- **智能体系统由工作流（workflows）和智能体（agents）共同构成（以及二者之间的所有中间形态）。**  
- **大多数智能体框架既非声明式（declarative）也非命令式（imperative）的编排框架，而仅仅是一组智能体抽象（agent abstractions）。**  
- **智能体抽象虽能降低入门门槛，却常常掩盖底层逻辑，使得确保 LLM 在每一步都获得恰当上下文变得困难。**  
- **无论规模与形态如何（单智能体、多智能体或工作流），所有智能体系统均能从同一套实用功能中受益——这些功能可由框架提供，也可从零构建。**  
- **LangGraph 最佳定位是一个编排框架（同时支持声明式与命令式 API），其上层构建了一系列智能体抽象。**

OpenAI 最近发布了一份《构建智能体指南》，其中包含一些有失偏颇的观点，例如下图所示：

![](images/how-to-think-about-agent-frameworks/img_001.jpg)

这一段引述最初令我颇为恼火；但当我开始撰写回应时才意识到：**思考智能体框架本身确实非常复杂！** 当前市面上可能有上百种不同的智能体框架；它们可在数十个维度上被比较；不同概念常被混为一谈（正如引文中所见）；领域内充斥着大量炒作、姿态性宣示与噪音；而真正严谨、精准的分析与思辨却极为稀缺。本篇博客正是我们对此所作的一次尝试。我们将涵盖以下主题：

- **背景信息**  
  - 什么是智能体（agent）？  
  - 构建智能体的难点何在？  
  - 什么是 LangGraph？  
- **智能体框架的类型划分**  
  - “智能体” vs “工作流”  
  - 声明式（declarative）vs 非声明式（non-declarative）  
  - 智能体抽象（agent abstractions）  
  - 多智能体（multi-agent）  
- **常见问题解答**  
  - 框架的价值究竟何在？  
  - 随着模型能力不断提升，是否所有系统终将演变为“智能体”，而非“工作流”？  
  - OpenAI 的观点中存在哪些偏差？  
  - 各类智能体框架之间究竟如何对比？

在本文中，我将反复引用以下几份关键材料：

- [OpenAI《构建智能体实用指南》](https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf?ref=blog.langchain.com)（我认为该指南质量一般）  
- [Anthropic《构建高效智能体指南》](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com)（我个人非常推崇）  
- [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)（我们用于构建可靠智能体的框架）

# Background info

# 背景信息

Helpful context to set the stage for the rest of the blog.

为后续内容提供必要铺垫的背景知识。

## What is an agent

## 什么是智能体（agent）？

There is no consistent definition of an agent, and they are often offered through different lenses.

目前尚无关于“智能体（agent）”的统一定义，不同机构往往从各自视角出发提出不同的理解。

OpenAI takes a higher level, more thought-leadery approach to defining an agent.

OpenAI 采用一种更高层次、更具思想领导力（thought-leadership）色彩的方式来定义智能体。

> Agents are systems that independently accomplish tasks on your behalf.

> 智能体是能够代表你独立完成任务的系统。

I am personally not a fan of this. This is a vague statement that doesn’t really help me understand what an agent is. It’s just thought-leadership and not practical at all.

我个人并不认同这一定义。这是一句模糊的表述，实际上无助于我真正理解“智能体”究竟是什么。它纯粹属于思想领导层面的提法，毫无实践指导意义。

Compare this to Anthropic’s definition:

不妨对比 Anthropic 的定义：

> "Agent" can be defined in several ways. Some customers define agents as fully autonomous systems that operate independently over extended periods, using various tools to accomplish complex tasks. Others use the term to describe more prescriptive implementations that follow predefined workflows. At Anthropic, we categorize all these variations as **agentic systems**, but draw an important architectural distinction between **workflows** and **agents**:
>
> **Workflows** are systems where LLMs and tools are orchestrated through predefined code paths.
>
> **Agents**, on the other hand, are systems where LLMs dynamically direct their own processes and tool usage, maintaining control over how they accomplish tasks.

> “智能体（agent）”可有多种定义方式。部分客户将智能体定义为完全自主的系统——它们可在较长时间内独立运行，并借助各类工具完成复杂任务；另一些用户则用该术语指代更偏指令式（prescriptive）的实现方案，即严格遵循预定义工作流（workflow）执行操作。在 Anthropic，我们将上述所有变体统称为 **“具身智能系统（agentic systems）”**，但同时在架构层面明确区分了 **“工作流（workflows）”** 与 **“智能体（agents）”**：
>
> **工作流（workflows）** 是指大语言模型（LLM）与工具通过预设代码路径进行编排的系统；
>
> 而 **智能体（agents）** 则是指大语言模型能够动态主导自身执行流程与工具调用、全程掌控任务达成方式的系统。

I like Anthropic’s definition better for a few reasons:

我更欣赏 Anthropic 的定义，原因有以下几点：

- Their definition of an agent is much more precise and technical.

- 其对“智能体”的定义更为精准、更具技术深度。

- They also make reference to the concept of “agentic systems”, and categorize both workflows and agents as variants of this. I **love** this.

- 他们还引入了“具身智能系统（agentic systems）”这一上位概念，并将工作流与智能体均归为其不同变体。这一点我 **非常喜欢**！

💡

Nearly all of the “agentic systems” we see in production are a **combination** of “workflows” and “agents”.

在生产环境中，我们所见到的几乎所有“智能体系统”（agentic systems）都是“工作流”（workflows）与“智能体”（agents）的**结合体**。

Later in the blog post, Anthropic defines agents as “… typically just LLMs using tools based on environmental feedback in a loop.”

在该博客文章后文，Anthropic 将智能体定义为：“……通常只是大语言模型（LLM）在一个循环中，依据环境反馈调用工具。”

![](images/how-to-think-about-agent-frameworks/img_002.webp)

Despite their grandiose definition of an agent at the start, this is basically what OpenAI means as well.

尽管其开篇对“智能体”的定义显得宏大而抽象，但这一描述本质上也契合 OpenAI 所指的含义。

These types of agents are parameterized by:

此类智能体由以下参数化定义：

- The model to use  
- 待使用的模型  

- The instructions (system prompt) to use  
- 待使用的指令（即系统提示词，system prompt）  

- The tools to use  
- 待使用的工具  

You call the model in a loop. If/when it decides to call a tool, you run that tool, get some observation/feedback, and then pass that back into the LLM. You run until the LLM decides to not call a tool (or it calls a tool that triggers a stopping criteria).

你以循环方式调用模型：若模型决定调用某个工具，你就执行该工具，获得相应的观察结果或反馈，并将该结果重新输入大语言模型；如此反复，直至模型决定不再调用任何工具（或调用了触发终止条件的工具）为止。

Both OpenAI and Anthropic call out workflows as being a different design pattern than agents. The LLM is less in control there, the flow is more deterministic. This is a helpful distinction!

OpenAI 与 Anthropic 均明确指出：工作流（workflows）是一种不同于智能体的设计范式。在工作流中，大语言模型的自主控制程度较低，整个流程更具确定性。这一区分非常有价值！

Both OpenAI and Anthropic explicitly call out that you do not always need agents. In many cases, workflows are simpler, more reliable, cheaper, faster, and more performant. A great quote from the Anthropic post:

OpenAI 与 Anthropic 均明确强调：你并非总需要使用智能体。在许多场景下，工作流更简单、更可靠、成本更低、速度更快，且性能更优。Anthropic 博客中有一段极富启发性的引述：

> When building applications with LLMs, we recommend finding the simplest solution possible, and only increasing complexity when needed. This might mean not building agentic systems at all. Agentic systems often trade latency and cost for better task performance, and you should consider when this tradeoff makes sense.  
>  
> When more complexity is warranted, workflows offer predictability and consistency for well-defined tasks, whereas agents are the better option when flexibility and model-driven decision-making are needed at scale.

> 在基于大语言模型构建应用时，我们建议优先寻找尽可能简单的解决方案，仅在确有必要的时候才增加复杂度。这甚至可能意味着完全无需构建智能体系统。智能体系统往往以更高的延迟和成本为代价，换取更优的任务表现；因此，你需要审慎评估这一权衡是否合理。  
>   
> 当确实需要更高复杂度时，工作流能为定义明确的任务提供可预测性与一致性；而当大规模场景下亟需灵活性与由模型驱动的决策能力时，智能体才是更优选择。

OpenAI says something similar:

> Before committing to building an agent, validate that your use case can meet these criteria clearly. Otherwise, a deterministic solution may suffice.

OpenAI 表达了类似的观点：

> 在决定构建智能体（agent）之前，请先验证你的使用场景是否能明确满足这些标准；否则，一个确定性的解决方案可能就已足够。

In practice, we see that most “agentic systems” are a combination of workflows and agents. This is why I actually **hate** talking about whether something is an agent, but prefer talking about how agentic a system is. h/t the great Andrew Ng for this way of [thinking about things](https://x.com/AndrewYNg/status/1801295202788983136?ref=blog.langchain.com):

在实践中，我们发现大多数“具身智能体系统”（agentic systems）其实是工作流（workflows）与智能体的结合体。正因如此，我其实**非常反感**讨论某个系统“是不是”智能体，而更愿意探讨一个系统在多大程度上具备“智能体特性”（agentic）。感谢杰出的吴恩达（Andrew Ng）提出这种[思考方式](https://x.com/AndrewYNg/status/1801295202788983136?ref=blog.langchain.com)：

> 我们不必以非此即彼的二元方式去判定某物“是否是”智能体；相反，更有价值的做法是将各类系统视为在不同程度上“具有智能体特征”（agent-like）。与名词“agent”不同，“agentic”作为形容词，使我们得以对这类系统展开细致考量，并将它们全部纳入这场方兴未艾的智能体运动之中。

## What is hard about building agents?

## 构建智能体的难点何在？

I think most people would agree that building agents is hard. Or rather - building an agent as a prototype is easy, but a reliable one, that can power business-critical applications? That is hard.

我认为大多数人会认同：构建智能体确实很难。更准确地说——构建一个原型智能体很容易，但要打造一个稳定可靠、足以支撑关键业务应用的智能体？那才真正困难。

The tricky part is exactly that - making it reliable. You can make a demo that looks good on Twitter easily. But can you run it to power a business critical application? Not without a lot of work.

真正的难点恰恰在于——如何确保其可靠性。你很容易做出一个在 Twitter 上看起来惊艳的演示；但能否将其投入实际运行，用以支撑关键业务应用？若不付出大量努力，答案是否定的。

We did a survey of agent builders a few months ago and asked them: _“What is your biggest limitation of putting more agents in production?”_ The number one response by far was “performance quality” - it’s still really hard to make these agents work.

几个月前，我们曾对一批智能体开发者开展过一项调研，向他们提问：“目前阻碍您将更多智能体投入生产的最大瓶颈是什么？”压倒性排名第一的答案是“性能质量”——让这些智能体真正稳定、有效地运行，至今仍极为困难。

![](images/how-to-think-about-agent-frameworks/img_003.svg)

![](images/how-to-think-about-agent-frameworks/img_003.svg)

_What causes agents to perform poorly sometimes?_ The LLM messes up.

_为何智能体有时表现欠佳？_ 大型语言模型（LLM）出了差错。

_Why does the LLM mess up?_

_为什么大语言模型（LLM）会出错？_

Two reasons: (a) the model is not good enough, (b) the wrong (or incomplete) context is being passed to the model.

原因有二：（a）模型本身不够好；（b）传给模型的上下文错误或不完整。

From our experience, it is very frequently the second use case. What causes this?

根据我们的经验，第二种情况极为常见。那么，这究竟是由什么导致的？

- Incomplete or short system messages  
- 系统提示信息不完整或过于简短  

- Vague user input  
- 用户输入模糊不清  

- Not having access to the right tools  
- 无法访问合适的工具  

- Poor tool descriptions  
- 工具描述质量差  

- Not passing in the right context  
- 未传入恰当的上下文  

- Poorly formatted tool responses  
- 工具响应格式不规范  

💡

💡

**The hard part of building reliable agentic systems is making sure the LLM has the appropriate context at each step. This includes both controlling the exact content that goes into the LLM, as well as running the appropriate steps to generate relevant content.**

**构建可靠智能体（agentic）系统最难的部分，是确保大语言模型在每一步都拥有恰当的上下文。这既包括精准控制输入到 LLM 中的具体内容，也包括执行恰当的步骤以生成相关的内容。**

As we discuss agent frameworks, it’s helpful to keep this in mind. Any framework that makes it harder to control **exactly** what is being passed to the LLM is just getting in your way. It’s already hard enough to pass the correct context to the LLM - why would you make it harder on yourself?

我们在讨论智能体框架时，应始终牢记这一点。任何让**精确控制**传入 LLM 的内容变得更困难的框架，都只是在给你添麻烦。向 LLM 传递正确的上下文本就已十分困难——你又何必自找麻烦、进一步增加难度呢？

## What is LangGraph

## 什么是 LangGraph？

💡

💡

LangGraph is best thought of as a orchestration framework (with both declarative and imperative APIs), with a series of agent abstractions built on top.

LangGraph 最好被理解为一个编排框架（同时提供声明式与命令式 API），其上构建了一系列面向智能体的抽象层。

LangGraph is an event-driven framework for building agentic systems. The two most common ways of using it are through:

LangGraph 是一个面向事件驱动的框架，专为构建智能体系统而设计。其最常见的两种使用方式是：

- a [declarative, graph-based syntax](https://langchain-ai.github.io/langgraph/tutorials/introduction/?ref=blog.langchain.com)  
- 一种[声明式、基于图的语法](https://langchain-ai.github.io/langgraph/tutorials/introduction/?ref=blog.langchain.com)

- [agent abstractions](https://langchain-ai.github.io/langgraph/agents/overview/?ref=blog.langchain.com) (built on top of the lower level framework)  
- [智能体抽象层](https://langchain-ai.github.io/langgraph/agents/overview/?ref=blog.langchain.com)（构建于底层框架之上）

LangGraph also supports a [functional API](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com), as well as the underlying [event-driven API](https://langchain-ai.github.io/langgraph/concepts/pregel/?ref=blog.langchain.com). There exist both [Python](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) and [Typescript](https://langchain-ai.github.io/langgraphjs/?ref=blog.langchain.com) variants.  
LangGraph 还支持[函数式 API](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com)，以及底层的[事件驱动型 API](https://langchain-ai.github.io/langgraph/concepts/pregel/?ref=blog.langchain.com)。目前提供 [Python](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 和 [TypeScript](https://langchain-ai.github.io/langgraphjs/?ref=blog.langchain.com) 两种实现。

Agentic systems can be represented as [nodes](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#nodes) and [edges](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#edges). Nodes represent units of work, while edges represent transitions. Nodes and edges are nothing more than normal Python or TypeScript code — so while the structure of the graph is represented in a declarative manner, the inner functioning of the graph’s logic is normal, imperative code. Edges can be either [fixed](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#normal-edges) or [conditional](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#conditional-edges). So while the structure of the graph is declarative, the path through the graph can be completely dynamic.  
智能体系统可被建模为[节点](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#nodes)和[边](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#edges)。节点代表工作单元，边则代表状态转移。节点与边本质上只是标准的 Python 或 TypeScript 代码——因此，尽管图的结构以声明式方式表达，其内部逻辑仍采用常规的命令式编程范式实现。边可分为[固定边](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#normal-edges)或[条件边](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#conditional-edges)。换言之，图的结构是声明式的，但图中实际执行路径却可以完全动态化。

LangGraph comes with a [built-in persistence layer](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com). This enables [fault tolerance](https://langchain-ai.github.io/langgraph/concepts/persistence/?h=fault+to&ref=blog.langchain.com#fault-tolerance), [short-term memory](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#short-term-memory), and [long-term memory](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#long-term-memory).  
LangGraph 内置了[持久化层](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com)，从而支持[容错能力](https://langchain-ai.github.io/langgraph/concepts/persistence/?h=fault+to&ref=blog.langchain.com#fault-tolerance)、[短期记忆](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#short-term-memory)和[长期记忆](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#long-term-memory)。

This persistence layer also enables “ [human-in-the-loop](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com)” and “ [human-on-the-loop](https://langchain-ai.github.io/langgraph/concepts/time-travel/?ref=blog.langchain.com)” patterns, such as interrupt, approve, resume, and time travel.  
该持久化层还支持“[人在回路中（human-in-the-loop）](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com)”与“[人在环上（human-on-the-loop）](https://langchain-ai.github.io/langgraph/concepts/time-travel/?ref=blog.langchain.com)”等模式，例如中断执行、人工审批、恢复运行及时间回溯（time travel）等功能。

LangGraph has built-in support for [streaming](https://langchain-ai.github.io/langgraph/concepts/streaming/?ref=blog.langchain.com): of tokens, node updates, and arbitrary events.  
LangGraph 原生支持[流式传输](https://langchain-ai.github.io/langgraph/concepts/streaming/?ref=blog.langchain.com)：包括 token 流、节点更新流以及任意自定义事件流。

LangGraph integrates seamlessly with [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) for debugging, evaluation, and observability.  
LangGraph 可与 [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) 无缝集成，用于调试、评估与可观测性分析。

# Flavors of agentic frameworks  

# 智能体框架的不同形态

Agentic frameworks are different across a few dimensions. Understanding — and not conflating — these dimensions is key to being able to properly compare agentic frameworks.  
智能体框架在若干维度上存在差异。准确理解这些维度（并避免混淆它们），是正确比较各类智能体框架的关键前提。

## Workflows vs Agents  

## 工作流（Workflows）vs 智能体（Agents）

Most frameworks contain higher level agent abstractions. Some frameworks include some abstraction for common workflows. LangGraph is a low level orchestration framework for building agentic systems. LangGraph supports [workflows, agents, and anything in-between](https://langchain-ai.github.io/langgraph/concepts/agentic_concepts/?ref=blog.langchain.com). We think this is crucial. As mentioned, most agentic systems in production are a combination of workflows and agents. A production-ready framework needs to support both.

大多数框架都包含更高层级的智能体（agent）抽象。一些框架还为常见工作流（workflow）提供了某种抽象。LangGraph 是一个用于构建智能体系统的低层级编排框架。LangGraph 支持[工作流、智能体，以及二者之间的任意形态](https://langchain-ai.github.io/langgraph/concepts/agentic_concepts/?ref=blog.langchain.com)。我们认为这一点至关重要。如前所述，目前投入生产的大多数智能体系统，都是工作流与智能体的混合体。一个面向生产环境的框架必须同时支持二者。

Let’s remember what is hard about building reliable agents - making sure the LLM has the right context. Part of why workflows are useful is that they make it easy to pass the right context to LLMs. You decide exactly how the data flows.

让我们回顾一下：构建可靠智能体的难点在于——确保大语言模型（LLM）拥有恰当的上下文。工作流之所以有用，部分原因正在于此：它让向 LLM 传递合适上下文变得简单直接；数据如何流动，完全由你自主决定。

As you think about where on spectrum of “workflow” to “agent” you want to build your application, there are two things to think about:

当你思考自己的应用应落在“工作流”到“智能体”这一光谱的哪个位置时，需重点考虑以下两个维度：

- Predictability vs agency  
- Low floor, high ceiling  

- 可预测性 vs 自主性  
- 入门门槛低，扩展上限高  

**Predictability vs agency**

**可预测性 vs 自主性**

As your system becomes more agentic, it will become less predictable.

随着系统自主性增强，其行为将趋于不可预测。

Sometimes you want or need your system to be predictable - for user trust, regulatory reasons, or other.

有时，你希望甚至必须让系统保持可预测性——例如，为了赢得用户信任、满足监管要求，或其他原因。

Reliability does not track 100% with predictability, but in practice they can be closely related.

可靠性并不与可预测性完全同步（即并非 100% 正相关），但在实践中，二者往往密切相关。

Where you want to be on this curve is pretty specific to your application. LangGraph can be used to build applications anywhere on this curve, allowing you to move to the point on the curve that you want to be.

你希望系统处于该曲线上的哪个位置，高度取决于你的具体应用场景。LangGraph 可用于构建该曲线上任意位置的应用，使你能灵活地将系统定位在你期望的那一点上。

![](images/how-to-think-about-agent-frameworks/img_004.png)

**High floor, low ceiling**

**高门槛，低上限**

When thinking about frameworks, it can be helpful to think about their floors and ceilings:

在思考框架时，考虑其“门槛”（floor）和“上限”（ceiling）会很有帮助：

- Low floor: A **low floor** framework is beginner-friendly and easy to get started with  
- 低门槛：**低门槛**框架对初学者友好，上手容易  

- High floor: A framework with a **high floor** means it has a steep learning curve and requires significant knowledge or expertise to begin using it effectively.  
- 高门槛：**高门槛**框架学习曲线陡峭，需要相当的知识储备或专业经验才能有效使用  

- Low ceiling: A framework with a **low ceiling** means it has limitations on what can be accomplished with it (you will quickly outgrow it).  
- 低上限：**低上限**框架能力有限，难以支撑复杂任务（你很快就会发现它不够用）  

- High ceiling: A **high ceiling** framework offers extensive capabilities and flexibility for advanced use cases (it grows with you?).  
- 高上限：**高上限**框架功能丰富、灵活度高，可支持高级应用场景（它能与你共同成长？）  

Workflow frameworks offer a high ceiling, but come with a high floor — you have to write lot of the agent logic yourself.

工作流框架具备高上限，但同时也具有高门槛——你需要自行编写大量智能体（agent）逻辑。

Agent frameworks are low floor, but low ceiling — easy to get started with, but not enough for non-trivial use cases.

智能体框架门槛低，但上限也低——上手容易，却难以应对非平凡（non-trivial）的实际场景。

LangGraph aims to have aspects that are low floor ([built-in agent abstractions](https://langchain-ai.github.io/langgraph/agents/overview/?ref=blog.langchain.com) that make it easy to get started) but also high ceiling ([low-level functionality](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) to achieve advanced use cases).

LangGraph 力求兼具低门槛（例如 [内置的智能体抽象](https://langchain-ai.github.io/langgraph/agents/overview/?ref=blog.langchain.com)，让入门变得轻松）与高上限（例如 [底层功能接口](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com)，以支撑高级应用场景）。

## Declarative vs non-declarative

## 声明式 vs 非声明式

There are benefits to declarative frameworks. There are also downsides. This is a seemingly endless debate among programmers, and everyone has their own preferences.

声明式框架有其优势，也有其不足。这在程序员群体中是一场看似永无止境的争论，每个人都有自己的偏好。

When people say non-declarative, they are usually implying imperative as the alternative.

当人们提到“非声明式”时，通常所指的替代方案是“命令式”（imperative）。

Most people would describe LangGraph as a declarative framework. This is only partially true.

多数人会将 LangGraph 描述为一个声明式框架。但这仅部分正确。

First - while the connections between the nodes and edges are done in a declarative manner, the actual nodes and edges are nothing more than Python or TypeScript functions. Therefore, LangGraph is kind of a blend between declarative and imperative.

第一点——尽管节点与边之间的连接是以声明式（declarative）方式定义的，但节点和边本身本质上只是 Python 或 TypeScript 函数。因此，LangGraph 实际上是一种声明式与命令式（imperative）的混合体。

Second - we actually support other APIs besides the recommended declarative API. Specifically, we support both [functional](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com) and [event-driven APIs](https://langchain-ai.github.io/langgraph/concepts/pregel/?ref=blog.langchain.com). While we think the declarative API is a useful mental model, we also recognize it is not for everyone.

第二点——除推荐的声明式 API 外，我们实际上还支持其他 API。具体而言，我们同时支持 [函数式 API](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com) 和 [事件驱动式 API](https://langchain-ai.github.io/langgraph/concepts/pregel/?ref=blog.langchain.com)。尽管我们认为声明式 API 是一种有益的思维模型，但我们同样承认它并不适合所有人。

A common comment about LangGraph is that is like Tensorflow (a declarative deep learning framework), while frameworks like Agents SDK are like Pytorch (an imperative deep learning framework).

关于 LangGraph 的一个常见类比是：它类似于 TensorFlow（一种声明式的深度学习框架），而 Agents SDK 等框架则类似于 PyTorch（一种命令式的深度学习框架）。

This is just incorrect. Frameworks like Agents SDK (and original LangChain, CrewAI, etc) are neither declarative or imperative - they are just abstractions. They have an agent abstraction (a Python class) and it contains a bunch of internal logic that runs the agent. They’re not really orchestration frameworks. They are just abstractions.

这种说法完全不准确。像 Agents SDK（以及最初的 LangChain、CrewAI 等）这类框架，既非声明式，也非命令式——它们仅仅是一些抽象封装。它们提供了一个“智能体”（agent）抽象（通常是一个 Python 类），该类内部封装了一整套运行智能体的逻辑。它们本质上并非编排（orchestration）框架，而仅仅是抽象层。

## Agent Abstractions

## 智能体抽象（Agent Abstractions）

Most agent frameworks contain an agent abstraction. They usually start as a class that involves a prompt, model, and tools. Then they add in a few more parameters… then a few more… then even more. Eventually you end up with a litany of parameters that control a multitude of behaviors, all abstracted behind a class. If you want to see what’s going on, or change the logic, you have to go into the class and modify the source code.

大多数智能体框架都包含一个智能体抽象。它们通常始于一个类，该类封装了提示词（prompt）、大语言模型（model）和工具（tools）。随后逐步加入更多参数……再加一些……甚至更多。最终，你将面对一长串控制多种行为的参数，而所有这些都被隐藏在一个类的抽象背后。若你想了解其内部运行机制，或修改其逻辑，就必须深入该类并直接修改源代码。

💡

💡

These abstractions end up making it really really hard to understand or control exactly what is going into the LLM at all steps. This is important - having this control is crucial for building reliable agents (as discussed above). This is the danger of agent abstractions.

这类抽象最终使得人们极难理解或精确控制在每一步究竟有哪些内容被送入大语言模型（LLM）。这一点至关重要——对输入内容的精细掌控，是构建可靠智能体的关键前提（如前所述）。这正是智能体抽象所蕴含的风险。

We learned this the hard way. This was the issue with the original LangChain chains and agents. They provided abstractions that got in the way. One of those original abstractions from two years ago was an agent class that took in a model, prompt, and tools. This isn’t a new concept. It didn’t provide enough control back then, and it doesn’t now.

我们曾为此付出过惨痛代价。这正是最初 LangChain 的链（chains）与智能体（agents）所面临的问题：它们提供的抽象反而成了障碍。早在两年前，LangChain 就引入了一个智能体类，接收模型、提示词和工具作为输入——这一概念并不新鲜。当时它就未能提供足够的控制力，如今依然如此。

To be clear, there is some value in these agent abstractions. It makes it easier to get started. But I don’t think these agent abstractions are good enough to build reliable agents yet (and maybe ever).

需要明确的是，这类智能体抽象确实具有一定价值：它降低了入门门槛。但我认为，目前这些智能体抽象尚不足以支撑可靠智能体的构建（也许永远都不够）。

We think the best way to think about these agent abstractions is like Keras. They provide higher level abstractions to get started easily. But it’s crucial to make sure they are built on top of a lower level framework so you don’t outgrow it.

我们认为，理解这些智能体（agent）抽象的最佳方式是将其类比为 Keras。它们提供了更高层级的抽象，便于快速上手；但至关重要的是，这些抽象必须构建于一个底层框架之上，以确保系统具备长期可扩展性，不会因需求增长而受限。

That is why we have built agent abstractions on top of LangGraph. This provides an easy way to get started with agents, but if you need to escape to lower-level LangGraph you easily can.

正因如此，我们将智能体抽象构建在 LangGraph 之上。这为初学者提供了便捷的入门路径；而当你需要深入底层、调用 LangGraph 的原生能力时，也能轻松实现。

## Multi Agent

## 多智能体系统

Oftentimes agentic systems won’t just contain one agent, they will contain multiple. OpenAI says in their report:

智能体系统往往并非仅包含单个智能体，而是由多个智能体协同构成。OpenAI 在其报告中指出：

> For many complex workflows, splitting up prompts and tools across multiple agents allows for improved performance and scalability. When your agents fail to follow complicated instructions or consistently select incorrect tools, you may need to further divide your system and introduce more distinct agents.

> 对于许多复杂工作流而言，将提示词（prompts）和工具（tools）分散到多个智能体中，有助于提升性能与可扩展性。当你的智能体无法正确执行复杂指令，或持续选择错误工具时，你可能需要进一步拆分系统，并引入更多职责明确的独立智能体。

💡

💡

The key part of multi agent systems is how they communicate. Again, the hard part of building agents is getting the right context to LLMs. Communication between these agents is important.

多智能体系统的核心在于智能体之间的通信机制。再次强调：构建智能体的最大难点，始终是如何向大语言模型（LLM）提供恰当的上下文。因此，智能体之间的信息交互至关重要。

There a bunch of ways to do this! Handoffs are one way. This is an agent abstraction from Agents SDK that I actually quite like.

实现这种通信的方式多种多样！其中一种是“任务交接”（handoffs）。这是 Agents SDK 提供的一种智能体抽象，我个人非常欣赏。

But the best way for these agents to communicate can sometimes be workflows. Take all the workflow diagrams in Anthropic’s blog post, and replace the LLM calls with agents. This blend of workflows and agents often gives the best reliability.

但有时，让这些智能体通信的最优方式其实是工作流（workflows）。请参考 Anthropic 博客文章中的所有工作流图示，并将其中的 LLM 调用替换为智能体。这种“工作流 + 智能体”的融合架构，往往能带来最佳的系统可靠性。

![](images/how-to-think-about-agent-frameworks/img_005.webp)

Again - agentic systems are not just workflows, or just an agent. They can be - and often are - a combination of the two. As Anthropic points out in their blog post:

> **Combining and customizing these patterns**  
>   
> These building blocks aren't prescriptive. They're common patterns that developers can shape and combine to fit different use cases.

再次强调——具身智能系统（agentic systems）并不仅仅等同于工作流，也不仅仅等同于单个智能体（agent）。它们可以——而且通常确实是——二者的结合。正如 Anthropic 在其博客文章中所指出的：

> **组合与定制这些模式**  
>   
> 这些构建模块并非强制性规范，而是开发者可根据不同使用场景灵活调整与组合的常见模式。

# Common Questions

# 常见问题

Having defined and explored the different axes that you should be evaluating frameworks on, let’s now try to answer some common questions.

在明确定义并深入探讨了评估框架所需关注的各项维度之后，接下来我们尝试回答一些常见问题。

## What is the value of a framework?

## 框架的价值是什么？

We often see people questioning whether they need a framework to build agentic systems. What value can agent frameworks provide?

我们常常看到人们质疑：构建具身智能系统是否真的需要一个框架？智能体框架究竟能提供哪些价值？

**Agent abstractions**

**智能体抽象层**

Frameworks are generically useful because they contain useful abstractions which make it easy to get started and provide a common way for engineers to build, making it easier to onboard and maintain projects. As mentioned above, there are real downsides to agent abstractions as well. For most agent frameworks, this is the sole value they provide. We worked really hard to make sure this was not case for LangGraph.

框架之所以具有普适价值，在于其内置了实用的抽象层——这不仅大幅降低了入门门槛，还为工程师提供了统一的开发范式，从而显著提升团队协作、项目交接与长期维护的效率。如前所述，智能体抽象层也确实存在真实短板。对大多数智能体框架而言，这几乎是其唯一价值所在；而 LangGraph 则倾注大量努力，确保自身绝不止步于此。

**Short term memory**

**短期记忆能力**

Most agentic applications today involve some sort of multi-turn (e.g. chat) component. LangGraph provides [production ready storage to enable multi-turn experiences (threads)](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#short-term-memory).

当前绝大多数具身智能应用都包含多轮交互（例如对话）组件。LangGraph 提供了[开箱即用、可用于生产环境的存储机制，以支持多轮交互体验（即“会话线程”）](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#short-term-memory)。

**Long term memory**

**长期记忆**

While still early, I am very bullish on agentic systems learning from their experiences (e.g. remembering things across conversations). LangGraph provides [production ready storage for cross-thread memory](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#long-term-memory).

尽管尚处早期阶段，但我对智能体系统从自身经验中学习（例如，在不同对话间记住信息）持非常乐观的态度。LangGraph 提供了[面向生产环境的跨会话记忆存储能力](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#long-term-memory)。

**Human-in-the-loop**

**人在回路中**

Many agentic systems are made better with some human-in-the-loop component. Examples include getting feedback from the user, approving a tool call, or editing tool call arguments. LangGraph provides [built in support to enable these workflows in a production system](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com).

许多智能体系统通过引入“人在回路中”（human-in-the-loop）机制可显著提升效果。典型用例包括：获取用户反馈、审批工具调用、或编辑工具调用参数等。LangGraph 提供了[开箱即用的支持，使这些工作流可在生产系统中顺利运行](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com)。

**Human-on-the-loop**

**人在回路旁**

Besides allowing the user to affect the agent as it is running, it can also be useful to allow the user to inspect the agent’s trajectory after the fact, and even go back to earlier steps and then rerun (with changes) from there. We call this human-on-the-loop, and LangGraph provides [built in support for this](https://langchain-ai.github.io/langgraph/concepts/time-travel/?ref=blog.langchain.com).

除允许用户在智能体运行过程中实时干预外，还很有价值的是：支持用户事后回溯并检查智能体的完整执行轨迹，甚至能返回到更早的步骤，并从此处（经修改后）重新运行。我们将此模式称为“人在回路旁”（human-on-the-loop），LangGraph 为此提供了[原生支持](https://langchain-ai.github.io/langgraph/concepts/time-travel/?ref=blog.langchain.com)。

**Streaming**

**流式响应**

Most agentic applications take a while to run, and so providing updates to the end user can be critical for providing a good user experience. LangGraph provides [built in streaming of tokens, graph steps, and arbitrary streams](https://langchain-ai.github.io/langgraph/concepts/streaming/?ref=blog.langchain.com).

大多数智能体应用执行耗时较长，因此向终端用户持续提供中间更新，对保障良好的用户体验至关重要。LangGraph 提供了[对 token、图执行步骤及任意自定义数据流的原生流式支持](https://langchain-ai.github.io/langgraph/concepts/streaming/?ref=blog.langchain.com)。

**Debugging/observability**

**调试与可观测性**

The hard part of building reliable agents is making sure you are passing the right context to the LLM. Being able to inspect the exact steps taken by an agent, and the exact inputs/outputs at each step is crucial for building reliable agents. LangGraph integrates seamlessly with [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) for best in class debugging and observability. Note: [AI observability](https://www.langchain.com/articles/ai-observability?ref=blog.langchain.com) is different from traditional software observability (this deserves a separate post).

构建可靠智能体的最大难点，在于确保向大语言模型（LLM）传递了恰当的上下文。能够精确查看智能体所执行的每一步操作，以及每一步的确切输入与输出，是构建高可靠性智能体的关键。LangGraph 与 [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) 深度集成，提供业界领先的调试与可观测性能力。注意：[AI 可观测性](https://www.langchain.com/articles/ai-observability?ref=blog.langchain.com) 与传统软件可观测性存在本质区别（这一主题值得另撰专文详述）。

**Fault tolerance**

**容错性**

Fault tolerance is a key component of traditional frameworks (like Temporal) for building distributed applications. LangGraph makes fault tolerance easier with [durable workflows](https://langchain-ai.github.io/langgraph/concepts/durable_execution/?ref=blog.langchain.com) and [configurable retries](https://langchain-ai.github.io/langgraph/how-tos/node-retries/?h=retr&ref=blog.langchain.com).

容错性是构建分布式应用的传统框架（如 Temporal）中的关键组成部分。LangGraph 通过 [持久化工作流（durable workflows）](https://langchain-ai.github.io/langgraph/concepts/durable_execution/?ref=blog.langchain.com) 和 [可配置的重试机制（configurable retries）](https://langchain-ai.github.io/langgraph/how-tos/node-retries/?h=retr&ref=blog.langchain.com)，让容错能力更易实现。

**Optimization**

**优化**

Rather than tweaking prompts manually by hand, it can sometimes be easier to define an evaluation dataset and then automatically optimize your agent based on this. LangGraph currently does not support this out of the box - we think it is a little early for this. But I wanted to include this because I think it is an interesting dimension to consider, and something we are constantly keeping our eyes on. `dspy` is the best framework for this currently.

与其手动反复调整提示词（prompts），有时定义一个评估数据集、再基于该数据集自动优化智能体（agent），反而更高效。目前 LangGraph 尚未原生支持此类功能——我们认为现阶段尚为时过早。但我仍将其列入，是因为它代表了一个值得思考的重要维度，也是我们持续关注的方向。当前，`dspy` 是实现此类优化的最佳框架。

💡

All of these value props (aside from the agent abstractions) provide value for both agents, workflows, and everything in between.

以上所有价值主张（除智能体抽象层外）均同时适用于智能体（agents）、工作流（workflows），以及二者之间的各类应用场景。

**So - do you really need an agentic framework?**

**那么——你真的需要一个智能体框架吗？**

If your application does not require all of these features, and/or if you want to build them yourself, then you may not need one. Some of them (like short term memory) aren’t terribly complicated. Others of them (like human-on-the-loop, or LLM specific observability) are more complicated.

如果你的应用并不需要上述全部功能，和/或你倾向于自行实现这些能力，那么你可能并不需要一个智能体框架。其中某些能力（例如短期记忆）实现起来并不复杂；而另一些（例如人工介入闭环（human-on-the-loop）或面向大语言模型的可观测性（LLM-specific observability））则更具挑战性。

And regarding agent abstractions: I agree with what Anthropic says in their post:

关于智能体抽象层：我赞同 Anthropic 在其博文中所表达的观点：

> If you do use a framework, ensure you understand the underlying code. Incorrect assumptions about what's under the hood are a common source of customer error.

> 如果你确实使用某个框架，请务必理解其底层代码。对底层实现机制的错误假设，是用户出错的常见原因。

## As the models get better, will everything become agents instead of workflows?

## 随着模型不断进步，所有系统都会变成智能体（agents），而非工作流（workflows）吗？

One common argument in favor of agents (compared to workflows) is that while they don’t work now, they will work in the future, and therefore you will just need the simple, tool-calling agents.

支持智能体（相对于工作流）的一种常见论点是：尽管当前智能体尚不可靠，但未来它们必将成熟；因此，你最终只需依赖简单、直接调用工具的智能体即可。

I think multiple things can be true:

我认为以下几点可以同时成立：

- The performance of these tool-calling agents will rise  
  这类工具调用型智能体的性能将持续提升。

- It will still really important to be able to control what goes into the LLM (garbage in, garbage out)  
  能够精准控制输入大语言模型（LLM）的内容，依然至关重要（即“垃圾进，垃圾出”原则仍适用）。

- For some applications, this tool calling loop will be enough  
  对某些应用场景而言，这种工具调用循环已完全足够。

- For other applications, workflows will just be simpler, cheaper, faster, and better  
  而对另一些应用场景，工作流反而更简单、更经济、更快速，也更可靠。

- For most applications, the production agentic system will be a combination of workflows and agents  
  对绝大多数实际应用而言，投入生产的智能体系统将是工作流与智能体的混合架构。

I don’t think OpenAI or Anthropic would debate any of these points? From Anthropic’s post:

我不认为 OpenAI 或 Anthropic 会质疑上述任何一点。Anthropic 在其博文中指出：

> When building applications with LLMs, we recommend finding the simplest solution possible, and only increasing complexity when needed. This might mean not building agentic systems at all. Agentic systems often trade latency and cost for better task performance, and you should consider when this tradeoff makes sense.

> 在使用大语言模型构建应用时，我们建议优先寻找最简可行方案，并仅在必要时才增加复杂度——这甚至可能意味着完全不构建智能体系统。智能体系统往往以更高的延迟和成本为代价换取更优的任务表现，因此你需要审慎评估这一权衡是否合理。

And from OpenAI's post:

OpenAI 在其博文中亦指出：

> Before committing to building an agent, validate that your use case can meet these criteria clearly. Otherwise, a deterministic solution may suffice.

> 在决定构建智能体之前，请先明确验证你的具体用例是否切实满足这些条件；否则，一个确定性的（非智能体）解决方案或许已足够。

Will there be applications where this simple tool calling loop will be enough? I think this will likely only be true if you are using a model trained/finetuned/RL’d on lots of data that is specific to your use case. This can happen in two ways:

是否存在某些应用场景，仅靠这种简单的工具调用循环就已足够？我认为，这种情况很可能仅当所用模型已在大量与你的具体用例高度相关的数据上完成训练（training）、微调（finetuning）或强化学习（RL）时才会成立。这通常有两种实现路径：

- Your task is unique. You gather a lot of data and train/finetune/RL your own model.  
  你的任务具有独特性：你自行收集大量相关数据，并据此训练/微调/强化学习专属模型。

- Your task is not unique. The large model labs are training/finetuning/RL’ing on data representative of your task.  
  你的任务并不独特：大型模型实验室已在能代表你任务特征的数据集上开展训练/微调/强化学习。

(Side note: if I was building a vertical startup in an area where my task was not unique, I would be pretty worried about the long term viability of my startup).

（附注：如果我正在一个任务不具备独特性的领域创办垂直型初创公司，我会非常担忧这家初创公司长期的生存能力。）

**Your task is unique**

**你的任务具有独特性**

I would bet that most use cases (certainly most enterprise use cases) fall into this category. How AirBnb handles customer support is different from how Klarna handles customer support which is different from how Rakuten handles customer support. There is a ton of subtlety in these tasks. Sierra - a leading agent company in the customer support space - is not building a single customer support _agent_, but rather a customer support agent _platform_:

我敢打赌，大多数应用场景（尤其是绝大多数企业级应用场景）都属于这一类。Airbnb 处理客户支持的方式，与 Klarna 的方式不同，也与 Rakuten 的方式不同。这些任务中蕴含着大量细微差异。Sierra——客户支持领域领先的智能体公司——并未开发单一的客户支持 _智能体_，而是构建了一个客户支持智能体 _平台_：

> The Sierra Agent SDK enables developers to use a declarative programming language to build powerful, flexible agents using composable skills to express procedural knowledge

> Sierra 智能体 SDK 使开发者能够使用声明式编程语言，借助可组合的技能构建功能强大、灵活可变的智能体，以表达程序性知识。

They need to do this because each company’s customer support experience is unique enough where a generic agent is not performant enough.

他们必须这样做，是因为每家公司的客户支持体验都足够独特，通用型智能体无法达到所需的性能水平。

One example of an agent that is a simple tool calling loop using a model trained on a specific task: [OpenAI’s Deep Research](https://www.sequoiacap.com/podcast/training-data-deep-research/?ref=blog.langchain.com). So it can be done, and it can produce amazing agents.

一个典型示例是：一种基于特定任务训练所得模型、仅执行简单工具调用循环的智能体——[OpenAI 的 Deep Research](https://www.sequoiacap.com/podcast/training-data-deep-research/?ref=blog.langchain.com)。由此可见，这种做法是可行的，且能产出极为出色的智能体。

If you can train a SOTA model on your specific task - then yes, you probably don’t need a framework that enables arbitrary workflows, you’ll just use a simple tool calling loop. In this case, agents will be preferred over workflows.

如果你能在自己的特定任务上训练出业界领先（SOTA）的模型，那么你很可能无需依赖支持任意工作流的框架，只需采用简单的工具调用循环即可。此时，智能体（agents）将比工作流（workflows）更受青睐。

A very open question in my mind is: how many agent companies will have the data, tools, or knowledge to train a SOTA model for their task? At this exact moment, I think only the large model labs are able to do this. But will that change? Will a small vertical startup be able to train a SOTA model for their task? I am very interested in this question. If you are currently doing this - please reach out!

我心中一个悬而未决的关键问题是：究竟有多少智能体公司拥有足够的数据、工具或专业知识，来为其特定任务训练出业界领先（SOTA）的模型？就当下而言，我认为仅有大型大模型实验室具备这种能力。但这种情况会改变吗？一家小型垂直领域初创公司，能否为其任务训练出 SOTA 级别的模型？我对这个问题极感兴趣。如果你正在实践此事，请务必与我联系！

**Your task is not unique**

**你的任务不具备独特性**

I think some tasks are generic enough that the large model labs will be able to provide models that are good enough to do the simple tool-calling loop on these non-generic tasks.

我认为，某些任务足够通用，以至于大型大模型实验室将能够提供性能足够优异的模型，使其足以在这些非特化任务上直接运行简单的工具调用循环。

OpenAI released their Computer Use model via the API, which is a model finetuned on generic computer use data aiming to be good enough at that generic task. (Side note: I don’t think it is close to good enough yet).

OpenAI 通过 API 发布了其“计算机使用”（Computer Use）模型，该模型基于通用的计算机操作数据进行了微调，目标是足以胜任这一通用任务。（附注：我认为它目前距离“足够好”还有相当差距。）

Code is an interesting example of this. Coding is relatively generic, and coding has definitely been a break out use case for agents so far. Claude code and OpenAI’s Codex CLI are two examples of coding agents that use this simple tool calling loop. I would bet heavily that the base models are trained on lots of coding data and tasks (see evidence [here](https://docs.anthropic.com/en/docs/build-with-claude/tool-use/text-editor-tool?ref=blog.langchain.com) that Anthropic does this).

代码是这一现象的一个有趣例证。编程本身相对通用，而迄今为止，编程也确实已成为智能体（agents）最具突破性的应用场景之一。Claude Code 和 OpenAI 的 Codex CLI 就是两个采用这种简单工具调用循环（tool-calling loop）的编程智能体实例。我非常确信，这些基础模型在训练过程中已摄入了大量编程相关数据与任务（参见 Anthropic 在此[文档](https://docs.anthropic.com/en/docs/build-with-claude/tool-use/text-editor-tool?ref=blog.langchain.com)中提供的佐证）。

Interestingly - as the general models are trained on this data, how much does the exact shape of this data matter? Ben Hylak had an [interesting tweet](https://x.com/benhylak/status/1912922457012572364?ref=blog.langchain.com) the other day that seemed to resonate with folks:

有趣的是——当通用大模型基于此类数据进行训练时，**数据的具体形态（shape）究竟有多重要？** Ben Hylak 几天前发了一条[颇具启发性的推文](https://x.com/benhylak/status/1912922457012572364?ref=blog.langchain.com)，引发了广泛共鸣：

> models don't know how to use cursor anymore.  
> they're all being optimized for terminal. that's why 3.7 is and o3 are so awful in Cursor, and so amazing outside of it.

> 模型如今已不再懂得如何使用 Cursor（编辑器）了。  
> 它们全都被优化以适配终端（terminal）环境。正因如此，Claude 3.7 和 o3 在 Cursor 中表现极差，而在终端之外却惊艳非凡。

This could suggest two things:

这或许暗示着两点：

- Your task has to be very very close to the task the general models are trained on. The less similar your task is, the less likely it is that the general models will be good enough for your use case.

- 你的任务必须与通用大模型所训练的任务**高度接近**；二者越不相似，通用大模型就越难满足你的具体需求。

- Training the general models on other specific tasks may decrease performance on your task. I’m sure there is just as much (if not more) data similar to Cursor’s use case used to train the new models. But if there is this influx of new data of a slightly different shape, it outweighs any other type of data. This implies it is currently hard for the general models to be really amazing at a large number of tasks.

- 在通用大模型上额外训练其他特定任务，反而可能削弱其在你原有任务上的表现。我确信，用于训练新模型的数据中，与 Cursor 使用场景相似的数据量至少相当（甚至更多）。但若这批新增数据在形态上略有差异，其影响力便会压倒其他类型的数据。这意味着：当前通用大模型**很难在大量不同任务上同时达到卓越水平**。

💡

💡

Even for applications where agents are preferred to anything workflow-like, you will still benefit features of a framework that don’t have to do with low level workflow control: short term memory storage, long term memory storage, human-in-the-loop, human-on-the-loop, streaming, fault tolerance, debugging/observability.

即使在那些更倾向采用智能体（而非任何类工作流方案）的应用场景中，你依然能从框架所提供的、**不涉及底层工作流控制**的功能中获益：短期记忆存储、长期记忆存储、人在环内（human-in-the-loop）、人在环上（human-on-the-loop）、流式响应（streaming）、容错能力（fault tolerance），以及调试与可观测性（debugging/observability）。

## What did OpenAI get wrong in their take?

## OpenAI 在其观点中错在哪里？

If we revisit OpenAI's stance, we find it to be premised on false dichotomies that conflate different dimensions of "agentic frameworks" in order to inflate the value of their singular abstraction. Specifically, it conflates “declarative vs imperative” with “agent abstractions” as well as “workflows vs agents”.

如果我们重新审视 OpenAI 的立场，便会发现其建立在若干**虚假二分法**（false dichotomies）之上——它将“智能体框架”（agentic frameworks）的不同维度混为一谈，从而夸大其单一抽象范式的价值。具体而言，它错误地将“声明式 vs 命令式”（declarative vs imperative）等同于“智能体抽象”（agent abstractions），又将“工作流 vs 智能体”（workflows vs agents）视为非此即彼的对立关系。

💡

💡

Ultimately it misses the mark on what the main challenge is for building production agentic systems and the main value that should be provided by a framework, which is: a reliable orchestration layer that gives developers explicit control over what context reaches their LLMs while seamlessly handling production concerns like persistence, fault tolerance, and human-in-the-loop interactions.

从根本上说，它未能准确把握构建生产级智能体系统（agentic systems）所面临的核心挑战，也未能体现框架本应提供的核心价值：一个可靠的编排层（orchestration layer），使开发者能够显式控制哪些上下文信息传递给大语言模型（LLMs），同时无缝处理持久化、容错性、人机协同（human-in-the-loop）等生产环境关键问题。

Let's break down specific parts I take issue with:

下面我们逐条剖析我所质疑的具体内容：

![](images/how-to-think-about-agent-frameworks/img_006.jpg)

![](images/how-to-think-about-agent-frameworks/img_006.jpg)

**”Declarative vs non-declarative graphs”**

**“声明式图 vs 非声明式图”**

LangGraph is not fully declarative - but it’s declarative enough so that’s not my main gripe. My main gripe would be that “non-declarative” is doing a lot of work and misleading. Normally when people criticize declarative frameworks they would prefer a more imperative framework. But Agents SDK is NOT an imperative framework. It’s an abstraction. A more proper title would be “Declarative vs imperative” or “Do you need an orchestration framework” or “Why agent abstractions are all you need” or “Workflows vs Agents” depending on what they want to argue (they seem to argue both below).

LangGraph 并非完全声明式——但其声明性已足够强，因此这并非我主要的批评点。我真正质疑的是，“非声明式”这一说法承担了过多语义负担，且具有误导性。通常，当人们批评声明式框架时，其隐含倾向是偏好更偏向命令式（imperative）的框架；但 Agents SDK 并非命令式框架，而是一种抽象（abstraction）。更准确的标题应为：“声明式 vs 命令式”、“你是否需要一个编排框架？”、“为何智能体抽象已足以满足全部需求？” 或 “工作流（Workflows）vs 智能体（Agents）”，具体取决于作者想论证的观点（从后文看，他们似乎同时在主张两者）。

**”this approach can quickly become cumbersome and challenging as workflows grow more dynamic and complex”**

**“随着工作流变得愈发动态和复杂，这种方案会迅速变得繁琐且难以维护”**

This doesn’t have anything to do with declarative or non-declarative. This has everything to do with workflows vs agents. You can easily express the agent logic in Agents SDK as a declarative graph, and that graph is just as dynamic and flexible as Agents SDK.

这与“声明式”或“非声明式”毫无关系，其本质是“工作流”与“智能体”的范式差异。你完全可以将 Agents SDK 中的智能体逻辑以声明式图的形式表达出来，而该图所具备的动态性与灵活性，丝毫不逊于 Agents SDK 本身。

And on the point of workflows vs agents. A lot of workflows do not require this level of dynamism and complexity. Both OpenAI and Anthropic acknowledge this. You should use workflows when you can use workflows. Most agentic systems are a combination. Yes, if a workflow is really dynamic and complex then use an agent. But don’t use an agent for everything. OpenAI literally says this earlier in the paper.

再回到“工作流 vs 智能体”这一议题：大量工作流其实并不需要如此高的动态性与复杂度。OpenAI 和 Anthropic 均明确承认这一点。只要适用工作流，就应优先采用工作流。绝大多数智能体系统本质上是两者的混合体。诚然，若某工作流确实高度动态且极其复杂，则可选用智能体方案；但绝不可将智能体当作万能解法。OpenAI 在本文前文已明确指出此观点。

**”often necessitating the learning of specialized domain-specific languages”**

**“往往要求开发者学习专门的领域特定语言（DSL）”**

Again - Agents SDK is not an imperative framework. It is an abstraction. It also has a domain specific language (it’s abstractions). I would argue that having to learn and work around Agents SDK abstractions is, at this point in time, worse than having to learn LangGraph abstractions. Largely because the hard thing about building reliable agents is making sure the agent has the right context, and Agents SDKs obfuscates that WAY more than LangGraph.

再次强调——Agents SDK 并非一个命令式框架，而是一种抽象。它还自带一套领域特定语言（即其自身的抽象体系）。我认为，现阶段学习并绕过 Agents SDK 的抽象机制，其难度和负担实际上高于学习 LangGraph 的抽象机制。主要原因在于：构建可靠智能体（agent）的最大难点，在于确保智能体始终拥有恰当的上下文；而 Agents SDK 对这一关键环节的掩盖程度，远甚于 LangGraph。

**"more flexible"**

**“更灵活”**

This is just strictly not true. It’s the opposite of the truth. Everything you can do with Agents SDK you can do with LangGraph. Agents SDK only lets you do 10% of what you can do with LangGraph.

这完全不属实，事实恰恰相反。凡 Agents SDK 能实现的功能，LangGraph 均可实现；而 Agents SDK 仅能完成 LangGraph 所支持功能的大约 10%。

**“code-first”**

**“代码优先”**

With Agents SDK you write their abstractions. With LangGraph you write a **large** amount of normal code. I don’t see how Agents SDK is more code first.

使用 Agents SDK 时，你编写的是它的抽象层；而使用 LangGraph 时，你编写的则是**大量**标准、常规的代码。我实在看不出 Agents SDK 如何称得上更“代码优先”。

**”using familiar programming constructs”**

**“采用熟悉的编程结构”**

With Agents SDK you have to learn a whole new set of abstractions. With LangGraph you write a large amount of normal code. What is more familiar than that?

使用 Agents SDK 时，你必须学习一整套全新的抽象概念；而使用 LangGraph 时，你只需编写大量常规代码——还有什么比这更熟悉？

**”enabling more dynamic and adaptable agent orchestration”**

**“支持更动态、更自适应的智能体编排”**

Again - this doesn’t have to with declarative vs non-declarative. This has to do with workflows vs agents. See above point.

再次强调——这与“声明式 vs 非声明式”无关，而关乎“工作流（workflow）vs 智能体（agent）”的本质区别。参见上文论述。

## Comparing Agent Frameworks

## 智能体框架对比

We've talked about a lot of different components of agent frameworks:

我们已经讨论了智能体框架（agent frameworks）的许多不同组成部分：

- Are they flexible orchestration layer, or just an agent abstraction?

- 它们是灵活的编排层（orchestration layer），还是仅仅是一种智能体抽象（agent abstraction）？

- If they are a flexible orchestration layer, are they declarative or otherwise?

- 如果它们是灵活的编排层，那它们是声明式（declarative）的，还是其他类型？

- What features (aside from agent abstractions) does this framework provide?

- 该框架提供了哪些功能（除智能体抽象之外）？

I thought it would be fun to try to list out these dimensions in an spreadsheet. I tried to be as impartial as possible about this ( [I asked for - and got - a lot of good feedback from Twitter!](https://x.com/hwchase17/status/1913662736963412365?ref=blog.langchain.com)).

我觉得将这些维度整理成一张电子表格会很有趣。我尽力保持客观中立（[我在 Twitter 上征求了意见——并收获了许多宝贵的反馈！](https://x.com/hwchase17/status/1913662736963412365?ref=blog.langchain.com)）。

This currently contains comparisons to Agents SDK, Google's ADK, LangChain, Crew AI, LlamaIndex, Agno AI, Mastra, Pydantic AI, AutoGen, Temporal, SmolAgents, DSPy.

目前该表格涵盖了与以下框架的对比：Agents SDK、Google 的 ADK、LangChain、Crew AI、LlamaIndex、Agno AI、Mastra、Pydantic AI、AutoGen、Temporal、SmolAgents、DSPy。

If I left out a framework (or got something wrong about a framework) please leave a comment!

如果我遗漏了某个框架（或对某个框架的描述有误），欢迎在评论区指出！

💡

You can find a living version of the spreadsheet [here](https://docs.google.com/spreadsheets/d/1B37VxTBuGLeTSPVWtz7UMsCdtXrqV5hCjWkbHN8tfAo/edit?usp=sharing&ref=blog.langchain.com).

您可在此处查看该电子表格的实时更新版本：[点击访问](https://docs.google.com/spreadsheets/d/1B37VxTBuGLeTSPVWtz7UMsCdtXrqV5hCjWkbHN8tfAo/edit?usp=sharing&ref=blog.langchain.com)。

# Conclusion

# 结论

- **The hard part of building reliable agentic systems is making sure the LLM has the appropriate context at each step. This includes both controlling the exact content that goes into the LLM, as well as running the appropriate steps to generate relevant content.**

- **构建可靠智能体系统（agentic systems）的最大难点，在于确保大语言模型（LLM）在每一步都拥有恰当的上下文。这既包括精确控制输入 LLM 的内容，也包括执行恰当的步骤以生成相关的内容。**

- **Agentic systems consist of both workflows and agents (and everything in between).**

- **智能体系统既包含工作流（workflows），也包含智能体（agents），以及二者之间的所有中间形态。**

- **Most agentic frameworks are neither declarative or imperative orchestration frameworks, but rather just a set of agent abstractions.**

- **大多数智能体框架既非声明式编排框架，也非命令式编排框架，而仅是一组智能体抽象。**

- **Agent abstractions can make it easy to get started, but they can often obfuscate and make it hard to make sure the LLM has the appropriate context at each step.**

- **智能体抽象有助于快速上手，但也常常掩盖底层细节，使得确保 LLM 在每一步都获得恰当上下文变得困难。**

- **Agentic systems of all shapes and sizes (agents or workflows) all benefit from the same set of helpful features, which can be provided by a framework, or built from scratch.**

- **各种形态与规模的智能体系统（无论是智能体还是工作流）均能从同一套实用功能中获益——这些功能可由框架直接提供，也可自行从零构建。**

- **LangGraph is best thought of as a orchestration framework (with both declarative and imperative APIs), with a series of agent abstractions built on top.**

- **LangGraph 最宜被理解为一个编排框架（同时提供声明式与命令式 API），其上层则构建了一系列智能体抽象。**

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[哈里森的热点评论](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/how-to-think-about-agent-frameworks/img_007.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![论智能体框架与智能体可观测性](images/how-to-think-about-agent-frameworks/img_007.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**论智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[哈里森的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/how-to-think-about-agent-frameworks/img_008.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪数据到深度洞察：规模化理解智能体行为](images/how-to-think-about-agent-frameworks/img_008.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[哈里森的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/how-to-think-about-agent-frameworks/img_009.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用行为；在 AI 中，追踪数据（traces）承担这一角色。](images/how-to-think-about-agent-frameworks/img_009.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用行为；在 AI 中，追踪数据（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/how-to-think-about-agent-frameworks/img_010.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![Agent 框架、运行时与封装器——天哪！](images/how-to-think-about-agent-frameworks/img_010.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent 框架、运行时与封装器——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Reflections on Three Years of Building LangChain](images/how-to-think-about-agent-frameworks/img_011.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/how-to-think-about-agent-frameworks/img_011.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/how-to-think-about-agent-frameworks/img_012.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/how-to-think-about-agent-frameworks/img_012.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读