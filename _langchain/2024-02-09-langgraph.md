---
render_with_liquid: false
title: "LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph/"
date: "2024-02-09"
scraped_at: "2026-03-03T08:13:37.589926692+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

TL;DR: LangGraph 是构建在 LangChain 之上的一个模块，旨在更好地支持循环图（cyclical graphs）的创建，而这在智能体（agent）运行时中常常是必需的。

TL;DR：LangGraph 是一个构建在 LangChain 之上的模块，旨在更高效地支持循环图（cyclical graphs）的构建——这在智能体（agent）运行时中往往不可或缺。

- [Python 代码仓库](https://github.com/langchain-ai/langgraph/tree/main?ref=blog.langchain.com)  
- [Python YouTube 播放列表](https://www.youtube.com/playlist?list=PLfaIDFEXuae16n2TWUkKq5PgJ0w6Pkwtg&ref=blog.langchain.com)  
- [JS 代码仓库](https://github.com/langchain-ai/langgraphjs/?ref=blog.langchain.com)  

## Introduction  

## 简介  

我们在 [LangChain v0.1](https://blog.langchain.com/langchain-v0-1-0/) 的发布公告中重点强调的内容之一，便是引入了一个新库：[LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)。LangGraph 构建于 LangChain 之上，并与整个 LangChain 生态系统完全兼容互操作。其核心新增价值在于：提供了一种简便方式来构建循环图（cyclical graphs），而这在构建智能体运行时（agent runtimes）时尤为关键。

我们在 [LangChain v0.1](https://blog.langchain.com/langchain-v0-1-0/) 的发布公告中重点强调的内容之一，便是引入了一个新库：[LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)。LangGraph 构建于 LangChain 之上，并与整个 LangChain 生态系统完全兼容、无缝互操作。其核心新增价值在于：提供一种简便方式来构建循环图（cyclical graphs），而这在构建智能体运行时（agent runtimes）时尤为关键。

本文将首先阐述 LangGraph 的设计动因；随后介绍其基础功能；接着重点展示我们已实现的两个智能体运行时示例；再梳理社区中高频提出的几类常见运行时定制需求，并给出具体实现示例；最后，我们将预告下一阶段即将发布的功能。

本文将首先阐述 LangGraph 的设计动因；随后介绍其基础功能；接着重点展示我们已实现的两个智能体运行时示例；再梳理社区中高频提出的几类常见运行时定制需求，并给出具体实现示例；最后，我们将预告下一阶段即将发布的功能。

## Motivation  

## 设计动因  

LangChain 的一大核心价值主张，是让用户能够轻松构建自定义链（custom chains）。为此，我们大力投入开发了 [LangChain 表达式语言（LangChain Expression Language）](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)。然而，截至目前，我们仍缺乏一种便捷方式，将**循环结构（cycles）** 引入这些链中。实际上，当前所有链本质上都是有向无环图（[DAGs](https://en.wikipedia.org/wiki/Directed_acyclic_graph?ref=blog.langchain.com)）——绝大多数 [数据编排框架（data orchestration frameworks）](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html?ref=blog.langchain.com) 亦是如此。

LangChain 的一大核心价值主张，是让用户能够轻松构建自定义链（custom chains）。为此，我们大力投入开发了 [LangChain 表达式语言（LangChain Expression Language）](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)。然而，截至目前，我们仍缺乏一种便捷方式，将**循环结构（cycles）** 引入这些链中。实际上，当前所有链本质上都是有向无环图（[DAGs](https://en.wikipedia.org/wiki/Directed_acyclic_graph?ref=blog.langchain.com)）——绝大多数 [数据编排框架（data orchestration frameworks）](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html?ref=blog.langchain.com) 亦是如此。

当用户构建更复杂的 LLM 应用时，我们常观察到一种典型模式：在运行时中主动引入循环。这些循环通常利用大语言模型（LLM）来**推理（reason）** 下一步该执行什么操作。而 LLM 的一大关键能力，正是胜任此类推理任务——这本质上相当于将 LLM 置于一个 `for` 循环中反复调用。这类系统通常被称为“智能体（agents）”。

当用户构建更复杂的 LLM 应用时，我们常观察到一种典型模式：在运行时中主动引入循环。这些循环通常利用大语言模型（LLM）来**推理（reason）** 下一步该执行什么操作。而 LLM 的一大关键能力，正是胜任此类推理任务——这本质上相当于将 LLM 置于一个 `for` 循环中反复调用。这类系统通常被称为“智能体（agents）”。

为何这种**具身智能（agentic）行为**如此强大？一个典型例证是常见的 [检索增强生成（RAG）应用](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com)。在标准 RAG 流程中，首先调用检索器（retriever）获取若干文档，再将这些文档输入 LLM 以生成最终答案。尽管该流程通常有效，但一旦首次检索未能返回任何有用结果，整个流程便会失效。此时，理想情况是：LLM 能够**自主推理出**检索器返回的结果质量低下，并主动发起第二次（更精准的）检索查询，继而基于新检索结果生成答案。本质上，让 LLM 在循环中持续运行，有助于构建更具适应性（flexible）的应用系统，从而胜任那些目标模糊、未被预先明确定义的复杂用例。

为何这种**具身智能（agentic）行为**如此强大？一个典型例证是常见的 [检索增强生成（RAG）应用](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com)。在标准 RAG 流程中，首先调用检索器（retriever）获取若干文档，再将这些文档输入 LLM 以生成最终答案。尽管该流程通常有效，但一旦首次检索未能返回任何有用结果，整个流程便会失效。此时，理想情况是：LLM 能够**自主推理出**检索器返回的结果质量低下，并主动发起第二次（更精准的）检索查询，继而基于新检索结果生成答案。本质上，让 LLM 在循环中持续运行，有助于构建更具适应性（flexible）的应用系统，从而胜任那些目标模糊、未被预先明确定义的复杂用例。

这类应用通常被称为“智能体（agents）”。其中最简单、却也最具雄心的形式，是一个仅包含两个步骤的基本循环：

1. 调用大语言模型（LLM）以决定：(a) 应执行哪些操作，或 (b) 应向用户返回何种响应  
1. 调用大语言模型（LLM）以决定：(a) 应执行哪些操作，或 (b) 应向用户返回何种响应  

2. 执行所确定的操作，并将结果传回第 1 步  
2. 执行所确定的操作，并将结果传回第 1 步  

这些步骤不断重复，直至生成最终响应。这本质上就是驱动我们核心 [AgentExecutor](https://python.langchain.com/docs/modules/agents/concepts?ref=blog.langchain.com#agentexecutor) 的循环机制，也是推动 [AutoGPT](https://github.com/Significant-Gravitas/AutoGPT?ref=blog.langchain.com) 等项目迅速走红的底层逻辑。该机制之所以“简单”，是因为它仅依赖一个相对直接的循环；而它之所以“最具雄心”，则在于它几乎将**全部**决策与推理能力都交由大语言模型（LLM）承担。

我们在与社区及企业合作、将智能体（agents）投入实际生产的过程中发现，实践中往往需要更强的控制力。例如：你可能希望强制智能体始终优先调用某个特定工具；你可能希望更精细地控制工具的调用方式；你还可能希望根据智能体所处的不同状态，为其提供不同的提示词（prompt）。

当我们讨论这类受控程度更高的流程时，团队内部通常将其称为“状态机”（state machines）。参见我们关于认知架构（cognitive architectures）的博客中下方这张示意图：

![](images/langgraph/img_001.webp)

这些状态机具备循环能力，因而可比简单链式（chain）结构更稳健地处理语义模糊或信息不明确的输入。然而，在如何构建该循环这一关键环节上，仍需人工介入与引导。

LangGraph 是一种通过图（graph）形式来定义和构建此类状态机的框架。

## 功能特性

## Functionality

LangGraph 在 LangChain 基础之上，对外暴露了一个非常精简的接口。

LangGraph 在 LangChain 基础之上，对外暴露了一个非常精简的接口。

### StateGraph

### StateGraph

`StateGraph` is a class that represents the graph.

`StateGraph` 是一个表示图（graph）的类。

You initialize this class by passing in a `state` definition. This state definition represents a central state object that is updated over time. This state is updated by nodes in the graph, which return operations to attributes of this state (in the form of a key-value store).

你通过传入一个 `state` 定义来初始化该类。此状态定义表示一个随时间持续更新的中心状态对象。该状态由图中的节点进行更新；这些节点返回针对该状态各属性的操作（以键值对形式表示）。

The attributes of this state can be updated in two ways. First, an attribute could be overridden completely. This is useful if you want to nodes to return the new value of an attribute. Second, an attribute could be updated by adding to its value. This is useful if an attribute is a list of actions taken (or something similar) and you want nodes to return new actions taken (and have those automatically added to the attribute).

该状态的属性可通过两种方式更新：  
第一，可完全覆写某个属性——适用于希望节点直接返回该属性的新值的情形；  
第二，可通过累加方式更新某个属性——适用于该属性为已执行操作列表（或类似结构）的情形，此时你希望节点返回新执行的操作，并自动将其追加至该属性中。

You specify whether an attribute should be overridden or added to when creating the initial state definition. See an example in pseudocode below.

你在定义初始状态时即需指定每个属性是应被覆写还是被累加。参见下方伪代码示例：

```
from langgraph.graph import StateGraph
from typing import TypedDict, List, Annotated
import Operator

class State(TypedDict):
    input: str
    all_actions: Annotated[List[str], operator.add]

graph = StateGraph(State)
```

```
from langgraph.graph import StateGraph
from typing import TypedDict, List, Annotated
import Operator

class State(TypedDict):
    input: str
    all_actions: Annotated[List[str], operator.add]

graph = StateGraph(State)
```

### Nodes

### 节点（Nodes）

After creating a `StateGraph`, you then add nodes with `graph.add_node(name, value)` syntax. The `name` parameter should be a string that we will use to refer to the node when adding edges. The `value` parameter should be either a function or LCEL runnable that will be called. This function/LCEL should accept a dictionary in the same form as the `State` object as input, and output a dictionary with keys of the `State` object to update.

创建 `StateGraph` 后，你可使用 `graph.add_node(name, value)` 语法添加节点。参数 `name` 应为字符串，用于在添加边（edges）时引用该节点；参数 `value` 应为一个函数或一个 LCEL 可运行对象（runnable），将在执行时被调用。该函数或 LCEL 应接收一个与 `State` 对象结构相同的字典作为输入，并输出一个字典，其中键为 `State` 对象的属性名，值为待更新的内容。

See an example in pseudocode below.

参见下方伪代码示例：

```
graph.add_node("model", model)
graph.add_node("tools", tool_executor)
```

```
graph.add_node("model", model)
graph.add_node("tools", tool_executor)
```

There is also a special `END` node that is used to represent the end of the graph. It is important that your cycles be able to end eventually!

图中还存在一个特殊的 `END` 节点，用于表示图的终止。请确保你的循环最终能够结束！

```
from langgraph.graph import END
```

```
from langgraph.graph import END
```

### Edges

### 边（Edges）

After adding nodes, you can then add edges to create the graph. There are a few types of edges.

添加节点后，你便可添加边来构建图。边有多种类型。

**The Starting Edge**

**起始边（Starting Edge）**

This is the edge that connects the start of the graph to a particular node. This will make it so that that node is the first one called when input is passed to the graph. Pseudocode for that is:

这是连接图起点与某个特定节点的边。它将确保当输入传入图时，该节点成为首个被调用的节点。其伪代码如下：

```
graph.set_entry_point("model")
```

```
graph.set_entry_point("model")
```

**Normal Edges**

**普通边（Normal Edges）**

These are edges where one node should ALWAYS be called after another. An example of this may be in the basic agent runtime, where we always want the model to be called after we call a tool.

这类边表示：某一节点必须始终在另一节点之后被调用。例如，在基础 Agent 运行时中，我们总是希望在调用工具（tool）之后再调用模型（model）。

```
graph.add_edge("tools", "model")
```

```
graph.add_edge("tools", "model")
```

**Conditional Edges**

**条件边**

These are where a function (often powered by an LLM) is used to determine which node to go to first.  
这类边利用一个函数（通常由大语言模型驱动）来决定下一步应进入哪个节点。

To create this edge, you need to pass in three things:  
要创建此类边，需传入以下三个参数：

1. The upstream node: the output of this node will be looked at to determine what to do next  
1. 上游节点：该节点的输出将被检查，以决定后续操作。

2. A function: this will be called to determine which node to call next. It should return a string  
2. 一个函数：该函数将被调用，以确定下一步应调用哪个节点；其返回值应为字符串。

3. A mapping: this mapping will be used to map the output of the function in (2) to another node. The keys should be possible values that the function in (2) could return. The values should be names of nodes to go to if that value is returned.  
3. 一个映射字典：该字典用于将第 (2) 步中函数的输出映射至另一个节点。字典的键应为第 (2) 步函数可能返回的所有取值；字典的值则应为对应返回值下所应跳转的目标节点名称。

An example of this could be that after a model is called we either exit the graph and return to the user, or we call a tool - depending on what a user decides! See an example in pseudocode below:  
例如，在调用模型后，我们可能选择退出图流程并返回结果给用户，也可能选择调用某个工具——具体取决于用户的决策！以下为一段伪代码示例：

```
graph.add_conditional_edge(
    "model",
    should_continue,
    {
        "end": END,
        "continue": "tools"
    }
)
```

### Compile

### 编译

After we define our graph, we can compile it into a runnable! This simply takes the graph definition we've created so far an returns a runnable. This runnable exposes all the same method as LangChain runnables (`.invoke`, `.stream`, `.astream_log`, etc) allowing it to be called in the same manner as a chain.  
在定义完图结构后，我们可以将其编译为一个可执行对象（runnable）！该过程仅接收我们迄今构建的图定义，并返回一个可执行对象。该对象暴露了与 LangChain 可执行对象完全一致的方法（如 `.invoke`、`.stream`、`.astream_log` 等），因此可像普通链（chain）一样被调用。

```
app = graph.compile()
```

## Agent Executor

## Agent 执行器（Agent Executor）

We've recreated the canonical LangChain AgentExecutor with LangGraph. This will allow you to use existing LangChain agents, but allow you to more easily modify the internals of the AgentExecutor. The state of this graph by default contains concepts that should be familiar to you if you've used LangChain agents: `input`, `chat_history`, `intermediate_steps` (and `agent_outcome` to represent the most recent agent outcome)  
我们已使用 LangGraph 重新实现了 LangChain 中标准的 `AgentExecutor`。这使您既能继续使用现有的 LangChain Agent，又能更便捷地定制 `AgentExecutor` 的内部逻辑。该图的默认状态包含若干您若曾使用过 LangChain Agent 就会感到熟悉的字段：`input`（输入）、`chat_history`（对话历史）、`intermediate_steps`（中间步骤），以及用于表示最近一次 Agent 输出结果的 `agent_outcome`。

```python
from typing import TypedDict, Annotated, List, Union
from langchain_core.agents import AgentAction, AgentFinish
from langchain_core.messages import BaseMessage
import operator

class AgentState(TypedDict):
   input: str
   chat_history: list[BaseMessage]
   agent_outcome: Union[AgentAction, AgentFinish, None]
   intermediate_steps: Annotated[list[tuple[AgentAction, str]], operator.add]
```

请参阅 [此笔记本](https://github.com/langchain-ai/langgraph/blob/main/examples/agent_executor/base.ipynb?ref=blog.langchain.com)，了解如何快速上手。

## Chat Agent 执行器

## Chat Agent 执行器

我们观察到的一个常见趋势是：越来越多的大模型属于“对话”（chat）模型，即以消息列表（list of messages）作为输入进行运作。这类模型通常支持函数调用（function calling）等功能，从而显著提升了构建类智能体（agent-like）体验的可行性。在使用此类模型时，将智能体的状态自然地表示为一条消息列表，往往是最直观的方式。

因此，我们专门设计了一种适配该状态表示方式的智能体运行时（agent runtime）：其输入为消息列表，而各节点（nodes）则随时间推移持续向该消息列表中追加新消息。

```python
from typing import TypedDict, Annotated, Sequence
import operator
from langchain_core.messages import BaseMessage

class AgentState(TypedDict):
    messages: Annotated[Sequence[BaseMessage], operator.add]
```

请参阅 [此笔记本](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/base.ipynb?ref=blog.langchain.com)，了解如何快速上手。

## 修改项

## Modifications

One of the big benefits of LangGraph is that it exposes the logic of AgentExecutor in a far more natural and modifiable way. We've provided a few examples of modifications that we've heard requests for:

LangGraph 的一大优势在于，它以一种更自然、更易修改的方式暴露了 `AgentExecutor` 的内部逻辑。我们已提供若干示例，涵盖社区中呼声较高的几类定制需求：

**Force Calling a Tool**

**强制首次调用工具**

For when you always want to make an agent call a tool first. For [Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/agent_executor/force-calling-a-tool-first.ipynb?ref=blog.langchain.com) and [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/force-calling-a-tool-first.ipynb?ref=blog.langchain.com).

适用于始终希望智能体在第一步就调用某个工具的场景。支持 [Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/agent_executor/force-calling-a-tool-first.ipynb?ref=blog.langchain.com) 和 [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/force-calling-a-tool-first.ipynb?ref=blog.langchain.com)。

**Human-in-the-loop**

**人工介入（人在环路中）**

How to add a human-in-the-loop step before calling tools. For [Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/agent_executor/human-in-the-loop.ipynb?ref=blog.langchain.com) and [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/human-in-the-loop.ipynb?ref=blog.langchain.com).

介绍如何在调用工具前插入人工审核或干预环节。支持 [Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/agent_executor/human-in-the-loop.ipynb?ref=blog.langchain.com) 和 [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/human-in-the-loop.ipynb?ref=blog.langchain.com)。

**Managing Agent Steps**

**管理智能体执行步骤**

For adding custom logic on how to handle the intermediate steps an agent might take (useful for when there's a lot of steps). For [Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/agent_executor/managing-agent-steps.ipynb?ref=blog.langchain.com) and [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/managing-agent-steps.ipynb?ref=blog.langchain.com).

用于为智能体可能执行的中间步骤添加自定义处理逻辑（尤其适用于步骤繁多的复杂流程）。支持 [Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/agent_executor/managing-agent-steps.ipynb?ref=blog.langchain.com) 和 [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/managing-agent-steps.ipynb?ref=blog.langchain.com)。

**Returning Output in a Specific Format**

**以特定格式返回输出**

How to make the agent return output in a specific format using function calling. Only for [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/respond-in-format.ipynb?ref=blog.langchain.com).

介绍如何利用函数调用（function calling）机制，使智能体严格按指定格式返回结果。仅适用于 [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/respond-in-format.ipynb?ref=blog.langchain.com)。

**Dynamically Returning the Output of a Tool Directly**

**动态直接返回工具的输出**

适用于需根据运行时条件跳过后续处理、立即将某工具的原始输出作为最终响应返回的场景。

Sometimes you may want to return the output of a tool directly. We provide an easy way to do with the `return_direct` parameter in LangChain. However, this makes it so that the output of a tool is ALWAYS returned directly. Sometimes, you may want to let the LLM choose whether to return the response directly or not. Only for [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/dynamically-returning-directly.ipynb?ref=blog.langchain.com).

有时你可能希望直接返回某个工具的输出结果。LangChain 提供了便捷的方式，即通过 `return_direct` 参数实现这一点。但该参数会使工具的输出**始终**被直接返回。而有时，你可能希望由大语言模型（LLM）自主决定是否直接返回响应。此功能目前**仅适用于 [Chat Agent Executor](https://github.com/langchain-ai/langgraph/blob/main/examples/chat_agent_executor_with_function_calling/dynamically-returning-directly.ipynb?ref=blog.langchain.com)**。

## Future Work

## 未来工作

We're incredibly excited about the possibility of LangGraph enabling more custom and powerful agent runtimes. Some of the things we are looking to implement in the near future:

我们对 LangGraph 赋能更定制化、更强大的智能体（agent）运行时充满期待。近期我们计划实现的部分功能包括：

- More advanced agent runtimes from academia ( [LLM Compiler](https://github.com/SqueezeAILab/LLMCompiler?ref=blog.langchain.com), [plan-and-solve](https://arxiv.org/abs/2305.04091?ref=blog.langchain.com), etc)  
  来自学术界的更先进的智能体运行时（例如 [LLM Compiler](https://github.com/SqueezeAILab/LLMCompiler?ref=blog.langchain.com)、[plan-and-solve](https://arxiv.org/abs/2305.04091?ref=blog.langchain.com) 等）；

- Stateful tools (allowing tools to modify some state)  
  有状态工具（允许工具修改某些状态）；

- More controlled human-in-the-loop workflows  
  更精细化的人机协同（human-in-the-loop）流程；

- Multi-agent workflows  
  多智能体协作流程。

If any of these resonate with you, please feel free to add an example notebook in the LangGraph repo, or reach out to us at hello@langchain.dev for more involved collaboration!

若您对上述任一方向感兴趣，欢迎在 LangGraph 仓库中贡献示例 Notebook，或通过 hello@langchain.dev 与我们联系，开展更深入的合作！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/langgraph/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/langgraph/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langgraph/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/langgraph/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/langgraph/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/langgraph/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/langgraph/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/langgraph/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/langgraph/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/langgraph/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**LangSmith SDK v0.2：让模型评估更轻松**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langgraph/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/langgraph/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台正式开启 Beta 测试：为可扩展智能体基础设施提供全新部署方案**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟