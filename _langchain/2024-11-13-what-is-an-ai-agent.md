---
title: "What is an AI agent?"
source: "LangChain Blog"
url: "https://blog.langchain.com/what-is-an-agent/"
date: "2024-11-13"
scraped_at: "2026-03-03T07:48:49.692451289+00:00"
language: "en-zh"
translated: true
description: "Introducing a new series of musings on AI agents, called \"In the Loop\"."
tags: ["Harrison Chase", "Harrison's Hot Takes"]
---
&#123;% raw %}

_“What is an agent?”_

_“什么是智能体（agent）？”_

I get asked this question almost daily. At LangChain, we build tools to help developers build LLM applications, especially those that act as a reasoning engines and interact with external sources of data and computation. This includes systems that are commonly referred to as “agents”.

我几乎每天都会被问到这个问题。在 LangChain，我们致力于构建工具，帮助开发者打造大语言模型（LLM）应用——尤其是那些充当推理引擎、并与外部数据源及计算资源交互的系统。这类系统通常就被称为“智能体（agents）”。

Everyone seems to have a slightly different definition of what an AI agent is. My definition is perhaps more technical than most:

每个人对“AI 智能体”究竟为何物似乎都有略微不同的理解。我的定义或许比大多数人的更偏技术性：

💡

An AI agent is a system that uses an LLM to decide the control flow of an application.

💡

智能体是一种利用大语言模型（LLM）来决定应用程序控制流的系统。

Even here, I’ll admit that my definition is not perfect. People often think of agents as advanced, autonomous, and human-like — but what about a simple system where an LLM routes between two different paths? This fits my technical definition, but not the common perception of what an agent should be capable of. It’s hard to define _exactly_ what an agent is!

即便如此，我也承认这一定义并不完美。人们常常将智能体想象为高度先进、完全自主、类人化的系统——但若一个系统仅由 LLM 在两条不同路径之间做简单路由，又该如何归类？它完全符合我提出的这一技术性定义，却与大众对智能体应有功能的普遍认知相去甚远。要**精确界定**“智能体”究竟为何物，实属不易！

That’s why I really liked Andrew Ng’s [tweet last week](https://x.com/AndrewYNg/status/1801295202788983136?ref=blog.langchain.com). In it he suggests that “rather than arguing over which work to include or exclude as being a true AI agent, we can acknowledge that there are different degrees to which systems can be agentic.” Just like autonomous vehicles, for example, have levels of autonomy, we can also view AI agent capabilities as a spectrum. I really agree with this viewpoint and I think Andrew expressed it nicely. In the future, when I get asked about what an agent is, I will instead turn the conversation to discuss what it means to be “agentic”.

正因如此，我非常欣赏吴恩达（Andrew Ng）教授上周发布的[这条推文](https://x.com/AndrewYNg/status/1801295202788983136?ref=blog.langchain.com)。他在文中提出：“与其争论哪些工作可被纳入或排除在‘真正的 AI 智能体’范畴之外，不如承认：不同系统所具备的‘智能体性（agenticness）’程度本就各不相同。” 就像自动驾驶汽车拥有不同等级的自主性（L0–L5）一样，我们同样可将 AI 智能体的能力视作一个连续光谱。我高度认同这一观点，也认为吴恩达教授的表述极为精当。今后，当再有人问我“什么是智能体”时，我将不再试图给出一个确定的定义，而是引导对话转向探讨——何谓“具备智能体性（agentic）”。

## What does it mean to be agentic?

## 何谓“具备智能体性（agentic）”？

I gave a TED talk last year about LLM systems and used the slide below to talk about the different levels of autonomy present in LLM applications.

去年，我曾就大语言模型（LLM）系统发表过一场 TED 演讲，并使用下方幻灯片来阐释 LLM 应用中所体现的不同层级的自主性。

![](images/what-is-an-ai-agent/img_001.png)

A system is more “agentic” the more an LLM decides how the system can behave.

一个系统越“具代理性（agentic）”，就越意味着大语言模型（LLM）在决定该系统行为方式时拥有更大的自主权。

Using an LLM to route inputs into a particular downstream workflow has some small amount of “agentic” behavior. This would fall into the `Router` category in the above diagram.

使用 LLM 将输入路由至某一特定下游工作流，已具备一定程度的“具代理性”行为。这在上图中属于 `Router`（路由器）类别。

If you do use multiple LLMs to do multiple routing steps? This would be somewhere between `Router` and `State Machine`.

若进一步采用多个 LLM 执行多级路由决策？其“具代理性”程度便介于 `Router` 与 `State Machine`（状态机）之间。

If one of those steps is then determining whether to continue or finish - effectively allowing the system to run in a loop until finished? That would fall into `State Machine`.

若其中某一步骤还需判断是继续执行还是终止流程——即实质上允许系统循环运行直至任务完成？则该系统便属于 `State Machine` 类别。

If the system is building tools, remembering those, and then taking those in future steps? That is similar to what the [Voyager paper](https://arxiv.org/abs/2305.16291?ref=blog.langchain.com) implemented, and is incredibly agentic, falling into the higher `Autonomous Agent` category.

若系统还能自主构建工具、记忆这些工具，并在后续步骤中调用它们？这种能力与 [Voyager 论文](https://arxiv.org/abs/2305.16291?ref=blog.langchain.com) 所实现的机制高度相似，展现出极强的“具代理性”，应归入更高阶的 `Autonomous Agent`（自主智能体）类别。

These definitions of “agentic” are still pretty technical. I prefer the more technical definition of “agentic” because I think it’s useful when designing and describing LLM systems.

上述对“具代理性”的界定仍偏技术化。我更倾向采用这一偏技术性的定义，因为我认为它在设计和描述 LLM 系统时极具实用价值。

## Why is “agentic” a helpful concept?

## 为何“具代理性”是一个有益的概念？

As with all concepts, it’s worth asking why we even need the concept of “agentic”. What does it help with?

如同所有概念一样，我们有必要追问：为何我们需要“具代理性”这一概念？它究竟有何助益？

Having an idea of how agentic your system can guide your decision-making during the development process - including building it, running it, interacting with it, evaluating it, and even monitoring it.

对系统“具代理性”程度的清晰认知，可有效指导开发全过程中的各项决策——包括系统构建、运行、人机交互、效果评估，甚至运行监控。

The more agentic your system is, the more an orchestration framework will help. If you are designing a complex agentic system, having a framework with the right abstractions for thinking about these concepts can enable faster development. This framework should have first-class support for branching logic and cycles.

系统“具代理性”越强，就越需要编排框架（orchestration framework）的支持。若你正在设计一个复杂的具代理性系统，那么一个能提供恰当抽象机制以帮助思考此类概念的框架，将显著加速开发进程。该框架应原生支持分支逻辑（branching logic）与循环机制（cycles）。

The more agentic your system is, the harder it is to run. It will be more and more complex, having some tasks that will take a long time to complete. This means you will want to run jobs as background runs. This also means you want durable execution to handle any errors that occur halfway through.

您的系统越具备“智能体性”（agentic），其运行难度就越大。系统将日趋复杂，其中部分任务可能需要耗费很长时间才能完成。这意味着您需要将任务作为后台作业（background runs）来执行；同时也意味着您需要具备**持久化执行能力**（durable execution），以妥善处理在执行中途发生的任何错误。

The more agentic your system is, the more you will want to interact with it while it’s running. You’ll want the ability to observe what is going on inside, since the exact steps taken may not be known ahead of time. You’ll want the ability to modify the state or instructions of the agent at a particular point in time, to nudge it back on track if it’s deviating from the intended path.

您的系统越具备“智能体性”，您就越希望在它运行过程中与其进行交互。您需要能够**实时观测内部运行状态**，因为智能体实际采取的步骤往往无法预先确定；您还需要能够在特定时刻**动态修改智能体的状态或指令**，以便在其偏离预设路径时及时将其“轻推回轨”。

The more agentic your system is, the more you will want an evaluation framework built for these types of applications. You’ll want to run evals multiple times, since there is compounding amount of randomness. You’ll want the ability to test not only the final output but also the intermediate steps to test how efficient the agent is behaving.

您的系统越具备“智能体性”，您就越需要一套专为这类应用设计的**评估框架**（evaluation framework）。由于随机性会逐层累积，您需要反复多次运行评估；您不仅需要检验最终输出结果，还需对**中间步骤**进行测试，从而全面评估智能体的行为效率。

The more agentic your system is, the more you will want a new type of monitoring framework. You’ll want the ability to drill down into all the steps an agent takes. You’ll also want the ability to query for runs based on steps an agent takes.

您的系统越具备“智能体性”，您就越需要一种**新型监控框架**。您需要能够深入下钻（drill down）查看智能体执行的每一步操作；同时，您还需支持基于智能体所执行的具体步骤来查询相关运行记录（runs）。

Understanding and leveraging the spectrum of agentic capabilities in your system can improve the efficiency and robustness of your development process.

深入理解并有效利用您系统中“智能体性”能力所构成的连续谱系（spectrum），有助于提升开发流程的效率与鲁棒性。

## Agentic is new

## “智能体性”是一种新范式

One thing that I often think about is what is _actually new_ in all this craze. Do we need new tooling and new infrastructure for the LLM applications people are building? Or will generic tools and infrastructure from pre-LLM days suffice?

我经常思考的一个问题是：在这股热潮之中，究竟有哪些东西是**真正全新的**？人们正在构建的大语言模型（LLM）应用，是否亟需全新的工具链与基础设施？还是说，前大模型时代通用的工具与基础设施已足以胜任？

To me, the more agentic your application is, the more critical it is to have new tooling and infrastructure. That’s exactly what motivated us to build [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com), the agent orchestrator to help with building, running, and interacting with agents, and [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com), the testing and observability platform for LLM apps. As we move further on the agentic spectrum, the entire ecosystem of supportive tooling needs to be reimagined.

对我而言，您的应用越具备“智能体性”，采用全新工具链与基础设施就越是关键。这正是我们打造 [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com)（面向智能体的编排器，助力智能体的构建、运行与交互）和 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)（面向大语言模型应用的测试与可观测性平台）的初衷。随着我们在“智能体性”谱系上不断向更高级形态演进，整个支撑性工具生态都亟需被重新构想与设计。

### Tags

### 标签

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) [Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/what-is-an-ai-agent/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/what-is-an-ai-agent/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/what-is-an-ai-agent/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码记录应用逻辑；在人工智能中，追踪数据（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/what-is-an-ai-agent/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![Agent Frameworks、Runtimes 和 Harnesses——天哪！](images/what-is-an-ai-agent/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks、Runtimes 和 Harnesses——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/what-is-an-ai-agent/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/what-is-an-ai-agent/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/what-is-an-ai-agent/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/what-is-an-ai-agent/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟
&#123;% endraw %}
