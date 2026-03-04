---
render_with_liquid: false
title: "Pushing LangSmith to new limits with Replit Agent's complex workflows"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-replit/"
date: "2025-06-09"
scraped_at: "2026-03-03T07:31:19.496328963+00:00"
language: "en-zh"
translated: true
description: "See how Replit built their agents atop LangGraph and integrated LangSmith to pinpoint issues, improve the performance of their agents, and enable human-in-the-loop workflows."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

[Replit](https://replit.com/?ref=blog.langchain.com) is at the forefront of AI innovation with its platform that simplifies writing, running, and collaborating on code for over 30+ million developers. They recently released Replit Agent, which immediately went viral due to the incredible applications people could easily create with this tool.

[Replit](https://replit.com/?ref=blog.langchain.com) 是 AI 创新领域的先行者，其平台为全球超 3000 万开发者大幅简化了代码编写、运行与协作流程。他们近期推出的 Replit Agent 工具一经发布便迅速走红，用户借助该工具轻松构建出大量令人惊叹的应用。

Behind the scenes, Replit Agent has a complex workflow which enables a highly custom agentic workflow with a high-degree of control and parallel execution. By using [LangSmith](http://langchain.com/langsmith?ref=blog.langchain.com), Replit gained deep visibility into their agent interactions to debug tricky issues.

在幕后，Replit Agent 依赖一套高度复杂的执行流程，从而支持高度定制化的智能体（agent）工作流，并具备精细的控制能力与并行执行能力。通过采用 [LangSmith](http://langchain.com/langsmith?ref=blog.langchain.com)，Replit 获得了对其智能体交互过程的深度可观测性，从而高效定位和调试各类疑难问题。

The level of complexity required for Replit Agent also pushed the boundaries of LangSmith. The LangChain and Replit teams worked closely together to add functionality to LangSmith that would satisfy their LLM observability needs. Specifically, there were three main areas that we innovated on:

Replit Agent 所需的复杂度也推动了 LangSmith 能力边界的拓展。LangChain 团队与 Replit 团队紧密协作，在 LangSmith 中新增多项功能，以全面满足其大语言模型（LLM）可观测性需求。具体而言，我们在以下三大方向实现了关键创新：

1. Improved performance and scale on large traces  
2. Ability to search and filter within traces  
3. Thread view to enable human-in-the loop workflows  

1. 大型追踪（trace）场景下的性能与可扩展性提升  
2. 支持在单个追踪内部进行搜索与筛选  
3. 新增“会话线程视图”（Thread View），赋能“人在环路中”（human-in-the-loop）工作流  

## **Improved performance and scale on large traces**

## **大型追踪场景下的性能与可扩展性提升**

Most other LLMOps solutions monitor individual API requests to LLM providers, offering a limited view of single LLM calls. In contrast, LangSmith from day one has focused on tracing the entire execution flow of an LLM application to provide a more holistic context.

目前大多数其他 LLMOps 解决方案仅监控发往大语言模型服务商的单个 API 请求，因而只能提供对单次 LLM 调用的有限视角。相比之下，LangSmith 自诞生之初即聚焦于完整追踪一个 LLM 应用的全链路执行流程，从而提供更全面、更上下文完备的观测视角。

Tracing is important for agents due to their complex nature. It captures multiple LLM calls as well as other steps (retrieval, running code, etc). This gives you granular visibility into what’s happening, including at the inputs and outputs of each step, in order to understand the agent’s decision-making.

对于结构复杂的智能体而言，追踪能力至关重要：它不仅能捕获多次 LLM 调用，还能记录其他关键步骤（如信息检索、代码执行等）。由此，开发者可获得细粒度的运行洞察——包括每一步骤的输入与输出，进而深入理解智能体的决策逻辑。

Replit Agent was a ripe example for advanced tracing needs. Their agentic tool goes beyond simply reviewing and writing code, but also performs a wider range of functions – including planning, creating dev environments, installing dependencies, and deploying applications for users.

Replit Agent 正是高级追踪需求的典型范例。该智能体工具远不止于审阅与编写代码，还承担着更广泛的功能任务——例如任务规划、创建开发环境、安装依赖项，以及为用户部署应用程序。

As a result, Replit’s traces were very large - involving hundreds of steps. This posed significant challenges for ingesting data and displaying it in a visually meaningful way.

因此，Replit 的追踪数据体量极为庞大——单条 trace 往往涵盖数百个执行步骤。这给数据接入（ingestion）与可视化呈现均带来了严峻挑战。

To address this, the LangChain team improved their ingestion to efficiently process and store large volumes of trace data. They also improved LangSmith’s frontend rendering to display long-running agent traces seamlessly.

为应对这一挑战，LangChain 团队优化了数据接入模块，使其能够高效处理并持久化海量追踪数据；同时，团队亦升级了 LangSmith 前端渲染能力，确保长周期、多步骤的智能体追踪可被流畅、无缝地展示。

![](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_001.png)

## **Search and filter within traces to pinpoint issues**

## **在单个 trace 内搜索与筛选，精准定位问题**

LangSmith 一直支持 trace **之间** 的搜索功能，使用户能够基于事件或全文关键词，在数十万条 trace 中快速定位某一条特定 trace。但随着 Replit Agent 生成的 trace 越来越长，Replit 团队需要在单个 trace **内部** 搜索特定事件（尤其是 alpha 测试人员报告的问题）。这要求对现有搜索能力进行增强。

为此，LangSmith 新增了一种搜索模式——**trace 内部搜索**。用户不再需要逐层展开、滚动浏览大型 trace 中的每一次调用，而是可直接按关心的条件进行筛选（例如：某次运行的输入或输出中包含的关键词）。这一改进大幅缩短了 Replit 团队在单个 trace 中调试 agent 步骤所需的时间。

## **Thread view to enable human-in-the-loop workflows**

## **线程视图（Thread View）赋能“人在环路中”工作流**

Replit Agent 的一项关键差异化特性，是其对“人在环路中”（human-in-the-loop）工作流的高度重视。Replit Agent 的设计目标是成为 AI agent 与人类开发者高效协作的工具——开发者可在任意时刻介入，编辑并修正 agent 的执行路径。

由于 Replit 设计了多个分工明确的 agent（如负责管理、编辑和验证生成代码的 agent），这些 agent 会持续与用户交互，往往在一次长时间、多轮次的对话中反复协作。然而，监控这类对话流常常十分困难，因为每个用户会话都会生成彼此孤立、互不关联的 trace。

为解决该问题，LangSmith 引入了 **线程视图（Thread View）**，将属于同一对话（即逻辑上相关）的多个 trace 自动聚合在一起。该视图以符合直觉的方式呈现整个多轮对话中所有 agent 与用户的交互过程，从而帮助 Replit 更好地：1）识别用户卡顿的瓶颈环节；2）精准定位适合引入人工干预的关键节点。

## **Conclusion**

## **结语**

Replit 正借助 LangSmith 强大的可观测性能力，不断拓展 AI agent 监控技术的边界。通过显著降低加载冗长、繁重 trace 的开销，Replit 团队极大加速了复杂 agent 的构建与规模化进程。凭借更快的调试速度、更清晰的 trace 可见性，以及对并行任务更优的处理能力，Replit 正在为 AI 驱动的软件开发树立全新标杆。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_002.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + 沃达丰：利用 LangGraph 与 LangSmith 构建 AI 智能体，重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功智能体的可观测性](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 与 LangSmith 构建数据与 AI 可观测性智能体](images/pushing-langsmith-to-new-limits-with-replit-agent_s-complex-workflows/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 与 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟