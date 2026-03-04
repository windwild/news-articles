---
title: "Agent Toolkits"
source: "LangChain Blog"
url: "https://blog.langchain.com/agent-toolkits/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:56:15.572803416+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

Today, we're announcing agent toolkits, a new abstraction that allows developers to create agents designed for a particular use-case (for example, interacting with a relational database or interacting with an OpenAPI spec). We hope to continue developing different toolkits that can enable agents to do amazing feats. Toolkits are supported in both [Python](https://github.com/hwchase17/langchain/tree/master/langchain/agents/agent_toolkits?ref=blog.langchain.com) and [TypeScript](https://github.com/hwchase17/langchainjs/tree/main/langchain/src/agents/agent_toolkits?ref=blog.langchain.com).

今天，我们正式发布 **Agent Toolkit（智能体工具包）**——一种全新的抽象机制，使开发者能够构建面向特定应用场景的智能体（例如：与关系型数据库交互，或与 OpenAPI 规范交互）。我们计划持续开发更多类型的工具包，以赋能智能体完成令人惊叹的任务。目前，工具包已在 [Python](https://github.com/hwchase17/langchain/tree/master/langchain/agents/agent_toolkits?ref=blog.langchain.com) 和 [TypeScript](https://github.com/hwchase17/langchainjs/tree/main/langchain/src/agents/agent_toolkits?ref=blog.langchain.com) 中全面支持。

## Agents

## 智能体（Agents）

Quick refresher: what do we mean by agents? And why use them?

快速回顾：我们所说的“智能体”究竟指什么？又为何要使用它们？

By agents we mean a system that uses an LLM to decide what actions to take in a repeated manner, where future decisions are made based on observing the outcome of previous actions. This approach has several benefits. First, it allows combining the LLM with external sources of knowledge or computation (the tools themselves). Second, it allows iterative planning and action taking, useful for more complex tasks where there are a series of things to be done. Finally, it allows for error handling in a robust way, as an agent can observe if an action raised an error and try to correct it. These benefits are evident in the examples below.

所谓“智能体”，是指一类系统：它利用大语言模型（LLM）反复决定应执行哪些操作，且后续决策基于对前序操作结果的观察而作出。该范式具备多重优势：  
第一，它可将 LLM 与外部知识源或计算能力（即各类“工具”本身）有机结合；  
第二，它支持迭代式规划与行动，特别适用于需分步骤完成的复杂任务；  
第三，它能实现稳健的错误处理——当某次操作引发异常时，智能体可主动识别并尝试修正。下文示例将清晰展现这些优势。

## Toolkits

## 工具包（Toolkits）

Toolkits allow you to logically group and initialize a set of tools that share a particular resource (such as a database connection or json object). They can be used to construct an agent for a specific use-case. Here are some examples of toolkits and agents created with them:

工具包允许你以逻辑方式对一组共享特定资源（例如数据库连接或 JSON 对象）的工具进行归类与初始化。它可用于构建面向具体应用场景的智能体。以下是若干工具包及其所构建智能体的示例：

### SQLDatabaseAgent

### SQLDatabaseAgent（SQL 数据库智能体）

This agent builds off of [SQLDatabaseChain](https://python.langchain.com/docs/modules/chains/popular/sqlite?ref=blog.langchain.com), and is able to answer general questions about the database, double check queries before executing them, and recover from errors.

该智能体基于 [SQLDatabaseChain](https://python.langchain.com/docs/modules/chains/popular/sqlite?ref=blog.langchain.com) 构建，能够回答关于数据库的一般性问题，在执行查询前进行双重校验，并在出错时自动恢复。

Using the `SQLDatabaseToolkit`, the agent retrieves tables from the DB, picks relevant tables, gets their table information, creates and checks a query to answer the question, and repeat parts of this process when an error is encountered.

借助 `SQLDatabaseToolkit`，该智能体可从数据库中获取表列表、筛选相关表、读取其元数据信息、生成并校验用于回答问题的 SQL 查询；一旦执行过程中发生错误，便会重复其中部分流程。

To see this in action, look at the example below. The agent is asked a question about the [Chinook database](https://github.com/lerocha/chinook-database?ref=blog.langchain.com); to do this, it asks for the list of tables, then the table metadata, then executes the query. It initially encounters an error caused by joining on a column that doesn't exist. (See full [notebook](https://python.langchain.com/docs/modules/agents/toolkits/sql_database?ref=blog.langchain.com), TypeScript example [here](https://hwchase17.github.io/langchainjs/docs/modules/agents/agent_toolkits/sql?ref=blog.langchain.com)).

请参见下方示例：智能体被要求回答一个关于 [Chinook 数据库](https://github.com/lerocha/chinook-database?ref=blog.langchain.com) 的问题。为此，它首先请求表列表，继而获取各表的元数据，最后执行查询。在首次尝试中，它因试图基于一个不存在的列进行 JOIN 而报错。（完整 [Jupyter Notebook 示例](https://python.langchain.com/docs/modules/agents/toolkits/sql_database?ref=blog.langchain.com)，TypeScript 版本示例见 [此处](https://hwchase17.github.io/langchainjs/docs/modules/agents/agent_toolkits/sql?ref=blog.langchain.com)）

![](images/agent-toolkits/img_001.png)

![](images/agent-toolkits/img_001.png)

After double checking and rewriting the query, it is able to arrive at the final answer:

经过反复核对并重写查询后，该智能体能够得出最终答案：

![](images/agent-toolkits/img_002.png)

![](images/agent-toolkits/img_002.png)

### OpenAPI Agent

### OpenAPI 智能体

This agent is able to interact with an OpenAPI spec and make a correct API request based on the information it has gathered from the spec.

该智能体能够解析 OpenAPI 规范，并基于从中提取的信息，构造并发送正确的 API 请求。

In the below example, we are using the OpenAPI spec for the OpenAI API, which you can find [here](https://github.com/openai/openai-openapi/blob/master/openapi.yaml?ref=blog.langchain.com). Using the `OpenAPIToolkit`, the agent is able to sift through the JSON representation of the spec (see JSON agent), find the required base URL, path, required parameters for  a `POST` request to the `/completions` endpoint, then make the request. (See full [notebook](https://python.langchain.com/docs/modules/agents/toolkits/openapi?ref=blog.langchain.com), TypeScript example [here](https://hwchase17.github.io/langchainjs/docs/modules/agents/agent_toolkits/openapi?ref=blog.langchain.com)).

在以下示例中，我们使用的是 OpenAI API 的 OpenAPI 规范，您可在此处获取：[链接](https://github.com/openai/openai-openapi/blob/master/openapi.yaml?ref=blog.langchain.com)。借助 `OpenAPIToolkit`，该智能体能够遍历规范的 JSON 表示（参见“JSON 智能体”），定位所需的基地址（base URL）、路径（path），以及向 `/completions` 端点发起 `POST` 请求所必需的参数，最后完成请求。（完整示例请参阅 [Jupyter Notebook](https://python.langchain.com/docs/modules/agents/toolkits/openapi?ref=blog.langchain.com)，TypeScript 示例见 [此处](https://hwchase17.github.io/langchainjs/docs/modules/agents/agent_toolkits/openapi?ref=blog.langchain.com)）

![](images/agent-toolkits/img_003.png)

![](images/agent-toolkits/img_003.png)

### Other agent toolkit examples:

### 其他智能体工具包示例：

- [JSON agent](https://python.langchain.com/docs/modules/agents/toolkits/json?ref=blog.langchain.com) \- an agent capable of interacting with a large JSON blob.

- [JSON 智能体](https://python.langchain.com/docs/modules/agents/toolkits/json?ref=blog.langchain.com) —— 一种能够与大型 JSON 数据块交互的智能体。

- [Vectorstore agent](https://python.langchain.com/docs/modules/agents/toolkits/vectorstore?ref=blog.langchain.com) \- an agent capable of interacting with vector stores.

- [向量数据库智能体（Vectorstore 智能体）](https://python.langchain.com/docs/modules/agents/toolkits/vectorstore?ref=blog.langchain.com) —— 一种能够与向量数据库交互的智能体。

- [Python agent](https://python.langchain.com/docs/modules/agents/toolkits/python?ref=blog.langchain.com) \- an agent capable of producing and executing Python code.

- [Python 智能体](https://python.langchain.com/docs/modules/agents/toolkits/python?ref=blog.langchain.com) —— 一种能够生成并执行 Python 代码的智能体。

- [Pandas DataFrame agent](https://python.langchain.com/docs/modules/agents/toolkits/pandas?ref=blog.langchain.com) \- an agent capable of question-answering over Pandas dataframes, builds on top of the Python agent.

- [Pandas DataFrame 智能体](https://python.langchain.com/docs/modules/agents/toolkits/pandas?ref=blog.langchain.com) —— 一种支持对 Pandas DataFrame 进行问答的智能体，构建于 Python 智能体之上。

- [CSV agent](https://python.langchain.com/docs/modules/agents/toolkits/csv?ref=blog.langchain.com) \- an agent capable of question answering over CSVs, builds on top of the Pandas DataFrame agent.

- [CSV 智能体](https://python.langchain.com/docs/modules/agents/toolkits/csv?ref=blog.langchain.com) —— 一种支持对 CSV 文件进行问答的智能体，构建于 Pandas DataFrame 智能体之上。

## Up Next

## 下一步

We're just getting started with agent toolkits and plan on adding many more in the future. We believe that interacting with tools and utilities in an agentic manner opens up many exciting possibilities. If there are other use-cases you want to see, please reach out!

我们才刚刚开始构建智能体工具包，未来计划添加更多功能。我们相信，以智能体（agentic）方式与各类工具和实用程序进行交互，将开启诸多令人振奋的可能性。如果您有其他希望看到的应用场景，欢迎随时联系我们！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/agent-toolkits/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/agent-toolkits/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/agent-toolkits/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/agent-toolkits/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/agent-toolkits/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024年人工智能现状》报告](images/agent-toolkits/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/agent-toolkits/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/agent-toolkits/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/agent-toolkits/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/agent-toolkits/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/agent-toolkits/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的新部署选项](images/agent-toolkits/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 正在公测：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[作者：LangChain](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
