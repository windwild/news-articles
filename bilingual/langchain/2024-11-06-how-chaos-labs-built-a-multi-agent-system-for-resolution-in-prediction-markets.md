---
title: "How Chaos Labs built a multi-agent system for resolution in prediction markets"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/"
date: "2024-11-06"
scraped_at: "2026-03-03T07:50:15.028854144+00:00"
language: "en-zh"
translated: true
---

**_Editor's Note: one of the most common use cases we've seen for LangGraph is complex research agents. This guest blog post by_** [**_Chaos Labs_**](https://chaoslabs.xyz/?ref=blog.langchain.com) **_highlights a great example of that. It utilizes multiple sources and complex architecture to do research that would power resolution in prediction markets. For those unfamiliar with prediction markets: prediction markets are resolved via an "oracle" that determines outcomes and resolves bets. Edge AI Oracle is an LLM based system that does just that._**

**编者按：** 我们观察到 LangGraph 最常见的应用场景之一是构建复杂的调研型智能体（research agents）。本文为 Chaos Labs 撰写的客座博客，正是这一类应用的绝佳范例。该系统整合了多个信息源，并采用复杂架构开展深度研究，从而为预测市场（prediction markets）中的事件裁决提供支撑。对于不熟悉预测市场的读者：预测市场通过一种称为“预言机”（oracle）的机制来裁定事件结果并结算投注。Edge AI Oracle 正是一款基于大语言模型（LLM）构建的此类预言机系统。

Today, we’re excited to announce the **alpha release of Edge AI Oracle**. Built using the latest advancements in LLMs, Edge AI Oracle orchestrates a multi-agent council, built on LangChain and LangGraph, that maximizes objectivity, transparency, and efficiency in **query resolution**. A core initial application of this is for **prediction markets**.

今天，我们非常高兴地宣布 **Edge AI Oracle 的 Alpha 版本正式发布**。该系统依托大语言模型（LLM）领域的最新进展构建，基于 LangChain 和 LangGraph 编排了一个多智能体委员会（multi-agent council），在 **查询裁决（query resolution）** 过程中最大程度地保障客观性、透明度与效率。其核心初始应用场景即为 **预测市场**。

/1:28

1×

### How Edge AI Oracle Works

### Edge AI Oracle 的工作原理

**Edge AI** enables precise, traceable, and reliable resolutions on virtually any topic, from _“Who won the election?”_ to _“How many goals did Messi score?”_ and _“Who are the latest Nobel Prize winners?”_ Unlike traditional oracles, Edge AI Oracle processes each query through an **AI Oracle Council**—a decentralized network of agents powered by diverse models from providers like OpenAI, Anthropic, and Meta. This architecture ensures each resolution is objective, accurate, and fully explainable, making it ideal for high-stakes prediction markets.

**Edge AI** 能够对几乎任何主题——从 _“谁赢得了本次选举？”_、_“梅西进了几个球？”_ 到 _“最新的诺贝尔奖得主是谁？”_ ——实现精准、可追溯且可靠的裁决。与传统预言机不同，Edge AI Oracle 通过一个 **AI 预言机委员会（AI Oracle Council）** 处理每个查询：该委员会是一个去中心化的智能体网络，由来自 OpenAI、Anthropic、Meta 等厂商的多种大模型共同驱动。这种架构确保每一次裁决都具备客观性、准确性与完全可解释性，因而尤为适用于高风险、高价值的预测市场。

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_001.png)

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_001.png)

This decentralized model allows Edge AI to sidestep the limitations and bias of single-model solutions, providing a multi-perspective, bias-filtered approach to query resolution.

这一去中心化模型使 Edge AI 能够规避单模型方案固有的局限性与偏见，为查询裁决提供一种多视角、经偏见过滤的综合决策路径。

For the Wintermute Election market, we’ve set the Council to require unanimous agreement with over 95% confidence from each Oracle AI Agent.

在 Wintermute 选举预测市场中，我们设定该委员会须达成**全体一致意见**，且每位 Oracle AI 智能体均需以**超过 95% 的置信度**支持该结论。

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_002.png)

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_002.png)

Consensus requirements are fully configurable on a per-market basis, and with the upcoming Beta release, developers and market creators will have autonomous control over these settings.

共识要求可在每个市场基础上完全自定义；随着即将发布的 Beta 版本，开发者与市场创建者将对这些设置拥有自主控制权。

# Architecture: Decentralized AI Oracle Council and Multi-Agent Orchestration

# 架构：去中心化 AI 预言机委员会与多智能体协同编排

The architecture of Edge AI Oracle is built to tackle three fundamental challenges of truth-seeking oracles:

Edge AI Oracle 的架构旨在应对“求真型预言机”的三大根本性挑战：

- **Prompt Optimization**  
- **Prompt 优化**

- **Single Model Bias**  
- **单一模型偏差**

- **Retrieval Augmented Generation (RAG)**.  
- **检索增强生成（RAG）**

Hosted on the **Edge Oracle Network** and powered by LangChain and LangGraph, the system leverages advanced multi-agent orchestration to enhance query accuracy and reliability.

该系统部署于 **Edge Oracle 网络**之上，由 LangChain 和 LangGraph 驱动，通过先进的多智能体协同编排机制，提升查询结果的准确性与可靠性。

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_003.png)

**Entry Point - Research Analyst**: The workflow begins with the _research\_analyst_, which reviews the query, identifying key data points and required sources.

**入口节点——研究分析师（Research Analyst）**：工作流始于 _research\_analyst_ 智能体，它负责审阅用户查询，识别关键数据点及所需信息来源。

**Web Scraper**: The query is then passed to the _web\_scraper_, which retrieves data from external sources and databases and prioritizes reputable, verified information.

**网络爬虫（Web Scraper）**：查询随后交由 _web\_scraper_ 智能体处理，该智能体从外部来源和数据库中抓取数据，并优先选用权威、经验证的信息。

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_004.png)

**Document Relevance Analyst**: The _document\_bias\_analyst_ reviews the gathered data, applying filters and checking for bias, ensuring the data pool remains neutral and credible.

**文档相关性分析师（Document Relevance Analyst）**：_document\_bias\_analyst_ 智能体对已收集的数据进行复核，应用过滤规则并检测潜在偏差，确保数据池保持中立性与可信度。

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_005.png)

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_005.png)

**Report Writer**: The _report\_writer_ synthesizes findings into a cohesive report, presenting an initial answer based on the research and analysis conducted.

**报告撰写员（Report Writer）**：`report_writer` 将各项研究与分析结果整合为一份逻辑连贯的报告，并基于该研究与分析提出初步答案。

**Summarizer**: The _summarizer_ condenses the report, distilling the key insights and findings into a concise form suitable for final processing.

**摘要生成员（Summarizer）**：`summarizer` 对报告进行压缩提炼，将核心洞见与关键发现凝练为简洁形式，以适配最终处理环节。

**Classifier**: Finally, the _classifier_ evaluates the summarized output, categorizing and validating it against preset criteria before reaching the END of the workflow.

**分类器（Classifier）**：最后，`classifier` 对摘要输出进行评估，依据预设标准对其进行归类与验证，随后抵达工作流的 **END（终止节点）**。

Each stage is executed sequentially, ensuring that data flows systematically from one agent to the next, enhancing transparency and accuracy in query resolution.

各阶段按顺序依次执行，确保数据在智能体之间系统化、有序地流转，从而提升查询解析过程的透明度与准确性。

# LangChain and LangGraph: Multi-Agent Orchestration Framework

# LangChain 与 LangGraph：多智能体协同编排框架

**LangChain** and **LangGraph** form the core of Edge AI Oracle’s multi-agent system, making it possible to orchestrate complex, stateful interactions and optimize query resolution. With **LangChain’s adaptable components**—from prompt templates to retrieval tools and output parsers—each Oracle agent can handle tasks independently while seamlessly integrating with other agents in the workflow. **LangGraph** then builds on this structure by enabling directed, cyclical workflows across agents, ensuring a well-coordinated, step-by-step process that is critical to achieving high accuracy and transparency in data resolution.

**LangChain** 与 **LangGraph** 构成了 Edge AI Oracle 多智能体系统的核心，使其能够编排复杂、有状态的交互流程，并优化查询解析效率。借助 **LangChain 的可适配组件**——从提示词模板（prompt templates）、检索工具（retrieval tools）到输出解析器（output parsers）——每个 Oracle 智能体均可独立完成任务，同时又能与工作流中的其他智能体无缝集成。**LangGraph** 则在此基础上进一步拓展，支持跨智能体的有向循环式工作流（directed, cyclical workflows），从而保障整个流程协调有序、步步推进，这对实现高精度与高透明度的数据解析至关重要。

- **LangChain Components**: LangChain supplies the essential building blocks to retrieve, organize, and structure data within each agent, allowing us to maintain high-quality, bias-filtered responses. Importantly, LangChain serves as a flexible gateway to multiple frontier models, providing a unified API and interface that simplifies extending support to various LLMs. This capability empowers Edge AI Oracle to leverage a diverse set of LLMs, ensuring balanced perspectives within the Oracle Council while minimizing individual model biases.

- **LangChain 组件**：LangChain 提供了在各智能体内检索、组织与结构化数据所必需的基础构件，使我们得以持续输出高质量、经偏差过滤的响应。尤为重要的是，LangChain 充当了一个灵活的接入网关，可统一对接多种前沿大模型（frontier models），提供标准化的 API 与接口，极大简化了对各类大语言模型（LLM）的支持扩展工作。这一能力使 Edge AI Oracle 能够融合多样化的 LLM，既保障“Oracle 理事会”内部观点的平衡性，又有效抑制单个模型固有的偏差。

- **LangGraph Workflow**: LangGraph’s graph-based structure and stateful interactions enable the precise **multi-agent orchestration** that powers the Decentralized AI Oracle Council. A directed, cyclical workflow allows each agent to build on the work of others, coordinating Oracle agents from initial research to final consensus in a structured flow:
  - **Workflow Breakdown**:
    - The workflow begins with the _research\_analyst_ node, where initial data gathering and query parsing occur.
    - The agent moves to the _web\_scraper_, gathering relevant, reputable data from external sources.
    - A _document\_bias\_analyst_ then filters out any potential biases within the retrieved data.
    - This leads to the _report\_writer_, who synthesizes findings into a coherent report.
    - Finally, a _summarizer_ distills the report into concise conclusions, which the _classifier_ evaluates before reaching the workflow’s END.

- **LangGraph 工作流**：LangGraph 基于图结构（graph-based structure）与有状态交互（stateful interactions），实现了精准的 **多智能体协同编排（multi-agent orchestration）**，为去中心化 AI Oracle 理事会提供底层支撑。其有向循环式工作流使各智能体能够基于前序智能体的工作成果持续推进，在结构化流程中协同完成从初始研究到最终共识的全过程：
  - **工作流分解（Workflow Breakdown）**：
    - 工作流始于 `_research_analyst` 节点，执行初始数据采集与查询解析；
    - 随后进入 `_web_scraper` 节点，从外部可信信源抓取相关数据；
    - 接着由 `_document_bias_analyst` 节点对所获数据进行偏差筛查，剔除潜在偏见；
    - 此后交由 `_report_writer` 节点，将分析结果整合为逻辑清晰的报告；
    - 最终由 `_summarizer` 节点提炼报告核心结论，再经 `_classifier` 节点评估验证，最终抵达工作流的 **END（终止节点）**。

**See the graphics above for more insight as to how these steps work.**

**请参阅上方图示，以更直观地理解上述各步骤的具体运作方式。**

Through LangGraph’s edge-based orchestration, each task is smoothly handed off to the next, ensuring a cohesive and logical resolution process.

依托 LangGraph 基于边（edge-based）的协同编排机制，每一项任务均被平滑移交至下一环节，从而确保整个解析过程高度连贯、逻辑严谨。

### Building the Future of Truth-Seeking AI Oracles

### 构建面向真相探索的 AI 预言机之未来

The alpha release of Edge AI Oracle marks a significant leap forward in developing a reliable, objective Oracle system. With the latest innovations in LangChain and LangGraph, Edge AI Oracle is poised to transform blockchain security, prediction markets, and decentralized data applications by providing a scalable, multi-agent, truth-seeking Oracle.

Edge AI Oracle 的 Alpha 版本发布，标志着构建可靠、客观的预言机系统迈出了重要一步。依托 LangChain 和 LangGraph 的最新技术突破，Edge AI Oracle 将通过提供可扩展、多智能体、面向真相探索的预言机能力，彻底变革区块链安全、预测市场以及去中心化数据应用。

Read more about Chaos Labs [here](https://chaoslabs.xyz/?ref=blog.langchain.com).

更多关于 Chaos Labs 的信息，请点击[此处](https://chaoslabs.xyz/?ref=blog.langchain.com)了解。