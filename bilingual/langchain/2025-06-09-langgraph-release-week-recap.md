---
title: "LangGraph Release Week Recap"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-release-week-recap/"
date: "2025-06-09"
scraped_at: "2026-03-03T07:31:18.933409720+00:00"
language: "en-zh"
translated: true
description: "See what we released for LangGraph.js and Python over the past few weeks to speed up development workflows and gain more control at every level of your graph."
---

Over the past few weeks, we rolled out new features for both LangGraph.js and LangGraph Python, improving both low level workflows and prebuilt agents.

过去几周，我们为 LangGraph.js 和 LangGraph Python 推出了新功能，全面优化了底层工作流和预构建智能体。

These new features make it easier to build workflows with faster development cycles, more efficient runs, and greater control at every level of your graph.

这些新功能让工作流的构建更加便捷：开发周期更短、运行效率更高，并在图的每一层级都提供更强的控制能力。

Here’s a quick recap of what’s new:

以下是本次更新的快速概览：

### **1\. Node Caching ♻️**

### **1. 节点缓存 ♻️**

We kicked off the week by introducing **node/task level caching**. Now you can cache the results of individual nodes in your LangGraph workflow, reducing redundant computation and speeding up execution. Node caching is particularly helpful for speeding up development cycles.

我们以推出 **节点/任务级缓存（node/task level caching）** 拉开本周更新序幕。现在，您可在 LangGraph 工作流中对单个节点的执行结果进行缓存，从而减少冗余计算、加快执行速度。节点缓存对加速开发迭代尤为有效。

🔗 [Python docs](https://langchain-ai.github.io/langgraph/concepts/low_level/?h=node+cach&ref=blog.langchain.com#node-caching) \| [JS docs](https://langchain-ai.github.io/langgraphjs/how-tos/node-caching/?ref=blog.langchain.com)

🔗 [Python 文档](https://langchain-ai.github.io/langgraph/concepts/low_level/?h=node+cach&ref=blog.langchain.com#node-caching) \| [JS 文档](https://langchain-ai.github.io/langgraphjs/how-tos/node-caching/?ref=blog.langchain.com)

### **2\. Deferred Nodes 🕰️**

### **2. 延迟节点 🕰️**

Next, we added support for **deferred nodes** — nodes whose execution is postponed until all upstream paths complete. Deferred nodes are ideal for map-reduce, consensus, and agent collaboration workflows.

紧接着，我们新增了对 **延迟节点（deferred nodes）** 的支持——这类节点的执行将被推迟，直至其所有上游路径全部完成。延迟节点特别适用于 Map-Reduce、共识达成以及智能体协同等场景的工作流。

🔗 [Python docs](https://langchain-ai.github.io/langgraph/how-tos/graph-api/?h=defer&ref=blog.langchain.com#defer-node-execution) \| [JS docs](https://langchain-ai.github.io/langgraphjs/how-tos/defer-node-execution/?ref=blog.langchain.com)

🔗 [Python 文档](https://langchain-ai.github.io/langgraph/how-tos/graph-api/?h=defer&ref=blog.langchain.com#defer-node-execution) \| [JS 文档](https://langchain-ai.github.io/langgraphjs/how-tos/defer-node-execution/?ref=blog.langchain.com)

### 3\. Pre/Post Model Hook 🪝

### 3. 模型前后钩子（Pre/Post Model Hook）🪝

Our prebuilt ReAct agents now support more customizable message flow with pre/post model hooks. Pre model hooks ag great for summarizing message history (controlling context bloat) and post model hooks are ideal for guardrails and human-in-the-loop interactions.

我们预构建的 ReAct 智能体现已支持更灵活可定制的消息流，可通过预模型钩子（pre-model hooks）和后模型钩子（post-model hooks）实现。预模型钩子非常适合对消息历史进行摘要（以控制上下文膨胀），而后模型钩子则非常适合实施安全护栏（guardrails）以及人机协同（human-in-the-loop）交互。

As a nice bonus, check out these [interactive docs](https://langchain-ai.github.io/langgraph/agents/overview/?ref=blog.langchain.com#visualize-an-agent-graph) that help you visualize react agent workflows.

作为一项额外福利，请查看这些[交互式文档](https://langchain-ai.github.io/langgraph/agents/overview/?ref=blog.langchain.com#visualize-an-agent-graph)，助您直观呈现 ReAct 智能体的工作流程。

🔗  [Python docs](https://langchain-ai.github.io/langgraph/reference/agents/?h=post_model_hook&ref=blog.langchain.com#langgraph.prebuilt.chat_agent_executor.create_react_agent) \| [JS docs](https://langchain-ai.github.io/langgraphjs/reference/types/langgraph_prebuilt.CreateReactAgentParams.html?ref=blog.langchain.com#__type.postModelHook)

🔗  [Python 文档](https://langchain-ai.github.io/langgraph/reference/agents/?h=post_model_hook&ref=blog.langchain.com#langgraph.prebuilt.chat_agent_executor.create_react_agent) \| [JS 文档](https://langchain-ai.github.io/langgraphjs/reference/types/langgraph_prebuilt.CreateReactAgentParams.html?ref=blog.langchain.com#__type.postModelHook)

### 4\. Builtin Provider Tools 🔍

### 4. 内置服务提供商工具 🔍

You can now use builtin provider tools like [web search](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat&ref=blog.langchain.com) and [Remote MCP](https://platform.openai.com/docs/guides/tools-remote-mcp?ref=blog.langchain.com) tools with the prebuilt ReAct agent. Simply pass in the tool specification dict to the list of `tools`, and you’re golden!

您现在可在预构建的 ReAct 智能体中直接使用内置服务提供商工具，例如 [网页搜索（Web Search）](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat&ref=blog.langchain.com) 和 [远程 MCP（Remote MCP）](https://platform.openai.com/docs/guides/tools-remote-mcp?ref=blog.langchain.com) 工具。只需将工具规格字典（tool specification dict）传入 `tools` 列表中，即可轻松启用！

## JS Enhancements

## JavaScript 增强功能

In addition to the above features introduced in both Python and JS, we’ve also added a few improvements specifically on the JS side.

除上述同时面向 Python 和 JavaScript 的新特性外，我们还专门针对 JavaScript 端新增了几项优化改进。

### 1\. Resumable Streams ⏩

### 1. 可恢复流（Resumable Streams）⏩

Make your app resilient to page reloads or network hiccups with `reconnectOnMount`. Streams resume automatically — no lost tokens, no extra code.

借助 `reconnectOnMount`，让您的应用具备应对页面刷新或网络波动的韧性。流式响应将自动从中断处恢复——不会丢失任何 token，也无需额外编写代码。

🔗 [JS docs](https://langchain-ai.github.io/langgraph/cloud/how-tos/use_stream_react/?ref=blog.langchain.com#resume-a-stream-after-page-refresh)

🔗 [JS 文档](https://langchain-ai.github.io/langgraph/cloud/how-tos/use_stream_react/?ref=blog.langchain.com#resume-a-stream-after-page-refresh)

### 2. DevX Improvements 🧘

### 2. 开发者体验（DevX）改进 🧘

Finally, we've made a bunch of changes to improve the day-to-day developer experience with LangGraph JS v0.3:

最后，我们针对 LangGraph JS v0.3 做了一系列改进，以提升开发者日常开发体验：

- `.stream()` method is now fully type-safe, returning the state updates and values depending on your streamMode. No more any and unsafe casts littered throughout the code. The same is coming in Python soon!

- `.stream()` 方法现已完全类型安全，会根据您的 `streamMode` 返回对应的状态更新与值。代码中不再充斥着 `any` 类型和不安全的类型断言。Python 版本即将支持该特性！

- `.addNode({node1, node2, ...})` and `.addSequence({node1, node2, ...})` is now available for StateGraph, reducing the boilerplate of constructing a simple workflow.

- `StateGraph` 现已支持 `.addNode({node1, node2, ...})` 和 `.addSequence({node1, node2, ...})` 方法，大幅减少构建简单工作流所需的样板代码。

- Interrupts are now returned in `.invoke()` and `"values"` stream modes, allowing you to handle the interrupt directly without the need to call `getState()` afterwards.

- 中断（Interrupts）现在会在 `.invoke()` 调用以及 `"values"` 流模式下直接返回，使您可直接处理中断，无需再后续调用 `getState()`。

Follow [@LangChainAI](https://x.com/langchainai?ref=blog.langchain.com), [@SydneyRunkle](https://x.com/sydneyrunkle?ref=blog.langchain.com) (Python), and [@\_\_dqbd](https://x.com/__dqbd?ref=blog.langchain.com) (JS) to stay up to date on what’s next. 👀

请关注 [@LangChainAI](https://x.com/langchainai?ref=blog.langchain.com)、[@SydneyRunkle](https://x.com/sydneyrunkle?ref=blog.langchain.com)（Python 方向）和 [@\_\_dqbd](https://x.com/__dqbd?ref=blog.langchain.com)（JS 方向），及时获取后续动态。👀