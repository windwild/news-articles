---
title: "Agent Middleware"
source: "LangChain Blog"
url: "https://blog.langchain.com/agent-middleware/"
date: "2025-09-09"
scraped_at: "2026-03-03T07:28:16.141483026+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_LangChain has had agent abstractions for nearly three years. There are now probably 100s of agent frameworks with the same core abstraction. They all suffer from the same downsides that the original LangChain agents suffered from: they do not give the developer enough control over context engineering when needed, leading to developers graduating off of the abstraction for any non-trivial use case. In LangChain 1.0 we are introducing a new agent abstraction (_ [_`Middleware`_](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com) _) which we think solves this._

_LangChain 已拥有 Agent 抽象层近三年之久。如今，可能已有数百个具备相同核心抽象的 Agent 框架涌现。这些框架均面临与原始 LangChain Agent 相同的缺陷：在需要时无法为开发者提供足够的上下文工程（context engineering）控制能力，导致开发者在处理任何非简单用例时，不得不放弃该抽象层。在 LangChain 1.0 中，我们引入了一种全新的 Agent 抽象——_[`Middleware`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com)_，我们认为它能有效解决这一问题。_

The core agent components are quite simple:

Agent 的核心组件非常简洁：

- A model  
- 一个模型  
- A prompt  
- 一个提示词（prompt）  
- A list of tools  
- 一组工具（tools）

The core agent algorithm is equally simple. The user first invokes the agent with some input message, and the agent then runs in a loop, calling tools, adding AI and tool messages to its state, until it decides to not call any tools and ultimately finish.

Agent 的核心算法同样简洁：用户首先以某条输入消息调用 Agent；随后 Agent 进入循环执行模式——调用工具、将大模型响应和工具返回的消息逐步添加至其内部状态，直至判定无需再调用任何工具，并最终完成任务。

![](images/agent-middleware/img_001.png)

We had a version of this agent in LangChain in November of 2022, and over the past 3 years 100s of frameworks have popped up with similar abstractions.

早在 2022 年 11 月，LangChain 就已实现了此类 Agent 的早期版本；而过去三年间，数百个采用类似抽象设计的框架相继涌现。

At the same time, while it is simple to get a basic agent abstraction up and running, it is hard to make this abstraction flexible enough to bring to production.

与此同时，尽管搭建一个基础版 Agent 抽象十分容易，但要使其具备足够灵活性以投入生产环境，却极具挑战性。

In this blog we will cover:

本文将围绕以下三点展开：

1. Why it is hard to get this abstraction to be reliable enough to bring to production  
1. 为何该抽象难以达到足以投入生产的可靠性水平  
2. Our journey to make it more reliable over the past year or so  
2. 我们在过去一年左右时间里提升其可靠性的探索历程  
3. A new [`Middleware`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com) abstraction we are introducing in LangChain 1.0 which we think makes it the most flexible and composable agent abstraction out there  
3. LangChain 1.0 中全新推出的 [`Middleware`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com) 抽象——我们认为这是目前最灵活、最可组合（composable）的 Agent 抽象方案

## Why it is hard to bring this abstraction to production

## 为何将该抽象投入生产环境如此困难

So why is it still so hard to build reliable agents with these frameworks? Why do many people, when they hit a certain level of complexity, go away from frameworks in favor of custom code?

那么，为什么使用这些框架构建可靠的智能体（agents）仍然如此困难？为什么当许多人面对一定复杂度时，会放弃框架、转而采用自定义代码？

The answer is [_context engineering_](https://blog.langchain.com/the-rise-of-context-engineering/). The context that goes into the model determines what comes out of it. In order to make the model (and therefore, the agent) more reliable, you want to have full control over what goes into the model. And while this simple agent state and simple agent loop are great for getting started, as you push the boundaries of your agent’s performance you will likely want to modify part of that.

答案是 [_上下文工程（context engineering）_](https://blog.langchain.com/the-rise-of-context-engineering/)。输入模型的上下文，决定了模型的输出内容。为了提升模型（从而也提升智能体）的可靠性，你需要对输入模型的内容拥有完全的控制权。尽管这种简单的智能体状态（agent state）和简单的智能体循环（agent loop）非常适合入门，但当你试图突破智能体性能的边界时，你很可能需要对其中某些部分进行调整。

There are a number of things you may want to have more control over as complexity increases:

随着复杂度上升，你可能希望在以下方面获得更强的控制力：

1. You may want to adjust the “state” of the agent to contain more than just messages  
   你可能希望扩展智能体的“状态”（state），使其不仅包含消息（messages），还能容纳其他类型的数据；  
2. You may want to have more control over what exactly goes into the model  
   你可能希望更精细地控制究竟有哪些内容被送入模型；  
3. You may want to have more control over the sequence of steps run  
   你可能希望更灵活地编排执行步骤的顺序。

## Our journey to make it more reliable

## 我们提升可靠性的演进之路

Over the past two years we worked to make our agent abstraction better support context engineering. Some things we did (roughly in order):

过去两年中，我们持续优化智能体抽象层，以更好地支持上下文工程。我们所做的一些工作（大致按时间顺序）包括：

- Allowed the user to specify runtime configuration, to pass in things like connection strings and read only user info  
  允许用户指定运行时配置（runtime configuration），例如传入数据库连接字符串或只读用户信息；  
- Allowed the user to specify arbitrary state schemas, that either the user or the agent could update  
  允许用户定义任意的状态结构（state schema），该结构可由用户或智能体本身更新；  
- Allowed the user to specify a function to return a prompt, rather than a string, allowing for dynamic prompts  
  允许用户指定一个返回提示词（prompt）的函数（而非固定字符串），从而支持动态生成提示词；  
- Allowed the user to specify a function to return a list of messages, to have full control over the whole message list that was sent to the model  
  允许用户指定一个返回消息列表（list of messages）的函数，从而完全掌控发送给模型的整条消息序列；  
- Allowed the user to specify a “pre model hook”, to run a step BEFORE the model was called, that could update state or jump to a different node. This allows for things like summarization of long conversations.  
  允许用户指定一个“模型调用前钩子”（pre-model hook），即在模型调用前执行某一步骤，该步骤可更新状态或跳转至其他节点——这使得长对话摘要等能力成为可能；  
- Allowed the user to specify a “post model hook”, to run a step AFTER the model was called, that could update state or jump to a different node. This allows for things like human-in-the-loop and guardrails.  
  允许用户指定一个“模型调用后钩子”（post-model hook），即在模型调用后执行某一步骤，该步骤同样可更新状态或跳转节点——这为人工介入（human-in-the-loop）与安全护栏（guardrails）等功能提供了支持；  
- Allowed the user to specify a function that returned the model to use at each call, making it possible to do dynamic model switching and dynamic tool calling.  
  允许用户指定一个返回每次调用所用模型的函数，从而实现动态模型切换与动态工具调用。

This allowed for high level of customization and control over the context engineering that gets done.

这使得开发者能够对上下文工程过程进行高度定制化与精细化控制。

But it also resulted in a large number of parameters to the agent. Furthermore, these parameters often had dependencies on each other, which made it tough to coordinate. And it was tough to combine multiple versions of these parameters, or provide off-the-shelf variants to try.

但这也导致智能体接口参数数量激增。此外，这些参数之间往往存在相互依赖关系，使得协调管理变得困难；同时，将多组参数组合使用，或提供开箱即用（off-the-shelf）的预设变体供尝试，也颇具挑战性。

## What we’re doing in LangChain 1.0

## LangChain 1.0 中的新举措

For LangChain 1.0 we are leaning to this idea of modifying this core agent loop by introducing a concept of [`Middleware`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com).

在 LangChain 1.0 中，我们倾向于通过引入 [`Middleware`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com)（中间件）这一概念，来改造核心 Agent 执行循环。

The core agent loop will still consist of a model node and a tool node. But Middleware can now specify:

核心 Agent 循环仍将由一个模型节点（model node）和一个工具节点（tool node）组成。但中间件现在可定义以下三类钩子函数：

- [`before_model`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#before-model): will run before model calls, can update state or jump to other nodes.  
- [`before_model`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#before-model)：在模型调用前执行，可更新状态或跳转至其他节点。

- [`after_model`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#after-model): will run after model calls, can update state or jump to other nodes.  
- [`after_model`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#after-model)：在模型调用后执行，可更新状态或跳转至其他节点。

- [`modify_model_request`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#modify-model-request): will run before model calls, allows user to modify (only for that model request) the tools, prompt, message list, model, model settings, output format, and tool choice.  
- [`modify_model_request`](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#modify-model-request)：在模型调用前执行，允许用户针对**本次模型请求**动态修改工具列表、提示词（prompt）、消息列表（message list）、模型本身、模型配置参数、输出格式及工具选择策略（tool choice）。

You can provide multiple middleware to an agent. They will run as middleware runs in web servers: sequentially on the way in to the model call (`before_model`, `modify_model_request`), and in reverse sequential order on the way back (`after_model`).

您可为一个 Agent 配置多个中间件。其执行顺序与 Web 服务器中的中间件一致：在进入模型调用时（即“入栈”阶段），按注册顺序依次执行 `before_model` 和 `modify_model_request`；在返回路径上（即“出栈”阶段），则以**逆序**执行 `after_model`。

![](images/agent-middleware/img_002.png)

![](images/agent-middleware/img_002.png)

Middleware can also specify custom state schemas and tools as well.

中间件还可声明自定义的状态结构（state schema）和工具（tools）。

We will provide off-the-shelf middleware for developers to get started with. We will also maintain a list of community middleware for easy access. For a while, developers have asked for collections of nodes to plug into LangGraph agents. This is exactly that.

我们将为开发者提供开箱即用（off-the-shelf）的中间件，助其快速上手；同时将持续维护一份社区贡献的中间件清单，方便查阅与复用。长期以来，开发者一直呼吁提供可直接集成进 LangGraph Agent 的节点组件库——这正是中间件所要实现的目标。

Middleware will also help us unify our different agent abstractions. We currently have separate LangGraph agents for supervisor, swarm, bigtool, deepagents, reflection, and more. We’ve already verified that we will be able replicate these architectures using Middleware.

中间件还将助力我们统一各类 Agent 抽象形态。目前，我们已为监管者（supervisor）、蜂群（swarm）、大工具（bigtool）、深度智能体（deepagents）、反思（reflection）等场景分别构建了独立的 LangGraph Agent 实现。我们已验证：所有这些架构均可通过中间件完整复现。

## Try it in LangChain 1.0 alpha

## 在 LangChain 1.0 Alpha 版本中试用

You can try out Middleware in the most recent LangChain 1.0 alpha releases (Python and JavaScript). This is the biggest new part of LangChain 1.0 so we would LOVE feedback on Middleware.

您可在最新发布的 LangChain 1.0 Alpha 版本（支持 Python 和 JavaScript）中体验中间件功能。这是 LangChain 1.0 中最具突破性的新特性，我们**非常期待**您对中间件的反馈！

As part of this alpha release, we are also releasing three different middleware implementations (all of which we are using in internal agents already):

作为本次 Alpha 版本发布的一部分，我们还同步推出了三种不同的中间件实现（目前均已应用于内部智能体中）：

1. [Human-in-the-loop](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#human-in-the-loop): uses `Middleware.after_model` to provide an off-the-shelf way to add interrupts to get human-in-the-loop feedback on tool calls.

1. [人工介入（Human-in-the-loop）](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#human-in-the-loop)：利用 `Middleware.after_model` 提供开箱即用的中断机制，以便在工具调用环节引入人工反馈。

2. [Summarization](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#summarization): uses `Middleware.before_model` to summarize messages once they accumulate past a certain threshold

2. [摘要生成（Summarization）](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#summarization)：利用 `Middleware.before_model` 在消息累积超过指定阈值时自动对其进行摘要。

3. [Anthropic Prompt Caching](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#anthropic-prompt-caching): uses `Middleware.modify_model_request` to add special prompt caching tags to messages.

3. [Anthropic 提示缓存（Anthropic Prompt Caching）](https://docs.langchain.com/oss/python/langchain/middleware?ref=blog.langchain.com#anthropic-prompt-caching)：利用 `Middleware.modify_model_request` 向消息中添加特殊的提示缓存标签。

Try it in Python: `pip install --pre -U langchain`

在 Python 中试用：`pip install --pre -U langchain`

Try it in JavaScript: `npm install langchain@next`

在 JavaScript 中试用：`npm install langchain@next`
&#123;% endraw %}
