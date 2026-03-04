---
title: "Debugging Deep Agents with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/debugging-deep-agents-with-langsmith/"
date: "2025-12-10"
scraped_at: "2026-03-03T07:15:51.848864050+00:00"
language: "en-zh"
translated: true
---
{% raw %}

Debugging is the process of finding and fixing errors. This is a critical step in software engineering, and even more critical in [agent engineering](https://blog.langchain.com/agent-engineering-a-new-discipline/). One of the key capabilities of [LangSmith](https://docs.langchain.com/langsmith/home?ref=blog.langchain.com) is tooling to debug LLM applications.

调试是查找并修复错误的过程。这是软件工程中至关重要的一步，而在[智能体工程（agent engineering）](https://blog.langchain.com/agent-engineering-a-new-discipline/)中则尤为关键。[LangSmith](https://docs.langchain.com/langsmith/home?ref=blog.langchain.com) 的核心能力之一，便是为大语言模型（LLM）应用提供调试工具。

Today we are doubling down on solving that problem for the new wave of [“deep agents”](https://blog.langchain.com/doubling-down-on-deepagents/) we see being developed.

今天，我们正全力应对这一挑战——为当前蓬勃兴起的[“深度智能体（deep agents）”](https://blog.langchain.com/doubling-down-on-deepagents/)开发浪潮提供更强大的解决方案。

In this blog we:

在本文中，我们将：

- Explain why debugging deep agents is different than debugging simpler LLM applications  
  - 解释为何调试深度智能体与调试更简单的 LLM 应用存在本质差异；

- Introduce [Polly](https://blog.langchain.com/introducing-polly-your-ai-agent-engineer/) (an AI assistant for agent engineering) to help in LangSmith for debugging deep agents  
  - 推出 [Polly](https://blog.langchain.com/introducing-polly-your-ai-agent-engineer/)（一款面向智能体工程的 AI 助手），助力 LangSmith 实现深度智能体的高效调试；

- Launch [langsmith-fetch](https://blog.langchain.com/introducing-langsmith-fetch/), a CLI for equipping coding agents like Claude Code or DeepAgents CLI with debugging capabilities  
  - 正式发布 [langsmith-fetch](https://blog.langchain.com/introducing-langsmith-fetch/) —— 一款命令行工具（CLI），可为 Claude Code 或 DeepAgents CLI 等编程类智能体快速赋予调试能力。

## How Deep Agents are different than simpler LLM applications

## 深度智能体与更简单的 LLM 应用有何不同？

Unlike simple LLM calls or short workflows, deep agents run for minutes, span dozens or hundreds of steps, and often involve multiple back-and-forth interactions with users.

与简单的 LLM 调用或短流程不同，深度智能体通常持续运行数分钟，执行步骤多达数十乃至数百步，并且往往需要与用户进行多轮反复交互。

![](images/debugging-deep-agents-with-langsmith/img_001.png)

![](images/debugging-deep-agents-with-langsmith/img_001.png)

As a result, the traces produced by a single deep agent execution can contain an ton of information, far more than a human can easily scan or reason about. When something goes wrong, it may not be obvious which decision, prompt instruction, or tool call caused the behavior you’re seeing.

因此，单次深度智能体执行所生成的追踪记录（trace）可能包含海量信息，远超人类所能轻松浏览或推理的范围。一旦出现问题，往往难以迅速判断：究竟是哪一项决策、哪一条提示词指令，抑或哪一次工具调用，导致了当前所观察到的异常行为。

This is where tracing with LangSmith — and using AI to analyze those traces — becomes important. So, what specifically makes deep agents more complex?

这正是 LangSmith 追踪能力——以及借助 AI 对这些追踪数据进行分析——变得至关重要的原因。那么，具体而言，是什么让深度智能体更加复杂？

- **Longer prompts:** The prompts for deep agents often span hundreds if not thousands of lines — usually containing a general persona, instructions on calling tools, important guidelines, and few-shot examples. When behavior degrades, it’s difficult to know which part of the prompt is responsible.  
  - **更长的提示词（prompts）**：深度智能体所使用的提示词往往长达数百甚至数千行，通常涵盖通用角色设定、工具调用说明、关键行为准则以及少量示例（few-shot examples）。当智能体表现退化时，很难定位问题究竟源于提示词中的哪一部分。

- **Longer traces:** Deep agents can run for dozens if not hundreds of steps (taking minutes to complete). When presented with such a large trace, there is simply more content for a human to parse through to find meaningful sections.  
  - **更长的追踪记录（traces）**：深度智能体可能执行数十乃至数百个步骤（耗时数分钟）。面对如此庞大的追踪数据，人类需要解析的内容显著增多，从中识别出关键环节也愈发困难。

- **Multiple turns:** Deep agents enable human-in-the-loop workflows by default. A meaningful example conversation with a deep agent often involves several back and forth interactions. In order to understand what the agent did and see its full trajectory, you need to look across multiple interactions.  
  - **多轮交互（multiple turns）**：深度智能体默认支持“人在环中（human-in-the-loop）”的工作流。一个典型的、富有意义的深度智能体对话，往往包含多次来回交互。要真正理解智能体的行为逻辑并完整还原其决策轨迹，就必须跨多个交互轮次进行综合分析。

## Tracing captures relevant information

## 追踪（Tracing）捕获关键信息

In order to debug an agent, you need to have visibility into what is happening inside. This is where tracing comes in.

要调试一个智能体（agent），你需要清晰地了解其内部运行状况。这正是“追踪”（tracing）发挥作用的地方。

We use the umbrella term **tracing** to describe logging your agent execution data to LangSmith. The data format consists of **runs, traces, and threads.**

我们使用统称 **tracing**（追踪）来描述将智能体执行数据记录到 LangSmith 的过程。该数据格式由 **Runs（运行步骤）、Traces（追踪链）和 Threads（会话线程）** 构成。

![](images/debugging-deep-agents-with-langsmith/img_002.png)

- **Runs:** A step that your agent takes. Examples include LLM model calls and tool calls. Runs are nested in a tree structure.  
- **Runs（运行步骤）：** 智能体执行的单个操作步骤，例如大语言模型（LLM）调用或工具（tool）调用。Runs 以树状结构嵌套组织。

- **Traces:** A single execution of your agent. A trace is made up of a tree of Runs.  
- **Traces（追踪链）：** 智能体的一次完整执行过程；一条 Trace 由一棵 Runs 树构成。

- **Threads:** A collection of Traces. A thread is a full conversation between a User and an application.  
- **Threads（会话线程）：** 多条 Traces 的集合；一个 Thread 代表用户与应用程序之间的一轮完整对话。

Tracing is super easy to set up - you can set it up in a few minutes by following this [guide](https://www.youtube.com/watch?v=fA9b4D8IsPQ&ref=blog.langchain.com).

追踪功能设置极为简便——只需几分钟，按此 [指南](https://www.youtube.com/watch?v=fA9b4D8IsPQ&ref=blog.langchain.com) 操作即可完成配置。

Once your application data is in LangSmith, you can leverage AI to analyze full agent trajectories to figure out what is going on, and then suggest updates to the prompt. There are two main ways to do this.

一旦您的应用数据接入 LangSmith，您即可借助 AI 分析智能体的完整执行轨迹，精准定位问题所在，并据此提出提示词（prompt）优化建议。实现这一目标主要有两种方式。

## Polly - an AI assistant for agent engineering

## Polly —— 面向智能体工程的 AI 助手

Polly is a [new in-app feature](https://blog.langchain.com/p/162fa797-0446-4a2b-86b5-49fdc007bfc3/?member_status=free) that allows you to chat with an agent to analyze your thread and trace data. See our [video overview here](https://youtu.be/4Ox2gdZnM6c?ref=blog.langchain.com).

Polly 是一项 [全新的应用内功能](https://blog.langchain.com/p/162fa797-0446-4a2b-86b5-49fdc007bfc3/?member_status=free)，支持您通过自然语言对话方式，让 AI 助手分析您的 Thread（会话线程）与 Trace（追踪链）数据。[点击此处观看视频概览](https://youtu.be/4Ox2gdZnM6c?ref=blog.langchain.com)。

Here are a few ways to chat with Polly!

以下是几种与 Polly 对话的方式！

**In the Trace view**

**在 Trace 视图中**

![](images/debugging-deep-agents-with-langsmith/img_003.png)

You can use Polly to debug, analyze, and understand what happened in the Trace. Instead of manually scanning dozens or hundreds of steps, you can ask Polly questions like:

您可以使用 Polly 来调试、分析并理解 Trace 中发生的事件。无需手动浏览数十甚至数百个步骤，您可直接向 Polly 提出如下问题：

- “Did the agent do anything that could be more efficient”  
- “代理是否执行了某些本可以更高效的操作？”

- “Did the agent make any mistakes”  
- “代理是否犯了任何错误？”

This is particularly helpful for deep agents, which tend to have longer traces where failure modes can be distributed across many steps.

这对“深度智能体（deep agents）”尤为有用——这类智能体通常生成更长的 Trace，其故障模式可能分散在多个步骤之中。

**In the Thread view**

**在 Thread 视图中**

![](images/debugging-deep-agents-with-langsmith/img_004.png)

This is similar to a single Trace, but here, Polly can access information from an entire thread. Threads span several conversational turns, and can oftentimes also span several hours or days. It’s hard for a person to stay aware of all of that context.

这与单个 Trace 类似，但在此视图中，Polly 可访问整个 Thread 的信息。Thread 跨越多次对话轮次，且常常持续数小时甚至数天。对人而言，要始终掌握全部上下文非常困难。

**In the Prompt Playground**

**在 Prompt Playground 中**

![](images/debugging-deep-agents-with-langsmith/img_005.png)

One of the most important parts of a Deep Agent is the system prompt. Polly is tuned to be an excellent prompt engineer! Just describe the behavior you want in natural language and Polly will update your prompt accordingly. Polly can also help you define structured output or mock tools on your model call as well.

深度代理（Deep Agent）中最重要的组成部分之一是系统提示词（system prompt）。Polly 经过专门调优，是一位出色的提示工程专家！只需用自然语言描述你期望的行为，Polly 即可相应地优化并更新你的提示词。此外，Polly 还能协助你定义结构化输出，或在模型调用中模拟工具（mock tools）。

## LangSmith Fetch CLI - a tool to make your coding agent an expert agent engineer

## LangSmith Fetch CLI —— 让你的编程智能体成为专家级智能体工程师的利器

If you prefer to work in your IDE or code agents (e.g., DeepAgents, Claude Code, etc), we have a CLI [`LangSmith Fetch`](https://github.com/langchain-ai/langsmith-fetch?ref=blog.langchain.com) that connects to LangSmith traces or threads easily. Whether you're debugging an agent, analyzing conversation flows, or building datasets from production traces, this [CLI](https://blog.langchain.com/p/647419d5-fa7e-493f-a997-d81fd0009f7a/?member_status=free) provides fast, flexible access to your LangSmith traces and threads.

如果你更习惯在 IDE 或代码智能体（例如 DeepAgents、Claude Code 等）中工作，我们提供了一个命令行工具 [`LangSmith Fetch`](https://github.com/langchain-ai/langsmith-fetch?ref=blog.langchain.com)，可轻松连接 LangSmith 的追踪记录（traces）或会话线程（threads）。无论你是在调试智能体、分析对话流程，还是基于线上生产环境的追踪数据构建数据集，该 [CLI 工具](https://blog.langchain.com/p/647419d5-fa7e-493f-a997-d81fd0009f7a/?member_status=free) 都能为你提供快速、灵活的 LangSmith 追踪与线程访问能力。

It bridges the gap between the LangSmith UI and your local workflow, letting you fetch traces or threads by ID when you know exactly what you want, or by time when you need to grab whatever just happened. With support for multiple output formats (human-readable panels, pretty JSON, or compact raw JSON), the tool adapts to your use case—whether you're inspecting data in the terminal, piping to `jq`, or feeding results to an LLM for analysis.

它弥合了 LangSmith Web 界面与本地开发工作流之间的鸿沟：当你明确知道目标 ID 时，可按 ID 精准获取追踪或线程；当需要捕获最新发生的事件时，则可按时间范围检索。工具支持多种输出格式（富文本可读面板、格式化 JSON、紧凑型原始 JSON），能灵活适配各类使用场景——无论是终端内直接查看数据、通过管道传给 `jq` 处理，还是将结果输入大语言模型（LLM）进行深度分析。

It enables two key workflows. First, the "I just ran something" workflow to grab recent threads: you execute your agent, then immediately run `langsmith-fetch threads ./my_data` to grab the most recent traces in the project without hunting for IDs in the UI. Add temporal filters like `--last-n-minutes 30` to narrow your search, or use `--project-uuid` to target a specific project.

该工具支持两大核心工作流。第一种是“我刚刚运行了某任务”式工作流，用于快速获取最近的会话线程：你执行完智能体后，立即运行 `langsmith-fetch threads ./my_data`，即可无需在 UI 中手动查找 ID，直接拉取项目中最新的追踪记录。你还可以添加时间过滤器（如 `--last-n-minutes 30`）缩小检索范围，或使用 `--project-uuid` 指定特定项目。

```markdown
# Just ran your agent? Grab the most recent trace immediately
langsmith-fetch traces --project-uuid <your-uuid> --format json

# Or grab the last 5 traces
langsmith-fetch traces --project-uuid <your-uuid> --limit 5
```

```markdown
# 刚刚运行完你的智能体？立即获取最新一条追踪记录
langsmith-fetch traces --project-uuid <your-uuid> --format json

# 或者获取最近 5 条追踪记录
langsmith-fetch traces --project-uuid <your-uuid> --limit 5
```

Second, the bulk export workflow: when you need datasets for evaluation or analysis, commands like `langsmith-fetch threads ./my-data --limit 50` fetch multiple threads and save each as a separate JSON file, perfect for batch processing or building test sets.

第二种是批量导出工作流：当你需要为评估或分析准备数据集时，可使用类似 `langsmith-fetch threads ./my-data --limit 50` 的命令，一次性拉取多个会话线程，并将每个线程保存为独立的 JSON 文件——非常适合批量处理或构建测试数据集。

```markdown
# Or grab the last 5 traces from a specific project
langsmith-fetch traces --project-uuid <your-uuid> --limit 5
```

```markdown
# 或从指定项目中获取最近 5 条追踪记录
langsmith-fetch traces --project-uuid <your-uuid> --limit 5
```

Of course, you can also supply a desired thread or trace ID. The output formats adapt to your needs: `--format pretty` for terminal viewing with Rich panels, `--format json` for readable structured data, or `--format raw` for piping to other tools.

当然，你也可以直接指定目标线程 ID 或追踪 ID。输出格式亦可按需切换：`--format pretty` 适用于终端中借助 Rich 库渲染的可视化面板；`--format json` 提供易读的结构化 JSON 数据；`--format raw` 则输出精简原始 JSON，便于管道传输至其他工具进一步处理。

## LangSmith makes it easy to debug and improve your deep agents

## LangSmith 让调试和优化您的深度智能体变得轻而易举

Deep Agents are powerful but longer running and more complex than simple LLM workflows. To understand and improve them, you need visibility into what your deep agents are actually doing.

深度智能体功能强大，但运行时间更长、结构比简单的 LLM 工作流更复杂。要理解并优化它们，您需要清晰地洞察深度智能体实际在执行哪些操作。

With LangSmith, you can trace your deep agents and see what's going on — then, chat with [Polly](https://blog.langchain.com/p/162fa797-0446-4a2b-86b5-49fdc007bfc3/?member_status=free) to analyze your deep agent’s behavior and use AI to help you improve your prompts. If you'd rather analyze it with Claude Code or another coding agent - you can use [LangSmith Fetch](https://blog.langchain.com/p/647419d5-fa7e-493f-a997-d81fd0009f7a/?member_status=free) to equip your coding agents with all the debugging tools necessary.

借助 LangSmith，您可以追踪深度智能体的执行过程，实时掌握其内部动态；随后，与 [Polly](https://blog.langchain.com/p/162fa797-0446-4a2b-86b5-49fdc007bfc3/?member_status=free) 对话，分析深度智能体的行为表现，并利用 AI 协助您优化提示词（prompts）。若您更倾向于使用 Claude Code 或其他编程智能体进行分析，也可通过 [LangSmith Fetch](https://blog.langchain.com/p/647419d5-fa7e-493f-a997-d81fd0009f7a/?member_status=free) 为您的编程智能体配备全套调试工具。

Set up tracing in just a few minutes, and try chatting with Polly today on LangSmith to debug and improve your deep agents!

仅需几分钟即可完成追踪配置——今天就登录 LangSmith，与 Polly 开始对话，立即调试并优化您的深度智能体！
{% endraw %}
