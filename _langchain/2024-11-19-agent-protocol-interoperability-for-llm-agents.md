---
title: "Agent Protocol: Interoperability for LLM agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/agent-protocol-interoperability-for-llm-agents/"
date: "2024-11-19"
scraped_at: "2026-03-03T07:47:24.498254634+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

# LangGraph is a multi-agent framework.

# LangGraph 是一个面向多智能体的框架。

LangGraph is a multi-agent framework. This means not only interacting with other LangGraph agents, but all other types of agents as well, regardless of how they are built. Today we are taking a few steps to build towards this vision. We are announcing:

LangGraph 是一个面向多智能体的框架。这意味着它不仅能与其他 LangGraph 智能体交互，还能与所有其他类型的智能体交互——无论这些智能体采用何种方式构建。今天，我们正迈出若干关键步伐，朝着这一愿景持续迈进。我们正式宣布：

- [**Agent Protocol**](https://github.com/langchain-ai/agent-protocol?ref=blog.langchain.com): a common interface for agent communication. This standardizes how agents (LangGraph or otherwise) can interact.  
- [**Agent 协议（Agent Protocol）**](https://github.com/langchain-ai/agent-protocol?ref=blog.langchain.com)：一种通用的智能体通信接口。该协议统一规范了各类智能体（无论是基于 LangGraph 还是其他技术栈）之间的交互方式。

- [A guide](https://langchain-ai.github.io/langgraph/how-tos/local-studio/?ref=blog.langchain.com) and [video](https://youtu.be/o9CT5ohRHzY?ref=blog.langchain.com) showing how to connect LangGraph Studio to a locally running agent. This exposes a locally running server (implementing the Agent Protocol) to make it easier for everyone to use LangGraph Studio.  
- [一份指南](https://langchain-ai.github.io/langgraph/how-tos/local-studio/?ref=blog.langchain.com) 和 [一段视频](https://youtu.be/o9CT5ohRHzY?ref=blog.langchain.com)，介绍如何将 LangGraph Studio 连接到本地运行的智能体。该方案通过暴露一个实现 Agent 协议的本地服务器，显著降低了 LangGraph Studio 的使用门槛。

- [A guide](https://langchain-ai.github.io/langgraph/how-tos/autogen-integration/?ref=blog.langchain.com) showing how to use other frameworks (like AutoGen, CrewAI, and others) as sub-agents within a LangGraph agent.  
- [一份指南](https://langchain-ai.github.io/langgraph/how-tos/autogen-integration/?ref=blog.langchain.com)，介绍如何将其他框架（如 AutoGen、CrewAI 等）作为子智能体集成到 LangGraph 智能体中。

- [A guide](https://langchain-ai.github.io/langgraph/how-tos/autogen-langgraph-platform/?ref=blog.langchain.com) showing how to deploy other frameworks (like AutoGen, CrewAI, and others) using LangGraph Platform, taking advantage of the infrastructure we have built there.  
- [一份指南](https://langchain-ai.github.io/langgraph/how-tos/autogen-langgraph-platform/?ref=blog.langchain.com)，介绍如何借助 LangGraph Platform 部署其他框架（如 AutoGen、CrewAI 等），从而充分利用我们在该平台中已构建的基础设施。

## Agent Protocol: a standard way for agents to communicate

## Agent 协议：智能体间通信的标准方式

While we think LangGraph is the best way to build agents, we also recognize that there are plenty of other ways to do so. The vast majority of people not using LangGraph roll their own implementations, but we also see people using other frameworks like AutoGen, OpenAI's Assistant API, CrewAI, LlamaIndex, and others.

尽管我们认为 LangGraph 是构建智能体的最佳方式，但我们同样承认，构建智能体还有大量其他可行路径。绝大多数未采用 LangGraph 的开发者选择自行实现，同时我们也观察到不少人正在使用 AutoGen、OpenAI 的 Assistant API、CrewAI、LlamaIndex 等其他框架。

This means most agents expose different APIs. As we move towards multi-agent world, this lack of uniformity poses an issue. [Communication is all you need](https://blog.langchain.com/communication-is-all-you-need/), but varying APIs make standard communication challenging.

这意味着大多数智能体对外暴露的 API 各不相同。当我们迈向多智能体协同的世界时，这种缺乏统一性的现状便构成了一大挑战。“通信即一切”（[Communication is all you need](https://blog.langchain.com/communication-is-all-you-need/)），但 API 的千差万别却让标准化通信变得异常困难。

In an effort to change this, we are open-sourcing an [**Agent Protocol**](https://github.com/langchain-ai/agent-protocol?ref=blog.langchain.com) \- a standard interface for agent communication. Agent Protocol is our attempt at codifying the framework-agnostic APIs that are needed to serve LLM agents in production. These APIs center around concepts we think are central to reliably deploying agents:

为改变这一现状，我们开源了 [**Agent 协议（Agent Protocol）**](https://github.com/langchain-ai/agent-protocol?ref=blog.langchain.com) —— 一套标准化的智能体通信接口。Agent 协议旨在将生产环境中部署大语言模型（LLM）智能体所必需的、与具体框架无关的 API 进行规范化定义。这些 API 围绕我们认为对智能体可靠部署至关重要的核心概念展开：

- Runs: APIs for executing an agent  
- **执行（Runs）**：用于触发智能体运行的 API  

- Threads: APIs to organize multi-turn executions of agents  
- **会话线程（Threads）**：用于组织智能体多轮交互执行的 API  

- Store: APIs to work with long-term memory  
- **存储（Store）**：用于管理长期记忆的 API  

Any agent developer can implement this protocol - whether they are using LangGraph, a different framework, or no framework at all.

任何智能体开发者均可实现该协议——无论其采用 LangGraph、其他框架，抑或完全不依赖任何框架。

## Using Agent Protocol to connect LangGraph Studio to a locally running agent

## 利用 Agent 协议将 LangGraph Studio 连接到本地运行的智能体

A few months ago we released LangGraph Desktop - "the first agent IDE." This UI allows you to visualize, interact with, and debug your LangGraph applications. When we initially released it as part of LangGraph Cloud, we soon realized it would provide more value running locally. This would allow you to pause execution mid-graph, change the underlying code, and rerun within a tight, low-latency feedback loop.

数月前，我们发布了 LangGraph Desktop —— “首个智能体集成开发环境（IDE）”。该用户界面支持您直观地可视化、交互式操作并调试 LangGraph 应用程序。最初，我们将它作为 LangGraph Cloud 的一部分发布；但很快我们意识到，若以本地模式运行，它将释放更大价值：您可在图执行中途暂停、即时修改底层代码，并在一个紧凑、低延迟的反馈循环中重新运行。

As innovative as LangGraph Desktop was, it suffered from three usability issues. First: it was available for Mac only. Second: it used Docker under the hood (more resource-intensive and slower to start up). Third: it ran in a separate Docker environment (not in your local environment & harder to debug).

尽管 LangGraph Desktop 极具创新性，但它存在三个可用性问题：第一，它仅支持 macOS；第二，其底层依赖 Docker（资源占用更高，启动更慢）；第三，它运行于独立的 Docker 环境中（而非您的本地环境，因而更难调试）。

Today we're excited to announce a version of LangGraph Studio that solves those issues. It is installable as Python package, and runs the backend locally inside your environment. This makes it usable on all platforms, and doesn't require Docker. It connects to a web version of the Studio frontend. Note that your LangGraph application runs entirely locally and no data is sent to our servers.

今天，我们非常高兴地宣布推出一款全新版本的 LangGraph Studio，彻底解决了上述问题。该版本以 Python 包形式分发，后端直接在您的本地环境中运行——因此可在所有平台（Windows、macOS、Linux）上使用，且无需 Docker。它通过网络连接至 Studio 的 Web 前端。请注意：您的 LangGraph 应用程序完全在本地运行，**不会向我们的服务器发送任何数据**。

You can install it with:

您可通过以下命令安装：

```
pip install "langgraph-cli[inmem]==0.1.55"
```

And you can run it with:

然后通过以下命令启动：

```
langgraph dev
```

For more information on installation and usage, [see here](https://langchain-ai.github.io/langgraph/how-tos/local-studio/?ref=blog.langchain.com). For more information on using the Studio to effectively debug your LangGraph applications, see our [YouTube video here](https://youtu.be/o9CT5ohRHzY?ref=blog.langchain.com).

如需了解安装与使用详情，请[点击此处查看文档](https://langchain-ai.github.io/langgraph/how-tos/local-studio/?ref=blog.langchain.com)。如需了解如何借助 Studio 高效调试 LangGraph 应用程序，请观看我们的 [YouTube 教程视频](https://youtu.be/o9CT5ohRHzY?ref=blog.langchain.com)。

The locally running server that `langgraph-cli` spins up implements the Agent Protocol, and LangGraph Studio will connect to any servers that implement the Agent Protocol.

`langgraph-cli` 启动的本地服务器实现了 **Agent Protocol**（智能体协议），LangGraph Studio 可连接任意兼容该协议的服务器。

## Integrating LangGraph with AutoGen, CrewAI, and other frameworks

## 将 LangGraph 与 AutoGen、CrewAI 及其他框架集成

LangGraph is a framework for building agentic and multi-agent applications. This includes integrating with other agent frameworks.

LangGraph 是一个用于构建智能体（agentic）及多智能体（multi-agent）应用的框架。它天然支持与其他智能体框架（如 AutoGen、CrewAI 等）集成。

We've released [a new guide](https://langchain-ai.github.io/langgraph/how-tos/autogen-integration/?ref=blog.langchain.com) showing how to integrate LangGraph with other frameworks. The framework we show off integrating with is AutoGen, but this can easily be done with other frameworks.

我们已发布[一份新指南](https://langchain-ai.github.io/langgraph/how-tos/autogen-integration/?ref=blog.langchain.com)，介绍如何将 LangGraph 与其他框架集成。指南中重点演示了与 AutoGen 的集成，但该方法同样可轻松适配其他框架。

At a high level, the way this works is by wrapping the other agent inside a LangGraph node. LangGraph nodes can be anything - arbitrary code. This makes it easy to define an AutoGen (or CrewAI, or LlamaIndex, or other framework) agent and then reference it inside your graph. This allows you to create multi-agent systems where some of the sub-agents are actually defined in other frameworks.

从高层视角来看，这种集成方式是将其他框架的智能体（agent）封装为一个 LangGraph 节点。LangGraph 的节点可以是任意内容——包括任意代码。这使得定义一个 AutoGen（或 CrewAI、LlamaIndex 或其他框架）智能体并将其引用到你的图（graph）中变得非常简单。由此，你便能构建多智能体系统，其中部分子智能体实际上由其他框架实现。

## Using LangGraph Platform to deploy AutoGen, CrewAI, and other frameworks

## 使用 LangGraph Platform 部署 AutoGen、CrewAI 及其他框架

LangGraph Platform provides infrastructure for deploying agents. This integrates seamlessly with LangGraph, but can also work with other frameworks. The way to make this work is to wrap the agent in a single LangGraph node, and have that be the entire graph.

LangGraph Platform 提供了用于部署智能体的基础设施。它与 LangGraph 无缝集成，同时也兼容其他框架。实现这一兼容的方式，是将目标智能体封装为一个独立的 LangGraph 节点，并使该节点构成整张图（即单节点图）。

Doing so will allow you to deploy to LangGraph Platform, and allows you to get a lot of the benefits. You get horizontally scalable infrastructure, a task queue to handle bursty operations, a persistence layer to power short term memory, and long term memory support.

如此操作后，你即可将智能体部署至 LangGraph Platform，并享受其诸多优势：具备水平扩展能力的基础设施、可应对突发性任务的任务队列、支撑短期记忆的持久化层，以及对长期记忆的支持。

See our guide [here](https://langchain-ai.github.io/langgraph/how-tos/autogen-langgraph-platform/?ref=blog.langchain.com) for how to do this integration.

请参阅我们的指南[此处](https://langchain-ai.github.io/langgraph/how-tos/autogen-langgraph-platform/?ref=blog.langchain.com)，了解如何完成此项集成。
&#123;% endraw %}
