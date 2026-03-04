---
render_with_liquid: false
title: "LangGraph Studio: The first agent IDE"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-studio-the-first-agent-ide/"
date: "2024-08-01"
scraped_at: "2026-03-03T07:57:12.186911858+00:00"
language: "en-zh"
translated: true
description: "LangGraph Studio provides a specialized agent IDE for visualizing, interacting with, and debugging complex agentic applications. See how to use it on your desktop today."
---
render_with_liquid: false
render_with_liquid: false

LLMs have paved the way for the development of new types of _agentic_ applications — and as LLM applications evolve, so must the tooling needed to efficiently develop them. Today, we're announcing LangGraph Studio - the first IDE designed specifically for agent development - in open beta.

大语言模型（LLM）为新型 _智能体（agentic）_ 应用的开发铺平了道路；而随着 LLM 应用不断演进，高效开发它们所需的工具链也必须同步升级。今天，我们正式宣布推出 LangGraph Studio——首个专为智能体开发而设计的集成开发环境（IDE）——现已开启公开测试（open beta）。

LangGraph Studio offers a new way to develop LLM applications, providing a specialized agent IDE for visualizing, interacting with, and debugging complex agentic applications. In this blog, we'll give a brief overview of LangGraph and then explore how LangGraph Studio streamlines the development of agentic applications.

LangGraph Studio 为 LLM 应用开发提供了全新范式，它是一款专用于智能体开发的 IDE，支持对复杂智能体应用进行可视化呈现、交互操作与调试。本文将首先简要介绍 LangGraph，随后深入探讨 LangGraph Studio 如何显著简化智能体应用的开发流程。

## LangGraph: Balancing agent control with agency

## LangGraph：在可控性与自主性之间取得平衡

In [January 2023](https://blog.langchain.com/langgraph/), we launched LangGraph, a highly controllable, low-level orchestration framework for building agentic applications. Since then, we've seen teams build more complex agentic applications for production; in turn, we've heavily invested in LangGraph, leading to [a stable 0.1 release](https://blog.langchain.com/langgraph-cloud/) this past June.

早在 [2023 年 1 月](https://blog.langchain.com/langgraph/)，我们便推出了 LangGraph——一个高度可控、面向底层的编排框架，专为构建智能体应用而设计。此后，我们观察到众多团队已将其用于构建更复杂的生产级智能体应用；与此同时，我们也持续加大对 LangGraph 的投入，并于今年 6 月发布了 [稳定版 0.1](https://blog.langchain.com/langgraph-cloud/)。

LangGraph features a persistence layer that enables human-in-the-loop interactions, and it excels at building complex (i.e. more than a single LLM call) applications that require highly domain-specific cognitive architecture. Most of the agents we see in production fit this description.

LangGraph 内置持久化层，支持“人在回路中”（human-in-the-loop）的交互模式；它尤其擅长构建结构复杂（即需多次调用 LLM）、且依赖高度领域特化认知架构的应用。目前大多数投入生产的智能体应用均符合这一特征。

LangGraph is fully open source, available in both [Python](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) and [Javascript](https://github.com/langchain-ai/langgraphjs?ref=blog.langchain.com). It works with or without LangChain, and integrates seamlessly with LangSmith.

LangGraph 完全开源，同时提供 [Python](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 和 [JavaScript](https://github.com/langchain-ai/langgraphjs?ref=blog.langchain.com) 两个版本。它既可独立使用，也可与 LangChain 协同工作，并能与 LangSmith 无缝集成。

## LangGraph Studio: Visualize and interact with agent graphs for quick iteration

## LangGraph Studio：通过可视化与交互式图谱实现快速迭代

While LangGraph offers a new framework for developing agentic applications, we also strongly believe that new tooling is needed to make the development process easier. Building LLM applications differs from traditional software development, requiring different tooling outside of the traditional code editor.

尽管 LangGraph 为智能体应用开发提供了全新框架，但我们同样坚信：要真正降低开发门槛，还需配套全新的开发工具。LLM 应用的构建方式与传统软件开发存在本质差异，因此不能仅依赖传统的代码编辑器，而需引入专门适配的新工具。

Coding is still important to developing LLM applications — after all, production-ready LangGraph applications have complicated custom logic in the nodes and edges of the graphs that are created. We don't aim to replace code editors but, instead, to **augment** the development experience with tools tailored for LangGraph applications.

编码在 LLM 应用开发中依然至关重要——毕竟，面向生产的 LangGraph 应用往往在所构建图谱的节点（nodes）与边（edges）中嵌入了大量复杂的自定义逻辑。我们的目标并非取代代码编辑器，而是通过专为 LangGraph 应用打造的工具，来 **增强（augment）** 开发体验。

LangGraph Studio facilitates this by making it easy to visualize and interact with agent graphs, even if development still primarily happens in code. Visualizing graphs helps developers understand their structure. Furthermore, you can modify an agent result (or the logic underlying a specific node) halfway through the agent's trajectory. This creates an iterative process, by letting you interact with and manipulate the state at that point in time.

LangGraph Studio 正是为此而生：即便开发工作仍主要在代码中完成，它也能让智能体图谱的可视化与交互变得轻而易举。图谱可视化有助于开发者直观理解其整体结构；此外，你甚至可以在智能体执行轨迹的中途，实时修改某次推理结果（或某个特定节点背后的逻辑）。这种能力催生了一种高效的迭代开发模式——让你能在任意时间点与当前运行状态进行交互，并直接对其进行调整与操控。

While there is much more to explore, we're excited to introduce LangGraph Studio to start with bringing some of the core features of an agent IDE to the world.

尽管还有大量功能有待探索，我们非常高兴地率先推出 LangGraph Studio，将智能体集成开发环境（agent IDE）的核心功能带入现实。

## How to use LangGraph Studio

## 如何使用 LangGraph Studio

LangGraph Studio is a desktop app, currently available for Apple Silicon. You can download a version [here](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com). Support for more platforms is coming soon.

LangGraph Studio 是一款桌面应用程序，当前仅支持 Apple Silicon（苹果自研芯片）平台。您可在此处下载安装包：[点击下载](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com)。对其他平台的支持即将上线。

After you download and open LangGraph Studio, you will be prompted to log in with your LangSmith account. All users of LangSmith (including those with free accounts) currently have access to LangGraph Studio while it is in beta. You can sign up for a LangSmith account [here](https://smith.langchain.com/?ref=blog.langchain.com).

下载并打开 LangGraph Studio 后，系统将提示您使用 LangSmith 账户登录。目前处于 Beta 测试阶段，所有 LangSmith 用户（包括免费账户用户）均可使用 LangGraph Studio。您可在此注册 LangSmith 账户：[立即注册](https://smith.langchain.com/?ref=blog.langchain.com)。

![](images/langgraph-studio-the-first-agent-ide/img_001.png)

![](images/langgraph-studio-the-first-agent-ide/img_001.png)

After downloading LangSmith, you can open a directory. At a bare minimum, this directory needs to contain a Python file with a graph defined in it.

安装 LangSmith 后，您可以打开一个本地目录。该目录至少需包含一个定义了图（graph）结构的 Python 文件。

Next, you will need to create a `langgraph.json` file containing details such as where the agent is defined, which dependencies to install, and which environment variables to load. This file can be created in the UI, or can exist as a file in the directory already. For an example repository which meets these requirements, see [this GitHub repo](https://github.com/langchain-ai/langgraph-example?ref=blog.langchain.com).

接下来，您需要创建一个 `langgraph.json` 文件，其中需包含智能体定义位置、待安装依赖项以及需加载的环境变量等信息。该文件既可通过界面创建，也可预先作为文件存在于目标目录中。符合上述要求的示例代码仓库，请参见：[GitHub 示例仓库](https://github.com/langchain-ai/langgraph-example?ref=blog.langchain.com)。

![](images/langgraph-studio-the-first-agent-ide/img_002.png)

![](images/langgraph-studio-the-first-agent-ide/img_002.png)

After you open a directory, we will build an environment for you agent to run. After it builds, you should see a visualization of the graph along with a box for interacting with the agent.

打开目录后，系统将自动为您构建智能体运行所需的环境。构建完成后，您将看到图结构的可视化界面，以及一个用于与智能体交互的输入框。

![](images/langgraph-studio-the-first-agent-ide/img_003.png)

![](images/langgraph-studio-the-first-agent-ide/img_003.png)

When you interact with the agent, you'll get a stream of real-time information about what steps are happening. You can see the agent decide which tools to call, call those tools, and then continue looping.

当您与智能体交互时，将实时收到有关当前执行步骤的信息流。您可以观察到智能体决定调用哪些工具、实际调用这些工具，并随后继续循环执行。

You can interrupt the agent at any time if it veers off course, or you can interrupt the agent to run it in a “debug mode” where it pauses after each step of the graph (so you can walk-through step by step).

如果智能体偏离预期路径，您可随时中断其运行；您也可主动中断智能体，使其进入“调试模式”——在此模式下，智能体将在图中每一步执行完毕后暂停（以便您逐个步骤地检查和验证）。

/0:19

/0:19

1×

1×

💡

💡

At any point, you can interact with the **state** of the agent.

在任意时刻，您均可与智能体的 **状态（state）** 进行交互。

If you don’t like what the agent responded with at a specific step, you can directly modify the response and then continue with that new response. This can be useful for simulating what would have happened if the agent or a tool returned something different.

若您对智能体在某一步骤所返回的响应不满意，可直接修改该响应内容，然后基于这一新响应继续执行。此功能有助于模拟：倘若智能体或某个工具返回了不同的结果，后续流程将如何演变。

/0:14

/0:14

1×

1×

You can also modify the underlying code and then replay the node. LangGraph Studio detects changes to the underlying code files, allowing you to update prompts in your code editor and rerun nodes if an agent responds poorly. This can make it much easier to iterate on long-running agents.

您还可修改底层代码，随后重放对应节点。LangGraph Studio 能自动检测底层代码文件的变更，使您可在代码编辑器中更新提示词（prompts），并在智能体响应不佳时重新运行相关节点。这一机制可显著简化对长期运行型智能体的迭代优化过程。

/0:20

1×

## Conclusion

## 结论

Building agentic applications differs from traditional software development. While code editors remain important, new IDEs designed for agents are also needed. LangGraph Studio is a step in this direction, and we're excited to see how it enhances your workflow.

构建基于智能体（agentic）的应用与传统软件开发有所不同。尽管代码编辑器依然重要，但专为智能体设计的新一代集成开发环境（IDE）同样不可或缺。LangGraph Studio 正是朝这一方向迈出的重要一步，我们非常期待它如何提升您的开发工作流。

* * *

**For more on LangGraph Studio, check out our** [**documentation**](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com). **You can also watch a** [**video walkthrough on YouTube**](https://www.youtube.com/watch?v=pLPJoFvq4_M&ref=blog.langchain.com) **if that's more your style. You can** [**sign up for LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com) **today to try out LangGraph Studio for free.**

**如需了解更多关于 LangGraph Studio 的信息，请查阅我们的** [**文档**](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com)。**若您更喜欢视频形式，也可观看我们在** [**YouTube 上的演示视频**](https://www.youtube.com/watch?v=pLPJoFvq4_M&ref=blog.langchain.com)。**您可立即** [**注册 LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com) **，免费试用 LangGraph Studio。**

**We'd also love your feedback - drop us a line at hello@langchain.dev or on** [**Twitter**](https://x.com/LangChainAI?ref=blog.langchain.com) **to share your thoughts.**

**我们也非常期待您的反馈——欢迎发送邮件至 hello@langchain.dev，或在** [**Twitter（X）**](https://x.com/LangChainAI?ref=blog.langchain.com) **上联系我们，分享您的想法与建议。**