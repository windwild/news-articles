---
title: "Plan-and-Execute Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/planning-agents/"
date: "2024-02-21"
scraped_at: "2026-03-03T08:11:29.424279704+00:00"
language: "en-zh"
translated: true
description: "Plan and execute agents promise faster, cheaper, and more performant task execution over previous agent designs. Learn how to build 3 types of planning agents in LangGraph in this post."
tags: ["By LangChain", "agents", "langgraph", "agent builder", "![Building Multi-Agent Apps", "deep agents"]
---
&#123;% raw %}

### **Links**

### **相关链接**

- Plan-and-execute（[Python](https://github.com/langchain-ai/langgraph/blob/main/examples/plan-and-execute/plan-and-execute.ipynb?ref=blog.langchain.com)，[JS](https://github.com/langchain-ai/langgraphjs/blob/main/examples/plan-and-execute/plan-and-execute.ipynb?ref=blog.langchain.com)）  
- LLMCompiler（[Python](https://github.com/langchain-ai/langgraph/blob/main/examples/llm-compiler/LLMCompiler.ipynb?ref=blog.langchain.com)）  
- ReWOO（[Python](https://github.com/langchain-ai/langgraph/blob/main/examples/rewoo/rewoo.ipynb?ref=blog.langchain.com)）  
- [YouTube 视频](https://youtu.be/uRya4zRrRx4?ref=blog.langchain.com)

We’re releasing three agent architectures in LangGraph showcasing the “plan-and-execute” style agent design. These agents promise a number of improvements over traditional Reasoning and Action (ReAct)-style agents.

我们正在 LangGraph 中发布三种基于“规划—执行”（plan-and-execute）范式的智能体架构。相比传统的“推理与行动”（Reasoning and Action，ReAct）风格智能体，这些新架构在多个方面具有显著优势。

⏰ First of all, they can execute multi-step workflow _**faster**,_ since the larger agent doesn’t need to be consulted after each action. Each sub-task can be performed without an additional LLM call (or with a call to a lighter-weight LLM).

⏰ 首先，它们能**更快速地执行多步工作流**，因为大型智能体无需在每次执行动作后都被重新调用。每个子任务均可独立完成——无需额外调用大语言模型（LLM），或仅需调用更轻量、更专用的 LLM。

💸 Second, they offer **cost savings** over ReAct agents. If LLM calls are used for sub-tasks, they typically can be made to smaller, domain-specific models. The larger model then is only called for (re-)planning steps and to generate the final response.

💸 其次，它们相比 ReAct 智能体可实现**成本节约**。若子任务需调用 LLM，通常可选用更小、更专精的领域模型；而大型模型仅用于（重新）规划阶段及最终响应生成。

🏆 Third, they can **perform better** overall (in terms of task completions rate and quality) by forcing the planner to explicitly “think through” all the steps required to accomplish the entire task. Generating the full reasoning steps is a tried-and-true prompting technique to improve outcomes. Subdividing the problem also permits more focused task execution.

🏆 第三，它们能**整体表现更优**（体现在任务完成率与结果质量两方面）：通过强制规划器显式“逐条梳理”完成整个任务所需的所有步骤，从而提升性能。完整生成推理步骤本身即是一种久经验证、行之有效的提示工程技巧；而将问题拆解，则有助于实现更聚焦、更精准的任务执行。

## Background

## 背景介绍

Over the past year, language model-powered agents and state machines have emerged as a promising design pattern for creating flexible and effective ai-powered products.

过去一年间，由大语言模型驱动的智能体（agents）与状态机（state machines）已逐渐成为构建灵活、高效 AI 产品的极具前景的设计范式。

At their core, agents use LLMs as general-purpose problem-solvers, connecting them with external resources to answer questions or accomplish tasks.

其核心思想在于：智能体将大语言模型作为通用问题求解器，并将其与外部资源相连接，以回答问题或完成具体任务。

LLM agents typically have the following main steps:

大语言模型智能体通常包含以下主要步骤：

1. 提出行动：大语言模型（LLM）生成文本，以直接响应用户，或将其传递给某个函数执行。  
1. 提出行动：大语言模型（LLM）生成文本，以直接响应用户，或将其传递给某个函数执行。

2. 执行行动：你的代码调用其他软件来完成任务，例如查询数据库或调用 API。  
2. 执行行动：你的代码调用其他软件来完成任务，例如查询数据库或调用 API。

3. 观察：根据工具调用的返回结果作出响应——要么调用另一个函数，要么直接向用户回复。  
3. 观察：根据工具调用的返回结果作出响应——要么调用另一个函数，要么直接向用户回复。

The [ReAct](https://arxiv.org/abs/2210.03629?ref=blog.langchain.com) agent is a great prototypical design for this, as it prompts the language model using a repeated thought, act, observation loop:  

[ReAct](https://arxiv.org/abs/2210.03629?ref=blog.langchain.com) 智能体是这一范式的典型设计范例，它通过反复循环的“思考（Thought）—行动（Act）—观察（Observation）”模式来引导语言模型：

```
Thought: I should call Search() to see the current score of the game.
Act: Search("What is the current score of game X?")
Observation: The current score is 24-21
... (repeat N times)
```

```
Thought: 我应该调用 Search() 来查看当前比赛得分。
Act: Search("游戏 X 的当前比分是多少？")
Observation: 当前比分为 24–21
...（重复 N 次）
```

A typical ReAct-style agent trajectory.  

典型的 ReAct 风格智能体执行轨迹。

This takes advantage of [Chain-of-thought](https://arxiv.org/abs/2201.11903?ref=blog.langchain.com) prompting to make a single action choice per step. While this can be effect for simple tasks, it has a couple main downsides:  

该方法利用了 [思维链（Chain-of-thought）](https://arxiv.org/abs/2201.11903?ref=blog.langchain.com) 提示技术，在每一步仅做出一个动作选择。尽管这对简单任务效果良好，但它存在两个主要缺点：

1. It requires an LLM call for each tool invocation.  
1. 每次调用工具都需要一次 LLM 调用。

2. The LLM only plans for 1 sub-problem at a time. This may lead to sub-optimal trajectories, since it isn't forced to "reason" about the whole task.  
2. LLM 每次仅针对一个子问题进行规划。这可能导致次优的执行路径，因为它并未被强制要求对整个任务进行全局性“推理”。

One way to overcome these two shortcomings is through an explicit planning step. Below are two such designs we have implemented in LangGraph.  

克服上述两项缺陷的一种方式是引入显式的规划步骤。以下是我们在 LangGraph 中已实现的两种此类设计：

## **Plan-And-Execute**  

## **规划与执行（Plan-And-Execute）**

🔗 [Python Link](https://github.com/langchain-ai/langgraph/blob/main/examples/plan-and-execute/plan-and-execute.ipynb?ref=blog.langchain.com)  

🔗 [Python 链接](https://github.com/langchain-ai/langgraph/blob/main/examples/plan-and-execute/plan-and-execute.ipynb?ref=blog.langchain.com)

🔗 [JS Link](https://github.com/langchain-ai/langgraphjs/blob/main/examples/plan-and-execute/plan-and-execute.ipynb?ref=blog.langchain.com)  

🔗 [JS 链接](https://github.com/langchain-ai/langgraphjs/blob/main/examples/plan-and-execute/plan-and-execute.ipynb?ref=blog.langchain.com)

![](images/plan-and-execute-agents/img_001.png)Plan-and-execute Agent

![](images/plan-and-execute-agents/img_001.png)计划与执行智能体（Plan-and-Execute Agent）

Based loosely on Wang, et. al.’s paper on [Plan-and-Solve Prompting](https://arxiv.org/abs/2305.04091?ref=blog.langchain.com), and Yohei Nakajima’s [BabyAGI](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com) project, this simple architecture is emblematic of the planning agent architecture. It consists of two basic components:

该架构大致借鉴自 Wang 等人关于 [Plan-and-Solve Prompting（计划与求解提示）](https://arxiv.org/abs/2305.04091?ref=blog.langchain.com) 的论文，以及 Yohei Nakajima 的 [BabyAGI](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com) 项目。这一简洁架构是规划型智能体（planning agent）架构的典型代表，包含两个基本组件：

1. A **planner**, which prompts an LLM to generate a multi-step plan to complete a large task.  
1. 一个**规划器（planner）**，通过提示大语言模型（LLM）生成多步骤计划，以完成一项复杂任务。

2. **Executor**(s), which accept the user query and a step in the plan and invoke 1 or more tools to complete that task.  
2. 一个或多个**执行器（executor）**，接收用户查询及计划中的某一步骤，并调用一个或多个工具来完成该步骤任务。

Once execution is completed, the agent is called again with a re-planning prompt, letting it decide whether to finish with a response or whether to generate a follow-up plan (if the first plan didn’t have the desired effect).  

执行完成后，智能体会再次被调用，并传入一个“重新规划”提示（re-planning prompt），使其自主判断：是直接输出最终响应，还是生成后续计划（例如当首轮计划未能达成预期效果时）。

This agent design lets us avoid having to call the large planner LLM for each tool invocation. It still is restricted by serial tool calling and uses an LLM for each task since it doesn't support variable assignment.  

该智能体设计使我们无需在每次调用工具时都调用大型规划用 LLM，从而提升效率。但其仍受限于串行式工具调用，且因不支持变量赋值，每个任务仍需单独调用一次 LLM。

## Reasoning WithOut Observations  

## 无观测推理（Reasoning Without Observations）

🔗 [Python Link](https://github.com/langchain-ai/langgraph/blob/main/examples/rewoo/rewoo.ipynb?ref=blog.langchain.com)  

🔗 [Python 示例链接](https://github.com/langchain-ai/langgraph/blob/main/examples/rewoo/rewoo.ipynb?ref=blog.langchain.com)

In [ReWOO](https://arxiv.org/abs/2305.18323?ref=blog.langchain.com), Xu, et. al, propose an agent that removes the need to always use an LLM for each task while still allowing tasks to depend on previous task results. They do so by permitting variable assignment in the planner's output. Below is a diagram of the agent design.

在 [ReWOO](https://arxiv.org/abs/2305.18323?ref=blog.langchain.com) 中，Xu 等人提出了一种新型智能体：它既消除了“每个任务都必须调用 LLM”的刚性依赖，又保留了任务间依赖关系（即后序任务可基于前序任务结果进行推理）。其实现关键在于——允许规划器（planner）在其输出中进行变量赋值。下图展示了该智能体的整体架构：

![](images/plan-and-execute-agents/img_002.png)ReWOO Agent  

![](images/plan-and-execute-agents/img_002.png)ReWOO 智能体  

Its **planner** generates a plan list consisting of interleaving "Plan" (reasoning) and "E#" lines. As an example, given the user query "What are the stats for the quarterbacks of the super bowl contenders this year", the planner may generate the following plan:  

其**规划器（planner）** 生成一份混合交错的计划列表，其中交替出现 “Plan”（表示推理步骤）和 “E#”（表示第 # 步工具执行）。例如，针对用户查询：“今年超级碗争冠球队四分卫的各项统计数据是什么？”，规划器可能生成如下计划：

```
Plan: I need to know the teams playing in the superbowl this year  
计划：我需要知道今年超级碗的参赛球队。

E1: Search[Who is competing in the superbowl?]  
E1：搜索[谁将参加今年的超级碗？]

Plan: I need to know the quarterbacks for each team  
计划：我需要知道每支球队的四分卫。

E2: LLM[Quarterback for the first team of #E1]  
E2：大语言模型[#E1 中第一支队伍的四分卫是谁？]

Plan: I need to know the quarterbacks for each team  
计划：我需要知道每支球队的四分卫。

E3: LLM[Quarter back for the second team of #E1]  
E3：大语言模型[#E1 中第二支队伍的四分卫是谁？]

Plan: I need to look up stats for the first quarterback  
计划：我需要查询第一位四分卫的统计数据。

E4: Search[Stats for #E2]  
E4：搜索[#E2 的统计数据]

Plan: I need to look up stats for the second quarterback  
计划：我需要查询第二位四分卫的统计数据。

E5: Search[Stats for #E3]  
E5：搜索[#E3 的统计数据]

```

请注意，规划器（Planner）可通过 `#E2` 等语法引用先前步骤的输出。这意味着它能按任务列表顺序执行，而无需每次重新规划。

**Worker（执行器）** 节点会遍历每个任务，将任务输出赋值给对应变量；并在调用后续任务时，自动将变量替换为其实际结果。

最后，**Solver（求解器）** 将所有这些输出整合为最终答案。

相较于朴素的“规划-执行”（plan-and-execute）智能体，这种智能体设计更为高效——因为每个任务仅接收其所需的上下文（即输入及所依赖的变量值）。

然而，该架构仍依赖**串行任务执行**，因此可能导致整体运行时间更长。

## **LLMCompiler**

🔗 [Python 示例链接](https://github.com/langchain-ai/langgraph/blob/main/examples/llm-compiler/LLMCompiler.ipynb?ref=blog.langchain.com)

![](images/plan-and-execute-agents/img_003.png)LLMCompiler 智能体

**LLMCompiler** 由 [Kim 等人](https://arxiv.org/abs/2312.04511?ref=blog.langchain.com) 提出，是一种智能体架构，旨在进一步提升任务执行的**速度**——不仅超越上文所述的“规划-执行”与 ReWOO 智能体，甚至优于 OpenAI 的并行工具调用（parallel tool calling）。

The LLMCompiler has the following main components:

LLMCompiler 具有以下主要组件：

1. **Planner**: streams a DAG of tasks. Each task contains a tool, arguments, and list of dependencies.  
1. **规划器（Planner）**：流式输出一个任务有向无环图（DAG）。每个任务包含一个工具、参数以及依赖任务列表。

2. **Task Fetching Unit** schedules and executes the tasks. This accepts a stream of tasks. This unit schedules tasks once their dependencies are met. Since many tools involve other calls to search engines or LLMs, the extra parallelism can grant a significant speed boost (the paper claims 3.6x).  
2. **任务获取单元（Task Fetching Unit）**：负责调度与执行任务。该单元接收一个任务流，并在任务的所有依赖条件满足后立即调度其执行。由于许多工具本身需调用搜索引擎或大语言模型（LLM），这种额外的并行能力可显著提升运行速度（论文中声称提速达 3.6 倍）。

3. **Joiner**: dynamically replan or finish based on the entire graph history (including task execution results) is an LLM step that decides whether to respond with the final answer or whether to pass the progress back to the (re-)planning agent to continue work.  
3. **聚合器（Joiner）**：基于整个图的历史信息（包括各任务的执行结果）动态决定是重新规划还是终止流程——这是一个由大语言模型（LLM）执行的步骤，用于判断应直接返回最终答案，还是将当前进展交还给（重新）规划代理以继续后续工作。

The key runtime-boosting ideas here are:

此处提升运行时性能的关键思想包括：

- **Planner** outputs are **_streamed;_** the output parser eagerly yields task parameters and their dependencies.  
- **规划器（Planner）** 的输出是 **_流式生成的_**；输出解析器会主动、及时地提取出任务参数及其依赖关系。

- The **task fetching unit** receives the parsed task stream and schedules tasks once all their dependencies are satisfied.  
- **任务获取单元（Task Fetching Unit）** 接收经解析后的任务流，并在所有依赖任务完成之后立即调度对应任务。

- Task arguments can be _variables,_ which are the outputs of previous tasks in the DAG. For instance, the model can call `search("${1}")` to search for queries generated by the output of task 1. This lets the agent work even faster than the "embarrassingly parallel" tool calling in OpenAI.  
- 任务参数可以是 _变量_，即 DAG 中先前任务的输出结果。例如，模型可调用 `search("${1}")`，以使用任务 1 的输出作为搜索查询。这使得智能体的执行效率甚至超越了 OpenAI 所采用的“高度并行化”（embarrassingly parallel）工具调用方式。

By formatting tasks as a DAG, the agent can save precious time while invoking tools, leading to an overall better user experience.

通过将任务组织为有向无环图（DAG），智能体可在调用工具时节省宝贵时间，从而全面提升用户体验。

## Conclusion

## 结论

These three agent architectures are prototypical of the "plan-and-execute" design pattern, which separates an LLM-powered "planner" from the tool execution runtime. If your application requires multiple tool invocations or API calls, these types of approaches can reduce the time it takes to return a final result and help you save costs by reducing the frequency of calls to more powerful LLMs.

上述三种智能体架构均是典型的“规划—执行”（plan-and-execute）设计模式的代表：该模式将由大语言模型（LLM）驱动的“规划器”与工具执行运行时环境明确分离。若您的应用需多次调用工具或外部 API，此类方法可显著缩短返回最终结果所需的时间，并通过减少对更强大（也更昂贵）的大语言模型的调用频次，帮助您降低成本。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/) [agents](https://blog.langchain.com/tag/agents/) [langgraph](https://blog.langchain.com/tag/langgraph/)

[![Introducing Agent Builder templates](images/plan-and-execute-agents/img_004.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[![推出 Agent Builder 模板](images/plan-and-execute-agents/img_004.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**Deploy agents instantly with Agent Builder templates**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**使用 Agent Builder 模板即时部署智能体**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 3 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：3 分钟

[![Building Multi-Agent Apps](images/plan-and-execute-agents/img_005.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[![构建多智能体应用](images/plan-and-execute-agents/img_005.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**Building Multi-Agent Applications with Deep Agents**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**使用 Deep Agents 构建多智能体应用**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[deep agents](https://blog.langchain.com/tag/deep-agents/) 5 min read

[deep agents](https://blog.langchain.com/tag/deep-agents/) 阅读时长：5 分钟

[![LangSmith Agent Builder Now Generally Available](images/plan-and-execute-agents/img_006.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[![LangSmith Agent Builder 现已正式发布（GA）](images/plan-and-execute-agents/img_006.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**Now GA: LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**正式发布（GA）：LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[agents](https://blog.langchain.com/tag/agents/) 2 min read

[agents](https://blog.langchain.com/tag/agents/) 阅读时长：2 分钟

[![Evaluating Deep Agents: Our Learnings](images/plan-and-execute-agents/img_007.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估 Deep Agents：我们的实践经验](images/plan-and-execute-agents/img_007.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/plan-and-execute-agents/img_008.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/plan-and-execute-agents/img_008.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 3 分钟

[![LangChain State of AI 2024 Report](images/plan-and-execute-agents/img_009.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/plan-and-execute-agents/img_009.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 6 分钟
&#123;% endraw %}
