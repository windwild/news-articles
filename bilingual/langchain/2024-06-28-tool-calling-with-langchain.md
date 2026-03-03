---
title: "Tool Calling with LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/tool-calling-with-langchain/"
date: "2024-06-28"
scraped_at: "2026-03-03T07:59:37.875202329+00:00"
language: "en-zh"
translated: true
---

**TLDR: We are introducing a new `tool_calls` attribute on `AIMessage`. More and more LLM providers are exposing API’s for reliable tool calling. The goal with the new attribute is to provide a standard interface for interacting with tool invocations. This is fully backwards compatible and is supported on all models that have native tool-calling support. In order to access these latest features you will need to upgrade your `langchain_core` and partner package versions.**

**简而言之：我们正在 `AIMessage` 上引入一个新的 `tool_calls` 属性。越来越多的大语言模型（LLM）提供商正开放可靠的工具调用（tool calling）API。新增该属性的目标是为工具调用提供统一、标准的交互接口。此变更完全向后兼容，且支持所有原生支持工具调用的模型。如需使用这些最新功能，请升级您的 `langchain_core` 及相关配套包版本。**

[**YouTube Walkthrough**](https://youtu.be/zCwuAlpQKTM?ref=blog.langchain.com)

[**YouTube 演示视频**](https://youtu.be/zCwuAlpQKTM?ref=blog.langchain.com)

**Python:**

**Python：**

- [**List of chat models**](https://python.langchain.com/docs/integrations/chat/?ref=blog.langchain.com) **that shows status of tool calling capability**  
- [**聊天模型列表**](https://python.langchain.com/docs/integrations/chat/?ref=blog.langchain.com) **展示各模型的工具调用能力支持状态**

- [**Tool calling**](https://python.langchain.com/docs/modules/model_io/chat/function_calling/?ref=blog.langchain.com) **explains the new tool calling interface**  
- [**工具调用**](https://python.langchain.com/docs/modules/model_io/chat/function_calling/?ref=blog.langchain.com) **详解全新的工具调用接口**

- [**Tool calling agent**](https://python.langchain.com/docs/modules/agents/agent_types/tool_calling/?ref=blog.langchain.com) **shows how to create an agent that uses the standardized tool calling interface**  
- [**工具调用型智能体（Agent）**](https://python.langchain.com/docs/modules/agents/agent_types/tool_calling/?ref=blog.langchain.com) **演示如何构建一个基于标准化工具调用接口的智能体**

- [**LangGraph notebook**](https://github.com/langchain-ai/langchain/blob/master/cookbook/tool_call_messages.ipynb?ref=blog.langchain.com) **shows how to create a LangGraph agent that uses the standardized tool calling interface**  
- [**LangGraph 笔记本**](https://github.com/langchain-ai/langchain/blob/master/cookbook/tool_call_messages.ipynb?ref=blog.langchain.com) **演示如何构建一个基于标准化工具调用接口的 LangGraph 智能体**

**JS:**

**JavaScript：**

- [**List of chat models**](https://js.langchain.com/docs/integrations/chat/?ref=blog.langchain.com) **that shows status of tool calling capability**  
- [**聊天模型列表**](https://js.langchain.com/docs/integrations/chat/?ref=blog.langchain.com) **展示各模型的工具调用能力支持状态**

- [**Tool calling**](https://js.langchain.com/docs/modules/model_io/chat/function_calling/?ref=blog.langchain.com) **explains the new tool calling interface**  
- [**工具调用**](https://js.langchain.com/docs/modules/model_io/chat/function_calling/?ref=blog.langchain.com) **详解全新的工具调用接口**

- [**Tool calling agent**](https://js.langchain.com/docs/modules/agents/agent_types/tool_calling/?ref=blog.langchain.com) **shows how to create an agent that uses the standardized tool calling interface**  
- [**工具调用型智能体（Agent）**](https://js.langchain.com/docs/modules/agents/agent_types/tool_calling/?ref=blog.langchain.com) **演示如何构建一个基于标准化工具调用接口的智能体**

* * *

## **Intro**

## **引言**

Large Language Models (LLMs) can interact with external data sources via tool calling functionality. Tool calling is a powerful technique that allows developers to build sophisticated applications that can leverage LLMs to access, interact and manipulate external resources like databases, files and APIs.

大语言模型（LLM）可通过“工具调用”（tool calling）功能与外部数据源进行交互。工具调用是一项强大技术，使开发者能够构建复杂应用——让 LLM 便捷地访问、交互并操作数据库、文件、API 等外部资源。

Providers have been introducing native tool calling capability into their models. What this looks like in practice is that when the LLM provides an auto-completion to a prompt, it can return a list of tool invocations in addition to plain text. OpenAI was the first to release this roughly a year ago with “function calling”, which quickly evolved to “tool calling” in November. Since then, other model providers have followed: Gemini (in December), Mistral (in February), Fireworks (in March), Together (in March), Groq (in April), Cohere (in April) and Anthropic (in April).

各大模型提供商陆续为其模型原生集成工具调用能力。在实际使用中，这意味着当 LLM 对用户提示（prompt）生成自动补全响应时，除返回普通文本外，还可一并返回一组待执行的工具调用指令。OpenAI 约一年前率先推出该能力（最初称为“函数调用”，function calling），并于同年 11 月正式升级为更通用的“工具调用”（tool calling）。此后，其他厂商也相继跟进：Gemini（12 月）、Mistral（2 月）、Fireworks（3 月）、Together（3 月）、Groq（4 月）、Cohere（4 月）及 Anthropic（4 月）。

All of these providers exposed slightly different interfaces (in particular: OpenAI, Anthropic, and Gemini, the three highest performing models are incompatible).  
上述所有提供商暴露的接口略有不同（尤其是 OpenAI、Anthropic 和 Gemini —— 这三个性能最强的模型彼此不兼容）。我们从社区中听到了一种强烈需求：希望提供一套标准化的工具调用（tool calling）接口，以便轻松在这些提供商之间切换。我们非常高兴地宣布，今天正式发布这一标准接口。

The standard interface consists of:  
该标准接口包含以下三部分：

- `ChatModel.bind_tools()`: 一个用于将工具定义绑定到模型调用的方法。  
- `AIMessage.tool_calls`: 模型返回的 `AIMessage` 对象上的一个属性，便于便捷访问模型决定发起的工具调用。  
- `create_tool_calling_agent()`: 一种代理（agent）构造器，可与**任意**实现了 `bind_tools` 方法并返回 `tool_calls` 的模型协同工作。

Let’s take a look at each of these components.  
下面我们逐一介绍这些组件。

## `ChatModel.bind_tools(...)`

## `ChatModel.bind_tools(...)`

To allow a model to use tools, we need to tell it which tools are available. We do this by specifying passing a list of of tool definitions to the model, including a schema for the tool arguments. The exact format of the tool definitions is model provider-dependent — OpenAI expects a dictionary with “name”, “description”, and “parameters” keys, while Anthropic expects “name”, “description”, and “input_schema”.  
为了让模型能够使用工具，我们需要向其明确声明哪些工具可用。具体做法是：向模型传入一个工具定义列表，并为每个工具的参数提供结构化 Schema。而工具定义的具体格式取决于模型提供商 —— 例如，OpenAI 要求字典包含 `"name"`、`"description"` 和 `"parameters"` 三个键；Anthropic 则要求 `"name"`、`"description"` 和 `"input_schema"`。

`ChatModel.bind_tools` provides a standard interface implemented by all tool-calling models that lets you specify which tools are available to the model. You can pass in not just a raw tool definition (a dict), but also objects from which a tool definition can be derived: namely Pydantic classes, LangChain tools, and arbitrary functions. This makes it easy to create generic tool definitions that you can use with any tool-calling model:  
`ChatModel.bind_tools` 为所有支持工具调用的模型提供了统一接口，使您能清晰指定模型可使用的工具。您传入的不仅限于原始工具定义（即字典），还可传入能自动推导出工具定义的对象，包括：Pydantic 类、LangChain 工具（`@tool` 装饰的函数），以及任意普通函数。这使得创建通用、跨平台的工具定义变得极为简单，可无缝适配任意支持工具调用的模型：

```python
from langchain_anthropic import ChatAnthropic
from langchain_core.pydantic_v1 import BaseModel, Field
from langchain_core.tools import tool

# ✅ Pydantic class
class multiply(BaseModel):
    """Return product of 'x' and 'y'."""
    x: float = Field(..., description="First factor")
    y: float = Field(..., description="Second factor")

# ✅ LangChain tool
@tool
def exponentiate(x: float, y: float) -> float:
    """Raise 'x' to the 'y'."""
    return x**y
```

# ✅ 函数

# ✅ 函数

def subtract(x: float, y: float) -> float:
    """Subtract 'x' from 'y'."""
    return y-x

def subtract(x: float, y: float) -> float:
    """从 'y' 中减去 'x'。"""
    return y-x

# ✅ OpenAI 格式字典  
# 也可以传入一个包含 "title" 和 "description" 的 JSON Schema

# ✅ OpenAI 格式字典  
# 也可以传入一个包含 "title" 和 "description" 的 JSON Schema

add = {
  "name": "add",
  "description": "Add 'x' and 'y'.",
  "parameters": {
    "type": "object",
    "properties": {
      "x": {"type": "number", "description": "First number to add"},
      "y": {"type": "number", "description": "Second number to add"}
    },
    "required": ["x", "y"]
  }
}

add = {
  "name": "add",
  "description": "将 'x' 和 'y' 相加。",
  "parameters": {
    "type": "object",
    "properties": {
      "x": {"type": "number", "description": "第一个相加的数字"},
      "y": {"type": "number", "description": "第二个相加的数字"}
    },
    "required": ["x", "y"]
  }
}

llm = ChatAnthropic(model="claude-3-sonnet-20240229", temperature=0)

llm = ChatAnthropic(model="claude-3-sonnet-20240229", temperature=0)

# Whenever we invoke `llm_with_tool`, all three of these tool definitions  
# are passed to the model.  
llm_with_tools = llm.bind_tools([multiply, exponentiate, add, subtract])

# 每当我们调用 `llm_with_tool` 时，上述全部三个工具定义  
# 都会被传递给模型。  
llm_with_tools = llm.bind_tools([multiply, exponentiate, add, subtract])

```

If we wanted to use a different tool-calling model, our code would look very similar:

```

如果我们想使用另一种支持工具调用的模型，代码结构将非常相似：

```python
from langchain_openai import ChatOpenAI

llm = ChatOpenAI(model="gpt-4-turbo", temperature=0)
llm_with_tools = llm.bind_tools([multiply, exponentiate, add, subtract])
```

```python
from langchain_openai import ChatOpenAI

llm = ChatOpenAI(model="gpt-4-turbo", temperature=0)
llm_with_tools = llm.bind_tools([multiply, exponentiate, add, subtract])
```

So what would calling `llm_with_tools` look like? That’s where `AIMessage.tool_calls` comes in.

那么调用 `llm_with_tools` 会是什么样子？这就引出了 `AIMessage.tool_calls`。

## `AIMessage.tool_calls`

## `AIMessage.tool_calls`

Before when using a tool-calling model, any tool invocations returned by the model were found in either `AIMessage.additional_kwargs` or `AIMessage.content`, depending on the model provider’s API, and followed a provider-specific format. That is, you’d need custom logic to extract the tool invocations from the outputs of different models. Now, `AIMessage.tool_calls` provides a standardized interface for getting model tool invocations. So after calling a model with bound tools, you'll get an output of the form:

在使用工具调用（tool-calling）模型的早期，模型返回的任何工具调用均根据模型提供商的 API，位于 `AIMessage.additional_kwargs` 或 `AIMessage.content` 中，并遵循该提供商特有的格式。也就是说，你需要编写自定义逻辑，才能从不同模型的输出中提取工具调用信息。如今，`AIMessage.tool_calls` 提供了一个标准化接口，用于统一获取模型发起的工具调用。因此，在调用已绑定工具的模型后，你将获得如下形式的输出：

```python
llm_with_tools.invoke([\
	("system", "You're a helpful assistant"),\
	("human", "what's 5 raised to the 2.743"),\
])

# 👀 Notice the tool_calls attribute 👀

# -> AIMessage(
# 	  content=...,
# 	  additional_kwargs={...},
# 	  tool_calls=[{'name': 'exponentiate', 'args': {'y': 2.743, 'x': 5.0}, 'id': '54c166b2-f81a-481a-9289-eea68fc84e4f'}]
# 	  response_metadata={...},
# 	  id='...'
#   )
```

```python
llm_with_tools.invoke([\
	("system", "你是一位乐于助人的助手"),\
	("human", "5 的 2.743 次方是多少？"),\
])

# 👀 注意 tool_calls 属性 👀

# -> AIMessage(
# 	  content=...,
# 	  additional_kwargs={...},
# 	  tool_calls=[{'name': 'exponentiate', 'args': {'y': 2.743, 'x': 5.0}, 'id': '54c166b2-f81a-481a-9289-eea68fc84e4f'}]
# 	  response_metadata={...},
# 	  id='...'
#   )
```

where the `AIMessage` has a `tool_calls: List[ToolCall]` attribute that will be populated if there are any tool invocations and will follow a standard interface for the tool calls:

其中，`AIMessage` 具有一个 `tool_calls: List[ToolCall]` 属性：只要存在工具调用，该属性就会被填充，并且所有工具调用均遵循统一的标准接口：

```python
class ToolCall(TypedDict):
  name: str
  args: Dict[str, Any]
	id: Optional[str]
```

```python
class ToolCall(TypedDict):
  name: str
  args: Dict[str, Any]
	id: Optional[str]
```

That is, whether you’re calling Anthropic, OpenAI, Gemini, etc., whenever there’s a tool call it will be in `AIMessage.tool_calls` as a `ToolCall`.

也就是说，无论你调用的是 Anthropic、OpenAI、Gemini 还是其他支持工具调用的模型，只要模型返回了工具调用，它都将统一以 `ToolCall` 对象的形式出现在 `AIMessage.tool_calls` 中。

There’s a few other attributes we’ve added for handling streamed tool call chunks and invalid tool calls. Read more about those in the tool-calling docs [here](https://python.langchain.com/docs/modules/model_io/chat/function_calling/?ref=blog.langchain.com).

我们还新增了若干其他属性，用于处理流式传输的工具调用分块（streamed tool call chunks）以及无效的工具调用（invalid tool calls）。更多详情请参阅工具调用文档：[此处](https://python.langchain.com/docs/modules/model_io/chat/function_calling/?ref=blog.langchain.com)。

## `create_tool_calling_agent()`

## `create_tool_calling_agent()`

One of the most powerful and obvious uses for LLM tool-calling abilities is to build agents. LangChain already has a `create_openai_tools_agent()` constructor that makes it easy to build an agent with tool-calling models that adhere to the OpenAI tool-calling API, but this won’t work for models like Anthropic and Gemini. Thanks to the new `bind_tools()` and `tool_calls` interfaces, we’ve added a `create_tool_calling_agent()` that works with any tool-calling model.

利用大语言模型（LLM）的工具调用能力，构建智能体（agents）是最强大也最直观的应用之一。LangChain 此前已提供 `create_openai_tools_agent()` 构造器，可便捷地基于符合 OpenAI 工具调用 API 的模型构建智能体；但该构造器不适用于 Anthropic、Gemini 等非 OpenAI 标准的模型。得益于新引入的 `bind_tools()` 和 `tool_calls` 接口，我们现在新增了通用型的 `create_tool_calling_agent()`，它可与**任意支持工具调用的模型**协同工作。

```python
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import ConfigurableField
from langchain_core.tools import tool
from langchain.agents import create_tool_calling_agent, AgentExecutor

@tool
def multiply(x: float, y: float) -> float:
    """Multiply 'x' times 'y'."""
    return x * y

@tool
def exponentiate(x: float, y: float) -> float:
    """Raise 'x' to the 'y'."""
    return x**y

@tool
def add(x: float, y: float) -> float:
    """Add 'x' and 'y'."""
    return x + y

prompt = ChatPromptTemplate.from_messages([\
    ("system", "you're a helpful assistant"),\
    ("human", "{input}"),\
    ("placeholder", "{agent_scratchpad}"),\
])

tools = [multiply, exponentiate, add]

llm = ChatAnthropic(model="claude-3-sonnet-20240229", temperature=0)

agent = create_tool_calling_agent(llm, tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

agent_executor.invoke({"input": "what's 3 plus 5 raised to the 2.743. also what's 17.24 - 918.1241", })
```

我们可以改用 VertexAI。

```python
from langchain_google_vertexai import ChatVertexAI

llm = ChatVertexAI(
	model="gemini-pro",
	temperature=0,
	convert_system_message_to_human=True
)
agent = create_tool_calling_agent(llm, tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

agent_executor.invoke({"input": "what's 3 plus 5 raised to the 2.743. also what's 17.24 - 918.1241", })
```

```python
from langchain_google_vertexai import ChatVertexAI

llm = ChatVertexAI(
	model="gemini-pro",
	temperature=0,
	convert_system_message_to_human=True
)
agent = create_tool_calling_agent(llm, tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

agent_executor.invoke({"input": "what's 3 plus 5 raised to the 2.743. also what's 17.24 - 918.1241", })
```

或者使用 OpenAI：

```python
llm = ChatOpenAI(model="gpt-3.5-turbo-0125", temperature=0)

agent = create_tool_calling_agent(llm, tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

agent_executor.invoke({"input": "what's 3 plus 5 raised to the 2.743. also what's 17.24 - 918.1241", })
```

```python
llm = ChatOpenAI(model="gpt-3.5-turbo-0125", temperature=0)

agent = create_tool_calling_agent(llm, tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

agent_executor.invoke({"input": "what's 3 plus 5 raised to the 2.743. also what's 17.24 - 918.1241", })
```

等等。

有关该新型智能体（agent）的完整文档，请参见[此处](https://python.langchain.com/docs/modules/agents/agent_types/tool_calling/?ref=blog.langchain.com)。

## LangGraph

## LangGraph

If you haven’t already checked out [LangGraph](https://python.langchain.com/docs/langgraph/?ref=blog.langchain.com), you absolutely should. It is an extension of LangChain that makes it easy to construct arbitrary agent and multi-agent flows. As you can imagine, using the new `tool_calls` interface also makes life simpler when constructing LangGraph agents or flows. Check out the [notebook here](https://github.com/langchain-ai/langchain/blob/master/cookbook/tool_call_messages.ipynb?ref=blog.langchain.com) for a detailed walkthrough of how to use `tool_calls` in a LangGraph agent.

如果您尚未了解 [LangGraph](https://python.langchain.com/docs/langgraph/?ref=blog.langchain.com)，那您绝对应该试一试。它是 LangChain 的一个扩展，可轻松构建任意类型的智能体（agent）及多智能体（multi-agent）工作流。不难想象，使用全新的 `tool_calls` 接口，在构建 LangGraph 智能体或工作流时也会让开发更简单。请查看 [此处的 Notebook](https://github.com/langchain-ai/langchain/blob/master/cookbook/tool_call_messages.ipynb?ref=blog.langchain.com)，其中详细演示了如何在 LangGraph 智能体中使用 `tool_calls`。

## [`with_structured_output`](https://python.langchain.com/docs/modules/model_io/chat/structured_output/?ref=blog.langchain.com)

## [`with_structured_output`](https://python.langchain.com/docs/modules/model_io/chat/structured_output/?ref=blog.langchain.com)

We recently released the `ChatModel.with_structured_output()` interface for getting structured outputs from a model, which is very related. While the exact implementation varies by model provider, `with_structured_output` is built _on top_ of tool-calling for most models that support it. Under the hood, `with_structured_output` uses `bind_tools` to pass the given structured output schema to the model.

我们近期发布了 `ChatModel.with_structured_output()` 接口，用于从大语言模型中获取结构化输出，该功能与工具调用高度相关。尽管不同模型提供商的具体实现略有差异，但对于大多数支持该功能的模型而言，`with_structured_output` 都是构建在工具调用（tool-calling）之上的。其底层机制是通过 `bind_tools` 将用户指定的结构化输出 Schema 传递给模型。

So when should you use `with_structured_output` versus binding tools and reading tool calls directly?

那么，何时应选用 `with_structured_output`，而何时又该直接绑定工具并解析工具调用（tool calls）呢？

`with_structured_output` always returns a structured output in the schema that you specified. This is useful when you want to force the LLM to output information that matches a specific schema. This is useful for information extraction tasks.

`with_structured_output` 始终返回严格符合您所指定 Schema 的结构化输出。当您需要强制大语言模型（LLM）输出符合特定 Schema 的信息时，这一功能非常有用——例如在信息抽取类任务中。

`bind_tools` is more general and can select a specific tool - or no tool, or multiple tools! This is useful when you want to allow the LLM to have more flexibility in how it should respond - for example, in agent applications where you need to choose which tools to invoke but also respond to the user.

`bind_tools` 则更为通用，它支持选择某个特定工具、不调用任何工具，或同时调用多个工具！当您希望赋予大语言模型更大的响应灵活性时，这一方式尤为适用——例如在智能体（agent）应用中，既需决定调用哪些工具，又需向用户作出自然回应。

## **Conclusion**

## **总结**

We expect that the trend to introduce native tool calling capabilities into LLMs will continue in the future. We hope that the standardized tool calling interface can help save LangChain users time and effort and allow them to switch between different LLM providers more easily.

我们预计，未来将大语言模型原生工具调用能力（native tool calling capabilities）集成进模型的趋势将持续发展。我们希望这一标准化的工具调用接口，能够帮助 LangChain 用户节省时间与精力，并更便捷地在不同大语言模型提供商之间切换。

Remember to update your `langchain_core` and partner package versions to leverage the new interfaces!

请务必更新您的 `langchain_core` 及相关配套包版本，以启用这些新接口！

We’d love to [hear any feedback](https://github.com/langchain-ai/langchain/discussions/20343?ref=blog.langchain.com) from you!

我们非常期待收到您的[任何反馈](https://github.com/langchain-ai/langchain/discussions/20343?ref=blog.langchain.com)！