---
title: "Structured Tools"
source: "LangChain Blog"
url: "https://blog.langchain.com/structured-tools/"
date: "2023-11-14"
scraped_at: "2026-03-03T08:27:41.336328704+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

**TL;DR: we're introducing a new abstraction to allow for usage of more complex tools. While previous tools took in a single string input, new tools can take in an arbitrary number of inputs of arbitrary types. We are also introducing a new agent class that works well with these new types of tools.**

**简明摘要：我们正在引入一种新抽象机制，以支持更复杂工具的使用。此前的工具仅接受单个字符串输入；而新工具可接收任意数量、任意类型的输入。同时，我们还推出了一种新型 Agent 类，专为适配此类新工具而设计。**

**Important Links:**

**重要链接：**

- [**Tools list**](https://python.langchain.com/docs/modules/agents/tools?ref=blog.langchain.com)  
- [**New agent**](https://python.langchain.com/docs/modules/agents/agent_types/structured_chat?ref=blog.langchain.com)

- [**工具列表**](https://python.langchain.com/docs/modules/agents/tools?ref=blog.langchain.com)  
- [**新型 Agent**](https://python.langchain.com/docs/modules/agents/agent_types/structured_chat?ref=blog.langchain.com)

Way back in November 2022 when we first launched LangChain, agent and tool utilization played a central role in our design. We built one of the first chains based on [**ReAct**](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2210.xml?ref=blog.langchain.com), a groundbreaking paper that brought tool use to the forefront of prompting frameworks.

早在 2022 年 11 月 LangChain 首次发布时，Agent 与工具的协同使用便在我们的整体架构设计中占据核心地位。我们构建了首批链式流程之一，其灵感源自开创性论文 [**ReAct**](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2210.xml?ref=blog.langchain.com)，该论文首次将“工具调用”置于提示工程（prompting frameworks）范式的中心位置。

In the early days, tool use was simplistic. A model would generate two strings:

1. A tool name  
2. An input string for the chosen tool  

在早期阶段，工具调用方式较为简单：模型仅需生成两个字符串：

1. 工具名称  
2. 传入所选工具的输入字符串  

This approach confined the agent to one tool per turn, and the input to that tool was restricted to a single string. These limitations were primarily due to the model's constraints; models struggled to perform even these basic tasks proficiently. Reliably executing more complex operations, such as selecting multiple tools or populating complex schema, would have been a fool’s errand.

这种设计将 Agent 严格限制为每轮仅能调用一个工具，且该工具的输入也仅限于单一字符串。这些限制主要源于当时大语言模型的能力瓶颈——即便完成上述基础任务，模型也常表现乏力。若试图可靠地执行更复杂的操作（例如同时选择多个工具，或填充结构复杂的 Schema），无异于缘木求鱼。

However, the rapid development of more advanced language models like `text-davinci-003`, `gpt-3.5-turbo`, and `gpt-4` has raised the floor of what available models can reliably achieve. This prompted us to reassess the limitations on tool usage within LangChain's agent framework.

然而，以 `text-davinci-003`、`gpt-3.5-turbo` 和 `gpt-4` 等为代表的更先进语言模型正飞速演进，显著提升了当前可用模型所能稳定达成的能力下限。这促使我们重新审视 LangChain Agent 框架中对工具使用的既有约束。

Earlier this year, we introduced a "multi-action" agent framework, where agents can plan multiple actions to perform on each step of the agent executor. Building on that success, we are now breaking free from the single-string input constraint and proudly offering structured tool support!

今年早些时候，我们推出了“多动作（multi-action）”Agent 框架，使 Agent 能在每次执行步骤中规划并执行多个动作。在此基础上，我们进一步突破单一字符串输入的桎梏，正式推出**结构化工具（structured tool）支持**！

Structured tool’s enable more complex, multi-faceted interactions between language models and tools, making it easier to build innovative, adaptable, and powerful applications.

结构化工具赋能语言模型与工具之间开展更复杂、多维度的交互，从而大幅降低构建创新型、高适应性及强功能应用的门槛。

## What is a “Structured Tool”?

## 什么是“结构化工具”？

A structured tool represents an action an agent can take. It wraps any function you provide to let an agent easily interface with it. A Structured Tool object is defined by its:

一个结构化工具代表智能体（agent）可执行的一项操作。它封装了您提供的任意函数，使智能体能够轻松地与之交互。一个 `StructuredTool` 对象由以下要素定义：

1. `name`: a label telling the agent which tool to pick. For example, a tool named "GetCurrentWeather" tells the agent that it's for finding the current weather.  
1. `name`（名称）：用于标识该工具的标签，告诉智能体在何时选择此工具。例如，名为 `"GetCurrentWeather"` 的工具即表明其用途是获取当前天气。

2. `description`: a short instruction manual that explains when and why the agent should use the tool.  
2. `description`（描述）：一份简明的操作指南，说明智能体应在何时、为何使用该工具。

3. `args_schema`: Communicates the interface of the tool for the agent. It typically draws from the wrapped function's signature and permits additional validation logic on tool inputs.  
3. `args_schema`（参数模式）：向智能体传达该工具的接口规范。它通常基于被封装函数的签名定义，并支持对工具输入施加额外的校验逻辑。

4. `_run` and `_arun` functions: These define the tool's inner workings. It could be something simple like returning the current time or more complex like sending a message or controlling a robot.  
4. `_run` 和 `_arun` 方法：定义工具的核心逻辑。其内容可以非常简单（例如返回当前时间），也可以相当复杂（例如发送消息或控制机器人）。

The tool `name` is its unique identifier. A good name unambiguously communicates what it does, so a tool called “GetCurrentWeather” is much more useful than “GCTW” . If a tool’s name isn’t clear to you, it probably isn’t clear to the agent either. If you are giving an agent access to multiple tools, the name could also provide information about their relationship. For instance, if you have “AmazonSearch” and “AmazonCurrentBalance” and “NikeShoppingCart” tools, the agent can infer that the first two are related, even without reading the description.

工具的 `name` 是其唯一标识符。一个优秀的名称应无歧义地传达其功能——因此名为 `"GetCurrentWeather"` 的工具远比 `"GCTW"` 更具实用性。如果连您自己都无法清晰理解某个工具的名称，那么智能体很可能也无法理解。当您为智能体提供多个工具时，名称还可隐含工具之间的关联性。例如，若您提供了 `"AmazonSearch"`、`"AmazonCurrentBalance"` 和 `"NikeShoppingCart"` 这三个工具，智能体即使未阅读描述，也能推断出前两者属于同一服务（亚马逊）体系。

The `description` provides more detailed directives on how to use the tool. A good description is concise but effectively communicates what the tool does. This can also provide space to provide short examples (or counter examples) if needed.

`description` 提供关于如何使用该工具的更详细指引。一份优秀的描述应简洁明了，同时准确传达工具的功能；必要时，还可在此处加入简短的示例（或反例）。

The `args_schema` is a Pydantic `BaseModel` that defines the arguments (along with their type information) that are to be fed to the tool. It has two main jobs: first, to communicate what information is required from the agent. The second job is to validate those inputs before executing the tool's inner functionality.

`args_schema` 是一个 Pydantic `BaseModel`，用于定义传入该工具的参数及其类型信息。它承担两项核心职责：第一，明确告知智能体需要提供哪些信息；第二，在执行工具内部逻辑前，对这些输入进行校验。

Finally, the `_run` and accompanying async `_arun` methods define tool’s logic. You can put anything here, from arithmetic, to API requests, to calls to other LLM Chains.

最后，`_run` 及其配套的异步方法 `_arun` 定义了工具的具体逻辑。此处可实现任意功能，包括基础算术运算、API 请求，乃至调用其他 LLM Chain。

## New Structured Tools

## 新增结构化工具

In addition to this new base class, we are releasing the following new tools, both of which inherit from this structured tool class.

除这一全新基类外，我们还同步发布以下两个新工具，二者均继承自该结构化工具类：

- File management - a toolkit for all the filesystem operations you might want, including write, grep, move, copy, list\_dir, find  
- 文件管理工具包——涵盖您可能需要的所有文件系统操作，包括写入（write）、文本搜索（grep）、移动（move）、复制（copy）、列出目录（list_dir）、查找文件（find）

- Web Browser - while we previously had browsers for document loaders, we now are releasing an official stateful PlayWright Browser toolkit that let’s an agent go to websites, click, submit forms, and query data  
- 网页浏览器工具包——此前我们仅在文档加载器中提供过浏览器能力；如今我们正式发布具备状态保持能力的 Playwright 浏览器工具包，支持智能体访问网站、点击元素、提交表单及查询网页数据

For a list of all tools (old and new) please see the documentation [here](https://python.langchain.com/docs/modules/agents/tools?ref=blog.langchain.com).

如需查看所有工具（包括旧版和新版）的完整列表，请参阅[此处](https://python.langchain.com/docs/modules/agents/tools?ref=blog.langchain.com)的文档。

### Implementing your own Structured Tools

### 实现您自己的结构化工具（Structured Tools）

The fastest way to get started is by calling the `StructuredTool.from_function(your_callable)` constructor.

最快上手的方式是调用 `StructuredTool.from_function(your_callable)` 构造函数。

As an example, suppose you wanted a tool to interact with Hugging Face models via the `requests` library.

例如，假设您希望创建一个工具，通过 `requests` 库与 Hugging Face 模型进行交互。

```python
import requests
from langchain.tools.base import StructuredTool

API_KEY = "<MY-API-KEY>"

def get_huggingface_models(
    path: Optional[str] = None, query_params: Optional[dict] = None
) -> dict:
    """Tool that calls GET on <https://huggingface.co/models*> apis. Valid params include "search":"search", "author":"author", "filter":"filter" and "sort":"sort"."""
    base_url = "<https://huggingface.co/api/models>"
    headers = {"authorization": f"Bearer {API_KEY}"}
    result = requests.get(base_url + (path or ""), params=query_params, headers=headers)
    return result.json()

get_huggingface_models_tool = StructuredTool.from_function(get_huggingface_models)
models = get_huggingface_models_tool.run({"query_params": {"search": "gpt-j"}})
print(models)
```

```python
import requests
from langchain.tools.base import StructuredTool

API_KEY = "<MY-API-KEY>"

def get_huggingface_models(
    path: Optional[str] = None, query_params: Optional[dict] = None
) -> dict:
    """Tool that calls GET on <https://huggingface.co/models*> apis. Valid params include "search":"search", "author":"author", "filter":"filter" and "sort":"sort"."""
    base_url = "<https://huggingface.co/api/models>"
    headers = {"authorization": f"Bearer {API_KEY}"}
    result = requests.get(base_url + (path or ""), params=query_params, headers=headers)
    return result.json()

get_huggingface_models_tool = StructuredTool.from_function(get_huggingface_models)
models = get_huggingface_models_tool.run({"query_params": {"search": "gpt-j"}})
print(models)
```

Behind the scenes, this infers the `args_schema` from the function’s signature. This is used tell the agent that it can provide query parameters to search as well as a path parameter to call other child endpoints.

在底层，该方法会根据函数签名自动推断出 `args_schema`。这一机制用于告知 Agent：它既可传入查询参数（query parameters）执行搜索，也可传入路径参数（path parameter）调用其他子端点（child endpoints）。

If you want more control over the tool definition, you can subclass the `BaseTool` directly. For instance, maybe you want the api key to be loaded automatically from the environment variables.

如果您希望更精细地控制工具定义，可以直接继承 `BaseTool` 类。例如，您可能希望 API 密钥能自动从环境变量中加载。

```python
from typing import Optional, Type

import aiohttp
import requests

from langchain.callbacks.manager import (
    AsyncCallbackManagerForToolRun,
    CallbackManagerForToolRun,
)
from langchain.tools import BaseTool
from pydantic import BaseModel, BaseSettings, Field

class GetHuggingFaceModelsToolSchema(BaseModel):
    path: str = Field(default="", description="the api path")
    query_params: Optional[dict] = Field(
        default=None, description="Optional search parameters"
    )

class GetHuggingFaceModelsTool(BaseTool, BaseSettings):
    """My custom tool."""

    name: str = "get_huggingface_models"
    description: str = """Tool that calls GET on <https://huggingface.co/models*> apis. Valid params include "search":"search", "author":"author", "filter":"filter" and "sort":"sort"."""
    args_schema: Type[GetHuggingFaceModelsToolSchema] = GetHuggingFaceModelsToolSchema
    base_url: str = "<https://huggingface.co/api/models>"
    api_key: str = Field(..., env="HUGGINGFACE_API_KEY")

    @property
    def _headers(self) -> dict:
        return {"authorization": f"Bearer {self.api_key}"}

    def _run(
        self,
        path: str = "",
        query_params: Optional[dict] = None,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> dict:
        """Run the tool"""
        result = requests.get(
            self.base_url + path, params=query_params, headers=self._headers
        )
        return result.json()

    async def _arun(
        self,
        path: str = "",
        query_params: Optional[dict] = None,
        run_manager: Optional[AsyncCallbackManagerForToolRun] = None,
    ) -> dict:
        """Run the tool asynchronously."""

        async with aiohttp.ClientSession() as session:
            async with session.get(
                self.base_url + path, params=query_params, headers=self._headers
            ) as response:
                return await response.json()
```

```python
from typing import Optional, Type

import aiohttp
import requests

from langchain.callbacks.manager import (
    AsyncCallbackManagerForToolRun,
    CallbackManagerForToolRun,
)
from langchain.tools import BaseTool
from pydantic import BaseModel, BaseSettings, Field

class GetHuggingFaceModelsToolSchema(BaseModel):
    path: str = Field(default="", description="API 路径")
    query_params: Optional[dict] = Field(
        default=None, description="可选的搜索参数"
    )

class GetHuggingFaceModelsTool(BaseTool, BaseSettings):
    """我的自定义工具。"""

    name: str = "get_huggingface_models"
    description: str = """该工具向 <https://huggingface.co/models*> 相关 API 发起 GET 请求。支持的有效参数包括 "search":"搜索词"、"author":"作者"、"filter":"过滤器" 和 "sort":"排序方式"。"""
    args_schema: Type[GetHuggingFaceModelsToolSchema] = GetHuggingFaceModelsToolSchema
    base_url: str = "<https://huggingface.co/api/models>"
    api_key: str = Field(..., env="HUGGINGFACE_API_KEY")

    @property
    def _headers(self) -> dict:
        return {"authorization": f"Bearer {self.api_key}"}

    def _run(
        self,
        path: str = "",
        query_params: Optional[dict] = None,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> dict:
        """执行该工具"""
        result = requests.get(
            self.base_url + path, params=query_params, headers=self._headers
        )
        return result.json()

    async def _arun(
        self,
        path: str = "",
        query_params: Optional[dict] = None,
        run_manager: Optional[AsyncCallbackManagerForToolRun] = None,
    ) -> dict:
        """异步执行该工具。"""

        async with aiohttp.ClientSession() as session:
            async with session.get(
                self.base_url + path, params=query_params, headers=self._headers
            ) as response:
                return await response.json()
```

```python
get_models_tool = GetHuggingFaceModelsTool()
models = get_models_tool.run({"query_params": {"search": "gpt-j"}})
print(models)
```

```python
get_models_tool = GetHuggingFaceModelsTool()
models = get_models_tool.run({"query_params": {"search": "gpt-j"}})
print(models)
```

## How can I use Structured Tools?

## 如何使用结构化工具（Structured Tools）？

We have added a new `StructuredChatAgent` that works natively with these structured tools. Please see [this page](https://python.langchain.com/docs/modules/agents/agent_types/structured_chat?ref=blog.langchain.com) for a walkthrough.

我们新增了一个原生支持此类结构化工具的 `StructuredChatAgent`。请参阅[此页面](https://python.langchain.com/docs/modules/agents/agent_types/structured_chat?ref=blog.langchain.com)，获取详细操作指南。

Due to limitations in the default prompts and output parsers of previous agents, they do not effectively work with structured tools without extra customization.

由于此前各类 Agent 的默认提示词（prompt）和输出解析器（output parser）存在局限性，若不进行额外定制，它们无法有效支持结构化工具。

To get started, you can instantiate the structured chat agent executor using the following code snippet:

如需快速上手，可使用以下代码片段实例化结构化聊天 Agent 执行器（structured chat agent executor）：

```python
from langchain.agents import initialize_agent, AgentType
from langchain.chat_models import ChatAnthropic
tools = [] # Add any tools here
llm = ChatAnthropic(temperature=0) # or any other LLM
agent_chain = initialize_agent(tools, llm, agent=AgentType.STRUCTURED_CHAT_ZERO_SHOT_REACT_DESCRIPTION)
```

```python
from langchain.agents import initialize_agent, AgentType
from langchain.chat_models import ChatAnthropic
tools = [] # 在此处添加任意工具
llm = ChatAnthropic(temperature=0) # 或其他任意大语言模型（LLM）
agent_chain = initialize_agent(tools, llm, agent=AgentType.STRUCTURED_CHAT_ZERO_SHOT_REACT_DESCRIPTION)
```

These tools are also compatible with the `AutoGPT` agent from `langchain.experimental`.

这些工具同样兼容 `langchain.experimental` 中的 `AutoGPT` Agent。

## FAQ

## 常见问题（FAQ）

**Q: Can I use structured tools with existing agents?**

**问：我能将结构化工具与现有 Agent 配合使用吗？**

A: If your structured tool accepts one string argument: **YES**, it will still work with existing agents. However, structured tool with more than one argument are not directly compatible with the following agents without further customization:

答：若您的结构化工具仅接受一个字符串参数：**可以**，它仍能与现有 Agent 正常协作；但若结构化工具接受两个或更多参数，则在未经进一步定制的情况下，无法直接与以下 Agent 兼容：

- `zero-shot-react-description`  
- `zero-shot-react-description`（零样本 ReAct 描述型工具）

- `react-docstore`  
- `react-docstore`（ReAct 文档存储型工具）

- `self-ask-with-search`  
- `self-ask-with-search`（自提问+搜索型工具）

- `conversational-react-description`  
- `conversational-react-description`（对话式 ReAct 描述型工具）

- `chat-zero-shot-react-description`  
- `chat-zero-shot-react-description`（聊天式零样本 ReAct 描述型工具）

- `chat-conversational-react-description`  
- `chat-conversational-react-description`（聊天式对话式 ReAct 描述型工具）

**Q: Can I still create string Tools?**  
**Q：我还能创建字符串型工具（string Tools）吗？**

A: You can still use the `Tool` constructor and `@tool` decorators to define simple string tools. Tools that inherit from the `BaseTool` class and accept a single string argument will still be treated as string tools.  
A：您仍可使用 `Tool` 构造函数和 `@tool` 装饰器来定义简单的字符串型工具。继承自 `BaseTool` 类、且仅接受单个字符串参数的工具，仍将被视作字符串型工具。

**Q: Can I use previously defined string `BaseTool`'s with new agents built for `StructuredTool`’s**  
**Q：我能否将先前定义的字符串型 `BaseTool` 与专为 `StructuredTool` 设计的新版智能体（agents）配合使用？**

A: Yes! Structured tools don’t require new agent executors, and older tools are forwards compatible. The original `Tool` class shares the same base class as the `StructuredTool`, which is another way of saying your tools should work out of the box.  
A：可以！结构化工具（Structured Tools）无需新的智能体执行器（agent executors），旧版工具具备前向兼容性。原始的 `Tool` 类与 `StructuredTool` 共享同一基类，换言之，您的工具应能即插即用（out of the box）。

Tools that expect json serialized string inputs may require some modifications to interoperate with the output parser of newer agents, or they can be updated to the new format, which should offer better support for more complex interfaces.  
对于期望接收 JSON 序列化字符串输入的工具，可能需要稍作调整以适配新版智能体的输出解析器（output parser）；或者，您也可将其升级为新格式——该格式将为更复杂的接口提供更完善的支持。

### Tags  
### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  
[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/structured-tools/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[![评估深度智能体：我们的经验总结](images/structured-tools/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/structured-tools/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/structured-tools/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 3 分钟

[![LangChain State of AI 2024 Report](images/structured-tools/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/structured-tools/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/structured-tools/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/structured-tools/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/structured-tools/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/structured-tools/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/structured-tools/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/structured-tools/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
