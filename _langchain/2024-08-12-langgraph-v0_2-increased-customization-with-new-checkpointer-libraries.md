---
title: "LangGraph v0.2: Increased customization with new checkpointer libraries"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-v0-2/"
date: "2024-08-12"
scraped_at: "2026-03-03T07:55:22.824082875+00:00"
language: "en-zh"
translated: true
description: "LangGraph v0.2 includes new checkpointer libraries for increased customization — including a SQLite checkpointer for local workflows and an optimized Postgres checkpointer to take your app to produ..."
---
&#123;% raw %}

Today, we’re excited to announce the stable release of LangGraph v0.2, which introduces a new ecosystem of LangGraph checkpointer libraries. These simplify the creation and customization of checkpointers, which allows users to build more resilient LLM applications with smooth session memory, robust error recovery, and human-in-the-loop features.

今天，我们很高兴地宣布 LangGraph v0.2 的正式版发布，该版本引入了一套全新的 LangGraph 检查点（checkpointer）库生态系统。这些库大幅简化了检查点器的创建与定制过程，使用户能够构建更具韧性的大语言模型（LLM）应用，具备流畅的会话记忆、强大的错误恢复能力以及“人在回路中”（human-in-the-loop）功能。

## Why we built LangGraph v0.2

## 为何推出 LangGraph v0.2

One of the key pillars of LangGraph is its built-in persistence layer, implemented through checkpointers. When you use a checkpointer with a graph, you can interact with and manage the graph's state. The checkpointer saves a _checkpoint_ of the graph state at each step, enabling several powerful capabilities, including:

LangGraph 的核心支柱之一，是其通过检查点器（checkpointer）实现的内置持久化层。当您将检查点器与图（graph）配合使用时，即可与图的状态进行交互并对其进行管理。检查点器会在每一步执行后保存图状态的一个 _检查点（checkpoint）_，从而支持以下多项强大能力：

- **Session memory**: Store history (checkpoints) of user interactions and resume from a saved checkpoint in follow up interactions  
- **会话记忆**：存储用户交互的历史记录（即检查点），并在后续交互中从已保存的检查点恢复执行

- **Error recovery**: Recover from failures at any given step in the graph execution by continuing from the last successful step checkpoint  
- **错误恢复**：在图执行过程中任意步骤发生故障时，均可从上一个成功步骤所保存的检查点继续执行

- **Human-in-the-loop**: Implement tool approval, wait for human input, edit agent actions and more  
- **人在回路中**：实现工具调用审批、等待人工输入、编辑智能体（agent）操作等更多交互模式

- **Time travel**: Edit graph state at any point in the history of execution and create an alternative execution from that point in time (i.e. fork the thread)  
- **时间穿梭（Time Travel）**：在执行历史中的任意时刻编辑图状态，并从此刻起生成一条替代执行路径（即“分叉线程”）

Since the early days of LangGraph, we’ve designed checkpointing to be database-agnostic, allowing users to implement their own checkpointer adapters for their database of choice.

自 LangGraph 诞生之初，我们就将其检查点机制设计为数据库无关（database-agnostic）架构，使用户可自由为其偏好的数据库实现专属的检查点适配器。

Since the [LangGraph v0.1 release,](https://blog.langchain.com/langgraph-cloud/) we've seen a lot of interest from the community in creating checkpointers for many popular databases like Postgres, Redis, and MongoDB. However, there was no clear blueprint for the users to implement their own, custom checkpointers.

自 [LangGraph v0.1 发布以来](https://blog.langchain.com/langgraph-cloud/)，社区对为 PostgreSQL、Redis 和 MongoDB 等主流数据库开发检查点器表现出极大热情。然而，此前一直缺乏清晰、统一的实现范式，用户难以高效构建自己的定制化检查点器。

## New checkpointer libraries in LangGraph

## LangGraph 中新增的检查点器库

With LangGraph v0.2, we’re making it easier to create new checkpointers. We’ve also laid the foundation to foster a community-maintained ecosystem of checkpointer implementations.

借助 LangGraph v0.2，我们显著降低了新检查点器的开发门槛；同时，也为构建一个由社区共同维护的检查点器实现生态体系打下了坚实基础。

We now have a suite of new, dedicated checkpointer libraries:

目前，我们已推出一系列全新、专用的检查点器库：

- `langgraph_checkpoint` : The base interface for checkpointer savers (`BaseCheckpointSaver` ) and serialization/deserialization interface (`SerializationProtocol`). Includes in-memory checkpointer implementation (`MemorySaver`) for experimentation.  
- `langgraph_checkpoint`：检查点保存器（`BaseCheckpointSaver`）及序列化/反序列化接口（`SerializationProtocol`）的基础定义。内含用于实验的内存型检查点器实现（`MemorySaver`）

- `langgraph_checkpoint_sqlite` : An implementation of LangGraph checkpointer that uses SQLite database. Ideal for experimentation and local workflows.  
- `langgraph_checkpoint_sqlite`：基于 SQLite 数据库的 LangGraph 检查点器实现，适用于实验性开发和本地工作流

- `langgraph_checkpoint_postgres` : Our advanced checkpointer that we wrote and optimized for Postgres in LangGraph Cloud is now open-sourced and available to the community to build upon. Ideal for using in production.  
- `langgraph_checkpoint_postgres`：我们在 LangGraph Cloud 中专为 PostgreSQL 编写并深度优化的高级检查点器，现已开源，供社区直接使用或在其基础上进行二次开发。适用于生产环境

Checkpointer implementations can be used interchangeably, which lets users tailor their stateful LangGraph applications to their custom needs.

检查点存储器（Checkpointer）的各类实现可以互换使用，使用户能够根据自身定制化需求，灵活适配其有状态的 LangGraph 应用。

### LangGraph Postgres Checkpointer for production-ready apps

### 面向生产环境就绪应用的 LangGraph PostgreSQL 检查点存储器

`langgraph_checkpoint_postgres` implementation can serve as a blueprint for community members to implement their own optimized, production-ready checkpointers for their favorite database. Postgres checkpointer implements a number of optimizations both on the write-, as well as read-side.

`langgraph_checkpoint_postgres` 实现可作为社区成员的参考模板，用于为其偏爱的数据库开发经过优化、面向生产环境就绪的检查点存储器。PostgreSQL 检查点存储器在写入端和读取端均实现了多项性能优化。

**Write-side optimizations:**

**写入端优化：**

- We're making use of Postgres pipeline mode to reduce database roundtrips  
- 我们利用 PostgreSQL 的流水线（pipeline）模式，以减少数据库往返通信次数。

- We're storing each channel value separately and versioned so that each new checkpoint only stores the values that changed.  
- 我们将每个通道（channel）的值单独存储并进行版本化管理，从而确保每次新建检查点时仅保存发生变更的值。

**Read-side optimizations:**

**读取端优化：**

- We're making use of a cursor for the list endpoint in order to efficiently fetch long thread histories when needed.  
- 我们在列表（list）接口中采用游标（cursor）机制，以便在需要时高效获取超长对话线程历史。

## Getting started on LangGraph v0.2

## 开始使用 LangGraph v0.2

Since LangGraph checkpointer libraries are implemented as namespace packages, you can import checkpointer interfaces and implementations the same way as before, using:

由于 LangGraph 检查点存储器库是以命名空间包（namespace package）方式实现的，您可沿用此前的方式导入检查点存储器的接口与具体实现，例如：

- `from langgraph.checkpoint.base import BaseCheckpointSaver`  
- `from langgraph.checkpoint.base import BaseCheckpointSaver`

- `from langgraph.checkpoint.memory import MemorySaver`  
- `from langgraph.checkpoint.memory import MemorySaver`

- `from langgraph.checkpoint.sqlite import SqliteSaver`  
- `from langgraph.checkpoint.sqlite import SqliteSaver`

- `from langgraph.checkpoint.postgres import PostgresSaver`  
- `from langgraph.checkpoint.postgres import PostgresSaver`

Since SQLite and Postgres checkpointers are provided via separate libraries, you will need to install them using `pip install langgraph-checkpoint-sqlite` or `pip install langgraph-checkpoint-postgres`.

SQLite 和 Postgres 检查点存储器（checkpointer）通过独立的库提供，因此您需要分别使用 `pip install langgraph-checkpoint-sqlite` 或 `pip install langgraph-checkpoint-postgres` 进行安装。

LangGraph checkpoint libraries will follow semantic versioning (starting with current release of 1.0), and any breaking changes in the main library will result in a major version bump for those libraries. For example, the next breaking change in `langgraph_checkpoint` will result in 2.0 version, and you can expect the checkpointer implementations (e.g.,`langgraph_checkpoint_sqlite`) to also be updated to 2.0 to follow that change.

LangGraph 检查点库将遵循语义化版本控制（当前起始版本为 1.0），主库中任何不兼容的变更都将导致这些检查点库同步升级主版本号。例如，`langgraph_checkpoint` 的下一次不兼容变更将发布为 2.0 版本，而对应的检查点实现（如 `langgraph_checkpoint_sqlite`）也将同步更新至 2.0 版本以保持兼容。

To get started, follow this guide on [how to use checkpointers in LangGraph](https://langchain-ai.github.io/langgraph/how-tos/persistence/?ref=blog.langchain.com). You can also check out our documentation, including a [reference](https://langchain-ai.github.io/langgraph/reference/checkpoints/?ref=blog.langchain.com) and [overview](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#send) of checkpointers.

入门指南，请参阅 [如何在 LangGraph 中使用检查点存储器](https://langchain-ai.github.io/langgraph/how-tos/persistence/?ref=blog.langchain.com)。您也可查阅我们的完整文档，包括检查点存储器的 [API 参考](https://langchain-ai.github.io/langgraph/reference/checkpoints/?ref=blog.langchain.com) 和 [概念概述](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#send)。

## Run agents at scale with LangGraph Cloud

## 使用 LangGraph Cloud 大规模运行智能体（Agents）

To complement the LangGraph framework, we also have a new runtime, [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com), which provides infrastructure purpose-built for deploying agents at scale.

作为 LangGraph 框架的补充，我们还推出了全新的运行时平台——[LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com)，专为大规模部署智能体应用而构建的基础设施。

LangGraph Cloud does the heavy lifting for your agentic application, removing the maintenance work for custom checkpointers while adding fault-tolerant scalability. It gracefully manages horizontally-scaling task queues, servers, and includes our robust Postgres checkpointer out-of-the-box to help you handle many concurrent users and efficiently store large states and threads.

LangGraph Cloud 承担了您智能体应用中的繁重工作：既免除了自定义检查点存储器的运维负担，又提供了容错性强、可弹性伸缩的能力。它能优雅地管理水平扩展的任务队列与服务节点，并开箱即用地集成我们高可靠的 Postgres 检查点存储器，助您轻松应对大量并发用户，高效存储庞大的状态数据与对话线程（threads）。

In addition, LangGraph Cloud supports real-world interaction patterns beyond streaming and human-in-the-loop. These include double-texting to handle new user inputs on currently-running threads of the graph, async background jobs for long-running tasks, and cron jobs.

此外，LangGraph Cloud 支持超越流式响应与人工介入（human-in-the-loop）等基础模式的现实世界交互范式，例如：  
- **双消息机制（double-texting）**：在图模型当前正在运行的线程中，无缝接收并处理新的用户输入；  
- **异步后台任务（async background jobs）**：用于执行耗时较长的任务；  
- **定时任务（cron jobs）**：按计划自动触发指定操作。

Lastly, you can easily deploy your agentic app and collaborate in LangGraph Studio, a playground-like space for visualizing and debugging agent trajectories, with LangGraph Cloud. The [LangGraph Studio desktop app](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/) is now also available for all LangSmith users to try for free.

最后，您可通过 LangGraph Cloud，在类 Playground 的可视化开发环境——LangGraph Studio 中，便捷地部署智能体应用并开展团队协作。LangGraph Studio 专注于智能体行为轨迹（trajectories）的可视化与调试。目前，[LangGraph Studio 桌面版应用](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/) 已面向所有 LangSmith 用户免费开放试用。

**LangGraph Cloud is now available in beta for all LangSmith users on Plus or Enterprise plans. Try it out today for free** [**by signing up for LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com) **.**

**LangGraph Cloud 当前已面向所有订阅 LangSmith Plus 或 Enterprise 计划的用户开放 Beta 测试。立即免费体验！** [**注册 LangSmith 即可开始使用**](https://smith.langchain.com/?ref=blog.langchain.com) **。**

## Additional changes in LangGraph v0.2

## LangGraph v0.2 中的其他更新

LangGraph v0.2 contains many improvements, and we've designed it to be largely backwards compatible. Below is a list of breaking changes and deprecations in this latest version.

LangGraph v0.2 包含诸多改进，我们已将其设计为在很大程度上保持向后兼容。以下是本版本中的破坏性变更（breaking changes）与弃用项（deprecations）列表。

### Breaking changes

### 破坏性变更

LangGraph v0.2 introduces several breaking changes:

LangGraph v0.2 引入了若干破坏性变更：

- `thread_ts` 和 `parent_ts` 已分别重命名为 `checkpoint_id` 和 `parent_checkpoint_id`（通过 `langgraph_checkpoint==1.0.0` 实现）。  
  - 注意：LangGraph 的 checkpointers 在配置（config）中若接收到 `thread_ts`，仍将识别并将其视为 `checkpoint_id`。
- 由于采用了命名空间包（namespace packages），此前支持的重新导出式导入（如 `from langgraph.checkpoint import BaseCheckpointSaver`）不再可用；请改用 `from langgraph.checkpoint.base import BaseCheckpointSaver`。
- SQLite checkpointers 已迁移至独立库，因此您需单独安装：`pip install langgraph-checkpoint-sqlite`。

### Deprecations

### 弃用项

In LangGraph v0.2, we've removed:

在 LangGraph v0.2 中，我们已移除以下内容：

- `langgraph.prebuilt.chat_agent_executor.create_function_calling_executor`。我们建议您改用 `langgraph.prebuilt.chat_agent_executor.create_react_agent`。
- `langgraph.prebuilt.agent_executor`。我们建议您改用 `langgraph.prebuilt.chat_agent_executor.create_react_agent`。

## Conclusion

## 总结

We are incredibly grateful to our community and users for pushing us and building with LangGraph to improve agent reliability. We hope that with LangGraph v0.2, you’ll find it easier to build and maintain your own checkpointer implementations– and we’re excited to see all the apps that you create.

我们由衷感谢社区成员与广大用户不断推动我们前进，并基于 LangGraph 构建应用，共同提升智能体（agent）的可靠性。我们希望 LangGraph v0.2 能让您更轻松地开发与维护自定义的 checkpointer 实现——同时，我们也热切期待看到您所创造的各类精彩应用。

**As you try out LangGraph v0.2, we'd love to hear your feedback at hello@langchain.dev. You can also learn more from these additional resources:**

**欢迎您在试用 LangGraph v0.2 的过程中，将反馈发送至 hello@langchain.dev。您还可通过以下额外资源进一步了解相关信息：**

- [LangGraph docs](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.dev)  
- [LangGraph 文档](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.dev)

- [LangGraph webpage (with FAQs)](https://www.langchain.com/langgraph?ref=blog.langchain.com)  
- [LangGraph 官网（含常见问题解答）](https://www.langchain.com/langgraph?ref=blog.langchain.com)
&#123;% endraw %}
