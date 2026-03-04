---
title: "Workflow 4.1 Beta: Event-sourced architecture - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/workflow-event-sourcing"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:38.657715351+00:00"
language: "en-zh"
translated: true
description: "Workflow 4.1 Beta now stores every state change as an event and reconstructs workflow state by replaying them, so failures can be recovered."
---
&#123;% raw %}

Feb 3, 2026

2026 年 2 月 3 日

[Workflow 4.1 Beta](https://github.com/vercel/workflow/releases/tag/workflow%404.1.0-beta.51) changes how workflows track state internally. Instead of updating records in place, every state change is now stored as an event, and current state is reconstructed by replaying the log. This release also adds support for provider-executed tools and higher throughput.

[Workflow 4.1 Beta](https://github.com/vercel/workflow/releases/tag/workflow%404.1.0-beta.51) 改变了工作流在内部追踪状态的方式。过去是就地更新记录，而现在每次状态变更均以事件形式存储，并通过重放事件日志来重构当前状态。本次发布还新增了对由 Provider 执行的工具（provider-executed tools）的支持，并提升了吞吐量。

## **What event sourcing means for workflows**

## **事件溯源对工作流的意义**

[Event sourcing](https://useworkflow.dev/docs/how-it-works/event-sourcing) is a persistence pattern where state changes are stored as a sequence of events rather than by updating records in place. Instead of storing "this run is completed," the system stores "run\_created, then run\_started, then run\_completed" and reconstructs the current state by replaying those events.

[事件溯源（Event Sourcing）](https://useworkflow.dev/docs/how-it-works/event-sourcing) 是一种持久化模式：状态变更被记录为一系列事件，而非通过就地更新记录实现。系统不再直接存储“该运行已完成”这样的快照，而是记录“run_created → run_started → run_completed”这一事件序列，并通过重放这些事件来重构当前状态。

In Workflow 4.1, runs, steps, and hooks are no longer mutable database records. They're materializations of an append-only event log. Each event captures a timestamp and context, and the runtime derives current state by processing events in order.

在 Workflow 4.1 中，运行（runs）、步骤（steps）和钩子（hooks）不再是可变的数据库记录，而是仅追加（append-only）事件日志的物化视图（materializations）。每个事件均包含时间戳与上下文信息，运行时（runtime）则按顺序处理事件，从而推导出当前状态。

This architecture makes workflows more reliable in three ways:

该架构从以下三方面显著提升了工作流的可靠性：

- **Self-healing**: If a queue message is lost or a race condition occurs, replaying the workflow route detects missing state and re-enqueues the necessary messages. Old runs required manual intervention to recover from queue downtime; new runs recover automatically.

- **自愈能力（Self-healing）**：若队列消息丢失或发生竞态条件（race condition），重放工作流路径即可检测到缺失的状态，并自动重新入队所需消息。旧版运行在队列宕机后需人工干预恢复；新版运行则可自动恢复。

- **Complete audit trail**: The event log lets you replay the exact sequence that led to any state, which makes debugging distributed workflows much easier.

- **完整的审计追踪（Complete audit trail）**：事件日志允许你精确重放导致任一状态的完整事件序列，极大简化了分布式工作流的调试过程。

- **Consistency**: Events are append-only, so partial failures during a write can't leave entities in an inconsistent state. The event log is the single source of truth.

- **一致性（Consistency）**：事件日志仅支持追加写入，因此写入过程中的部分失败不会导致实体处于不一致状态。事件日志即为唯一可信数据源（single source of truth）。

For a deeper look at the event model, including state machine diagrams for run, step, and hook lifecycles, see the [Event Sourcing documentation](https://useworkflow.dev/docs/how-it-works/event-sourcing).

如需深入了解事件模型（包括运行、步骤及钩子生命周期对应的状态机图），请参阅 [事件溯源文档（Event Sourcing documentation）](https://useworkflow.dev/docs/how-it-works/event-sourcing)。

## **Other updates**

## **其他更新**

- **Improved throughput**: The workflow queue system now processes many thousands of steps per second. When dependencies allow, multiple steps execute in parallel.

- **吞吐量提升**：工作流队列系统现可每秒处理数千个步骤；在依赖关系允许的情况下，多个步骤可并行执行。

- **Provider-executed tools**: `@workflow/ai` now supports provider-executed tools like Google Search and WebSearch, which run on the model provider's infrastructure rather than in your workflow.

- **由模型提供商执行的工具**：`@workflow/ai` 现已支持 Google Search 和 WebSearch 等由模型提供商执行的工具，这些工具运行于模型提供商的基础设施之上，而非您的工作流中。

- **NestJS support**: The new `@workflow/nest` package adds build support for NestJS applications, handling dependency injection patterns so workflows integrate with existing NestJS services.

- **NestJS 支持**：全新 `@workflow/nest` 包为 NestJS 应用提供构建支持，自动处理依赖注入模式，使工作流可无缝集成现有 NestJS 服务。

- **Top-level** **`using`** **declarations**: The SWC plugin now supports the TC39 Explicit Resource Management proposal inside step and workflow functions, enabling automatic resource cleanup.

- **顶层** **`using`** **声明**：SWC 插件现已在步骤（step）和工作流（workflow）函数内部支持 TC39 显式资源管理（Explicit Resource Management）提案，实现资源的自动清理。

- **Custom class serialization**: Client mode now supports custom class serialization, with a `classes` object in `manifest.json` that declares serializable types.

- **自定义类序列化**：客户端模式现已支持自定义类序列化，您可在 `manifest.json` 中通过 `classes` 对象声明可序列化的类型。

- Fixed double-serialization of tool output in `@workflow/ai`

- 已修复 `@workflow/ai` 中工具输出被重复序列化的问题。

Learn more about [Workflow](https://useworkflow.dev/) or [get started](https://useworkflow.dev/docs/getting-started) with your first workflow.

了解更多关于 [Workflow](https://useworkflow.dev/) 的信息，或立即 [开始使用](https://useworkflow.dev/docs/getting-started) 您的第一个工作流。
&#123;% endraw %}
