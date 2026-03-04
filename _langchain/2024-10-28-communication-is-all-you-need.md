---
title: "Communication is all you need"
source: "LangChain Blog"
url: "https://blog.langchain.com/communication-is-all-you-need/"
date: "2024-10-28"
scraped_at: "2026-03-03T07:50:19.969215711+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---
{% raw %}

> “What we’ve got here is failure to communicate” — [《铁窗喋血》（1967）](https://www.youtube.com/watch?v=452XjnaHr1A&ref=blog.langchain.com)  
> “我们眼前所见，是沟通的失败。”——《铁窗喋血》（1967）

Communication is the hardest part of life. It’s also the hardest part of building LLM applications.  
沟通是人生中最难的部分；它同时也是构建大语言模型（LLM）应用时最难的部分。

New hires always requires a lot of communication when first joining a company, no matter how smart they may be. This might include getting a guidebook of key procedures and best practices, having a manager step in to help the new hire get up to speed, and gaining access to specific software to do the job properly. While ramping up, giving and receiving continuous feedback ensures that the new hire is successful in their role.  
新员工初入公司时，无论其多么聪明，都必然需要大量沟通。这可能包括获取一份涵盖关键流程与最佳实践的操作指南、由经理介入协助新人快速上手，以及获得执行工作所必需的特定软件权限。在入职适应期，持续给予和接收反馈，是确保新人顺利胜任岗位的关键。

Just as onboarding a new hire requires thoughtful communication, building an agent also requires high standards for good communication. As smart as the underlying LLMs may become, they will still need the proper context to function reliably, and that context needs to be communicated properly.  
正如新员工入职需要深思熟虑的沟通一样，构建智能体（agent）同样对沟通质量提出了高标准要求。即便底层大语言模型日益强大，它们仍需恰当的上下文才能稳定可靠地运行——而这一上下文，必须被准确、有效地传达给模型。

💡  
💡  

Most of the time when an agent is not performing reliably the underlying cause is not that the model is not intelligent enough, but rather that context and instructions have not been communicated properly to the model.  
大多数情况下，当智能体表现不可靠时，根本原因并非模型“不够聪明”，而在于上下文信息与指令未能被恰当地传达给模型。

Don’t get me wrong - the models do mess up and have room to improve. But more often than not, it comes down to basic communication issues.  
请别误会——模型确实会出错，也仍有提升空间；但更常见的情况是，问题根源恰恰在于最基础的沟通失误。

If we believe that communication is a key part of building LLM applications, then from that axiom, we can derive some other “hot takes” about agents that should hold. I’ve listed a few below in brief detail. All of these could (and maybe will) be individual blogs.  
如果我们认同“沟通是构建 LLM 应用的关键环节”这一前提，那么由此出发，我们便可推导出若干关于智能体的其他“犀利观点”（hot takes），这些观点理应成立。以下我简要列出几点；其中每一项，都足以（也或许终将）成为一篇独立博文。

## Why prompt engineering isn’t going away  
## 为何提示工程（prompt engineering）不会消亡

As models improve, prompt engineering tricks like [bribing an LLM with a tip](https://minimaxir.com/2024/02/chatgpt-tips-analysis/?ref=blog.langchain.com) or worrying about JSON vs XML formatting will become near obsolete. However, it will still be critical for you to effectively and clearly communicate to the model and give it clear instructions on how to handle various scenarios.  
随着模型能力不断提升，诸如“用小费‘贿赂’大语言模型”[1] 或纠结于 JSON 与 XML 格式孰优孰劣等提示工程“技巧”，将几近过时。然而，你依然必须以高效、清晰的方式向模型传达意图，并为其提供明确指令，指导其如何应对各类场景——这一点，始终至关重要。

💡

The model is not a mind reader - if you want it to behave a certain way or process specific information, you must provide that context.

模型不是读心者——如果你希望它以某种方式行为，或处理特定信息，就必须提供相应上下文。

The best tip for diagnosing why your agent isn’t working is to simply look at the actual calls to the LLM and the exact inputs to the prompts— then make sure that if you gave these inputs to the smartest human you know, they would be able to respond as you expect. If they couldn’t do that, then you need to clarify your request, typically by adjusting the prompt. This process, known as prompt engineering, is unlikely to disappear anytime soon.

诊断你的智能体为何无法正常工作的最佳方法，就是直接查看实际发给大语言模型（LLM）的调用及其提示词（prompt）的确切输入；然后思考：如果把这些输入交给你知道的最聪明的人类，他/她是否能按你的预期作出回应？如果不能，那么你就需要进一步明确你的请求——通常可通过优化提示词来实现。这一过程即所谓“提示工程”（prompt engineering），在可预见的未来都难以被取代。

## Why code will make up a large part of the "cognitive architecture" of an agent

## 为何代码将构成智能体“认知架构”的重要组成部分

Prompts are one way to communicate to an LLM how they should behave as part of an agentic system, but code is just as important. Code is a fantastic way to communicate how a system should behave. Compared to natural language, code lets you communicate much more precisely the steps you expect a system to take.

提示词是向大语言模型传达其在智能体系统中应如何行为的一种方式，但代码同样至关重要。代码是一种极为出色的表达系统行为方式的工具。与自然语言相比，代码能更精确地描述你期望系统执行的每一步操作。

💡

The ["cognitive architecture"](https://blog.langchain.com/what-is-a-cognitive-architecture/) of your agent will consist of both code and prompts.

你的智能体的[“认知架构”](https://blog.langchain.com/what-is-a-cognitive-architecture/)将由代码和提示词共同构成。

Some instructions an agent can only be communicated in natural language. Others could be either code or language. Code can be more precise and more efficient, and so there are many spots we see code being more useful than prompts when building the ["cognitive architecture"](https://blog.langchain.com/what-is-a-cognitive-architecture/) of your agent.

某些指令只能通过自然语言传达给智能体；另一些则既可用代码、也可用自然语言表达。代码往往更精确、更高效，因此在构建你的智能体的[“认知架构”](https://blog.langchain.com/what-is-a-cognitive-architecture/)时，我们常发现代码比提示词更具优势的诸多场景。

## Why you need an agent framework

## 为何你需要一个智能体框架

Some parts of coding are necessary for you, as an agent developer, to write, in order to best communicate to the agent what it should be doing. This makes up the cognitive architecture of your application and is part of your competitive advantage and moat.

作为智能体开发者，你必须亲自编写某些代码，才能最有效地向智能体阐明其应执行的任务。这部分构成了你应用的“认知架构”，也是你核心竞争力与护城河的重要组成部分。

💡

💡

There are other pieces of code that you will have to write that are generic infrastructure and tooling that you need to build, but don't provide any differentiation. This is where an agent framework can assist.

还有其他一些代码需要你自行编写，它们属于通用型基础设施和工具，虽为构建所必需，却无法为你带来差异化优势。此时，一个智能体（agent）框架便能提供有力支持。

An agent framework facilitates this by letting you focus on the parts of code that matter — what the agent should be doing — while taking care of common concerns unrelated to your application’s cognitive architecture, such as:

智能体框架通过让你专注于真正关键的代码部分——即“智能体应当做什么”，同时代为处理那些与你的应用认知架构无关的通用问题，从而助力开发，例如：

- Clear streaming of what the agent is doing  
- 智能体行为的清晰流式输出  
- Persistence to enable multi-tenant memory  
- 支持多租户记忆的持久化机制  
- Infrastructure to power human-in-the-loop interaction patterns  
- 支持“人在环路中”（human-in-the-loop）交互模式的基础设施  
- Running agents in a fault tolerant, horizontally scalable way  
- 以容错、水平可扩展的方式运行智能体  

## Why it matters that LangGraph is the most controllable agent framework out there

## 为何 LangGraph 作为目前可控性最强的智能体框架至关重要

You want an agent framework that takes care of some of the issues that are listed above, but that still lets you communicate as clearly as possible (through prompts and code) what the agent should be doing. Any agent framework that obstructs that is just going to get in the way — even if it makes it easier to get started. Transparently, that’s what we saw with `langchain` — it made it easy to get started but suffered from built-in prompts, a hard-coded while loop, and wasn’t easy to extend.

你所需要的智能体框架，既要能解决上述部分问题，又要让你能通过提示词（prompts）和代码，尽可能清晰、直接地表达“智能体应当做什么”。任何阻碍这一目标的框架，终将徒增障碍——即便它能让入门变得更简单。坦率地说，这正是我们对 `langchain` 的观察：它降低了上手门槛，却存在内置提示词、硬编码的 while 循环等问题，且难以扩展。

We made sure to fix that with LangGraph.

我们已在 LangGraph 中彻底解决了这些问题。

💡

💡

LangGraph stands apart from all other agent frameworks for its focus on being low-level, highly controllable, and highly customizable.

LangGraph 凭借其底层化设计、高度可控性与高度可定制性，在所有智能体框架中独树一帜。

There is nothing built in that restricts the cognitive architectures you can build. The nodes and edges are nothing more than Python functions — you can put whatever you want inside them!

LangGraph 内部没有任何预设限制，不会约束你能构建的认知架构。其中的节点（nodes）与边（edges）本质上只是 Python 函数——你可以自由填入任意逻辑！

Agents are going to heavily feature code as part of their cognitive architecture. Agent frameworks can help remove some of the common infrastructure needs. But they CANNOT restrict the cognitive architecture of your agent. That will impede your ability to communicate what exactly you want to happen and the agent won’t be reliable.

代理将深度整合代码，作为其认知架构的核心组成部分。代理框架可帮助消除部分通用基础设施需求。但它们**绝不能限制**您代理的认知架构——否则将阻碍您精准表达预期行为，导致代理不可靠。

## **Why agent frameworks like LangGraph are here to stay**

## **为何 LangGraph 等代理框架将长期存在**

A somewhat common question I get asked is: “as the models get better, will that remove the need for frameworks like LangGraph?”. The underlying assumption is that the models will get so good that they will remove the need for any code around the LLM.

我常被问到的一个问题略带普遍性：“随着大模型能力不断提升，LangGraph 这类框架是否终将变得不再必要？” 其隐含假设是：模型会强大到足以完全取代围绕大语言模型（LLM）所编写的任何代码。

No.

不。

If you’re using LangGraph to elicit better general purpose reasoning from models, then sure, maybe.

如果您仅用 LangGraph 来激发模型更优的通用推理能力，那或许如此。

But that’s not how most people are using it.

但这并非大多数人的实际用法。

💡

💡

Most people are using LangGraph to build vertical-specific, highly customized agentic applications.

绝大多数人正借助 LangGraph 构建面向垂直领域、高度定制化的代理型应用。

Communication is a key part of that, and code is a key part of communication. Communication isn’t going away, and so neither is code — and so neither is LangGraph.

沟通是这一过程的关键环节，而代码正是沟通的核心载体。只要沟通不可或缺，代码就不可或缺；因此，LangGraph 同样不可或缺。

## Why building agents is a multidisciplinary endeavor

## 为何构建代理是一项跨学科工程

One thing that we noticed quickly is that teams building agents aren’t just made up of engineers.

我们很快注意到的一点是：构建智能体（agent）的团队并不仅仅由工程师组成。

💡

💡

Non-technical subject matter experts also often play a crucial role in the building process.

非技术领域的领域专家（SME）也常常在构建过程中发挥关键作用。

One key area is prompt engineering, where domain experts often write the best natural language instructions for prompts, since they know how the LLM should behave (more so than the engineers).

其中一个关键领域是提示工程（prompt engineering）：由于领域专家比工程师更清楚大语言模型（LLM）应有的行为方式，他们往往能写出最优质的自然语言提示指令。

Yet, the value of domain experts goes beyond prompting. They can review the entire “cognitive architecture” of the agent, to make sure all logic (whether expressed in language or in code) is correct. Tools like [LangGraph Studio](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/), which visualize the flow of your agent, make this process easier.

然而，领域专家的价值远不止于提示编写。他们还能全面审视智能体的“认知架构”（cognitive architecture），确保所有逻辑（无论以自然语言还是代码形式表达）均准确无误。像 [LangGraph Studio](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/) 这类可直观呈现智能体运行流程的工具，让这一审查过程变得更加轻松。

Domain experts can also help debug why an agent is messing up, as agents often mess up because of a failure to communicate - a gap that domain experts are well-equipped to spot.

领域专家还能协助排查智能体出错的原因——因为智能体出错往往源于沟通失效，而这种沟通断层恰恰是领域专家最擅长识别的薄弱环节。

## Why we made LangSmith the most user friendly “LLM Ops” tool

## 为何我们将 LangSmith 打造成最易用的“大语言模型运维（LLM Ops）”工具

Since AI engineering requires multiple teams to collaborate to figure out how to best build with LLMs, an “LLM Ops” tool like LangSmith also focuses on facilitating that type of collaboration. What most of the triaging flow amounts to is – “Look at your data!”, and we want to make looking at large, mostly text responses very easy in LangSmith.

由于 AI 工程需要多个团队协同合作，共同探索如何最优地基于大语言模型（LLM）进行开发，“LLM Ops” 类工具（如 LangSmith）的核心目标之一便是促进此类跨团队协作。当前大多数问题排查（triaging）流程的本质其实就是——“请查看你的数据！”——而我们的目标，就是在 LangSmith 中让查阅海量、以文本为主的响应结果变得极为便捷。

One thing we’ve invested in really heavily from the beginning is a beautiful UI for visualizing agent traces. This beauty serves a purpose - it makes it easier for domain experts of all levels of technical ability to understand what is going on. It communicates so much more clearly what is happening that JSON logs ever would.

从项目伊始，我们就大力投入打造一套精美直观的用户界面，用于可视化智能体的执行轨迹（agent traces）。这份“美”并非仅为赏心悦目，而是承载着明确目的：它能让不同技术背景的领域专家都更容易理解系统正在发生什么；其传达信息的清晰度，远超原始 JSON 日志所能企及。

The visualization of traces within LangSmith allows everyone - regardless of technical ability - to understand what is happening inside the agent, and contribute to diagnosing any issues.

LangSmith 中的追踪可视化功能，使得所有人——无论技术能力如何——都能理解智能体内部正在发生什么，并参与到问题诊断中来。

LangSmith also facilitates this cross team collaboration in other areas - most notably, the prompt playground- but I like to use tracing as an example because it is so subtle yet so important.

LangSmith 还在其他方面促进这种跨团队协作——最显著的是提示词游乐场（prompt playground）——但我倾向于以追踪（tracing）为例，因为它看似细微，实则至关重要。

## Why people have asked us to expose LangSmith traces to their end users

## 为何多家公司要求向终端用户开放 LangSmith 追踪功能

For the same reasons listed above, we have had multiple companies ask to expose LangSmith traces to their end users. Understanding what the agent is doing isn’t just important for developers - it's also important for end users!

出于上述相同原因，已有多家公司提出将 LangSmith 追踪功能向其终端用户开放。理解智能体正在执行什么操作，不仅对开发者至关重要，对终端用户同样重要！

There are other (more user-friendly ways) to do this than our traces, of course. But it is still flattering to hear this request.

当然，实现这一目标还有其他（更面向用户）的方式，不一定非得依赖我们的追踪功能。但听到这样的请求，我们依然深感荣幸。

## Why UI/UX is the most important place to be innovating with AI

## 为何 UI/UX 是 AI 创新最关键的领域

Most of this post has focused on the importance of communication with AI agents when building them, but this also extends to end users. Allowing users to interact with an agent in a transparent, efficient, and reliable way can be crucial for adoption.

本文大部分内容聚焦于构建 AI 智能体时与之沟通的重要性，而这一原则同样适用于终端用户。让用户以透明、高效且可靠的方式与智能体交互，对于产品的采用率而言可能至关重要。

💡

💡

The power an AI application comes down to how well it facilitates human-AI collaboration, and for that reason we think UI/UX is one of the most important places to be innovating.

一款 AI 应用的真正实力，归根结底取决于它在多大程度上促进了人与 AI 的协同合作；正因如此，我们认为 UI/UX 是当前最值得投入创新的关键领域之一。

We’ve talked about different agentic UXs we see emerging ( [here](https://blog.langchain.com/ux-for-agents-part-1-chat-2/), [here](https://blog.langchain.com/ux-for-agents-part-2-ambient/), and [here](https://blog.langchain.com/ux-for-agents-part-3/)), but it’s still super early on in this space.

我们此前已探讨过正在兴起的多种智能体导向的用户体验设计（[此处](https://blog.langchain.com/ux-for-agents-part-1-chat-2/)、[此处](https://blog.langchain.com/ux-for-agents-part-2-ambient/) 和 [此处](https://blog.langchain.com/ux-for-agents-part-3/)），但该领域整体仍处于非常早期的探索阶段。

Communication is all you need, and so UI/UXs that best facilitate this human-agent interaction patterns will lead to better products.

沟通就是一切；因此，最能促进此类人机交互模式的用户界面（UI）与用户体验（UX）设计，将催生更优秀的产品。

## Communication is all you need

## 沟通就是一切

Communication can mean a lot of things. It’s an integral part of the human experience. As agents attempt to accomplish more and more humanlike tasks, I strongly believe that good communication skills will make you a better agent developer — whether it’s through prompts, code, or UX design.

“沟通”一词涵盖广泛，它本就是人类经验中不可或缺的一部分。随着智能体（agents）不断尝试完成越来越多类人的任务，我深信：出色的沟通能力——无论体现于提示词（prompts）、代码还是用户体验设计之中——都将使你成为更优秀的智能体开发者。

Communication is not just expression in natural language, but it can also involve code to communicate more precisely. The best people to communicate something are the ones who understand it best, and so building these agents will become cross-functional.

沟通不仅限于自然语言表达，也可借助代码实现更精准的信息传递。而最擅长传达某一概念的人，往往正是对该概念理解最深刻者；因此，构建这类智能体必将走向跨职能协作。

And I’ll close with a tip from George Bernard Shaw “The single biggest problem in communication is the illusion that it has taken place.” If we want a future in which LLM applications are solving real problems, we need to figure out how to communicate with them better.

最后，引用乔治·伯纳德·肖（George Bernard Shaw）的一句箴言作为结语：“沟通中最大的问题，在于人们误以为沟通已经发生。” 若我们希冀大语言模型（LLM）应用在未来真正解决现实问题，就必须深入探索并切实提升我们与它们之间的沟通效能。

_Thanks to Nuno Campos, Julia Schottenstein, and Linda Ye for reading drafts of this._

_感谢 Nuno Campos、Julia Schottenstein 与 Linda Ye 对本文初稿的审阅。_

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/communication-is-all-you-need/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/communication-is-all-you-need/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪到洞察：规模化理解智能体行为](images/communication-is-all-you-need/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪到洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/communication-is-all-you-need/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用；在 AI 中，追踪记录应用。](images/communication-is-all-you-need/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用；在 AI 中，追踪记录应用。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/communication-is-all-you-need/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排工具——天哪！](images/communication-is-all-you-need/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Reflections on Three Years of Building LangChain](images/communication-is-all-you-need/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/communication-is-all-you-need/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/communication-is-all-you-need/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不。](images/communication-is-all-you-need/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不。**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读
{% endraw %}
