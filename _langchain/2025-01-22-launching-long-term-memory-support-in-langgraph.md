---
render_with_liquid: false
title: "Launching Long-Term Memory Support in LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/"
date: "2025-01-22"
scraped_at: "2026-03-03T07:43:15.258007824+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Today, we are excited to announce the first steps towards long-term memory support in LangGraph, available both in [Python](https://langchain-ai.github.io/langgraph/how-tos/cross-thread-persistence/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/how-tos/cross-thread-persistence/?ref=blog.langchain.com). Long-term memory lets you store and recall information between conversations so your agent can **learn from feedback** and adapt to **user preferences**. This feature is part of the OSS library, and it is enabled by default for all LangGraph Cloud & Studio users.

我们很高兴地宣布：LangGraph 现已迈出支持长期记忆（long-term memory）的第一步，该功能已在 [Python](https://langchain-ai.github.io/langgraph/how-tos/cross-thread-persistence/?ref=blog.langchain.com) 和 [JavaScript](https://langchain-ai.github.io/langgraphjs/how-tos/cross-thread-persistence/?ref=blog.langchain.com) 版本中同步上线。长期记忆使您能够在不同对话之间持久化存储并检索信息，从而让您的智能体能够 **从用户反馈中持续学习**，并动态适应 **用户偏好**。该功能属于开源（OSS）库的一部分，并且对所有 LangGraph Cloud 与 LangGraph Studio 用户默认启用。

![](images/launching-long-term-memory-support-in-langgraph/img_001.png)Memory: from short (thread-scoped) to long (cross-thread)

![](images/launching-long-term-memory-support-in-langgraph/img_001.png)记忆：从短期（线程内作用域）到长期（跨线程）

## On Memory

## 关于记忆（Memory）

Most AI applications today are goldfish; they forget everything between conversations. This isn't just inefficient— it fundamentally limits what AI can do.

当今大多数 AI 应用就像金鱼一样：每次对话结束后便遗忘一切。这不仅效率低下，更从根本上限制了 AI 的能力边界。

Over the past year at LangChain, we've been working with customers to build memory into their agents. Through this experience, we've realized something important: there's no universally perfect solution for AI memory. The best memory for each application still contains very application specific logic. By extension, most "agent memory" products today are too high-level. They try to create a one-size-fits-all product that doesn't satisfy many production users' needs.

过去一年中，LangChain 团队一直与客户合作，为其智能体构建记忆能力。通过这一实践，我们认识到一个关键事实：**AI 记忆并不存在放之四海而皆准的“完美方案”**。每个应用所需的最优记忆机制，仍高度依赖其自身业务逻辑。正因如此，当前市面上大多数“智能体记忆”产品抽象层级过高——它们试图打造一款“通用型”产品，却难以满足众多生产环境用户的实际需求。

This insight is why we have built our initial memory support into LangGraph as a simple document store. High level abstractions can be easily built on top (as we will show below), but beneath it all is a simple, reliable, persistent memory layer that comes built in to all LangGraph applications.

正是基于这一洞察，我们将初始的记忆支持设计为 LangGraph 内置的一个**轻量、可靠、持久化的文档存储（document store）**。在此基础之上，开发者可轻松构建更高阶的抽象（如下文所示），但底层始终是一个简洁、稳定、开箱即用的记忆层，原生集成于所有 LangGraph 应用之中。

## Cross-Thread Memory

## 跨线程记忆（Cross-Thread Memory）

LangGraph has always excelled at managing state **within** a single conversation thread using [checkpointers](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com#checkpoints). This "short-term memory" lets you maintain context within a single conversation.

LangGraph 一直以来都擅长借助 [检查点器（checkpointers）](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com#checkpoints) 来管理**单个对话线程内部**的状态。这种“短期记忆”使您能在一次完整对话中持续维护上下文。

Today, we're extending that capability **across** **multiple threads**, enabling your agents to easily remember information across multiple conversations, all integrated in the LangGraph framework.

今天，我们进一步将这一能力拓展至 **多个对话线程之间**，使您的智能体能够轻松在多次独立对话中记住并复用信息——全部能力均深度集成于 LangGraph 框架之内。

At its core, cross-thread memory is "just" a persistent document store that lets you **put**, **get**, and **search** for memories you've saved. These basic primitives enable:  

本质上，跨线程记忆“仅”是一个持久化文档存储，支持对已保存的记忆执行 **存入（put）**、**读取（get）** 和 **检索（search）** 操作。这些基础原语支撑起以下能力：

1. **Cross-Thread Persistence**: Store and recall information across different conversation sessions.  
1. **跨会话持久化**：在不同对话会话之间存储与回溯信息。

2. **Flexible Namespacing**: Organize memories using custom namespaces, making it easy to manage data for different users, organizations, or contexts.  
2. **灵活的命名空间机制**：通过自定义命名空间组织记忆，便于为不同用户、组织或上下文管理数据。

3. **JSON Document Storage**: Save memories as JSON documents for easy manipulation and retrieval.  
3. **JSON 文档存储**：以 JSON 文档形式保存记忆，便于操作与检索。

4. **Content-Based Filtering**: Search for memories across namespaces based on content.  
4. **基于内容的过滤**：跨命名空间按内容搜索记忆。

For a deeper understanding of these concepts, we've prepared a set of documents to provide framing and guidance on how to get started:  
如需更深入理解上述概念，我们已准备了一系列文档，帮助您建立认知框架并提供入门指导：

- A [conceptual video](https://youtu.be/JTL0yp85FsE?ref=blog.langchain.com) walking through memory concepts  
- 一段[概念讲解视频](https://youtu.be/JTL0yp85FsE?ref=blog.langchain.com)，系统梳理记忆相关概念  

- Conceptual guides on memory in LangGraph [Python](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com) & [JS](https://langchain-ai.github.io/langgraphjs/concepts/memory/?ref=blog.langchain.com)  
- LangGraph 中关于记忆的概念指南：[Python 版](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com) 与 [JavaScript 版](https://langchain-ai.github.io/langgraphjs/concepts/memory/?ref=blog.langchain.com)  

- How-to guide for sharing memories across threads in [Python](https://langchain-ai.github.io/langgraph/how-tos/cross-thread-persistence/?ref=blog.langchain.com) & [JS](https://langchain-ai.github.io/langgraphjs/how-tos/cross-thread-persistence/?ref=blog.langchain.com)  
- 跨会话共享记忆的操作指南：[Python 版](https://langchain-ai.github.io/langgraph/how-tos/cross-thread-persistence/?ref=blog.langchain.com) 与 [JavaScript 版](https://langchain-ai.github.io/langgraphjs/how-tos/cross-thread-persistence/?ref=blog.langchain.com)  

## Practical Implementation  

## 实践落地  

To help you get started with implementing long-term memory in your applications, we've prepared a new LangGraph [template](https://studio.langchain.com/?ref=blog.langchain.com):  
为帮助您快速在应用中实现长期记忆功能，我们推出了一款全新的 LangGraph [模板](https://studio.langchain.com/?ref=blog.langchain.com)：  

![](images/launching-long-term-memory-support-in-langgraph/img_002.png)  

This LangGraph Template shows a chatbot agent that manages its own memory. Key resources for this are  
该 LangGraph 模板展示了一个可自主管理记忆的聊天机器人智能体。核心配套资源包括：  

- An [end-to-end tutorial video](https://youtu.be/-xkduCeudgY?ref=blog.langchain.com) walking through the implementation  
- 一段[端到端教学视频](https://youtu.be/-xkduCeudgY?ref=blog.langchain.com)，完整演示实现过程  

- A [LangGraph Memory Agent](https://github.com/langchain-ai/memory-agent?ref=blog.langchain.com) in Python  
- 一个基于 Python 的 [LangGraph 记忆智能体](https://github.com/langchain-ai/memory-agent?ref=blog.langchain.com)  

- A [LangGraph.js Memory Agent](https://github.com/langchain-ai/memory-agent-js?ref=blog.langchain.com) in JavaScript  
- 一个基于 JavaScript 的 [LangGraph.js 记忆智能体](https://github.com/langchain-ai/memory-agent-js?ref=blog.langchain.com)  

These resources demonstrate one way to leverage long-term memory in LangGraph, bridging the gap between concept and implementation.  
这些资源展示了在 LangGraph 中运用长期记忆的一种可行路径，有效弥合了概念理解与工程实践之间的鸿沟。

We encourage you to explore these materials and experiment with incorporating long-term memory into your LangGraph projects. As always, we welcome your feedback and look forward to seeing how you apply these new capabilities in your applications.  
我们诚挚邀请您深入探索上述资料，并积极尝试将长期记忆能力集成至您的 LangGraph 项目中。一如既往，我们热切期待您的宝贵反馈，并乐于见证您如何在实际应用中发挥这些全新能力的价值。