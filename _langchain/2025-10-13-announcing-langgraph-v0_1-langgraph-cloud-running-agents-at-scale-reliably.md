---
title: "Announcing LangGraph v0.1 & LangGraph Cloud: Running agents at scale, reliably"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-cloud/"
date: "2025-10-13"
scraped_at: "2026-03-03T07:24:15.324540369+00:00"
language: "en-zh"
translated: true
description: "Our new infrastructure for running agents at scale, LangGraph Cloud, is available in beta. We also have a new stable release of LangGraph."
tags: ["By LangChain"]
---
{% raw %}

_Note: As of October 2025, LangGraph Platform has been re-named to "LangSmith Deployment"._

_注：截至 2025 年 10 月，LangGraph Platform 已正式更名为“LangSmith Deployment”。_

At LangChain, we aim to make it easy to build LLM applications – systems that connect LLMs to external sources of data and computation to _reason_ about the world. Letting an LLM decide the control flow of an application (i.e. what we call agents) is attractive, as they can unlock a variety of tasks that couldn’t previously be automated. In practice, however, it is incredibly difficult to build systems that reliably execute on these tasks.

在 LangChain，我们的目标是让构建大语言模型（LLM）应用变得简单——这类系统将 LLM 与外部数据源和计算资源连接起来，从而对现实世界进行 _推理（reason）_。让 LLM 主导应用程序的控制流（即我们所称的“智能体”或 agents）极具吸引力，因为它能解锁大量此前无法自动化的任务。然而在实践中，构建能够稳定、可靠执行此类任务的系统却异常困难。

To tackle this, a few months ago, we introduced [LangGraph](http://langchain.com/langgraph?ref=blog.langchain.com) — a framework for building agentic and multi-agent applications. Separate from the langchain package, LangGraph’s core design philosophy is to help developers add better precision and control into agentic workflows, suitable for the complexity of real-world systems.

为应对这一挑战，几个月前我们推出了 [LangGraph](http://langchain.com/langgraph?ref=blog.langchain.com)——一个专为构建智能体（agentic）及多智能体（multi-agent）应用而设计的框架。LangGraph 独立于 `langchain` 包之外，其核心设计理念是帮助开发者在智能体工作流中注入更高精度与更强控制力，以适配真实世界系统的复杂性。

Today, we’re introducing a **stable release of LangGraph v0.1**, reaffirming our commitment to helping users create more of these robust agentic systems, and we’re grateful for leading companies such as Klarna, Replit, Ally, Elastic, NCL, and many more who are already relying on LangGraph to take their companies’ AI initiatives to the next level.

今天，我们正式发布 **LangGraph v0.1 稳定版**，再次彰显我们助力用户构建更强大、更稳健的智能体系统的坚定承诺。我们衷心感谢 Klarna、Replit、Ally、Elastic、NCL（挪威邮轮公司）等领先企业，以及众多其他合作伙伴——他们已率先采用 LangGraph，推动各自企业的 AI 战略迈向新高度。

We’re also thrilled to announce **LangGraph Cloud**. LangGraph Cloud, currently in closed beta, is infrastructure for deploying your LangGraph agents in a scalable, fault tolerant way. It also provides an integrated developer experience for you to gain more visibility and confidence as you prototype, debug, and monitor your agentic workflows.

我们还非常激动地宣布推出 **LangGraph Cloud**。目前 LangGraph Cloud 正处于封闭测试（closed beta）阶段，它是一套用于规模化、高容错地部署 LangGraph 智能体的基础设施。同时，它还提供一体化的开发者体验，助您在原型设计、调试与监控智能体工作流的过程中获得更强的可观测性与信心。

Read on to learn more and see how to try it out. If you're more of a visual learner, you can check out our video walkthrough [here](https://www.youtube.com/watch?v=l4sMKF1dTDM&ref=blog.langchain.com).

请继续阅读，深入了解并了解如何试用。若您更倾向于通过视频学习，欢迎观看我们的操作演示视频：[点击此处](https://www.youtube.com/watch?v=l4sMKF1dTDM&ref=blog.langchain.com)。

## **LangGraph v0.1: Balancing agent control with agency**

## **LangGraph v0.1：在智能体控制力与自主性之间取得平衡**

Most agentic frameworks can handle simple, predefined tasks but struggle with complex workflows that require any company or domain-specific context. This was true of the legacy LangChain AgentExecutor as well, but what we learned through iteration and experience is that the higher level abstraction hides too many details from the developer, ultimately resulting in a system lacking the control needed to accomplish tasks reliably.

大多数智能体框架可处理简单、预定义的任务，但在需融入企业专属或领域特定上下文的复杂工作流面前则力不从心。旧版 LangChain 的 `AgentExecutor` 同样如此。而通过持续迭代与实践，我们认识到：过高的抽象层级会向开发者隐藏过多细节，最终导致系统缺乏完成任务所必需的精细控制能力。

[LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com), by contrast, has a flexible API that lets you design custom cognitive architectures. This means you get low-level control over the flow of code, prompts, and LLM calls that take in user input to perform an action or generate a response. With conditional branching and looping, LangGraph lets users build single-agent or multi-agent setups with hierarchical or sequential decision patterns. At companies like Norwegian Cruise Line, having this level of agent control has been critical.

相比之下，[LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 提供灵活的 API，支持您设计定制化的认知架构。这意味着您可对代码执行流、提示词（prompts）及调用 LLM 的逻辑进行底层控制——这些组件共同接收用户输入，进而执行操作或生成响应。借助条件分支（conditional branching）与循环（looping），LangGraph 支持构建单智能体或多智能体系统，并实现分层式（hierarchical）或顺序式（sequential）决策模式。在挪威邮轮公司（Norwegian Cruise Line）等企业，这种程度的智能体控制能力已被证明至关重要。

> _"LangGraph has been instrumental for our AI development. Its robust framework for building stateful, multi-actor applications with LLMs has transformed how we evaluate and optimize the performance of our AI guest-facing solutions. LangGraph enables granular control over the agent's thought process, which has empowered us to make data-driven and deliberate decisions to meet the diverse needs of our guests." **\- Andres Torres (Sr. Solutions Architect @** **Norwegian Cruise Line)**_

> “LangGraph 对我们的 AI 开发起到了关键作用。它为基于大语言模型构建有状态、多角色（multi-actor）应用提供了坚实可靠的框架，彻底改变了我们评估与优化面向宾客的 AI 解决方案性能的方式。LangGraph 赋予我们对智能体‘思维过程’的精细化控制能力，使我们得以基于数据、审慎决策，从而精准满足宾客多样化的需求。”  
> **——Andres Torres（高级解决方案架构师，挪威邮轮公司 Norwegian Cruise Line）**

LangGraph also makes it easy to add moderation and quality checks that ensure agents meet certain conditions before continuing their tasks. This keeps the agent progressing properly and reduces the chance it gets stuck on an incorrect path, from which it’d be unlikely to recover.

LangGraph 还使得添加内容审核与质量检查变得十分简便，从而确保智能体在继续执行任务前满足特定条件。这有助于保障智能体始终沿正确路径推进，显著降低其陷入错误流程而难以自行恢复的风险。

![](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_001.png)

For companies like Replit, LangGraph’s fine-grained control has strengthened their ability to ship reliable agents.

对于 Replit 等公司而言，LangGraph 提供的细粒度控制能力，显著增强了其交付高可靠性智能体的实力。

> _"It's easy to build the prototype of a coding agent, but deceptively hard to improve its reliability. Replit wants to give a coding agent to millions of users — reliability is our top priority, and will remain so for a long time. LangGraph is giving us the control and ergonomics we need to build and ship powerful coding agents." - **Michele Catasta (VP of AI @ Replit)**_

> “构建一个编程智能体的原型很容易，但提升其可靠性却出人意料地困难。Replit 希望将编程智能体提供给数百万用户——可靠性是我们的首要任务，并将在很长一段时间内持续如此。LangGraph 正为我们提供构建并交付强大编程智能体所必需的控制能力与工程体验。”——**Michele Catasta（Replit 首席人工智能副总裁）**

For the most complex or sensitive tasks, human collaboration is still needed to supplement agentic automation. LangGraph makes human-agent collaboration possible through its built in persistence layer. Specifically, with LangGraph, you can:

在最复杂或最敏感的任务中，人类协作仍不可或缺，用以补充智能体自动化能力。LangGraph 通过其内置的持久化层，使“人机协同”成为可能。具体而言，借助 LangGraph，您可以：

- Design the agent to explicitly wait for human approval before executing a task and resuming its workflow.  
  设计智能体，在执行某项任务及恢复工作流前，明确等待人工审批。

- Edit the agent’s actions before they are executed.  
  在智能体动作实际执行前对其进行编辑。

- Inspect, rewire, edit, and resume execution of the agent (in what we describe as “time travel” features).  
  检查、重构、编辑并恢复智能体的执行过程（即我们所称的“时间旅行”功能）。

For teams such as Elastic, this flexibility in design has been game-changing. They note:

对 Elastic 等团队而言，这种设计灵活性堪称变革性突破。他们指出：

> _"LangChain is streets ahead with what they've put forward with LangGraph. LangGraph sets the foundation for how we can build and scale AI workloads — from conversational agents, complex task automation, to custom LLM-backed experiences that 'just work'. The next chapter in building complex production-ready features with LLMs is agentic, and with LangGraph and LangSmith, LangChain delivers an out-of-the-box solution to iterate quickly, debug immediately, and scale effortlessly." **– Garrett Spong (Principal SWE @ Elastic)**_

> “LangChain 凭借 LangGraph 的推出已遥遥领先。LangGraph 为构建与扩展各类 AI 工作负载奠定了坚实基础——无论是对话式智能体、复杂任务自动化，还是‘开箱即用’的定制化大语言模型（LLM）驱动体验。利用大语言模型构建复杂、可投入生产的功能，其下一阶段必然是‘智能体化’；而 LangGraph 与 LangSmith 的组合，则让 LangChain 能够提供一套开箱即用的完整解决方案，助您快速迭代、即时调试、无缝扩展。”——**Garrett Spong（Elastic 首席软件工程师）**

Lastly, LangGraph natively supports streaming of intermediate steps and token-by-token streaming, enabling more dynamic and responsive experiences for users working with long-running, agentic tasks.

最后，LangGraph 原生支持中间步骤流式输出（intermediate step streaming）与逐 Token 流式输出（token-by-token streaming），从而为处理长时间运行、具备智能体特性的任务的用户，带来更动态、更灵敏的交互体验。

## **LangGraph Cloud: Scalable agent deployment with integrated monitoring**

## **LangGraph Cloud：集成监控能力的可扩展智能体部署平台**

To complement the LangGraph framework, we also have a new runtime, [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com), now available in beta, which provides infrastructure purpose-built for deploying agents at scale.

为补充 LangGraph 框架，我们还推出了全新的运行时环境——[LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com)，目前处于 Beta 测试阶段。该平台专为大规模部署智能体（agents）而构建，提供定制化基础设施支持。

As your agentic use case gains traction, uneven task distribution among agents can overload the system, risking slowdowns and downtime. LangGraph Cloud does the heavy lifting to help you achieve fault-tolerant scalability. It gracefully manages horizontally-scaling task queues, servers, and a robust Postgres checkpointer to handle many concurrent users and efficiently store large states and threads.

随着您的智能体应用场景日益普及，各智能体之间任务分配不均可能导致系统过载，进而引发响应迟缓甚至服务中断。LangGraph Cloud 承担了繁重的底层工作，助您实现具备容错能力的弹性伸缩：它可优雅地管理横向扩展的任务队列与服务器集群，并依托健壮的 PostgreSQL 检查点（checkpointer）机制，高效支撑海量并发用户，同时可靠存储庞大的状态（state）与会话线程（thread）。

LangGraph Cloud is designed to support real-world interaction patterns. In addition to streaming and human-in-the-loop (which are covered in LangGraph), LangGraph Cloud also adds:

LangGraph Cloud 专为支持真实世界中的交互模式而设计。除 LangGraph 原生支持的流式响应（streaming）和人工介入（human-in-the-loop）外，LangGraph Cloud 还新增以下关键能力：

- **Double-texting** to handle new user inputs on currently-running threads of the graph. It supports four different strategies for handling additional context: reject, queue, interrupt, and rollback.  
- **双重消息处理（Double-texting）**：用于响应正在运行的图谱线程（graph thread）中用户新输入的消息。支持四种上下文处理策略：拒绝（reject）、入队（queue）、中断（interrupt）和回滚（rollback）。

- **Asynchronous background jobs** for long-running tasks **.** You can check for completion via polling or a webhook.  
- **异步后台任务（Asynchronous background jobs）**：专为耗时较长的任务而设。您可通过轮询（polling）或 Webhook 查询任务完成状态。

- **Cron jobs** for running common tasks on a schedule  
- **定时任务（Cron jobs）**：按预设时间表自动执行常规任务。

LangGraph Cloud also brings a more integrated experience for collaborating on, deploying, and monitoring your agentic app. It comes with [LangGraph Studio](https://langchain-ai.github.io/langgraph/cloud/how-tos/test_deployment/?ref=blog.langchain.com) – a playground-like space for visualizing agent trajectories to help debug failure modes and add breakpoints for interruption, state editing, resumption, and time travel. LangGraph Studio lets you share your LangGraph agent with internal stakeholders for feedback and rapid iteration.

LangGraph Cloud 同时带来更一体化的协作、部署与监控体验。其内置 [LangGraph Studio](https://langchain-ai.github.io/langgraph/cloud/how-tos/test_deployment/?ref=blog.langchain.com) —— 一个类似交互式沙盒（playground）的可视化开发环境，支持直观呈现智能体执行轨迹（agent trajectories），便于定位故障模式；并支持设置断点，实现流程中断、状态编辑、会话恢复及“时间旅行”式调试（time travel）。您还可将 LangGraph 智能体直接共享给内部相关方，快速收集反馈、加速迭代。

![](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_002.jpg)

![](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_002.jpg)

Additionally, LangGraph Cloud simplifies deployment. Select a LangGraph repo from GitHub, and with just one-click, deploy your agentic application — no infra expertise required. And since LangGraph Cloud is integrated within LangSmith, you can gain deeper visibility into your app and track and monitor usage, errors, performance, and costs in production too.

此外，LangGraph Cloud 极大简化了部署流程：只需从 GitHub 选择一个 LangGraph 代码仓库，单击一次即可完成智能体应用的部署——无需任何基础设施（infra）专业知识。由于 LangGraph Cloud 已深度集成于 LangSmith 平台，您还可获得对应用更全面的可观测性，实时追踪并监控生产环境中的使用量、错误率、性能指标及成本开销。

![](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_003.jpg)

![](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_003.jpg)

We're excited to roll out LangGraph Cloud, with support from partners like Ally Financial who have already been making strides with LangGraph.

我们非常激动地正式推出 LangGraph Cloud，并已获得 Ally Financial 等合作伙伴的鼎力支持——他们正积极借助 LangGraph 推进各项创新实践。

> _“As Ally advances its exploration of Generative AI, our tech labs is excited by LangGraph, the new library from LangChain, which is central to our experiments with multi-actor agentic workflows. We are committed to deepening our partnership with LangChain._” \- **Sathish Muthukrishnan (Chief Information, Data and Digital Officer @ Ally Financial _)_**  

> “随着 Ally 持续深化生成式人工智能（Generative AI）探索，我们的技术实验室对 LangChain 推出的新库 LangGraph 深感振奋。LangGraph 已成为我们开展多角色智能体协同工作流（multi-actor agentic workflows）实验的核心技术基础。我们致力于进一步深化与 LangChain 的战略合作。”  
> —— **Sathish Muthukrishnan（Ally Financial 首席信息、数据与数字官）**

## **Try it for yourself**

## **亲自试用**

To get started with LangGraph, simply go to the [GitHub project](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) and follow the install instructions.

要开始使用 LangGraph，只需访问 [GitHub 项目页面](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)，并按照安装说明操作即可。

To get access to LangGraph Cloud, sign up for the [LangGraph Cloud waitlist](http://langchain.com/langgraph-cloud-beta?ref=blog.langchain.com). You’ll need to first have a LangSmith account (which you can [try out](https://smith.langchain.com/?ref=blog.langchain.com) for free) to use LangGraph Cloud features.

如需访问 LangGraph Cloud，请加入 [LangGraph Cloud 等待名单](http://langchain.com/langgraph-cloud-beta?ref=blog.langchain.com)。使用 LangGraph Cloud 功能前，您需先拥有一个 LangSmith 账户（可免费[体验](https://smith.langchain.com/?ref=blog.langchain.com)）。

* * *

* * *

We believe we have a unique approach to building agents – one that lets you put your company specific workflow at the center and gives you the control needed to ship to production. Our hope is that with the launch of these tools, we’re a step closer to bridging the gap between user expectations and agent capabilities.

我们相信，我们在构建智能体（agents）方面拥有独特的方法——该方法以贵公司专属的工作流为核心，并赋予您将智能体成功部署至生产环境所需的全部控制能力。我们希望，随着这些工具的发布，我们正朝着弥合用户期望与智能体实际能力之间的差距迈出关键一步。

If you have feedback, we’d love to hear from you at hello@langchain.dev!

如果您有任何反馈，欢迎发送邮件至 hello@langchain.dev！我们非常期待您的声音！

**_Learn more from these additional resources:_**

**_更多学习资源：_**

- [LangGraph docs](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com)  
- [LangGraph Cloud docs](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com)  
- [LangGraph webpage](http://langchain.com/langgraph?ref=blog.langchain.com) (with FAQs)  
- [LangGraph 文档](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com)  
- [LangGraph Cloud 文档](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com)  
- [LangGraph 官网页面](http://langchain.com/langgraph?ref=blog.langchain.com)（含常见问题解答）

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  
[作者：LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![推出 LangSmith 的 OpenTelemetry 支持](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的全新部署选项](images/announcing-langgraph-v0_1-langgraph-cloud-running-agents-at-scale-reliably/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
