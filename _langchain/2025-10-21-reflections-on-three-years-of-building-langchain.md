---
title: "Reflections on Three Years of Building LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/three-years-langchain/"
date: "2025-10-21"
scraped_at: "2026-03-03T07:22:22.750427816+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes", "![Deep Agents", "**Deep Agents**"]
---
{% raw %}

_by Harrison Chase_

_by 哈里森·蔡斯_

Almost exactly 3 years ago, I pushed the first lines of code to `langchain` as an open source package. There was no company at the time, and no grand plan for what the project would become.

差不多整整三年前，我将 `langchain` 的首批代码作为开源软件包推送到 GitHub。彼时尚无公司实体，亦无关于该项目未来发展的宏大蓝图。

A month later, ChatGPT launched, and everything for `langchain` changed. It quickly gained steam as the default way to build your own LLM-powered apps. Over the past three years the industry has matured past prototyping chatbots toward productionizing agents that do things, and `langchain` has evolved into LangChain, the company.

一个月后，ChatGPT 正式发布，`langchain` 的发展轨迹由此彻底改变。它迅速成为构建自有大语言模型（LLM）驱动应用的默认选择。过去三年间，整个行业已从初步尝试聊天机器人原型，迈向将具备实际执行能力的智能体（agents）投入规模化生产；而 `langchain` 也由此演进为一家正式公司——LangChain。

Our product offerings have expanded, too: from a single Python open source package to a multi-language agent ecosystem consisting of multiple popular open source packages and a separate commercial platform (LangSmith). Our technologies power leading companies' agents like Rippling, Vanta, Cloudflare, Replit, Harvey, and thousands more.

我们的产品体系也随之不断拓展：从最初单一的 Python 开源包，发展为覆盖多编程语言的智能体生态系统，包含多个广受欢迎的开源项目，以及一个独立的商业化平台（LangSmith）。我们的技术正为 Rippling、Vanta、Cloudflare、Replit、Harvey 等行业领军企业的智能体提供底层支撑，服务客户已逾数千家。

Today, we’re announcing a $125 million funding round at a $1.25 billion valuation to continue that trajectory, expand LangSmith, the platform for agent engineering, and grow our open source contributions. We wrote more about our vision for LangSmith and what else we’re launching today in our [announcement blog](https://blog.langchain.com/series-b).

今天，我们宣布完成新一轮 1.25 亿美元融资，公司估值达 12.5 亿美元。本轮融资将用于延续当前发展势头，进一步拓展 LangSmith——这一面向智能体工程（agent engineering）的开发平台，并持续加大我们在开源领域的投入与贡献。关于 LangSmith 的愿景，以及我们今日发布的其他新动向，我们已在[官方公告博客](https://blog.langchain.com/series-b)中做了更详尽的阐述。

With such a large funding announcement (and on the eve of the third anniversary of the initial `langchain` launch), I also want to take the time to share my perspective on how agents have evolved over the past three years, how we’ve kept pace, worked to address fair feedback on the original `langchain`, and where the company is headed.

值此大规模融资官宣之际（恰逢 `langchain` 首次发布三周年前夕），我也愿借此机会分享自己对过去三年智能体演进历程的观察：我们如何紧跟趋势、积极回应早期 `langchain` 所获的合理反馈，以及公司未来的发展方向。

## **Starting as a side project**

## **始于个人副业项目**

`langchain` was launched as a single (800 line long?) python package in fall of 2022 out of my personal github `hwchase17`. It was a side project. I was inspired by going to meetups and running into a few folks on the bleeding edge, building some experimental stuff with language models. I was instantly fascinated by the technology but cannot claim to have had any idea how big LLMs would become. I saw a few common patterns in terms of how people were building and put those patterns into `langchain`.

`langchain` 于 2022 年秋季以一个（约 800 行？）Python 包的形式，从我个人 GitHub 账号 `hwchase17` 首次发布。它最初只是一个副业项目。当时我常参加各类技术交流活动，结识了几位处于前沿探索阶段的开发者，他们正利用语言模型开展一些实验性构建。我立刻被这项技术深深吸引，但坦白说，彼时我完全无法预见大语言模型（LLMs）日后会发展得如此之大、影响如此之广。我注意到开发者们在实践中呈现出若干共性模式，于是便将这些模式提炼并融入了 `langchain`。

After the initial launch, I kept on iterating on it, adding mainly two things: (1) more integrations to various LLMs, vector DBs, etc; (2) more high-level “templates” for getting started with RAG, SQL question answering, extraction, etc in 5 lines of code. A lot of `langchain` in the early days was experimenting with prompting techniques, and we were figuring things out alongside everyone else building in the space.

首次发布之后，我持续对其进行迭代，主要增加了两类功能：（1）与更多大语言模型（LLMs）、向量数据库（vector DBs）等系统的集成；（2）一系列高级“模板”，让用户仅用 5 行代码即可快速启动 RAG、SQL 自然语言查询、信息抽取等典型任务。`langchain` 早期的大量工作聚焦于提示词（prompting）技术的实验探索——我们与所有该领域的建设者一样，在摸索中共同前行。

In addition to needing lots of integrations, it was clear from the beginning that there would be lots of options for LLMs. Especially in a dynamic industry, helping users pick a model and later change that decision was incredibly important. Model neutrality still remains one the main benefits of our products.

除需支持海量集成外，我们从一开始就清楚地意识到：大语言模型的选择将极为丰富。尤其在这样一个快速演进的行业中，协助用户做出初始模型选型，并在未来灵活更换模型，至关重要。模型中立性（model neutrality）至今仍是我们的核心产品优势之一。

## **Forming a company**

## **成立公司**

As the space (and `langchain`) exploded, I started working more closely with Ankush, my cofounder (and a much better engineer than me). We started to get the inklings of what would drive us to start a company and that early inspiration is still what we're focused on today:

随着大模型应用生态（以及 `langchain`）迅猛发展，我开始与联合创始人 Ankush（一位远比我出色的工程师）展开更紧密的合作。我们逐渐萌生了创办一家公司的想法，而这一早期灵感，至今仍是我们的核心使命：

LLMs are this great, transformational new technology. They are even more powerful when connected to external data and APIs. We call these systems agents. And it turns out building _reliable_ agents is quite hard! When there is so much promise, but it’s difficult to realize the vision, there's a massive opportunity to help. We were (and still are) determined to build the best tools to help others build reliable agents. We know what some of the needed tools are, and we don’t yet know what others will be. Our goal is to figure out what the agents of the future look like, and then build tools to help make them real.

大语言模型（LLM）是一项卓越且具有变革意义的新兴技术；当它们与外部数据和 API 相连时，能力更加强大。我们将这类系统称为“智能体（agents）”。然而，构建**可靠的**智能体却异常困难！当一项技术蕴含巨大潜力，却难以真正落地实现其愿景时，其中便蕴藏着巨大的赋能机遇。我们当时（并持续至今）决心打造最优秀的工具，助力他人构建可靠的智能体。我们已明确部分所需工具，但仍有诸多工具尚待探索。我们的目标是：先构想出未来智能体应有的形态，再开发相应工具，助其实现。

We started the company in February 2023 knowing that `langchain` was just the first tool we would build.

我们于 2023 年 2 月正式创立公司，并深知 `langchain` 只是我们将要打造的第一款工具。

## **Launching LangSmith**

## **发布 LangSmith**

The biggest problem we saw facing developers was that these LLM systems had quality problems. LLM calls kept on messing up, largely because they had the wrong context. In order to make them more reliable, you needed observability into the context going into the LLMs, and a way to test that once you modified that context it actually led to improvements.

我们观察到开发者面临的最大难题，是这些 LLM 系统存在质量缺陷：LLM 调用频频出错，主要原因在于输入了错误的上下文。为提升系统可靠性，开发者亟需对输入至 LLM 的上下文具备可观测性，同时需要一种机制，在修改上下文后能验证其是否真正带来了效果提升。

LangSmith was our answer to this problem – observability and evals for LLM systems, and we went live with a beta in summer of 2023. Notably, we made LangSmith completely separate from `langchain`. We recognized that the space was very early and that a tool like LangSmith was much needed, so we committed to building LangSmith to be best-in-class, regardless of the framework (or lack of framework) that a developer used. LangSmith is neutral to the LLM and neutral to the underlying framework, adding to our open and composable philosophy of tooling.

LangSmith 正是我们对此问题的回应——专为 LLM 系统设计的可观测性与评估（evals）平台。我们于 2023 年夏季推出 LangSmith 公测版。尤为关键的是，我们将 LangSmith 完全独立于 `langchain` 进行开发。我们认识到，该领域尚处早期，像 LangSmith 这样的工具需求极为迫切；因此，我们坚定承诺：无论开发者使用何种框架（甚至无框架），LangSmith 都将致力于成为业界标杆。LangSmith 对底层大语言模型保持中立，也对所依赖的基础框架保持中立，进一步践行了我们开放、可组合（composable）的工具设计理念。

## **Launching LangGraph**

## **发布 LangGraph**

Around the summer of 2023, we started to get a lot of negative feedback about `langchain`. Some problems we could fix: like preventing breaking changes, making hidden prompts explicit, package bloat, dependency conflicts, outdated documentation. But one piece of feedback was harder to address – people wanted more control. While `langchain` was the fastest place to get started, we traded power for ease of use. The same high level interfaces in `langchain` that made it easy to get started were now getting in the way when people tried to customize them to go to production.

大约在 2023 年夏季，我们开始收到来自社区对 `langchain` 的大量负面反馈。其中一些问题可以解决：例如避免破坏性变更、显式暴露隐藏提示词（prompts）、精简包体积、解决依赖冲突、更新文档等。但有一类反馈更难应对——用户渴望更强的控制力。尽管 `langchain` 是上手最快的起点，但我们以易用性为代价牺牲了灵活性。当初让初学者快速入门的那些高层级接口，如今反而成了用户将其定制化并投入生产环境时的阻碍。

We started developing LangGraph that summer, and launched it in early 2024. There were two main pillars we focused on:

我们于当年夏季启动 LangGraph 的研发工作，并于 2024 年初正式发布。其设计聚焦于两大核心支柱：

1. 可控性：无隐藏提示词，无隐藏的上下文工程。您对系统拥有完全控制权——无论它是一个工作流、智能体（agent），还是介于二者之间的任何形态。

1. 可控性：无隐藏提示词，无隐藏的上下文工程。您对系统拥有完全控制权——无论它是一个工作流、智能体（agent），还是介于二者之间的任何形态。

2. 运行时能力：我们整合了所有关于生产级运行时所需特性的经验认知（包括流式处理、有状态性、人工介入环节、持久化执行等），并将这些能力以原生方式深度集成进 LangGraph。

2. 运行时能力：我们整合了所有关于生产级运行时所需特性的经验认知（包括流式处理、有状态性、人工介入环节、持久化执行等），并将这些能力以原生方式深度集成进 LangGraph。

LangGraph 的设计灵感源自初代 `langchain` 的固有局限。来自 LinkedIn、Uber、摩根大通（J.P. Morgan）和贝莱德（BlackRock）等企业的生产环境验证，进一步坚定了我们所走方向的正确性。

LangGraph 的设计灵感源自初代 `langchain` 的固有局限。来自 LinkedIn、Uber、摩根大通（J.P. Morgan）和贝莱德（BlackRock）等企业的生产环境验证，进一步坚定了我们所走方向的正确性。

## **重新构想 LangChain**

## **重新构想 LangChain**

几个月前，我们决定从零开始全面重构 `langchain`。尽管 LangGraph 已获得广泛采用，但其学习门槛相对较高；与此同时，开发者社区对 `langchain` 持续高涨的热情也让我们确信：行业中仍存在一个真实且未被充分满足的需求——而 `langchain` 正在有效填补这一空白。为此，我们为全新构想的 `langchain` 设立了三大目标：

几个月前，我们决定从零开始全面重构 `langchain`。尽管 LangGraph 已获得广泛采用，但其学习门槛相对较高；与此同时，开发者社区对 `langchain` 持续高涨的热情也让我们确信：行业中仍存在一个真实且未被充分满足的需求——而 `langchain` 正在有效填补这一空白。为此，我们为全新构想的 `langchain` 设立了三大目标：

1. 让构建智能体（agents）的入门过程尽可能简单；
2. 提供比以往更丰富的自定义能力；
3. 内置面向生产环境就绪的运行时（production-ready runtime）。

1. 让构建智能体（agents）的入门过程尽可能简单；  
2. 提供比以往更丰富的自定义能力；  
3. 内置面向生产环境就绪的运行时（production-ready runtime）。

我们深知，实现这一愿景必然带来 `langchain` 的大规模破坏性变更（breaking changes）。因此，我们决定将这些变更集中体现在 1.0 版本中。我们通过以下三项关键举措达成了既定目标：

我们深知，实现这一愿景必然带来 `langchain` 的大规模破坏性变更（breaking changes）。因此，我们决定将这些变更集中体现在 1.0 版本中。我们通过以下三项关键举措达成了既定目标：

1. 聚焦于当前已与“智能体”概念深度绑定的核心工具调用循环（tool-calling loop）；
2. 引入全新的“中间件（middleware）”概念——该机制专为开发者量身打造，使其能精准地在所需位置掌控“上下文工程（context engineering）”的全生命周期；
3. 基于 LangGraph 构建运行时：天然支持流式响应、持久化执行、人工介入（human-in-the-loop）等关键生产特性。

1. 聚焦于当前已与“智能体”概念深度绑定的核心工具调用循环（tool-calling loop）；  
2. 引入全新的“中间件（middleware）”概念——该机制专为开发者量身打造，使其能精准地在所需位置掌控“上下文工程（context engineering）”的全生命周期；  
3. 基于 LangGraph 构建运行时：天然支持流式响应、持久化执行、人工介入（human-in-the-loop）等关键生产特性。

我们相信，今日发布的 `langchain` 1.0 完美实现了上述全部目标；更重要的是，它向逾百万开发者的庞大社区清晰传达了我们坚定支持的技术理念与工程主张。如今，业界对智能体架构的最佳实践理解，已远超项目启动之初；而 `langchain` 1.0 的设计也比我们团队此前发布的任何版本都更加精炼、更具指导性。此外，我们还正式上线了 [全新的统一文档网站](https://docs.langchain.com/?ref=blog.langchain.com)，这是一次期待已久的重磅升级！我们听到了大家的声音。

我们相信，今日发布的 `langchain` 1.0 完美实现了上述全部目标；更重要的是，它向逾百万开发者的庞大社区清晰传达了我们坚定支持的技术理念与工程主张。如今，业界对智能体架构的最佳实践理解，已远超项目启动之初；而 `langchain` 1.0 的设计也比我们团队此前发布的任何版本都更加精炼、更具指导性。此外，我们还正式上线了 [全新的统一文档网站](https://docs.langchain.com/?ref=blog.langchain.com)，这是一次期待已久的重磅升级！我们听到了大家的声音。

对于当前正在使用 `langchain` 的数百万开发者（月下载量高达 8000 万次！），我们仍将保留 `langchain` 0.x 系列，并将其更名为 `langchain-classic`；同时，我们承诺将在较长时间内持续提供维护与支持。

对于当前正在使用 `langchain` 的数百万开发者（月下载量高达 8000 万次！），我们仍将保留 `langchain` 0.x 系列，并将其更名为 `langchain-classic`；同时，我们承诺将在较长时间内持续提供维护与支持。

## **将 LangSmith 升级为智能体工程平台**

## **将 LangSmith 升级为智能体工程平台**

LangSmith 的核心功能一直是可观测性（observability）和评估（evaluations），但这并非构建可靠智能体（agents）所需的全部工具。我们已开始尝试将更多功能整合进平台，此前推出的“LangGraph Platform”即聚焦于部署（deployments）。展望未来，我们看到了诸多帮助客户的新方式，并希望将 LangSmith 打造成一个统一平台——您可在此获取构建可靠智能体所需的大部分工具。今天，我们正式将部署能力集成至 LangSmith，同时着手将其建设为全面的智能体工程平台（comprehensive agent engineering platform）。未来，我们还将在 LangSmith 中陆续引入其他产品线，目标是确保每项新产品均保持与现有产品相对独立，同时又能与平台深度集成。

## **未来的智能体**

## **未来智能体**

我们的目标是探索未来智能体的形态，并构建相应工具以推动其实现。我们已明确部分关键组件（例如 LangGraph 这类智能体运行时、可观测性能力、评估能力）。对于其他潜在组件，我们也有一些初步设想，并正积极展开探索。此外，我们完全预期：在当下这个时间点，仍存在一些我们尚无法想象其具体形态的组件——这恰恰让这场探索之旅充满乐趣与成就感，而我们相信，这将是一段漫长且富有回报的征程。

如果您对我们的工具如何进一步适配、更好地支持未来智能体的构建有任何反馈，[欢迎通过 X 告诉我](https://x.com/hwchase17?ref=blog.langchain.com)。我珍视每一条反馈，因为我们深知：唯有持续演进，我们的产品才能真正满足不断变化的需求。

若您在构建未来智能体的过程中需要可靠的合作伙伴，[请随时联系我们](https://www.langchain.com/contact-sales?ref=blog.langchain.com)。我们有幸与 Vanta、Rippling、Replit、Clay、Cisco、Workday 等众多优秀企业合作，也热切期待与更多勇于突破技术边界的团队携手同行。

若您愿加入我们，共同践行“构建未来智能体”的使命，[我们正在招聘](http://langchain.com/careers?ref=blog.langchain.com)——几乎所有岗位均在开放中。

### 标签

### Tags

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的热点观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/reflections-on-three-years-of-building-langchain/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/reflections-on-three-years-of-building-langchain/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪记录到深度洞察：规模化理解智能体行为](images/reflections-on-three-years-of-building-langchain/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪记录到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/reflections-on-three-years-of-building-langchain/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码记录应用行为；在人工智能中，追踪记录（traces）承担这一角色。](images/reflections-on-three-years-of-building-langchain/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码记录应用行为；在人工智能中，追踪记录（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/reflections-on-three-years-of-building-langchain/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排工具——天哪！](images/reflections-on-three-years-of-building-langchain/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Not Another Workflow Builder](images/reflections-on-three-years-of-building-langchain/img_005.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/reflections-on-three-years-of-building-langchain/img_005.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[![Deep Agents](images/reflections-on-three-years-of-building-langchain/img_006.png)](https://blog.langchain.com/deep-agents/)

[![深度智能体（Deep Agents）](images/reflections-on-three-years-of-building-langchain/img_006.png)](https://blog.langchain.com/deep-agents/)

[**Deep Agents**](https://blog.langchain.com/deep-agents/)

[**深度智能体（Deep Agents）**](https://blog.langchain.com/deep-agents/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison 的热评](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读
{% endraw %}
