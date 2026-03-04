---
render_with_liquid: false
title: "How Captide is redefining equity research with agentic workflows running on LangGraph Platform"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-captide-is-redefining-equity-research-with-agentic-workflows-built-on-langgraph-and-langsmith/"
date: "2025-01-20"
scraped_at: "2026-03-03T07:44:40.496682292+00:00"
language: "en-zh"
translated: true
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

[Captide’s platform](https://www.captide.co/?ref=blog.langchain.com) transforms how investment research teams work with financial data. By automating the extraction of insights and metrics from regulatory filings and investor relations documents, analysts can create customized datasets and analyses with extreme efficiency. At the heart of this innovation is their commitment to NLP workflows and its strategic integration of LangGraph and LangSmith, hosted on [LangGraph Platform](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com).

[Captide 平台](https://www.captide.co/?ref=blog.langchain.com) 彻底改变了投资研究团队处理金融数据的方式。通过自动从监管申报文件和投资者关系文档中提取洞察与指标，分析师得以以前所未有的效率构建定制化数据集与分析报告。这一创新的核心，在于 Captide 对自然语言处理（NLP）工作流的坚定投入，以及其对 LangGraph 和 LangSmith 的战略性集成——相关能力托管于 [LangGraph 平台](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com)。

## Redefining Financial Analysis with NLP Workflows

## 借助 NLP 工作流重塑金融分析

By allowing users to articulate complex analysis tasks in natural language, [Captide](https://www.captide.co/?ref=blog.langchain.com) simplifies the process of extracting financial metrics, creating customized datasets, and uncovering contextual insights. Once the user defines their analysis tasks, Captide’s agents take over, orchestrating the entire data retrieval and processing pipeline from a big corpus of financial documents.

[Captide](https://www.captide.co/?ref=blog.langchain.com) 允许用户以自然语言清晰表达复杂的分析任务，从而大幅简化金融指标提取、定制化数据集构建及上下文洞察挖掘等流程。一旦用户定义好分析目标，Captide 的智能体（agents）即自动接管，统筹协调整个数据检索与处理流水线——其输入源是海量金融文档构成的语料库。

This seamless transition from query to actionable results redefines efficiency in financial analysis. It provides unmatched flexibility to extract company-specific metrics and insights, overcoming the fixed-schema limitations of legacy platforms, while analyzing exponentially larger volumes of investments.

这种从查询到可执行结果的无缝转化，重新定义了金融分析的效率标准。它赋予用户前所未有的灵活性，可精准提取面向特定公司的指标与洞察，突破传统平台固定数据模式（fixed-schema）的桎梏，同时支持对指数级增长的投资标的规模开展深度分析。

To achieve this, Captide relies on the capabilities of LangGraph and LangSmith, ensuring precision, scalability, and reliable outputs that align with the stringent standards of the financial industry.

为实现上述能力，Captide 高度依赖 LangGraph 与 LangSmith 的技术能力，确保输出结果具备高精度、强可扩展性与高度可靠性，完全契合金融行业严苛的质量标准。

## Using LangGraph for parallel processing and structured outputs

## 借助 LangGraph 实现并行处理与结构化输出

💡

💡

LangGraph has become indispensable in Captide’s technological stack.

LangGraph 已成为 Captide 技术栈中不可或缺的核心组件。

The framework’s intuitive design has streamlined development, reducing the complexity of tracking agent workflows while enhancing operational efficiency. With LangGraph, Captide’s team can manage complex agentic processes, such as parallel document processing and creation of structured outputs with ease.

该框架直观的设计显著简化了开发流程：既降低了追踪智能体工作流的复杂度，又提升了整体运行效率。借助 LangGraph，Captide 团队能够轻松管理各类复杂智能体流程，例如文档的并行处理，以及结构化输出的自动生成。

For example, when analyzing vast troves of regulatory filings, LangGraph’s parallel processing capabilities come into play. Multiple agents work simultaneously to execute ticker-specific vector store queries, retrieve relevant documents, and grade each document chunks. This approach not only minimizes latency but also eliminates the need to complicate the codebase with asynchronous functions.

例如，在分析海量监管申报文件时，LangGraph 的并行处理能力便大显身手：多个智能体协同并行执行针对不同股票代码（ticker）的向量数据库查询、相关文档检索，以及各文档分块（chunk）的评分任务。该方案不仅显著降低延迟，更避免了在代码库中引入复杂的异步函数逻辑。

The platform’s ability to generate structured outputs is another highlight.  
该平台生成结构化输出的能力是另一大亮点。

By leveraging LangGraph’s [trustcall](https://github.com/hinthornw/trustcall?ref=blog.langchain.com) python library, Captide ensures that users can request table outputs with their custom schemas to structure metrics found in distinct documents.  
Captide 借助 LangGraph 的 [trustcall](https://github.com/hinthornw/trustcall?ref=blog.langchain.com) Python 库，确保用户能够按自定义 Schema 请求表格形式的输出，从而对分散在不同文档中的指标进行结构化整理。

Trustcall makes the output adhere strictly to predefined JSON schemas, an essential requirement for Captide’s features.  
trustcall 强制输出严格遵循预定义的 JSON Schema，这是 Captide 各项功能的一项关键要求。

This guarantees consistency and reliability, even when dealing with the most complex document sets.  
这保证了输出的一致性与可靠性，即使面对最复杂的文档集合亦然。

![](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_001.png)

Captide’s adoption of LangGraph Studio and CLI further enhances its development workflow.  
Captide 对 LangGraph Studio 和 CLI 的采用进一步优化了其开发工作流。

By running agents locally and integrating outputs with LangSmith, the team has created an efficient environment where rapid iterations and testing are the norm.  
通过在本地运行智能体（agents），并将输出集成至 LangSmith，团队构建了一个高效环境——快速迭代与测试已成为常态。

## Integrating LangSmith for Real-Time Insights and Improvement

## 集成 LangSmith，实现实时洞察与持续优化

For Captide, real-time monitoring and iterative enhancement are non-negotiable.  
对 Captide 而言，实时监控与迭代式增强是不可或缺的。

💡

LangSmith provides Captide with a robust suite of tools to track agent performance, evaluate outputs, and gather invaluable user feedback as soon as tasks are run.  
LangSmith 为 Captide 提供了一套强大工具，可实时追踪智能体性能、评估输出质量，并在任务执行完成的第一时间收集宝贵的用户反馈。

Captide’s integration of LangSmith allows for precise monitoring of agent workflows, with detailed traces that highlight response times, error rates, and operational costs.  
Captide 与 LangSmith 的集成支持对智能体工作流进行精准监控，其详尽的执行轨迹（traces）清晰呈现响应时长、错误率及运行成本等关键指标。

This visibility ensures that the platform maintains its high standards of performance and reliability.  
这种可观测性保障了平台始终维持高性能与高可靠性标准。

LangSmith has also been crucial when incorporating thumbs-up and thumbs-down options within the platform where users can directly rate the quality of outputs.  
LangSmith 在平台内嵌入“点赞”与“点踩”功能的过程中也发挥了关键作用——用户可直接对输出质量进行评分。

This feedback is collected and analyzed, creating a growing dataset that helps refine agent behavior and improve system performance over time.  
此类反馈被系统自动收集并分析，逐步形成一个不断扩大的数据集，用以持续优化智能体行为、提升系统整体性能。

With LangSmith’s evaluation tools, this feedback loop enables Captide to identify trends, address weaknesses, and continuously enhance the user experience.  
借助 LangSmith 的评估工具，这一闭环反馈机制使 Captide 能够识别趋势、定位短板，并持续改善用户体验。

## Deploying on LangGraph Platform

## 在 LangGraph 平台上部署

When LangChain launched [LangGraph Platform](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com) this summer, it was a no-brainer to deploy their cutting-edge agents on it.

今年夏天，当 LangChain 推出 [LangGraph 平台](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com) 时，将他们前沿的智能体部署到该平台上便成了顺理成章的选择。

With Captide's agent built on LangGraph, it was a one-click deploy to get production-ready API endpoints for interacting with the agent. This includes endpoints for streaming as well as for getting the state of the thread at any point in time.

Captide 的智能体基于 LangGraph 构建，仅需单击一次即可完成部署，快速获得可用于生产环境的 API 端点，以与该智能体交互。这些端点既支持流式响应，也支持在任意时刻获取对话线程（thread）的当前状态。

LangGraph Platform also contains LangGraph Studio, an IDE for visualizing and interacting with the agent once deployed. It also seamlessly integrates with LangSmith, which was a crucial part of Captide's workflow.

LangGraph 平台还内置了 LangGraph Studio——一个专用于可视化和交互式调试已部署智能体的集成开发环境（IDE）。此外，它与 LangSmith 无缝集成，而 LangSmith 正是 Captide 工作流中不可或缺的关键环节。

For these reasons, it was an easy decision to adopt LangGraph Platform.

正因上述优势，采用 LangGraph 平台成为了一个水到渠成的决定。

## Looking Ahead: The Future of Financial Analysis

## 展望未来：金融分析的新图景

As Captide continues to redefine financial analysis, its integration with LangChain remains a driving force behind its progress. The platform is poised to expand its NLP capabilities, focusing on state management and self-validation loops to enhance accuracy and reliability further.

随着 Captide 持续重塑金融分析范式，其与 LangChain 的深度集成始终是推动其不断前行的核心动力。该平台将进一步拓展自然语言处理（NLP）能力，重点强化状态管理（state management）与自验证循环（self-validation loops），从而进一步提升分析结果的准确性与可靠性。

Captide is not just transforming how financial analysts work but also setting a new standard for the industry. Built on the capabilities of LangGraph and LangSmith, Captide is paving the way for a smarter, more effective future in financial analysis.

Captide 不仅正在变革金融分析师的工作方式，更在为整个行业树立全新标杆。依托 LangGraph 与 LangSmith 的强大能力，Captide 正引领金融分析迈向更智能、更高效的新未来。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_002.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 与 LangSmith，利用 AI 智能体重塑客户体验](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 与 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业支持赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-captide-is-redefining-equity-research-with-agentic-workflows-running-on-lang/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟