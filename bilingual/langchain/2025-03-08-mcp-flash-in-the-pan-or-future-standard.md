---
title: "MCP: Flash in the Pan or Future Standard?"
source: "LangChain Blog"
url: "https://blog.langchain.com/mcp-fad-or-fixture/"
date: "2025-03-08"
scraped_at: "2026-03-03T07:38:18.004091778+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---

_Model Context Protocol (MCP) is creating quite the stir on Twitter – but is it actually useful, or just noise? In this back and forth, Harrison Chase (LangChain CEO) and Nuno Campos (LangGraph Lead) debate whether MCP lives up to the hype._

_模型上下文协议（Model Context Protocol，简称 MCP）最近在 Twitter 上引发热议——但它究竟是真正有用，还是仅仅是一阵喧嚣？在这场来回交锋中，LangChain 首席执行官 Harrison Chase 与 LangGraph 负责人 Nuno Campos 就 MCP 是否名副其实展开了辩论。_

**_Harrison:_** I’ll take the position that MCP is actually useful. I was skeptical on it at first, but I’ve begun to see its value. Essentially: **MCP is useful when you want to bring tools to an agent you don’t control.**

**_哈里森：_** 我持“MCP 确实有用”的立场。起初我对它持怀疑态度，但如今已逐渐认识到其价值。核心在于：**当您希望为一个您无法控制的智能体（agent）引入工具时，MCP 就派上了用场。**

Let me give an example. For Claude Desktop, Cursor, Windsurf - as a user, I don’t control the underlying agent. That agent has access to a few built-in tools.

让我举个例子。以 Claude Desktop、Cursor 和 Windsurf 为例——作为用户，我无法控制其底层智能体；该智能体仅能访问若干内置工具。

But what if I want to give it access to a tool that it doesn’t have by default? In order to do that, there needs to be some protocol that exists – otherwise how would it know how to call the tool?

但如果我想让它调用某个默认未提供的工具呢？这就需要某种协议的存在——否则它根本不知道该如何调用该工具。

I believe this will be useful for non-developers to create agents as well. One of the trends we are seeing is the people want to make agent building accessible to subject matter experts, regardless of their technical expertise. I think these builders will rarely want to (or be able to) edit the agent logic itself - but they will want to give it access to certain tools. MCP will be useful here.

我认为，这对非开发者构建智能体同样具有价值。当前一个明显趋势是：人们希望让领域专家（subject matter experts）也能轻松构建智能体，无论其技术背景如何。而这类构建者通常既不愿（也往往无法）直接修改智能体自身的逻辑，却非常希望赋予其特定工具的调用能力。MCP 正好适用于这一场景。

**_Nuno:_** I think you’re underestimating the degree to which the rest of the agent needs to be tailored to the tools you give it access to. Sure, if Windsurf (god forbid) ships with a crappy web search tool and you want to replace it with a good one, that will work. But that’s not a real use case.

**_努诺：_** 我认为你低估了智能体其余部分需针对所接入工具进行深度适配的程度。诚然，如果 Windsurf（但愿不会如此）出厂自带一个糟糕的网页搜索工具，而你想用一个优质工具将其替换，这种情形下 MCP 确实可行。但这并非典型的实际应用场景。

The compelling use case – the one where you give Cursor new capabilities even its creators didn’t dream of by just injecting your one magical tool – won’t actually work most of the time in practice. In pretty much all production agents I’ve seen, you need to tailor the system message and even other parts of the architecture to the tools you make available.

真正令人振奋的应用场景——即仅凭注入你那“神奇工具”，就为 Cursor 赋予连其开发者都未曾设想的新能力——在现实中绝大多数情况下并不可行。据我所见，几乎所有投入生产的智能体，都需要针对所开放的工具，专门定制系统提示词（system message），甚至调整架构中的其他部分。

**_Harrison:_** Well, these agents might not be 99% reliable... but they can probably still be good enough to be useful? Tool descriptions and instructions definitely matter! But we also know:

**_哈里森：_** 嗯，这些智能体或许达不到 99% 的可靠性……但它们很可能仍足以发挥实用价值？工具描述与使用说明当然至关重要！但我们同时也清楚：

1. MCP has tool definitions - and the good MCP servers will probably have better tool descriptions than you would write quickly.  
   1. MCP 提供了工具定义——而优质的 MCP 服务器所提供的工具描述，很可能远胜于你仓促撰写的版本。

2. MCP allows for prompts - so you can include instructions.  
   2. MCP 支持嵌入提示词（prompts），因此你可将具体指令一并纳入。

3. The off-the-shelf tool calling agent will get way better as the underlying models get better.  
   3. 随着底层大模型能力持续提升，开箱即用的工具调用智能体也将显著增强。

I don’t think anyone is going to build the next Cursor based solely on MCP integrations and a tool calling agent, but surely there is some value there? Internal or personal agents, for example.

我不认为会有人单靠 MCP 集成与一个通用工具调用智能体，就打造出下一代 Cursor；但其中的价值难道不显而易见吗？例如，用于企业内部或个人用途的智能体。

**_Nuno:_** Well, our own tool calling benchmarks show that current models fail to call the right tool about half the time – and this is in agents with architecture and prompts tailor-made for that exact set of tools. Even a personal agent that fails half the time is not terribly useful…

嗯，我们自己开展的工具调用基准测试显示，当前模型约有一半的时间无法正确调用所需工具——而这些测试所用的智能体（agents）其架构与提示词（prompts）均是专为该组工具量身定制的。即便是一个个人智能体，若失败率高达50%，其实际效用也相当有限……

And yes, models will get better – but so will user’s expectations. Don’t take my word for it, take it from Bezos: “One thing I love about **_customers_** is that they are divinely discontent. Their **_expectations_** are never static – they go up. It's human nature.”

当然，模型性能会持续提升——但用户的期望值同样水涨船高。别只听我这么说，不妨听听贝索斯（Bezos）的原话：“我特别欣赏**_客户_**的一点，就是他们天生就永不满足。他们的**_期望_**从不静止不变——只会不断攀升。这正是人性使然。”

If you own the entire stack – UI, prompts, architecture, tools – you can actually deliver on those expectations. Otherwise, good luck.

如果你能掌控整条技术栈——包括用户界面（UI）、提示词、系统架构和工具集——你才真正有能力兑现这些日益增长的期望。否则，祝你好运。

**_Harrison:_** Models will continue to get better - I’m comfortable betting on that. So whatever the success rate of agents now, it will only go up.

**_哈里森：_** 模型性能将持续提升——我对此充满信心。因此，无论当前智能体的调用成功率是多少，未来都只会越来越高。

I don’t think the right comparison is comparing an agent I could build with MCP to a polished agent with those tools. I think real value will come in the long tail of connections and integrations I want to make.

我认为，恰当的比较方式并非将“我用 MCP 构建的智能体”与“已针对这些工具深度优化的成熟智能体”直接对比。真正的价值，将体现在那些长尾场景中——即我想要建立的各类连接与集成。

Like Zapier, it’s about connecting email to Google Sheets, Slack, etc. There’s an infinite number of workflows I could create, and there likely won’t be a polished agent for each one of them. With MCP, I can create my own versions of them.

就像 Zapier 那样，核心在于打通电子邮件与 Google Sheets、Slack 等各类服务。我能创建的工作流数量近乎无限，而其中绝大多数几乎不可能有厂商专门为其打造一个“打磨完毕”的智能体。借助 MCP，我便能自主构建属于自己的定制化版本。

What do you think of the Zapier analogy?

你如何看待这个 Zapier 类比？

**_Nuno:_** At LangChain, we’ve had a library of 500 tools for two years, and I haven’t seen them used often in production. They were all implemented to the same “protocol”, compatible with any model, and swappable. So what’s the difference here – is it the amazing MCP form factor of having to run a million servers in my terminal locally and only being compatible with desktop apps? That doesn’t sound like a plus to me. Honestly, I do think Zapier is the upper bound on MCP potential.

**_努诺：_** 在 LangChain，我们已维护一个包含 500 个工具的工具库达两年之久，但我并未看到它们在生产环境中被频繁使用。这些工具均遵循统一的“协议”实现，可兼容任意大语言模型，且彼此可互换。那么，MCP 的差异究竟在哪里？难道就在于它那“惊艳”的形态——要求我在本地终端中运行数以百万计的服务，并且仅支持桌面端应用？这在我眼中可算不上什么优势。坦白讲，我认为 Zapier 才真正代表了 MCP 潜力的上限。

**_Harrison:_** I think the difference between LangChain tools and MCP tools is that MCP is not for developers of the agent. They are most useful when bringing tools to an agent you **can’t** develop.

**_哈里森：_** 我认为 LangChain 工具与 MCP 工具的关键区别在于：MCP 并非面向智能体开发者设计；它的最大价值，恰恰体现在将工具接入你**无法自主开发**的智能体之中。

To be clear - if I was writing an agent to do XYZ - there is zero chance I would use MCP. But I don’t think that is the target use case for MCP. MCP is bringing tools to an agent you don’t control. It also enables non-developers to bring tools to agents (while LangChain tools are developer focused). There are **many more non-developers** than developers.

需要明确的是——如果我自己正在编写一个用于执行 XYZ 任务的智能体，那么我**绝不会**选用 MCP。但这恰恰说明：MCP 的目标用户并非此类开发者。MCP 的使命，是让工具能够接入你**无法控制**的智能体。此外，它还能赋能**非开发者**将工具接入智能体（而 LangChain 工具则纯粹面向开发者）。要知道，**非开发者的人数远超开发者**。

As for the current MCP form factor? Yeah, it sucks. But its going to get better, right? I’m imagining a future state of MCP, where you one-click install MCP apps (no more running servers in terminal locally) and they're accessible on web apps. I would bet that is where MCP is headed.

当前的 MCP 形态如何？是的，它确实很糟糕。但情况总会变好吧？我设想中的未来版 MCP 是这样的：用户只需单击一次即可安装 MCP 应用（再也不用在本地终端中手动运行服务器），且这些应用可通过网页直接访问。我敢打赌，这正是 MCP 的发展方向。

What do you think MCP needs to change, and would that be enough to convince you they are useful?

您认为 MCP 还需要做出哪些改变？这些改变是否足以让您信服：MCP 确实有用？

**_Nuno:_** Okay, so MCP needs to become more like OpenAI’s Custom GPTs, and that’s when the current hype will be justified. But Custom GPTs aren’t that popular either. So what gives – what was missing in GPTs that MCP has?

**_努诺（Nuno）：_** 好吧，那么 MCP 需要变得更像 OpenAI 的自定义 GPT（Custom GPTs），届时当前的热潮才真正名副其实。但事实上，自定义 GPT 本身也并未真正流行起来。那么问题来了——GPTs 缺失了什么，而 MCP 却恰好拥有？

**_Harrison:_** I mean, MCP is more like Plugins, which also didn’t succeed 🙂 I kind of forget the Plugin experience (not sure I ever used it) so any comparisons I make may be off. But I would argue:

- The ecosystem of MCP is far greater already than the ecosystem of plugins  
- The models have gotten better and more capable of using these tools

**_哈里森（Harrison）：_** 我的意思是，MCP 更像是当年的 OpenAI 插件（Plugins）——而插件同样未能成功 🙂 我甚至已淡忘了插件的实际使用体验（不确定自己是否真的用过），因此我所做的任何类比都可能不够准确。不过，我仍想指出以下两点：

- MCP 的生态体系目前已远超插件生态；  
- 大模型能力已显著提升，对这类工具的调用与整合也愈发得心应手。

**_Nuno:_** Well, I don’t know if that the ecosystem is larger. Some [random directory](https://glama.ai/mcp/servers?ref=blog.langchain.com) I found in 5 seconds lists 893 servers at the time of writing. I think you might be counting number of tweets in your timeline mentioning MCP instead of actual things built with it 🙂 But returning to your unanswered question, in my opinio, if MCP is ever to become more than a footnote in the history of AI, it needs to:

- **Become less complicated.** Why does a tool protocol need to also serve prompts and LLM completions?  
- **Become easier to implement.** Why does a protocol to serve tools need to have two-way communication? Yes, I’ve read all the reasons they list, and no, sorry, receiving logs from the server is not a good enough reason.  
- **Become usable on a server**. A stateless protocol is key for this – just because we’re building with LLMs doesn’t mean we should forget all the hard earned lessons of scaling stuff online. And once usable on a server, a number of other issues pop up, like auth (which isn’t easy to solve in a distributed way).  
- **Make up for the quality hit** that comes from plugging in random tools into an agent that knows nothing about them.

**_努诺（Nuno）：_** 嗯，我不确定其生态规模是否真的更大。我仅用 5 秒就搜到一个[随机目录](https://glama.ai/mcp/servers?ref=blog.langchain.com)，撰写本文时该目录列出了 893 个 MCP 服务端。我想，您统计的或许不是实际构建出的 MCP 应用数量，而是推特时间线上提及 MCP 的推文条数 🙂 不过，回到您尚未回答的问题——依我之见，若 MCP 想超越“AI 发展史上的一个注脚”，它必须做到以下几点：

- **大幅简化设计复杂度。** 一种工具协议，为何还需同时承担提示词（prompt）分发与大语言模型（LLM）补全响应的功能？  
- **显著降低实现门槛。** 一种用于提供工具服务的协议，为何必须支持双向通信？是的，我已通读他们列出的所有理由；但抱歉，仅凭“需从服务端接收日志”这一条，并不足以构成充分理由。  
- **真正适配服务端部署。** 无状态（stateless）协议是实现该目标的关键——我们虽正基于大语言模型构建系统，却绝不能因此遗忘多年来在线系统规模化实践中积累的宝贵经验。一旦实现服务端可用，一系列新问题也将随之浮现，例如身份认证（auth）——而在分布式架构下，这恰恰是一个极难妥善解决的问题。  
- **弥补质量损失。** 当把大量互不相干的工具随意接入一个对其一无所知的智能体（agent）时，必然导致整体输出质量下降；MCP 必须设法弥补这一损失。

**_Harrison:_** You're probably right that I have some recency bias from my Twitter timeline. But there’s also a lot of skepticism on there as well!

So, let’s turn it back to them. Cast your vote at the Twitter poll below - is MCP a flash in the pan or future standard?

**_哈里森（Harrison）：_** 您说得没错，我的判断很可能受到了推特时间线近期信息的干扰（即“近因偏差”）。但事实上，那上面同样充斥着大量质疑声音！

那么，让我们把问题抛还给社区。请参与下方推特投票——MCP 究竟是昙花一现，还是未来标准？

> ❓MCP — 昙花一现，还是未来标准？  
>  
> MCP 近期热度高涨。[@hwchase17](https://twitter.com/hwchase17?ref_src=twsrc%5Etfw&ref=blog.langchain.com) 与 [@nfcampos](https://twitter.com/nfcampos?ref_src=twsrc%5Etfw&ref=blog.langchain.com) 展开辩论，探讨 MCP 是否具备长期生命力。内容涵盖：  
>  
> \- MCP 的典型应用场景  
>  
> \- 与 OpenAI 插件（Plugins）的对比分析  
>  
> \- MCP 当前存在的主要局限性  
>  
> 完整辩论原文请见：[https://t.co/n1ZDzMHRWe](https://t.co/n1ZDzMHRWe?ref=blog.langchain.com)  
>  
> 请在下方投票：  
>  
> — LangChain (@LangChainAI) [2025 年 3 月 8 日](https://twitter.com/LangChainAI/status/1898410721215750487?ref_src=twsrc%5Etfw&ref=blog.langchain.com)

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/mcp-flash-in-the-pan-or-future-standard/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![关于智能体框架与智能体可观测性](images/mcp-flash-in-the-pan-or-future-standard/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/mcp-flash-in-the-pan-or-future-standard/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪数据到深度洞察：规模化理解智能体行为](images/mcp-flash-in-the-pan-or-future-standard/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/mcp-flash-in-the-pan-or-future-standard/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码即文档；在人工智能中，追踪数据即文档。](images/mcp-flash-in-the-pan-or-future-standard/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用；在 AI 中，追踪（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/mcp-flash-in-the-pan-or-future-standard/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排工具——天哪！](images/mcp-flash-in-the-pan-or-future-standard/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/mcp-flash-in-the-pan-or-future-standard/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/mcp-flash-in-the-pan-or-future-standard/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/mcp-flash-in-the-pan-or-future-standard/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不。](images/mcp-flash-in-the-pan-or-future-standard/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不。**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟