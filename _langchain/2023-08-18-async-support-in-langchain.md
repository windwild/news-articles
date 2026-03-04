---
title: "Async Support in LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/async-api/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:55:17.688706996+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

We’re excited to roll out initial asynchronous support in LangChain by leveraging the [asyncio](https://docs.python.org/3/library/asyncio.html?ref=blog.langchain.com) library. Asyncio uses uses coroutines and an event loop to perform non-blocking I/O operations; these coroutines are able to “pause” (`await`) while waiting on their ultimate result and let other routines run in the meantime. To learn more about asyncio and how it compares to multithreading and multiprocessing, check out this [awesome tutorial](https://realpython.com/async-io-python/?ref=blog.langchain.com).

我们很高兴地宣布，LangChain 已初步支持异步（async）功能，其底层基于 [asyncio](https://docs.python.org/3/library/asyncio.html?ref=blog.langchain.com) 库。`asyncio` 利用协程（coroutines）和事件循环（event loop）实现非阻塞 I/O 操作；这些协程可在等待最终结果时主动“暂停”（即执行 `await`），从而让其他协程得以继续运行。若想深入了解 `asyncio` 的工作原理，以及它与多线程（multithreading）和多进程（multiprocessing）的异同，欢迎查阅这篇[精彩教程](https://realpython.com/async-io-python/?ref=blog.langchain.com)。

## Motivation

## 设计动因

Since LangChain applications tend to be fairly I/O and network bound (calling LLM APIs and interacting with data stores), asyncio offers significant advantages by allowing you to run LLMs, chains, and agents concurrently: while one agent is waiting for an LLM call or tool to complete, another one can continue to make progress. Async support in LangChain also allows you to more seamlessly integrate your async chains and agents into frameworks that support asyncio, such as [`FastAPI`](https://fastapi.tiangolo.com/?ref=blog.langchain.com).

由于 LangChain 应用通常严重受限于 I/O 和网络（例如调用大语言模型 API、访问数据存储等），`asyncio` 提供了显著优势：它允许你并发运行大语言模型（LLM）、链（Chain）和智能体（Agent）。例如，当一个智能体正在等待某个 LLM 调用或工具执行完成时，另一个智能体可继续推进任务。此外，LangChain 的异步支持还能让你更顺畅地将异步链和异步智能体集成至原生支持 `asyncio` 的框架中，例如 [`FastAPI`](https://fastapi.tiangolo.com/?ref=blog.langchain.com)。

Check out the async agent [docs](https://python.langchain.com/docs/modules/agents/how_to/async_agent?ref=blog.langchain.com) in particular to see how significantly concurrent execution can speed things up!

特别推荐查看异步智能体的[文档](https://python.langchain.com/docs/modules/agents/how_to/async_agent?ref=blog.langchain.com)，了解并发执行如何大幅加速整体流程！

## Usage

## 使用方式

As a starting point, we’ve implemented async support for:

作为起点，我们已为以下组件实现了异步支持：

`LLM` via `agenerate` (see [docs](https://python.langchain.com/docs/modules/model_io/models/llms/how_to/async_llm?ref=blog.langchain.com)):

`LLM` 类型通过 `agenerate` 方法（参见[文档](https://python.langchain.com/docs/modules/model_io/models/llms/how_to/async_llm?ref=blog.langchain.com)）：

- `OpenAI`

- `OpenAI`

`Chain` via `arun` and `acall` (see [docs](https://python.langchain.com/docs/modules/chains/how_to/async_chain?ref=blog.langchain.com)):

`Chain` 类型通过 `arun` 和 `acall` 方法（参见[文档](https://python.langchain.com/docs/modules/chains/how_to/async_chain?ref=blog.langchain.com)）：

- `LLMChain`
- `LLMChain`

- `LLMMathChain`
- `LLMMathChain`

`Agent` 和 `Tool` 通过 `arun` 调用（参见 [文档](https://python.langchain.com/docs/modules/agents/how_to/async_agent?ref=blog.langchain.com)）：

- `SerpAPIWrapper`
- `LLMMathChain`

## 下一步计划

我们才刚刚开始探索 asyncio。在不久的将来，我们希望新增以下功能：

- 为更多大语言模型（LLM）、链（Chain）和智能体（Agent）工具提供异步支持  
- 支持对单个动作输入并发执行多个工具  
- 为回调处理器（callback handler）提供异步支持  
- 更无缝地集成追踪（tracing）功能  

### 标签

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![评估深度智能体：我们的经验总结](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/async-support-in-langchain/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/async-support-in-langchain/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[![LangChain State of AI 2024 Report](images/async-support-in-langchain/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/async-support-in-langchain/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/async-support-in-langchain/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/async-support-in-langchain/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/async-support-in-langchain/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更轻松的评估](images/async-support-in-langchain/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**LangSmith SDK v0.2：让模型评估更轻松**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写｜阅读时长 4 分钟]

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/async-support-in-langchain/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/async-support-in-langchain/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台正式开启 Beta 测试：为可扩展智能体基础设施提供全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写｜阅读时长 4 分钟]
{% endraw %}
