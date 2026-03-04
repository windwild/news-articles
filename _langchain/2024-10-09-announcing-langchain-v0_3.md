---
render_with_liquid: false
title: "Announcing LangChain v0.3"
source: "LangChain Blog"
url: "https://blog.langchain.com/announcing-langchain-v0-3/"
date: "2024-10-09"
scraped_at: "2026-03-03T07:51:53.545198855+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Today, we’re excited to announce the release of LangChain v0.3 for both Python and JavaScript ecosystems.

今天，我们很高兴地宣布 LangChain v0.3 正式发布，同时支持 Python 和 JavaScript 生态系统。

## What's changed

## 变更内容

### Python

### Python

- 所有包内部均已从 Pydantic 1 升级至 Pydantic 2。用户代码中可直接、完整地使用 Pydantic 2，所有包均原生支持，无需借助 `langchain_core.pydantic_v1` 或 `pydantic.v1` 等兼容桥接模块。
- Pydantic 1 将不再受支持，因其已于 [2024 年 6 月终止维护（End-of-Life）](https://docs.pydantic.dev/2.7/version-policy/?ref=blog.langchain.com#pydantic-v1)。
- Python 3.8 将不再受支持，因其 [终止维护时间为 2024 年 10 月](https://devguide.python.org/versions/?ref=blog.langchain.com)。

**以上是 Python 版本中仅有的破坏性变更（breaking changes）。**

**这些是 Python 版本中唯一的破坏性变更。**

### JavaScript

### JavaScript

- 所有 LangChain 包现将 `@langchain/core` 作为 peer dependency（对等依赖），而非 direct dependency（直接依赖），以帮助避免因 [核心版本冲突](https://js.langchain.com/docs/how_to/installation/?ref=blog.langchain.com#installing-integration-packages) 导致的类型错误。
  - 您现在需显式安装 `@langchain/core`，而不能再依赖其他包内部解析出的版本。
- 回调（callbacks）默认改为后台执行且非阻塞（non-blocking），而非原先的阻塞式（blocking）。
  - 这意味着：若您在无服务器（serverless）环境中使用 LangSmith 进行链路追踪（tracing），则需 [显式 `await` 回调，确保其在函数结束前完成](https://js.langchain.com/docs/how_to/callbacks_serverless/?ref=blog.langchain.com)。
- 已从 `langchain` 主包中移除已弃用的文档加载器（document loader）和自查询（self-query）入口点，转而统一由 [`@langchain/community`](https://www.npmjs.com/package/@langchain/community?ref=blog.langchain.com) 及各集成包提供对应入口。
- 已从 `@langchain/community` 中移除已弃用的 Google PaLM 入口点，改由 [`@langchain/google-vertexai`](https://www.npmjs.com/package/@langchain/google-vertexai?ref=blog.langchain.com) 和 [`@langchain/google-genai`](https://www.npmjs.com/package/@langchain/google-genai?ref=blog.langchain.com) 提供相应入口。
- 已弃用将含 `"type"` 字段的对象作为 [`BaseMessageLike`](https://v03.api.js.langchain.com/types/_langchain_core.messages.BaseMessageLike.html?ref=blog.langchain.com) 使用的方式，转而推荐采用更贴近 OpenAI 风格的 [`MessageWithRole`](https://v03.api.js.langchain.com/types/_langchain_core.messages.MessageFieldWithRole.html?ref=blog.langchain.com)。

## What's new

## 新增特性

We’ve made a number of improvements during the development of LangChain v0.2 that we’d like to highlight here:

我们在 LangChain v0.2 的开发过程中实现了一系列改进，现重点介绍如下：

- 将更多集成（integrations）从 `langchain-community` 迁移至独立的 `langchain-{name}` 专用包中。该迁移为**非破坏性变更**：旧版实现在 `langchain-community` 中仍被保留，但已标记为“已弃用（deprecated）”。此举有助于我们更精细地管理各集成的依赖关系、测试流程与版本控制。您可在 [Python API 参考文档](https://python.langchain.com/api_reference/reference.html?ref=blog.langchain.com#integrations) 和 [JS API 参考文档](https://v03.api.js.langchain.com/index.html?ref=blog.langchain.com) 中查看全部最新集成包。
- 全面重构了集成文档（integration docs）与 API 参考文档。详情请参阅 [此处](https://blog.langchain.com/langchain-integration-docs-revamped/)。
- 简化了工具（tool）的定义与使用方式。详情请参阅 [此处](https://blog.langchain.com/improving-core-tool-interfaces-and-docs-in-langchain/)。
- 新增了与聊天模型（chat models）交互的实用工具：
  - 通用模型构造器（[Python](https://python.langchain.com/docs/how_to/chat_models_universal_init/?ref=blog.langchain.com)，[JS](https://js.langchain.com/docs/how_to/chat_models_universal_init/?ref=blog.langchain.com)）；
  - 消息裁剪、过滤与合并工具（[Python](https://python.langchain.com/docs/how_to/?ref=blog.langchain.com#messages)，[JS](https://js.langchain.com/docs/how_to/?ref=blog.langchain.com#messages)）；
  - 速率限制器（rate limiter）（[Python](https://python.langchain.com/docs/how_to/chat_model_rate_limiting/?ref=blog.langchain.com)）。
- 新增了分发自定义事件（custom events）的能力（[Python](https://python.langchain.com/docs/how_to/callbacks_custom_events/?ref=blog.langchain.com)，[JS](https://js.langchain.com/docs/how_to/callbacks_custom_events/?ref=blog.langchain.com)）。

## How to update your code

## 如何更新您的代码

To help you migrate to the newest version of LangChain we’ve written how-to guides for [Python](https://python.langchain.com/docs/versions/v0_3/?ref=blog.langchain.com#how-to-update-your-code) and [JavaScript](https://js.langchain.com/docs/versions/v0_3/?ref=blog.langchain.com#how-to-update-your-code).

为帮助您迁移到 LangChain 的最新版本，我们已分别为 [Python](https://python.langchain.com/docs/versions/v0_3/?ref=blog.langchain.com#how-to-update-your-code) 和 [JavaScript](https://js.langchain.com/docs/versions/v0_3/?ref=blog.langchain.com#how-to-update-your-code) 编写了迁移指南。

## Documentation

## 文档

LangChain documentation is versioned and documentation for previous versions will remain live at the following URLs: [Python 0.1,](https://python.langchain.com/v0.1?ref=blog.langchain.com) [Python 0.2,](https://python.langchain.com/v0.2?ref=blog.langchain.com) [JS 0.1,](https://js.langchain.com/v0.1/docs/get_started/introduction/?ref=blog.langchain.com) [JS 0.2](https://js.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com)

LangChain 文档采用版本化管理，旧版本文档将持续保留在以下网址：[Python 0.1](https://python.langchain.com/v0.1?ref=blog.langchain.com)、[Python 0.2](https://python.langchain.com/v0.2?ref=blog.langchain.com)、[JS 0.1](https://js.langchain.com/v0.1/docs/get_started/introduction/?ref=blog.langchain.com)、[JS 0.2](https://js.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com)。

## LangGraph

## LangGraph

[LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) is a library for building stateful, multi-actor applications with LLMs, used to create agent and multi-agent workflows. As of LangChain v0.2, [LangGraph](https://blog.langchain.com/langgraph/) has been the recommended way to build agents. LangGraph comes with a pre-built LangGraph object equivalent to the LangChain AgentExecutor which makes it easy to use an out of the box agent solution. See [here](https://python.langchain.com/docs/how_to/migrate_agent/?ref=blog.langchain.dev) for documentation on how to migrate.

[LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 是一个用于基于大语言模型（LLM）构建有状态、多角色应用的库，常用于创建智能体（agent）及多智能体工作流。自 LangChain v0.2 起，[LangGraph](https://blog.langchain.com/langgraph/) 已成为构建智能体的推荐方案。LangGraph 提供了一个预构建的 `LangGraph` 对象，其功能等效于 LangChain 的 `AgentExecutor`，使您能轻松开箱即用地使用智能体解决方案。有关迁移方法的详细文档，请参见[此处](https://python.langchain.com/docs/how_to/migrate_agent/?ref=blog.langchain.dev)。

## What’s coming

## 即将到来的功能

We are expecting to improve LangChain’s multi-modal capabilities during the 0.3 release, and continue our work on improving documentation and reliability of integrations.

在 0.3 版本中，我们将重点增强 LangChain 的多模态能力，并持续推进文档质量与集成模块稳定性的优化工作。

* * *

* * *

We’d love to hear from you on GitHub on all things LangChain v0.3. And if you’re new to LangChain, follow our quickstart guide ( [Python](https://python.langchain.com/docs/tutorials/llm_chain/?ref=blog.langchain.com) [,](https://python.langchain.com/docs/tutorials/llm_chain/?ref=blog.langchain.com) [JavaScript](https://js.langchain.com/docs/tutorials/llm_chain/?ref=blog.langchain.com)) to get started.

我们非常期待您在 GitHub 上就 LangChain v0.3 的所有方面提出反馈与建议。若您是 LangChain 新用户，欢迎参考我们的快速入门指南（[Python](https://python.langchain.com/docs/tutorials/llm_chain/?ref=blog.langchain.com)、[JavaScript](https://js.langchain.com/docs/tutorials/llm_chain/?ref=blog.langchain.com)）开始您的首次体验。