---
title: "Why do I need LangGraph Platform for agent deployment?"
source: "LangChain Blog"
url: "https://blog.langchain.com/why-langgraph-platform/"
date: "2025-10-13"
scraped_at: "2026-03-03T07:25:17.240166419+00:00"
language: "en-zh"
translated: true
description: "This blog dives into technical details for why agent deployment is difficult, and how we built a platform to solve those challenges (LangGraph Platform)."
---

_Note: As of October 2025, LangGraph Platform has been re-named to "LangSmith Deployment"._

_注：截至 2025 年 10 月，LangGraph Platform 已正式更名为 “LangSmith Deployment”。_

Last we week, we announced the GA of LangGraph Platform, our deployment platform for long running, stateful, or bursty agents. This blog is a technical explanation of **why** a deployment platform for agents is needed and **how** we built it.

上周，我们宣布 LangGraph Platform（面向长时间运行、有状态或突发性负载的智能体的部署平台）正式进入通用可用（GA）阶段。本文将从技术角度深入解析：**为何需要专为智能体设计的部署平台**，以及**我们是如何构建它的**。

## Intro

## 简介

Over the past year we’ve seen [companies like LinkedIn, Uber, Klarna, and Elastic](https://www.langchain.com/built-with-langgraph?ref=blog.langchain.com) successfully build agents with LangGraph. We increasingly have confidence that LangGraph’s high degree of control, built-in persistence layer, and human-in-the-loop features are the right abstractions for building reliable agents.

过去一年中，我们已见证 [LinkedIn、Uber、Klarna 和 Elastic 等公司](https://www.langchain.com/built-with-langgraph?ref=blog.langchain.com) 成功基于 LangGraph 构建智能体。我们愈发确信：LangGraph 所提供的高度可控性、内置持久化层，以及“人在环路中”（human-in-the-loop）能力，正是构建高可靠性智能体所需的恰当抽象。

After an agent is built, it then time to deploy.

智能体开发完成之后，便进入部署阶段。

For some agents - deployment is easy. Specifically, if you have stateless agents that run quickly and at low volumes - then deployment isn’t that hard! You can run them as a lambda and all will be fine.

对某些智能体而言，部署十分简单——尤其是那些无状态、执行迅速且调用量较低的智能体，部署难度并不大！你完全可以将其部署为 Serverless 函数（如 AWS Lambda），一切便可顺利运行。

For other types of agents, however, deployment becomes trickier. Specifically, the **longer running, more stateful, or more bursty** your agent is, the more complicated you deployment will be.

然而，对于其他类型的智能体，部署则会变得更具挑战性。具体而言，你的智能体若具备以下任一特征——**运行时间更长、状态更复杂、或流量更具突发性**——其部署复杂度便会显著上升。

## **Long Running Agents**

## **长时间运行的智能体**

**Problem**

**问题**

For agents that take longer to process (e.g., hours), maintaining an open connection can be impractical.

对于处理耗时较长（例如数小时）的智能体，维持一个长期打开的连接在实践中往往不可行。

**How we solve it**:

**我们如何解决该问题**：

The LangGraph Server supports launching agent runs in the background and provides polling endpoints, streaming endpoints and webhooks to monitor run status effectively.

LangGraph Server 支持在后台启动智能体（agent）运行，并提供轮询端点（polling endpoints）、流式端点（streaming endpoints）以及 Webhook，以高效监控运行状态。

**Problem**

**问题**

Regular server setups often encounter timeouts or disruptions when handling requests that take a long time to complete.

常规服务器配置在处理耗时较长的请求时，常常遭遇超时或连接中断。

**How we solve it**

**我们如何解决该问题**

LangGraph Server’s API provides robust support for these tasks by sending regular heartbeat signals, preventing unexpected connection closures during prolonged processes. Additionally, stream endpoints can be rejoined if the connection drops, and will very soon buffer events emitted while you were disconnected.

LangGraph Server 的 API 通过定期发送心跳信号，为这类任务提供稳健支持，从而避免长时间运行过程中出现意外连接关闭。此外，若流式连接中断，可重新接入流式端点；并且很快将支持缓存您断连期间所触发的事件。

**Problem**

**问题**

The longer an agent runs for, the more likely it is to suffer an exception while running.

智能体运行时间越长，其在执行过程中发生异常的可能性就越高。

**How we solve it**

**我们如何解决该问题**

LangGraph Server implements strategies to both minimize the number of exceptions agents face (eg. by running them in workers which can use isolated event loops and background threads) as well as the amount of time needed to recover from an exception (eg. when an agent fails it is retried a configurable number of times, and each retry starts off from the most recent successful checkpoint).

LangGraph Server 实施了多项策略：一方面，尽可能减少智能体遭遇异常的次数（例如，将其运行于独立的工作进程（worker）中，这些进程可使用隔离的事件循环和后台线程）；另一方面，最大限度缩短从异常中恢复所需的时间（例如，当智能体运行失败时，系统将按预设次数自动重试，且每次重试均从最近一次成功保存的检查点（checkpoint）开始）。

**Problem**

The longer an agent runs for, the more you need intermediate output to be emitted while the agent is running, to show the end user that something is happening.

**问题**

代理运行时间越长，就越需要在代理执行过程中实时输出中间结果，以便向终端用户表明系统正在处理中。

**How we solve it**

LangGraph Server implements multiple streaming modes, including intermediate results, token-by-token LLM messages, all the way to streaming of custom payloads emitted by your nodes. Streaming events are emitted in realtime from the background workers that run the agents, with minimal latency, giving you a unique combo of durable execution with realtime output. Multiple consumers can connect to the output stream of the same agent, and these connections can be re-established if dropped by the client or intermediate networking layers.

**我们的解决方案**

LangGraph Server 实现了多种流式传输模式，包括中间结果、逐 Token 的大语言模型（LLM）消息，乃至由您自定义节点所发出的任意载荷（custom payloads）的流式传输。流式事件由运行代理的后台工作进程实时发出，延迟极低，从而为您提供一种独特的能力组合：既保障执行的持久性，又支持实时输出。多个消费者可同时连接至同一代理的输出流；若因客户端或中间网络层原因导致连接中断，这些连接亦可重新建立。

## **Bursty Agents**

## **突发型代理（Bursty Agents）**

**Problem**

Certain applications, especially those with real-time user interaction, may experience "bursty" request loads where numerous requests hit the server simultaneously.

**问题**

某些应用——尤其是具备实时用户交互特性的应用——可能遭遇“突发型”请求负载，即大量请求在同一时刻涌入服务器。

**How we solve it**

LangGraph Server includes a task queue, ensuring requests are handled consistently without loss, even under heavy loads. LangGraph Server is designed to scale horizontally on both the server and queue components. This scaling is transparent to you, and doesn’t require complicated load balancing, as all server instances are stateless, and all server instances can communicate with all worker instances to support real-time streaming and cancellation. You can add as many queue instances as needed to handle your desired throughput, and they will all share the queued runs fairly, without ever executing the same run more than once.

**我们的解决方案**

LangGraph Server 内置任务队列，确保即使在高负载下，所有请求也能被一致、无丢失地处理。LangGraph Server 在服务端和队列组件两方面均支持水平扩展。该扩展过程对您完全透明，无需配置复杂的负载均衡机制——因为所有服务实例均为无状态，且任一服务实例均可与所有工作实例通信，从而原生支持实时流式传输与任务取消功能。您可以按需添加任意数量的队列实例以满足目标吞吐量要求；这些队列实例将公平共享待执行任务队列，且绝不会重复执行同一任务。

**Problem**

**问题**

Some of types of bursty applications that are also stateful (see below) may let the user send multiple messages rapidly, without the agent having finished responding to the first one. This “double texting” can disrupt agent flows if not handled properly.

某些具有突发性（bursty）特征、同时又是有状态（stateful）的应用程序（参见下文）可能允许用户快速连续发送多条消息，而智能体尚未完成对第一条消息的响应。这种“重复发送消息”行为若未得到妥善处理，可能会扰乱智能体的执行流程。

**How we solve it**

**我们如何解决该问题**

LangGraph Server offers four built-in strategies to address and manage such interactions.

LangGraph Server 提供了四种内置策略，用于应对和管理此类交互。

## **Stateful Agents**

## **有状态智能体**

**Problem**

**问题**

There are several levels of statefulness. There is both short-term and long-term memory. Then there is human-in-the-loop (pausing at an arbitrary point in your graph until you get back human input). On top of that, there is human-on-the-loop (time travel) - letting users go back to a previous state of the graph, modify it, and resume from there.

有状态性（statefulness）可分为多个层级：既包括短期记忆，也包括长期记忆；此外还有“人在回路中”（human-in-the-loop），即在图（graph）中任意节点处暂停执行，等待人工输入后继续；更进一步的是“人在环上”（human-on-the-loop，即“时间旅行”功能）——允许用户回退到图的某一历史状态，对其进行修改，再从此处恢复执行。

There are also different shapes of state. The most simple one is just a list of messages. Most agents, however, have more complicated state than that.

状态的形式也各不相同。最简单的状态仅是一组消息列表；但大多数智能体的状态结构远比这复杂。

The more of these stateful operations you want to support, and the more complex your state, then the more complicated it is to properly set up infrastructure to enable this.

你希望支持的有状态操作越多、状态结构越复杂，相应地，构建能稳定支撑这些能力的基础设施也就越具挑战性。

**How we solve it**

**我们如何解决该问题**

LangGraph Platform includes optimized [checkpointers](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com#checkpoints) and a [memory store](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com#memory-store), managing state across sessions without the need for custom solutions.

LangGraph Platform 内置了经过优化的 [检查点管理器（checkpointers）](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com#checkpoints) 和 [内存存储（memory store）](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com#memory-store)，可在不同会话间自动管理状态，无需用户自行开发定制化方案。

LangGraph Server provides specialized endpoints for human-in-the-loop scenarios, simplifying the integration of manual oversight into agent workflows.

LangGraph Server 为“人在环路”（human-in-the-loop）场景提供专用端点，简化人工监督与智能体工作流的集成。

**Problem**

**问题**

The more your agent is used, the more memory is used to store conversations and memories that may no longer be relevant.

智能体使用得越频繁，用于存储对话和记忆的内存就越多——而这些对话和记忆可能已不再相关。

**How we solve it**

**我们的解决方案**

LangGraph Server supports attaching TTLs (time-to-live) to both conversation threads as well as long-term memory entries, which will be cleared from memory by the platform when they expire.

LangGraph Server 支持为对话线程和长期记忆条目分别设置 TTL（生存时间），过期后平台将自动将其从内存中清除。

## Conclusion

## 结论

By using LangGraph Platform, you gain access to a robust, scalable deployment solution that mitigates these challenges, saving you the effort of implementing and maintaining them manually. This allows you to focus more on building effective agent behavior and less on solving deployment infrastructure issues.

借助 LangGraph Platform，您可获得一个稳健、可扩展的部署解决方案，有效缓解上述挑战，免去手动实现与维护相关功能的负担。这使您能更专注于构建高效的智能体行为，而非耗费精力解决部署基础设施问题。

To get started, read about our deployment options [here](https://langchain-ai.github.io/langgraph/concepts/deployment_options/?ref=blog.langchain.dev#related). You can also check out [our announcement](https://blog.langchain.com/langgraph-platform-ga/) LangGraph Platform's general availability to learn more.

如需快速上手，请阅读我们的[部署选项说明](https://langchain-ai.github.io/langgraph/concepts/deployment_options/?ref=blog.langchain.dev#related)。您还可查阅[官方公告](https://blog.langchain.com/langgraph-platform-ga/)，了解 LangGraph Platform 正式发布的更多信息。