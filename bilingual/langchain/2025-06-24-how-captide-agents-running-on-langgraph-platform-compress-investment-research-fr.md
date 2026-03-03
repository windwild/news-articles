---
title: "How Captide agents running on LangGraph Platform compress investment research from days to seconds"
source: "LangChain Blog"
url: "https://blog.langchain.com/captide/"
date: "2025-06-24"
scraped_at: "2026-03-03T07:29:18.753086132+00:00"
language: "en-zh"
translated: true
description: "See how Captide is using LangGraph Platform and LangSmith for their investment research and equity modeling agents."
tags: ["Case Studies"]
---

[Captide](https://www.captide.ai/?ref=blog.langchain.com) is reshaping how financial institutions build with AI, offering a full-stack platform that makes it easy to deploy multi-agent systems, embed intelligence across financial workflows, and extract insights from millions of corporate filings—without the overhead of building and managing complex RAG infrastructure.

[Captide](https://www.captide.ai/?ref=blog.langchain.com) 正在重塑金融机构构建 AI 应用的方式——它提供一个全栈式平台，让多智能体系统（multi-agent systems）的部署变得轻而易举，使 AI 智能无缝嵌入各类金融工作流，并从数百万份企业公开披露文件中高效提取洞见，同时完全规避了自建与运维复杂 RAG 基础设施所带来的额外负担。

At the foundation is Captide’s curated library of global financial disclosures from over 14,000 public companies, preprocessed and structured for optimal use with large language models. On top of this, Captide has built domain-specific AI agents that read, interpret, and reason over this data—augmenting a wide range of high-value tasks, from investment research to equity modeling.

其底层是 Captide 精心构建的全球金融披露文档库，覆盖逾 14,000 家上市公司，所有数据均已预处理并结构化，专为大语言模型（LLM）高效调用而优化。在此基础之上，Captide 开发了面向金融领域的专用 AI 智能体（AI agents），能够阅读、解析并推理该数据集，从而增强一系列高价值任务的能力——从投资研究到股权建模，均涵盖其中。

These agents don’t just extract information, they make use of all authoritative sources to automate workflows that once took hours or days. With exceptional precision, speed, and contextual understanding, Captide’s systems are trusted by leading asset managers, investment banks, and global institutions to enhance decision-making at scale.

这些智能体不仅限于信息抽取；它们综合调用全部权威信源，将过去需耗时数小时乃至数天的手动流程全面自动化。凭借卓越的准确性、响应速度与上下文理解能力，Captide 的系统已赢得全球顶尖资产管理公司、投资银行及大型金融机构的信任，成为其规模化决策支持的关键基础设施。

Powered by the LangChain ecosystem, Captide enables real-time exploration of investment theses, corporate events, peer comparisons, M&A signals, and more.

依托 LangChain 生态系统，Captide 支持对投资逻辑、企业重大事件、同业对比、并购信号等场景进行实时探索与分析。

## **Scaling with LangGraph Platform**

## **借助 LangGraph 平台实现规模化扩展**

Captide agents are used in a range of use cases—from answering sequential questions on company filings to powering spreadsheet-like setups that require large-scale parallel invocations to populate cells with metrics and insights. To ensure reliability and scalability across use cases, Captide agents are deployed on LangGraph Platform. LangGraph Platform ensures the service scales effectively with request volume and provides built-in tools for saving and recalling the state of an agent's execution within each session. This ensures agents remain consistent, responsive, and context-aware at scale.

Captide 智能体被广泛应用于多种场景：既可逐层解答关于企业披露文件的连贯性问题，也可驱动类电子表格（spreadsheet-like）应用——后者需大规模并行调用，以向成千上万个单元格填充指标与洞见。为确保各场景下的可靠性与可扩展性，Captide 智能体统一部署于 LangGraph 平台。该平台能随请求量动态弹性伸缩，并内置会话级状态保存与恢复机制，保障智能体在高并发下仍保持行为一致、响应及时、上下文感知准确。

In spreadsheet-style applications, Captide agents may be triggered simultaneously across thousands of cells, each with different parameters. This results in a high volume of concurrent tasks in a point of time. LangGraph automatically scales infrastructure up or down to meet these demands, ensuring stable, efficient performance regardless of load.

在类电子表格应用中，Captide 智能体可能在同一时刻被触发数千次，遍及不同参数配置的各个单元格，瞬时产生海量并发任务。LangGraph 可自动按需扩缩底层基础设施，无论负载高低，始终保障系统运行稳定、高效。

![](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_001.png)

![](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_001.png)

Deploying on LangGraph Platform has also enabled Captide’s product team—finance domain experts—to actively shape agent behavior. With access to LangGraph Studio’s low-code interface, they can iterate quickly on prompts and agent design, bringing client feedback and industry knowledge directly into the loop. This frees the engineering team to focus on the agent set up and architecture and provides a level of agility to the product team that wouldn’t be possible with more traditional setups.

部署于 LangGraph 平台，还赋能 Captide 的产品团队——一群深耕金融领域的专家——直接参与并塑造智能体的行为逻辑。借助 LangGraph Studio 提供的低代码界面，他们可快速迭代提示词（prompts）与智能体设计，将客户反馈与行业知识实时融入开发闭环。此举使工程团队得以专注智能体部署与架构建设，同时赋予产品团队前所未有的敏捷性——这是传统开发模式难以企及的。

## **Observability and Reliability with LangSmith**

## **借助 LangSmith 实现可观测性与高可靠性**

Captide’s AI agents operate within a sophisticated orchestration framework, breaking down complex tasks, coordinating multiple tool calls, and ensuring transparency at every step. To maintain high performance and control, Captide relies on LangSmith to make every agent decision fully observable, testable, and verifiable. With LangSmith, the team can trace responses end-to-end, while closely monitoring cost, accuracy, and latency.

Captide 的 AI 智能体运行于一个高度成熟的编排框架之中，能够将复杂任务逐层拆解、协调调用多种工具，并在每一步都确保过程透明。为维持高性能与强可控性，Captide 依托 LangSmith 实现对每个智能体决策的全面可观测性、可测试性与可验证性。借助 LangSmith，团队可实现端到端响应追踪，同时密切监控成本、准确率与延迟。

LangSmith also plays a critical role in maintaining quality over time. Captide sets up evaluations that test both common and edge-case user requests recurrently, scoring the agent’s responses to catch issues before they surface. It’s a continuous feedback loop that ensures every deployment is smarter, faster, and more resilient than the last.

LangSmith 在长期质量保障中亦发挥着关键作用。Captide 建立了一套持续运行的评估机制，反复测试用户常见请求及各类边界场景请求，并对智能体响应进行打分，从而在问题暴露前及时发现并修复。这是一个闭环反馈系统，确保每一次部署都比上一次更智能、更快速、更具韧性。

![](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_002.png)

## **Bringing in Generative UI into Captide**

## **将生成式 UI 引入 Captide**

To serve investment teams seeking powerful tools with minimal technical overhead, Captide has recently launched an interface that provides immediate access to its core technology. Through natural language alone, analysts can perform complex equity research, benchmark companies, and validate investment theses, powered by Captide’s AI agents.

为服务那些亟需强大工具却希望技术门槛尽可能低的投资团队，Captide 近期推出了一款全新界面，使用户可即时接入其核心技术。分析师仅需使用自然语言，即可在 Captide AI 智能体的支持下，开展复杂的股票研究、企业对标分析，以及投资假设验证。

To bring this experience to life, Captide built the platform using LangGraph’s generative UI technology. This allows AI agents to push interactive React components from the server directly into the user interface. Each component is uniquely identified and bundled by LangGraph Platform, then loaded dynamically as the conversation unfolds. The result is a responsive, modular experience where the interface adapts in real time to the user’s requests and the agent’s research path.

为实现这一体验，Captide 基于 LangGraph 的生成式 UI（Generative UI）技术构建了该平台。该技术使 AI 智能体能够直接从服务端向用户界面推送交互式 React 组件。每个组件均由 LangGraph 平台唯一标识并打包，再随对话进程动态加载。最终呈现的是一种响应迅速、模块清晰的交互体验——界面实时适配用户的查询意图与智能体的研究路径。

One of the most powerful aspects of this design is the visibility it offers. In Captide’s implementation, users don’t just see the final answer–they see the entire thought process. As the agent works through a request, the interface streams updates on the steps it’s taking, which sources it’s checking, and what it’s finding along the way. This matters because no two queries follow the same path—researching an M&A deal is very different from benchmarking companies, and Captide’s clients expect transparency into every step. For example, if someone asks about a past acquisition, the system recognizes the task, pulls relevant documents from a massive library of filings and disclosures, and surfaces key excerpts. All of this is shown to the user in real time, making the research traceable and auditable from start to finish.

这一设计最具优势的特性之一，正是其卓越的“过程可见性”。在 Captide 的实现中，用户看到的不只是最终答案，而是完整的推理链条。当智能体处理用户请求时，界面会实时流式呈现其执行步骤、所查阅的数据源，以及过程中获取的关键信息。这一点至关重要——因为没有任何两个查询遵循完全相同的路径：并购交易研究与企业对标分析截然不同；而 Captide 的客户，正期待着对每一个环节的全程透明。例如，当用户询问某项历史收购事件时，系统会自动识别任务类型，从海量的监管文件与披露材料库中精准调取相关文档，并高亮呈现核心段落。所有这些操作均以实时方式向用户展示，使整项研究工作从起点到终点全程可追溯、可审计。

![](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_003.png)

## **Conclusion**

## **结语**

Captide brings the full potential of agentic AI directly into the hands of financial analysts and decision-makers. With LangGraph and LangSmith powering everything under the hood, the platform scales effortlessly, stays reliable under pressure, and offers complete visibility into every step of the process. The result is a smarter, more intuitive way to research, reason, and act—setting a new standard for how AI supports financial workflows.

Captide 将具身智能（agentic AI）的全部潜力，直接交付至金融分析师与决策者手中。在 LangGraph 与 LangSmith 的底层驱动下，该平台可轻松扩展、高压下依然稳定可靠，并对整个流程的每一步提供全景式可视能力。最终成果是一种更智能、更直观的研究、推理与行动方式——重新定义了 AI 赋能金融工作流的新标准。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_004.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_004.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_005.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_005.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_006.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_006.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + 沃达丰：利用 LangGraph 与 LangSmith 构建 AI 代理，重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何借助 LangSmith 实现客户成功代理的可观测性](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何借助 LangSmith 实现客户成功代理的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_009.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 与 LangSmith 构建数据与 AI 可观测性代理](images/how-captide-agents-running-on-langgraph-platform-compress-investment-research-fr/img_009.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 与 LangSmith 构建数据与 AI 可观测性代理**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟