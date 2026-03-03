---
title: "Agent Frameworks, Runtimes, and Harnesses- oh my!"
source: "LangChain Blog"
url: "https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/"
date: "2025-11-04"
scraped_at: "2026-03-03T07:20:18.282110977+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes", "![Deep Agents", "**Deep Agents**"]
---

There are few different open source packages we maintain: [LangChain](https://docs.langchain.com/oss/python/langchain/quickstart?ref=blog.langchain.com) and [LangGraph](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com) being the biggest ones, but [DeepAgents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) being an increasingly popular one. I’ve started using different terms to describe them: LangChain is an agent framework, LangGraph is an agent runtime, DeepAgents is an [agent harness](https://www.vtrivedy.com/posts/claude-code-sdk-haas-harness-as-a-service?ref=blog.langchain.com). Other folks are using these terms as well — but I don’t think there is a clear definition of framework vs runtime vs harness. This is my attempt to do try to define things. I will readily admit that there is still murkiness and overlap so I would love any feedback!

我们维护着几个不同的开源软件包：其中规模最大的是 [LangChain](https://docs.langchain.com/oss/python/langchain/quickstart?ref=blog.langchain.com) 和 [LangGraph](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com)，而 [DeepAgents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) 则日益流行。我开始用不同术语来描述它们：LangChain 是一种**智能体框架（agent framework）**，LangGraph 是一种**智能体运行时（agent runtime）**，DeepAgents 则是一种**智能体套件（agent harness）**——参见 [agent harness](https://www.vtrivedy.com/posts/claude-code-sdk-haas-harness-as-a-service?ref=blog.langchain.com) 的定义。其他开发者也在使用这些术语，但我认为目前对“框架”、“运行时”与“套件”三者之间尚无清晰、公认的界定。本文即是我尝试厘清这些概念的一次努力。我坦率承认，当前这些概念仍存在模糊性与重叠之处，因此非常欢迎任何反馈！

![](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_001.png)

## Agent Frameworks (LangChain)

## 智能体框架（LangChain）

Most packages out there that help build with LLMs I would classify as agent frameworks. The main value add they provide is abstractions. These abstractions represent a mental model of the world. These abstractions should ideally make it easier to get started. They also provide a standard way to build applications which makes it easy for developers to onboard and jump between projects. Complaints against abstractions are that if done poorly they can obfuscate the inner workings of things and not provide the flexibility needed for advanced use cases.

目前市面上大多数辅助基于大语言模型（LLM）构建应用的软件包，我都将其归类为**智能体框架**。其核心价值在于提供**抽象层（abstractions）**。这些抽象层代表了一种对世界的思维建模方式；理想情况下，它们应显著降低入门门槛，并为应用开发提供一套标准化范式，从而帮助开发者快速上手、轻松在不同项目间切换。不过，对抽象层的常见批评是：若设计不当，反而会掩盖底层实现细节，且难以满足高级应用场景所需的灵活性。

We think of [LangChain](https://docs.langchain.com/oss/python/langchain/overview?ref=blog.langchain.com) as an agent framework. As part of the 1.0 we spent a lot of time thinking about the abstractions - for structured content blocks, for the agent loop, for middleware (which we think adds flexibility to the standard agent loop). Other examples of what I would consider agent frameworks are Vercel’s AI SDK, CrewAI, OpenAI Agents SDK, Google ADK, LlamaIndex, and lot more.

我们认为 [LangChain](https://docs.langchain.com/oss/python/langchain/overview?ref=blog.langchain.com) 正是一种智能体框架。在 LangChain 1.0 版本的开发过程中，我们投入大量精力深入思考各类抽象设计——包括结构化内容块（structured content blocks）、智能体循环（agent loop），以及中间件（middleware，我们认为它为标准智能体循环注入了更强的灵活性）。其他可被归入智能体框架范畴的代表性项目还包括：Vercel 的 AI SDK、CrewAI、OpenAI Agents SDK、Google ADK、LlamaIndex，以及更多同类工具。

## Agent Runtimes (LangGraph)

## 智能体运行时（LangGraph）

When you need to run agents in production, you will want some sort of runtime for agents. This runtime should provide more infrastructure level considerations. The main one that comes to mind is [durable execution](https://docs.langchain.com/oss/python/langgraph/durable-execution?ref=blog.langchain.com), but I would also put considerations like support for streaming, [human-in-the-loop support](https://docs.langchain.com/oss/python/langgraph/interrupts?ref=blog.langchain.com), thread level persistence and [cross-thread persistence](https://docs.langchain.com/oss/python/langgraph/add-memory?ref=blog.langchain.com) here.

当您需要将智能体部署至生产环境时，就需要某种形式的**智能体运行时**。该运行时应聚焦于更偏基础设施层面的能力考量。其中最典型的一项能力是 **[持久化执行（durable execution）](https://docs.langchain.com/oss/python/langgraph/durable-execution?ref=blog.langchain.com)**；此外，我还把以下能力也纳入运行时范畴：流式响应（streaming）支持、**[人工介入支持（human-in-the-loop support）](https://docs.langchain.com/oss/python/langgraph/interrupts?ref=blog.langchain.com)**、线程级状态持久化（thread-level persistence），以及**[跨线程持久化（cross-thread persistence）](https://docs.langchain.com/oss/python/langgraph/add-memory?ref=blog.langchain.com)**。

When we build [LangGraph](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com), we wanted to build in a production ready agent runtime from scratch. You can read more about our thought process behind building LangGraph [here](https://blog.langchain.com/building-langgraph/). The other projects we think are closest to this are Temporal, Inngest, and other durable execution engines.

我们在构建 [LangGraph](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com) 时，目标是从零开始打造一个面向生产环境就绪的智能体运行时。关于 LangGraph 的设计思路，您可进一步阅读我们的官方博客文章：[Building LangGraph](https://blog.langchain.com/building-langgraph/)。我们认为，与 LangGraph 定位最为接近的其他项目包括 Temporal、Inngest，以及其他各类持久化执行引擎。

Agent runtimes are generally lower level than agent frameworks and can power agent frameworks. For example, LangChain 1.0 is built on top of LangGraph to take advantage of the agent runtime it provides.

智能体运行时通常比智能体框架层级更低，且可作为智能体框架的底层支撑。例如，LangChain 1.0 就是构建在 LangGraph 之上的，以充分利用其提供的智能体运行时能力。

## Agent Harnesses (DeepAgents)

## 智能体套件（DeepAgents）

[DeepAgents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) is the newest project we’re working on.  
[DeepAgents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) 是我们目前正在进行的最新项目。

It is higher level than agent frameworks — it builds on top of LangChain.  
它比智能体（agent）框架层级更高——构建于 LangChain 之上。

It adds in default prompts, opinionated handling for tool calls, tools for planning, has access to a filesystem, and more.  
它内置了默认提示词（prompts）、对工具调用（tool calls）的约定式处理逻辑、规划类工具（planning tools），并具备文件系统访问能力等更多功能。

It’s more than a framework — it comes with batteries included.  
它远不止是一个框架——真正做到了“开箱即用”（batteries included）。

Another way that we’ve used to describe DeepAgents is as a “general purpose version of Claude Code”.  
我们还曾将 DeepAgents 形象地描述为“通用版 Claude Code”。

To be fair, Claude Code is also trying to be an agent harness — they’ve released things like Claude Agent SDK as a step in that direction.  
客观地说，Claude Code 同样致力于成为一种智能体运行时载体（agent harness）——他们已发布诸如 Claude Agent SDK 等工具，正是朝这一方向迈出的重要一步。

Besides Claude Agent SDK, I don’t think there are many other general purpose agent harnesses out there today.  
除 Claude Agent SDK 外，我认为当前市面上真正意义上的通用型智能体运行时载体（general purpose agent harnesses）并不多见。

One could argue, however, that ALL the coding CLI's are in a way agent harnesses, and may be general purpose.  
不过也有人会指出：所有面向编程任务的命令行工具（coding CLIs）在某种意义上都可视为智能体运行时载体，且其中不少确实具备通用性。

## When to use each one  

## 各方案适用场景

Let’s summarize the differences and talk about when to use each one:  
下面我们来总结三者的差异，并探讨各自适用的场景：

![](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_002.png)  
![](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_002.png)

Now, I will readily admit that the lines are blurry. LangGraph is probably best described as both a runtime and a framework, for example.  
诚然，这些概念之间的边界并不清晰。例如，LangGraph 很可能既可被归类为运行时（runtime），也可被视为框架（framework）。

“Agent Harness” is a term I’m just starting to see be used more ([I didn’t come up with it](https://www.vtrivedy.com/posts/claude-code-sdk-haas-harness-as-a-service?ref=blog.langchain.com)).  
“智能体运行时载体（Agent Harness）”这一术语，我也是近期才开始见到其被更广泛使用（[该说法并非我首创](https://www.vtrivedy.com/posts/claude-code-sdk-haas-harness-as-a-service?ref=blog.langchain.com)）。

I don’t think there is yet a super clear definition of any of these.  
目前，我认为上述任一概念都尚未形成极为明确、公认的定义。

Part of the fun of developing in an early space is coming up with the mental models for how to talk about things.  
在技术发展早期阶段进行开发的乐趣之一，正在于共同构建用于理解与讨论这些新事物的认知模型（mental models）。

We know LangChain is different from LangGraph, and DeepAgents is different from both of them.  
我们清楚地知道：LangChain 有别于 LangGraph，而 DeepAgents 又与二者均不相同。

We think describing them as a framework, runtime, and harness respectively is a helpful distinction — but as always, we would love your feedback!  
我们认为，将它们分别定义为“框架（framework）”、“运行时（runtime）”和“运行时载体（harness）”，是一种有益的区分方式；但一如既往，我们非常期待您的宝贵反馈！

### Tags  

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)  
[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_003.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![关于智能体框架与智能体可观测性](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_003.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_004.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪数据到深度洞察：规模化理解智能体行为](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_004.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_005.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码即文档；在人工智能中，追踪数据即文档。](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_005.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码即文档；在人工智能中，追踪数据即文档。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Reflections on Three Years of Building LangChain](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考与回顾](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![Deep Agents](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_008.png)](https://blog.langchain.com/deep-agents/)

[![深度智能体（Deep Agents）](images/agent-frameworks-runtimes-and-harnesses-oh-my/img_008.png)](https://blog.langchain.com/deep-agents/)

[**Deep Agents**](https://blog.langchain.com/deep-agents/)

[**深度智能体（Deep Agents）**](https://blog.langchain.com/deep-agents/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟