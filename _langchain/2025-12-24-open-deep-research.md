---
title: "Open Deep Research"
source: "LangChain Blog"
url: "https://blog.langchain.com/open-deep-research/"
date: "2025-12-24"
scraped_at: "2026-03-03T07:15:13.082627749+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

## TL;DR

## 简而言之

深度研究（Deep research）已迅速崛起，成为最受欢迎的智能体（agent）应用之一。[OpenAI](https://openai.com/index/introducing-deep-research/?ref=blog.langchain.com)、[Anthropic](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)、[Perplexity](https://www.perplexity.ai/hub/blog/introducing-perplexity-deep-research?ref=blog.langchain.com) 和 [Google](https://gemini.google/overview/deep-research/?hl=en&ref=blog.langchain.com) 均已推出深度研究产品，这些产品利用[多种上下文来源](https://www.anthropic.com/news/research?ref=blog.langchain.com)生成全面详尽的研究报告。此外，还存在大量[开源](https://huggingface.co/blog/open-deep-research?ref=blog.langchain.com)实现方案，例如 [Google 的 Gemini 全栈 LangGraph 快速入门项目](https://github.com/google-gemini/gemini-fullstack-langgraph-quickstart?ref=blog.langchain.com)。

我们构建了一个[开源深度研究员（Open Deep Researcher）](https://github.com/langchain-ai/open_deep_research?ref=blog.langchain.com)，该系统设计简洁、高度可配置，支持用户灵活接入自定义大语言模型、搜索工具及 MCP（Model Control Protocol）服务器。

- 开源深度研究系统基于 LangGraph 构建。代码详见 [GitHub 仓库](https://github.com/langchain-ai/open_deep_research?ref=blog.langchain.com)！  
- 欢迎前往 [Open Agent Platform](https://oap.langchain.com/?ref=blog.langchain.com) 在线体验！

![](images/open-deep-research/img_001.png)

## Challenge

## 挑战

研究是一项开放性任务；针对用户请求，最优的解决策略往往无法预先确定。不同请求可能需要截然不同的研究策略，以及差异化的搜索深度。

> _“对比这两款产品”_

此类对比任务通常需分别对两款产品开展独立检索，再通过综合分析步骤完成横向比对。

> _“为该职位筛选出前 20 名候选人”_

Listing and ranking requests typically require open-ended search, followed by a synthesis and ranking.

列表与排序类请求通常需要开放式搜索，随后进行综合分析与排序。

> _“Is X really true?”_

> _“X 真的成立吗？”_

Validation questions can require iterative deep research into a specific domain, where the quality of sources matters much more than the breadth of the search.

验证类问题往往需要针对特定领域开展迭代式深度研究，此时信息来源的质量远比搜索范围的广度更为重要。

With these points in mind, a key design principle for open deep research is **flexibility** to explore different research strategies depending on the request.

基于上述要点，开放式深度研究的一项核心设计原则是**灵活性**——即能够根据具体请求灵活选择并调整不同的研究策略。

## Architectural Overview

## 架构概览

[Agents](https://langchain-ai.github.io/langgraph/tutorials/workflows/?ref=blog.langchain.com#agent) are well suited to research because they can flexibly apply different strategies, using intermediate results to guide their exploration. Open deep research uses an agent to conduct research as part of a three step process:

[智能体（Agents）](https://langchain-ai.github.io/langgraph/tutorials/workflows/?ref=blog.langchain.com#agent) 非常适合用于研究任务，因为它们能灵活采用不同策略，并利用中间结果来引导后续探索。开放式深度研究将智能体作为核心组件，嵌入一个三阶段流程中以执行研究任务：

- **Scope** – _clarify research scope_  
- **界定范围** —— 明确研究边界  

- **Research** – _perform research_  
- **研究** —— 开展实际研究  

- **Write** – _produce the final report_  
- **撰写** —— 生成最终报告  

![](images/open-deep-research/img_002.png)

### Phase 1: Scope

### 第一阶段：界定范围

The purpose of scoping is to gather all user-context needed for research. This is a two-step pipeline that performs **User Clarification** and **Brief Generation**.

界定范围的目的是收集研究所需的所有用户上下文信息。该阶段由两个子步骤构成的流水线完成：**用户澄清（User Clarification）** 和 **简报生成（Brief Generation）**。

![](images/open-deep-research/img_003.png)

**User Clarification**

**用户澄清**

[OpenAI has made the point](https://youtu.be/bNEvJYzoa8A?feature=shared&t=1265&ref=blog.langchain.com) that users rarely provide sufficient context in a research request. We use a chat model to ask for additional context if necessary.

[OpenAI 指出](https://youtu.be/bNEvJYzoa8A?feature=shared&t=1265&ref=blog.langchain.com)，用户在提出研究请求时，极少提供足够充分的背景信息。如有必要，我们将调用聊天模型向用户进一步询问补充信息。

![](images/open-deep-research/img_004.png)

**Brief Generation**

**简报生成**

The chat interaction can include clarification questions, follow-ups, or user-provided examples (e.g., a prior deep research report). Because the interaction can be quite verbose and token-heavy, we translate it into a comprehensive, yet focused research brief. The research brief serves as our north star for success, and we refer back to it throughout the research and writing phases.

聊天交互过程可能包含澄清性问题、后续追问，或用户提供的示例（例如一份过往的深度研究报告）。由于该交互过程往往冗长且消耗大量 token，我们将其提炼为一份全面而聚焦的研究简报。这份研究简报即是我们衡量成功与否的“北极星”，并在整个研究与撰写阶段持续回溯参考。

![](images/open-deep-research/img_005.png)

💡

💡

_We translate the researcher-user chat interaction into a focused brief for the research supervisor to measure against._

_我们将研究员与用户的聊天交互内容转化为一份聚焦明确的简报，供研究主管据此评估工作成效。_

### Phase 2: Research

### 第二阶段：研究

The goal of research is to gather the context requested by the research brief. We conduct research using a [supervisor agent](https://langchain-ai.github.io/langgraph/tutorials/multi_agent/agent_supervisor/?ref=blog.langchain.com).

研究的目标是收集研究简报（research brief）所要求的上下文信息。我们使用一个[主管智能体（supervisor agent）](https://langchain-ai.github.io/langgraph/tutorials/multi_agent/agent_supervisor/?ref=blog.langchain.com)来开展研究工作。

![](images/open-deep-research/img_006.png)

![](images/open-deep-research/img_006.png)

**Research Supervisor**

**研究主管智能体**

The supervisor has a simple job: delegate research tasks to an appropriate number of sub-agents. The supervisor determines if the research brief can be broken-down into independent sub-topics and delegates to sub-agents with isolated context windows. This is useful because it allows the system to parallelize research work, finding more information faster.

主管智能体的任务十分明确：将研究任务合理分配给若干子智能体（sub-agents）。主管智能体会判断研究简报是否可被拆解为彼此独立的子主题，并将各子主题分别委派给拥有隔离式上下文窗口（isolated context windows）的子智能体。这一设计的优势在于，它使系统能够并行开展研究工作，从而更快速地获取更丰富的信息。

**Research Sub-Agents**

**研究子智能体**

Each research sub-agent is presented with a sub-topic from the supervisor. The sub-agent is prompted to focus only on a specific topic and doesn’t worry about the full scope of research brief – that's a job for the supervisor. Each sub-agent conducts research as a tool-calling loop, making use of search tools and / or MCP tools configured by the user.

每个研究子智能体均从主管智能体处接收一个子主题。子智能体仅需专注于该特定主题，无需考虑整个研究简报的全部范围——后者属于主管智能体的职责。每个子智能体通过“工具调用循环”（tool-calling loop）开展研究，灵活调用用户配置的搜索工具和/或 MCP 工具。

When each sub-agent finishes, it makes a final LLM call to write a detailed answer to the subquestion posed, taking into account all of its research and citing helpful sources. This is important because there can be a lot of raw (e.g. scraped web pages) and irrelevant (e.g. failed tool calls, or irrelevant web sites) information collected from tool call feedback.

当每个子智能体完成研究后，它会发起一次最终的大语言模型（LLM）调用，综合其全部研究成果，针对所分配的子问题撰写一份详尽的回答，并引用有帮助的信息来源。这一步至关重要，因为工具调用反馈中往往包含大量原始数据（例如爬取的网页内容）以及无关信息（例如失败的工具调用结果或不相关的网站内容）。

💡

💡

_We make an additional LLM call to clean sub-agent research findings so that the supervisor is provided with clean, processed information._

_我们额外发起一次 LLM 调用，对子智能体的研究成果进行清洗与提炼，从而向主管智能体提供干净、已处理的信息。_

If we return this raw information to the supervisor, the token usage can bloat significantly and the supervisor is forced parse through more tokens in order to isolate the most useful information. So, our sub-agent cleans up its findings and returns them to the supervisor.

倘若将上述原始信息直接返回给主管智能体，不仅会导致 token 消耗大幅增加，还会迫使主管智能体耗费更多 token 去解析、筛选出其中最有价值的信息。因此，我们的子智能体会先行清洗并整理自身研究成果，再将其提交给主管智能体。

![](images/open-deep-research/img_007.png)

![](images/open-deep-research/img_007.png)

**Research Supervisor Iteration**

**研究主管迭代**

The supervisor reasons about whether the findings from the sub-agents sufficiently address the scope of work in the brief. If the supervisor wants more depth, it can spawn further sub-agents to conduct more research. As the supervisor delegates research and reflects on results, it can flexibly identify what is missing and address these gaps with follow-up research.

主管会评估各子智能体（sub-agents）所获发现是否已充分覆盖研究简报（research brief）中规定的工作范围。若主管认为现有成果深度不足，可进一步生成新的子智能体以开展更深入的研究。在委派研究任务并审阅结果的过程中，主管能够灵活识别当前成果中的缺失环节，并通过后续研究予以弥补。

### Phase 3: Report Writing

### 第三阶段：报告撰写

The goal of report writing is to fulfill the request in the research brief using the gathered context from sub-agents. When the supervisor deems that the gathered findings are sufficient to address the request in the research brief, then we move ahead to write the report.

报告撰写的目标是依据子智能体所收集的上下文信息，全面回应研究简报中提出的具体需求。当主管判断所汇集的发现已足以回应简报要求时，即进入报告撰写阶段。

To write the report, we provide an LLM with the research brief and all of the research findings returned by sub-agents. This final LLM call produces an output in one-shot, steered by the brief and answered with the research findings.

撰写报告时，我们将研究简报及所有子智能体返回的研究发现一并输入大语言模型（LLM）。此次最终调用以“单次生成”（one-shot）方式输出报告，其内容严格遵循简报要求，并以已有研究成果为依据作答。

![](images/open-deep-research/img_008.png)

![](images/open-deep-research/img_008.png)

## Lessons

## 经验总结

### **Only use multi-agent for easily parallelized tasks**

### **仅对易于并行化的任务采用多智能体架构**

Multi vs. single-agent is an important design consideration. Cognition has [argued against multi-agent](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com) because sub-agents working in parallel can be difficult to coordinate. If the task (e.g., building an application) requires the multi-agent outputs to function together, then coordination is a risk.

多智能体与单智能体架构的选择是一项关键的设计考量。Cognition 公司曾[明确反对构建多智能体系统](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com)，理由在于并行运行的子智能体往往难以协调。倘若某项任务（例如开发一个应用程序）要求多个智能体的输出必须协同工作、彼此配合，则协调失败将成为显著风险。

We also learned this lesson. Earlier versions of our research agent wrote sections of the final report in parallel with sub-agents. It was fast, but we faced a problem that Cognition raised: the reports were disjoint because the section-writing agents were not well coordinated. We resolved this by using multi-agent for only the research task itself, performing writing after all research was done.

我们也吸取了这一教训。我们研究型智能体的早期版本曾让多个子智能体并行撰写最终报告的不同章节。这种方式虽快，但正如 Cognition 所指出的问题：报告内容彼此割裂，因为负责撰写各章节的子智能体之间缺乏良好协同。为此，我们调整策略——仅在研究任务本身中采用多智能体架构，待全部研究工作完成后，再统一撰写报告。

💡

💡

_Multi-agents are hard to coordinate, and can perform poorly if writing sections of the report in parallel. We restrict multi-agent to research, and write the report in one-shot._

_多智能体难以协调；若让其并行撰写报告章节，性能往往不佳。因此，我们将多智能体严格限定于研究环节，报告则采用“一次性”方式统一撰写。_

### Multi-agent is useful for isolating context across sub-research topics

### 多智能体有助于在不同子研究主题间隔离上下文

Our experiments showed that single agent response quality suffers if the request has multiple sub-topics (e.g., compare A to B to C). The intuition here is straightforward: a single context window needs to store and reason about tool feedback across all of the sub-topics. This tool feedback is often token heavy. [Numerous failure modes](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com), such as [context clash](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com), become prevalent as the context window accumulates tool calls across many different sub-topics.

我们的实验表明：当用户请求涉及多个子主题（例如，“对比 A、B 与 C”）时，单智能体的响应质量会明显下降。其直觉原因很直接：单一上下文窗口需同时存储并推理所有子主题相关的工具反馈；而这类工具反馈往往具有极高的 token 开销。随着上下文窗口中不断累积来自多个不同子主题的工具调用，[多种失效模式](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com)（例如 [上下文冲突（context clash）](https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html?ref=blog.langchain.com)）便愈发普遍。

#### Let’s look at a concrete example

#### 我们来看一个具体示例

_Compare the approaches of OpenAI vs Anthropic vs Google DeepMind to AI safety. I want to understand their different philosophical frameworks, research priorities, and how they're thinking about the alignment problem._

_请对比 OpenAI、Anthropic 与 Google DeepMind 在 AI 安全领域的研究路径。我希望了解它们各自不同的哲学框架、研究重点，以及对对齐（alignment）问题的思考方式。_

Our **single agent** implementation used its search tool to send separate queries about each frontier lab _at the same time._

我们的 **单智能体** 实现方案，利用其搜索工具，**同时**向每个前沿实验室发起独立查询：

- 'OpenAI philosophical framework for AI safety and alignment'  
- “OpenAI 在 AI 安全与对齐方面的哲学框架”

- 'Anthropic philosophical framework for AI safety and alignment'  
- “Anthropic 在 AI 安全与对齐方面的哲学框架”

- 'Google DeepMind philosophical framework for AI safety and alignment’  
- “Google DeepMind 在 AI 安全与对齐方面的哲学框架”

The search tool returned results about all three labs in a _single lengthy string_. Our single agent reasoned about the results for all three frontier labs and called the search tool again, asking independent queries of each.

搜索工具将三家实验室的相关结果，以**一个冗长的字符串**形式一并返回。该单智能体需在此单一上下文中对三家前沿实验室的结果进行综合推理，并再次调用搜索工具，分别向每家机构发起新的独立查询。

- 'DeepMind statements on social choice and political philosophy'  
- DeepMind 关于社会选择与政治哲学的声明

- 'Anthropic statements on technical alignment challenges'  
- Anthropic 关于技术对齐挑战的声明

- 'OpenAI technical reports on recursive reward modeling'  
- OpenAI 关于递归奖励建模的技术报告

In each tool-call iteration, the single agent juggled context from three independent threads. This was wasteful from a token and latency perspective. We don’t need tokens about OpenAI’s recursive reward modeling approach to help us generate our next query about DeepMind’s alignment philosophies. Another important observation was that a single agent handling multiple topics would naturally research each topic _less deeply_(# of search queries) before choosing to finish.  

在每次工具调用迭代中，单个智能体需同时处理来自三个独立线程的上下文。从 token 消耗和延迟角度看，这种做法效率低下。我们并不需要关于 OpenAI 递归奖励建模方法的 token 来辅助生成下一个针对 DeepMind 对齐哲学的查询。另一个重要观察是：当单个智能体负责多个主题时，它往往会在每个主题上投入**更少的深度研究**（即搜索查询次数更少），便选择终止。

![](images/open-deep-research/img_009.png)A multi-agent approach allows multiple sub-agents to run in parallel, and each is dedicated to an independent, focused task. Applying a multi-agent approach to research captures the benefits [reported by Anthropic](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) and is highlighted in our own evals: sub-topic context can be isolated in each sub-agent.  

![](images/open-deep-research/img_009.png)采用多智能体架构，可让多个子智能体并行运行，且每个子智能体均专注于一项独立而明确的任务。将多智能体方法应用于研究工作，不仅能复现 [Anthropic 所报告的优势](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)，也在我们自身的评估中得到验证：各子主题的上下文可在每个子智能体中实现隔离。

💡  

💡  

_Context isolation of sub-topics during research can avoid various long context failure modes._  

研究过程中对子主题进行上下文隔离，可规避多种长上下文失效模式。

### **Multi-agent supervisor enables the system to tune to required research depth**  

### **多智能体监督器使系统能够动态适配所需的研究深度**

Users do not want simple requests to take 10+ minutes. But, there are some requests that require research with higher token utilization and latency, [as Anthropic has nicely shown](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com).  

用户不希望简单请求耗时超过 10 分钟；但另一方面，确实存在一些请求需要更高 token 消耗与更长延迟的研究过程——[Anthropic 已对此做了清晰阐释](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com)。

The supervisor can handle both cases by selectively spawning sub-agents to tune the level of research depth needed for a request. The supervisor is prompted with heuristics to reason about when research should be parallelized, and when a single thread of research is sufficient. Our deep research agent has the flexibility to choose whether to parallelize research or not.  

监督器可通过有选择性地启动子智能体，来精准调节某项请求所需的研究深度，从而兼顾上述两类场景。监督器被赋予启发式提示（heuristics），以判断何时应并行开展研究、何时单一线程已足够。我们的深度研究智能体具备灵活决策能力，可自主决定是否启用并行研究。

💡  

💡  

_A multi-agent supervisor allows for flexibility of search strategy._  

多智能体监督器赋予系统搜索策略的灵活性。

### Context Engineering is important to mitigate token bloat and steer behavior

### 上下文工程对于缓解 Token 膨胀和引导智能体行为至关重要

Research is a token-heavy task. Anthropic reported that their multi-agent system [used 15x more tokens](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) than a typical chat application! We used [context engineering](https://blog.langchain.com/context-engineering-for-agents/) to mitigate this.

研究是一项高 Token 消耗的任务。Anthropic 报告称，其多智能体系统所消耗的 Token 数量是典型聊天应用的 **15 倍**！我们采用 [上下文工程（Context Engineering）](https://blog.langchain.com/context-engineering-for-agents/) 来缓解这一问题。

We compress the chat history into a research brief, which prevents token-bloat from prior messages. Sub-agents prune their research findings to remove irrelevant tokens and information before returning to the supervisor.

我们将聊天历史压缩为一份研究简报（research brief），从而避免先前消息引发的 Token 膨胀。各子智能体在向主管智能体（supervisor）返回结果前，会主动裁剪其研究成果，剔除无关的 Token 和信息。

Without sufficient context engineering, our agent was prone to running into context window limits from long, raw tool-call results. Practically, it also helps save $ on token spend and helps avoid TPM model rate limits.

若缺乏充分的上下文工程，我们的智能体极易因冗长、未经处理的工具调用（tool-call）原始结果而超出上下文窗口限制。实际上，该方法还能显著节省 Token 开销（即降低费用），并有助于规避模型每分钟请求数（TPM）的速率限制。

💡

💡

_Context engineering has many practical benefits. It saves tokens, helps avoid context window limits, and helps stay under model rate limits._

_上下文工程具有诸多实用价值：它可节省 Token、避免触发上下文窗口限制，并助力维持在模型速率限制之内。_

## Next Steps

## 下一步计划

Open deep research is a living project and we have several ideas we want to try. These are some of the open questions that we’re thinking about.

“开放式深度研究”（Open Deep Research）是一个持续演进的项目，我们已有多个待验证的想法。以下是我们正在思考的一些开放性问题：

- What is the best way to handle token-heavy tool responses, and what is the best way to filter out irrelevant context to reduce unnecessary token expenditure?

  - 应如何最优地处理高 Token 消耗的工具响应？又该如何高效过滤无关上下文，以减少不必要的 Token 开销？

- Are there any evaluations worth running in the hot path of the agent to ensure high quality responses?

  - 是否有必要在智能体的关键执行路径（hot path）中嵌入评估机制，以确保响应质量？

- Deep research reports are valuable and relatively expensive to create, can we store this work and leverage these in the future with long-term memory?

  - 深度研究报告价值高但生成成本相对较高，我们能否将此类成果持久化存储，并借助长期记忆（long-term memory）在未来复用？

## Using Open Deep Research

## 使用 Open Deep Research

### LangSmith Studio

### LangSmith Studio

You can clone our LangGraph [code](https://github.com/langchain-ai/open_deep_research?ref=blog.langchain.com) and run Open Deep Research locally with LangSmith Studio. You can use Studio to test out the prompts and architecture and tailor them more specifically to your use cases!

您可以克隆我们的 LangGraph [代码](https://github.com/langchain-ai/open_deep_research?ref=blog.langchain.com)，并在本地使用 LangSmith Studio 运行 Open Deep Research。您可借助 Studio 测试提示词（prompts）与系统架构，并针对您的具体应用场景进一步定制优化！

[Check out the repo!](https://github.com/langchain-ai/open_deep_research?ref=blog.langchain.com)

[查看该代码仓库！](https://github.com/langchain-ai/open_deep_research?ref=blog.langchain.com)

### LangChain Academy

### LangChain Academy

Check out our course on how to build your own deep research agent to handle research tasks.

欢迎了解我们关于如何构建专属深度研究智能体（deep research agent）以高效处理各类研究任务的课程。

[Head to LangChain Academy](https://academy.langchain.com/courses/deep-research-with-langgraph?ref=blog.langchain.com)

[前往 LangChain Academy](https://academy.langchain.com/courses/deep-research-with-langgraph?ref=blog.langchain.com)
&#123;% endraw %}
