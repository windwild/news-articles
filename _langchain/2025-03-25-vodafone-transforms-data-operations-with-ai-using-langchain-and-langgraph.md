---
title: "Vodafone transforms data operations with AI using LangChain and LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-vodafone/"
date: "2025-03-25"
scraped_at: "2026-03-03T07:36:49.555765180+00:00"
language: "en-zh"
translated: true
description: "See how Vodafone, a leading telecom company serving 340M+ customers, used LangChain and LangGraph for its performance metrics monitoring and information retrieval chatbots."
tags: ["Case Studies"]
---
{% raw %}

Vodafone is a leading European and African telecommunications company, serving over 340 million customers. Its services span mobile and fixed networks and services, IoT, and enterprise solutions, with a strong emphasis on innovation. In the AI and data space, Vodafone is solving complex challenges related to real-time performance analysis, infrastructure management, and operational efficiency for its network of data centers in Europe.

沃达丰（Vodafone）是欧洲和非洲领先的电信公司，服务客户逾3.4亿。其业务涵盖移动与固网通信及服务、物联网（IoT）以及企业解决方案，高度重视创新。在人工智能与数据领域，沃达丰正着力解决与其欧洲数据中心网络相关的实时性能分析、基础设施管理及运营效率等复杂挑战。

To streamline data operations and to empower its engineering teams, Vodafone has built several AI assistants using LangChain and LangGraph that facilitate intelligent data access, natural language-driven insights, and complex problem-solving.

为简化数据运维流程并赋能工程团队，沃达丰基于 LangChain 和 LangGraph 构建了多个 AI 助手，以实现智能化数据访问、自然语言驱动的洞察生成，以及复杂问题的求解能力。

## **Vodafone’s GenAI Applications**

## **沃达丰的生成式 AI 应用**

Currently, Vodafone has developed two AI-powered internal chatbots, which are deployed on Google Cloud to support engineers working in multiple operations across its data centers. These AI assistants help Vodafone improve the customer experience:

目前，沃达丰已开发出两款由 AI 驱动的内部聊天机器人，部署于 Google Cloud 平台，为分布在其各数据中心、从事多项运维工作的工程师提供支持。这些 AI 助手助力沃达丰提升客户体验：

- **Performance metrics monitoring (Insight Engine):** This assistant analyzes performance metrics by converting natural language queries into SQL to retrieve key data from data centers monitoring systems. This supports engineers and operations staff with dynamic, data-driven insights that were previously accessible only through custom dashboards.

- **性能指标监控（Insight Engine）：** 该助手将自然语言查询自动转换为 SQL 语句，从数据中心监控系统中提取关键数据，从而对性能指标进行分析。它为工程师与运维人员提供了动态、数据驱动的洞察——此前，此类洞察仅能通过定制化仪表盘获取。

- **Information retrieval from MS-Sharepoint (Enigma):** This assistant enables efficient access to thousands of technical documents and resources. Engineers can ask questions to verify specific designs, retrieve inventory details, or identify contacts within the organization— reducing time spent sifting through documentation.

- **从 Microsoft SharePoint 检索信息（Enigma）：** 该助手支持高效访问数千份技术文档与资源。工程师可通过提问方式验证特定设计方案、检索库存详情，或查找组织内部相关人员，大幅减少人工翻阅文档所耗费的时间。

With these agents, Vodafone can diagnose and respond to incidents faster by dynamically creating views of data to support quick and more accurate decision-making. As a result, this has reduced engineers’ reliance on custom dashboards or queries to see performance metrics, providing them with deeper insights into internal resources.

借助这些智能体（agents），沃达丰能够通过动态构建数据视图，更快地诊断并响应各类事件，从而支撑更快速、更精准的决策。由此，工程师对定制化仪表盘或手动编写查询语句来查看性能指标的依赖显著降低，同时获得了关于内部资源更深层次的洞察。

## **Flexibly building RAG pipelines with LangChain**

## **借助 LangChain 灵活构建 RAG 流水线**

Vodafone adopted LangChain for these GenAI initiatives due to its composable and comprehensive framework. LangChain’s integration of essential components like document loaders, models, and vector database allowed Vodafone to rapidly prototype and deploy AI applications tailored to their use case. Vodafone leveraged LangChain to experiment with multiple LLMs, including OpenAI’s models, LLaMA 3, and Google’s Gemini, optimizing performance for each specific use case.

沃达丰选择 LangChain 推进上述生成式 AI 项目，正是看中其模块化、高度可组合且功能完备的框架特性。LangChain 将文档加载器（document loaders）、大语言模型（LLMs）及向量数据库等核心组件无缝集成，使沃达丰得以快速完成原型开发与应用部署，并针对自身具体场景量身定制 AI 解决方案。沃达丰利用 LangChain 对多种大语言模型展开实验，包括 OpenAI 的系列模型、LLaMA 3 及 Google 的 Gemini，从而为每类应用场景优化模型性能。

Specifically, the document loader helped Vodafone’s engineers process a variety of documents — from HLD, Blueprints and Request for Proposals (RFPs) — that would be onboarded into the multi-vector DB. Through RAG pipelines, these are then converted into actionable insights by their information retrieval assistant, producing images, tables, and other information needed by the end user.

具体而言，文档加载器帮助沃达丰工程师高效处理各类文档——包括高层设计文档（HLD）、系统架构蓝图（Blueprints）及招标文件（RFPs）等——并将它们统一接入多向量数据库（multi-vector DB）。再经由 RAG 流水线，其信息检索助手即可将这些结构化与非结构化内容转化为可操作的洞察，最终向终端用户输出图表、表格及其他所需信息。

LangChain reduced development time by providing ready-made tools for document processing and pipeline testing. It also enabled Vodafone to benchmark LLM performance effectively across various pipelines.

LangChain 通过提供开箱即用的文档处理与流水线测试工具，显著缩短了开发周期；同时也助力沃达丰在不同 RAG 流水线中高效开展大语言模型性能基准测试（benchmarking）。

> _“We’ve been using LangChain’s components for over a year now,”_ said Antonino Artale, senior manager of Cloud Solutions, Orchestration and Intelligence.  
> _“It’s been a critical enabler for our transition from open-source experimentation to production-grade AI systems.”_  

> “我们已使用 LangChain 的组件超过一年时间。”沃达丰云解决方案、编排与智能高级经理安东宁诺·阿尔塔莱（Antonino Artale）表示。  
> “它是我们从开源实验阶段迈向生产级 AI 系统的关键赋能者。”

## **Scaling multi-agent workflows with LangGraph**

## **借助 LangGraph 扩展多智能体工作流**

As Vodafone scaled its GenAI capabilities, the company’s teams turned to LangGraph to implement a multi-agent architecture and build more sophisticated AI systems. LangGraph’s flexibility and focus on controllable agent frameworks allowed the team to go beyond simple agents, developing complex workflows with inter-agent coordination.

随着沃达丰不断扩展其生成式 AI（GenAI）能力，公司各团队转而采用 LangGraph 来构建多智能体架构，并打造更复杂的 AI 系统。LangGraph 具备高度灵活性，且专注于可控制的智能体框架，使团队得以突破简单智能体的局限，开发出具备智能体间协同能力的复杂工作流。

The Vodafone team leveraged LangGraph for its:

沃达丰团队之所以选用 LangGraph，主要基于以下优势：

- **Modular agent design:** Vodafone used LangGraph to construct modular agents as subgraphs, each has certain tools responsible for a specific task. This architecture made it easy to add new capabilities, such as Data collection modules, processing modules, report generators and advanced reasoning using RAG pipelines, without redesigning the entire system.  
- **模块化智能体设计：** 沃达丰利用 LangGraph 将智能体构建为子图（subgraph），每个子图配备特定工具，专责执行某项任务。该架构使得新增功能（如数据采集模块、数据处理模块、报告生成器，以及基于 RAG 流水线的高级推理能力）变得极为便捷，无需对整个系统进行重构。

- **API integration:** The ability to quickly deploy APIs with LangGraph ensured seamless integration into Vodafone’s broader ecosystem, allowing the AI agents to dynamically orchestrate their own tools based on event-driven architectural patterns.  
- **API 集成能力：** 借助 LangGraph 快速部署 API 的能力，AI 智能体得以无缝融入沃达丰更广泛的生态系统；同时，智能体可根据事件驱动型架构模式，动态编排自身所调用的各类工具。

- **Reliable agent performance:** LangGraph’s validation tools helped Vodafone test multi-agent workflows and ensure consistent performance through validating the different workflow states, verification of node connections, and measuring node latency.  
- **可靠的智能体性能：** LangGraph 提供的验证工具助力沃达丰对多智能体工作流开展全面测试，通过校验不同工作流状态、验证节点连接关系以及测量节点延迟等方式，保障系统性能稳定一致。

An example of LangGraph’s value is its role in configuring multi-agent workflows for multi-agent Insight Engine and Enigma. LangGraph is placed after the user prompt where it will understand the intent of the user query and orchestrate the request to the appropriate chain.

LangGraph 价值的一个典型例证，体现在其为多智能体 Insight Engine 和 Enigma 配置多智能体工作流的过程之中。LangGraph 被部署于用户输入提示（user prompt）之后，负责理解用户查询意图，并将请求调度至相应的工作链（chain）。

In the case of Enigma, if the query is related to document summarization, the agent will direct the request to the appropriate chain. In turn, this will fetch the relevant context from the multi-vector DB and present the grounded summary response to the user.

以 Enigma 为例：若用户查询涉及文档摘要，则智能体会将请求路由至对应的工作链；该工作链随即从多向量数据库（multi-vector DB）中提取相关上下文，并向用户提供有依据支撑的摘要响应。

![](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_001.jpg)

![](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_001.jpg)

In the case of Insight Engine, if the query is related to inventory data, then the agent will direct the request to a NL2SQL chain that will convert the NL query to a SQL query and send the response back to the agent. The agent will then forward the request to another query processing chain that will query the inventory DB, receive the result, and then pass the information to a LLM to create graphs and charts based on the query response.

在 Insight Engine 场景下，若用户查询涉及库存数据，智能体便会将请求转发至 NL2SQL 工作链——该链负责将自然语言（NL）查询转换为 SQL 查询，并将结果返回给智能体；随后，智能体再将请求交由另一条查询处理工作链，后者访问库存数据库、获取查询结果，并将数据传递给大语言模型（LLM），最终依据查询响应生成图表。

![](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_002.jpg)

![](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_002.jpg)

In summary, LangGraph powered both multi-agent workflows for the Vodafone team:

总而言之，LangGraph 为沃达丰（Vodafone）团队的多智能体工作流提供了强大支持：

- **Enigma** \| This agent seamlessly integrates with Knowledge Hub. It employs a vector database that enables faster and accurate context retrieval across documents, providing more context to the LLM and allowing it to deliver more informed and accurate answers.  
- **Enigma** \| 该智能体与知识中心（Knowledge Hub）无缝集成，采用向量数据库，实现跨文档的快速、精准上下文检索，从而为大语言模型（LLM）提供更丰富的上下文信息，使其能够输出更明智、更准确的回答。

- **Insight Engine** \| This agent performs seamless query transformation, effortlessly converting natural language queries into structured formats such as SQL, NoSQL, and other services. It shall also ensure efficient data retrieval by quickly accessing data center performance metrics, inventory, and detected anomalies using advanced machine learning techniques. Moreover, passing the results to another agent responsible for generating custom visualizations.  
- **洞察引擎（Insight Engine）** \| 该智能体执行无缝查询转换，可轻松将自然语言查询转化为结构化格式（如 SQL、NoSQL 及其他服务接口）。它还借助先进的机器学习技术，快速访问数据中心性能指标、库存数据及已检测到的异常，确保高效的数据检索；此外，还将检索结果传递给另一负责生成定制化可视化图表的智能体。

## **Future plan to power LLM apps with LangSmith**

## **未来计划：利用 LangSmith 赋能大语言模型应用**

LangSmith offers an all-in-one solution for the entire application lifecycle, including debugging, evaluation, and performance tracking. This makes it particularly useful for large-scale, production-ready applications, allowing for better insights into the inner workings of LLMs.

LangSmith 为整个应用生命周期（包括调试、评估与性能追踪）提供一站式解决方案。这使其特别适用于大规模、面向生产的应用，有助于更深入地洞察大语言模型（LLM）的内部运行机制。

Additionally, LangSmith supports collaboration between developers and subject matter experts, ensuring that applications are not only functional but also aligned with user needs. By integrating seamlessly with existing workflows, LangSmith empowers teams to iterate quickly and effectively, ultimately leading to more reliable and robust AI solutions.

此外，LangSmith 支持开发者与领域专家之间的协同合作，确保所构建的应用不仅功能完备，而且切实契合用户需求。通过与现有工作流无缝集成，LangSmith 赋能团队快速、高效地完成迭代，最终打造出更可靠、更稳健的 AI 解决方案。

## **Conclusion**

## **总结**

With LangChain, LangGraph and LangSmith, Vodafone has successfully delivered advanced AI-driven solutions to its engineering and operations teams. These tools have enabled:

依托 LangChain、LangGraph 和 LangSmith，沃达丰已成功为其工程与运维团队交付了先进的 AI 驱动型解决方案。这些工具带来了以下成效：

- Reduction in time-to-insight for critical infrastructure issues.  
- 显著缩短关键基础设施问题的“洞察获取时间”（time-to-insight）。

- Enhanced scalability with modular, API-integrated agent designs.  
- 借助模块化、API 集成的智能体设计，显著提升系统可扩展性。

- Future-proofed systems that can easily accommodate new domains and data sources.  
- 构建面向未来的系统架构，可轻松适配新业务领域与数据源。

Looking ahead, Vodafone plans to extend its GenAI pipeline to additional data lakes, build even more sophisticated multi-agent systems, and refine its benchmarking processes for a wider range of AI applications.

展望未来，沃达丰计划将其生成式 AI（GenAI）流水线拓展至更多数据湖，构建更为复杂的多智能体系统，并进一步优化基准测试流程，以覆盖更广泛的人工智能应用场景。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_003.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 完成数千名客户的入职流程](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 完成数千名客户的入职流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/vodafone-transforms-data-operations-with-ai-using-langchain-and-langgraph/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读
{% endraw %}
