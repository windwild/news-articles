---
title: "OpenAI's Bet on a Cognitive Architecture"
source: "LangChain Blog"
url: "https://blog.langchain.com/openais-bet-on-a-cognitive-architecture/"
date: "2023-11-28"
scraped_at: "2026-03-03T08:23:27.351039386+00:00"
language: "en-zh"
translated: true
---

Three weeks ago OpenAI held a highly anticipated developer day. They released a myriad of new features. The two most interesting to me were the Assistants API and GPTs. To me, these represent the same bet – on a particular, agent-like, closed “cognitive architecture”. They appeal to different end users, but both speak to OpenAI’s ambitions to drive applications towards this particular cognitive architecture. At LangChain, we believe in a world where LLMs power agent-like systems that are truly transformative. However, we believe the route to get there is one where companies have control over their cognitive architectures. You can do that today with projects like [OpenGPTs](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com) \- an open, editable, and configurable version of the Assistants API (and GPTs).

三周前，OpenAI 举办了一场备受期待的开发者大会。他们发布了大量新功能。其中最令我关注的两项是 Assistants API 和 GPTs。在我看来，这两项发布体现的是同一战略押注——即押注于一种特定的、类智能体（agent-like）、封闭式的“认知架构”（cognitive architecture）。它们面向不同的终端用户，但都彰显了 OpenAI 推动各类应用向这一特定认知架构演进的雄心。在 LangChain，我们相信未来的世界将由大语言模型（LLM）驱动真正具有变革性的类智能体系统。然而，我们认为实现这一愿景的路径，应是让企业能够自主掌控其自身的认知架构。如今，你已可通过 [OpenGPTs](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com) 等开源项目实现这一点——这是一个开放、可编辑、可配置的 Assistants API（及 GPTs）实现版本。

## GPTs and the Assistants API

## GPTs 与 Assistants API

Of the two, [GPTs](https://openai.com/blog/introducing-gpts?ref=blog.langchain.com) are probably the more commonly discussed one on the internet. They provide a (largely) no-code way to create your own “GPT”. These GPTs can be customized with custom instructions, custom knowledge, and custom functions. These GPTs seem to be a second attempt at an app store of sorts, following up on Plugins (which - [in Sam Altman's own words](https://matt-rickard.com/chatgpt-plugins-dont-have-pmf?ref=blog.langchain.com) \- did not find product market fit).

二者之中，[GPTs](https://openai.com/blog/introducing-gpts?ref=blog.langchain.com) 可能是目前互联网上讨论最多的。它提供了一种（基本）无需编码的方式，让用户创建专属的“GPT”。这些 GPT 可通过自定义指令、自定义知识库和自定义函数进行个性化配置。从某种意义上说，GPTs 似乎是 OpenAI 对“应用商店”模式的第二次尝试，此前的 Plugins（插件）方案——正如萨姆·阿尔特曼（Sam Altman）本人所言——[未能找到产品市场契合点（PMF）](https://matt-rickard.com/chatgpt-plugins-dont-have-pmf?ref=blog.langchain.com)。

The [Assistants API](https://platform.openai.com/docs/assistants/overview?ref=blog.langchain.com) is the more developer-centric version of this idea. The Assistants API is a stateful API that allows for storage of previous messages, uploading of files, access to built-in tools (code interpreter), and can be used to control other tools (through function calling, where the developer specifies a function to be called, which can then be executed client side).

[Assistants API](https://platform.openai.com/docs/assistants/overview?ref=blog.langchain.com) 则是这一理念更偏向开发者的实现版本。该 API 是一个有状态（stateful）接口，支持存储历史消息、上传文件、调用内置工具（如代码解释器），并可用于控制其他外部工具（通过函数调用机制：开发者预先声明待调用的函数，随后由客户端执行）。

## Cognitive Architectures

## 认知架构

Under the hood, these both represent a similar type of “cognitive architecture”. Here, I use cognitive architecture to describe the orchestration of an LLM application. I first heard this term used by [Flo Crivello](https://twitter.com/Altimor?ref=blog.langchain.com) (creator of [Lindy](https://twitter.com/getlindy?ref=blog.langchain.com), an autonomous agent startup) and think it is a fantastic term.

本质上，二者均体现了一种相似的“认知架构”（cognitive architecture）。此处，“认知架构”指代大语言模型应用的整体编排逻辑（orchestration）。我首次听到这一术语，是在 [Flo Crivello](https://twitter.com/Altimor?ref=blog.langchain.com)（自主智能体初创公司 [Lindy](https://twitter.com/getlindy?ref=blog.langchain.com) 的创始人）的分享中，我认为这是一个极为精妙的表述。

💡

💡

Most interesting LLM applications can be described as context-aware reasoning applications. There are two main components here: (1) how is context provided to the application, (2) how does the application “reason”. Both of these components make up the cognitive architecture of an application.

绝大多数引人入胜的大语言模型应用，均可被描述为“上下文感知的推理型应用”。这类应用包含两大核心要素：（1）上下文如何提供给应用；（2）应用如何进行“推理”。这两大要素共同构成了一个应用的认知架构。

At LangChain, we’ve been thinking about cognitive architectures for a while. In a recent TedAI talk (video yet to be released) I spoke about the different levels of cognitive architectures that we see developers building. These include:

在 LangChain，我们长期致力于认知架构的研究。在最近一场 TedAI 演讲（视频尚未公开发布）中，我探讨了当前开发者正在构建的不同层级的认知架构，主要包括：

1. A single LLM call, only determining the output of the application  
   1. 单次大语言模型调用，仅用于生成应用输出  

2. A chain of LLM calls, still only determining the output of the application  
   2. 多次大语言模型调用组成的链式流程，仍仅用于生成应用输出  

3. Using an LLM as a router, to choose which action (tool, retriever, prompt) to use  
   3. 将大语言模型用作路由控制器，以决定调用何种操作（工具、检索器或提示词）  

4. State machines - using LLMs to route between steps, in some sort of loop, but still with the allowed transition options enumerated in code  
   4. 状态机——利用大语言模型在各步骤间进行路由（通常以循环方式），但所有允许的状态转移路径仍需在代码中显式枚举  

5. Agents - removing a lot of the scaffolding, so that the transition options are wholly determined by the LLM  
   5. 智能体（Agents）——大幅减少人工搭建的框架约束，使状态转移选项完全由大语言模型自主决定

![](images/openai_s-bet-on-a-cognitive-architecture/img_001.png)一张展示我们当前对认知架构（cognitive architectures）心理模型的表格。

![](images/openai_s-bet-on-a-cognitive-architecture/img_001.png)一张展示我们当前对认知架构心理模型的表格。

## Agents

## 智能体（Agents）

Both the Assistants API and GPTs are examples of the “agent” cognitive architecture described above. Sam Altman even used that exact term (”agent”) when announcing them. Although agents can be an overloaded term, used to describe a myriad of different applications, OpenAI’s use of the term largely tracks with our understanding: using the LLM alone to define transition options.

上述“智能体（agent）”认知架构的典型代表，正是 Assistants API 和 GPTs。萨姆·阿尔特曼（Sam Altman）在发布这两项功能时，甚至直接使用了“agent”这一术语。尽管“agent”一词含义已被过度泛化，常被用于描述形形色色的不同应用，但 OpenAI 对该术语的用法与我们的理解基本一致：即**仅依靠大语言模型（LLM）来定义状态转移选项**。

What do applications like this look like in practice? This can best be thought of as a loop. Given user input, this loop will be entered. An LLM is then called, resulting in either a response to the user OR action(s) to be taken. If it is determined that a response is required, then that is passed to the user, and that cycle is finished. If it is determined that an action is required, that action is then taken, and an observation (action result) is made. That action & corresponding observation are added back to the prompt (we call this an “agent scratchpad”), and the loop resets, ie. the LLM is called again (with the updated agent scratchpad).

这类应用在实际中究竟如何运作？最恰当的理解方式是将其视为一个**循环（loop）**：当接收到用户输入后，该循环即被触发；随后调用一次大语言模型（LLM），其输出结果要么是**直接返回给用户的响应**，要么是**需要执行的一个或多个动作（action）**。若判定需生成响应，则将该响应传递给用户，本轮循环即告结束；若判定需执行动作，则立即执行该动作，并获得一个**观测结果（observation，即动作执行后的反馈）**。随后，该动作及其对应的观测结果会被追加至提示词（prompt）中（我们称此为“智能体草稿区（agent scratchpad）”），循环随即重置——即再次调用 LLM（此时 prompt 已更新，包含最新的 agent scratchpad）。

![](images/openai_s-bet-on-a-cognitive-architecture/img_002.png)An overview of an "agent" architecture

![](images/openai_s-bet-on-a-cognitive-architecture/img_002.png)“智能体（agent）”架构概览

At a high level, this is what GPTs are doing. When they call a tool you give them (or a built-in tool like retrieval or code interpreter) you can see a widget on the screen that spins. This represents the action being taken, and the GPT is waiting for an observation. As some point, it just responds with text - no action to be taken - and the loop is finished.

从高层视角来看，这正是 GPTs 所做的工作。当它们调用你提供的工具（或内置工具，如检索器或代码解释器）时，界面上会出现一个旋转的加载小部件（widget）。这表示正在执行某个动作，而 GPT 正在等待相应的观测结果。在某些时刻，它仅输出纯文本响应——无需再执行任何动作——此时整个循环即宣告完成。

The Assistants API is the same. The only difference is that the API doesn’t call the tools for you - unless it is a built in tool like retrieval or code interpreter. Instead, it responds with a certain type of message, telling you which tool(s) should be called (and what the inputs to those tools should be) and then waits for you to call the tools client-side and pass back in the results.

Assistants API 的工作机制与此完全相同，唯一区别在于：**该 API 不会自动为你调用工具**（除非是像检索或代码解释器这样的内置工具）。相反，它会返回一种特定类型的消息，明确告知你应调用哪些工具、以及各工具所需的输入参数；随后，它将等待你**在客户端侧调用这些工具，并将执行结果传回**。

This “agent” cognitive architecture has been evolving over the past year and a half. AI21 Labs released their [MRKL paper](https://www.ai21.com/blog/jurassic-x-crossing-the-neuro-symbolic-chasm-with-the-mrkl-system?ref=blog.langchain.com) over a year and half ago. The [ReAct prompting strategy](https://arxiv.org/abs/2210.03629?ref=blog.langchain.com) (released over a year ago) was a particular type of prompting strategy that enables this type of architecture. We incorporated ReAct in LangChain nearly a year ago, quickly expanding to a more general, zero-shot prompting strategy. [AutoGPT](https://github.com/Significant-Gravitas/AutoGPT/tree/master?ref=blog.langchain.com) burst onto the scene about nine months ago, using this same cognitive architecture but giving it more tools, more persistent memory, and generally larger tasks to accomplish.

这一“智能体（agent）”认知架构在过去一年半中持续演进。AI21 Labs 早在一年半前就发布了其 [MRKL 论文](https://www.ai21.com/blog/jurassic-x-crossing-the-neuro-symbolic-chasm-with-the-mrkl-system?ref=blog.langchain.com)；而 [ReAct 提示策略](https://arxiv.org/abs/2210.03629?ref=blog.langchain.com)（发布于一年前）则是一种专为此类架构设计的提示工程方法。我们于近一年前将 ReAct 引入 LangChain，并迅速拓展为一种更通用的零样本（zero-shot）提示策略。约九个月前，[AutoGPT](https://github.com/Significant-Gravitas/AutoGPT/tree/master?ref=blog.langchain.com) 横空出世，同样基于这一认知架构，但为其配备了更丰富的工具集、更持久的记忆能力，以及更宏大的任务目标。

## The Bet OpenAI is Making

## OpenAI 正在下的赌注

I was very interested to see how heavily OpenAI leaned into agents given that by all accounts this cognitive architecture is not reliable enough for serious applications. They are best positioned out of anyone to make this work - they control the underlying model, after all. But it is still a **bet**. They are betting that over time the issues that plague agents will go away.

我非常关注 OpenAI 在多大程度上押注于“智能体”路线——毕竟据各方评估，这一认知架构目前尚不足以支撑严肃的实际应用。诚然，OpenAI 拥有得天独厚的优势：作为底层模型的掌控者，它最有可能让这一构想真正落地。但即便如此，这仍是一场**豪赌**——他们赌的是：随着时间推移，困扰智能体架构的种种问题终将迎刃而解。

Nearly all of the actually useful “autonomous agents” that we see differ in two key regards.

我们所见到的几乎所有真正实用的“自主智能体”（autonomous agents）都在两个关键方面存在差异。

First, many are actually NOT this “agent” cognitive architecture, but rather either elaborate and complex chains, or more similar to “state machines”. Two great public examples of this are [GPT-Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) and [Sweep.dev](https://sweep.dev/?ref=blog.langchain.com).

首先，其中许多**并非**本文所指的这种“智能体”式认知架构，而更接近于精心设计、高度复杂的**链式流程**（chains），或更类似于“状态机”（state machines）。两个出色的公开案例分别是 [GPT-Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) 和 [Sweep.dev](https://sweep.dev/?ref=blog.langchain.com)。

We wrote at length about GPT-Researcher [multiple](https://blog.langchain.com/gpt-researcher-x-langchain/) [times](https://blog.langchain.com/exploring-uxs-besides-chat-with-research-assistant/), and worked with them last week to release a [LangChain template](https://github.com/langchain-ai/langchain/tree/master/templates/research-assistant?ref=blog.langchain.com). They are one of the few complex LLM powered applications that produce valuable results, but their cognitive architecture is more like a complex chain. If we look at the diagram below, we can see that it flows in one direction. It does a lot of complex steps, but in defined manner: it first generates sub questions, then gets links for each one, then summarizes each link, then combines the summaries into a research report.

我们曾多次深入探讨 GPT-Researcher：[第一次](https://blog.langchain.com/gpt-researcher-x-langchain/)、[第二次](https://blog.langchain.com/exploring-uxs-besides-chat-with-research-assistant/)；上周，我们还与团队合作发布了 [LangChain 模板](https://github.com/langchain-ai/langchain/tree/master/templates/research-assistant?ref=blog.langchain.com)。它是为数不多的、能产出真正有价值结果的复杂大语言模型（LLM）驱动应用之一；但其认知架构更接近一条复杂的链式流程。观察下方示意图即可发现，整个流程呈单向流动：它执行大量复杂步骤，且每一步都严格定义——先生成子问题，再为每个子问题获取相关链接，接着分别总结各链接内容，最后将所有摘要整合成一份研究报告。

![](images/openai_s-bet-on-a-cognitive-architecture/img_003.png)The GPT-Researcher cognitive architecture, taken from their GitHub repo.

![](images/openai_s-bet-on-a-cognitive-architecture/img_003.png)GPT-Researcher 的认知架构图，源自其 GitHub 仓库。

[Sweep.dev](http://sweep.dev/?ref=blog.langchain.com) is another great example. They wrote a [blog](https://docs.sweep.dev/blogs/sweeps-core-algo?ref=blog.langchain.com) over the summer describing their cognitive architecture, including a fantastic diagram.

[Sweep.dev](http://sweep.dev/?ref=blog.langchain.com) 是另一个绝佳范例。今年夏天，他们发布了一篇[博客文章](https://docs.sweep.dev/blogs/sweeps-core-algo?ref=blog.langchain.com)，详细阐述了自身的认知架构，并配有一张极为清晰的示意图。

![](images/openai_s-bet-on-a-cognitive-architecture/img_004.svg)Sweep.dev cognitive architecture, taken from their blog.

![](images/openai_s-bet-on-a-cognitive-architecture/img_004.svg)Sweep.dev 的认知架构图，源自其官方博客。

There are clearly defined transitions and steps. First, a search is done. Then a plan is generated. Then the plan is executed on. There is then a validation step: if it passes, a PR is made and Sweep is done. If it fails, then it makes a new plan. This is a pretty clear state machine, where there are well defined transitions between different states.

整个流程包含明确定义的状态转换与执行步骤：首先执行代码搜索（search），随后生成修复计划（plan），继而执行该计划；之后进入验证环节（validation）：若验证通过，则提交 Pull Request（PR），Sweep 任务即告完成；若失败，则重新生成新计划。这正是一种非常典型的状态机（state machine）——不同状态之间具有清晰、明确的转换逻辑。

Many other builders and teams that we work with have complex chains/state machines powering their applications.

我们合作的众多开发者与团队，其应用系统也普遍由复杂的链式流程或状态机所驱动。

💡

💡

The benefits of these cognitive architectures are simple: **more control**. No two problems are alike and choosing the appropriate cognitive architecture that fits the problem space is critical to delivering a good experience.

此类认知架构的优势十分直接：**更强的可控性**。没有任何两个问题完全相同；针对具体问题域，选择最匹配的认知架构，是交付优质用户体验的关键所在。

For applications that do use something more similar to this agent architecture, they differ from GPTs in another way: how context is provided to the agent.

对于采用更接近此类智能体（agent）架构的应用而言，它们与 GPTs 的另一关键区别在于：**上下文如何提供给智能体**。

I was chatting with Flo Crivello about cognitive architectures and he brought up the point that one difference in the agent architecture is how context is provided to the agent. Remember, the way we describe most of the interesting LLM applications is “context-aware reasoning applications”.

我正与 Flo Crivello 讨论认知架构，他指出：智能体架构的一个差异点，正在于上下文向智能体提供的机制。请记住，我们通常将大多数引人关注的大语言模型（LLM）应用描述为“**具备上下文感知能力的推理应用**”。

💡

💡

Context can either be provided via **pulling** or **pushing**. In most performant and reliable agents, we see a significant amount of context provided by pushing.

上下文的提供方式可分为 **“拉取”（pulling）** 或 **“推送”（pushing）** 两种。在绝大多数高性能、高可靠性的智能体中，大量上下文是通过“推送”方式提供的。

What does it mean for an agent to **pull** context? This means that the agent decides what context it needs, and then asks for it. This generally happens via a tool. As a concrete example, an agent created to interact with a SQL database may need to know what tables are present in the SQL database. So we may give it a tool that returns a list of tables in the database, and it can call that tool at the start.

那么，智能体如何 **“拉取”上下文**？这意味着智能体自主判断自身所需的信息，并主动发起请求获取。这一过程通常借助工具（tool）完成。举一个具体例子：一个用于与 SQL 数据库交互的智能体，可能需要知道数据库中存在哪些数据表；因此，我们可以为其配备一个能返回数据库表名列表的工具，它可在运行起始阶段调用该工具。

In contrast, when context is **pushed** to the language model it is encoded in the logic of an application that a particular piece context should be fetched and pushed into the prompt. In the example of the SQL agent above, this would correspond to automatically fetching the SQL tables ahead of time and inserting them in the prompt.

相比之下，当上下文被 **“推送”** 给语言模型时，其逻辑已内嵌于应用程序中——即由程序预先判定某类特定上下文应被获取，并直接注入提示词（prompt）。以上述 SQL 智能体为例，这相当于在执行前自动获取所有数据库表结构，并将其插入提示词中。

Most applications that do use an agent architecture have a significant amount of pushed context. As one example, the [SQL](https://python.langchain.com/docs/integrations/toolkits/sql_database?ref=blog.langchain.com) and [Pandas](https://python.langchain.com/docs/integrations/toolkits/pandas?ref=blog.langchain.com) agents in LangChain have the table schemas as part of the system message. As another example, [the agent that the Rubrics team](https://blog.langchain.com/how-to-design-an-agent-for-production/) built for [Cal.com](http://cal.com/?ref=blog.langchain.com) has a [significant amount of user information pushed into the prompt](https://github.com/calcom/cal.com/blob/main/apps/ai/src/utils/agent.ts?ref=blog.langchain.com).

目前大多数采用智能体架构的应用，均以“推送”方式提供大量上下文。例如，LangChain 中的 [SQL](https://python.langchain.com/docs/integrations/toolkits/sql_database?ref=blog.langchain.com) 和 [Pandas](https://python.langchain.com/docs/integrations/toolkits/pandas?ref=blog.langchain.com) 智能体，会将数据库表结构作为系统消息（system message）的一部分直接传入；再如，[Rubrics 团队](https://blog.langchain.com/how-to-design-an-agent-for-production/) 为 [Cal.com](http://cal.com/?ref=blog.langchain.com) 构建的智能体，就将[大量用户信息预先推入提示词中](https://github.com/calcom/cal.com/blob/main/apps/ai/src/utils/agent.ts?ref=blog.langchain.com)。

This **push vs pull** of context again gives developers **more control**. It allows us to enforce what context is relevant to the LLM when deciding what to do. Specifically, knowing what context is most relevant, how to fetch that context, and how to provide it are small decisions that can make a big impact on quality and performance.

这种 **“推送”与“拉取”的权衡**，再次赋予开发者**更强的控制力**。它使我们能够主动约束大语言模型在决策过程中所依赖的上下文内容。具体而言，“识别最关键的上下文”、“设计高效的上下文获取方式”以及“选择最优的上下文注入形式”——这些看似微小的设计决策，往往会对应用的质量与性能产生巨大影响。

GPTs - and to an extent, the Assistant API - largely empower applications with an unconstrained agent architecture that rely more on pulling context as needed. This can be great for getting started quickly or for simple tasks, but for more complex use cases, there’s no substitute for controlling the cognitive architecture that suits the problem at hand.

GPTs（以及在一定程度上，Assistant API）主要赋能的是**无约束的智能体架构**，其上下文高度依赖按需“拉取”。这种方式非常适合快速启动或处理简单任务；但对于更复杂的实际场景，唯有精准掌控契合问题本质的认知架构（cognitive architecture），方无可替代。

## Open vs Closed

## 开放式 vs 封闭式

Aside from the choice of cognitive architecture, another notable attribute of Assistants API and GPTs is that the cognitive architecture itself is **closed**. We do not know what is going on under the hood. We do not know the exact algorithm. We do not know what is being done to manage the context of the chat history. We do not know what is being done for retrieval.

除了认知架构的选择之外，Assistants API 和 GPTs 的另一显著特点是其认知架构本身是**封闭的**。我们无从知晓其内部运行机制；不清楚其确切算法；不了解聊天历史上下文管理的具体实现方式；也不了解检索环节的具体操作。

Right now we can make guesses at both of those. However, as they add more and more, and it gets more and more complex, it will become more and more of a black box.

目前，我们只能对这两方面进行推测。然而，随着功能不断叠加、系统日益复杂，它将愈发成为一个“黑箱”。

💡

💡

Much of the [discourse around open-source vs closed-source](https://x.com/JosephJacks_/status/1728510229133119644?s=20&ref=blog.langchain.com) revolves around the models themselves. But there is another element to consider: **open-source cognitive architectures vs closed-source cognitive architectures.**

当前围绕开源与闭源的大量讨论（[参见此处](https://x.com/JosephJacks_/status/1728510229133119644?s=20&ref=blog.langchain.com)）聚焦于大语言模型本身。但还有一个不容忽视的维度：**开源认知架构 vs 闭源认知架构**。

Over time, I bet this will become a larger discussion topic than the models themselves. A year ago, most of the new features (and I would bet most of the focus internally) was on better models. Now, it seems to be a 50/50 split between core model improvements versus figuring out how best to hook them up in an agentic manner. As more evidence of the importance of this, [Karpathy’s Twitter feed](https://twitter.com/karpathy?ref=blog.langchain.com) (the definitive reading list for all things AGI) is shifting more and more towards this idea of the LLM as an OS. Over this past weekend, he released a [fantastic video](https://www.youtube.com/watch?v=zjkBMFhNj_g&ref=blog.langchain.com) on exactly that.

长远来看，我确信这一议题将比模型本身引发更广泛的讨论。一年前，绝大多数新功能（以及我推测内部研发的重点）都集中在提升模型性能上；而如今，研发重心似乎已趋于均分：一半投入核心模型的改进，另一半则致力于探索如何以“智能体化”（agentic）方式最优地集成和调用这些模型。越来越多的迹象表明这一方向的重要性——例如，[Andrej Karpathy 的 Twitter 主页](https://twitter.com/karpathy?ref=blog.langchain.com)（被公认为通用人工智能（AGI）领域最权威的信息来源）正日益转向“将大语言模型视为操作系统（LLM-as-an-OS）”这一理念。就在上个周末，他发布了一段[极为精彩的视频](https://www.youtube.com/watch?v=zjkBMFhNj_g&ref=blog.langchain.com)，主题正是此观点。

I fully expect this trend to continue, and OpenAI (and perhaps other labs) to invest more in platform and tooling around models, rather than just models themselves. The way to AGI is not (just) in better models - it’s also in hooking them up to their surroundings. As the focus of these labs shift, I expect - and hope - the discourse around open vs closed will happen not just models but also for cognitive architectures.

我完全预期这一趋势将持续深化：OpenAI（或许还有其他研究实验室）将把更多资源投向围绕模型构建的平台与工具链，而不再仅限于模型本身。通往通用人工智能（AGI）的道路，不仅在于打造更优的模型，更在于让模型与其所处环境深度连接、协同运作。随着这些实验室研发重心的转移，我期待——也衷心希望——关于“开源 vs 闭源”的讨论，将不再局限于模型层面，而同样延伸至认知架构层面。

## Do Cognitive Architectures Make Your Beer Taste Better?

## 认知架构能让您的啤酒口感更佳吗？

There’s a great quote from Jeff Bezos that says to [only do what makes your beer taste better](https://blog.weaverse.io/make-your-beer-taste-better?ref=blog.langchain.com). This refers to early industrial revolution, when breweries were also making their own electricity. A breweries ability to make good beer doesn’t really depend on how differentiated their electricity was - so those that outsourced electricity generation and focused more on brewing jumped to an advantage.

杰夫·贝索斯有一句广为流传的名言：“只做能让您的啤酒口感更佳的事。”（[参见此处](https://blog.weaverse.io/make-your-beer-taste-better?ref=blog.langchain.com)）这句话源自工业革命早期：当时许多啤酒厂还自行发电。但一家啤酒厂酿出好啤酒的能力，其实并不取决于其自发电技术是否独特——因此，那些将发电业务外包、转而专注酿酒工艺的厂商，反而迅速占据了竞争优势。

Is the same true of cognitive architectures? Does having control over your cognitive architecture really make your beer taste better? At the moment, I would argue strongly the answer is yes, for two reasons. First: it’s very difficult to make complex agents actually function. If your application relies on agents working, and getting agents to work is challenging, then almost by definition if you can do that well you’ll have an advantage over your competition. The second reason is that we often see the value of GenAI applications being really closely tied to the performance of the cognitive architecture. A lot of current companies are selling agents for coding, agents for customer support. In those cases, the cognitive architecture IS the product.

那么，认知架构是否也遵循同样的逻辑？掌控自身的认知架构，真的能让您的“啤酒”口感更佳吗？目前，我坚定地认为答案是肯定的，理由有二：  
第一，构建真正可用的复杂智能体（agents）极其困难。倘若您的应用高度依赖智能体的稳定运行，而智能体的开发与调试本身又充满挑战，那么——几乎可视为定义使然——只要您能在此领域做到卓越，便天然拥有超越竞争对手的优势。  
第二，生成式 AI（GenAI）应用的价值，往往与认知架构的性能紧密绑定。当前大量公司正在销售面向编程的智能体、面向客户服务的智能体等产品；在这些场景中，**认知架构本身就是产品本身**。

That last reason is also the reason that I find it hard to believe that companies would be willing to lock into a cognitive architecture controlled by a single company. I think this is different form of lock-in than cloud or even LLMs. In those cases, you are using cloud resources and LLMs in order to build or power a particular application. But if a cognitive architecture moves closer and closer to being a full application by itself - you’re unlikely to want to have that locked in.

上述第二点，也正是我难以相信企业会甘愿被某一家公司所控制的认知架构“锁定”的原因。我认为，这种锁定形式与云服务或甚至大语言模型（LLMs）的锁定存在本质区别：在后两种情形中，您只是将云资源或大语言模型作为构建或驱动某一特定应用的工具；但若认知架构自身正日益演变为一个完整的、端到端的应用系统——那么，您几乎不可能愿意接受这种锁定。

## How LangChain fits in

## LangChain 的定位与作用

At LangChain, we believe in a world where LLMs power agent-like systems that are truly transformative. However, we believe the route to get there is one where companies have control over their cognitive architectures.

在 LangChain，我们相信未来将是一个由大语言模型（LLM）驱动类智能体（agent-like）系统、并真正实现变革的世界。然而，我们认为通往这一愿景的路径，是让企业能够完全掌控自身的认知架构。

💡

💡

From everything we’ve seen with working with teams shipping LLM-powered applications, it is really really hard to get agent-like systems working reliably. You can make demos with a general agent architecture, and maybe simple toy apps. But when it comes time to increase performance and run at scale, you NEED to customize it to your application and your use case.

根据我们与众多正在交付 LLM 应用的团队合作所积累的经验，构建稳定可靠的类智能体系统极其困难。你或许能基于通用智能体架构快速搭建演示原型，甚至开发出简单的玩具应用；但一旦需要提升性能、实现规模化部署，你就**必须**针对自身业务场景和具体应用进行深度定制。

This takes a lot of engineering work. We’re building tools to help with that. With [LCEL](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com) we have a flexible way to compose chains together. With LangChain we have [over 600 integrations](https://integrations.langchain.com/?ref=blog.langchain.com) allowing for full flexibility in what model/vectorstore/database you use. With [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) we’ve explicitly focused on having the best debugging experience possible (because that’s where most teams are) but we’ve also adding in management tools (regression testing, monitoring, data annotation, prompt hub) to help you manage these systems as you to go production.

这需要大量工程投入。为此，我们正持续构建一系列工具来支持这项工作：  
- 借助 [LCEL](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)，我们提供了一种灵活的链式（chain）编排方式；  
- LangChain 自身已支持 [600 多种集成](https://integrations.langchain.com/?ref=blog.langchain.com)，让你可自由选用任意模型、向量数据库（vectorstore）或传统数据库；  
- [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 则明确聚焦于提供业界最佳的调试体验（因为绝大多数团队正卡在此处），同时我们也集成了多项管理能力——包括回归测试、运行监控、数据标注以及提示词中心（prompt hub）——助力你将这些系统顺利推向生产环境。

We’ve also recently released [OpenGPTs](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com). This is an attempt to recreate the same experience as the Assistants API as well as GPTs (our implementation of GPTs is just a simple UI over the Assistants API). This is open sourced, currently configurable with four different model providers, and the exact retrieval method used can be easily modified.

我们近期还发布了 [OpenGPTs](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com)。该项目旨在复现 OpenAI Assistants API 及 GPTs 的使用体验（我们的 GPTs 实现本质上是在 Assistants API 基础上封装的一层简洁 UI）。该项目完全开源，当前支持配置四种不同大模型提供商，并且其底层检索机制也可轻松定制与替换。

This is just the start.

这一切，才刚刚开始。