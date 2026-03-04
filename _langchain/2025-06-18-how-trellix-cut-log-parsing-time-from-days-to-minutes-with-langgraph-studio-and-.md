---
title: "How Trellix cut log parsing time from days to minutes with LangGraph Studio and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-trellix/"
date: "2025-06-18"
scraped_at: "2026-03-03T07:30:06.281060394+00:00"
language: "en-zh"
translated: true
description: "See how cybersecurity company Trellix used LangGraph Studio to visualize and debug agent interactions, plus LangSmith for agent evaluations"
tags: ["Case Studies"]
---
&#123;% raw %}

[Trellix](https://www.trellix.com/?ref=blog.langchain.com) 是一家领先的网络安全公司，拥有超过 40,000 名客户，致力于帮助组织防范网络攻击与安全威胁。为应对客户面临的实际挑战，Trellix 专业服务团队借助 LangSmith 和 LangGraph（包括可视化工具 LangGraph Studio）开发了内部应用 Sidekick，该应用旨在普及知识、自动化繁琐流程。

[Trellix](https://www.trellix.com/?ref=blog.langchain.com) 是一家领先的网络安全公司，拥有超过 40,000 名客户，致力于帮助组织防范网络攻击与安全威胁。为应对客户面临的实际挑战，Trellix 专业服务团队借助 LangSmith 和 LangGraph（包括可视化工具 LangGraph Studio）开发了内部应用 Sidekick，该应用旨在普及知识、自动化繁琐流程。

## **Problem: Customer request backlog and log parsing**

## **问题：客户请求积压与日志解析**

Trellix faced significant challenges with a growing backlog of requests for cybersecurity integrations and log parsing. Each request often required a developer to spend 2 to 3 days deciphering logs, coding integrations, and managing customer communications. This lengthy process frustrated customers and led to delays, as support tickets would bounce back and forth between customers and engineers.

Trellix 在网络安全集成与日志解析类客户请求方面面临日益加剧的积压问题。每项请求通常需开发人员耗费 2 至 3 天时间来解读日志、编写集成代码，并协调客户沟通。这一冗长流程令客户倍感沮丧，也导致响应延迟——支持工单往往在客户与工程师之间反复流转。

To improve customer experience, Trellix decided to build Sidekick, an agentic platform to automate tasks for engineering teams at Trellix, including parsing and script writing. Specifically, they created a structured approach to intake and parse syslog data. Sidekick can automatically generate parsers for unknown log formats, **reducing the time required for manual parsing from days to minutes.** Additionally, they built agents that can speed up the development of plugins and integrations for their SaaS products. Traditionally, this required an engineer to read through 3rd-party API documentation and generate boilerplate code for each new plugin. Handing off this work to agents meant plugins, traditionally being written during the course of multiple days, could now be written during the better part of an afternoon. This quicker turn around time enabled engineers to make a dent in the integration backlog and increased customer satisfaction.

为提升客户体验，Trellix 决定构建 Sidekick —— 一个面向其工程团队的智能体（agentic）平台，用于自动化日志解析、脚本编写等任务。具体而言，他们设计了一套结构化方案，用于接收并解析 syslog 数据。Sidekick 能够自动为未知格式的日志生成解析器，**将原本需耗时数天的手动解析工作缩短至几分钟。** 此外，他们还构建了多个智能体，以加速为其 SaaS 产品开发插件与集成模块。传统方式下，工程师需通读第三方 API 文档，并为每个新插件手动生成样板代码；而将此类工作交由智能体执行后，原本需耗时数天完成的插件开发，如今可在大半个下午内完成。这种显著提速使工程师得以有效缓解集成请求积压问题，同时提升了客户满意度。

## **LangGraph’s advantages as a library**

## **LangGraph 作为开发库的优势**

[LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) provided the low-level tools and enhanced abstraction techniques needed for the Trellix AI engineering team to make the required customizations for their use cases. Specifically,  map-reduce style graphs using the Send API and subgraph calling are used throughout the Sidekick Agents. These features encouraged modularity and abstraction. The Trellix team started by making several smaller subgraphs, many of which relied on the Send API and other lower-level LangGraph techniques to work efficiently and at scale. Once multiple subgraphs could perform their individual roles successfully, larger graphs were made to call the original graphs as modules.

[LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) 为 Trellix 的 AI 工程团队提供了所需的底层工具与增强型抽象机制，使其能针对自身业务场景灵活定制功能。具体而言，Sidekick 中的各类智能体广泛采用了基于 Send API 的 Map-Reduce 风格图结构及子图调用机制。这些特性天然支持模块化设计与分层抽象。Trellix 团队首先构建了若干小型子图，其中多数依赖 Send API 及其他 LangGraph 底层技术，以确保高效性与可扩展性。当多个子图均能稳定完成各自职责后，团队进一步构建更大型的图结构，将原有子图作为模块进行组合调用。

The Trellix team noted the ease of use; it was not that LangGraph had fundamentally reimagined how to develop agents. Instead, LangGraph offered several out-of-the-box features that made their lives as developers easier. Rather than spending their time figuring out the best way to create agents in code, their time was spent tweaking, refining, and combining a small assembly of easily-built agents.

Trellix 团队特别指出 LangGraph 的易用性：它并未从根本上重构智能体的开发范式，而是提供了一系列开箱即用的功能，切实降低了开发门槛。工程师无需再耗费大量精力研究“如何用代码最优地构建智能体”，转而将时间聚焦于对一组易于构建的智能体进行微调、优化与组合。

LangGraph’s human-in-the-loop capabilities also provided reassurance that engineers could step in to approve or rewind the agent’s actions as needed. Having the ability to pause execution during development testing or restart a certain step with slightly different input without waiting for a whole new run led to efficiency gains. This was a big deal to the engineering team who has stressed that waiting for model responses to test code can become quite tedious.

LangGraph 的“人在环中”（human-in-the-loop）能力也让工程师倍感安心——他们可随时介入，批准或回退智能体的操作。在开发测试过程中，工程师能够随时暂停执行，或仅对某一步骤使用略有差异的输入重新运行，而无需等待整条链路重跑一遍，从而显著提升效率。对此，工程团队强调：在调试阶段反复等待大模型响应以验证代码，极易令人疲惫不堪；而 LangGraph 的这一能力恰恰解决了该痛点。

## **Using Studio to visualize agent workflows for business stakeholders**

## **借助 Studio 向业务相关方可视化呈现智能体工作流**

Not only did the open source libraries offer advantages, but LangChain tools were particularly useful. [LangGraph Studio](http://ncepts/langgraph_studio/?ref=blog.langchain.com) played a crucial role in the development of Sidekick by providing a framework to visualize and optimize the workflows involved in log parsing and integration tasks. The engineering team used LangGraph Studio to map out the manual processes and transition them into an agentic workflow.

开源库本身已具备诸多优势，而 LangChain 生态中的工具更展现出独特价值。[LangGraph Studio](http://ncepts/langgraph_studio/?ref=blog.langchain.com) 在 Sidekick 的开发过程中发挥了关键作用——它提供了一套框架，用于可视化呈现并持续优化日志解析与集成任务所涉及的工作流。工程团队借助 LangGraph Studio，系统梳理了原有手工操作流程，并将其逐步迁移、重构为基于智能体的自动化工作流。

The benefits of LangGraph Studio did not stop with development. Agent visualization was especially helpful for presenting the **thought process and reasoning** behind AI models to both technical and non-technical stakeholders, such as executives and business leaders at Trellix. The engineering team behind Sidekick found that getting buy-in and inter-team understanding drastically improved once LangGraph Studio came into use. It became a great way to show that agents are not a “black box” but are instead carefully engineered programs.

LangGraph Studio 的优势不仅止步于开发阶段。其中，智能体（agent）的可视化功能尤为突出——它能向技术与非技术利益相关方（例如 Trellix 的高管和业务负责人）清晰呈现 AI 模型背后的**思维过程与推理逻辑**。Sidekick 项目背后的工程团队发现，自引入 LangGraph Studio 后，跨团队共识与协作理解显著增强。该工具成为有力佐证：智能体并非不可知的“黑箱”，而是经过精心设计与工程化实现的程序。

![](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_001.jpg)Trellix's LangGraph Studio workflow

![](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_001.jpg)Trellix 的 LangGraph Studio 工作流

## **Monitoring agent performance over time with LangSmith**

## **借助 LangSmith 长期监控智能体性能**

To make data-driven decisions and to assess agent performance, Trellix used [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) for experimentation and to action upon performance metrics. The team was able to first design different architectures of their agent with LangGraph, then test multiple architectures of their Sidekick agents in LangSmith in order to see what performed best.

为实现数据驱动的决策并全面评估智能体性能，Trellix 借助 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 开展实验，并基于性能指标采取优化行动。团队首先使用 LangGraph 设计多种智能体架构，随后在 LangSmith 中对 Sidekick 智能体的不同架构进行并行测试，从而快速识别出最优方案。

Using datasets and experiments in LangSmith was especially powerful, as the Trellix team could quickly compare performance across app versions. In particular, they monitored key metrics such as recursion rate (i.e., how often the agent has to restart or go back to a previous step) and the “must include” rate (i.e., how often the agent retrieves helpful additional documents). Having this data and seeing improvements grounded in data helped Trellix build confidence before shipping to production.

在 LangSmith 中运用数据集与实验功能尤为高效：Trellix 团队得以快速对比不同应用版本间的性能表现。尤其值得关注的是两大核心指标——**递归率**（即智能体需重启或回退至上一环节的频次）与**“必须包含”率**（即智能体成功检索到有益补充文档的频次）。这些可量化、可追溯的数据及其持续提升趋势，极大增强了 Trellix 在正式上线前的信心。

![](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_002.jpg)Trellix's Experiments view in LangSmith

![](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_002.jpg)Trellix 在 LangSmith 中的实验视图

In addition to their use of experiments and datasets, the engineers at Trellix found the traces to be especially useful for debugging both when in production and during development. The intuitive structuring of trace data into inputs and outputs of each node made debugging significantly easier than drudging through AWS logs. This led to quicker development and bug fixes which increased satisfaction from internal users.

除实验与数据集外，Trellix 工程师还高度依赖 LangSmith 的**调用链追踪（traces）**功能，无论是在生产环境还是开发阶段，该功能均大幅提升了调试效率。调用链数据以节点为单位，清晰结构化地呈现各环节的输入与输出，远比在庞杂的 AWS 日志中艰难排查要直观高效得多。由此带来的开发提速与缺陷修复加速，显著提升了内部用户满意度。

## **Impact & what’s next**

## **成效与后续规划**

With Sidekick, Trellix has amplified time savings for both engineers on the team and customers. They have:

借助 Sidekick，Trellix 不仅大幅节省了内部工程师的时间，也显著提升了客户体验。具体成果包括：

- **Reduced log parsing time from days to minutes**, drastically improving engineering efficiency.  
- **日志解析耗时从数天缩短至数分钟**，工程效率实现质的飞跃。

- **Accelerated customer request resolution**, reducing backlog and improving time-to-value (TTV).  
- **加速客户请求响应闭环**，有效降低积压工单量，显著缩短价值交付周期（Time-to-Value, TTV）。

- **Improved AI agent performance** by testing multiple architectures and tracking key metrics in LangSmith.  
- **提升 AI 智能体性能**：通过多架构实验与 LangSmith 关键指标追踪，持续优化模型表现。

- **Boosted stakeholder confidence** by providing clear, visual explanations of AI reasoning to non-technical leaders.  
- **增强利益相关方信心**：面向非技术领导者提供清晰、直观的 AI 推理可视化解释。

Looking ahead, Trellix plans to expand the capabilities of Sidekick to external partners, further democratizing access to AI-driven solutions in cybersecurity. The positive impact of LangSmith and LangGraph has set the stage for continued innovation in Trellix's service delivery, with goals to extend automated parsing and cloud connectors to all customers in the next quarter.

展望未来，Trellix 计划将 Sidekick 的能力拓展至外部合作伙伴，进一步推动网络安全领域 AI 驱动解决方案的普惠化应用。LangSmith 与 LangGraph 所带来的积极影响，为 Trellix 持续优化服务交付模式奠定了坚实基础；公司目标是在下一季度内，将自动化日志解析功能与云连接器全面覆盖所有客户。

## **Conclusion**

## **结语**

Trellix has successfully implemented generative AI to address operational challenges in the cybersecurity realm, including servicing customer needs. By using LangSmith, LangGraph, and LangGraph Studio to develop Sidekick, Trellix has not only improved internal efficiencies but also enhanced customer satisfaction – paving the way for future advancements in AI-driven cybersecurity solutions.

Trellix 已成功将生成式 AI 应用于解决网络安全领域的运营挑战，包括高效响应客户需求。通过运用 LangSmith、LangGraph 及 LangGraph Studio 开发 Sidekick，Trellix 不仅显著提升了内部运营效率，也大幅改善了客户满意度——为未来 AI 驱动型网络安全解决方案的持续演进铺平了道路。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_003.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何借助 LangChain 和 LangGraph，利用 AI 实现数千名客户的规模化接入](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入职流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何借助 LangSmith 实现对其客户成功智能体的可观测性](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何借助 LangSmith 实现对其客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-trellix-cut-log-parsing-time-from-days-to-minutes-with-langgraph-studio-and-/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
