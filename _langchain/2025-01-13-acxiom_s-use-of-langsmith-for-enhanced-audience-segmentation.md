---
render_with_liquid: false
title: "Acxiom's use of LangSmith for enhanced audience segmentation"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-acxiom/"
date: "2025-01-13"
scraped_at: "2026-03-03T07:44:51.618558267+00:00"
language: "en-zh"
translated: true
description: "See how Acxiom debugged their agent application with LangSmith and built a scalable solution for their user base, complete with long-term memory, dynamic updates, and attribute-specific search."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

[Acxiom](https://www.acxiom.com/?ref=blog.langchain.com) ® 是全球客户智能与 AI 驱动型数据营销领域的领导者。作为宏盟集团（Interpublic, Inc.，IPG）旗下企业，Acxiom 专注于高性能解决方案，助力全球顶级品牌与广告代理机构提升客户获取与留存能力，并驱动业务增长。依托其 AI 赋能的身份识别基础架构、基于云的数据管理平台，以及营销技术（martech）与分析服务，Acxiom 已彻底重塑全渠道营销战略与执行方式。五十多年来，Acxiom 分布于美国、英国、德国、中国、波兰和墨西哥的团队持续帮助各类企业优化营销与广告投入，同时始终将客户隐私保护置于首位。

## **规模化 AI 驱动受众细分面临的关键挑战**

作为数据与消费者身份解决方案领域的领军者，Acxiom 持续探索创新方法，以精准识别并交付营销所需的受众细分群体。当 Acxiom 的数据与身份数据科学团队受命评估大语言模型（LLM）在动态受众构建中的应用潜力时，他们面临一系列独特挑战：如何构建一个可扩展、高鲁棒性的生成式 AI 解决方案，以用户自然语言输入为依据，自动生成高质量受众细分。

该团队最初开发了一套提示词（prompt）输入/输出日志系统，用于追踪和排查 LLM 调用问题。然而，随着用户规模不断扩大，团队意识到此类轻量级日志方案难以有效扩展。他们亟需一个功能完备的可观测性平台，以切实支撑代理（agent）应用日益增长的用户需求。Acxiom 的核心目标是：通过标注机制简化单元测试的编写流程，并显著提升故障排查效率。

Acxiom 致力于打造一款能够理解用户自然语言输入、并据此从其海量数据目录中生成精细受众细分的应用程序。例如，用户可能提出如下请求：_“请识别一类受众：30 岁以上的男性，热爱攀岩或徒步，但尚未结婚。”_ 该应用程序需完成两项关键任务：（1）输出一个 JSON 结构，其中包含来自 Acxiom 交易型与预测型数据产品的精选 ID 及对应属性值；（2）满足以下三方面要求：

- **对话式记忆（Conversational memory）**：具备长期记忆能力，可在不同用户会话之间维持上下文连贯性，从而支撑多轮、非连续的受众构建过程；
- **动态更新（Dynamic updates）**：支持在单次会话过程中对已生成的受众细分进行实时细化或调整；
- **数据一致性（Data consistency）**：执行精准的属性级检索，且不会遗忘或“幻觉”（hallucinate）此前已处理的信息。

初期，团队基于 LangChain 的检索增强生成（RAG）工具，并辅以自定义的代理逻辑代码，设计了一套工作流。该 RAG 工作流仅利用 Acxiom 核心数据产品的元数据及其详尽描述的数据字典。然而，随着解决方案规模扩大，新的痛点随之浮现，主要包括：

- **复杂调试（Complex debugging）**：LLM 推理过程中的任何失败或遗漏，均会逐层传导，最终导致错误结果或内容幻觉；
- **扩展性瓶颈（Scaling issues）**：原有日志机制能力有限，难以支撑多用户并发场景下的可观测性需求；
- **需求持续演进（Evolving requirements）**：新功能不断迭代上线，使得基于代理（agent-based）的架构日趋复杂，开发与维护难度陡增。

## **借助 LangSmith 实现可扩展的大语言模型可观测性**

为应对上述挑战，Acxiom 引入了 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) —— 由 LangChain 团队研发的大语言模型测试与可观测性平台。LangSmith 提供了关键的可观测性能力，显著提升了调试效率与系统可扩展性；同时，它无缝兼容 Acxiom 混合式技术生态，包括开源模型、私有化部署模型，以及基于 LangChain 原语构建的自定义代理代码。

LangSmith integrated with Acxiom’s existing LangChain-based codebase with little additional effort. With its simple decorators, LangSmith provided the Acxiom team full visibility into LLM calls, function executions, and utility workflows so they could troubleshoot issues efficiently. LangSmith’s flexible support for a wide range of models — including open-source vLLM, Claude via AWS Bedrock, and Databricks’ model endpoints — also allowed Acxiom to continue using their existing technology stack without disruption.

LangSmith 与 Acxiom 现有的基于 LangChain 的代码库实现了低开销集成。凭借其简洁的装饰器（decorators），LangSmith 为 Acxiom 团队提供了对大语言模型（LLM）调用、函数执行及工具工作流的完整可观测性，从而显著提升了问题排查效率。LangSmith 对多种模型的灵活支持——包括开源的 vLLM、通过 AWS Bedrock 调用的 Claude，以及 Databricks 提供的模型端点——也使 Acxiom 能够在不中断现有技术栈的前提下持续使用原有基础设施。

To gain a deeper understanding of complex workflows and to troubleshoot, the tree-structured trace visualization and metadata tracking tools in LangSmith were particularly helpful. These helped the Acxiom team identify bottlenecks in requests that involved more than 60 LLM calls and 200k tokens for a single user interaction.

为深入理解复杂工作流并高效排障，LangSmith 提供的树状结构追踪可视化（trace visualization）与元数据追踪（metadata tracking）工具尤为关键。这些工具帮助 Acxiom 团队精准识别出单次用户交互中涉及逾 60 次 LLM 调用、总计超 20 万 token 的请求瓶颈所在。

As Acxiom’s workflow evolved, LangSmith’s scalability proved invaluable. The platform’s ability to log and annotate arbitrary code allowed the team to adapt as new agents, such as an overseer and researcher agent, were added to the architecture for more nuanced decision-making related to audience-building.

随着 Acxiom 工作流的演进，LangSmith 的可扩展性展现出巨大价值。该平台支持对任意代码进行日志记录与标注的能力，使团队能够灵活适配架构升级——例如新增“监管代理”（overseer agent）和“研究代理”（researcher agent）等新智能体，以支撑更精细的受众构建（audience-building）决策。

## **Impact**

## **成效**

With LangSmith, Acxiom’s engineers achieved significant improvements across their application for building more refined audience segments in several ways:

借助 LangSmith，Acxiom 工程师在其受众细分（audience segmentation）应用中，从多个维度实现了显著提升：

- **Streamlined debugging for campaign optimization**: LangSmith’s deep visibility into nested LLM calls and RAG agents simplified troubleshooting and accelerated the development of more refined audience segments for marketing campaigns.

- **面向营销活动优化的调试流程简化**：LangSmith 对嵌套式 LLM 调用与 RAG 智能体的深度可观测性，大幅简化了问题定位过程，并加速了面向营销活动的精细化受众细分方案的开发。

- **Improved audience reach**: The platform’s hierarchical agent architecture led to more accurate and dynamic audience segment creation, enabling Acxiom to deliver more relevant, data-driven recommendations for marketing strategies.

- **拓展受众覆盖能力**：该平台分层式智能体架构，推动了更精准、更动态的受众细分生成，助力 Acxiom 为营销策略提供更具相关性、更以数据为驱动的推荐方案。

- **Scalable growth for marketing initiatives**: The system could handle increasing user demands and complexity without needing to reengineer the observability layer.

- **支撑营销计划的规模化增长**：系统可在无需重构可观测性层的前提下，从容应对不断增长的用户需求与业务复杂度。

- **Optimized token usage**: Visibility into token and call usage informed cost management strategies for the Acxiom team’s hybrid model approach.

- **优化 token 使用效率**：对 token 消耗量与调用次数的清晰可见性，为 Acxiom 团队制定混合模型（hybrid model）方案下的成本管控策略提供了有力依据。

## **Conclusion**

## **总结**

By integrating with LangSmith, Acxiom successfully overcame the challenges of building a generative AI-based audience segmentation system. The platform’s flexibility and robust observability features enabled Acxiom to transform a complex technical vision into a scalable, user-friendly application that not only meets the demands of a growing user base but also drives better marketing precision.

通过集成 LangSmith，Acxiom 成功攻克了构建生成式 AI 驱动的受众细分系统的各项挑战。该平台所具备的灵活性与强大的可观测性能力，助力 Acxiom 将一项复杂的技术构想，转化为一款可规模化扩展、用户体验友好的应用——它不仅满足日益扩大的用户群体需求，更切实提升了营销决策的精准度。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)  
[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_002.png)](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[![吉姆多（Jimdo）如何借助 AI 驱动的商业支持赋能个体创业者](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**吉姆多（Jimdo）如何借助 AI 驱动的商业支持赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员工作状态的可视化洞察](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员工作状态的可视化洞察**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 与 LangSmith 构建数据与 AI 可观测性智能体](images/acxiom_s-use-of-langsmith-for-enhanced-audience-segmentation/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 与 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟