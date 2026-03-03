---
title: "Improving core tool interfaces and docs in LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/improving-core-tool-interfaces-and-docs-in-langchain/"
date: "2024-09-13"
scraped_at: "2026-03-03T07:53:16.145337635+00:00"
language: "en-zh"
translated: true
description: "See our latest improvements to our core tool interfaces that make it turn any code into a tool, handle diverse inputs, enrich tool outputs, and handle tool errors effectively."
tags: ["By LangChain"]
---

“[Tools](https://python.langchain.com/v0.2/docs/concepts/?ref=blog.langchain.com#tools)”（“工具”）在大语言模型（LLM）语境中，是指专为被模型调用而设计的实用程序。它们具有明确定义的结构（schema），可作为输入提供给模型，并生成可反馈回模型的输出。当您希望模型控制代码的某一部分，或调用外部 API 时，就必须使用工具——因此，工具是构建 LLM 应用不可或缺的基础组件。

过去几周，我们重点优化了核心工具接口与相关文档。这些更新显著提升了以下能力：

- 将任意代码快速封装为工具  
- 向工具传递多种类型（如字符串、字典、嵌套对象等）的输入  
- 从工具返回结构复杂的输出（例如嵌套字典、自定义类实例等）  
- 借助更稳健的架构，构建可靠性更高的工具  

接下来，我们将深入介绍 LangChain 中关于工具集成、调用与管理的上述改进。

## 工具定义大幅简化

工具集成往往较为复杂，常需手动编写定制化包装器（wrapper）或接口。在 LangChain 中，我们从工具定义这一环节入手，显著降低了整体复杂度。

- 现在，您可直接将**任意 Python 函数传入 `ChatModel.bind_tools()`**，使普通 Python 函数无需额外封装即可作为工具使用。LangChain 会自动解析函数的类型注解（type annotations）和文档字符串（docstring），推断出所需的工具 schema，从而极大简化工具定义流程。以下示例展示了模型如何从输入中提取地址列表，并将其作为参数传入工具：

```python
from typing import List
from typing_extensions import TypedDict

from langchain_anthropic import ChatAnthropic

class Address(TypedDict):
    street: str
    city: str
    state: str

```python
def validate_user(user_id: int, addresses: List[Address]) -> bool:
    """Validate user using historical addresses.

    Args:
        user_id: (int) the user ID.
        addresses: Previous addresses.
    """
    return True

llm = ChatAnthropic(
    model="claude-3-sonnet-20240229"
).bind_tools([validate_user])

result = llm.invoke(
    "Could you validate user 123? They previously lived at "
    "123 Fake St in Boston MA and 234 Pretend Boulevard in "
    "Houston TX."
)
result.tool_calls
```

```python
def validate_user(user_id: int, addresses: List[Address]) -> bool:
    """使用历史地址验证用户。

    参数：
        user_id: （int）用户 ID。
        addresses: 以往的住址列表。
    """
    return True

llm = ChatAnthropic(
    model="claude-3-sonnet-20240229"
).bind_tools([validate_user])

result = llm.invoke(
    "您能验证用户 123 吗？该用户此前曾居住于：马萨诸塞州波士顿市 Fake 街 123 号，以及德克萨斯州休斯顿市 Pretend 大道 234 号。"
)
result.tool_calls
```

```python
[{'name': 'validate_user',\
  'args': {'user_id': 123,\
   'addresses': [{'street': '123 Fake St', 'city': 'Boston', 'state': 'MA'},\
    {'street': '234 Pretend Boulevard', 'city': 'Houston', 'state': 'TX'}]},\
  'id': 'toolu_011KnPwWqKuyQ3kMy6McdcYJ',\
  'type': 'tool_call'}]
```

```python
[{'name': 'validate_user',\
  'args': {'user_id': 123,\
   'addresses': [{'street': '123 Fake St', 'city': 'Boston', 'state': 'MA'},\
    {'street': '234 Pretend Boulevard', 'city': 'Houston', 'state': 'TX'}]},\
  'id': 'toolu_011KnPwWqKuyQ3kMy6McdcYJ',\
  'type': 'tool_call'}]
```

The associated [LangSmith trace](https://smith.langchain.com/public/587a1d4c-c065-42f9-8610-43f99e0435ae/r?ref=blog.langchain.com) shows how the tool schema was populated behind the scenes, including the parsing of the function docstring into top-level and parameter-level descriptions.

关联的 [LangSmith 追踪记录](https://smith.langchain.com/public/587a1d4c-c065-42f9-8610-43f99e0435ae/r?ref=blog.langchain.com) 展示了工具（tool）schema 在后台是如何自动生成的，包括将函数文档字符串（docstring）解析为顶层描述和各参数级别的描述。

Learn more about creating tools from functions in our how-to guides for [Python](https://python.langchain.com/v0.2/docs/how_to/custom_tools/?ref=blog.langchain.com#creating-tools-from-functions) and [JavaScript](https://js.langchain.com/v0.2/docs/how_to/custom_tools/?ref=blog.langchain.com).

有关如何从函数创建工具的更多详细信息，请参阅我们的操作指南：[Python 版](https://python.langchain.com/v0.2/docs/how_to/custom_tools/?ref=blog.langchain.com#creating-tools-from-functions) 和 [JavaScript 版](https://js.langchain.com/v0.2/docs/how_to/custom_tools/?ref=blog.langchain.com)。

- **此外，任何 LangChain** [**runnable**](https://python.langchain.com/v0.2/docs/concepts/?ref=blog.langchain.com#runnable-interface) **现在均可直接转换为工具（tool）**，从而更便捷地复用已有的 LangChain runnable（可运行对象），包括链（chains）和智能体（agents）。复用已有 runnable 能有效减少冗余，并加快新功能的部署速度。例如，下方代码将一个 LangGraph 智能体配备另一个“用户信息智能体”作为工具，使其能够将相关问题委派给该辅助智能体处理。

- **此外，任意 LangChain** [**runnable**](https://python.langchain.com/v0.2/docs/concepts/?ref=blog.langchain.com#runnable-interface) **现均支持直接转为工具（tool）**，从而更便捷地复用现有 LangChain runnable（可运行对象），包括链（chains）与智能体（agents）。复用已有 runnable 可显著减少重复开发，并加速新功能上线。例如，下方示例中，我们为一个 LangGraph 智能体配置了另一个“用户信息智能体”作为工具，使其可将相关问题交由该辅助智能体处理。

```python
from typing import List, Literal
from typing_extensions import TypedDict

from langchain_openai import ChatOpenAI
from langgraph.prebuilt import create_react_agent
```

```python
from typing import List, Literal
from typing_extensions import TypedDict

from langchain_openai import ChatOpenAI
from langgraph.prebuilt import create_react_agent
```

```python
llm = ChatOpenAI(temperature=0)

llm = ChatOpenAI(温度=0)

user_info_agent = create_react_agent(llm, [validate_user])

user_info_agent = create_react_agent(llm, [validate_user])

class Message(TypedDict):
    role: Literal["human"]
    content: str

class Message(TypedDict):
    role: Literal["human"]
    content: str

agent_tool = user_info_agent.as_tool(
    arg_types={"messages": List[Message]},
    name="user_info_agent",
    description="Ask questions about users.",
)

agent_tool = user_info_agent.as_tool(
    arg_types={"messages": List[Message]},
    name="user_info_agent",
    description="向用户提问。",
)

agent = create_react_agent(llm, [agent_tool])
```

agent = create_react_agent(llm, [agent_tool])
```

See how to use runnables as tools in our [Python](https://python.langchain.com/v0.2/docs/how_to/convert_runnable_to_tool/?ref=blog.langchain.com) and [JavaScript](https://js.langchain.com/v0.2/docs/how_to/convert_runnable_to_tool?ref=blog.langchain.com) docs.

请参阅我们的 [Python](https://python.langchain.com/v0.2/docs/how_to/convert_runnable_to_tool/?ref=blog.langchain.com) 和 [JavaScript](https://js.langchain.com/v0.2/docs/how_to/convert_runnable_to_tool?ref=blog.langchain.com) 文档，了解如何将 runnables 用作工具。

## Flexible tool inputs

## 灵活的工具输入

Tools must handle diverse inputs coming from varying data sources and user interactions. Validating these inputs can be cumbersome, especially determining which inputs should be generated by the model versus provided by other sources.

工具必须能处理来自不同数据源和用户交互的多样化输入。验证这些输入可能十分繁琐，尤其是需明确哪些输入应由模型生成、哪些应由其他来源提供。

- In LangChain, you can now **pass in model-generated ToolCalls directly to tools** (see [Python](https://python.langchain.com/v0.2/docs/concepts/?ref=blog.langchain.com#invoke-with-toolcall), [JS](https://js.langchain.com/v0.2/docs/concepts/?ref=blog.langchain.com#invoke-with-toolcall) docs). While this streamlines executing tools called by a model, there’s also cases where we _don’t_ want all inputs to the tool to be generated by the model. For example, if our tool requires some type of user ID, this input will likely come from elsewhere in our code and not from a model. For these cases, we’ve added **annotations** **that specify which tool inputs shouldn’t be generated by the model**. See docs here ( [Python](https://python.langchain.com/v0.2/docs/how_to/tool_runtime/?ref=blog.langchain.com), [JS](https://js.langchain.com/v0.2/docs/how_to/tool_runtime/?ref=blog.langchain.com)).

- 在 LangChain 中，您现在可**直接将模型生成的 ToolCall 传入工具**（参见 [Python](https://python.langchain.com/v0.2/docs/concepts/?ref=blog.langchain.com#invoke-with-toolcall) 和 [JS](https://js.langchain.com/v0.2/docs/concepts/?ref=blog.langchain.com#invoke-with-toolcall) 文档）。尽管此举简化了模型调用工具的执行流程，但某些场景下我们**并不希望工具的所有输入均由模型生成**。例如，若某工具需要某种用户 ID，则该输入很可能来自代码其他部分，而非模型生成。针对此类情况，我们新增了**注解（annotations）功能，用于明确指定哪些工具输入不应由模型生成**。详见文档（[Python](https://python.langchain.com/v0.2/docs/how_to/tool_runtime/?ref=blog.langchain.com)，[JS](https://js.langchain.com/v0.2/docs/how_to/tool_runtime/?ref=blog.langchain.com)）。

- We’ve also added documentation on how to **pass LangGraph state to tools** in [Python](https://langchain-ai.github.io/langgraph/how-tos/pass-run-time-values-to-tools/?ref=blog.langchain.com) and [JavaScript](https://js.langchain.com/v0.2/docs/how_to/tool_runtime/?ref=blog.langchain.com). We’ve also made it possible for tools to access the `RunnableConfig` object associated with a run. This is useful for parametrizing tool behavior, passing global params through a chain, and accessing metadata like Run IDs — which provide more control over tool management. Read the docs ( [Python](https://python.langchain.com/v0.2/docs/how_to/tool_configure/?ref=blog.langchain.com), [JS](https://js.langchain.com/v0.2/docs/how_to/tool_configure?ref=blog.langchain.com)).

- 我们还新增了关于**如何将 LangGraph 状态传递给工具**的文档，涵盖 [Python](https://langchain-ai.github.io/langgraph/how-tos/pass-run-time-values-to-tools/?ref=blog.langchain.com) 和 [JavaScript](https://js.langchain.com/v0.2/docs/how_to/tool_runtime/?ref=blog.langchain.com)。此外，我们已支持工具访问与当前运行关联的 `RunnableConfig` 对象。该功能可用于参数化工具行为、在链式调用中透传全局参数，以及访问诸如 Run ID 等元数据——从而实现对工具管理更精细的控制。请查阅相关文档（[Python](https://python.langchain.com/v0.2/docs/how_to/tool_configure/?ref=blog.langchain.com)，[JS](https://js.langchain.com/v0.2/docs/how_to/tool_configure?ref=blog.langchain.com)）。

## Enriched tool outputs

## 增强的工具输出

Enriching your tool outputs with additional data can help you use these outputs in subsequent actions or processes, increasing developer efficiency.

通过向工具输出中添加额外数据，您可以将这些输出用于后续操作或流程，从而提升开发者的效率。

- Tools in LangChain can now **return results needed in downstream components** but that should not be part of the content sent to the model via an `artifact` attribute in ToolMessages. Tools can also return ToolMessages to set the `artifact` themselves, giving developers more control over output management. See docs here ( [Python](https://python.langchain.com/v0.2/docs/how_to/tool_artifacts/?ref=blog.langchain.com), [JS](https://js.langchain.com/v0.2/docs/how_to/tool_artifacts/?ref=blog.langchain.com)).

- LangChain 中的工具现在可**返回下游组件所需的结果**，但这些结果不应作为内容通过 ToolMessage 中的 `artifact` 属性发送给模型。工具还可自行返回 ToolMessage 来设置 `artifact`，从而赋予开发者对输出管理更强的控制力。详见文档（[Python](https://python.langchain.com/v0.2/docs/how_to/tool_artifacts/?ref=blog.langchain.com)，[JavaScript](https://js.langchain.com/v0.2/docs/how_to/tool_artifacts/?ref=blog.langchain.com)）。

- We’ve also enabled tools to **stream** **custom events**, providing real-time feedback that improves your tools’ usability. See docs here ( [Python](https://python.langchain.com/v0.2/docs/how_to/tool_stream_events/?ref=blog.langchain.com), [JS](https://js.langchain.com/v0.2/docs/how_to/tool_stream_events?ref=blog.langchain.com)).

- 我们还支持工具**流式传输自定义事件**，提供实时反馈，从而提升工具的可用性。详见文档（[Python](https://python.langchain.com/v0.2/docs/how_to/tool_stream_events/?ref=blog.langchain.com)，[JavaScript](https://js.langchain.com/v0.2/docs/how_to/tool_stream_events?ref=blog.langchain.com)）。

## Robust handling of tool call errors

## 工具调用错误的稳健处理

Tools can fail for various reasons — as a result, implementing fallback mechanisms and learning how to handle these failures gracefully is important to maintaining app stability. To support this, we’ve added:

工具可能因多种原因而失败；因此，实现回退机制，并掌握优雅处理此类失败的方法，对保障应用稳定性至关重要。为支持这一需求，我们新增了以下内容：

- Docs for how to use **prompt engineering and fallbacks** to handle tool calling errors ( [Python](https://python.langchain.com/v0.2/docs/how_to/tools_error/?ref=blog.langchain.com), [JS](https://js.langchain.com/v0.2/docs/how_to/tools_error?ref=blog.langchain.com)).

- 关于如何运用**提示工程与回退机制**处理工具调用错误的文档（[Python](https://python.langchain.com/v0.2/docs/how_to/tools_error/?ref=blog.langchain.com)，[JavaScript](https://js.langchain.com/v0.2/docs/how_to/tools_error?ref=blog.langchain.com)）。

- Docs for how to use **flow engineering** in your LangGraph graph to handle tool calling errors ( [Python](https://langchain-ai.github.io/langgraph/how-tos/tool-calling-errors?ref=blog.langchain.com), [JS](https://langchain-ai.github.io/langgraphjs/how-tos/tool-calling-errors?ref=blog.langchain.com)).

- 关于如何在 LangGraph 图中运用**流程工程（flow engineering）** 处理工具调用错误的文档（[Python](https://langchain-ai.github.io/langgraph/how-tos/tool-calling-errors?ref=blog.langchain.com)，[JavaScript](https://langchain-ai.github.io/langgraphjs/how-tos/tool-calling-errors?ref=blog.langchain.com)）。

## What’s next

## 后续计划

In the coming weeks we’ll continue adding how-to guides and best practices for defining tools and designing tool-using architectures. We’ll also refresh the documentation for our many tool and toolkit integrations. These efforts aim to empower users to maximize the potential of LangChain tools as they build context-aware reasoning applications.

在接下来的几周内，我们将持续补充关于定义工具及设计工具调用架构的实操指南与最佳实践。同时，我们也将全面更新大量工具与工具包集成的相关文档。这些工作旨在赋能用户，在构建具备上下文感知能力的推理应用时，充分释放 LangChain 工具的全部潜力。

If you haven’t already, check out our docs to learn more about LangChain for [Python](https://python.langchain.com/v0.2/docs/tutorials/?ref=blog.langchain.com) and [JavaScript](https://js.langchain.com/v0.2/docs/tutorials/?ref=blog.langchain.com).

若您尚未查阅，欢迎访问我们的文档，深入了解 LangChain 在 [Python](https://python.langchain.com/v0.2/docs/tutorials/?ref=blog.langchain.com) 和 [JavaScript](https://js.langchain.com/v0.2/docs/tutorials/?ref=blog.langchain.com) 中的使用方法。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/improving-core-tool-interfaces-and-docs-in-langchain/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/improving-core-tool-interfaces-and-docs-in-langchain/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/improving-core-tool-interfaces-and-docs-in-langchain/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/improving-core-tool-interfaces-and-docs-in-langchain/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/improving-core-tool-interfaces-and-docs-in-langchain/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能发展现状报告](images/improving-core-tool-interfaces-and-docs-in-langchain/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/improving-core-tool-interfaces-and-docs-in-langchain/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![推出 LangSmith 的 OpenTelemetry 支持](images/improving-core-tool-interfaces-and-docs-in-langchain/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/improving-core-tool-interfaces-and-docs-in-langchain/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/improving-core-tool-interfaces-and-docs-in-langchain/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/improving-core-tool-interfaces-and-docs-in-langchain/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/improving-core-tool-interfaces-and-docs-in-langchain/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟