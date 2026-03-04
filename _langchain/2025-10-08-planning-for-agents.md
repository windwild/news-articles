---
render_with_liquid: false
title: "Planning for Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/planning-for-agents/"
date: "2025-10-08"
scraped_at: "2026-03-03T07:27:09.118217870+00:00"
language: "en-zh"
translated: true
description: "The fourth installment in our \"In the Loop Series,\" in which we talk about what planning means for an agent and how to improve it."
tags: ["Harrison's Hot Takes"]
---
render_with_liquid: false
render_with_liquid: false

_At Sequoia’s AI Ascent conference in March, I talked about three limitations for agents: planning, UX, and memory. Check out that talk_ [_here_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com) _. In this post, I will dive more into planning for agents._

在今年3月红杉资本（Sequoia）举办的“AI Ascent”大会上，我曾探讨了智能体（agents）面临的三大局限：规划能力（planning）、用户体验（UX）和记忆能力（memory）。您可点击此处观看该演讲视频：[_链接_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com)。本文将深入聚焦于智能体的**规划能力**。

If you ask any developer building agents with LLMs, he or she will probably cite the inability for agents to plan and reason well as a big pain point for agent reliability. What does planning mean for an agent, and how do we see people currently overcoming this shortcoming? What is (our best guess at what) the future of planning and reasoning for agents will look like? We’ll cover all of this below.

若您向任何一位正在使用大语言模型（LLM）构建智能体的开发者提问，他/她很可能指出：智能体缺乏良好的规划与推理能力，是影响其可靠性的主要痛点。那么，对智能体而言，“规划”究竟意味着什么？当前业界又如何应对这一短板？而（我们目前最合理的推测是）智能体的规划与推理能力未来将走向何方？下文将逐一展开探讨。

## What exactly is meant by planning and reasoning?

## 规划与推理究竟指什么？

Planning and reasoning by an agent involves the LLM’s ability to think about what actions to take. This involves both short-term and long term steps. The LLM evaluates all available information and then decides: what are the series of steps that I need to take, and which is the first one I should take right now?

智能体的规划与推理，是指大语言模型（LLM）思考“应采取何种行动”的能力——这既包括即时的短期步骤，也涵盖面向目标的长期步骤。LLM需综合评估所有可用信息，进而判断：为达成目标，我需要执行哪些步骤？其中，当下应优先执行的是哪一步？

Most of the time, developers use [function calling](https://platform.openai.com/docs/guides/function-calling?ref=blog.langchain.com) (also known as tool calling) to let LLMs choose what actions to take. Function calling is a capability [first added to LLM APIs by OpenAI in June of 2023](https://openai.com/index/function-calling-and-other-api-updates/?ref=blog.langchain.com) and then [by others in late 2023/early 2024](https://python.langchain.com/v0.2/docs/integrations/chat/?ref=blog.langchain.com#advanced-features). With function calling, you can provide JSON schemas for different functions and have the LLM output object match one (or more) of those schemas. For more information on how to do this, see our guide [here](https://python.langchain.com/v0.2/docs/how_to/tool_calling/?ref=blog.langchain.com).

大多数情况下，开发者借助[函数调用（function calling）](https://platform.openai.com/docs/guides/function-calling?ref=blog.langchain.com)（亦称工具调用，tool calling）机制，使LLM自主选择待执行的动作。该能力最早由OpenAI于2023年6月在其LLM API中引入，随后其他厂商也于2023年末至2024年初陆续支持。通过函数调用，开发者可为各类函数提供JSON Schema定义，LLM则输出符合其中一个（或多个）Schema结构的对象。有关具体实现方法，请参阅我们的指南：[此处](https://python.langchain.com/v0.2/docs/how_to/tool_calling/?ref=blog.langchain.com)。

Function calling is used to let the agent choose what to do as an immediate action. Often times though, to successfully accomplish a complex task you need to take a number of actions in sequence. This long-term planning and reasoning is a tougher task for LLMs for a few reasons. First, the LLM must think about a longer time-horizon goal, but then jump back into a short-term action to take. Second, as the agent takes more and more actions, the results of those actions are fed back to the LLM; this lead to the context window growing, which can cause the LLM to get “distracted” and perform poorly.

函数调用主要用于让智能体决定**当下应执行的即时动作**。然而，要成功完成一项复杂任务，往往需按序执行多个动作——这种面向长期目标的规划与推理，对LLM而言更具挑战性，原因有二：其一，LLM需兼顾远期目标，却又要迅速切换回执行当下的短期动作；其二，随着智能体执行动作次数增多，各步动作的结果持续反馈给LLM，导致上下文窗口（context window）不断膨胀，易使LLM“分心”，从而降低性能表现。

Like most things in the LLM world, it is tough to measure exactly how well current models do at planning and reasoning. There are reasonable benchmarks like the [Berkeley Function Calling Leaderboard](https://gorilla.cs.berkeley.edu/leaderboard.html?ref=blog.langchain.com) for evaluating function calling. We’ve done [a little research](https://blog.langchain.com/benchmarking-agent-tool-use/) on evaluating multi-step applications. But the best way to get a sense for this is build up an evaluation set for **your specific problem** and attempt to evaluate on that yourself.

如同大语言模型领域的多数问题一样，要精确量化当前模型在规划与推理方面的实际表现，仍十分困难。目前已有若干合理基准测试，例如用于评估函数调用能力的[加州大学伯克利分校函数调用排行榜（Berkeley Function Calling Leaderboard）](https://gorilla.cs.berkeley.edu/leaderboard.html?ref=blog.langchain.com)；我们也曾就多步骤应用的评估开展过[初步研究](https://blog.langchain.com/benchmarking-agent-tool-use/)。但最有效的方式，仍是围绕**您自身的具体问题**构建专属评测集，并亲自开展评估。

💡

Anecdotally, it's a common conclusion that planning and reasoning is still not at the level it’s needed to be for real-world tasks.

据业内普遍经验判断，当前智能体的规划与推理能力，仍未达到支撑真实世界任务所需的水平。

## What are current fixes to improve planning by agents?

## 当前有哪些提升智能体规划能力的改进方案？

The lowest hanging fix for improving planning is to ensuring the LLM has all the information required to reason/plan appropriately. As basic as this sounds, oftentimes the prompt being passed into the LLM simply does not contain enough information for the LLM to make a reasonable decision. Adding a retrieval step, or clarifying the prompt instructions, can be an easy improvement. That’s why its crucial to actually [look at the data](https://x.com/HamelHusain/status/1717582026537312519?ref=blog.langchain.com) and see what the LLM is actually seeing.

提升规划能力最直接有效的改进方法，是确保大语言模型（LLM）拥有充分的信息以进行合理推理与规划。尽管这听起来非常基础，但实践中输入 LLM 的提示词往往信息不足，导致模型难以做出合理决策。增加一个检索步骤，或进一步明确提示词中的指令，即可带来显著且易于实施的改进。因此，至关重要的是——真正[查看实际输入的数据](https://x.com/HamelHusain/status/1717582026537312519?ref=blog.langchain.com)，弄清楚 LLM 究竟“看到”了什么。

After that, I’d recommend you try changing the [cognitive architecture](https://blog.langchain.com/what-is-a-cognitive-architecture/) of your application. By “cognitive architecture”, I mean the data engineering logic your application uses to reason. There are two categories of cognitive architectures you can look towards to improve reasoning: general purpose cognitive architectures and domain specific cognitive architectures.

在此之后，我建议你尝试调整应用的[认知架构](https://blog.langchain.com/what-is-a-cognitive-architecture/)。“认知架构”在此指代你的应用用于推理所依赖的数据工程逻辑。为提升推理能力，可重点关注两类认知架构：通用型认知架构（general-purpose cognitive architectures）与领域专用型认知架构（domain-specific cognitive architectures）。

## General purpose cognitive architectures vs domain specific cognitive architectures

## 通用型认知架构 vs 领域专用型认知架构

General purpose cognitive architectures attempt to achieve better reasoning generically. They can be applied to any task. One good example of this is the “plan and solve” architecture. [This paper](https://arxiv.org/abs/2305.04091?ref=blog.langchain.com) explores an architecture where first you come up with a plan, and then execute on each step in that plan. Another general purpose architecture is the Reflexion architecture. [This paper](https://arxiv.org/abs/2303.11366?ref=blog.langchain.com) explores putting an explicit “reflection” step after the agent does a task to reflect on whether it did it correctly or not.

通用型认知架构旨在以通用方式提升推理能力，适用于各类任务。一个典型示例是“规划—求解”（plan-and-solve）架构。[这篇论文](https://arxiv.org/abs/2305.04091?ref=blog.langchain.com)探讨了一种先生成计划、再逐项执行计划中各步骤的架构。另一类通用架构是 Reflexion 架构。[该论文](https://arxiv.org/abs/2303.11366?ref=blog.langchain.com)提出：在智能体完成某项任务后，显式加入一个“反思”（reflection）步骤，用以评估任务执行是否正确。

Though these ideas show improvement, they are often too general for practical use by agents in production. Rather, we see agents being built with domain-specific cognitive architectures. This often manifests in domain-specific classification/routing steps, domain specific verification steps. Some of the general ideas of planning and reflection can be applied here, but they are often applied in a domain specific way.

尽管这些思路展现出一定改进效果，但其通用性过强，往往难以直接应用于生产环境中的智能体。现实中，我们更常见的是基于领域专用型认知架构构建的智能体。这类架构通常体现为领域专属的分类/路由步骤、领域专属的验证步骤等。其中，规划与反思等通用理念仍可被借鉴，但往往需结合具体领域进行定制化适配。

As a concrete example, let’s look at the [AlphaCodium paper](https://www.codium.ai/products/alpha-codium/?ref=blog.langchain.com). This achieved state-of-the-art performance by using what they called “flow engineering” (another way to talk about cognitive architectures). See a diagram of the flow they use below.

作为具体实例，我们来看[AlphaCodium 论文](https://www.codium.ai/products/alpha-codium/?ref=blog.langchain.com)。该工作通过所谓“流程工程”（flow engineering）——即另一种对认知架构的表述——实现了当前最优性能。下图展示了其所采用的流程：

![](images/planning-for-agents/img_001.png)

The flow is VERY specific to the problem they are trying to solve. They are telling the agent what to do in steps - come up with tests, then come up with a solution, then iterate on more tests, etc. This cognitive architecture is highly domain specific - it wouldn’t help you write essays, for example.

该流程与其试图解决的问题高度绑定。他们以分步指令的方式明确告诉智能体该做什么：先生成测试用例，再生成解决方案，接着迭代补充更多测试……这种认知架构具有极强的领域专属性——例如，它对撰写议论文就毫无帮助。

## Why are domain specific cognitive architectures so helpful?

## 为何领域专用型认知架构如此有效？

There are two ways I like to think about this.

关于这一点，我倾向于从两个角度来理解。

First: you can view this as just another method of communicating to the agent what it should do. You can communicate instructions in prompt instructions, or you can hardcode specific transitions in code. Either one is valid! Code is **fantastic** way of communicating what you want to have happen.

第一点：你可以将这种方式视为向智能体传达“它应当做什么”的又一种途径。你既可以通过提示词（prompt）中的指令来传达任务要求，也可以直接在代码中硬编码特定的状态流转逻辑。两种方式都完全可行！代码是一种**极佳的**表达你期望行为的方式。

Second: this is essentially removing the planning responsibilities from the LLM to us as engineers. We are are basically saying: “don’t worry about planning, LLM, I’ll do it for you!” Of course, we’re not removing ALL planning from the LLM, as we still ask it do some planning in some instances.

第二点：这本质上是将规划（planning）职责从大语言模型（LLM）转移给了我们这些工程师。我们实际上是在说：“LLM，别担心规划了，我来替你完成！”当然，我们并未彻底移除LLM的所有规划能力——在某些场景下，我们仍会要求它执行部分规划任务。

For example, let’s look back at the AlphaCodium example above. The steps in the flow are basically us doing planning for the LLM! We’re telling it to first write tests, then code, then run the tests, etc. This is presumably what the authors thought a good plan for writing software was. If they were planning how to do a problem, this is how they would do it. And rather than tell the LLM to do in the prompt - where it may ignore it, not understand it, not have all the details - they told the system to do it by constructing a domain specific cognitive architecture.

例如，让我们回顾上文提到的 AlphaCodium 示例。流程中的各个步骤，本质上就是我们在为 LLM 进行规划！我们明确告诉它：先编写测试，再编写代码，然后运行测试，等等。这大概正是作者所认为的软件开发的理想规划路径——如果让他们自己来规划如何解决一个问题，他们也会采用这样的步骤。与其将该规划逻辑写进提示词（prompt），结果却可能被 LLM 忽略、误解，或因缺乏细节而无法准确执行，他们选择通过构建一个面向特定领域的认知架构（domain-specific cognitive architecture），让系统按既定逻辑自动执行。

💡

💡

Nearly all the advanced “agents” we see in production actually have a very domain specific and custom cognitive architecture.

目前几乎所有投入实际生产的高级“智能体（agents）”，其底层都依赖高度领域定制化、专属设计的认知架构。

We’re making building these custom cognitive architectures easier with [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com). One of the big focus points of LangGraph is on controllability. We’ve designed LangGraph to very low level and highly controllable - this is because we’ve seen that level of controllability is 100% needed to create a reliable custom cognitive architecture.

我们正借助 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 让这类定制化认知架构的构建变得更加便捷。LangGraph 的一大核心设计目标正是**可控性（controllability）**。我们将其设计为底层粒度极细、高度可编程的框架——因为我们已深刻认识到：唯有达到这一级别的可控性，才能构建出真正可靠、可落地的定制化认知架构。

## What does the future of planning and reasoning look like?

## 规划与推理的未来图景是什么？

The LLM space has been changing and evolving rapidly, and we should keep that in mind when building applications, and especially when building tools.

大语言模型（LLM）领域正以前所未有的速度持续演进；我们在构建应用（尤其是构建工具）时，必须时刻牢记这一趋势。

My current take is that general purpose reasoning will get more and more absorbed into the model layer. The models will get more and more intelligent, whether through scale or research breakthroughs - it seems foolish to bet against that. Models will get faster and cheaper as well, so it will become more and more feasible to pass a large amount of context to them.

我当前的观点是：通用型推理能力将越来越多地被内化至模型层本身。无论通过扩大模型规模，还是借助研究突破，模型的智能水平将持续提升——押注其不会进步，显然不合常理。同时，模型的推理速度将越来越快、成本也将越来越低，因此向其输入大量上下文信息将变得愈发可行。

However, I believe that no matter how powerful the model becomes, you will always need to communicate to the agent, in some form, what it should do. As a result, I believe prompting and custom architectures are here to stay. For simple tasks, prompting may suffice. For more complex tasks, you may want to put the logic of how it should behave in code. Code-first approaches may be faster, more reliable, more debuggable, and oftentimes easier/more logical to express.

然而，我相信：无论模型变得多么强大，你始终需要以某种形式向智能体明确传达“它应当做什么”。因此，我坚信——提示工程（prompting）与定制化架构将长期共存。对于简单任务，仅靠提示词或许已足够；而对于更复杂的任务，你可能更希望将“智能体应如何行为”的逻辑直接写入代码。以代码为先（code-first）的方法往往具备更快的执行速度、更高的可靠性、更强的可调试性，且在多数情况下，也更容易表达、更符合逻辑。

I went on a [podcast recently](https://podcasts.apple.com/us/podcast/langchains-harrison-chase-on-building-the/id1750736528?i=1000659385691&ref=blog.langchain.com) with Sonya and Pat from Sequoia and talked about this topic. They drew a fantastic diagram showing how the role / importance of prompting, cognitive architectures, and the model may evolve over time.

我最近与红杉资本（Sequoia）的 Sonya 和 Pat 参加了一档[播客节目](https://podcasts.apple.com/us/podcast/langchains-harrison-chase-on-building-the/id1750736528?i=1000659385691&ref=blog.langchain.com)，就这一话题展开了讨论。他们绘制了一张极为精彩的示意图，展示了提示工程（prompting）、认知架构（cognitive architectures）以及大语言模型（the model）的角色与重要性将如何随时间演进。

![](images/planning-for-agents/img_002.png)

![](images/planning-for-agents/img_002.png)

So while the planning and reasoning of LLMs will certainly get better, we also strongly believe that if you are building a task-specific agent then you will need to build a custom cognitive architecture. That’s why we’re so bullish on the future of [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com).

因此，尽管大语言模型（LLM）的规划与推理能力必将持续提升，我们也坚定地认为：如果你正在构建面向特定任务的智能体（agent），那么你必须设计并实现一套定制化的认知架构。这正是我们对 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 的未来发展如此看好的原因。

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/planning-for-agents/img_003.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![论智能体框架与智能体可观测性](images/planning-for-agents/img_003.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**论智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/planning-for-agents/img_004.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪数据到深度洞察：规模化理解智能体行为](images/planning-for-agents/img_004.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/planning-for-agents/img_005.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用逻辑；在 AI 中，追踪数据（traces）承担这一角色。](images/planning-for-agents/img_005.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用逻辑；在 AI 中，追踪数据（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/planning-for-agents/img_006.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架（Agent Frameworks）、运行时（Runtimes）与编排层（Harnesses）——天哪！](images/planning-for-agents/img_006.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架（Agent Frameworks）、运行时（Runtimes）与编排层（Harnesses）——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/planning-for-agents/img_007.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考与回顾](images/planning-for-agents/img_007.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考与回顾**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/planning-for-agents/img_008.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？](images/planning-for-agents/img_008.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读