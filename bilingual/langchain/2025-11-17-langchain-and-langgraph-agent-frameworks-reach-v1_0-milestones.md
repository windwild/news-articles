---
title: "LangChain and LangGraph Agent Frameworks Reach v1.0 Milestones"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-langgraph-1dot0/"
date: "2025-11-17"
scraped_at: "2026-03-03T07:18:54.256545577+00:00"
language: "en-zh"
translated: true
---

_By Sydney Runkle and the LangChain OSS team_

_作者：Sydney Runkle 与 LangChain 开源团队_

We're releasing LangChain 1.0 and LangGraph 1.0 — our first major versions of our open source frameworks! After years of feedback, we've updated `langchain` to focus on the core agent loop, provide flexibility with a new concept of middleware, and upgrade model integrations with the latest content types.

我们正式发布 LangChain 1.0 和 LangGraph 1.0 —— 这是我们开源框架的首个主要版本！经过数年的用户反馈，我们对 `langchain` 包进行了全面更新：聚焦于核心的智能体（agent）执行循环，引入一种全新的“中间件（middleware）”概念以增强灵活性，并基于最新的内容类型升级了大模型集成能力。

These two frameworks serve different purposes:

这两个框架面向不同的使用场景：

- **LangChain** is the fastest way to build an AI agent — with a standard tool calling architecture, provider agnostic design, and middleware for customization.  
- **LangChain** 是构建 AI 智能体的最快途径——具备标准化的工具调用架构、与模型提供商无关的设计，以及支持高度定制化的中间件机制。

- **LangGraph** is a lower level framework and runtime, useful for highly custom and controllable agents, designed to support production-grade, long running agents  
- **LangGraph** 是一个更底层的框架与运行时系统，适用于需要高度定制化与精细控制的智能体，专为支持生产级、长期运行的智能体而设计。

These 1.0 releases mark our commitment to stability for our open source libraries and no breaking changes until 2.0. Alongside these releases, we're launching a completely redesigned [docs site](https://docs.langchain.com/oss/python/langchain/overview?ref=blog.langchain.com).

此次 1.0 版本的发布，标志着我们对开源库稳定性的郑重承诺：在 2.0 版本之前，将不会引入任何破坏性变更。与此同时，我们还推出了全面重构的全新[文档网站](https://docs.langchain.com/oss/python/langchain/overview?ref=blog.langchain.com)。

Learn more about the changes below, and check our [behind-the-scenes](https://youtu.be/r5Z_gYZb4Ns?ref=blog.langchain.com) [conversation](https://youtu.be/r5Z_gYZb4Ns?ref=blog.langchain.com) with our engineers for more commentary.

下方将详细介绍本次更新内容；您还可观看我们与工程师团队深入探讨技术细节的[幕后对话视频](https://youtu.be/r5Z_gYZb4Ns?ref=blog.langchain.com)。

## LangChain 1.0

## LangChain 1.0

LangChain has always offered high-level interfaces for interacting with LLMs and building agents. With standardized model abstractions and prebuilt agent patterns, it helps developers ship AI features fast and build sophisticated applications without vendor lock-in. This is essential in a space where the best model for any given task changes regularly.

LangChain 始终提供高层次接口，用于与大语言模型（LLM）交互及构建智能体。凭借标准化的模型抽象层与预置的智能体模式，它帮助开发者快速交付 AI 功能，并构建复杂应用，同时避免厂商锁定（vendor lock-in）。在当前这个“针对任一具体任务，最优模型都可能频繁更迭”的领域中，这一点尤为关键。

**We've been listening.** Over the past three years, we've heard consistent feedback: LangChain's abstractions were sometimes too heavy, the package surface area had grown unwieldy, and developers wanted more control over the agent loop without dropping down to raw LLM calls. Some struggled with customization when their use cases diverged from our prebuilt patterns. We took this feedback seriously. LangChain 1.0 is our response— a thoughtful refinement that preserves what works while fixing what didn't.

**我们一直在倾听。** 过去三年间，我们持续收到一致反馈：LangChain 的抽象层有时过于厚重，包的接口范围（surface area）已变得难以驾驭；开发者希望在不退回到原始 LLM 调用的前提下，对智能体执行循环拥有更强的控制力；当实际应用场景偏离我们预置的智能体模式时，部分用户在定制化方面遇到了困难。我们高度重视这些反馈。LangChain 1.0 正是我们的回应——一次深思熟虑的精炼升级：保留行之有效的部分，同时修正不足之处。

> "We rely heavily on the durable runtime that LangGraph provides under the hood to support our agent developments, and the new agent prebuilt and middleware in LangChain 1.0 makes it far more flexible than before. We're excited about 1.0 and are already building with the new features at Rippling." – **Ankur Bhatt, Head of AI at Rippling**  
> “我们高度依赖 LangGraph 在底层提供的稳健运行时系统来支撑智能体开发；而 LangChain 1.0 中新增的预置智能体组件与中间件机制，则使其灵活性远超以往。我们对 1.0 版本倍感振奋，Rippling 团队目前已开始基于这些新特性开展实际开发。” —— **Rippling 公司 AI 负责人 Ankur Bhatt**

We’re leaning hard into three things for LangChain 1.0:

LangChain 1.0 将重点聚焦于以下三大方向：

1. **Our new `create_agent` abstraction:** the fastest way to build an agent with any model provider  
1. **全新的 `create_agent` 抽象层：** 支持任意模型提供商，是构建智能体（agent）最快捷的方式  
1. Built on the LangGraph runtime, helping to power reliable agents  
2. 基于 LangGraph 运行时构建，助力打造高可靠性智能体  
2. Prebuilt and user defined middleware enable step by step control and customization  
3. 内置及用户自定义中间件，支持逐步骤控制与灵活定制  
2. **Standard content blocks:** a provider agnostic spec for model outputs.  
2. **标准化内容区块（Standard content blocks）：** 一套与模型提供商无关的模型输出规范。  
3. **Streamlined surface area:** we’re trimming down our namespace to focus on what developers use to build agents.  
3. **精简的 API 表面区域（Streamlined surface area）：** 我们正大幅精简命名空间，聚焦开发者构建智能体时真正需要的核心功能。

### 1\. `create_agent`

### 1. `create_agent`

The `create_agent` abstraction is built around the core agent loop, making it easy to get started quickly. Here's how the loop works:

`create_agent` 抽象层围绕核心智能体循环（agent loop）构建，让开发者能够快速上手。该循环的工作流程如下：

**Setup:** select a model and give it some tools and a prompt.  
**初始化设置（Setup）：** 选择一个模型，并为其配置若干工具（tools）和提示词（prompt）。

**Execution:**  
**执行（Execution）：**  

1. Send a request to the model  
1. 向模型发送请求  
2. The model responds with either:  
2. 模型返回以下两种响应之一：  
1. Tool calls → execute the tool and add results to the conversation  
1. 工具调用（Tool calls）→ 执行对应工具，并将结果加入对话上下文  
2. Final answer → return the result  
2. 最终答案（Final answer）→ 直接返回结果  
3. Repeat from step 1  
3. 返回第 1 步，继续循环  

![](images/langchain-and-langgraph-agent-frameworks-reach-v1_0-milestones/img_001.png)

![](images/langchain-and-langgraph-agent-frameworks-reach-v1_0-milestones/img_001.png)

The new `create_agent` function uses LangGraph under the hood to run this loop. It has a very similar feel to the `create_react_agent` function from `langgraph.prebuilts`, which has been used in production for a year.

新版 `create_agent` 函数在底层依托 LangGraph 运行该循环。其使用体验与 `langgraph.prebuilts` 中已投入生产环境使用一年之久的 `create_react_agent` 函数高度相似。

Getting started with an agent in `langchain` is easy:  
在 `langchain` 中快速启动一个智能体非常简单：

```python
from langchain.agents import create_agent

weather_agent = create_agent(
    model="openai:gpt-5",
    tools=[get_weather],
    system_prompt="Help the user by fetching the weather in their city.",
)

result = agent.invoke({"role": "user", "what's the weather in SF?"})
```

```python
from langchain.agents import create_agent

weather_agent = create_agent(
    model="openai:gpt-5",
    tools=[get_weather],
    system_prompt="帮助用户获取其所在城市的天气信息。",
)

result = agent.invoke({"role": "user", "旧金山的天气如何？"})
```

Most agent builders are highly restrictive in that they don’t permit customization outside of this core loop. That’s where `create_agent` stands out with our introduction of `middleware`.

大多数智能体（agent）构建工具限制性极强，不允许用户在该核心执行循环之外进行任何定制。而 `create_agent` 正是凭借我们引入的 `middleware`（中间件）机制脱颖而出。

**Middleware:**

**中间件（Middleware）：**

Middleware defines a set of hooks that allow you to customize behavior in the agent loop, enabling fine grained control at every step an agent takes.

中间件定义了一组钩子（hooks），允许您自定义智能体执行循环中的行为，从而在智能体运行的每一步都实现精细化控制。

We’re including a few built-in middlewares for common use cases:

我们内置了若干适用于常见场景的中间件：

- **Human-in-the-loop:** Pause agent execution to let users approve, edit, or reject tool calls before they execute. This is essential for agents that interact with external systems, send communications, or make sensitive transactions.

- **人工介入（Human-in-the-loop）：** 暂停智能体执行，以便用户在工具调用实际发生前对其进行批准、编辑或拒绝。这对于需与外部系统交互、发送通信消息或执行敏感交易的智能体至关重要。

- **Summarization:** Condense message history when it approaches context limits, keeping recent messages intact while summarizing older context. This prevents token overflow errors and keeps long-running agent sessions performant.

- **摘要生成（Summarization）：** 当消息历史接近上下文长度限制时，自动压缩历史记录——保留最新消息的完整性，同时对较早的上下文进行摘要。此举可避免因超出 token 限制而导致的错误，并保障长期运行的智能体会话性能稳定。

- **PII redaction:** Use pattern matching to identify and redact sensitive information like email addresses, phone numbers, and social security numbers before content is passed to the model. This helps maintain compliance with privacy regulations and prevents accidental exposure of user data.

- **个人身份信息（PII）脱敏：** 在内容传入模型前，利用模式匹配识别并脱敏敏感信息（如电子邮件地址、电话号码、社会保障号码等）。这有助于满足隐私合规要求，并防止用户数据被意外泄露。

LangChain also supports **custom** **middleware** that hook into various of points in the agent loop. The following diagram showcases these hooks:

LangChain 同样支持**自定义中间件（custom middleware）**，可接入智能体执行循环中的多个关键节点。下图展示了这些可接入点：

![](images/langchain-and-langgraph-agent-frameworks-reach-v1_0-milestones/img_002.png)

**Structured Output Generation:**

**结构化输出生成：**

We’ve also improved structured output generation in the agent loop by incorporating it into the main model <–> tools loop. This reduces both latency and cost by eliminating an extra LLM call that used to happen in addition to the main loop.

我们还通过将结构化输出生成功能整合进主模型 ↔ 工具循环中，进一步优化了智能体（agent）循环中的结构化输出生成。此举消除了原先在主循环之外额外发起的一次大语言模型（LLM）调用，从而降低了延迟与成本。

Developers now have fine grained control over how structured output is generated, either via tool calling or provider-native structured output.

开发者如今可对结构化输出的生成方式实施精细化控制——既可通过工具调用（tool calling），也可利用各提供商原生支持的结构化输出功能。

```python
from langchain.agents import create_agent
from langchain.agents.structured_output import ToolStrategy

from pydantic import BaseModel

class WeatherReport(BaseModel):
    temperature: float
    condition: str

agent = create_agent(
    "openai:gpt-4o-mini",
    tools=[weather_tool],
    response_format=ToolStrategy(WeatherReport),
    prompt="Help the user by fetching the weather in their city.",
)
```

```python
from langchain.agents import create_agent
from langchain.agents.structured_output import ToolStrategy

from pydantic import BaseModel

class WeatherReport(BaseModel):
    temperature: float
    condition: str

agent = create_agent(
    "openai:gpt-4o-mini",
    tools=[weather_tool],
    response_format=ToolStrategy(WeatherReport),
    prompt="Help the user by fetching the weather in their city.",
)
```

### Standard Content Blocks

### 标准化内容块

LangChain’s hundreds of provider integrations (OpenAI, Anthropic, etc.) are largely unchanged in 1.0. The interfaces used by these abstractions live in `langchain-core`, which we’re promoting to 1.0 with one key addition: **standardized content blocks**.

LangChain 在 1.0 版本中，对其数百个服务商集成（如 OpenAI、Anthropic 等）基本保持不变。这些抽象层所依赖的接口位于 `langchain-core` 模块中；我们正将该模块整体升级至 1.0 版本，并引入一项关键新增特性：**标准化内容块（standardized content blocks）**。

Much of LangChain’s value comes from its provider-agnostic interfaces, allowing developers to use a common protocol across multiple providers in a single application. Without standard content blocks, switching models or providers often breaks streams, UIs and frontends, and memory stores. The new `.content_blocks` property on messages provides:

LangChain 的核心价值很大程度上源于其与服务商无关（provider-agnostic）的接口设计，使开发者能在单个应用中跨多个服务商复用统一协议。若缺乏标准化内容块，切换模型或服务商往往会导致流式响应（streams）、用户界面（UIs）与前端（frontends）以及记忆存储（memory stores）等组件失效。消息对象（message）上新增的 `.content_blocks` 属性提供了以下能力：

- Consistent content types across providers  
- 跨供应商的一致内容类型  

- Support for reasoning traces, citations, and tool calls – including server-side tool calls  
- 支持推理追踪（reasoning traces）、引用标注（citations）和工具调用（tool calls）——包括服务端工具调用  

- Typed interfaces for complex response structures  
- 针对复杂响应结构的类型化接口  

- Full backward compatibility  
- 完全向后兼容  

This keeps LangChain’s abstractions current with modern LLM capabilities like reasoning, citations, and server side tool execution, while minimizing breaking changes.  

此举使 LangChain 的抽象层持续紧跟现代大语言模型（LLM）的关键能力（如推理、引用标注及服务端工具执行），同时最大限度减少破坏性变更。

### Simplifying the package  

### 简化软件包  

LangChain 1.0 reduces package scope to essential abstractions. Legacy functionality moves to `langchain-classic` for backwards compatibility. As the framework has matured, we've learned what patterns matter most. This streamlined package cuts through years of accumulated features to make LangChain simple _and_ powerful.  

LangChain 1.0 将软件包范围精简至核心抽象层。遗留功能已迁移至 `langchain-classic`，以保障向后兼容性。随着框架日趋成熟，我们已明确哪些设计模式最为关键。这一精简后的软件包剔除了多年累积的冗余特性，让 LangChain 既简洁又强大。

**Key Changes:**  

**主要变更：**  

- `create_agent` introduced in LangChain, with `create_react_agent` deprecated in `langgraph.prebuilt`  
- LangChain 中新增 `create_agent`；`langgraph.prebuilt` 中的 `create_react_agent` 已被弃用  

- Python 3.9 support dropped due to October 2025 EOL, v1.0 requires Python 3.10+  
- 因 Python 3.9 将于 2025 年 10 月终止官方支持（EOL），LangChain v1.0 不再支持 Python 3.9，最低要求为 Python 3.10+  
  - Python 3.14 support is coming soon!  
  - 对 Python 3.14 的支持即将推出！  

- Package surface area reduced to focus on core abstractions with old functionality moved to `langchain-classic`  
- 软件包对外暴露的 API 面积（surface area）大幅缩减，聚焦于核心抽象；原有功能均已迁移至 `langchain-classic`

![](images/langchain-and-langgraph-agent-frameworks-reach-v1_0-milestones/img_003.png)

### Installation  

### 安装  

```bash
# Python
uv pip install --upgrade langchain
uv pip install langchain-classic

# JavaScript
npm install @langchain/langchain@latest
npm install @langchain/langchain-classic
```

### Migration

### 迁移指南

If you're upgrading from a previous version of LangChain, we've created detailed resources to guide you through the changes.

如果您正从 LangChain 的旧版本升级，我们已准备了详尽的资源，帮助您了解并顺利完成本次升级。

**Release overviews:** [Python](https://docs.langchain.com/oss/python/releases/langchain-v1?ref=blog.langchain.com), [JavaScript](https://docs.langchain.com/oss/javascript/releases/langchain-v1?ref=blog.langchain.com)

**版本发布概览：** [Python](https://docs.langchain.com/oss/python/releases/langchain-v1?ref=blog.langchain.com)，[JavaScript](https://docs.langchain.com/oss/javascript/releases/langchain-v1?ref=blog.langchain.com)

**Migration guides**: [Python](https://docs.langchain.com/oss/python/migrate/langchain-v1?ref=blog.langchain.com), [JavaScript](https://docs.langchain.com/oss/javascript/migrate/langchain-v1?ref=blog.langchain.com)

**迁移指南：** [Python](https://docs.langchain.com/oss/python/migrate/langchain-v1?ref=blog.langchain.com)，[JavaScript](https://docs.langchain.com/oss/javascript/migrate/langchain-v1?ref=blog.langchain.com)

## LangGraph 1.0

## LangGraph 1.0

AI agents are moving from prototype to production, but core features like persistence, observability, and human-in-the-loop control have remained underserved.

AI 智能体正从原型阶段迈向生产部署，但诸如状态持久化、可观测性以及“人在环路中”（human-in-the-loop）控制等核心能力，长期以来仍未能得到充分支持。

LangGraph 1.0 addresses these gaps with a powerful graph-based execution model, and it provides production-ready features for reliable agentic systems:

LangGraph 1.0 借助强大的基于图的执行模型填补了上述空白，并为构建高可靠性的智能体系统提供了面向生产环境的功能支持：

- **Durable state** \- Your agent's execution state persists automatically, so if your server restarts mid-conversation or a long-running workflow gets interrupted, it picks up exactly where it left off without losing context or forcing users to start over.

- **持久化状态（Durable state）**：您的智能体执行状态将自动持久化。即使服务器在对话中途重启，或长时间运行的工作流意外中断，系统也能精准恢复至中断点，既不丢失上下文，也无需用户重新开始。

- **Built-in persistence** \- Save and resume agent workflows at any point without writing custom database logic, enabling use cases like multi-day approval processes or background jobs that run across multiple sessions.

- **内置持久化（Built-in persistence）**：无需编写自定义数据库逻辑，即可在任意时刻保存并恢复智能体工作流，从而轻松支持跨多日的审批流程、或需跨越多个会话执行的后台任务等场景。

- **Human-in-the-loop patterns** \- Pause agent execution for human review, modification, or approval with first-class API support, making it trivial to build systems where humans stay in control of high-stakes decisions.

- **人在环路中模式（Human-in-the-loop patterns）**：通过开箱即用的 API 支持，在任意节点暂停智能体执行，交由人工进行审核、修改或批准，让构建“关键决策始终由人掌控”的系统变得轻而易举。

For a deeper dive into our design philosophy, check out our [blog post](https://blog.langchain.com/building-langgraph/) on building LangGraph from first principles.

如需深入了解我们的设计理念，请参阅我们关于“从第一性原理构建 LangGraph”的[博客文章](https://blog.langchain.com/building-langgraph/)。

This is the first stable major release in the durable agent framework space — a major milestone for production-ready AI systems. After more than a year of iteration and widespread adoption by companies like Uber, LinkedIn, and Klarna, LangGraph is officially v1.

这是持久化智能体框架领域首个稳定的重大版本发布——标志着面向生产环境的 AI 系统迈出了重要一步。经过一年多的持续迭代，并已被 Uber、LinkedIn 和 Klarna 等众多公司广泛采用，LangGraph 正式发布 v1 版本。

### Breaking Changes & Migration

### 重大变更与迁移指南

The only notable change is deprecation of the `langgraph.prebuilt` module, with enhanced functionality moved to `langchain.agents`.

唯一值得注意的变更是：`langgraph.prebuilt` 模块已被弃用，其增强功能已迁移至 `langchain.agents`。

LangGraph 1.0 maintains full backward compatibility.

LangGraph 1.0 完全保持向后兼容性。

### Installation

### 安装

```bash
# Python
uv pip install --upgrade langgraph

# JavaScript
npm install @langchain/langgraph@latest
```

## When to Use Each Framework

## 各框架的适用场景

LangChain lets you build and ship agents fast with high-level abstractions for common patterns, while LangGraph gives you fine-grained control for complex workflows that require customization.

LangChain 提供面向常见模式的高层抽象，助您快速构建并交付智能体（agents）；而 LangGraph 则为需要深度定制的复杂工作流提供细粒度控制能力。

The best part? LangChain agents are built on LangGraph, so you're not locked in. Start with LangChain's high-level APIs and seamlessly drop down to LangGraph when you need more control. Since graphs are composable, you can mix both approaches—using agents created with `create_agent` inside custom LangGraph workflows as your needs evolve.

最棒的是？LangChain 的智能体底层基于 LangGraph 构建，因此您不会被锁定在某一层级。您可以先从 LangChain 的高层 API 入手，当需要更强的控制力时，再无缝切换至 LangGraph。由于图结构（graphs）具有可组合性，您还可灵活融合两种方式——例如，随着需求演进，在自定义的 LangGraph 工作流中直接复用通过 `create_agent` 创建的智能体。

### Choose LangChain 1.0 for:

### 选择 LangChain 1.0 的适用场景：

- Shipping quickly with standard agent patterns  
- 使用标准智能体模式快速交付  

- Agents that fit the default loop (model → tools → response)  
- 适配默认执行循环（模型 → 工具 → 响应）的智能体  

- Middleware-based customization  
- 基于中间件的自定义能力  

- Higher-level abstractions over low-level control  
- 在底层控制之上提供更高层级的抽象  

### Choose LangGraph 1.0 for:  
### 选择 LangGraph 1.0，适用于以下场景：

- Workflows with a mixture of deterministic and agentic components  
- 同时包含确定性组件与智能体组件的工作流  

- Long running business process automation  
- 长周期运行的业务流程自动化  

- Sensitive workflows which necessitate more oversight / human in the loop  
- 对安全性要求较高的工作流，需加强人工监督或“人在环中”（human-in-the-loop）机制  

- Highly custom or complex workflows  
- 高度定制化或极其复杂的工作流  

- Applications where latency and / or cost need to be carefully controlled  
- 对延迟和/或成本需进行精细管控的应用场景  

## Documentation & Resources  
## 文档与资源  

We're launching a much improved documentation site at [docs.langchain.com](https://docs.langchain.com/?ref=blog.langchain.com). For the first time, all LangChain and LangGraph docs—across Python and JavaScript—live in one unified site with parallel examples, shared conceptual guides, and consolidated API references.  
我们已在 [docs.langchain.com](https://docs.langchain.com/?ref=blog.langchain.com) 正式上线大幅升级的文档网站。这是首次将 LangChain 与 LangGraph 的全部文档——涵盖 Python 和 JavaScript 两大语言生态——整合至统一平台，提供并行示例、共通的概念性指南，以及整合后的 API 参考文档。

The new docs feature more intuitive navigation, thoughtful guides, and in depth tutorials for common agent architectures.  
新版文档具备更直观的导航结构、精心编排的学习指南，以及针对常见智能体架构的深度教程。

## Thank You & Feedback  
## 感谢与反馈  

We hope you love these 1.0 releases. We are incredibly grateful for the community that has pressure tested LangChain and LangGraph over the years to make them what they are today. With 90M monthly downloads and powering production applications at Uber, JP Morgan, Blackrock, Cisco, and more, we have a duty to you all to keep innovating but also be the most dependable framework for building agents.  
我们衷心希望您喜爱此次 1.0 版本的发布。多年来，广大社区用户对 LangChain 和 LangGraph 进行了高强度的压力测试，助力它们成长为今日成熟稳健的框架——对此我们深表感激。目前，LangChain 每月下载量达 9000 万次，并已应用于 Uber、摩根大通（J.P. Morgan）、贝莱德（BlackRock）、思科（Cisco）等众多企业的生产环境。我们有责任持续创新，同时也必须成为构建智能体最值得信赖的框架。

While this is a major milestone, we are still at the beginning of a major change in software. We want to hear from you: [post on the LangChain Forum](https://forum.langchain.com/t/launch-week-is-here-oss-1-0s-insights-agent-and-no-code-agent-builder/1890?ref=blog.langchain.com) and tell us what you think of our 1.0 release and what you're building.  
尽管这是一次重要里程碑，但软件领域这场深刻变革才刚刚拉开序幕。我们热切期待您的声音：欢迎前往 [LangChain 论坛发帖](https://forum.langchain.com/t/launch-week-is-here-oss-1-0s-insights-agent-and-no-code-agent-builder/1890?ref=blog.langchain.com)，分享您对本次 1.0 版本的看法，以及您正在构建的项目。