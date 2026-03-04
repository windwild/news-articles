---
title: "Introducing the LangGraph Functional API"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-the-langgraph-functional-api/"
date: "2025-01-29"
scraped_at: "2026-03-03T07:42:19.575344400+00:00"
language: "en-zh"
translated: true
---
{% raw %}

Have you ever wanted to take advantage of LangGraph's core features like **human-in-the-loop**, **persistence/memory**, and **streaming** without having to explicitly define a graph?

你是否曾希望在不显式定义图（graph）的情况下，直接利用 LangGraph 的核心功能，例如 **人工介入（human-in-the-loop）**、**持久化/记忆（persistence/memory）** 和 **流式处理（streaming）**？

We're excited to announce the release of the **Functional API** for LangGraph, available in [Python](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/functional_api/?ref=blog.langchain.com).

我们很高兴地宣布 LangGraph **函数式 API（Functional API）** 正式发布，现已支持 [Python](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com) 和 [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/functional_api/?ref=blog.langchain.com)。

The functional API allows you to leverage LangGraph features using a more traditional programming paradigm, making it easier to build AI workflows that incorporate **human-in-the-loop** interactions, **short-term** and **long-term memory**, and **streaming** capabilities.

函数式 API 使你能够以更传统的编程范式使用 LangGraph 的各项功能，从而更轻松地构建融合了 **人工介入（human-in-the-loop）** 交互、**短期记忆** 与 **长期记忆**，以及 **流式处理能力** 的 AI 工作流。

The **Functional API** consists of two decorators -- `entrypoint` and `task` \-\- which allow you to define workflows using standard functions, and use regular loops and conditionals to control the flow of execution. This makes it easy to adopt LangGraph's features in your existing applications without having to restructure your code.

**函数式 API** 包含两个装饰器——`entrypoint` 和 `task`，它们允许你使用标准函数定义工作流，并借助常规的循环与条件语句控制执行流程。这使得你无需重构现有代码，即可在已有应用中便捷地集成 LangGraph 的各项能力。

This API is complementary to the **Graph API** (StateGraph) and can be used in conjunction with it as both APIs use the same underlying runtime. This allows you to mix and match the two paradigms to create complex workflows that leverage the best of both worlds.

该 API 与 **图式 API（Graph API，即 StateGraph）** 互为补充；由于二者共享同一底层运行时，因此可协同使用。你可以灵活组合这两种范式，构建兼具两者优势的复杂工作流。

In this post, we'll see how to leverage LangGraph's key features using the **Functional API**.

本文将介绍如何通过 **函数式 API** 来运用 LangGraph 的关键特性。

## Building Blocks

## 基础构件

The Functional API uses two primitives to define workflows:

函数式 API 使用两种基础构件来定义工作流：

- **Entrypoint**: A starting point for a workflow that encapsulates workflow logic and manages execution flow, including handling long-running **tasks** and interrupts.

- **入口点（Entrypoint）**：工作流的起始节点，封装工作流逻辑并管理执行流程，包括处理长时间运行的 **任务（tasks）** 和中断（interrupts）。

- **Task**: A discrete unit of work, such as an API call or data processing step, that can be executed asynchronously from within an **entrypoint**. Invoking a task returns a future-like object, which can be awaited to obtain the result or resolved synchronously.

- **任务（Task）**：一个独立的工作单元（例如一次 API 调用或数据处理步骤），可在 **入口点（entrypoint）** 内异步执行。调用任务将返回一个类 Future 对象，可通过 `await` 获取结果，也可同步解析。

## Human-in-the-Loop

## 人工介入（Human-in-the-Loop）

Imagine you're building a content generation app that helps users create essays. Before finalizing the output, your users need to review and approve the draft.

想象你正在开发一款内容生成应用，帮助用户撰写论文。在最终确定输出前，用户需要审阅并批准初稿。

Here’s how it could work: the AI writes a draft, then pauses for user feedback. Once they approve or reject it, the system picks up right where it left off—no need to rerun the whole workflow or wrestle with complex state management.

其工作方式如下：AI 先撰写初稿，随后暂停以等待用户反馈；一旦用户批准或拒绝该初稿，系统便从暂停处无缝继续执行——无需重新运行整个工作流，也无需手动处理复杂的状态管理。

Without the right tools, you'd have to build a persistence layer and pipeline logic yourself. But with LangGraph's human-in-the-loop features and Functional API, it's straightforward. With the `interrupt` function, you can pause the workflow _indefinitely_ while waiting for user input. When user input has been collected you can resume using the `Command` primitive, skipping previously completed tasks thanks to task result persistence.

若缺乏合适的工具，你将不得不自行构建持久化层与流水线逻辑。但借助 LangGraph 的“人在环中”（human-in-the-loop）功能和函数式 API（Functional API），这一过程变得极为简单：通过 `interrupt` 函数，你可无限期暂停工作流，静候用户输入；待用户输入收集完毕后，即可使用 `Command` 原语恢复执行——得益于任务结果的持久化机制，此前已完成的任务将被自动跳过。

```python
from langgraph.checkpoint.memory import MemorySaver
from langgraph.func import entrypoint, task
from langgraph.types import interrupt

@task
def write_essay(topic: str) -> str:
  """Write an essay about the given topic."""
  time.sleep(1) # This is a placeholder for a long-running task.
  return f"An essay about topic: {topic}"

@entrypoint(checkpointer=MemorySaver())
def workflow(topic: str) -> dict:
  """A simple workflow that writes an essay and asks for a review."""
  essay = write_essay("cat").result()
  is_approved = interrupt({
    # Any json-serializable payload provided to interrupt as argument.
    # It will be surfaced on the client side as an Interrupt when streaming data
    # from the workflow.
    "essay": essay, # The essay we want reviewed.
    # We can add any additional information that we need.
    # For example, introduce a key called "action" with some instructions.
    "action": "Please approve/reject the essay",
  })

  return {
    "essay": essay, # The essay that was generated
    "is_approved": is_approved, # Response from HIL
  }
```

```python
from langgraph.checkpoint.memory import MemorySaver
from langgraph.func import entrypoint, task
from langgraph.types import interrupt

@task
def write_essay(topic: str) -> str:
  """Write an essay about the given topic."""
  time.sleep(1) # This is a placeholder for a long-running task.
  return f"An essay about topic: {topic}"

@entrypoint(checkpointer=MemorySaver())
def workflow(topic: str) -> dict:
  """A simple workflow that writes an essay and asks for a review."""
  essay = write_essay("cat").result()
  is_approved = interrupt({
    # 传入 `interrupt` 的任意 JSON 可序列化载荷。
    # 当从工作流流式传输数据时，该载荷将在客户端以 `Interrupt` 形式暴露。
    "essay": essay, # 待审阅的论文初稿。
    # 我们可添加任意所需的附加信息。
    # 例如，引入一个名为 `"action"` 的键，并附带相关指令。
    "action": "请批准或拒绝该论文",
  })

  return {
    "essay": essay, # 已生成的论文
    "is_approved": is_approved, # 来自“人在环中”（HIL）环节的响应
  }
```

An example workflow that writes a draft of an essay and pauses for human review.

一个撰写论文初稿并在关键节点暂停、等待人工审阅的工作流示例。

**Why this matters**: A human-in-the-loop (or “on-the-loop”) workflow blends human input into automated processes, allowing for review, validation, or corrections where they matter most. This approach is invaluable in LLM-based applications, where occasional inaccuracies can arise. For low-error-tolerance use cases—like compliance, decision-making, or content creation—human involvement ensures reliability by enabling reviews, overrides, or adjustments at critical stages.

**为何这至关重要**：“人在环中”（或称“环上人控”，on-the-loop）工作流将人类输入有机融入自动化流程，在最关键环节实现人工审核、校验或修正。该范式在基于大语言模型（LLM）的应用中尤为宝贵——因为 LLM 偶尔会产生不准确内容。在容错率极低的场景中（如合规审查、关键决策支持或专业内容创作），人工介入能显著提升系统可靠性，确保在核心环节及时开展审核、覆盖或调整。

- For a more detailed example of the workflow above please review the Functional API docs ( [Python](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com#example) and [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/functional_api/?ref=blog.langchain.com#example)).

- 如需上述工作流更详尽的示例，请参阅函数式 API 文档（[Python 版](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com#example) 和 [JavaScript 版](https://langchain-ai.github.io/langgraphjs/concepts/functional_api/?ref=blog.langchain.com#example)）。

- For an overview of human-in-the-loop patterns, refer to the conceptual documentation ( [Python](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/human_in_the_loop/?ref=blog.langchain.com)).

- 如需了解“人在环中”模式的整体概览，请查阅概念性文档（[Python 版](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com) 和 [JavaScript 版](https://langchain-ai.github.io/langgraphjs/concepts/human_in_the_loop/?ref=blog.langchain.com)）。

- For more information about persistence, see: [Python](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com), [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/persistence/?ref=blog.langchain.com).

- 关于持久化（persistence）的更多说明，请参阅：[Python 版](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com)，[JavaScript 版](https://langchain-ai.github.io/langgraphjs/concepts/persistence/?ref=blog.langchain.com)。

## Short-term memory

## 短期记忆

Building a chatbot or conversational agent? You'll need short-term memory to keep track of the conversation history — without it, your chatbot can't maintain a coherent conversation with a user.

构建聊天机器人或对话式智能体？您需要短期记忆来跟踪对话历史——缺少它，您的聊天机器人将无法与用户维持连贯的对话。

In the Functional API, you can handle short-term memory using:

在函数式 API 中，您可通过以下方式处理短期记忆：

- `previous` parameter: Automatically gives you the state from the last checkpoint in a conversation thread.  
- `previous` 参数：自动为您提供对话线程中上一个检查点（checkpoint）的状态。

- `entrypoint.final()` type: Lets you return a final value for the workflow and optionally save a different value for the next checkpoint.  
- `entrypoint.final()` 类型：允许您为工作流返回一个最终值，并可选择为下一个检查点保存另一个不同的值。

```python
from langgraph.checkpoint.memory import MemorySaver
from langgraph.func import entrypoint

# Set a checkpointer to enable persistence.
# Additional implementations are available.
checkpointer = MemorySaver()

@entrypoint(checkpointer=checkpointer)
def conversational_agent(user_message, *, previous: Any = None):
    # Initialize messages list from previous state
    messages = previous or []

    # Add the new user message to the conversation history
    messages.append(user_message)

    # Get agent's response based on conversation history.
    # Replace with call_llm with actual implementation.
    new_messages = call_llm(messages)

    # Add agent's messages to conversation history
    messages.extend(new_messages)
```

# Return agent's messages as output  
# while saving full conversation history  

# 将代理的消息作为输出返回  
# 同时保存完整的对话历史  

```python
return entrypoint.final(value=new_messages, save=messages)
```

```python
return entrypoint.final(value=new_messages, save=messages)
```

Example conversational agent implementation  

示例对话式代理实现  

LangGraph's built in persistence layer allows you to implement short-term memory that maintains a conversation history and works for multiple users without requiring complex setup or management.  

LangGraph 内置的持久化层支持实现短期记忆，可维护对话历史，并在无需复杂配置或管理的前提下，同时服务于多个用户。  

- For more details, please see the how-to guide for adding long term memory (cross-thread persistence) in [Python](https://langchain-ai.github.io/langgraph/how-tos/persistence-functional/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/how-tos/persistence-functional/?ref=blog.langchain.com).  
- 更多详情，请参阅 Python 和 JavaScript 版本的“如何添加长期记忆（跨会话持久化）”操作指南：[Python](https://langchain-ai.github.io/langgraph/how-tos/persistence-functional/?ref=blog.langchain.com)、[JavaScript](https://langchain-ai.github.io/langgraphjs/how-tos/persistence-functional/?ref=blog.langchain.com)。  

- You can find more conceptual information about memory here: [Python](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/memory/?ref=blog.langchain.com).  
- 关于记忆机制的更多概念性介绍，请参阅：[Python](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com)、[JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/memory/?ref=blog.langchain.com)。  

## Long-term memory  

## 长期记忆  

Some apps, like recommender systems or personal assistants, need to remember user preferences to deliver better experiences. This is called **long-term memory** \-\- your app learns and adapts over time by storing and updating information about the user across different conversations.  

某些应用（例如推荐系统或个人助理）需要记住用户偏好，以提供更优的用户体验。这被称为 **长期记忆** —— 应用通过在不同对话间持续存储并更新用户相关信息，从而实现随时间推移的学习与自适应。  

You can implement long-term memory in LangGraph using the `store` parameter in the Functional API. The `store` parameter provides access to a persistent storage layer that can be used to store and retrieve data across different interactions with the same user.  

你可以在 LangGraph 中通过 Functional API 的 `store` 参数实现长期记忆。该参数提供对一个持久化存储层的访问能力，支持在与同一用户的多次交互中存储和检索数据。  

```python
from langgraph.checkpoint.memory import MemorySaver
from langgraph.func import entrypoint
from langgraph.store.base import BaseStore
from langgraph.store.memory import InMemoryStore

# Set a checkpointer to enable persistence.
# Additional implementations are available.
checkpointer = MemorySaver()

# Configure a store for long-term memory.
# Additional implementations are available.
store = InMemoryStore()
```

```python
from langgraph.checkpoint.memory import MemorySaver
from langgraph.func import entrypoint
from langgraph.store.base import BaseStore
from langgraph.store.memory import InMemoryStore

# 设置检查点器以启用持久化。
# 还提供其他实现方式。
checkpointer = MemorySaver()

# 为长期记忆配置存储器。
# 还提供其他实现方式。
store = InMemoryStore()
```

@entrypoint(checkpointer=checkpointer, store=store)
def workflow(
    some_input: dict,
    *,
    store: BaseStore
):
    # Use the store for long-term memory operations
    stored_data = store.get("user_info")
    # Your workflow will also be able to update the stored data.
    # A common way to do this is by having an LLM invoke tool calls that
    # update the stored data based on the conversation, user input, etc.

@entrypoint(checkpointer=checkpointer, store=store)
def workflow(
    some_input: dict,
    *,
    store: BaseStore
):
    # 使用存储（store）执行长期记忆操作
    stored_data = store.get("user_info")
    # 您的工作流也能够更新已存储的数据。
    # 一种常见做法是让大语言模型（LLM）调用工具函数，根据对话内容、用户输入等动态更新存储的数据。

```

A workflow can use LangGraph's BaseStore interface to implement long-term memory.

```

工作流可利用 LangGraph 的 `BaseStore` 接口实现长期记忆功能。

- For more details, please see the how-to guide for adding long term memory (cross-thread persistence) in [Python](https://langchain-ai.github.io/langgraph/how-tos/cross-thread-persistence-functional/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/how-tos/cross-thread-persistence-functional/?ref=blog.langchain.com).
- You can find more conceptual information about memory here: [Python](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/memory/?ref=blog.langchain.com).

- 如需了解更多详情，请参阅 Python 和 JavaScript 版本的“如何添加长期记忆（跨线程持久化）”指南：[Python](https://langchain-ai.github.io/langgraph/how-tos/cross-thread-persistence-functional/?ref=blog.langchain.com)、[JavaScript](https://langchain-ai.github.io/langgraphjs/how-tos/cross-thread-persistence-functional/?ref=blog.langchain.com)。  
- 关于记忆（memory）的更多概念性说明，请参阅：[Python](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com)、[JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/memory/?ref=blog.langchain.com)。

## Streaming

## 流式传输（Streaming）

Building a responsive app for end-users? Real-time updates are key to keeping users engaged as your app progresses.

面向终端用户构建响应迅速的应用？实时更新是保持用户在应用运行过程中持续参与的关键。

There are three main types of data you’ll want to stream:

您需要流式传输的数据主要有三类：

1. Workflow progress (e.g., "Task 1 completed").
2. LLM tokens as they’re generated.
3. Custom updates (e.g., "Fetched 10/100 records").

1. 工作流执行进度（例如：“任务 1 已完成”）。  
2. 大语言模型（LLM）生成的 token（逐个输出）。  
3. 自定义更新（例如：“已获取 10/100 条记录”）。

LangGraph makes this easy with built-in streaming support. When you define an entrypoint, you get a `stream` method to send real-time data. It returns a generator, so you can yield updates as they happen. You can subscribe to different streams using the stream\_mode argument, subscribing to workflow progress (`updates`), LLM tokens (`messages`), or custom data (`custom`).

LangGraph 通过内置的流式传输支持，让这一过程变得简单。当您定义一个入口点（entrypoint）时，将自动获得一个 `stream` 方法用于发送实时数据。该方法返回一个生成器（generator），因此您可在事件发生时即时产出（yield）更新。您可通过 `stream_mode` 参数订阅不同类型的流，例如工作流进度（`updates`）、LLM 输出消息（`messages`）或自定义数据（`custom`）。

```python
from langgraph.func import entrypoint
from langgraph.types import StreamWriter

@entrypoint(checkpointer=checkpointer)
def workflow(inputs, writer: StreamWriter):
  writer("Processing started")  # Write to custom stream
  # Do stuff (e.g., call tasks, call llms)
  writer("Processing completed")
  return result

```python
from langgraph.func import entrypoint
from langgraph.types import StreamWriter

@entrypoint(checkpointer=checkpointer)
def workflow(inputs, writer: StreamWriter):
  writer("Processing started")  # 写入自定义流（custom stream）
  # 执行具体操作（例如：调用任务、调用 LLM 等）
  writer("Processing completed")
  return result

# Consume the stream

# 消费流式响应

```python
for chunk in main.stream(input_data, stream_mode=["custom", "updates", "messages"], config=config):
  print(chunk)
```

- You can find more conceptual information about streaming here: [Python](https://langchain-ai.github.io/langgraph/concepts/streaming/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/streaming/?ref=blog.langchain.com).

- 关于流式处理的更多概念性信息，请参阅：[Python 版文档](https://langchain-ai.github.io/langgraph/concepts/streaming/?ref=blog.langchain.com) 和 [JavaScript 版文档](https://langchain-ai.github.io/langgraphjs/concepts/streaming/?ref=blog.langchain.com)。

## Observability

## 可观测性（Observability）

The Functional API provides built-in observability features to monitor and debug workflows. The inputs and outputs into **entrypoints** and tasks can be logged to [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com), LangChain's observability platform. This allows you to track the progress of workflows, identify bottlenecks, and troubleshoot issues and improve your workflows.

函数式 API（Functional API）内置了可观测性功能，可用于监控和调试工作流。**入口点（entrypoints）** 和任务（tasks）的输入与输出可记录至 LangChain 的可观测性平台 [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com)。这使您能够追踪工作流执行进度、识别性能瓶颈、排查问题，并持续优化工作流。

## Deployment

## 部署

If you’ve created a workflow using **entrypoint** you can deploy it to production using [LangGraph Platform](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com).

如果您已使用 **entrypoint** 创建了工作流，可通过 [LangGraph 平台](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com) 将其部署至生产环境。

## Graph API vs. Functional API

## 图 API（Graph API）vs. 函数式 API（Functional API）

The **Functional API** and the **Graph APIs** (StateGraph) provide two different paradigms to create in LangGraph. Here are some key differences:

**函数式 API** 与 **图 API**（即 `StateGraph`）为 LangGraph 提供了两种不同的建模范式。以下是二者的关键差异：

- **Control flow:** The **Functional API** does not require thinking about graph structure. You can use standard Python constructs to define workflows. This will usually trim the amount of code you need to write for control flow.

- **控制流（Control Flow）：** **函数式 API** 无需显式考虑图结构，您可直接使用标准 Python 语法（如 `if`、`for`、函数调用等）定义工作流逻辑，通常能显著减少控制流所需的代码量。

- **State management:** The **Graph API** requires declaring a State and may require defining reducers to manage updates to the graph state. **entrypoints** and **tasks** do not require explicit state management as their state is scoped to the function and is not shared across functions.

- **状态管理（State Management）：** **图 API** 要求显式声明 `State` 类型，并可能需定义 `reducer` 函数来管理图状态的更新；而 **entrypoints** 和 **tasks** 不需要显式的状态管理——其状态作用域限定在单个函数内，且不跨函数共享。

- **Time-travel:** In the **Graph API** checkpoints are more granular being generated after every node execution (or group of nodes if some nodes are being executed in parallel). In the **Functional API** checkpoints are generated after every **entrypoint** execution. When tasks are executed they update the existing checkpoint associated with the **entrypoint**, but it does not generate a new checkpoint. As a result, **time-travel** is better supported in the **Graph API**.

- **时间回溯（Time-travel）：** 在 **图 API** 中，检查点（checkpoints）粒度更细——每次节点（或并行执行的一组节点）执行完毕后均会生成一个新检查点；而在 **函数式 API** 中，检查点仅在每次 **entrypoint** 执行完成后生成。当执行 **tasks** 时，它们仅更新与该 **entrypoint** 关联的现有检查点，而不会创建新检查点。因此，**图 API 对时间回溯的支持更完善**。

- **Visualization:** The **Graph API** makes it easy to visualize the workflow as a graph which can be useful for debugging, understanding the workflow, and sharing with others. The **Functional API** does not support visualization since the execution flow is dynamically generated at run time.

- **可视化（Visualization）：** **图 API** 可轻松将工作流渲染为图形化拓扑图，这对调试、理解工作流逻辑以及团队协作分享非常有帮助；而 **函数式 API** 不支持可视化，因其执行流程是在运行时动态生成的，无法预先确定完整结构。

Because the both the **Functional API** and **Graph API** use the same underlying run time, you can mix and match them in the same project. For example, you can call a graph from an entrypoint, or you can use tasks from within a graph etc.

由于 **函数式 API** 与 **图 API** 共享同一底层运行时，您可在同一项目中灵活混用二者。例如：您可以在某个 **entrypoint** 中调用一个图（graph），也可以在图内部调用 **tasks** 等。

## Conclusion

## 结论

The **Functional API** in **LangGraph** provides a flexible approach to building AI workflows, with powerful features like **human-in-the-loop interactions**, **state management**, **persistence**, and **streaming**. These capabilities enable developers to create sophisticated applications that effectively combine automation with human input.

**LangGraph** 中的 **Functional API** 为构建 AI 工作流提供了灵活的方法，具备强大的功能，例如 **人工介入交互（human-in-the-loop interactions）**、**状态管理（state management）**、**持久化（persistence）** 和 **流式处理（streaming）**。这些能力使开发者能够构建出将自动化与人工输入高效结合的复杂应用。

📘 **Ready to get started?** Check out the Functional API documentation for [Python](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com) and [JavaScript](https://langchain-ai.github.io/langgraphjs/concepts/functional_api/?ref=blog.langchain.com).

📘 **准备开始了吗？** 请查阅 Functional API 的官方文档：[Python 版](https://langchain-ai.github.io/langgraph/concepts/functional_api/?ref=blog.langchain.com) 和 [JavaScript 版](https://langchain-ai.github.io/langgraphjs/concepts/functional_api/?ref=blog.langchain.com)。

🎥 We've also prepared [this YouTube video](https://www.youtube.com/watch?v=NXhyWJozM8A&ref=blog.langchain.com) that covers the Functional API for Python.

🎥 我们还专门制作了 [这段 YouTube 视频](https://www.youtube.com/watch?v=NXhyWJozM8A&ref=blog.langchain.com)，全面讲解 Python 版本的 Functional API。
{% endraw %}
