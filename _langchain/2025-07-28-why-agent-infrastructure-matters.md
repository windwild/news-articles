---
render_with_liquid: false
title: "Why agent infrastructure matters"
source: "LangChain Blog"
url: "https://blog.langchain.com/why-agent-infrastructure/"
date: "2025-07-28"
scraped_at: "2026-03-03T07:28:42.994600809+00:00"
language: "en-zh"
translated: true
description: "Learn why agent infrastructure is essential to handling stateful, long-running tasks — and how LangGraph Platform provides the runtime support needed to build and scale reliable agents."
---
render_with_liquid: false
render_with_liquid: false

Over the past year, we’ve seen the rise of agentic applications, from workflow copilots to codegen assistants to deep researchers. These agentic apps often combine tool use, memory, and reasoning to complete complex, multi-step tasks — moving beyond retrieval and chat to action-taking.

过去一年，我们见证了“智能体应用”（agentic applications）的兴起，从工作流协作者（workflow copilots）、代码生成助手（codegen assistants），到深度研究者（deep researchers）等各类应用纷纷涌现。这类智能体应用通常融合工具调用、记忆能力与推理能力，以完成复杂、多步骤的任务——其能力已远超传统的信息检索与对话交互，迈向了主动执行与行动落地。

Agents are altering how we think of applications. Apps are no longer just a series of requests and responses — reduced to input forms, buttons, visuals, or chat interfaces. Instead, agents remember, reason, and act. They work in the background off of events and information. They not only _act_ but also ask for help, show their work, reason through problems, and collaborate in groups. And while stateless, serverless compute remains a north star for distributed systems, it falls short for agent-based applications. This new style of application requires new infrastructure.

智能体正在重塑我们对“应用”的认知。应用不再仅是一系列请求与响应的简单组合——被简化为输入表单、按钮、可视化界面或聊天窗口。相反，智能体具备记忆、推理与执行能力；它们基于事件与信息，在后台持续运行；它们不仅会主动 _执行_，还会主动寻求帮助、展示推理过程、逐步拆解问题，并能以协作方式组成群体共同工作。尽管无状态、无服务器（stateless, serverless）计算仍是分布式系统设计的“北极星”，但它却难以满足智能体应用的需求。这种新型应用范式亟需全新的基础设施支撑。

Agents often are:

智能体通常具有以下特征：

- **Long-running** — reasoning and executing on a task for minutes, not milliseconds.  
- **长时运行**——对任务进行推理与执行往往耗时数分钟，而非毫秒级。

- **Stateful** — carrying memory and persisting context across steps or from past interactions  
- **有状态**——承载记忆能力，并在多步执行之间或跨历史交互中持续保存上下文。

- **Bursty** — especially in scheduled or user-triggered scenarios.  
- **突发性负载**——尤其在定时调度或用户触发场景下表现明显。

Trying to shoehorn an agent with these characteristics into existing serverless or microservice architectures often leads to brittle, fault-prone systems.

若强行将具备上述特性的智能体塞入现有的无服务器架构或微服务架构中，往往会导致系统脆弱、容错性差。

## Why agent infrastructure is needed

## 为何需要智能体基础设施？

Agentic workloads demand new primitives — ones that neither web backends nor traditional distributed systems provide. A new layer to the agent stack is emerging: **agent infrastructure**. It sits between your agent logic and raw compute, providing structure, control, and reliability.

智能体类工作负载要求全新的基础能力（primitives）——而这些能力既非传统 Web 后端所能提供，也非经典分布式系统所涵盖。一个面向智能体的新技术栈层级正逐渐浮现：**智能体基础设施（agent infrastructure）**。它位于你的智能体逻辑与底层原始算力之间，为智能体运行提供结构化支持、可控性与高可靠性。

**Agent infrastructure is** infrastructure purpose-built to support durable execution, complex state management, human-in-the-loop coordination, streaming and more — without requiring you to stitch everything together yourself. That's why we built [**LangGraph Platform**](https://www.langchain.com/langgraph-platform?ref=blog.langchain.com) to be the best place to deploy and run your LangGraph applications with scalable, reliable agent infrastructure.

**智能体基础设施**，是专为支持持久化执行、复杂状态管理、人机协同（human-in-the-loop）协调、流式处理等关键能力而定制打造的基础设施——你无需再手动拼接所有组件。正因如此，我们构建了 [**LangGraph 平台（LangGraph Platform）**](https://www.langchain.com/langgraph-platform?ref=blog.langchain.com)，旨在成为部署与运行 LangGraph 应用的最佳平台，提供可扩展、高可靠的智能体基础设施支持。

### Durable execution: Agent runs take time

### 持久化执行：智能体运行耗时较长

Most serverless environments are optimized for short-lived tasks. But agents — from research assistants to workflow copilots — can run for at least several seconds, and often minutes, or even hours in extremes. They might pause to call tools, wait on APIs, or receive human-in-the-loop feedback.

大多数无服务器环境均针对短生命周期任务进行了优化。但智能体——无论是科研助手还是工作流协作者——其运行时间至少达数秒，通常持续数分钟，在极端情况下甚至可达数小时。它们可能暂停以调用外部工具、等待 API 响应，或接收人工介入反馈。

In [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com), these agents are suspended and safely resumed later, but many systems can’t handle these long or unpredictable pauses. Without the right runtime, long-running agents risk timing out, crashing, or losing progress.

在 [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 中，这些智能体（agents）会被挂起，并在后续安全恢复执行；但许多系统无法应对如此漫长或不可预测的暂停。若缺乏合适的运行时环境，长时间运行的智能体将面临超时、崩溃或进度丢失的风险。

Agent infrastructure provides:

智能体基础设施提供以下能力：

- **Background execution** so agents can run independently of the initial request  
- **后台执行**，使智能体能够脱离初始请求独立运行  

- **Heartbeat signals** to prevent timeouts by signaling ongoing progress  
- **心跳信号**，通过持续报告执行进展来防止超时  

- **Resumable runs** to restore from checkpoints after crashes or pauses  
- **可恢复的运行**，支持在崩溃或暂停后从检查点恢复执行  

This durability is essential for building reliable, production-grade agents that work through to successful completion of the task no matter how long it takes.

这种持久性对于构建高可靠性、可用于生产环境的智能体至关重要——无论任务耗时多长，都能确保其最终成功完成。

### State management: Agents need more than message buffers

### 状态管理：智能体需要的不只是消息缓冲区

An agent’s “state” can include intermediate results, tool outputs, embedded documents, or multi-turn context. Traditional infra doesn't give you a structured way to store, resume, or edit this state mid-run. An agent infrastructure can provide the storage and checkpointing needed OOTB to persist state across steps, failures, or user interventions.

智能体的“状态”可能包含中间结果、工具输出、嵌入式文档或多轮对话上下文。传统基础设施并未提供结构化的方式来存储、恢复或在运行中途编辑该状态。而智能体基础设施则能开箱即用地提供所需的存储与检查点（checkpointing）能力，从而在步骤间、故障后或用户介入时持续保存状态。

### Human-in-the-loop: Agents need to wait, pause, and resume

### 人机协同（Human-in-the-loop）：智能体需要等待、暂停与恢复

Agents frequently rely on human feedback for approval or clarification before continuing. That means you can’t just fire off a request and forget it. You need resumable state and support for arbitrarily long delays between steps.

智能体常需依赖人工反馈（如审批或澄清）才能继续执行。这意味着你不能简单发起请求后就置之不理；你必须具备可恢复的状态，并支持步骤之间任意长度的延迟。

Agent infrastructure lets you use APIs to pause or resume without wiring together queues, caches, and polling endpoints manually.

智能体基础设施允许你通过 API 直接暂停或恢复执行，无需手动集成队列、缓存及轮询端点等组件。

### Bursty concurrency: Agents must absorb spikes in traffic

### 突发性并发：智能体必须吸收流量激增

Real-world agentic apps can face unpredictable surges — whether it’s millions of users querying an AI search app at once, or a scheduled deep research assistant running its end-of-the-day job for entire teams. These spikes can lead to request traffic jams, dropped requests, or degraded performance.

现实世界中的智能体应用可能遭遇不可预测的流量激增——无论是数百万用户同时查询一个 AI 搜索应用，还是一个定时运行的深度研究助手在每日结束时为整个团队执行任务。此类峰值可能导致请求拥堵、请求丢失或性能下降。

An agent infrastructure like LangGraph Platform is designed to absorb these bursts with:

像 LangGraph Platform 这样的智能体基础设施专为吸收此类突发流量而设计，具备以下能力：

- **Task queues**, which buffer and schedule incoming runs effectively (even under heavy load)  
- **任务队列（Task queues）**：可高效缓冲并调度传入的运行任务（即使在高负载下亦然）

- **Horizontal auto-scaling**, where new workers and queue instances can be added dynamically to ensure each run is processed just once  
- **横向自动扩缩容（Horizontal auto-scaling）**：可动态新增工作节点（workers）与队列实例，确保每个运行任务仅被处理一次

This thus eliminates the need for custom load balancing logic and helps your agent remain stable even under high-throughput or unpredictable workloads.

因此，这消除了对自定义负载均衡逻辑的需求，并帮助您的智能体在高吞吐量或不可预测的工作负载下依然保持稳定。

### Streaming: See what your agents are thinking

### 流式输出：实时观察智能体的思考过程

Agents don’t just return a final result — they think, act, and refine their response over time.

智能体不仅返回最终结果——它们还会边思考、边行动，并随时间逐步优化响应。

Good agent infrastructure makes their intermediate output (e.g. thoughts, tool calls, partial completions) visible to enhance user experience and developer visibility. For example, LangGraph Platform enables:

优秀的智能体基础设施会将中间输出（例如：思考过程、工具调用、部分完成内容）显式暴露出来，从而提升用户体验与开发者可观测性。例如，LangGraph Platform 支持：

- **Token-level streaming,** which lets you stream LLM output token-by-token from any node, subgraph, tool, or task in [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com).  
- **Token 级流式输出（Token-level streaming）**：支持从 [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 中任意节点、子图、工具或任务逐 Token 流式传输大语言模型（LLM）输出。

- **Custom data streaming,** which emits structured, user-defined data at any point in the graph using custom stream mode, enabling flexible communication beyond standard text responses  
- **自定义数据流式输出（Custom data streaming）**：通过自定义流模式，在图中任意位置输出结构化、用户定义的数据，实现超越标准文本响应的灵活通信能力。

- [**Streaming generative UI**](https://langchain-ai.github.io/langgraph/cloud/how-tos/generative_ui_react/?ref=blog.langchain.com), which renders dynamic components for rich user interfaces.  
- [**流式生成式用户界面（Streaming generative UI）**](https://langchain-ai.github.io/langgraph/cloud/how-tos/generative_ui_react/?ref=blog.langchain.com)：渲染动态组件，构建功能丰富的用户界面。

Since all streaming modes contain metadata context, you can trace every output back to its origin — making it easier to debug and monitor your agent behavior too.

由于所有流式输出模式均包含元数据上下文，您可将每一条输出追溯至其源头——这也让智能体行为的调试与监控变得更加便捷。

## How LangGraph Platform helps

## LangGraph Platform 如何助力

LangGraph Platform gives you the infrastructure needed to run agentic workloads in production without building it yourself. You can deploy agents directly from GitHub with 1-click, and the runtime handles long-running execution, checkpointing, retries, memory, streaming, and traffic spikes out-of-the-box.

LangGraph 平台为您提供在生产环境中运行智能体（agentic）工作负载所需的基础设施，无需从零构建。您只需一键即可直接从 GitHub 部署智能体，运行时环境开箱即用地支持长时间执行、检查点（checkpointing）、重试机制、状态记忆、流式响应以及应对流量激增。

If you’re building agents that are stateful, action taking, or need to pause and resume — LangGraph Platform takes care of the hard parts so you can focus on agent logic and behavior, not infrastructure. [See the docs to learn more](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com).

如果您正在构建有状态的、能主动执行操作的，或需要暂停/恢复能力的智能体——LangGraph 平台将为您处理所有底层复杂性，让您专注于智能体本身的逻辑与行为设计，而非基础设施运维。[点击查阅文档，了解详情](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com)。

## The future is agentic — so build on a solid foundation

## 未来属于智能体时代——请基于坚实的基础构建

Agentic apps are here to stay. But like every shift in software — whether from monoliths to microservices, or from on-prem to cloud— the transition requires new tools.

智能体应用已成大势所趋，并将持续发展。但正如软件领域的每一次重大演进——无论是从单体架构转向微服务，还是从本地部署迈向云原生——这一转变同样需要全新的工具支撑。

**Agent infrastructure is the missing layer.** And if you're building anything beyond a stateless prompt, it's time to think seriously about what supports your agents behind the scenes.

**智能体基础设施，正是当前缺失的关键一环。** 如果您构建的应用已超越简单的无状态提示（stateless prompt），那么现在正是认真思考：幕后究竟有哪些系统在支撑您的智能体运行之时。

[Get started with LangGraph Platform](https://www.langchain.com/langgraph-platform?ref=blog.langchain.com) to learn more.

[立即开始使用 LangGraph 平台](https://www.langchain.com/langgraph-platform?ref=blog.langchain.com)，深入了解更多信息。