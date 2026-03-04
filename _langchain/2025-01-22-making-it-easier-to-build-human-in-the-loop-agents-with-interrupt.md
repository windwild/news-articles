---
title: "Making it easier to build human-in-the-loop agents with interrupt"
source: "LangChain Blog"
url: "https://blog.langchain.com/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/"
date: "2025-01-22"
scraped_at: "2026-03-03T07:43:07.276649070+00:00"
language: "en-zh"
translated: true
---
{% raw %}

While agents can be powerful, they are not perfect. This often makes it important to keep the human “in the loop” when building agents. For example, in our [fireside chat](https://www.youtube.com/watch?v=ViykMqljjxU&ref=blog.langchain.com) we did with Michele Catasta (President of Replit) on their Replit Agent, he speaks several times about the human-in-the-loop component being crucial to their agent design.

尽管智能体（agents）功能强大，但它们并非完美无缺。因此，在构建智能体时，让人类“参与其中”（human-in-the-loop）往往至关重要。例如，在我们与 Replit 首席执行官 Michele Catasta 就其 Replit Agent 展开的[炉边对话](https://www.youtube.com/watch?v=ViykMqljjxU&ref=blog.langchain.com)中，他多次强调：人类参与环节是其智能体设计中不可或缺的核心要素。

From the start, we designed LangGraph with this in mind, and it’s one of the key reasons [many](https://blog.langchain.com/customers-rexera/) [companies](https://blog.langchain.com/customers-openrecovery/) [choose](https://blog.langchain.com/customers-replit/) [to build](https://blog.langchain.com/customers-tradestack/) on LangGraph. Today, we’re excited to announce a new method to more easily include human-in-the-loop steps in your LangGraph agents: `interrupt`

从最初设计 LangGraph 起，我们就将这一理念融入其中——这也是众多公司选择基于 LangGraph 构建应用的关键原因之一：[Rexera](https://blog.langchain.com/customers-rexera/)、[Open Recovery](https://blog.langchain.com/customers-openrecovery/)、[Replit](https://blog.langchain.com/customers-replit/) 和 [TradeStack](https://blog.langchain.com/customers-tradestack/) 等企业均是如此。今天，我们非常高兴地宣布一项新功能，可更便捷地在 LangGraph 智能体中加入人类参与步骤：`interrupt`。

## How we built LangGraph for human-in-the-loop workflows

## LangGraph 如何原生支持人类参与型工作流

One of the differentiating aspects of LangGraph is that we built it for human-in-the-loop workflows. We think these workflows are incredibly important when building agents, and so we built in first class support for them in LangGraph.

LangGraph 的一大差异化特性，正是它专为支持“人类参与型工作流”而设计。我们认为，这类工作流在构建智能体时至关重要；因此，LangGraph 原生提供了对它的头等支持（first-class support）。

We did this by making [persistence](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com) a first class citizen in LangGraph. Every step of the graph, it reads from and then writes to a checkpoint of that graph state. That graph state stores everything the agent needs to do its work.

我们通过将[持久化机制](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com)设为 LangGraph 的核心能力来实现这一点。图（graph）执行的每一步，都会先从该图状态的检查点（checkpoint）中读取数据，再将更新后的状态写回该检查点。该图状态保存了智能体完成任务所需的全部信息。

This makes it possible to pause execution of the graph half way through, and then resume after some time - because that checkpoint is there, and we can just pick right back up from there.

这使得图的执行可在中途暂停，并在一段时间后继续运行——因为检查点始终存在，我们只需从中断处无缝恢复即可。

It also makes it possible to pause, let the human edit the checkpoint, and then resume from that new updated checkpoint.

这也意味着：我们可以暂停执行，允许人类编辑该检查点内容，再从此更新后的检查点继续执行。

In some ways, you can think of this persistence layer as a scratchpad for human/agent collaboration.

从某种意义上说，这一持久化层可被视作人类与智能体协同工作的“草稿板”。

## `interrupt`: a new developer experience for human-in-the-loop

## `interrupt`：面向人类参与场景的全新开发者体验

We’ve had a few ways of building human in the loop interactions before (breakpoints, NodeInterrupt). Over the past few months, we’ve seen developers want to do more and more complicated things, and so we’ve added a new tool to help with this.

此前，我们已提供若干种实现人类参与交互的方式（如断点 breakpoint、NodeInterrupt）。但在过去几个月中，我们观察到开发者的需求日趋复杂；为此，我们新增了一项工具来更好地支持此类场景。

When building human-in-the-loop into Python programs, one common way to do this is with [the `input` function](https://www.w3schools.com/python/ref_func_input.asp?ref=blog.langchain.com). With this, your program pauses, a text box pops up in your terminal, and whatever you type is then used as the response to that function. You use it like the below:

在 Python 程序中构建“人在环路中”（human-in-the-loop）功能时，一种常见方式是使用 [`input` 函数](https://www.w3schools.com/python/ref_func_input.asp?ref=blog.langchain.com)。调用该函数后，程序会暂停执行，终端中会弹出一个文本输入框，您键入的内容将作为该函数的返回值。其用法如下所示：

```python
response = input("Your question here")
```

```python
response = input("请输入您的问题")
```

That is a pretty easy and intuitive way to add human-in-the-loop functionality. The downside to this is that it is synchronous and blocks the process and doesn’t really work outside the command line (or notebooks). So this won’t work in production at all.

这是一种非常简单且直观的添加“人在环路中”功能的方式。但它的缺点在于：它是同步的，会阻塞整个进程，且仅适用于命令行环境（或 Jupyter Notebook），无法在 Web 服务等非交互式环境中运行。因此，它完全不适用于生产环境。

We’ve tried to emulate this developer experience by adding a new function to LangGraph: `interrupt`. You can use this in much the same way as `input`:

我们尝试复刻这种开发者体验，在 LangGraph 中新增了一个函数：`interrupt`。它的使用方式与 `input` 非常相似：

```python
response = interrupt("Your question here")
```

```python
response = interrupt("请输入您的问题")
```

This is designed to work in production settings. When you do this, it will pause execution of the graph, mark the thread you are running as `interrupted`, and put whatever you passed as an input to `interrupt` into the persistence layer. This way, you can check the thread status, see that it’s interrupted, check the message, and then based on that invoke the graph again (in a special way) to pass your response back in:

该函数专为生产环境设计。调用它时，LangGraph 将暂停当前图（graph）的执行，将您正在运行的线程（thread）标记为 `interrupted`（已中断），并将传给 `interrupt` 的输入内容存入持久化层（persistence layer）。这样，您就可以查询线程状态，确认其处于中断状态、查看待处理的消息，然后据此以一种特殊方式再次调用该图，将您的响应传回：

```python
graph.invoke(Command(resume="Your response here"), thread)
```

```python
graph.invoke(Command(resume="您的响应内容"), thread)
```

Note that it doesn’t function exactly the same as `input` (it reruns any work in that node done before this is called, but no previous nodes). This ensures interrupted threads don’t take up any resources (beyond storage space), and can be resumed many months later, on a different machine, etc.

需要注意的是，`interrupt` 的行为并不完全等同于 `input`（它会重新执行当前节点中此前已完成的工作，但不会重跑之前的所有节点）。这一设计确保了被中断的线程几乎不占用任何运行时资源（仅需少量存储空间），并支持在数月之后、甚至在另一台机器上恢复执行。

For more information, see the [Python](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com) and [Javascript](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com) documentation.

如需了解更多详情，请参阅 [Python 文档](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com) 和 [JavaScript 文档](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com)。

## Common human-in-the-loop workflows

## 常见的“人在环路中”工作流

There are a few different human-in-the-loop workflows that we see being implemented.

我们观察到几种不同的人机协同（human-in-the-loop）工作流正在被实际应用。

[**Approve or Reject**](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/review-tool-calls/?ref=blog.langchain.com)

[**批准或拒绝**](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/review-tool-calls/?ref=blog.langchain.com)

Pause the graph before a critical step, such as an API call, to review and approve the action. If the action is rejected, you can prevent the graph from executing the step, and potentially take an alternative action.

在关键步骤（例如调用 API）之前暂停图执行，以便人工审查并批准该操作；若操作被拒绝，可阻止图执行该步骤，并可能采取替代操作。

![](images/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/img_001.png)

![](images/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/img_001.png)

[**Review & Edit State**](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/wait-user-input/?ref=blog.langchain.com)

[**审查与编辑状态**](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/wait-user-input/?ref=blog.langchain.com)

A human can review and edit the state of the graph. This is useful for correcting mistakes or updating the state with additional information.

人类用户可审查并编辑图的状态。这在修正错误或通过额外信息更新状态时尤为有用。

![](images/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/img_002.png)

![](images/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/img_002.png)

[**Review Tool Calls**](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/review-tool-calls/?ref=blog.langchain.com)

[**审查工具调用**](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/review-tool-calls/?ref=blog.langchain.com)

A human can review and edit the output from the LLM before proceeding. This is particularly critical in applications where the tool calls requested by the LLM may be sensitive or require human oversight.

人类可在流程继续前审查并编辑大语言模型（LLM）的输出。在涉及敏感操作、或 LLM 所发起的工具调用需人工监督的应用场景中，这一环节尤为关键。

![](images/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/img_003.png)

![](images/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/img_003.png)

[**Multi-turn conversation in a multi-agent setup**](https://langchain-ai.github.io/langgraph/how-tos/multi-agent-multi-turn-convo/?ref=blog.langchain.com)

[**多智能体环境下的多轮对话**](https://langchain-ai.github.io/langgraph/how-tos/multi-agent-multi-turn-convo/?ref=blog.langchain.com)

A **multi-turn conversation** involves multiple back-and-forth interactions between an agent and a human, which can allow the agent to gather additional information from the human in a conversational manner.

**多轮对话** 指智能体与人类之间进行的多次来回交互，这种交互方式使智能体能够以自然对话的形式从人类处持续获取补充信息。

This design pattern is useful in an LLM application consisting of [multiple agents](https://langchain-ai.github.io/langgraph/concepts/multi_agent/?ref=blog.langchain.com). One or more agents may need to carry out multi-turn conversations with a human, where the human provides input or feedback at different stages of the conversation. For simplicity, the agent implementation below is illustrated as a single node, but in reality it may be part of a larger graph consisting of multiple nodes and include a conditional edge.

该设计模式适用于由 [多个智能体](https://langchain-ai.github.io/langgraph/concepts/multi_agent/?ref=blog.langchain.com) 构成的大语言模型（LLM）应用。其中，一个或多个智能体可能需要与人类开展多轮对话——人类在对话的不同阶段提供输入或反馈。为简化说明，下方示例将智能体实现表示为单个节点；但在实际应用中，它可能是包含多个节点及条件边（conditional edge）的更大图结构的一部分。

![](images/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/img_004.png)

![](images/making-it-easier-to-build-human-in-the-loop-agents-with-interrupt/img_004.png)

## Conclusion

## 总结

We are building LangGraph to be the best agent framework for human-in-the-loop interaction patterns. We think `interrupt` makes this easier than ever. We’ve updated all of our examples that use human-in-the-loop to use this new functionality. We hope to release some more end-to-end projects that demonstrate this in real-world action soon.

我们正致力于将 LangGraph 打造成面向“人在回路中”（human-in-the-loop）交互模式的最佳智能体框架。我们认为，`interrupt`（中断机制）让这一目标前所未有地易于实现。我们已将所有涉及“人在回路中”的示例更新为使用这一新功能。我们期待尽快发布更多端到端项目，真实展现该能力在实际场景中的应用效果。

See our [YouTube walkthrough](https://youtu.be/6t7YJcEFUIY?ref=blog.langchain.com) for more information

欢迎观看我们的 [YouTube 演示视频](https://youtu.be/6t7YJcEFUIY?ref=blog.langchain.com) 了解更多信息。

We’re excited to see what you build!

我们热切期待您构建出的精彩成果！
{% endraw %}
