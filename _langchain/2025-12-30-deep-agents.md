---
title: "Deep Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/deep-agents/"
date: "2025-12-30"
scraped_at: "2026-03-03T07:15:08.110304231+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---
&#123;% raw %}

Using an LLM to call tools in a loop is the simplest form of an agent.  
让大语言模型（LLM）在循环中调用工具，是最简单的智能体（agent）形式。

This architecture, however, can yield agents that are “shallow” and fail to plan and act over longer, more complex tasks.  
然而，这种架构可能产生“浅层”的智能体，难以对更长周期、更复杂的任务进行规划与执行。

Applications like “ [Deep Research](https://openai.com/index/introducing-deep-research/?ref=blog.langchain.com)”, “ [Manus](https://manus.im/?ref=blog.langchain.com)”, and “ [Claude Code](https://www.anthropic.com/claude-code?ref=blog.langchain.com)” have gotten around this limitation by implementing a combination of four things: a planning tool, sub agents, access to a file system, and a detailed prompt.  
诸如“[Deep Research](https://openai.com/index/introducing-deep-research/?ref=blog.langchain.com)”、“[Manus](https://manus.im/?ref=blog.langchain.com)”和“[Claude Code](https://www.anthropic.com/claude-code?ref=blog.langchain.com)”等应用，通过整合以下四项能力，成功突破了这一局限：规划工具（planning tool）、子智能体（sub agents）、文件系统访问能力，以及详尽的系统提示（detailed prompt）。

Acknowledgements: this exploration was primarily inspired by Claude Code and reports of people using it for [more than just coding](https://x.com/alexalbert__/status/1948765443776544885?ref=blog.langchain.com). What about Claude Code made it general purpose, and could we abstract out and generalize those characteristics?  
致谢：本次探索主要受 Claude Code 启发，并参考了用户将其用于[远不止编程任务](https://x.com/alexalbert__/status/1948765443776544885?ref=blog.langchain.com)的相关报道。究竟是什么特性使 Claude Code 具备通用性？我们能否将这些特性抽象出来并加以泛化？

## Deep agents in the wild

## 现实世界中的“深度智能体”

The dominant agent architecture to emerge is also the simplest: running in a loop, calling tools.  
目前主流涌现的智能体架构，恰恰也是最简单的一种：在循环中持续运行并调用工具。

Doing this naively, however, leads to agents that are a bit shallow. “Shallow” here refers to the agents inability to plan over longer time horizons and do more complex tasks.  
但若以朴素方式实现，往往导致智能体略显“浅层”。“浅层”在此指其难以在更长的时间跨度上进行规划，也难以完成更复杂的任务。

Research and coding have emerged as two areas where agents have been created that buck this trend. All of the major model providers have an agent for Deep Research and for “async” coding tasks. Many startups and customers are creating versions of these for their specific vertical.  
研究（research）与编程（coding）已成为两类成功打破该趋势的应用领域。所有主流大模型厂商均已推出面向“深度研究”（Deep Research）和“异步编程”（async coding）任务的智能体。众多初创公司及终端客户也正为其特定垂直领域定制开发此类智能体。

I refer to these agents as “deep agents” - for their ability to dive deep on topics. They are generally capable of planning more complex tasks, and then executing over longer time horizons on those goals.  
我将这类智能体称为“深度智能体”（deep agents）——因其具备深入探究主题的能力。它们通常能对更复杂的任务进行规划，并在更长的时间跨度内持续执行以达成目标。

What makes these agents good at going deep?  
是什么让这些智能体擅长“深入”？

The core algorithm is actually the same - it’s an LLM running in a loop calling tools. The difference compared to the naive agent that is easy to build is:  
其核心算法其实完全相同——依然是一个在循环中调用工具的大语言模型。但相较于易于构建的朴素智能体，其关键差异在于：

- A detailed system prompt  
- 详尽的系统提示（system prompt）  
- Planning tool  
- 规划工具（planning tool）  
- Sub agents  
- 子智能体（sub agents）  
- File system  
- 文件系统（file system）

![](images/deep-agents/img_001.png)

## Characteristics of deep agents

## 深度智能体的特征

**Detailed system prompt**

**详尽的系统提示**

Claude Code’s [recreated system prompts](https://github.com/kn1026/cc/blob/main/claudecode.md?ref=blog.langchain.com) are long. They contain detailed instructions on how to use tools. They contain examples (few shot prompts) on how to behave in certain situations.

Claude Code 的 [重构版系统提示](https://github.com/kn1026/cc/blob/main/claudecode.md?ref=blog.langchain.com) 非常长，其中包含关于如何使用工具的详细说明，以及在特定情境下应如何响应的示例（即“少样本提示”）。

Claude Code is not an anomaly - most of the best coding or deep research agents have pretty complex system prompts. Without these system prompts, the agents would not be nearly as deep. Prompting matters still!

Claude Code 并非特例——目前最优秀的编程类或深度研究类智能体，其系统提示普遍十分复杂。若缺少这类系统提示，智能体的“深度”将大打折扣。提示工程依然至关重要！

**Planning tool**

**规划工具**

Claude Code uses a [Todo list tool](https://claudelog.com/faqs/what-is-todo-list-in-claude-code/?ref=blog.langchain.com). Funnily enough - this doesn’t do anything! It’s basically a no-op. It’s just context engineering strategy to keep the agent on track.

Claude Code 使用了一种 [待办事项列表工具](https://claudelog.com/faqs/what-is-todo-list-in-claude-code/?ref=blog.langchain.com)。有趣的是——该工具实际上并不执行任何操作！它本质上是一个空操作（no-op），仅作为一种上下文工程策略，用于帮助智能体保持任务聚焦。

Deep agents are better at executing on complex tasks over longer time horizons. Planning (even if done via a no-op tool call) is a big component of that.

深度智能体更擅长在较长的时间跨度内执行复杂任务。而规划能力（即使仅通过一次空操作式的工具调用实现）正是这一优势的关键组成部分。

**Sub agents**

**子智能体**

Claude Code can spawn [sub agents](https://docs.anthropic.com/en/docs/claude-code/sub-agents?ref=blog.langchain.com). This allows it to split up tasks. You can also create custom sub agents to have more control. This allows for ["context management and prompt shortcuts"](https://x.com/dexhorthy/status/1950288431122436597?ref=blog.langchain.com).

Claude Code 可以生成 [子智能体](https://docs.anthropic.com/en/docs/claude-code/sub-agents?ref=blog.langchain.com)，从而将任务进行拆分。你还可以创建自定义子智能体，以获得更强的控制力。这使得智能体能够实现 [“上下文管理与提示快捷方式”](https://x.com/dexhorthy/status/1950288431122436597?ref=blog.langchain.com)。

Deep agents go deeper on topics. This is largely accomplished by spinning up sub agents that specifically focused on individual tasks, and allowing those sub agents to go deep there.

深度代理在主题上挖掘得更深入。这主要通过启动专门聚焦于单个任务的子代理来实现，并允许这些子代理在各自领域内深入探索。

**File System**

**文件系统**

Claude Code (obviously) has access to the file system and can modify files on there, not just to complete its task but also to jot down notes. It also acts as a shared workspace for all agents (and sub agents) to collaborate on.

Claude Code（显然）可访问文件系统，不仅能修改其中的文件以完成任务，还能随手记下笔记。它同时也作为所有代理（及子代理）协作的共享工作区。

Manus is another example of a deep agent that makes [significant use](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus?ref=blog.langchain.com) of a file system for “memory”.

Manus 是另一个深度代理的范例，它对文件系统进行了[大量应用](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus?ref=blog.langchain.com)，将其用作“记忆”机制。

Deep agents run for long periods of time and accumulate a lot of context that they need to manage. Having a file system handy to store (and then later read from) is helpful for doing so.

深度代理通常长时间运行，并持续积累大量需要管理的上下文信息。拥有一个便捷的文件系统用于存储（以及后续读取）这些信息，对此大有裨益。

## Build your deep agent

## 构建你自己的深度代理

In order to make it easier for everyone to build a deep agent for their specific vertical, I hacked on an open source package ( [`deepagents`](https://github.com/hwchase17/deepagents?ref=blog.langchain.com)) over the weekend. You can easily install it with `pip install deepagents` and then read instructions for how to use it [here](https://github.com/hwchase17/deepagents?ref=blog.langchain.com).

为便于各行业用户构建适配自身垂直领域的深度代理，我利用周末时间开发了一个开源软件包（[`deepagents`](https://github.com/hwchase17/deepagents?ref=blog.langchain.com)）。你只需运行 `pip install deepagents` 即可轻松安装，使用说明详见[此处](https://github.com/hwchase17/deepagents?ref=blog.langchain.com)。

This package attempts to create a general purpose deep agent that can be customized to create your own custom version.

该软件包旨在构建一个通用型深度代理框架，支持高度定制化，助你打造专属版本。

It comes with built-in components mapping to the above characteristics:

它内置了与上述特性一一对应的组件：

- A system prompt inspired by Claude Code, but modified to be more general  
- 一个受 Claude Code 启发、但经改造以增强通用性的系统提示词（system prompt）  

- A no-op Todo list planning tool (same as Claude Code)  
- 一个空操作（no-op）待办事项规划工具（与 Claude Code 相同）  

- Ability to spawn sub-agents, and specify your own  
- 支持动态生成子代理，并允许用户自定义子代理类型  

- A mocked out “virtual file system” that uses the agents state (a preexisting LangGraph concept)  
- 一个模拟的“虚拟文件系统”，其底层基于代理的状态（state）实现——该状态是 LangGraph 已有的核心概念

You can easily create your own deep agent by passing in a custom prompt (will be inserted into the larger system prompt as custom instructions), custom tools, and custom subagents. We put together a simple example of a ["deep research" agent](https://github.com/langchain-ai/open_deep_research?ref=blog.langchain.com) built on top of `deepagents`.

您只需传入自定义提示词（该提示词将作为自定义指令插入到更庞大的系统提示中）、自定义工具以及自定义子智能体（subagents），即可轻松构建属于您自己的深度智能体（deep agent）。我们基于 `deepagents` 构建了一个简单的 ["深度研究" 智能体](https://github.com/langchain-ai/open_deep_research?ref=blog.langchain.com) 示例。

[**TRY OUT `deepagents` HERE**](https://github.com/hwchase17/deepagents?ref=blog.langchain.com)

[**立即试用 `deepagents`**](https://github.com/hwchase17/deepagents?ref=blog.langchain.com)

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/deep-agents/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/deep-agents/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![In software, the code documents the app. In AI, the traces do.](images/deep-agents/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用；在 AI 中，追踪记录应用。](images/deep-agents/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用；在 AI 中，追踪记录应用。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/deep-agents/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排工具——天哪！](images/deep-agents/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Reflections on Three Years of Building LangChain](images/deep-agents/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/deep-agents/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/deep-agents/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/deep-agents/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟
&#123;% endraw %}
