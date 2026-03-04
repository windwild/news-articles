---
render_with_liquid: false
title: "The rise of \"context engineering\""
source: "LangChain Blog"
url: "https://blog.langchain.com/the-rise-of-context-engineering/"
date: "2025-06-23"
scraped_at: "2026-03-03T07:29:23.822575170+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---
render_with_liquid: false
render_with_liquid: false

_Header image from_ [_Dex Horthy on Twitter_](https://x.com/dexhorthy/status/1933283008863482067?ref=blog.langchain.com) _._

_标题图来自_ [_Dex Horthy 的 Twitter_](https://x.com/dexhorthy/status/1933283008863482067?ref=blog.langchain.com) _。_

Context engineering is building dynamic systems to provide the right information and tools in the right format such that the LLM can plausibly accomplish the task.

上下文工程（Context Engineering）是指构建动态系统，以恰当的格式提供恰当的信息与工具，从而使大语言模型（LLM）能够合理、可靠地完成任务。

Most of the time when an agent is not performing reliably the underlying cause is that the appropriate context, instructions and tools have not been communicated to the model.

大多数情况下，当智能体（agent）表现不稳定或不可靠时，其根本原因在于：恰当的上下文、指令和工具尚未被有效传达给模型。

LLM applications are evolving from single prompts to more complex, dynamic agentic systems. As such, context engineering is becoming the [most important skill an AI engineer can develop](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com#a-theory-of-building-long-running-agents).

大语言模型应用正从单一提示（single prompt）逐步演进为更复杂、更动态的智能体系统（agentic systems）。因此，上下文工程正日益成为[一名 AI 工程师所能培养的最重要技能](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com#a-theory-of-building-long-running-agents)。

## What is context engineering?

## 什么是上下文工程？

Context engineering is building dynamic systems to provide the right information and tools in the right format such that the LLM can plausibly accomplish the task.

上下文工程是指构建动态系统，以恰当的格式提供恰当的信息与工具，从而使大语言模型（LLM）能够合理、可靠地完成任务。

This is the definition that I like, which builds upon recent takes on this from [Tobi Lutke](https://x.com/tobi/status/1935533422589399127?ref=blog.langchain.com), [Ankur Goyal](https://x.com/ankrgyl/status/1913766591910842619?ref=blog.langchain.com), and [Walden Yan](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com). Let’s break it down.

这是我偏好的定义，它融合并拓展了近期[Tobi Lutke](https://x.com/tobi/status/1935533422589399127?ref=blog.langchain.com)、[Ankur Goyal](https://x.com/ankrgyl/status/1913766591910842619?ref=blog.langchain.com)与[Walden Yan](https://cognition.ai/blog/dont-build-multi-agents?ref=blog.langchain.com)等人对此概念的思考。下面我们逐层解析。

**Context engineering is a system**

**上下文工程是一个系统**

Complex agents likely get context from many sources. Context can come from the developer of the application, the user, previous interactions, tool calls, or other external data. Pulling these all together involves a complex system.

复杂的智能体通常需从多个来源获取上下文。这些来源包括应用开发者、终端用户、历史交互记录、工具调用结果，或其他外部数据源。将所有这些信息整合起来，本身便构成一个复杂的系统。

**This system is dynamic**

**该系统是动态的**

Many of these pieces of context can come in dynamically. As such, the logic for constructing the final prompt needs to be dynamic as well. It is not just a static prompt.

这些上下文信息中的许多部分可能是动态传入的。因此，构建最终提示词（prompt）的逻辑本身也必须是动态的，而不能仅仅依赖一个静态提示。

**You need the right information**

**你需要提供恰当的信息**

A common reason agentic systems don’t perform is they just don’t have the right context. LLMs cannot read minds - you need to give them the right information. Garbage in, garbage out.

代理式系统（agentic systems）表现不佳的一个常见原因是缺乏恰当的上下文。大语言模型（LLM）无法读心——你必须向其提供恰当的信息。输入垃圾，输出必然是垃圾。

**You need the right tools**

**你需要配备恰当的工具**

It may not always be the case that the LLM will be able to solve the task just based solely on the inputs. In these situations, if you want to empower the LLM to do so, you will want to make sure that it has the right tools. These could be tools to look up more information, take actions, or anything in between. Giving the LLM the right tools is just as important as giving it the right information.

LLM 并不总能仅凭输入就完成任务。在这些情况下，若希望赋能 LLM 成功执行任务，就必须确保它拥有恰当的工具——例如用于检索更多信息、执行具体操作，或介于二者之间的各类工具。为 LLM 提供恰当的工具，其重要性丝毫不亚于提供恰当的信息。

**The format matters**

**格式至关重要**

Just like communicating with humans, how you communicate with LLMs matters. A short but descriptive error message will go a lot further a large JSON blob. This also applies to tools. What the input parameters to your tools are matters a lot when making sure that LLMs can use them.

正如与人类沟通一样，你与 LLM 的沟通方式同样重要。一条简短但描述清晰的错误消息，远比一个冗长繁杂的 JSON 数据块更有效。这一点同样适用于工具设计：工具的输入参数如何定义，对 LLM 能否正确调用并使用该工具具有决定性影响。

**Can it plausibly accomplish the task?**

**该任务是否在逻辑上可被完成？**

This is a great question to be asking as you think about context engineering. It reinforces that LLMs are not mind readers - you need to set them up for success. It also helps separate the failure modes. Is it failing because you haven’t given it the right information or tools? Or does it have all the right information and it just messed up? These failure modes have very different ways to fix them.

这是进行上下文工程（context engineering）时一个极富价值的问题。它再次提醒我们：LLM 并非读心者——你必须为其成功执行任务做好充分准备。同时，它也有助于区分不同的失败模式：失败是因为未提供恰当的信息或工具？还是已提供全部必要信息，却仍因模型自身原因出错？这两种失败模式的解决路径截然不同。

## Why is context engineering important

## 为何上下文工程如此重要？

When agentic systems mess up, it’s largely because an LLM messes. Thinking from first principles, LLMs can mess up for two reasons:

当智能体系统出错时，主要原因往往在于大语言模型（LLM）出错。从第一性原理出发，LLM 出错通常源于以下两个原因：

1. The underlying model just messed up, it isn’t good enough  
1. 底层模型本身出了问题，其能力尚不足够  

2. The underlying model was not passed the appropriate context to make a good output  
2. 底层模型未被提供恰当的上下文，因而无法生成优质输出  

More often than not (especially as the models get better) model mistakes are caused more by the second reason. The context passed to the model may be bad for a few reasons:

在大多数情况下（尤其是随着模型能力不断提升），模型出错更多是由第二个原因导致的。传递给模型的上下文可能存在问题，原因包括以下几点：

- There is just missing context that the model would need to make the right decision. Models are not mind readers. If you do not give them the right context, they won’t know it exists.  
- 缺少模型做出正确决策所必需的关键上下文。模型并非读心者——若未向其提供恰当的上下文，它便无从知晓相关信息的存在。  

- The context is formatted poorly. Just like humans, communication is important! How you format data when passing into a model absolutely affects how it responds  
- 上下文格式不当。正如人类沟通一样，表达方式至关重要！将数据输入模型时的组织与格式，会直接影响模型的响应效果。  

## How is context engineering different from prompt engineering?

## 上下文工程（Context Engineering）与提示工程（Prompt Engineering）有何区别？

Why the shift from “prompts” to “context”? Early on, developers focused on phrasing prompts cleverly to coax better answers. But as applications grow more complex, it’s becoming clear that **providing complete and structured context** to the AI is far more important than any magic wording.

为何焦点正从“提示（prompts）”转向“上下文（context）”？早期，开发者倾向于精心设计提示词，以“引导”模型给出更优回答。但随着应用日益复杂，人们逐渐意识到：**为 AI 提供完整且结构化的上下文**，远比任何“神奇措辞”都更为关键。

I would also argue that prompt engineering is a subset of context engineering. Even if you have all the context, how you assemble it in the prompt still absolutely matters. The difference is that you are not architecting your prompt to work well with a single set of input data, but rather to take a set of dynamic data and format it properly.

我还认为，提示工程本质上是上下文工程的一个子集。即便你已掌握全部所需上下文，如何在提示中组织和编排这些信息，依然至关重要。二者的根本区别在于：你不再仅仅设计一个能适配某组固定输入数据的提示，而是构建一种机制，使其能够接收并合理格式化一组动态变化的数据。

I would also highlight that a key part of context is often core instructions for how the LLM should behave. This is often a key part of prompt engineering. Would you say that providing clear and detailed instructions for how the agent should behave is context engineering or prompt engineering? I think it’s a bit of both.

我还想强调：上下文的关键组成部分，常常是关于 LLM 应如何行为的核心指令——而这本身也往往是提示工程的核心环节。那么，为智能体提供清晰、详尽的行为指令，究竟属于上下文工程还是提示工程？我认为，这二者兼而有之。

## Examples of context engineering

## 上下文工程的典型示例

Some basic examples of good context engineering include:  
良好的上下文工程实践示例包括：

- Tool use: Making sure that if an agent needs access to external information, it has tools that can access it. When tools return information, they are formatted in a way that is maximally digestable for LLMs  
- 工具调用：确保当智能体需要访问外部信息时，具备可调用的相关工具；工具返回的信息经过格式化处理，以最大程度适配大语言模型（LLM）的理解与使用。

- Short term memory: If a conversation is going on for a while, creating a summary of the conversation and using that in the future.  
- 短期记忆：若对话持续较长时间，则生成对话摘要，并在后续交互中复用该摘要。

- Long term memory: If a user has expressed preferences in a previous conversation, being able to fetch that information.  
- 长期记忆：若用户曾在先前对话中表达过偏好，系统能够检索并复用该信息。

- Prompt Engineering: Instructions for how an agent should behave are clearly enumerated in the prompt.  
- 提示工程：关于智能体应如何行为的指令，在提示词（prompt）中被清晰、明确地列出。

- Retrieval: Fetching information dynamically and inserting it into the prompt before calling the LLM.  
- 检索：在调用大语言模型前，动态获取相关信息并将其注入提示词中。

## How LangGraph enables context engineering  

## LangGraph 如何赋能上下文工程  

When we built [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com), we built it with the goal of making it the most controllable agent framework. This also allows it to perfectly enable context engineering.  

我们在构建 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 时，目标是将其打造为**可控性最强的智能体框架**。这一设计理念也使其成为实现上下文工程（context engineering）的理想平台。

With LangGraph, you can control everything. You decide what steps are run. You decide **exactly** what goes into your LLM. You decide where you store the outputs. You control everything.  

借助 LangGraph，您可实现**全链路掌控**：您决定执行哪些步骤；您决定**精确地**向大语言模型输入什么内容；您决定输出结果的存储位置——一切尽在掌握。

This allows you do all the context engineering you desire. One of the downsides of agent abstractions (which most other agent frameworks emphasize) is that they restrict context engineering. There may be places where you cannot change exactly what goes into the LLM, or exactly what steps are run beforehand.  

这使您能自由开展所需的一切上下文工程实践。而多数其他智能体框架所强调的“智能体抽象层”（agent abstractions），其一大缺陷恰恰在于限制了上下文工程的灵活性——某些环节中，您可能无法精确控制输入至大语言模型的内容，也无法完全自定义前置执行步骤。

Side note: a very good read is Dex Horthy's ["12 Factor Agents"](https://github.com/humanlayer/12-factor-agents?ref=blog.langchain.com). A lot of the points there relate to context engineering ("own your prompts", "own your context building", etc). The header image for this blog is also taken from Dex. We really enjoy the way he communicates about what is important in the space.  

附注：Dex Horthy 的文章 ["12 Factor Agents"](https://github.com/humanlayer/12-factor-agents?ref=blog.langchain.com) 是一篇极富洞见的佳作。其中诸多要点均直指上下文工程的核心理念（例如“自主掌控提示词”“自主构建上下文”等）。本文博客的题图亦取自 Dex 的作品。我们非常欣赏他阐述该领域关键议题时所展现的清晰与深刻。

## How LangSmith helps with context engineering  

## LangSmith 如何助力上下文工程  

[LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) is our LLM application observability and evals solution. One of the key features in LangSmith is the ability to [trace your agent calls](https://docs.smith.langchain.com/observability/tutorials/observability?ref=blog.langchain.com). Although the term "context engineering" didn't exist when we built LangSmith, it aptly describes what this tracing helps with.  

[LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 是我们面向大语言模型应用的可观测性与评估（evals）解决方案。其核心功能之一，便是支持对智能体调用过程进行[完整追踪（tracing）](https://docs.smith.langchain.com/observability/tutorials/observability?ref=blog.langchain.com)。尽管“上下文工程”这一术语在 LangSmith 初创之时尚未出现，但该追踪能力恰恰精准服务于上下文工程的目标。

LangSmith lets you see all the steps that happen in your agent. This lets you see what steps were run to gather the data that was sent into the LLM.  

LangSmith 可直观呈现智能体内部执行的全部步骤，助您清晰了解：为向大语言模型提供输入数据，系统究竟执行了哪些操作。

LangSmith lets you see the exact inputs and outputs to the LLM. This lets you see exactly what went into the LLM — the data it had and how it was formatted. You can then debug whether that contains all the relevant information that is needed for the task. This includes what tools the LLM has access to — so you can debug whether it's been given the appropriate tools to help with the task at hand.  

LangSmith 可精确展示大语言模型的全部输入与输出内容——包括模型实际接收的数据及其具体格式。由此，您可深入调试：当前输入是否已涵盖完成任务所需的全部相关信息？其中包括智能体可调用的工具集——您可据此验证：大语言模型是否已被赋予恰当的工具，以有效支撑当前任务的执行。

## Communication is all you need

## 沟通就是一切

A few months ago I wrote a blog called ["Communication is all you need"](https://blog.langchain.com/communication-is-all-you-need/). The main point was that communicating to the LLM is hard, and not appreciated enough, and often the root cause of a lot of agent errors. Many of these points have to do with context engineering!

几个月前，我撰写了一篇题为 [《沟通就是一切》](https://blog.langchain.com/communication-is-all-you-need/) 的博客。核心观点是：向大语言模型（LLM）有效传达指令非常困难，这一挑战常被低估，且往往是大量智能体（agent）出错的根本原因。其中许多问题都与上下文工程（context engineering）密切相关！

Context engineering isn't a new idea - agent builders have been doing it for the past year or two. It's a new term that aptly describes an increasingly important skill. We'll be writing and sharing more on this topic. We think a lot of the tools we've built (LangGraph, LangSmith) are perfectly built to enable context engineering, and so we're excited to see the emphasis on this take off.

上下文工程并非全新概念——过去一两年间，智能体开发者一直在实践它。但“上下文工程”作为一个新术语，精准概括了一项日益关键的技能。我们后续将持续围绕这一主题撰文并分享见解。我们认为，我们所构建的诸多工具（如 LangGraph、LangSmith）正是为赋能上下文工程而生；因此，我们非常欣喜地看到业界对这一方向的关注正迅速升温。

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/the-rise-of-context-engineering/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![论智能体框架与智能体可观测性](images/the-rise-of-context-engineering/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**论智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/the-rise-of-context-engineering/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪数据到深度洞察：规模化理解智能体行为](images/the-rise-of-context-engineering/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/the-rise-of-context-engineering/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用行为；在 AI 中，追踪数据（traces）承担这一角色。](images/the-rise-of-context-engineering/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用行为；在 AI 中，追踪数据（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/the-rise-of-context-engineering/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架（Agent Frameworks）、运行时（Runtimes）与编排层（Harnesses）——天哪！](images/the-rise-of-context-engineering/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架（Agent Frameworks）、运行时（Runtimes）与编排层（Harnesses）——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/the-rise-of-context-engineering/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考与回顾](images/the-rise-of-context-engineering/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考与回顾**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/the-rise-of-context-engineering/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不。**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读