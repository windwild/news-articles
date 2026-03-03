---
title: "Doubling down on DeepAgents"
source: "LangChain Blog"
url: "https://blog.langchain.com/doubling-down-on-deepagents/"
date: "2025-11-17"
scraped_at: "2026-03-03T07:18:43.726732223+00:00"
language: "en-zh"
translated: true
---

Two months ago [we wrote about Deep Agents](https://blog.langchain.com/deep-agents/) \- a term we coined for agents that are able to do complex, open ended tasks over longer time horizons. We hypothesized that there were four key elements to those agents: a planning tool, access to a filesystem, subagents, and detailed prompts.

两个月前，我们撰文介绍了 [Deep Agents（深度智能体）](https://blog.langchain.com/deep-agents/)——这是我们提出的一个术语，指能够在更长的时间跨度内执行复杂、开放式任务的智能体。我们曾假设，这类智能体包含四个关键要素：规划工具（planning tool）、文件系统访问能力、子智能体（subagents）以及细致入微的提示词（detailed prompts）。

![](images/doubling-down-on-deepagents/img_001.png)

We launched [`deepagents`](https://github.com/hwchase17/deepagents?ref=blog.langchain.com) as an Python package that had a base of all these elements, so that you would only have to bring your custom tools and a custom prompt and you could build a Deep Agent easily.

我们发布了 [`deepagents`](https://github.com/hwchase17/deepagents?ref=blog.langchain.com) ——一个 Python 软件包，已内置上述全部核心要素。你只需提供自定义工具和定制化提示词，即可轻松构建一个 Deep Agent。

We've seen strong interest and adoption, and today we're excited to double down with a 0.2 release. In this blog we want to talk about whats new in 0.2 release compared to the launch, as well as when to use [`deepagents`](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) (vs [`langchain`](https://docs.langchain.com/oss/python/langchain/overview?ref=blog.langchain.com) or [`langgraph`](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com))

我们已观察到强烈的社区兴趣与广泛采用；今天，我们非常高兴地宣布推出 0.2 版本，进一步加码投入。本文将重点介绍 0.2 版本相较初始发布版本新增了哪些功能，并探讨何时应选用 [`deepagents`](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com)（而非 [`langchain`](https://docs.langchain.com/oss/python/langchain/overview?ref=blog.langchain.com) 或 [`langgraph`](https://docs.langchain.com/oss/python/langgraph/overview?ref=blog.langchain.com)）。

## **Pluggable Backends**

## **可插拔后端（Pluggable Backends）**

The main new addition in 0.2 release comes in the form of pluggable backends. Previously, the "filesystem" that `deepagents` had access to was a "virtual filesystem". It would use LangGraph state to store files.

0.2 版本最主要的新特性是引入了**可插拔后端（pluggable backends）**。此前，`deepagents` 所访问的“文件系统”仅是一个“虚拟文件系统”，其底层依赖 LangGraph 的状态（state）来存储文件。

In 0.2, we have a new `Backend` abstraction, which allows you to plug in anything as the "filesystem". Built in implementations include:

在 0.2 版本中，我们新增了 `Backend` 抽象接口，使你可以将任意存储系统接入作为“文件系统”。当前内置实现包括：

- LangGraph State  
- LangGraph Store（支持跨线程持久化）  
- 真实的本地文件系统（actual local filesystem）

We've also introduced the idea of a "composite backend". This allows you to have a base backend (eg local filesystem) but then map on top of it other backends at certain subdirectories. An example use case of this is to empower long term memory. You could have a local filesystem as a base backend, but then map all file operations in `/memories/` directory to an s3 backed "virtual filesystem", allowing your agent to add things there and have them persist beyond your computer.

我们还引入了“复合后端（composite backend）”的概念：它允许你指定一个基础后端（例如本地文件系统），再针对特定子目录（如 `/memories/`）映射其他后端。一个典型应用场景是增强长期记忆能力——你可以将本地文件系统设为基础后端，同时将 `/memories/` 目录下的所有文件操作重定向至由 Amazon S3 支撑的“虚拟文件系统”，从而使智能体写入该目录的内容能持久保存，不受单机生命周期限制。

You can write your own backend to create a "virtual filesystem" over any database or any data store you want.

你也可以自行开发后端实现，从而在任意数据库或任意数据存储系统之上构建专属的“虚拟文件系统”。

You can also subclass an existing backend and add in guardrails around which files can be written to, format checking for these files, etc.

您还可以继承一个现有后端，并添加针对可写入文件范围的防护机制、对这些文件的格式校验等安全措施。

## Other things in 0.2

## 0.2 版本中的其他更新

We also added a number of other improvements making their way to `deepagents` in the 0.2 release:

在 0.2 版本中，我们还为 `deepagents` 引入了多项其他改进：

- [Large tool result eviction](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#large-tool-result-eviction): automatically dump large tool results to the filesystem when they exceed a certain token limit.  
- [大型工具结果驱逐（Large tool result eviction）](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#large-tool-result-eviction)：当工具返回结果超出指定 token 限制时，自动将其转储至文件系统。

- [Conversation history summarization](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#conversation-history-summarization): automatically compress old conversation history when token usage becomes large.  
- [对话历史摘要（Conversation history summarization）](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#conversation-history-summarization)：当 token 使用量过大时，自动压缩过往对话历史。

- [Dangling tool call repair](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#dangling-tool-call-repair): fix message history when tool calls are interrupted or cancelled before execution.  
- [悬空工具调用修复（Dangling tool call repair）](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#dangling-tool-call-repair)：在工具调用被中断或执行前被取消时，修复消息历史记录。

## When to use deepagents vs LangChain, LangGraph

## 何时选用 deepagents，何时选用 LangChain 或 LangGraph？

This is now our third open source library we are investing in, but we believe that all three serve different purposes. In order to distinguish these purposes, we will likely refer `deepagents` as an "agent harness", `langchain` as an "agent framework", and `langgraph` as an agent runtime.

这如今是我们重点投入的第三个开源库；但我们认为，这三个库各自承担着不同的定位与使命。为清晰区分其用途，我们今后很可能将 `deepagents` 称为“智能体运行环境（agent harness）”，将 `langchain` 称为“智能体框架（agent framework）”，而将 `langgraph` 称为“智能体运行时（agent runtime）”。

![](images/doubling-down-on-deepagents/img_002.png)

LangGraph is great if you want to build things that are combinations of workflows and agents.

如果您希望构建融合工作流（workflows）与智能体（agents）能力的应用，LangGraph 是极佳选择。

LangChain is great if you want to use the core agent loop without anything built in, and built all prompts/tools from scratch.

如果您希望直接使用核心智能体循环（core agent loop），不依赖任何预置组件，而是从零开始自行设计所有提示词（prompts）和工具（tools），LangChain 将非常适用。

DeepAgents is great for building more autonomous, long running agents where you want to take advantage of built in things like planning tools, filesystem, etc.

DeepAgents 则非常适合构建更自主、长期运行的智能体——您可充分利用其内置能力，例如规划工具（planning tools）、文件系统（filesystem）等。

They built on top of each other - `deepagents` is built on top of `langchain`'s agent abstraction, which is turn is built on top of `langgraph`'s agent runtime.

它们层层构建——`deepagents` 建立在 `langchain` 的智能体（agent）抽象层之上，而该抽象层又建立在 `langgraph` 的智能体运行时（agent runtime）之上。

![](images/doubling-down-on-deepagents/img_003.png)