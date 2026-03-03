---
title: "How Harmonic built an investment agent with LangGraph and LangSmith— so VCs can focus on founders"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-harmonic/"
date: "2025-04-14"
scraped_at: "2026-03-03T07:34:37.534492038+00:00"
language: "en-zh"
translated: true
description: "See how Harmonic uses LangSmith and LangGraph products to streamline venture investing workflows."
tags: ["Case Studies"]
---

Harmonic is the startup discovery engine, tracking company formation and growth while providing valuable insights and workflow tools to venture capitalists (VCs). By aggregating vast amounts of public data and private data collected through partnerships with venture ecosystem players, Harmonic enables users to discover startups based on various criteria, enhancing their sourcing efforts. Using LangGraph and LangSmith, they’ve been able to move several steps further down the investment pipeline. With automatic market maps, research reports, and conversational interactions, VCs can now leverage Harmonic to pick and win the best deals in addition to sourcing.

Harmonic 是一款初创企业发现引擎，持续追踪公司创立与成长动态，同时为风险投资人（VC）提供宝贵的洞察分析与工作流工具。通过聚合海量公开数据及与风投生态伙伴合作获取的私有数据，Harmonic 使用户能够依据多种维度筛选初创企业，大幅提升其项目源头发掘效率。借助 LangGraph 和 LangSmith，Harmonic 已将用户推进至投资流程更下游的关键环节。凭借自动生成的市场图谱、深度研究报告以及自然对话式交互能力，VC 不仅可高效发掘优质标的，更能依托 Harmonic 精准锁定并成功竞得最具价值的投资机会。

## **Problem: Discovering the most exciting startups**

## **难题：发掘最具潜力的初创企业**

Navigating the complex landscape of early-stage startups is challenging for VCs and companies looking to connect with emerging businesses.  Historically, Harmonic has had an enormous search index, with a powerful search building UI.  For users, combining filters across hundreds of fields to find startups that met their interests was time-consuming at best, and prevented them from finding their best targets at worst.

对风险投资人及寻求对接新兴企业的公司而言，驾驭纷繁复杂的早期初创企业格局始终是一项挑战。长期以来，Harmonic 拥有极为庞大的搜索索引和功能强大的搜索构建界面（UI）。然而，用户需在数百个字段中组合多重筛选条件才能定位符合自身兴趣的初创企业——这一过程即便顺利也耗时费力，若操作不当甚至可能导致错失最优目标。

Harmonic saw the need to enable far simpler and more effective search. By implementing natural language search and refinement capabilities on top of their extensive data, they aimed to significantly reduce the time it took for users to find the best-fit startups for their investment thesis.

Harmonic 意识到亟需打造更简洁、更高效的新一代搜索能力。于是，他们在既有海量数据基础上，引入自然语言搜索与渐进式精炼功能，旨在大幅缩短用户为其投资策略匹配最适配初创企业所需的时间。

![](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_001.jpg)

# **LangGraph Studio for debugging agents & modular workflow**

# **LangGraph Studio：用于调试智能体与构建模块化工作流**

The Harmonic team chose to build with [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) due to its ecosystem approach. This allowed for a unified stack so Harmonic could host all their prompts in LangSmith, invoke their target models with LangChain, and build composable workflows in LangGraph with nodes directly linking to execution traces.

Harmonic 团队选择基于 [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) 构建系统，正是看中其生态协同的设计理念。该方案实现了技术栈的高度统一：Harmonic 可将全部提示词（prompts）托管于 LangSmith，通过 LangChain 调用目标大模型，并在 LangGraph 中构建可组合的工作流——其中每个节点均可直接关联至对应执行轨迹（execution trace）。

LangGraph Studio proved to be a game-changer for Harmonic's development process. The visual studio allowed engineers to track state, and directly link to any invoked LLMs in its exact invoked state, across every node in their agent workflows, significantly reducing debugging time.

LangGraph Studio 成为 Harmonic 开发流程中的关键转折点。这一可视化开发环境使工程师得以实时追踪工作流状态，并在智能体（agent）的任一节点上，精准定位并查看当时被调用的大语言模型（LLM）所处的确切运行状态，从而显著缩短调试周期。

> As CEO Max Ruderman notes: _"This UI is invaluable for debugging—instead of rerunning every node, we can directly inspect graph state at any point, make changes, re-run from that point, and observe the difference. Or open up that execution in Playground, with all the context from execution time already there so you can instantly experiment with different models or instructions."_

> Harmonic 首席执行官 Max Ruderman 表示：“这一 UI 对调试工作具有不可估量的价值——我们无需重复运行整个工作流中的每个节点，而是可随时直接检查图谱（graph）在任意节点处的状态，即时修改、从该节点起重新执行，并直观比对差异；亦可将该次执行直接载入 Playground 环境，所有运行时上下文均已自动加载就绪，助您即刻尝试不同模型或指令。”

![](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_002.jpg)

The modular framework of LangGraph empowered Harmonic to quickly bring agentic workflows to other parts of their product.  For example, because standalone workflows were modularized into subgraphs, they were able to bring a “research agent” (which was otherwise a subcomponent of a more complex workflow) to every company profile in their platform with almost no incremental backend work. That saves investors hours on screening, evaluation, and diligence, allowing them to show up prepared to every founder meeting.

LangGraph 的模块化框架赋能 Harmonic 快速将智能体（agentic）工作流拓展至其产品的其他模块。例如，由于独立工作流被模块化为子图（subgraphs），他们得以将一个“研究型智能体”（该智能体原本只是更复杂工作流中的一个子组件）无缝部署到平台上的每一个公司档案中，几乎无需额外的后端开发工作。此举为投资者节省了大量用于初步筛选、评估与尽职调查的时间，使其每次与创始人会面前都能充分准备。

![](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_003.jpg)

By using LLMs to combine Harmonic’s millions of startup data points with live web data, Harmonic hoped to supercharge the insights and growth signals they could offer for early stage companies. But before LangGraph, building a reliable pipeline for real-time research on startup talent flow, market mapping, and media activity proved to be a tedious feat. Without a framework for composable development and graph visualization, tuning runs was a slow, iterative process of trial-and-error. Switching to LangGraph helped the team gain confidence that multiple engineers could collaborate on building these workflows quickly without introducing regressions.

Harmonic 希望借助大语言模型（LLMs），将其积累的数百万条初创企业数据点与实时网络数据相结合，从而大幅提升其面向早期公司的洞察力与增长信号识别能力。然而，在引入 LangGraph 之前，构建一条稳定可靠的实时研究流水线——涵盖初创企业人才流动、市场格局映射及媒体动态追踪——始终是一项繁琐而艰巨的任务。缺乏可组合式开发（composable development）框架与图结构可视化能力，使得调优过程只能依赖缓慢、反复的试错迭代。转而采用 LangGraph 后，团队得以建立信心：多名工程师可协同高效构建此类工作流，且不会引发功能退化（regressions）。

Harmonic also leveraged LangGraph's capabilities to rapidly develop subgraphs for refining user intent and structuring search queries. This allowed them to create a sophisticated search agent capable of executing complex queries like: _"Show me AI companies in SF or NY that have raised funding in the last year from top investors and that have a connection to someone on my team, but no one on the team has been in touch with them in the last year."_

Harmonic 还充分利用 LangGraph 的能力，快速构建用于细化用户意图与结构化搜索查询的子图。这使其成功打造了一个高度智能化的搜索智能体，能够精准执行如下复杂查询：  
_“请列出旧金山或纽约地区的人工智能公司，这些公司在过去一年内已从顶级投资机构获得融资，且与我团队中的某位成员存在关联，但该团队成员在过去一年内尚未与其联系过。”_

Now, investors can simply describe what they’re looking for—whether it’s a problem space, industry, a product that should exist, or a particular founder background—and Harmonic translates their natural language queries into precise, actionable search results.

如今，投资者只需用自然语言描述其需求——无论是某一问题领域、特定行业、尚待诞生的产品构想，还是某类创始人背景——Harmonic 即可将其转化为精准、可直接操作的搜索结果。

# **LangSmith for evaluations & collaborative prompt iteration**

# **使用 LangSmith 进行效果评估与协作式提示词迭代**

With [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com), the Harmonic team could track every model invocation with seamless integration into a playground environment. This gave the team visibility into their model performance and user interactions, something they had struggled to achieve with previous disparate systems.

借助 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)，Harmonic 团队可对每一次模型调用进行全程追踪，并无缝集成至交互式 Playground 环境中。这使团队得以全面掌握模型性能表现与用户交互行为——而此前，他们一直难以在彼此割裂的多个系统中实现这一目标。

A key feature that attracted Harmonic to LangSmith was its robust prompt versioning system. The Harmonic team has a collaborative approach to prompt engineering, with one engineer handling more of the model writing and prompt tuning, and others coming in to collaborate on prompt refinements. This collaborative environment extended to their fine-tuning efforts for custom models, where LangSmith's tracking capabilities provided essential data for optimization.

吸引 Harmonic 采用 LangSmith 的关键特性之一，是其强大而稳健的提示词（prompt）版本管理系统。Harmonic 团队采用协作式提示工程模式：一名工程师主要负责模型逻辑编写与提示词调优，其他成员则参与提示词的持续优化与打磨。这种协作模式同样延伸至其定制化模型的微调工作中——LangSmith 提供的精细化追踪能力，为模型优化提供了不可或缺的数据支撑。

LangSmith's integration with LangGraph created a powerful development ecosystem that accelerated Harmonic's iteration cycles. The ability to link execution traces to specific prompts enabled developers to analyze performance patterns and make data-driven adjustments. When issues arose in their search agent, the team could quickly identify whether the problem stemmed from prompt design, model limitations, or graph structure.

LangSmith 与 LangGraph 的深度集成，构建起一套强大的开发生态系统，显著加快了 Harmonic 的迭代节奏。通过将执行轨迹（execution traces）精准关联至具体提示词，开发者得以深入分析性能规律，并基于数据作出优化调整。当其搜索智能体出现异常时，团队可迅速定位问题根源——究竟是提示词设计缺陷、模型能力瓶颈，还是图结构逻辑问题。

Crucially, LangSmith made it incredibly easy to manage and view datasets and evaluations, which greatly sped up Harmonic’s development velocity. These evaluations ensured that any change to prompts or agent graph configurations could be tested against a suite of predefined metrics, whether at the level of individual nodes or the entire graph. This allowed the team to iterate rapidly and confidently, even as they frequently switched out underlying LLM models to keep pace with the latest advancements.

尤为关键的是，LangSmith 极大地简化了数据集与评估任务的管理与查看流程，从而显著提升了 Harmonic 的开发效率。这些评估机制确保：无论对提示词还是智能体图结构配置所做的任何修改，均可在预设的一整套指标体系下完成验证——验证粒度既可细化至单个节点，也可覆盖整个图结构。正因如此，即便团队需频繁更换底层大语言模型以紧跟技术前沿，仍能保持高速、稳健的迭代节奏与充分的信心。

![](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_004.jpg)

# **Impact & Conclusion**

# **影响与总结**

The implementation of LangChain's LangSmith and LangGraph has significantly improved Harmonic's search and research capabilities. Users reach their "aha moment" faster, with searches delivering more relevant results—especially for the most creative queries. Time to value dropped from hours to under a minute, and positive search outcomes **increased by 30%.**

LangChain 的 LangSmith 和 LangGraph 的落地实施，显著提升了 Harmonic 的搜索与研究能力。用户能更快抵达“顿悟时刻”（“aha moment”），搜索结果更加精准——尤其在应对最具创意性的查询时表现突出。价值实现时间从数小时缩短至一分钟以内，正面搜索结果的占比**提升了 30%**。

Harmonic was also able to add new capabilities, increasing the leverage they bring users throughout the investing funnel by offering instant market-maps and the ability to conduct research that combines Harmonic’s unique data with synthesized insights from the public web, the user’s CRM data, and network. Now, leading investors can rely on Harmonic to find, pick, and win the best deals out there.

Harmonic 还借此新增多项功能，在整个投资流程中为用户创造了更高杠杆价值：例如即时生成市场图谱（market-maps），以及开展融合式研究——将 Harmonic 独有的数据，与来自公开网络、用户 CRM 系统及人际网络的综合洞察无缝整合。如今，顶尖投资者可充分信赖 Harmonic，高效发现优质项目、精准筛选标的，并最终赢得最具竞争力的交易机会。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_005.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_006.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_006.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_007.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith 打造 AI 智能体，全面升级客户体验](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_007.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith 打造 AI 智能体，全面升级客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_008.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_008.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_009.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何借助 LangSmith 实现对其客户成功智能体的可观测性](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_009.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员工作状态的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_010.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-harmonic-built-an-investment-agent-with-langgraph-and-langsmith-so-vcs-can-f/img_010.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟