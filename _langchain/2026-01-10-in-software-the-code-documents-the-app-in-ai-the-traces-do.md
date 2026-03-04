---
title: "In software, the code documents the app. In AI, the traces do."
source: "LangChain Blog"
url: "https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/"
date: "2026-01-10"
scraped_at: "2026-03-03T07:14:44.450610114+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes", "![Deep Agents", "**Deep Agents**"]
---
{% raw %}

**TL;DR**

**简明摘要**

- **In traditional software, you read the code to understand what the app does - the decision logic lives in your codebase**  
  **在传统软件中，你通过阅读代码来理解应用的行为——决策逻辑就存在于你的代码库中**

- **In AI agents, the code is just scaffolding - the actual decision-making happens in the model at runtime**  
  **在 AI 智能体（agents）中，代码仅起脚手架作用——真正的决策过程发生在运行时的模型内部**

- **Because of this, the source of truth for what your app does shifts from code to traces - traces document what your agent actually did and why**  
  **正因如此，你的应用“实际做了什么”的事实来源，便从代码转向了追踪记录（traces）——traces 记录了智能体实际执行了哪些操作，以及背后的原因**

- **This changes how we debug, test, optimize, monitor, collaborate, and understand product usage**  
  **这彻底改变了我们调试、测试、优化、监控、协作以及理解产品使用情况的方式**

- **If you're building agents without good observability, you're missing the source of truth for what your system actually does**  
  **如果你在构建智能体时缺乏良好的可观测性（observability），你就失去了对系统实际行为的事实依据**

* * *

In traditional software, when something goes wrong, you read the code. When you want to understand how a feature works, you read the code. When you want to improve performance, you profile the code. The code is the source of truth.

在传统软件中，出问题时，你阅读代码；想理解某个功能如何运作时，你阅读代码；想提升性能时，你对代码进行性能分析（profiling）。代码即唯一真相来源。

In AI agents, this doesn't work anymore.

在 AI 智能体中，这套方法已不再适用。

## Why Code Doesn't Document Agent Behavior

## 为何代码无法描述智能体行为

In traditional software, if you want to understand what happens when a user submits a form, you open `handleSubmit()` and read the function. The decision logic is right there: validate inputs, check authentication, call the API, handle errors. It's deterministic - same input, same code path, same output.

在传统软件中，若想了解用户提交表单时发生了什么，你只需打开 `handleSubmit()` 函数并阅读其代码。决策逻辑清晰可见：校验输入、检查身份认证、调用 API、处理错误。整个过程是确定性的——相同输入，必然触发相同代码路径，产生相同输出。

**In AI agents, code is just scaffolding.**

**在 AI 智能体中，代码仅起脚手架作用。**

Here's a simplified version of what agent code actually looks like:

以下是智能体代码的一个简化示例：

```python
agent = Agent(
    model="gpt-4",
    tools=[search_tool, analysis_tool, visualization_tool],
    system_prompt="You are a helpful data analyst..."
)
result = agent.run(user_query)
```

You've defined the pieces: which model, which tools, what instructions. But the decision logic isn't in your code. It just orchestrates LLM calls.

您已定义了各个组件：使用哪个模型、调用哪些工具、提供哪些指令。但决策逻辑并未体现在您的代码中——代码仅负责编排大语言模型（LLM）的调用。

The actual decisions - which tool to call when, how to reason through the problem, when to stop, what to prioritize - all of that happens in the model at runtime.

真正的决策——何时调用哪个工具、如何逐步推理问题、何时终止执行、优先处理什么任务——所有这些都在运行时由模型自主完成。

💡

💡

As the LLM drives more and more of your app (as happens with agents), you have less and less visibility into what the app will actually do just by looking at the code.

随着大语言模型在您的应用中承担越来越多的功能（正如智能体 agent 所体现的那样），仅通过阅读代码，您对应用实际行为的可观察性便越来越低。

You can still debug your orchestration code - whether tool calling works, whether parsing works. But you can't debug the intelligence. Whether the agent makes good decisions, whether it reasons effectively - that logic lives in the model, not in your codebase.

您仍可调试自身的编排逻辑代码——例如工具调用是否成功、解析是否正确。但您无法调试“智能”本身：智能体是否做出了合理决策、推理是否有效——这类逻辑存在于模型内部，而非您的代码库中。

## Traces as the New Documentation

## 追踪记录（Traces）即新型文档

So where does the actual behavior live? In the traces.

那么，应用的实际行为究竟体现在何处？答案是：追踪记录（traces）中。

A trace is the sequence of steps an agent takes. It documents the logic of your app - the reasoning at each step, which tools were called and why, the outcomes and timing.

一次追踪记录，即智能体所执行的一系列步骤。它完整记载了您应用的逻辑——每一步的推理过程、调用了哪些工具及其原因、各步骤的结果与耗时。

💡

💡

This means that operations you would do on code in the software world, you now do on traces in the agent world.

这意味着，在传统软件开发中您对源代码所进行的操作（如审查、分析、调试），如今在智能体（agent）世界中，需转而作用于追踪记录（traces）之上。

Debugging, testing, profiling, monitoring - all of these shift from operating on code to operating on traces.

调试、测试、性能分析、监控——所有这些活动都从以代码为操作对象，转向以追踪（trace）为操作对象。

In traditional software, if two runs produce different outputs, you assume different inputs or different code. In AI agents, the same input with the same code can produce different outputs. Different tool calls, different reasoning chains, different outcomes.

在传统软件中，若两次运行产生不同输出，你通常会假设输入不同或代码不同。而在 AI 智能体中，即使输入相同、代码相同，输出也可能不同：调用的工具不同、推理链不同、最终结果也不同。

The only way to understand what happened is to look at the trace. Why did Task A succeed but Task B fail? Compare the traces. Did your prompt change improve reasoning? Compare traces before and after. Why does the agent keep making the same mistake? Look at the pattern across traces.

理解究竟发生了什么的唯一方式，就是查看追踪记录（trace）。为什么任务 A 成功了而任务 B 失败了？对比两者的 trace。你对提示词（prompt）的修改是否提升了推理效果？对比修改前后的 trace。为什么智能体反复犯同样的错误？观察跨多个 trace 的行为模式。

## How This Changes Building Agents

## 这一转变如何重塑智能体的构建方式

When the source of truth for logic moves from code to traces, everything else follows. All the operations you used to do on code - debugging, testing, optimizing, monitoring - now need to center around traces. Let's look at what this means in practice.

当逻辑的“真相来源”从代码转移到 trace，其余一切也随之改变。过去你在代码上执行的所有操作——调试、测试、优化、监控——如今都必须围绕 trace 展开。我们来具体看看这意味着什么。

### Debugging Becomes Trace Analysis

### 调试演变为追踪分析（Trace Analysis）

When a user reports "the agent failed," you don't open the code and look for a bug. You open the trace and look for where the reasoning went wrong. Did the agent misunderstand the task? Call the wrong tool? Get stuck in a loop?

当用户报告“智能体失败了”，你不再打开代码去查找程序缺陷（bug），而是打开 trace，寻找推理出错的位置：智能体是否误解了任务？是否调用了错误的工具？是否陷入了循环？

The "bug" isn't a logic error in your code. It's a reasoning error in what the agent actually did.

这个“bug”并非你代码中的逻辑错误，而是智能体实际行为中所表现出的推理错误。

Example: An agent keeps retrying the same failed API call five times before giving up. Your code has retry logic - that works fine. The bug is that the agent isn't learning from the error message. You only see this in the trace: same tool call, same parameters, same failure, repeated.

示例：某智能体在放弃前反复重试同一个失败的 API 调用达五次。你的代码中已实现重试逻辑——这部分完全正常。真正的“bug”在于：智能体并未从错误信息中学习。而这一现象，只有在 trace 中才能被发现：相同的工具调用、相同的参数、相同的失败结果，反复出现。

### You Can't Set a Breakpoint in Reasoning

### 你无法在“推理过程”中设置断点

In traditional software, when you find a bug, you set a breakpoint in the code.

在传统软件中，当你发现一个 bug 时，你会在代码中设置断点。

In AI agents, you can't set a breakpoint in reasoning. The decision happens inside the model.

在 AI 智能体中，你无法在推理过程中设置断点——决策发生在模型内部。

But you can set a breakpoint in _logic_ using traces + playgrounds. Open a trace at a particular point in time - right before the agent made the bad decision. Load that exact state into a playground. The playground is like a debugger, but for reasoning instead of code.

但你可以借助 **trace（追踪记录）+ playground（交互式沙盒）** 在 _逻辑层面_ 设置断点：在智能体做出错误决策前的特定时间点打开一条 trace，将该时刻的完整状态加载进 playground。这个 playground 就像一个调试器，只不过它调试的是“推理过程”，而非“代码”。

You can see: What context did the agent have? What was in its memory? What tools were available? What did the prompt look like? Then you iterate - adjust the prompt, change the context, try different approaches - and see if the agent makes a better decision.

你可以清晰地看到：智能体当时拥有哪些上下文？其记忆中存有哪些信息？有哪些工具可用？提示词（prompt）长什么样子？接着你就可以迭代优化——调整提示词、变更上下文、尝试不同策略——并观察智能体是否能做出更优决策。

### Testing Becomes Eval-Driven

### 测试演变为评估驱动（Eval-Driven）

Now that the source of truth for logic is in traces, you need to test those traces. This means two things:

既然逻辑的“事实来源”已转移到 trace 中，你就必须对这些 trace 进行测试。这包含两层含义：

First: you need a pipeline to add traces to your test dataset. As your agent runs, you capture traces and add them to a dataset that you can eval against.

第一：你需要一套流水线，将 trace 自动加入测试数据集。当你的智能体运行时，系统持续捕获 trace，并将其汇入一个可供评估（eval）的数据集。

Second: you need to eval traces in production. In traditional software, you test before deployment and ship. In AI, agents are non-deterministic, so you need to continuously eval in production to catch quality degradation and drift.

第二：你必须在生产环境中持续评估 trace。在传统软件中，你在部署前完成测试，然后发布；而在 AI 领域，智能体具有非确定性（non-deterministic），因此你必须在生产环境中持续开展评估，以及时发现质量下降与行为偏移（drift）。

### Performance Optimization Changes

### 性能优化方式的转变

In traditional software, you profile the code to find hot loops and optimize algorithms. In AI agents, you profile traces to find decision patterns - unnecessary tool calls, redundant reasoning, inefficient paths. The bottleneck is in the agent's decisions, and those only exist in traces.

在传统软件中，你通过代码性能分析（profiling）定位热点循环并优化算法；而在 AI 智能体中，你则通过对 trace 进行分析来识别决策模式——例如不必要的工具调用、冗余的推理步骤、低效的执行路径。性能瓶颈存在于智能体的决策之中，而这些决策仅能在 trace 中被观测和分析。

### Monitoring Shifts from Uptime to Quality

### 从“正常运行时间”监控转向“质量”监控

An agent can be "up" with 0 errors and still be performing terribly - succeeding at the wrong task, succeeding inefficiently at 10x the cost, or giving correct but unhelpful answers.

一个智能体（agent）可能“运行正常”、零错误，但实际表现却极差——它可能完成了错误的任务，或以十倍成本低效地完成了任务，又或给出了虽正确却毫无帮助的回答。

You need to monitor _quality of decisions_, not just system health - task success rate, reasoning quality, tool usage efficiency. You can't monitor quality without sampling and analyzing traces.

您需要监控的是**决策质量**，而不仅仅是系统健康状况——包括任务成功率、推理质量、工具调用效率等。若不采样并分析 trace（执行轨迹），就无法真正监控质量。

### Collaboration Moves to Observability Platforms

### 协作重心迁移至可观测性平台

In traditional software, collaboration happens in GitHub. You review code, leave comments on PRs, discuss implementation in issues. The code is the artifact everyone works with.

在传统软件开发中，协作发生在 GitHub 上：您审查代码、在 Pull Request 中留言评论、在 Issue 中讨论实现细节。代码是所有人共同工作的核心产物。

In AI agents, the logic isn't in the code - it's in the traces. So collaboration has to happen where the traces are too. Sure, you still use GitHub for the orchestration code. But when you're debugging why the agent made a bad decision, you need to share a trace, add comments on specific decision points, discuss why it chose this path. Your observability platform becomes a collaboration tool, not just a monitoring tool.

而在 AI 智能体中，逻辑并不在代码里——而是在 trace 中。因此，协作也必须发生在 trace 所在之处。当然，您仍会在 GitHub 上维护编排（orchestration）代码；但当您调试智能体为何做出错误决策时，您需要共享一条 trace，在关键决策节点添加评论，并围绕其路径选择展开讨论。此时，您的可观测性平台不再仅是监控工具，更成为团队协作的核心平台。

### Product Analytics Merges with Debugging

### 产品数据分析与调试深度融合

In traditional software, product analytics is separate from debugging. Mixpanel tells you what users clicked. Your error logs tell you what broke. They're different tools for different questions.

在传统软件中，产品数据分析与调试彼此分离：Mixpanel 告诉您用户点击了什么，错误日志告诉您哪里崩溃了——二者是面向不同问题的独立工具。

In AI agents, these merge. You can't understand user behavior without understanding agent behavior. When you see "30% of users are frustrated" in your analytics, you need to open traces to see what the agent did wrong. When you see "users asking for data analysis features", you need to look at traces to see which tools the agent is already choosing and what's working. The user experience is the agent's decisions, and those decisions are documented in traces - so product analytics has to be built on traces.

而在 AI 智能体中，二者深度融合。不理解智能体的行为，就无法真正理解用户行为。当您的产品分析数据显示“30% 的用户感到沮丧”时，您需打开 trace 查看智能体究竟哪里出错；当数据显示“用户正在请求数据分析功能”时，您需查阅 trace，观察智能体当前已选用哪些工具、哪些流程已奏效。用户体验即智能体所做的一系列决策，而这些决策全部记录在 trace 中——因此，产品数据分析必须构建在 trace 的基础之上。

## Make the shift

## 完成这一转变

In traditional software, the code is your documentation. In AI agents, the trace is your documentation.

在传统软件中，代码即文档；而在 AI 智能体中，追踪记录（trace）即文档。

The shift is simple: when the decision logic moves from your codebase to the model, your source of truth moves from code to traces.

这一转变十分直接：当决策逻辑从你的代码库转移到模型时，你的“真相来源”也随之从代码转向追踪记录。

💡

💡

Everything you used to do with code - debugging, testing, optimizing, monitoring, collaborating - you now do with traces.

过去你用代码完成的一切工作——调试、测试、优化、监控、协作——如今都需依托追踪记录来完成。

To make this work, you need good observability. Structured tracing that you can search, filter, and compare. The ability to see the full reasoning chain - which tools were called, how long things took, what it cost. The ability to run evals on historical data to monitor quality over time.

要让这一切顺利运转，你需要强大的可观测性（observability）：结构化的追踪能力，支持搜索、筛选与对比；能够完整呈现推理链路——调用了哪些工具、各环节耗时多少、成本几何；还能基于历史数据运行评估（evals），以持续监控质量变化。

If you're building agents and you don't have this, you're working blind. The logic that matters only exists in those traces.

如果你正在构建智能体，却缺乏上述能力，那无异于蒙眼作业。真正关键的逻辑，只存在于那些追踪记录之中。

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![关于智能体框架与智能体可观测性](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪到洞察：大规模理解智能体行为](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪到洞察：大规模理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_003.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与封装器——天哪！](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_003.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与封装器——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_004.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_004.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_005.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_005.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[![Deep Agents](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_006.png)](https://blog.langchain.com/deep-agents/)

[![深度智能体（Deep Agents）](images/in-software-the-code-documents-the-app-in-ai-the-traces-do/img_006.png)](https://blog.langchain.com/deep-agents/)

[**Deep Agents**](https://blog.langchain.com/deep-agents/)

[**深度智能体（Deep Agents）**](https://blog.langchain.com/deep-agents/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读
{% endraw %}
