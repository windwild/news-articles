---
render_with_liquid: false
title: "How and when to build multi-agent systems"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-and-when-to-build-multi-agent-systems/"
date: "2025-06-16"
scraped_at: "2026-03-03T07:30:26.431622081+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---
render_with_liquid: false
render_with_liquid: false

Late last week two great blog posts were released with seemingly opposite titles. [“Don’t Build Multi-Agents”](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com) by the Cognition team, and [“How we built our multi-agent research system”](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) by the Anthropic team.

上周晚些时候，两篇极富洞见的博客文章相继发布，标题看似截然相反：Cognition 团队撰写的 [《不要构建多智能体系统》](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com)，以及 Anthropic 团队撰写的 [《我们如何构建多智能体研究系统》](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)。

Despite their opposing titles, I would argue they actually have a lot in common and contain some insights as to how and when to build multi-agent systems:

尽管标题针锋相对，但我认为这两篇文章实则高度共识，并共同揭示了构建多智能体系统的关键原则与适用场景：

1. Context engineering is crucial  
1. 上下文工程（Context Engineering）至关重要  

2. Multi-agent systems that primarily “read” are easier than those that “write”  
2. 主要执行“读取”操作的多智能体系统，比主要执行“生成/书写”操作的系统更易构建  

## Context engineering is critical  

## 上下文工程至关重要  

One of the hardest parts of building multi-agent (or even single-agent) applications is effectively communicating to the models the context of what they’re being asked to do. The Cognition blog post introduces the term “context engineering” to describe this challenge.

构建多智能体（甚至单智能体）应用最困难的环节之一，是如何高效地向大语言模型传达其任务所依赖的具体上下文。Cognition 的这篇博客首次提出“上下文工程（context engineering）”这一术语，用以概括这一核心挑战。

> In 2025, the models out there are extremely intelligent. But even the smartest human won’t be able to do their job effectively without the context of what they’re being asked to do. “Prompt engineering” was coined as a term for the effort needing to write your task in the ideal format for a LLM chatbot. “Context engineering” is the next level of this. It is about doing this automatically in a dynamic system. It takes more nuance and is effectively the #1 job of engineers building AI agents.

> 到 2025 年，现有大模型已极为强大。但即便最聪明的人类，若缺乏对其所承担任务的具体背景理解，也无法高效完成工作。“提示工程（prompt engineering）”一词，最初即指为使大语言模型聊天机器人达到最优表现，而对任务指令进行精心设计与格式化的过程；而“上下文工程（context engineering）”则是这一工作的进阶形态——它强调在动态系统中自动完成上下文的构建与传递。这项工作需要更精细的权衡与设计，事实上已成为构建 AI 智能体的工程师们首要的核心职责。

They show through a few toy examples that using multi-agent systems makes it **harder** to ensure that each sub-agent has the appropriate context.

文中通过若干简化示例指出：采用多智能体架构反而会**加大**确保每个子智能体获得恰当上下文的难度。

The Anthropic blog post doesn’t explicitly use the term context engineering, but at multiple points it addresses the same issue. It’s clear that the Anthropic team spent a significant amount of time on context engineering. Some highlights below:

Anthropic 的博客虽未明确使用“上下文工程”这一术语，却在多处直击同一核心问题。显而易见，Anthropic 团队在上下文工程方面投入了大量精力。以下摘录若干关键要点：

> **Long-horizon conversation management.** Production agents often engage in conversations spanning hundreds of turns, requiring careful context management strategies. As conversations extend, standard context windows become insufficient, necessitating intelligent compression and memory mechanisms. We implemented patterns where agents summarize completed work phases and store essential information in external memory before proceeding to new tasks. When context limits approach, agents can spawn fresh subagents with clean contexts while maintaining continuity through careful handoffs. Further, they can retrieve stored context like the research plan from their memory rather than losing previous work when reaching the context limit. This distributed approach prevents context overflow while preserving conversation coherence across extended interactions.

> **长周期对话管理（Long-horizon conversation management）**：生产环境中的智能体常需参与跨越数百轮次的长程对话，这对上下文管理策略提出了极高要求。随着对话不断延伸，标准的上下文窗口很快便会捉襟见肘，因而必须引入智能压缩与记忆机制。我们设计了一套模式：智能体在完成某一工作阶段后，即对其进行摘要提炼，并将关键信息存入外部记忆，再启动新任务；当接近上下文容量上限时，智能体可派生出具备“干净上下文”的全新子智能体，同时通过审慎的任务交接维持整体连贯性；此外，它们还能从自身记忆中检索已存储的上下文（例如研究计划），从而避免因达到上下文限制而丢失前期成果。这种分布式方法既防止了上下文溢出，又保障了长程交互中对话逻辑的一致性与连贯性。

> In our system, the lead agent decomposes queries into subtasks and describes them to subagents. Each subagent needs an objective, an output format, guidance on the tools and sources to use, and clear task boundaries. Without detailed task descriptions, agents duplicate work, leave gaps, or fail to find necessary information.

> 在我们的系统中，主智能体（lead agent）负责将用户查询分解为若干子任务，并向各子智能体清晰传达任务细节。每个子智能体均需明确知晓：任务目标、输出格式、可用工具与数据源、以及清晰的任务边界。若任务描述不够详尽，智能体便极易出现重复劳动、遗漏关键环节，或无法获取必要信息等问题。

Context engineering is critical to making agentic systems work reliably. This insight has guided our development of [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com), our agent and multi-agent framework. When using a framework, you need to have full control what gets passed into the LLM, and full control over what steps are run and in what order (in order to generate the context that gets passed into the LLM). We prioritize this with LangGraph, which is a low-level orchestration framework with no hidden prompts, no enforced “cognitive architectures”. This gives you full control to do the appropriate context engineering that you require.

上下文工程（Context engineering）对于确保智能体系统（agentic systems）稳定可靠地运行至关重要。这一洞见指导了我们开发 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)——我们专为构建智能体及多智能体系统设计的框架。使用框架时，你必须对**传入大语言模型（LLM）的内容拥有完全控制权**，同时也必须对**执行哪些步骤、以何种顺序执行**拥有完全控制权（从而生成传入 LLM 的上下文）。LangGraph 正是围绕这一核心需求构建的：它是一个低层级编排框架，不隐藏任何提示词（no hidden prompts），也不强制采用某种预设的“认知架构”（no enforced “cognitive architectures”）。这赋予你充分的自由度，按需实施精准、恰当的上下文工程。

## Multi-agent systems that primarily “read” are easier than those that “write”

## 主要执行“阅读”任务的多智能体系统，比主要执行“写作”任务的系统更易实现

Multi-agent systems designed primarily for "reading" tasks tend to be more manageable than those focused on "writing" tasks. This distinction becomes clear when comparing the two blog posts: Cognition's coding-focused system and Anthropic's research-oriented approach.

主要面向“阅读”类任务设计的多智能体系统，通常比聚焦于“写作”类任务的系统更易于构建与管理。这一差异在对比两篇博客文章时尤为明显：Cognition 公司以编程为核心的系统，与 Anthropic 公司以研究为导向的方法。

Both coding and research involve reading and writing, but they emphasize different aspects. The key insight is that read actions are inherently more parallelizable than write actions. When you attempt to parallelize writing, you face the dual challenge of effectively communicating context between agents and then merging their outputs coherently. As the Cognition blog post notes: "Actions carry implicit decisions, and conflicting decisions carry bad results." While this applies to both reading and writing, conflicting write actions typically produce far worse outcomes than conflicting read actions. When multiple agents write code or content simultaneously, their conflicting decisions can create incompatible outputs that are difficult to reconcile.

编程和研究都包含“读”与“写”，但侧重点不同。关键洞见在于：“读”操作天然更适合并行化，而“写”操作则不然。当你尝试并行化“写”操作时，会面临双重挑战：一是如何在多个智能体之间高效传递上下文，二是如何将它们各自产出的结果一致、连贯地融合起来。正如 Cognition 博客所指出：“每个操作都隐含着决策，而相互冲突的决策必然导致不良结果。”尽管该原则对“读”与“写”均适用，但“写”操作间的冲突通常比“读”操作间的冲突带来严重得多的后果。当多个智能体同时编写代码或内容时，其彼此冲突的决策极易产生互不兼容的输出，极难协调统一。

Anthropic's Claude Research illustrates this principle well. While the system involves both reading and writing, the multi-agent architecture primarily handles the research (reading) component. The actual writing—synthesizing findings into a coherent report—is deliberately handled by a single main agent in one unified call. This design choice recognizes that collaborative writing introduces unnecessary complexity.

Anthropic 的 Claude Research 系统很好地印证了这一原理。尽管该系统同时涉及“读”与“写”，但其多智能体架构主要承担的是研究（即“读”）环节；而真正的“写”——即将研究成果整合成一份逻辑连贯的报告——则被刻意交由一个主智能体，在单次统一调用中完成。这一设计选择正体现了对“协作式写作会引入不必要复杂性”的清醒认知。

However, even read-heavy multi-agent systems aren't trivial to implement. They still require sophisticated context engineering. Anthropic discovered this firsthand:

> We started by allowing the lead agent to give simple, short instructions like 'research the semiconductor shortage,' but found these instructions often were vague enough that subagents misinterpreted the task or performed the exact same searches as other agents. For instance, one subagent explored the 2021 automotive chip crisis while 2 others duplicated work investigating current 2025 supply chains, without an effective division of labor.

然而，即便是以“读”为主的多智能体系统，其落地实现也绝非易事，仍需高度成熟的上下文工程能力。Anthropic 在实践中对此深有体会：

> 我们最初允许主智能体仅发出简短指令，例如“调研半导体短缺问题”，却发现这类指令往往过于模糊，导致子智能体误解任务目标，或与其他智能体重复执行完全相同的搜索。例如，一个子智能体研究了2021年汽车芯片危机，而另外两个子智能体却重复工作，共同调查当前（2025年）的供应链状况，整个过程中缺乏有效的任务分工。

## Production reliability and engineering challenges

## 生产环境下的可靠性与工程挑战

Whether using multi-agent systems or just a complex single agent one, there are several reliability and engineering challenges that emerge. Anthropic's blog post does a great job of highlighting these. These challenges are not unique to Anthropic's use case, but are actually pretty generic. A lot of the tooling we've been building has been aimed at generically solving problems like these.

无论采用多智能体系统，还是仅使用一个结构复杂的单智能体系统，都会涌现出若干共性的可靠性与工程挑战。Anthropic 的博客文章对此做了极为出色的梳理与揭示。这些挑战并非 Anthropic 特有，而是具有高度普适性。我们团队持续构建的大量工具，其核心目标正是通用化地解决此类问题。

**Durable execution and error handling**  

**持久化执行与错误处理**

> **Agents are stateful and errors compound.**  
> **代理具有状态性，且错误会累积。**  
> Agents can run for long periods of time, maintaining state across many tool calls.  
> 代理可长时间运行，并在多次工具调用之间持续维护状态。  
> This means we need to durably execute code and handle errors along the way.  
> 这意味着我们必须以持久化方式执行代码，并在执行过程中妥善处理各类错误。  
> Without effective mitigations, minor system failures can be catastrophic for agents.  
> 若缺乏有效的缓解机制，微小的系统故障就可能对代理造成灾难性影响。  
> When errors occur, we can't just restart from the beginning: restarts are expensive and frustrating for users.  
> 错误发生时，我们无法简单地从头重启——重启成本高昂，且令用户感到沮丧。  
> Instead, we built systems that can resume from where the agent was when the errors occurred.  
> 因此，我们构建了可在错误发生时精准恢复至代理中断点的系统。

This durable execution is a key part of [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com), our agent orchestration framework.  
这种持久化执行能力是我们的代理编排框架 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 的核心组成部分。  
We believe all long running agents will need this, and accordingly it should be built into the agent orchestration framework.  
我们相信，所有长期运行的代理都将依赖这一能力，因此它理应被原生集成到代理编排框架中。

**Agent Debugging and Observability**  
**代理调试与可观测性**

> Agents make dynamic decisions and are non-deterministic between runs, even with identical prompts. This makes debugging harder. For instance, users would report agents “not finding obvious information,” but we couldn't see why. Were the agents using bad search queries? Choosing poor sources? Hitting tool failures? Adding full production tracing let us diagnose why agents failed and fix issues systematically.  
> **代理会做出动态决策，即使输入提示完全相同，其运行结果也具有非确定性——这大大增加了调试难度。** 例如，用户反馈代理“未能找到显而易见的信息”，但我们却无从得知原因：是代理构造了低效的搜索查询？选用了不可靠的信息源？还是遭遇了工具调用失败？引入完整的生产级追踪能力后，我们得以精准定位代理失败的根本原因，并系统性地修复问题。

We have long recognized that observability for LLM systems is different than traditional software observability. A key reason why is it needs to be optimized for debugging these types of challenges.  
我们早已认识到，大语言模型（LLM）系统的可观测性与传统软件的可观测性存在本质差异；其关键区别在于：前者必须专为应对上述这类调试挑战而深度优化。  
If you’re not sure what exactly this means — check out [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com), our platform for (among other things) agent debugging and observability.  
若您尚不清楚这具体意味着什么，请访问 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) —— 我们专为（包括但不限于）代理调试与可观测性打造的平台。  
We’ve been building LangSmith for the past two years to handle these types of challenges. Try it out and see why this is so critical!  
过去两年间，我们持续构建 LangSmith，正是为了应对这类挑战。欢迎立即试用，亲身体验其不可或缺的价值！

**Evaluation of agents**  
**代理评估**

A whole section in the Anthropic post is dedicated to “effective evaluation of agents”. A few key takeaways that we like:  
Anthropic 博客文章中专门用一整节篇幅探讨“如何有效评估代理”。其中几点核心洞见深得我们认同：

- Start small with evals, even ~20 datapoints is enough  
- 评估宜从小规模起步，仅需约 20 条数据点即足以启动  
- LLM-as-a-judge can automate scoring of experiments  
- “LLM 作为裁判”（LLM-as-a-judge）可自动化完成实验评分  
- Human testing remains essential  
- 人工测试仍不可或缺  

This resonates whole-heartedly with our approach to evaluation. We’ve been building evals into LangSmith for a while, and have landed on several features to help with those aspects:  
这与我们一贯的评估理念高度契合。我们已将评估能力深度集成至 LangSmith 多时，并围绕上述要点推出了多项实用功能：

- [Datasets](https://docs.smith.langchain.com/evaluation/concepts?ref=blog.langchain.com#datasets), to curate datapoints easily  
- [数据集（Datasets）](https://docs.smith.langchain.com/evaluation/concepts?ref=blog.langchain.com#datasets)，便于高效整理与管理评估数据点  
- Running [LLM-as-a-judge](https://docs.smith.langchain.com/evaluation/concepts?ref=blog.langchain.com#llm-as-judge) server side (more features coming here soon!)  
- 在服务端运行 [LLM-as-a-judge](https://docs.smith.langchain.com/evaluation/concepts?ref=blog.langchain.com#llm-as-judge)（更多功能即将上线！）  
- [Annotation queues](https://docs.smith.langchain.com/evaluation/concepts?ref=blog.langchain.com#annotation-queues) to coordinate and facilitate human evaluations  
- [标注队列（Annotation queues）](https://docs.smith.langchain.com/evaluation/concepts?ref=blog.langchain.com#annotation-queues)，用于统筹协调并高效推进人工评估

## Conclusion

## 结论

Anthropic’s blog post also contains some wisdom for where multi-agent systems may or may not work best:

Anthropic 的博客文章还提供了一些洞见，指出了多智能体系统在哪些场景下适用、哪些场景下不适用：

> Our internal evaluations show that multi-agent research systems excel especially for breadth-first queries that involve pursuing multiple independent directions simultaneously.

> 我们的内部评估表明，多智能体研究系统尤其擅长处理“广度优先”类查询——即需要同时探索多个相互独立方向的任务。

> Multi-agent systems work mainly because they help spend enough tokens to solve the problem…. Multi-agent architectures effectively scale token usage for tasks that exceed the limits of single agents.

> 多智能体系统之所以有效，主要在于它们能调用足够多的 token 来解决问题……对于超出单个智能体能力边界的任务，多智能体架构能有效扩展 token 的使用规模。

> For economic viability, multi-agent systems require tasks where the value of the task is high enough to pay for the increased performance.

> 从经济可行性角度看，多智能体系统仅适用于那些任务价值足够高、足以覆盖其性能提升所带来额外成本的场景。

> Further, some domains that require all agents to share the same context or involve many dependencies between agents are not a good fit for multi-agent systems today. For instance, most coding tasks involve fewer truly parallelizable tasks than research, and LLM agents are not yet great at coordinating and delegating to other agents in real time. We’ve found that multi-agent systems excel at valuable tasks that involve heavy parallelization, information that exceeds single context windows, and interfacing with numerous complex tools.

> 此外，当前多智能体系统并不适合某些特定领域——例如要求所有智能体共享同一上下文，或智能体之间存在大量依赖关系的场景。以编程任务为例：相比研究类任务，真正可并行化的子任务更少；而当前的大语言模型（LLM）智能体在实时协调与委托其他智能体方面仍显不足。我们发现，多智能体系统最擅长的是那些高价值、高度并行化、所需信息量超出单次上下文窗口容量、且需频繁对接大量复杂工具的任务。

As is quickly becoming apparent when building agents, there is not a “one-size-fits-all” solution. Instead, you will want to explore several options and choose the best one according to the problem you are solving.

正如构建智能体时日益清晰显现的那样，并不存在一种“放之四海而皆准”的通用方案。相反，你需要尝试多种选项，并根据你所解决的具体问题，选择最合适的方案。

Any agent framework you choose should allow you to slide anywhere on this spectrum - something we’ve uniquely emphasized with LangGraph.

你所选用的任何智能体框架，都应支持你在这一光谱上灵活调节——这正是 LangGraph 所独树一帜强调的核心能力。

Figuring out how to get multi-agent (or complex single agent) systems to function also requires new tooling. Durable execution, debugging, observability, and evaluation are all new tools that will make your life as an application developer easier. Luckily, these are all generic tooling. This means that you can use tools like LangGraph and LangSmith to get these off-the-shelf, allowing you to focus more on the business logic of your application than generic infrastructure.

要让多智能体（或结构复杂的单智能体）系统真正运转起来，还需配套全新的开发工具。持久化执行（durable execution）、调试（debugging）、可观测性（observability）和评估（evaluation）等，都是能让应用开发者工作更轻松的新一代通用工具。幸运的是，这些工具均具有通用性——这意味着你可以直接开箱即用地采用 LangGraph 和 LangSmith 等工具，从而将更多精力聚焦于应用自身的业务逻辑，而非重复建设通用型基础设施。

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[哈里森的热点评论](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/how-and-when-to-build-multi-agent-systems/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![论智能体框架与智能体可观测性](images/how-and-when-to-build-multi-agent-systems/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**论智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[哈里森的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/how-and-when-to-build-multi-agent-systems/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪记录到深度洞察：大规模理解智能体行为](images/how-and-when-to-build-multi-agent-systems/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪记录到深度洞察：大规模理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[哈里森的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/how-and-when-to-build-multi-agent-systems/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码即文档；在人工智能中，追踪记录即文档。](images/how-and-when-to-build-multi-agent-systems/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码即文档；在人工智能中，追踪记录即文档。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/how-and-when-to-build-multi-agent-systems/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![Agent 框架、运行时与编排工具——天哪！](images/how-and-when-to-build-multi-agent-systems/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent 框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Reflections on Three Years of Building LangChain](images/how-and-when-to-build-multi-agent-systems/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/how-and-when-to-build-multi-agent-systems/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/how-and-when-to-build-multi-agent-systems/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/how-and-when-to-build-multi-agent-systems/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读