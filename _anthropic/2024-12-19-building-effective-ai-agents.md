---
title: "Building Effective AI Agents"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/building-effective-agents"
date: "2024-12-19"
scraped_at: "2026-03-03T07:06:52.762698176+00:00"
language: "en-zh"
translated: true
description: "Discover how Anthropic approaches the development of reliable AI agents. Learn about our research on agent capabilities, safety considerations, and technical framework for building trustworthy AI."
---
{% raw %}

Over the past year, we've worked with dozens of teams building large language model (LLM) agents across industries. Consistently, the most successful implementations weren't using complex frameworks or specialized libraries. Instead, they were building with simple, composable patterns.

过去一年中，我们与数十个跨行业的团队合作，共同构建大型语言模型（LLM）智能体（agents）。一贯以来，最成功的实践并未依赖复杂的框架或专用库，而是采用简单、可组合的设计模式。

In this post, we share what we’ve learned from working with our customers and building agents ourselves, and give practical advice for developers on building effective agents.

本文中，我们将分享在与客户协作及自主构建智能体过程中所积累的经验，并为开发者提供构建高效智能体的实用建议。

## What are agents?

## 什么是智能体（agents）？

"Agent" can be defined in several ways. Some customers define agents as fully autonomous systems that operate independently over extended periods, using various tools to accomplish complex tasks. Others use the term to describe more prescriptive implementations that follow predefined workflows. At Anthropic, we categorize all these variations as **agentic systems**, but draw an important architectural distinction between **workflows** and **agents**:

“智能体”（agent）一词有多种定义方式。部分客户将智能体定义为完全自主的系统——它们可在较长时间内独立运行，并调用各类工具完成复杂任务；另一些客户则用该术语指代更偏向指令式（prescriptive）的实现，即严格遵循预定义工作流的系统。Anthropic 将上述所有变体统称为 **智能体系统（agentic systems）**，但同时在架构层面明确区分了 **工作流（workflows）** 与 **智能体（agents）**：

- **Workflows** are systems where LLMs and tools are orchestrated through predefined code paths.  
- **Agents**, on the other hand, are systems where LLMs dynamically direct their own processes and tool usage, maintaining control over how they accomplish tasks.

- **工作流（workflows）** 是指通过预定义代码路径来编排大语言模型与工具调用的系统；  
- **智能体（agents）** 则是大语言模型能够动态主导自身执行流程与工具调用的系统，全程掌控任务达成的方式。

Below, we will explore both types of agentic systems in detail. In Appendix 1 (“Agents in Practice”), we describe two domains where customers have found particular value in using these kinds of systems.

下文将深入探讨这两类智能体系统的具体特征与适用场景。在附录 1（《智能体的实际应用》）中，我们将介绍客户在两个典型领域中应用此类系统所获得的显著价值。

## When (and when not) to use agents

## 何时（以及何时不）使用智能体？

When building applications with LLMs, we recommend finding the simplest solution possible, and only increasing complexity when needed. This might mean not building agentic systems at all. Agentic systems often trade latency and cost for better task performance, and you should consider when this tradeoff makes sense.

在基于大语言模型构建应用时，我们建议优先选择尽可能简单的解决方案，仅在必要时才增加系统复杂度——这甚至可能意味着完全无需构建智能体系统。智能体系统往往以更高的延迟和成本为代价换取更优的任务表现，因此您需审慎评估这一权衡是否合理。

When more complexity is warranted, workflows offer predictability and consistency for well-defined tasks, whereas agents are the better option when flexibility and model-driven decision-making are needed at scale. For many applications, however, optimizing single LLM calls with retrieval and in-context examples is usually enough.

当确有必要引入更高复杂度时，工作流适用于目标明确、结果可预期的任务，能提供更强的可预测性与一致性；而智能体则更适合需要大规模灵活响应与模型驱动决策的场景。然而，对许多应用而言，仅通过检索增强（retrieval）与上下文示例（in-context examples）优化单次大语言模型调用，通常已足以满足需求。

## When and how to use frameworks

## 何时以及如何使用框架？

There are many frameworks that make agentic systems easier to implement, including:

- The [Claude Agent SDK](https://platform.claude.com/docs/en/agent-sdk/overview);
- [Strands Agents SDK by AWS](https://strandsagents.com/latest/);
- [Rivet](https://rivet.ironcladapp.com/), a drag and drop GUI LLM workflow builder; and
- [Vellum](https://www.vellum.ai/), another GUI tool for building and testing complex workflows.

目前有许多框架可简化智能体（agentic）系统的实现，包括：

- [Claude 智能体 SDK](https://platform.claude.com/docs/en/agent-sdk/overview)；
- [AWS 推出的 Strands 智能体 SDK](https://strandsagents.com/latest/)；
- [Rivet](https://rivet.ironcladapp.com/) —— 一款支持拖放操作的图形界面 LLM 工作流构建工具；以及
- [Vellum](https://www.vellum.ai/) —— 另一款用于构建和测试复杂工作流的图形界面工具。

These frameworks make it easy to get started by simplifying standard low-level tasks like calling LLMs, defining and parsing tools, and chaining calls together. However, they often create extra layers of abstraction that can obscure the underlying prompts ​​and responses, making them harder to debug. They can also make it tempting to add complexity when a simpler setup would suffice.

这些框架通过简化调用大语言模型（LLM）、定义与解析工具、串联多次调用等底层常规任务，显著降低了入门门槛。然而，它们往往引入额外的抽象层，可能掩盖底层的提示词（prompts）与响应内容，从而增加调试难度；此外，还容易诱使开发者在本可采用更简洁方案的场景下，不必要地引入复杂性。

We suggest that developers start by using LLM APIs directly: many patterns can be implemented in a few lines of code. If you do use a framework, ensure you understand the underlying code. Incorrect assumptions about what's under the hood are a common source of customer error.

我们建议开发者从直接调用 LLM API 入手：许多设计模式仅需数行代码即可实现。若确实使用某类框架，请务必深入理解其底层实现逻辑；对底层机制的错误假设，是客户常见错误的重要根源之一。

See our [cookbook](https://platform.claude.com/cookbook/patterns-agents-basic-workflows) for some sample implementations.

请参阅我们的 [示例手册（cookbook）](https://platform.claude.com/cookbook/patterns-agents-basic-workflows)，了解若干典型实现示例。

## Building blocks, workflows, and agents

## 构建模块、工作流与智能体

In this section, we’ll explore the common patterns for agentic systems we’ve seen in production. We'll start with our foundational building block—the augmented LLM—and progressively increase complexity, from simple compositional workflows to autonomous agents.

本节将探讨我们在实际生产环境中观察到的智能体系统常用模式。我们将以基础构建模块——增强型大语言模型（augmented LLM）为起点，逐步提升复杂度，依次介绍简单组合式工作流（compositional workflows）与自主智能体（autonomous agents）。

### Building block: The augmented LLM

### 构建模块：增强型大语言模型（augmented LLM）

The basic building block of agentic systems is an LLM enhanced with augmentations such as retrieval, tools, and memory. Our current models can actively use these capabilities—generating their own search queries, selecting appropriate tools, and determining what information to retain.

智能体系统的基本构建模块，是一种经增强的大语言模型（LLM），其增强能力包括检索（retrieval）、工具调用（tools）与记忆（memory）等。当前我们的模型已能主动运用这些能力——例如自动生成搜索查询、选择恰当的工具，并判断应保留哪些信息。

![](images/building-effective-ai-agents/img_001.jpg)The augmented LLM

![](images/building-effective-ai-agents/img_001.jpg)增强型大语言模型

We recommend focusing on two key aspects of the implementation: tailoring these capabilities to your specific use case and ensuring they provide an easy, well-documented interface for your LLM. While there are many ways to implement these augmentations, one approach is through our recently released [Model Context Protocol](https://www.anthropic.com/news/model-context-protocol), which allows developers to integrate with a growing ecosystem of third-party tools with a simple [client implementation](https://modelcontextprotocol.io/tutorials/building-a-client#building-mcp-clients).

我们建议在实现过程中重点关注两个关键方面：一是将这些能力适配到您的具体应用场景中；二是确保它们为您的大语言模型（LLM）提供简洁、文档完备的接口。尽管实现此类增强功能的方式多种多样，但其中一种方法是采用我们近期发布的 [Model Context Protocol（模型上下文协议，MCP）](https://www.anthropic.com/news/model-context-protocol)，该协议允许开发者通过一个简易的 [客户端实现](https://modelcontextprotocol.io/tutorials/building-a-client#building-mcp-clients)，接入日益壮大的第三方工具生态系统。

For the remainder of this post, we'll assume each LLM call has access to these augmented capabilities.

在本文余下部分中，我们将假设每次 LLM 调用均可访问这些增强能力。

### Workflow: Prompt chaining

### 工作流：提示链（Prompt Chaining）

Prompt chaining decomposes a task into a sequence of steps, where each LLM call processes the output of the previous one. You can add programmatic checks (see "gate” in the diagram below) on any intermediate steps to ensure that the process is still on track.

提示链将一项任务分解为一系列步骤，其中每次 LLM 调用均处理前一步的输出。您可在任意中间步骤中加入程序化校验机制（参见下方示意图中的“gate”/“门控”节点），以确保整个流程始终处于正确轨道上。

![](images/building-effective-ai-agents/img_002.jpg)The prompt chaining workflow

![](images/building-effective-ai-agents/img_002.jpg)提示链工作流

**When to use this workflow:** This workflow is ideal for situations where the task can be easily and cleanly decomposed into fixed subtasks. The main goal is to trade off latency for higher accuracy, by making each LLM call an easier task.

**适用场景：** 当任务可被清晰、自然地拆解为若干固定子任务时，该工作流尤为适用。其核心目标是通过降低单次 LLM 调用的难度，以适当增加延迟为代价，换取更高的整体准确性。

**Examples where prompt chaining is useful:**

**提示链适用的典型示例：**

- Generating Marketing copy, then translating it into a different language.

- 先生成营销文案，再将其翻译为另一种语言。

- Writing an outline of a document, checking that the outline meets certain criteria, then writing the document based on the outline.

- 先撰写文档大纲，再校验该大纲是否满足特定要求，最后依据合格的大纲撰写完整文档。

### Workflow: Routing

### 工作流：路由（Routing）

Routing classifies an input and directs it to a specialized followup task. This workflow allows for separation of concerns, and building more specialized prompts. Without this workflow, optimizing for one kind of input can hurt performance on other inputs.

路由机制对输入进行分类，并将其导向专门化的后续任务。该工作流支持关注点分离（separation of concerns），并有助于构建更具针对性的提示词（prompts）。若不采用此工作流，针对某类输入所做的优化，反而可能损害其他类型输入的处理性能。

![](images/building-effective-ai-agents/img_003.jpg)路由工作流

![](images/building-effective-ai-agents/img_003.jpg)The routing workflow

**何时使用该工作流：** 当任务较为复杂、存在明显可区分的类别（且各类别更适合由不同模块分别处理），同时分类本身能够被准确完成（无论是通过大语言模型 LLM，还是更传统的分类模型/算法）时，路由（Routing）是一种非常适用的工作流。

**路由适用的典型场景：**

- 将不同类型的客户服务咨询（如一般性问题、退款申请、技术支持请求）分发至不同的下游处理流程、提示词（prompt）及工具。
- 将简单/常见问题路由至更轻量、成本更低的模型（例如 Claude Haiku 4.5），而将困难/异常问题路由至能力更强的模型（例如 Claude Sonnet 4.5），从而在性能与成本之间实现最优平衡。

### 工作流：并行化（Parallelization）

### Workflow: Parallelization

大语言模型（LLM）有时可对同一任务进行并行处理，并通过程序自动聚合其输出结果。这种“并行化”工作流主要体现为两种关键形式：

- **分段处理（Sectioning）**：将一项任务拆解为多个相互独立的子任务，并行执行；
- **投票机制（Voting）**：对同一任务多次运行，以获取多样化输出。

![](images/building-effective-ai-agents/img_004.jpg)并行化工作流

![](images/building-effective-ai-agents/img_004.jpg)The parallelization workflow

**何时使用该工作流：** 当子任务可被有效并行执行以提升速度，或当需要多个视角/多次尝试以提高结果置信度时，并行化尤为有效。对于需综合多方面考量的复杂任务，LLM 通常在每次调用仅聚焦于单一维度时表现更佳——即通过多次独立调用，让每个 LLM 专门处理一个特定方面，从而获得更高质量的整体输出。

**并行化适用的典型场景：**

- **Sectioning**:
- **分段处理（Sectioning）**：
  - 实施防护机制（guardrails），即由一个大语言模型（LLM）实例处理用户查询，而另一个实例专门对查询内容进行筛查，识别其中是否包含不当内容或违规请求。这种分离式架构通常比让同一个 LLM 同时承担防护与核心响应任务表现更优。
  - 自动化评估（evals）：通过多个 LLM 调用分别评估模型在给定提示（prompt）下的不同性能维度（例如事实准确性、逻辑连贯性、安全性等），从而全面衡量其表现。

- **Voting**:
- **投票机制（Voting）**：
  - 对一段代码进行漏洞审查：使用多个不同的提示词（prompts）分别对同一段代码进行分析；若任一提示词识别出潜在问题，则标记该代码为存在风险。
  - 判断某段内容是否不当：由多个提示词从不同角度（如暴力、偏见、隐私泄露等）独立评估，并可设定差异化投票阈值（例如“2/3同意即判定为不当”），以在误报（false positives）与漏报（false negatives）之间取得平衡。

### Workflow: Orchestrator-workers

### 工作流：协调器–工作者（Orchestrator-workers）

In the orchestrator-workers workflow, a central LLM dynamically breaks down tasks, delegates them to worker LLMs, and synthesizes their results.

在协调器–工作者工作流中，一个中心化的 LLM 动态地将任务分解为子任务，分派给多个“工作者”LLM 并整合其返回结果。

![](images/building-effective-ai-agents/img_005.jpg)The orchestrator-workers workflow

![](images/building-effective-ai-agents/img_005.jpg)协调器–工作者工作流

**When to use this workflow:** This workflow is well-suited for complex tasks where you can’t predict the subtasks needed (in coding, for example, the number of files that need to be changed and the nature of the change in each file likely depend on the task). Whereas it’s topographically similar, the key difference from parallelization is its flexibility—subtasks aren't pre-defined, but determined by the orchestrator based on the specific input.

**适用场景：** 该工作流特别适用于子任务难以预先确定的复杂任务（例如编程任务中，需修改的文件数量及每个文件的具体修改方式，往往高度依赖于原始需求）。尽管其结构上看似与并行化相似，但关键区别在于其灵活性——子任务并非静态预设，而是由协调器根据具体输入动态判定和生成。

**Example where orchestrator-workers is useful:**

**协调器–工作者工作流的典型应用场景：**

- Coding products that make complex changes to multiple files each time.  
  每次均需对多个文件执行复杂变更的编程类产品（如智能代码重构工具、AI辅助开发平台）。

- Search tasks that involve gathering and analyzing information from multiple sources for possible relevant information.  
  需从多个信息源采集并综合分析以挖掘潜在相关情报的搜索类任务（如竞品技术调研、跨文档知识推理）。

### Workflow: Evaluator-optimizer

### 工作流：评估器–优化器（Evaluator-optimizer）

In the evaluator-optimizer workflow, one LLM call generates a response while another provides evaluation and feedback in a loop.

在评估器–优化器工作流中，一个 LLM 调用负责生成初始响应，另一个 LLM 则在循环中持续对其进行评估并提供反馈，驱动迭代优化。

![](images/building-effective-ai-agents/img_006.jpg)The evaluator-optimizer workflow

![](images/building-effective-ai-agents/img_006.jpg)评估器–优化器工作流

**When to use this workflow:** This workflow is particularly effective when we have clear evaluation criteria, and when iterative refinement provides measurable value. The two signs of good fit are, first, that LLM responses can be demonstrably improved when a human articulates their feedback; and second, that the LLM can provide such feedback. This is analogous to the iterative writing process a human writer might go through when producing a polished document.

**何时使用该工作流：** 当我们拥有明确的评估标准，且迭代优化能带来可衡量的价值时，该工作流尤为有效。判断其适用性的两个关键信号是：第一，当人类清晰表达反馈意见时，大语言模型（LLM）的输出确实能得到显著改进；第二，该 LLM 本身能够提供此类反馈。这一过程类似于人类作者在撰写精修文稿时所经历的反复修改过程。

**Examples where evaluator-optimizer is useful:**

**评估者–优化器模式适用的典型场景：**

- Literary translation where there are nuances that the translator LLM might not capture initially, but where an evaluator LLM can provide useful critiques.  
- 文学翻译任务：译者型 LLM 可能初次无法准确捕捉文本中的细微语义或风格特征，但评估者型 LLM 可提供富有洞见的批评性反馈。

- Complex search tasks that require multiple rounds of searching and analysis to gather comprehensive information, where the evaluator decides whether further searches are warranted.  
- 复杂检索任务：需经过多轮搜索与分析以获取全面信息，由评估者判断是否需要启动下一轮检索。

### Agents

### 智能体（Agents）

Agents are emerging in production as LLMs mature in key capabilities—understanding complex inputs, engaging in reasoning and planning, using tools reliably, and recovering from errors. Agents begin their work with either a command from, or interactive discussion with, the human user. Once the task is clear, agents plan and operate independently, potentially returning to the human for further information or judgement. During execution, it's crucial for the agents to gain “ground truth” from the environment at each step (such as tool call results or code execution) to assess its progress. Agents can then pause for human feedback at checkpoints or when encountering blockers. The task often terminates upon completion, but it’s also common to include stopping conditions (such as a maximum number of iterations) to maintain control.

随着大语言模型在若干核心能力上的持续成熟——包括理解复杂输入、开展推理与规划、稳定调用工具、以及从错误中恢复——智能体正逐步走向实际生产应用。智能体的工作通常始于人类用户的明确指令，或与其展开交互式对话。一旦任务目标明确，智能体将自主进行规划并独立执行，必要时可主动返回向人类用户请求补充信息或关键判断。在执行过程中，智能体必须在每一步都从环境中获取“真实反馈”（例如工具调用结果或代码执行输出），以实时评估自身进展。智能体可在预设检查点暂停，或在遭遇阻塞时主动请求人工反馈。任务通常在完成时终止，但为保障可控性，实践中也常设置终止条件（例如最大迭代轮数）。

Agents can handle sophisticated tasks, but their implementation is often straightforward. They are typically just LLMs using tools based on environmental feedback in a loop. It is therefore crucial to design toolsets and their documentation clearly and thoughtfully. We expand on best practices for tool development in Appendix 2 ("Prompt Engineering your Tools").

智能体可胜任高度复杂的任务，但其具体实现往往十分简洁：本质上，它们通常是基于环境反馈循环调用工具的大语言模型。因此，工具集的设计及其文档编写必须清晰、审慎。关于工具开发的最佳实践，详见附录 2（《为你的工具进行提示工程》）。

![](images/building-effective-ai-agents/img_007.jpg)Autonomous agent

![](images/building-effective-ai-agents/img_007.jpg)自主智能体（Autonomous Agent）

**When to use agents:** Agents can be used for open-ended problems where it’s difficult or impossible to predict the required number of steps, and where you can’t hardcode a fixed path. The LLM will potentially operate for many turns, and you must have some level of trust in its decision-making. Agents' autonomy makes them ideal for scaling tasks in trusted environments.

**何时使用智能体：** 当面对开放性问题时，若难以甚至无法预先确定所需执行步骤的数量，且无法通过硬编码设定固定执行路径，则适合采用智能体。在此类场景中，大语言模型可能需经历多轮交互与决策，因而要求使用者对其判断能力具备一定程度的信任。智能体的自主性使其成为在可信环境中规模化部署任务的理想选择。

The autonomous nature of agents means higher costs, and the potential for compounding errors. We recommend extensive testing in sandboxed environments, along with the appropriate guardrails.

智能体的自主特性意味着更高的计算成本，以及错误累积的风险。我们建议在沙箱环境中开展充分测试，并配套部署恰当的安全护栏（guardrails）。

**Examples where agents are useful:**  

**智能体适用的典型场景：**

The following examples are from our own implementations:

以下示例源自我们自身的实现：

- A coding Agent to resolve [SWE-bench tasks](https://www.anthropic.com/research/swe-bench-sonnet), which involve edits to many files based on a task description;  
- 一个用于解决 [SWE-bench 任务](https://www.anthropic.com/research/swe-bench-sonnet) 的编程智能体（coding Agent），这类任务需根据任务描述对多个文件进行修改；

- Our [“computer use” reference implementation](https://github.com/anthropics/anthropic-quickstarts/tree/main/computer-use-demo), where Claude uses a computer to accomplish tasks.  
- 我们的 [“计算机使用”参考实现](https://github.com/anthropics/anthropic-quickstarts/tree/main/computer-use-demo)，其中 Claude 通过操作计算机完成各类任务。

![](images/building-effective-ai-agents/img_008.jpg)High-level flow of a coding agent  
![](images/building-effective-ai-agents/img_008.jpg)编程智能体的高层工作流程

## Combining and customizing these patterns  

## 组合与定制这些模式  

These building blocks aren't prescriptive. They're common patterns that developers can shape and combine to fit different use cases. The key to success, as with any LLM features, is measuring performance and iterating on implementations. To repeat: you should consider adding complexity _only_ when it demonstrably improves outcomes.  
这些构建模块并非强制性规范，而是开发者可根据不同应用场景灵活调整与组合的常见模式。与所有大语言模型（LLM）功能一样，成功的关键在于持续衡量性能并迭代优化实现方案。再次强调：**仅当新增复杂性被证实能切实提升效果时，才应引入该复杂性。**

## Summary  

## 总结  

Success in the LLM space isn't about building the most sophisticated system. It's about building the _right_ system for your needs. Start with simple prompts, optimize them with comprehensive evaluation, and add multi-step agentic systems only when simpler solutions fall short.  
在大语言模型领域取得成功，并不取决于构建最复杂的系统，而在于构建**最适合你需求的系统**。从简洁的提示词（prompt）起步，借助全面评估不断优化；仅当更简单的方案已无法满足要求时，再引入多步骤的智能体（agentic）系统。

When implementing agents, we try to follow three core principles:  
在实现智能体时，我们力求遵循以下三项核心原则：

1. Maintain **simplicity** in your agent's design.  
1. 在智能体设计中坚持**简洁性**；

2. Prioritize **transparency** by explicitly showing the agent’s planning steps.  
2. 通过显式呈现智能体的规划步骤，优先保障**透明性**；

3. Carefully craft your agent-computer interface (ACI) through thorough tool **documentation and testing**.  
3. 借助详尽的工具**文档编写与测试**，精心设计智能体—计算机接口（Agent-Computer Interface, ACI）。

Frameworks can help you get started quickly, but don't hesitate to reduce abstraction layers and build with basic components as you move to production. By following these principles, you can create agents that are not only powerful but also reliable, maintainable, and trusted by their users.  
框架可助你快速上手，但一旦进入生产阶段，请毫不犹豫地降低抽象层级，转而使用基础组件进行构建。遵循上述原则，你将不仅能打造出功能强大的智能体，更能确保其具备高可靠性、易维护性，并赢得用户的信赖。

### Acknowledgements

### 致谢

Written by Erik Schluntz and Barry Zhang. This work draws upon our experiences building agents at Anthropic and the valuable insights shared by our customers, for which we're deeply grateful.

由 Erik Schluntz 和 Barry Zhang 撰写。本工作基于我们在 Anthropic 构建智能体（agents）的实践经验，并深受客户所分享的宝贵洞见启发——对此，我们深表感激。

## Appendix 1: Agents in practice

## 附录 1：实践中的智能体

Our work with customers has revealed two particularly promising applications for AI agents that demonstrate the practical value of the patterns discussed above. Both applications illustrate how agents add the most value for tasks that require both conversation and action, have clear success criteria, enable feedback loops, and integrate meaningful human oversight.

我们与客户的合作实践揭示了人工智能智能体（AI agents）两个极具前景的应用场景，充分印证了上文所讨论设计模式的实际价值。这两个案例均表明：当任务同时需要对话交互与执行动作、具备明确的成功标准、支持反馈闭环，并能融入有意义的人类监督时，智能体所能创造的价值最为显著。

### A. Customer support

### A. 客户支持

Customer support combines familiar chatbot interfaces with enhanced capabilities through tool integration. This is a natural fit for more open-ended agents because:

客户支持将用户熟悉的聊天机器人界面与通过工具集成实现的增强能力相结合。这一场景天然适配更具开放性的智能体，原因在于：

- Support interactions naturally follow a conversation flow while requiring access to external information and actions;  
  - 支持交互天然遵循对话流程，同时又需访问外部信息并执行操作；  

- Tools can be integrated to pull customer data, order history, and knowledge base articles;  
  - 可集成各类工具以调取客户资料、订单历史及知识库文章；  

- Actions such as issuing refunds or updating tickets can be handled programmatically; and  
  - 退款、工单更新等操作可由程序自动完成；  

- Success can be clearly measured through user-defined resolutions.  
  - 成功与否可通过用户定义的解决结果清晰衡量。

Several companies have demonstrated the viability of this approach through usage-based pricing models that charge only for successful resolutions, showing confidence in their agents' effectiveness.

多家公司已通过“按成功解决次数计费”的用量型定价模式验证了该方案的可行性，彰显了其对自身智能体效能的信心。

### B. Coding agents

### B. 编程智能体

The software development space has shown remarkable potential for LLM features, with capabilities evolving from code completion to autonomous problem-solving. Agents are particularly effective because:  

软件开发领域已展现出大语言模型（LLM）功能的巨大潜力，其能力正从代码补全逐步演进至自主问题求解。编程智能体在此尤为高效，原因在于：

- Code solutions are verifiable through automated tests;  
- 代码解决方案可通过自动化测试进行验证；  

- Agents can iterate on solutions using test results as feedback;  
- 智能体可利用测试结果作为反馈，对解决方案进行迭代优化；  

- The problem space is well-defined and structured; and  
- 问题空间定义清晰、结构明确；且  

- Output quality can be measured objectively.  
- 输出质量可被客观衡量。  

In our own implementation, agents can now solve real GitHub issues in the [SWE-bench Verified](https://www.anthropic.com/research/swe-bench-sonnet) benchmark based on the pull request description alone. However, whereas automated testing helps verify functionality, human review remains crucial for ensuring solutions align with broader system requirements.  

在我们自己的实现中，智能体现在仅依据 Pull Request 描述，即可解决 [SWE-bench Verified](https://www.anthropic.com/research/swe-bench-sonnet) 基准测试中的真实 GitHub 问题。然而，尽管自动化测试有助于验证功能正确性，人工评审仍至关重要——它确保解决方案符合更广泛的系统需求。

## Appendix 2: Prompt engineering your tools  

## 附录 2：对工具进行提示工程优化  

No matter which agentic system you're building, tools will likely be an important part of your agent. [Tools](https://www.anthropic.com/news/tool-use-ga) enable Claude to interact with external services and APIs by specifying their exact structure and definition in our API. When Claude responds, it will include a [tool use block](https://docs.anthropic.com/en/docs/build-with-claude/tool-use#example-api-response-with-a-tool-use-content-block) in the API response if it plans to invoke a tool. Tool definitions and specifications should be given just as much prompt engineering attention as your overall prompts. In this brief appendix, we describe how to prompt engineer your tools.  

无论您构建的是哪一类智能体系统，工具（Tools）很可能都将成为智能体的重要组成部分。[工具](https://www.anthropic.com/news/tool-use-ga) 使 Claude 能够通过在 API 中精确声明其结构与定义，与外部服务和 API 进行交互。当 Claude 生成响应时，若计划调用某项工具，其 API 响应中将包含一个 [tool use block（工具调用块）](https://docs.anthropic.com/en/docs/build-with-claude/tool-use#example-api-response-with-a-tool-use-content-block)。工具的定义与规格说明，理应获得与整体提示词同等程度的提示工程关注。本简短附录将介绍如何对工具进行提示工程优化。

There are often several ways to specify the same action. For instance, you can specify a file edit by writing a diff, or by rewriting the entire file. For structured output, you can return code inside markdown or inside JSON. In software engineering, differences like these are cosmetic and can be converted losslessly from one to the other. However, some formats are much more difficult for an LLM to write than others. Writing a diff requires knowing how many lines are changing in the chunk header before the new code is written. Writing code inside JSON (compared to markdown) requires extra escaping of newlines and quotes.  

对同一操作，往往存在多种指定方式。例如，文件编辑既可通过编写 diff 实现，也可通过重写整个文件完成；对于结构化输出，代码既可置于 Markdown 代码块中，也可嵌入 JSON 字段内。在软件工程实践中，此类差异通常属于表层形式（cosmetic），且可在不丢失信息的前提下相互无损转换。然而，对大语言模型（LLM）而言，某些格式明显比另一些更难生成：编写 diff 需在写出新代码前，就预先确定变更块（chunk）头部所声明的行数；而将代码嵌入 JSON（相较 Markdown）则需额外转义换行符与引号。

Our suggestions for deciding on tool formats are the following:  

我们关于工具格式选型的建议如下：

- Give the model enough tokens to "think" before it writes itself into a corner.  
- 为模型预留充足的 token 空间，使其能在“陷入死胡同”前充分“思考”；  

- Keep the format close to what the model has seen naturally occurring in text on the internet.  
- 尽量采用模型在互联网文本中自然见过的格式；  

- Make sure there's no formatting "overhead" such as having to keep an accurate count of thousands of lines of code, or string-escaping any code it writes.  
- 确保格式本身不引入额外负担，例如：无需精确统计数千行代码的行号，或强制对模型生成的任意代码进行字符串转义。

One rule of thumb is to think about how much effort goes into human-computer interfaces (HCI), and plan to invest just as much effort in creating good _agent_-computer interfaces (ACI). Here are some thoughts on how to do so:  

一条经验法则是：请类比人类—计算机交互界面（HCI）所需投入的设计精力，并为打造优秀的 *智能体—计算机交互界面*（ACI）投入同等努力。以下是一些具体实践思路：

- Put yourself in the model's shoes. Is it obvious how to use this tool, based on the description and parameters, or would you need to think carefully about it? If so, then it’s probably also true for the model. A good tool definition often includes example usage, edge cases, input format requirements, and clear boundaries from other tools.  
- 设身处地站在模型视角思考：仅凭工具描述与参数，其用途是否一目了然？还是需要反复推敲？若你本人尚需仔细琢磨，那模型大概率也会如此。一份优秀的工具定义，通常包含典型使用示例、边界情况说明、输入格式要求，以及与其他工具的清晰职责边界。  

- How can you change parameter names or descriptions to make things more obvious? Think of this as writing a great docstring for a junior developer on your team. This is especially important when using many similar tools.  
- 如何调整参数名称或描述，以提升其直观性？不妨将其视作为你团队中初级开发人员撰写的优质文档字符串（docstring）。当同时使用多个功能相似的工具时，这一点尤为重要。  

- Test how the model uses your tools: Run many example inputs in our [workbench](https://console.anthropic.com/workbench) to see what mistakes the model makes, and iterate.  
- 测试模型对工具的实际使用效果：在我们的 [工作台（Workbench）](https://console.anthropic.com/workbench) 中运行大量示例输入，观察模型常犯哪些错误，并持续迭代优化。  

- [Poka-yoke](https://en.wikipedia.org/wiki/Poka-yoke) your tools. Change the arguments so that it is harder to make mistakes.  
- 对工具实施 [防错设计（Poka-yoke）](https://en.wikipedia.org/wiki/Poka-yoke)：调整参数设计，使误用变得更为困难。

While building our agent for [SWE-bench](https://www.anthropic.com/research/swe-bench-sonnet), we actually spent more time optimizing our tools than the overall prompt. For example, we found that the model would make mistakes with tools using relative filepaths after the agent had moved out of the root directory. To fix this, we changed the tool to always require absolute filepaths—and we found that the model used this method flawlessly.  

在为 [SWE-bench](https://www.anthropic.com/research/swe-bench-sonnet) 构建智能体的过程中，我们实际投入在工具优化上的时间，甚至超过了整体提示词的优化时间。例如，我们发现：当智能体离开项目根目录后，若工具接受相对路径（relative filepaths），模型便容易出错。为此，我们将该工具改为**始终要求绝对路径（absolute filepaths）**；结果表明，模型此后对该工具的调用完全准确无误。

[Engineering at Anthropic](https://www.anthropic.com/engineering)

[Anthropic 工程团队](https://www.anthropic.com/engineering)

![](images/building-effective-ai-agents/img_009.svg)

![](images/building-effective-ai-agents/img_009.svg)

# Building effective agents

# 构建高效的 AI 智能体

Published Dec 19, 2024

发布于 2024 年 12 月 19 日

We've worked with dozens of teams building LLM agents across industries. Consistently, the most successful implementations use simple, composable patterns rather than complex frameworks.

我们已与数十个跨行业的团队合作，共同构建大语言模型（LLM）智能体。实践表明，最成功的落地案例普遍采用简洁、可组合的设计模式，而非复杂的框架。

## Get the developer newsletter

## 订阅开发者简报

Product updates, how-tos, community spotlights, and more. Delivered monthly to your inbox.

产品更新、实用教程、社区亮点等内容，每月推送至您的邮箱。
{% endraw %}
