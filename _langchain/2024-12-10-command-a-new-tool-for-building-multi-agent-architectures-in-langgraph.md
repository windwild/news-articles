---
render_with_liquid: false
title: "Command: A new tool for building multi-agent architectures in LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/command-a-new-tool-for-multi-agent-architectures-in-langgraph/"
date: "2024-12-10"
scraped_at: "2026-03-03T07:45:45.446037161+00:00"
language: "en-zh"
translated: true
description: "Learn about Command, a new tool in LangGraph that helps facilitate multi-agent communication."
---
render_with_liquid: false
render_with_liquid: false

Agent and multi-agent systems are all about how the different components of the system [communicate with each other](https://blog.langchain.com/communication-is-all-you-need/). We spend a lot of time thinking about the best infrastructure and developer experience for facilitating this type of communication. Today, we’re excited to announce `Command`: a new tool in `langgraph` to more easily facilitate multi-actor (or multi-agent) communication.

代理与多代理系统，其核心在于系统中各个组件之间[如何相互通信](https://blog.langchain.com/communication-is-all-you-need/)。我们投入大量精力，思考如何构建最优的基础设施与开发者体验，以支持此类通信。今天，我们很高兴地宣布推出 `Command`：这是 `langgraph` 中一项全新工具，旨在更便捷地实现多参与者（或多代理）间的通信。

## Technical Background

## 技术背景

Our [agent framework `langgraph`](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) is powered by an event-driven system. We expose a graph-based developer experience heavily influenced by [`NetworkX`](https://networkx.org/?ref=blog.langchain.com), which we've found maps nicely to developer’s mental models of agents. Given the underlying event-driven architecture, we can easily add variants of this graph-based devX.

我们的[代理框架 `langgraph`](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 基于事件驱动架构构建。我们提供一种以图（graph）为核心的开发者体验，其设计深受 [`NetworkX`](https://networkx.org/?ref=blog.langchain.com) 启发；实践表明，这种图式表达与开发者对代理系统的认知模型高度契合。得益于底层的事件驱动架构，我们可轻松扩展并支持多种变体的图式开发体验（graph-based devX）。

`langgraph` graphs have traditionally been represented as nodes and edges. This declarative architecture is helpful for mapping an agent’s path to a visual representation. On the flip side, requiring edges to connect nodes can sometimes make it harder or unintuitive to express more dynamic logic. In these situations, you would want nodes to be able to specify dynamically which node to go to next.

传统上，`langgraph` 的图由节点（nodes）和边（edges）构成。这种声明式架构有助于将代理的执行路径映射为直观的可视化图谱。但另一方面，强制依赖边来连接节点，有时会使动态逻辑的表达变得困难甚至反直觉。在这些场景下，你希望节点能够**动态指定**下一步应执行哪个（或哪些）节点。

## Command: Edgeless graphs

## Command：无边图（Edgeless Graphs）

With this in mind, we are excited to release `Command` in LangGraph. This is a special type that when returned from a node specifies not only the update to the state (as usual) but also which node to go to next. This allows nodes to more directly control which nodes are executed after-the-fact.

基于上述考量，我们很高兴在 LangGraph 中正式发布 `Command`。这是一种特殊类型——当节点返回该类型时，它不仅指定对状态（state）的更新（如常规操作），还明确指定了下一步应跳转至哪个节点。这使得节点能更直接、更灵活地控制后续实际执行的节点。

Usage looks something like this (Python):

用法示例如下（Python）：

```python
# With type hints, you can specify the possible nodes this can go to.
# 通过类型提示，你可以明确声明该节点可能跳转到的目标节点。
def agent(state: MessagesState) -> Command[Literal[..., END]]:
    ...
    return Command(
	    goto=...,  # The next node(s) to go to
	    # 下一个（或多个）要执行的节点
	    update={"messages": [response]}  # The update to apply to the state
	    # 要应用到状态上的更新
	  )
```

This can be returned by any node. The type hints on the node can let the graph know which nodes can possibly be executed next. (This allows you to still visualize the graph.)

任何节点均可返回 `Command`。节点函数的类型提示可告知图结构：该节点后续可能执行哪些节点。（这确保了图谱仍可被可视化。）

Read these more technical guides to learn more:

请阅读以下更深入的技术指南以了解详情：

- [Python docs](https://langchain-ai.github.io/langgraph/how-tos/command/?ref=blog.langchain.com)  
- [Python 文档](https://langchain-ai.github.io/langgraph/how-tos/command/?ref=blog.langchain.com)

- [JS docs](https://langchain-ai.github.io/langgraphjs/how-tos/command/?ref=blog.langchain.com)  
- [JavaScript 文档](https://langchain-ai.github.io/langgraphjs/how-tos/command/?ref=blog.langchain.com)

## Impact on multi-agent flows  

## 对多智能体流程的影响

One of the primary motivators for this is to more easily allow dynamic multi-agent architectures.  

此举的主要动因之一，是更便捷地支持动态的多智能体架构。

One emerging component of multi-agent architectures is a “handoff”. A handoff involves one agent handing off control to another agent (with or without adding any initial response). OpenAI’s swarm framework actually does this quite well.  

在多智能体架构中，一个新兴的关键组件是“移交”（handoff）。所谓移交，是指一个智能体将控制权转交给另一个智能体（可选是否附带初始响应）。OpenAI 的 Swarm 框架在此方面表现尤为出色。

The `Command` type lets us perform handoffs easily. We can easily specify any other node in the graph to jump to. As part of this, we can also specify nodes in the **parent** graph to jump to. This allows for better communication and handoffs in hierarchical agent architectures.  

`Command` 类型使我们能够轻松实现移交操作：可便捷指定跳转至图中的任意其他节点；此外，还可指定跳转至**父级**图中的节点。这显著提升了分层智能体架构中各组件间的通信效率与移交灵活性。

For more information on this, see [our conceptual guide on multi-agent architectures](https://langchain-ai.github.io/langgraph/concepts/multi_agent/?ref=blog.langchain.com) which we've updated to reflect our updated thoughts on handoffs. You can also check out our [multiple tutorials on building multi-agent systems with `Command`](https://langchain-ai.github.io/langgraph/tutorials/?ref=blog.langchain.com#multi-agent-systems).  

如需进一步了解，请参阅我们最新修订的[多智能体架构概念指南](https://langchain-ai.github.io/langgraph/concepts/multi_agent/?ref=blog.langchain.com)，其中已全面融入我们对“移交”机制的最新思考。您也可查阅我们提供的[一系列使用 `Command` 构建多智能体系统的教程](https://langchain-ai.github.io/langgraph/tutorials/?ref=blog.langchain.com#multi-agent-systems)。

## Conclusion  

## 总结

Building agentic and multi-agent systems is all about communication. As such, our goal is to make `langgraph` the agent framework that gives you the most control over how these agents communicate. We believe that this new `Command` type is an improvement in that direction.  

构建具身智能体（agentic）及多智能体系统，其核心在于通信。因此，我们的目标是将 `langgraph` 打造成一款能让您对智能体间通信方式拥有最高控制权的智能体框架。我们相信，这一全新的 `Command` 类型正是朝此方向迈出的重要一步。

For a video guide of this, see [our walkthrough on YouTube](https://youtu.be/6BJDKf90L9A?ref=blog.langchain.com).  

如需视频讲解，请观看我们在 YouTube 上发布的[操作演示视频](https://youtu.be/6BJDKf90L9A?ref=blog.langchain.com)。