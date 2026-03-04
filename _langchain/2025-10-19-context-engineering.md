---
title: "Context Engineering"
source: "LangChain Blog"
url: "https://blog.langchain.com/context-engineering-for-agents/"
date: "2025-10-19"
scraped_at: "2026-03-03T07:22:47.378859925+00:00"
language: "en-zh"
translated: true
---
{% raw %}

### TL;DR

### 简而言之

Agents need context to perform tasks.  
Agent 需要上下文才能执行任务。

Context engineering is the art and science of filling the context window with just the right information at each step of an agent’s trajectory.  
上下文工程（Context Engineering）是一门艺术，也是一门科学——它旨在为 agent 的每一步轨迹精准填充上下文窗口，使其仅包含恰如其分的信息。

In this post, we break down some common strategies — **write, select, compress, and isolate —** for context engineering by reviewing various popular agents and papers.  
本文将通过梳理若干主流 agent 架构与代表性论文，系统拆解上下文工程的几类常见策略：**写入（write）、筛选（select）、压缩（compress）和隔离（isolate）**。

We then explain how LangGraph is designed to support them!  
随后，我们将阐述 LangGraph 是如何原生支持这些策略的！

**Also, see our video on context engineering** [**here**](https://youtu.be/4GiqzUHD5AA?ref=blog.langchain.com) **.**  
**此外，欢迎观看我们关于上下文工程的视频讲解** [**此处链接**](https://youtu.be/4GiqzUHD5AA?ref=blog.langchain.com) **。**

![](images/context-engineering/img_001.png)General categories of context engineering  
![](images/context-engineering/img_001.png)上下文工程的主要类别

### Context Engineering

### 上下文工程

As Andrej Karpathy puts it, LLMs are like a [new kind of operating system](https://www.youtube.com/watch?si=-aKY-x57ILAmWTdw&t=620&v=LCEmiRjPEtQ&feature=youtu.be&ref=blog.langchain.com).  
正如 Andrej Karpathy 所言，大语言模型（LLM）就像一种[新型操作系统](https://www.youtube.com/watch?si=-aKY-x57ILAmWTdw&t=620&v=LCEmiRjPEtQ&feature=youtu.be&ref=blog.langchain.com)。

The LLM is like the CPU and its [context window](https://docs.anthropic.com/en/docs/build-with-claude/context-windows?ref=blog.langchain.com) is like the RAM, serving as the model’s working memory.  
LLM 相当于 CPU，而其[上下文窗口](https://docs.anthropic.com/en/docs/build-with-claude/context-windows?ref=blog.langchain.com)则相当于 RAM，共同构成模型的“工作记忆”。

Just like RAM, the LLM context window has limited [capacity](https://lilianweng.github.io/posts/2023-06-23-agent/?ref=blog.langchain.com) to handle various sources of context.  
与 RAM 类似，LLM 的上下文窗口容量有限[（受限于长度）](https://lilianweng.github.io/posts/2023-06-23-agent/?ref=blog.langchain.com)，难以无差别容纳各类上下文信息。

And just as an operating system curates what fits into a CPU’s RAM, we can think about “context engineering” playing a similar role.  
正如操作系统需精心调度、决定哪些数据应载入 CPU 的 RAM，我们也应以类似思路看待“上下文工程”所扮演的角色。

[Karpathy summarizes this well](https://x.com/karpathy/status/1937902205765607626?ref=blog.langchain.com):  
[Karpathy 对此做了精辟概括](https://x.com/karpathy/status/1937902205765607626?ref=blog.langchain.com)：

> _\[Context engineering is the\] ”…delicate art and science of filling the context window with just the right information for the next step.”_  
> _“……这是一门精微的艺术，也是一门严谨的科学：在每一步中，为上下文窗口注入恰到好处的信息。”_

![](images/context-engineering/img_002.png)Context types commonly used in LLM applications  
![](images/context-engineering/img_002.png)大语言模型应用中常见的上下文类型

What are the types of context that we need to manage when building LLM applications?  
构建大语言模型应用时，我们需要管理哪些类型的上下文？

Context engineering as an [umbrella](https://x.com/dexhorthy/status/1933283008863482067?ref=blog.langchain.com) that applies across a few different context types:  
上下文工程是一个[统摄性概念](https://x.com/dexhorthy/status/1933283008863482067?ref=blog.langchain.com)，覆盖以下几类不同性质的上下文：

- **Instructions** – prompts, memories, few‑shot examples, tool descriptions, etc  
- **指令类上下文**——提示词（prompts）、记忆（memories）、少样本示例（few-shot examples）、工具描述（tool descriptions）等  

- **Knowledge** – facts, memories, etc  
- **知识类上下文**——事实性信息（facts）、记忆（memories）等  

- **Tools** – feedback from tool calls  
- **工具类上下文**——工具调用所返回的反馈（feedback from tool calls）

### Context Engineering for Agents

### 代理的上下文工程

This year, interest in [agents](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com) has grown tremendously as LLMs get better at [reasoning](https://platform.openai.com/docs/guides/reasoning?api-mode=responses&ref=blog.langchain.com) and [tool calling](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com). [Agents](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com) interleave [LLM invocations and tool calls](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com), often for [long-running tasks](https://blog.langchain.com/introducing-ambient-agents/). Agents interleave [LLM calls and tool calls](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com), using tool feedback to decide the next step.

今年，随着大语言模型（LLM）在[推理能力](https://platform.openai.com/docs/guides/reasoning?api-mode=responses&ref=blog.langchain.com)和[工具调用](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com)方面的持续提升，业界对[智能代理（agents）](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com)的关注度大幅攀升。[代理](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com)通过交替执行[LLM 调用与工具调用](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com)，常用于处理[长时间运行的任务](https://blog.langchain.com/introducing-ambient-agents/)；它们依据工具返回的反馈动态决定后续步骤。

![](images/context-engineering/img_003.png)Agents interleave [LLM calls and](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com) [tool calls](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com), using tool feedback to decide the next step

![](images/context-engineering/img_003.png)代理交替执行[LLM 调用](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com)与[工具调用](https://www.anthropic.com/engineering/building-effective-agents?ref=blog.langchain.com)，并利用工具反馈决定下一步操作。

However, long-running tasks and accumulating feedback from tool calls mean that agents often utilize a large number of tokens. This can cause numerous problems: it can [exceed the size of the context window](https://cognition.ai/blog/kevin-32b?ref=blog.langchain.com), balloon cost / latency, or degrade agent performance. Drew Breunig [nicely outlined](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com) a number of specific ways that longer context can cause perform problems, including:

然而，长时间运行的任务以及工具调用反馈的持续累积，意味着代理往往消耗大量 token。这会引发诸多问题：例如[超出上下文窗口容量](https://cognition.ai/blog/kevin-32b?ref=blog.langchain.com)、显著推高成本与延迟，或导致代理性能下降。Drew Breunig 在其文章中[清晰梳理了](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com)长上下文可能引发性能问题的若干具体机制，包括：

- [Context Poisoning: When a hallucination makes it into the context](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com#context-poisoning)  
- [上下文污染（Context Poisoning）：幻觉内容被引入上下文中](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com#context-poisoning)

- [Context Distraction: When the context overwhelms the training](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com#context-distraction)  
- [上下文干扰（Context Distraction）：上下文信息过载，干扰模型训练或推理](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com#context-distraction)

- [Context Confusion: When superfluous context influences the response](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com#context-confusion)  
- [上下文混淆（Context Confusion）：冗余上下文干扰模型输出](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com#context-confusion)

- [Context Clash: When parts of the context disagree](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com#context-clash)  
- [上下文冲突（Context Clash）：上下文内部不同部分相互矛盾](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com#context-clash)

![](images/context-engineering/img_004.png)Context from tool calls accumulates over multiple agent turns

![](images/context-engineering/img_004.png)工具调用产生的上下文在多次代理交互轮次中持续累积。

With this in mind, [Cognition](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com) called out the importance of context engineering:

鉴于上述挑战，[Cognition](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com) 特别强调了上下文工程的重要性：

> _“Context engineering” … is effectively the #1 job of engineers building AI agents._

> “上下文工程”……实质上是构建 AI 代理的工程师的首要任务。

[Anthropic](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) also laid it out clearly:

[Anthropic](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) 同样明确指出：

> _Agents often engage in conversations spanning hundreds of turns, requiring careful context management strategies._

> “代理之间的对话常常跨越数百轮次，因此亟需精细设计的上下文管理策略。”

So, how are people tackling this challenge today? We group common strategies for agent context engineering into four buckets — **write, select, compress, and isolate —** and give examples of each from review of some popular agent products and papers. We then explain how LangGraph is designed to support them!

那么，人们目前是如何应对这一挑战的呢？我们将智能体上下文工程（agent context engineering）的常见策略归纳为四大类——**写入（write）、选择（select）、压缩（compress）和隔离（isolate）**——并结合一些主流智能体产品与论文的调研，为每一类提供具体示例。随后，我们将说明 LangGraph 是如何被设计来支持这些策略的！

![](images/context-engineering/img_005.png)General categories of context engineering

![](images/context-engineering/img_005.png)上下文工程的一般分类

### Write Context

### 写入上下文

_Writing context means saving it outside the context window to help an agent perform a task._

_“写入上下文”是指将信息保存在上下文窗口之外，以辅助智能体完成任务。_

**Scratchpads**

**草稿区（Scratchpads）**

When humans solve tasks, we take notes and remember things for future, related tasks. Agents are also gaining these capabilities! Note-taking via a “ [scratchpad](https://www.anthropic.com/engineering/claude-think-tool?ref=blog.langchain.com)” is one approach to persist information while an agent is performing a task. The idea is to save information outside of the context window so that it’s available to the agent. [Anthropic’s multi-agent researcher](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) illustrates a clear example of this:

人类在解决任务时，会做笔记，并为后续相关任务记住关键信息；如今，智能体也正逐步获得这类能力！通过“[草稿区（scratchpad）](https://www.anthropic.com/engineering/claude-think-tool?ref=blog.langchain.com)”进行笔记记录，便是一种在智能体执行任务过程中持久化信息的方法。其核心思想是将信息保存在上下文窗口之外，从而确保智能体在后续步骤中仍可访问该信息。[Anthropic 的多智能体研究系统](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)便给出了一个清晰范例：

> _The LeadResearcher begins by thinking through the approach and saving its plan to Memory to persist the context, since if the context window exceeds 200,000 tokens it will be truncated and it is important to retain the plan._

> _首席研究员（LeadResearcher）首先思考整体方案，并将计划存入 Memory 以实现上下文持久化——这是因为一旦上下文窗口超过 200,000 个 token，内容即会被截断，而保留该计划至关重要。_

Scratchpads can be implemented in a few different ways. They can be a [tool call](https://www.anthropic.com/engineering/claude-think-tool?ref=blog.langchain.com) that simply [writes to a file](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem?ref=blog.langchain.com). They can also be a field in a runtime [state object](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state) that persists during the session. In either case, scratchpads let agents save useful information to help them accomplish a task.

草稿区可通过多种方式实现：它既可以是一个 [工具调用（tool call）](https://www.anthropic.com/engineering/claude-think-tool?ref=blog.langchain.com)，直接[写入文件](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem?ref=blog.langchain.com)；也可以是运行时 [状态对象（state object）](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state) 中的一个字段，在整个会话期间持续存在。无论采用哪种方式，草稿区都使智能体能够保存有用信息，从而更高效地完成任务。

**Memories**

**记忆（Memories）**

Scratchpads help agents solve a task within a given session (or [thread](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com#threads)), but sometimes agents benefit from remembering things across _many_ sessions! [Reflexion](https://arxiv.org/abs/2303.11366?ref=blog.langchain.com) introduced the idea of reflection following each agent turn and re-using these self-generated memories. [Generative Agents](https://ar5iv.labs.arxiv.org/html/2304.03442?ref=blog.langchain.com) created memories synthesized periodically from collections of past agent feedback.

草稿区主要帮助智能体在单次会话（或称 [线程（thread）](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com#threads)）内完成任务；但有时，智能体还需在**多次会话之间**持续记住信息！[Reflexion](https://arxiv.org/abs/2303.11366?ref=blog.langchain.com) 首次提出“每轮行动后进行反思（reflection）”的理念，并复用这些自主生成的记忆；而 [Generative Agents](https://ar5iv.labs.arxiv.org/html/2304.03442?ref=blog.langchain.com) 则通过周期性汇总过往智能体反馈，合成出结构化的长期记忆。

![](images/context-engineering/img_006.png)An LLM can be used to update or create memories

![](images/context-engineering/img_006.png)大语言模型（LLM）可用于更新或创建记忆。

These concepts made their way into popular products like [ChatGPT](https://help.openai.com/en/articles/8590148-memory-faq?ref=blog.langchain.com), [Cursor](https://forum.cursor.com/t/0-51-memories-feature/98509?ref=blog.langchain.com), and [Windsurf](https://docs.windsurf.com/windsurf/cascade/memories?ref=blog.langchain.com), which all have mechanisms to auto-generate long-term memories that can persist across sessions based on user-agent interactions.

这些概念已融入 ChatGPT、Cursor 和 Windsurf 等主流产品中。这些产品均具备自动生成长期记忆的机制，所生成的记忆可基于用户与智能体（agent）的交互，在不同会话间持续保留。

### Select Context

### 选择上下文

_Selecting context means pulling it into the context window to help an agent perform a task._

_“选择上下文”是指将相关信息拉取至上下文窗口中，以辅助智能体完成任务。_

**Scratchpad**

**草稿区（Scratchpad）**

The mechanism for selecting context from a scratchpad depends upon how the scratchpad is implemented. If it’s a [tool](https://www.anthropic.com/engineering/claude-think-tool?ref=blog.langchain.com), then an agent can simply read it by making a tool call. If it’s part of the agent’s runtime state, then the developer can choose what parts of state to expose to an agent each step. This provides a fine-grained level of control for exposing scratchpad context to the LLM at later turns.

从草稿区中选取上下文的具体机制，取决于草稿区的实现方式：若其被实现为一种[工具](https://www.anthropic.com/engineering/claude-think-tool?ref=blog.langchain.com)，智能体只需调用该工具即可读取；若其作为智能体运行时状态的一部分，则开发者可在每一步中自主决定向智能体暴露哪些状态内容。这种方式使得开发者能在后续对话轮次中，对向大语言模型暴露的草稿区上下文进行细粒度控制。

**Memories**

**记忆（Memories）**

If agents have the ability to save memories, they also need the ability to select memories relevant to the task they are performing. This can be useful for a few reasons. Agents might select few-shot examples ( [episodic](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#memory-types) [memories](https://arxiv.org/pdf/2309.02427?ref=blog.langchain.com)) for examples of desired behavior, instructions ( [procedural](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#memory-types) [memories](https://arxiv.org/pdf/2309.02427?ref=blog.langchain.com)) to steer behavior, or facts ( [semantic](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#memory-types) [memories](https://arxiv.org/pdf/2309.02427?ref=blog.langchain.com)) for task-relevant context.

若智能体具备保存记忆的能力，则也必须具备从中筛选出与当前任务相关记忆的能力。这一能力具有多重价值：智能体可选取少量示例（即[情景式记忆](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#memory-types)），用于展示期望的行为模式；可选取操作指令（即[程序式记忆](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#memory-types)），以引导自身行为；亦可选取事实性信息（即[语义式记忆](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#memory-types)），为任务提供相关背景知识。

![](images/context-engineering/img_007.png)

![](images/context-engineering/img_007.png)

One challenge is ensuring that relevant memories are selected. Some popular agents simply use a narrow set of files that are _always_ pulled into context. For example, many code agent use specific files to save instructions (”procedural” memories) or, in some cases, examples (”episodic” memories). Claude Code uses [`CLAUDE.md`](http://claude.md/?ref=blog.langchain.com). [Cursor](https://docs.cursor.com/context/rules?ref=blog.langchain.com) and [Windsurf](https://windsurf.com/editor/directory?ref=blog.langchain.com) use rules files.

一大挑战在于确保所选记忆确实与任务相关。部分主流智能体采取一种简化策略：始终将一组范围极窄的文件强制纳入上下文。例如，许多代码智能体使用特定文件来存储操作指令（即“程序式”记忆），有时也用于存放示例（即“情景式”记忆）。Claude Code 使用 [`CLAUDE.md`](http://claude.md/?ref=blog.langchain.com)；[Cursor](https://docs.cursor.com/context/rules?ref=blog.langchain.com) 和 [Windsurf](https://windsurf.com/editor/directory?ref=blog.langchain.com) 则采用规则文件（rules files）。

# But, if an agent is storing a larger [collection](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#collection) of facts and / or relationships (e.g., [semantic](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#memory-types) memories), selection is harder. [ChatGPT](https://help.openai.com/en/articles/8590148-memory-faq?ref=blog.langchain.com) is a good example of a popular product that stores and selects from a large collection of user-specific memories.

但若一个智能体正在存储更大规模的[事实与/或关系集合](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#collection)（例如[语义型](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#memory-types)记忆），则记忆选择将变得更加困难。[ChatGPT](https://help.openai.com/en/articles/8590148-memory-faq?ref=blog.langchain.com) 就是一个典型范例：这款广受欢迎的产品会存储并从大量用户专属记忆中进行选择。

Embeddings and / or [knowledge](https://arxiv.org/html/2501.13956v1?ref=blog.langchain.com#:~:text=In%20Zep%2C%20memory%20is%20powered,subgraph%2C%20and%20a%20community%20subgraph) [graphs](https://neo4j.com/blog/developer/graphiti-knowledge-graph-memory/?ref=blog.langchain.com#:~:text=changes%20since%20updates%20can%20trigger,and%20holistic%20memory%20for%20agentic) for memory indexing are commonly used to assist with selection. Still, memory selection is challenging. At the AIEngineer World’s Fair, [Simon Willison shared](https://simonwillison.net/2025/Jun/6/six-months-in-llms/?ref=blog.langchain.com) an example of selection gone wrong: ChatGPT fetched his location from memories and unexpectedly injected it into a requested image. This type of unexpected or undesired memory retrieval can make some users feel like the context window “ _no longer belongs to them_”!

为辅助记忆选择，常采用嵌入（embeddings）和/或[知识图谱](https://arxiv.org/html/2501.13956v1?ref=blog.langchain.com#:~:text=In%20Zep%2C%20memory%20is%20powered,subgraph%2C%20and%20a%20community%20subgraph)[(knowledge graphs)](https://neo4j.com/blog/developer/graphiti-knowledge-graph-memory/?ref=blog.langchain.com#:~:text=changes%20since%20updates%20can%20trigger,and%20holistic%20memory%20for%20agentic) 进行记忆索引。然而，记忆选择本身仍极具挑战性。在 AIEngineer 世界博览会上，[Simon Willison](https://simonwillison.net/2025/Jun/6/six-months-in-llms/?ref=blog.langchain.com) 分享了一个选择失败的典型案例：ChatGPT 从用户记忆中提取了 Simon 的地理位置，并意外地将其注入到一张用户请求生成的图像中。此类出乎意料或非预期的记忆调用，可能令部分用户产生一种错觉——仿佛上下文窗口“**已不再属于自己**”！

## **Tools**

## **工具**

Agents use tools, but can become overloaded if they are provided with too many. This is often because the tool descriptions overlap, causing model confusion about which tool to use. One approach is [to apply RAG (retrieval augmented generation) to tool descriptions](https://arxiv.org/abs/2410.14594?ref=blog.langchain.com) in order to fetch only the most relevant tools for a task. Some [recent papers](https://arxiv.org/abs/2505.03275?ref=blog.langchain.com) have shown that this improve tool selection accuracy by 3-fold.

智能体依赖工具执行任务，但若为其提供过多工具，则易导致过载。这通常源于工具描述之间存在重叠，致使模型难以判断应选用哪个工具。一种可行方案是[对工具描述应用 RAG（检索增强生成）](https://arxiv.org/abs/2410.14594?ref=blog.langchain.com)，从而只为当前任务精准检索最相关的工具。一些[最新研究论文](https://arxiv.org/abs/2505.03275?ref=blog.langchain.com)表明，该方法可将工具选择准确率提升达三倍。

## **Knowledge**

## **知识**

[RAG](https://github.com/langchain-ai/rag-from-scratch?ref=blog.langchain.com) is a rich topic and it [can be a central context engineering challenge](https://x.com/_mohansolo/status/1899630246862966837?ref=blog.langchain.com). Code agents are some of the best examples of RAG in large-scale production. Varun from Windsurf captures some of these challenges well:

[RAG](https://github.com/langchain-ai/rag-from-scratch?ref=blog.langchain.com) 是一个内涵丰富的主题，亦[可能是上下文工程中的核心挑战之一](https://x.com/_mohansolo/status/1899630246862966837?ref=blog.langchain.com)。代码智能体（code agents）则是 RAG 在大规模生产环境中落地的最佳实践范例之一。Windsurf 的 Varun 对其中若干挑战做了精辟概括：

> _Indexing code ≠ context retrieval … \[We are doing indexing & embedding search … \[with\] AST parsing code and chunking along semantically meaningful boundaries … embedding search becomes unreliable as a retrieval heuristic as the size of the codebase grows … we must rely on a combination of techniques like grep/file search, knowledge graph based retrieval, and … a re-ranking step where \[context\] is ranked in order of relevance._\
\
> _代码索引 ≠ 上下文检索……\[我们正在开展索引与嵌入搜索……\[结合\] 抽象语法树（AST）解析、沿语义合理边界进行代码分块……随着代码库规模扩大，嵌入搜索作为检索启发式方法的可靠性将显著下降……我们必须综合运用多种技术，例如 grep/文件搜索、基于知识图谱的检索，以及……一个重排序步骤，即按相关性对\[上下文\]进行排序。_

### Compressing Context

### 压缩上下文

_Compressing context involves retaining only the tokens required to perform a task._

_压缩上下文是指仅保留完成任务所必需的 token。_

#### **Context Summarization**

#### **上下文摘要**

Agent interactions can span [hundreds of turns](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) and use token-heavy tool calls. Summarization is one common way to manage these challenges. If you’ve used Claude Code, you’ve seen this in action. Claude Code runs “ [auto-compact](https://docs.anthropic.com/en/docs/claude-code/costs?ref=blog.langchain.com)” after you exceed 95% of the context window and it will summarize the full trajectory of user-agent interactions. This type of compression across an [agent trajectory](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#manage-short-term-memory) can use various strategies such as [recursive](https://arxiv.org/pdf/2308.15022?ref=blog.langchain.com#:~:text=the%20retrieved%20utterances%20capture%20the,based%203) or [hierarchical](https://alignment.anthropic.com/2025/summarization-for-monitoring/?ref=blog.langchain.com#:~:text=We%20addressed%20these%20issues%20by,of%20our%20computer%20use%20capability) summarization.

智能体交互可能跨越[数百轮次](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)，且频繁调用高 token 消耗量的工具。摘要（summarization）是应对这类挑战的常用手段之一。若您使用过 Claude Code，便已亲身体验过该机制：当上下文窗口占用率超过 95% 时，Claude Code 便会自动触发“[自动压缩（auto-compact）](https://docs.anthropic.com/en/docs/claude-code/costs?ref=blog.langchain.com)”功能，对完整的用户—智能体交互轨迹进行摘要。此类针对[智能体运行轨迹](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#manage-short-term-memory)的压缩，可采用多种策略，例如[递归式摘要](https://arxiv.org/pdf/2308.15022?ref=blog.langchain.com#:~:text=the%20retrieved%20utterances%20capture%20the,based%203)或[分层式摘要](https://alignment.anthropic.com/2025/summarization-for-monitoring/?ref=blog.langchain.com#:~:text=We%20addressed%20these%20issues%20by,of%20our%20computer%20use%20capability)。

![](images/context-engineering/img_008.png)A few places where summarization can be applied

![](images/context-engineering/img_008.png)摘要技术可应用的若干场景

It can also be useful to [add summarization](https://github.com/langchain-ai/open_deep_research/blob/e5a5160a398a3699857d00d8569cb7fd0ac48a4f/src/open_deep_research/utils.py?ref=blog.langchain.com#L1407) at specific points in an agent’s design. For example, it can be used to post-process certain tool calls (e.g., token-heavy search tools). As a second example, [Cognition](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com#a-theory-of-building-long-running-agents) mentioned summarization at agent-agent boundaries to reduce tokens during knowledge hand-off. Summarization can be a challenge if specific events or decisions need to be captured. [Cognition](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com#a-theory-of-building-long-running-agents) uses a fine-tuned model for this, which underscores how much work can go into this step.

在智能体设计的特定节点处[引入摘要机制](https://github.com/langchain-ai/open_deep_research/blob/e5a5160a398a3699857d00d8569cb7fd0ac48a4f/src/open_deep_research/utils.py?ref=blog.langchain.com#L1407)也颇具价值。例如，可用于对某些工具调用（如高 token 消耗量的搜索类工具）进行后处理；又如，[Cognition](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com#a-theory-of-building-long-running-agents) 提出可在智能体间边界处实施摘要，以降低知识交接过程中的 token 消耗。然而，若需精确捕获特定事件或关键决策，摘要本身也会构成挑战。为此，[Cognition](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com#a-theory-of-building-long-running-agents) 专门采用了微调模型来应对，这也凸显出该环节所需投入的巨大工作量。

#### **Context Trimming**

#### **上下文裁剪**

Whereas summarization typically uses an LLM to distill the most relevant pieces of context, trimming can often filter or, as Drew Breunig points out, “ [prune](https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html?ref=blog.langchain.com)” context. This can use hard-coded heuristics like removing [older messages](https://python.langchain.com/docs/how_to/trim_messages/?ref=blog.langchain.com) from a list. Drew also mentions [Provence](https://arxiv.org/abs/2501.16214?ref=blog.langchain.com), a trained context pruner for Question-Answering.

与摘要通常借助大语言模型提炼上下文中最关键信息不同，裁剪（trimming）则往往通过过滤，或如 Drew Breunig 所言，“[修剪（prune）](https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html?ref=blog.langchain.com)”上下文。其可采用硬编码启发式规则，例如从消息列表中移除[较早的历史消息](https://python.langchain.com/docs/how_to/trim_messages/?ref=blog.langchain.com)。Drew 还提到了专为问答任务训练的上下文修剪器 [Provence](https://arxiv.org/abs/2501.16214?ref=blog.langchain.com)。

### Isolating Context

### 隔离上下文

_Isolating context involves splitting it up to help an agent perform a task._

_隔离上下文是指将上下文拆分为多个部分，以协助智能体更高效地完成任务。_

#### **Multi-agent**

#### **多智能体架构**

One of the most popular ways to isolate context is to split it across sub-agents. A motivation for the OpenAI [Swarm](https://github.com/openai/swarm?ref=blog.langchain.com) library was [separation of concerns](https://openai.github.io/openai-agents-python/ref/agent/?ref=blog.langchain.com), where a team of agents can handle specific sub-tasks. Each agent has a specific set of tools, instructions, and its own context window.

将上下文分散至多个子智能体（sub-agents），是目前最主流的上下文隔离方式之一。OpenAI 的 [Swarm](https://github.com/openai/swarm?ref=blog.langchain.com) 库的设计动因之一，正是[关注点分离（separation of concerns）](https://openai.github.io/openai-agents-python/ref/agent/?ref=blog.langchain.com)：一支智能体团队可分别承担特定的子任务。每个智能体均配备专属工具集、指令集及独立的上下文窗口。

![](images/context-engineering/img_009.png)Split context across multiple agents

![](images/context-engineering/img_009.png)将上下文分散至多个智能体

Anthropic’s [multi-agent researcher](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) makes a case for this: many agents with isolated contexts outperformed single-agent, largely because each subagent context window can be allocated to a more narrow sub-task. As the blog said:\
\
Anthropic 的[多智能体研究员系统](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)有力佐证了这一观点：多个具备隔离上下文的智能体，其整体表现优于单智能体系统，主要原因在于每个子智能体的上下文窗口均可被精准分配给更聚焦的子任务。正如该博客所述：

> _\[Subagents operate\] in parallel with their own context windows, exploring different aspects of the question simultaneously._\
\
> _\[子智能体\] 各自携带独立上下文窗口，并行运作，同步探索问题的不同维度。_

Of course, the challenges with multi-agent include token use (e.g., up to [15× more tokens](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) than chat as reported by Anthropic), the need for careful [prompt engineering](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) to plan sub-agent work, and coordination of sub-agents.

当然，多智能体架构亦面临诸多挑战：包括 token 消耗量激增（据 Anthropic 报告，其消耗量可达普通对话的[15 倍](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)）、需精心开展[提示词工程（prompt engineering）](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)以规划子智能体任务，以及子智能体间的协同调度难题。

#### **Context Isolation with Environments**

#### **借助环境实现上下文隔离**

HuggingFace’s [deep researcher](https://huggingface.co/blog/open-deep-research?ref=blog.langchain.com#:~:text=From%20building%20,it%20can%20still%20use%20it) shows another interesting example of context isolation. Most agents use [tool calling APIs](https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/overview?ref=blog.langchain.com), which return JSON objects (tool arguments) that can be passed to tools (e.g., a search API) to get tool feedback (e.g., search results). HuggingFace uses a [CodeAgent](https://huggingface.co/papers/2402.01030?ref=blog.langchain.com), which outputs that contains the desired tool calls. The code then runs in a [sandbox](https://e2b.dev/?ref=blog.langchain.com). Selected context (e.g., return values) from the tool calls is then passed back to the LLM.

HuggingFace 的[深度研究员（deep researcher）](https://huggingface.co/blog/open-deep-research?ref=blog.langchain.com#:~:text=From%20building%20,it%20can%20still%20use%20it) 展示了另一种颇具启发性的上下文隔离范例。多数智能体依赖[工具调用 API](https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/overview?ref=blog.langchain.com)，这些 API 返回 JSON 格式的对象（即工具参数），供传递至具体工具（如搜索 API）以获取反馈结果（如搜索结果）。而 HuggingFace 则采用了一种 [CodeAgent](https://huggingface.co/papers/2402.01030?ref=blog.langchain.com)，其输出内容即为所需的工具调用指令；随后，该代码将在一个[沙箱环境（sandbox）](https://e2b.dev/?ref=blog.langchain.com) 中执行；最终，从工具调用中筛选出的关键上下文（如返回值）再回传至大语言模型（LLM）。

![](images/context-engineering/img_010.png)Sandboxes can isolate context from the LLM.

![](images/context-engineering/img_010.png)沙箱环境可将上下文与大语言模型相隔离。

This allows context to be isolated from the LLM in the environment. Hugging Face noted that this is a great way to isolate token-heavy objects in particular:\
\
此举使上下文得以在运行环境中与大语言模型相隔离。Hugging Face 特别指出，此法尤其适用于隔离高 token 消耗量的对象：

> _\[Code Agents allow for\] a better handling of state … Need to store this image / audio / other for later use? No problem, just assign it as a variable_ [_in your state and you \[use it later\]_](https://deepwiki.com/search/i-am-wondering-if-state-that-i_0e153539-282a-437c-b2b0-d2d68e51b873?ref=blog.langchain.com) _._\
\
> _\[代码智能体可实现\] 更优的状态管理……需要暂存这张图片/音频/其他数据以备后续使用？毫无问题，只需将其赋值为状态（state）中的一个变量，即可\[随时调用\]。_

#### **State**

#### **状态（State）**

It’s worth calling out that an agent’s runtime [state object](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state) can also be a great way to isolate context. This can serve the same purpose as sandboxing. A state object can be designed with a [schema](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#schema) that has fields that context can be written to. One field of the schema (e.g., `messages`) can be exposed to the LLM at each turn of the agent, but the schema can isolate information in other fields for more selective use.

值得强调的是，智能体运行时的[状态对象（state object）](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state) 本身也是实现上下文隔离的绝佳途径，其作用与沙箱环境类似。该状态对象可通过定义[模式（schema）](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#schema) 来构建，模式中包含若干字段，用于写入各类上下文信息。模式中的某一字段（如 `messages`）可在每一轮智能体交互中向大语言模型开放；而其余字段则可将信息加以隔离，实现更有针对性的调用。

### Context Engineering with LangSmith / LangGraph

### 基于 LangSmith / LangGraph 的上下文工程实践

So, how can you apply these ideas? Before you start, there are two foundational pieces that are helpful. First, ensure that you have a way to [look at your data](https://hamel.dev/blog/posts/evals/?ref=blog.langchain.com) and track token-usage across your agent. This helps inform where best to apply effort context engineering. [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) is well-suited for agent [tracing / observability](https://docs.smith.langchain.com/observability?ref=blog.langchain.com), and offers a great way to do this. Second, be sure you have a simple way to test whether context engineering hurts or improve agent performance. LangSmith enables [agent evaluation](https://docs.smith.langchain.com/evaluation/tutorials/agents?ref=blog.langchain.com) to test the impact of any context engineering effort.

那么，如何将上述理念付诸实践？起步之前，有两项基础准备工作至关重要：  
第一，确保您具备[查看自身数据](https://hamel.dev/blog/posts/evals/?ref=blog.langchain.com) 并全程追踪智能体 token 使用情况的能力。这有助于精准识别上下文工程最应发力的关键环节。[LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) 非常适合作为智能体的[追踪与可观测性（tracing / observability）](https://docs.smith.langchain.com/observability?ref=blog.langchain.com) 工具，为您提供便捷高效的解决方案；  
第二，务必建立一套简易机制，用以评估上下文工程究竟会削弱还是提升智能体性能。LangSmith 提供了完善的[智能体评估（agent evaluation）](https://docs.smith.langchain.com/evaluation/tutorials/agents?ref=blog.langchain.com) 功能，可全面检验任意上下文工程举措的实际影响。

#### **Write context**

#### **写入上下文**

LangGraph was designed with both thread-scoped ( [short-term](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#short-term-memory)) and [long-term memory](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#long-term-memory). Short-term memory uses [checkpointing](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com) to persist [agent state](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state) across all steps of an agent. This is extremely useful as a “scratchpad”, allowing you to write information to state and fetch it at any step in your agent trajectory.

LangGraph 原生支持线程级（即[短期记忆](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#short-term-memory)）与[长期记忆](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#long-term-memory)。短期记忆通过[检查点（checkpointing）](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com) 机制，将[智能体状态（agent state）](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state) 持久化保存于智能体运行的全部步骤之中。这一机制堪称绝佳的“草稿纸”，让您可随时将信息写入状态，并在智能体运行轨迹的任意步骤中读取调用。

LangGraph’s long-term memory lets you to persist context _across many sessions_ with your agent. It is flexible, allowing you to save small sets of [files](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#profile) (e.g., a user profile or rules) or larger [collections](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#collection) of memories. In addition, [LangMem](https://langchain-ai.github.io/langmem/?ref=blog.langchain.com) provides a broad set of useful abstractions to aid with LangGraph memory management.

LangGraph 的长期记忆能力，支持您将上下文持久化保存于与智能体的**多次会话之间**。其灵活性体现在：既可保存少量[文件](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#profile)（如用户档案或业务规则），亦可保存更大规模的[记忆集合](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#collection)。此外，[LangMem](https://langchain-ai.github.io/langmem/?ref=blog.langchain.com) 提供了一整套丰富实用的抽象接口，助力 LangGraph 的记忆管理。

#### **Select context**

#### **选择上下文**

Within each node (step) of a LangGraph agent, you can fetch [state](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state). This give you fine-grained control over what context you present to the LLM at each agent step.

在 LangGraph 智能体的每个节点（即每一步）中，您均可获取[状态（state）](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state)。这赋予您对每一步向大语言模型呈现何种上下文的精细化控制权。

In addition, LangGraph’s long-term memory is accessible within each node and supports various types of retrieval (e.g., fetching files as well as [embedding-based retrieval on a memory collection).](https://langchain-ai.github.io/langgraph/cloud/reference/cli/?ref=blog.langchain.com#adding-semantic-search-to-the-store) For an overview of long-term memory, see [our Deeplearning.ai course](https://www.deeplearning.ai/short-courses/long-term-agentic-memory-with-langgraph/?ref=blog.langchain.com). And for an entry point to memory applied to a specific agent, see our [Ambient Agents](https://academy.langchain.com/courses/ambient-agents?ref=blog.langchain.com) course. This shows how to use LangGraph memory in a long-running agent that can manage your email and learn from your feedback.

此外，LangGraph 的长期记忆在每个节点内均可访问，并支持多种检索方式（例如：文件读取，以及针对记忆集合的[基于嵌入的语义检索](https://langchain-ai.github.io/langgraph/cloud/reference/cli/?ref=blog.langchain.com#adding-semantic-search-to-the-store)）。关于长期记忆的概览，请参阅我们的 [Deeplearning.ai 课程](https://www.deeplearning.ai/short-courses/long-term-agentic-memory-with-langgraph/?ref=blog.langchain.com)；若想了解如何将记忆能力应用于特定智能体，欢迎学习我们的 [Ambient Agents 课程](https://academy.langchain.com/courses/ambient-agents?ref=blog.langchain.com)，该课程详细展示了如何在长期运行的邮件管理智能体中集成 LangGraph 记忆能力，并使其能够持续从您的反馈中学习进化。

![](images/context-engineering/img_011.png)Email agent with user feedback and long-term memory

![](images/context-engineering/img_011.png)集成用户反馈与长期记忆的邮件智能体

For tool selection, the [LangGraph Bigtool](https://github.com/langchain-ai/langgraph-bigtool?ref=blog.langchain.com) library is a great way to apply semantic search over tool descriptions. This helps select the most relevant tools for a task when working with a large collection of tools. Finally, we have several [tutorials and videos](https://langchain-ai.github.io/langgraph/tutorials/rag/langgraph_agentic_rag/?ref=blog.langchain.com) that show how to use various types of RAG with LangGraph.

针对工具选择，[LangGraph Bigtool](https://github.com/langchain-ai/langgraph-bigtool?ref=blog.langchain.com) 库提供了在工具描述上执行语义搜索的优秀方案，特别适用于面对海量工具时精准遴选最契合当前任务的工具。最后，我们还准备了多份[教程与视频](https://langchain-ai.github.io/langgraph/tutorials/rag/langgraph_agentic_rag/?ref=blog.langchain.com)，详尽演示如何在 LangGraph 中灵活运用各类 RAG 技术。

#### **Compressing context**

#### **压缩上下文**

Because LangGraph [is a low-level orchestration framework](https://blog.langchain.com/how-to-think-about-agent-frameworks/), you [lay out your agent as a set of nodes](https://www.youtube.com/watch?v=aHCDrAbH_go&ref=blog.langchain.com), [define](https://blog.langchain.com/how-to-think-about-agent-frameworks/) the logic within each one, and define an state object that is passed between them. This control offers several ways to compress context.

由于 LangGraph 是一款[底层编排框架](https://blog.langchain.com/how-to-think-about-agent-frameworks/)，您需[将智能体建模为一组节点](https://www.youtube.com/watch?v=aHCDrAbH_go&ref=blog.langchain.com)，[定义](https://blog.langchain.com/how-to-think-about-agent-frameworks/)每个节点内部的逻辑，并设计一个在各节点间传递的状态对象。这种高度可控的架构，为您提供了多种上下文压缩路径。

One common approach is to use a message list as your agent state and [summarize or trim](https://langchain-ai.github.io/langgraph/how-tos/memory/add-memory/?ref=blog.langchain.com#manage-short-term-memory) it periodically using [a few built-in utilities](https://langchain-ai.github.io/langgraph/how-tos/memory/add-memory/?ref=blog.langchain.com#manage-short-term-memory). However, you can also add logic to post-process [tool calls](https://github.com/langchain-ai/open_deep_research/blob/e5a5160a398a3699857d00d8569cb7fd0ac48a4f/src/open_deep_research/utils.py?ref=blog.langchain.com#L1407) or work phases of your agent in a few different ways. You can add summarization nodes at specific points or also add summarization logic to your tool calling node in order to compress the output of specific tool calls.

一种常见做法是将消息列表设为智能体状态，并借助[若干内置工具](https://langchain-ai.github.io/langgraph/how-tos/memory/add-memory/?ref=blog.langchain.com#manage-short-term-memory)定期对其进行[摘要或裁剪](https://langchain-ai.github.io/langgraph/how-tos/memory/add-memory/?ref=blog.langchain.com#manage-short-term-memory)。此外，您还可自主添加逻辑，以多种方式对[工具调用](https://github.com/langchain-ai/open_deep_research/blob/e5a5160a398a3699857d00d8569cb7fd0ac48a4f/src/open_deep_research/utils.py?ref=blog.langchain.com#L1407) 或智能体的工作阶段进行后处理：既可在特定节点插入摘要节点，亦可直接在工具调用节点中嵌入摘要逻辑，从而压缩特定工具调用的输出结果。

#### **Isolating context**

#### **隔离上下文**

LangGraph is designed around a [state](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state) object, allowing you to specify a state schema and access state at each agent step. For example, you can store context from tool calls in certain fields in state, isolating them from the LLM until that context is required. In addition to state, LangGraph supports use of sandboxes for context isolation. See this [repo](https://github.com/jacoblee93/mini-chat-langchain?tab=readme-ov-file&ref=blog.langchain.com) for an example LangGraph agent that uses [an E2B sandbox](https://e2b.dev/?ref=blog.langchain.com) for tool calls. See this [video](https://www.youtube.com/watch?v=FBnER2sxt0w&ref=blog.langchain.com) for an example of sandboxing using Pyodide where state can be persisted. LangGraph also has a lot of support for building multi-agent architecture, such as the [supervisor](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com) and [swarm](https://github.com/langchain-ai/langgraph-swarm-py?ref=blog.langchain.com) libraries. You can [see](https://www.youtube.com/watch?v=4nZl32FwU-o&ref=blog.langchain.com) [these](https://www.youtube.com/watch?v=JeyDrn1dSUQ&ref=blog.langchain.com) [videos](https://www.youtube.com/watch?v=B_0TNuYi56w&ref=blog.langchain.com) for more detail on using multi-agent with LangGraph.

LangGraph 的核心设计理念围绕[状态（state）](https://langchain-ai.github.io/langgraph/concepts/low_level/?ref=blog.langchain.com#state) 对象展开，允许您自定义状态模式（schema），并在每一步智能体交互中访问该状态。例如，您可将工具调用产生的上下文存入状态的特定字段中，使其与大语言模型隔离，直至该上下文真正被需要时才予以暴露。除状态机制外，LangGraph 还原生支持沙箱环境以实现上下文隔离。请参考此 [代码仓库](https://github.com/jacoblee93/mini-chat-langchain?tab=readme-ov-file&ref=blog.langchain.com)，其中展示了一个利用 [E2B 沙箱](https://e2b.dev/?ref=blog.langchain.com) 执行工具调用的 LangGraph 智能体实例；另可观看此 [视频](https://www.youtube.com/watch?v=FBnER2sxt0w&ref=blog.langchain.com)，了解如何借助 Pyodide 实现沙箱隔离并持久化保存状态。此外，LangGraph 还为构建多智能体架构提供了强大支持，例如 [supervisor](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com) 和 [swarm](https://github.com/langchain-ai/lang
{% endraw %}
