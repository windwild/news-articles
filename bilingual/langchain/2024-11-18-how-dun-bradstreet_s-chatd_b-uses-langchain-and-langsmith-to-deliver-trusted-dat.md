---
title: "How Dun & Bradstreet’s ChatD&B™ uses LangChain and LangSmith to deliver trusted, data-driven AI insights"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-dun-bradstreet/"
date: "2024-11-18"
scraped_at: "2026-03-03T07:48:11.265411645+00:00"
language: "en-zh"
translated: true
description: "Learn how Dun & Bradstreet, a leading financial data analytics company, empowers global clients with business data — from credit risk to ownership structures — to make better decisions using thei..."
tags: ["Case Studies"]
---

[Dun & Bradstreet (D&B)](https://www.dnb.com/?ref=blog.langchain.com)，作为全球商业决策数据与分析领域的领军企业，通过提供值得信赖、精心筛选的数据与分析能力，助力企业解决关键业务难题，从而推动明智决策并提升业务成效。D&B 服务遍及全球 200 多个国家/地区的逾 24 万家客户，其“数据云”（Data Cloud）为各类解决方案提供动力，助力企业增加营收、降低成本、管控风险，并实现业务转型。

传统人工智能（AI）与机器学习（ML）长期以来一直是 Dun & Bradstreet 产品体系的重要组成部分，使客户能够从其覆盖全球、包含逾 5.8 亿家企业实体的庞大数据云中，快速提取可落地的业务洞察。近年来，大语言模型（LLM）进一步赋能 Dun & Bradstreet，使其得以依托自身久经验证的专业洞见，全面升级客户交互体验。

与传统聊天机器人不同，ChatD&B——基于 [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) 构建——为用户提供对海量异构数据源的实时访问能力，涵盖结构化与非结构化等多种格式。LangChain 所赋能的自主式 AI 智能体（autonomous AI agents）框架，正从根本上重塑客户价值交付方式：

- **客户用例复杂性**：自主智能体支持以往难以实现的复杂对话场景，例如，同时在多个维度上对比多家企业实体，并生成全局性综合摘要。
- **客户用例多样性**：ChatD&B 覆盖信用风险评估、销售与营销、供应链管理、客户尽职调查（KYC）等广泛业务领域，远超单一功能型聊天机器人的能力边界。
- **可信信息保障**：LangChain 框架将大语言模型与传统工具（如 API）深度融合，扬长避短，显著降低“幻觉”（hallucination）风险。
- **可解释性**：“展示推理过程”（Show your work）功能提供清晰的数据溯源路径，使客户能够直观了解每一项回答所依据的具体数据来源，这是践行负责任 AI 的关键要素。
- **个性化体验**：动态数据权限机制确保每一次交互均精准匹配个体客户的实际需求。

客户反馈显示，该方案大幅节省了操作时间，并实现了此前无法完成的关键业务活动。

## **构建更智能的对话**

ChatD&B 面临的核心挑战，远不止于“回答问题”本身——它必须以真实、准确、可信的数据为支撑，给出答案，同时确保全程透明、可追溯、可解释。Dun & Bradstreet 深知，客户不仅需要信任答案本身，更需清楚看到每个回答背后的推理逻辑；任何错误响应都可能引发后续决策或行动的重大风险，造成高昂代价。

Dun & Bradstreet 首席数据与分析官 Gary Kotvets 表示：

> “我们的‘展示推理过程’框架，使 ChatD&B 中的数据来源与数据血缘关系变得清晰可解释，从而让用户对所呈现信息的质量与有效性充满信心。ChatD&B 的目标，是让用户随时随地、按需规模化地便捷调用我们备受业界推崇的公共及私营企业商业数据。”

正是在此背景下，[LangChain](https://www.langchain.com/?ref=blog.langchain.com) 进入了 Dun & Bradstreet 的技术视野。LangChain 使 Dun & Bradstreet 能够将原始数据动态接入，转化为具备对话能力、富有智能的 AI 助手，并实现实时结果解释。例如，当客户提问：“_位于德克萨斯州的［X 公司］是否属于高信用风险？_”，ChatD&B 不仅返回一个信用评分，更提供全面深入的信息支持：它从诉讼记录、留置权信息、公司治理结构等多个数据维度进行交叉验证，并清晰阐释该评分背后的成因——哪些具体因素正在影响信用评级。这种“展示推理过程”的能力，不仅赋予系统高度可解释性，也成为最受客户青睐的核心功能之一。

[LangChain’s modular structure](https://www.langchain.com/langchain?ref=blog.langchain.com) also allowed the company to inject important contextual information, making ChatD&B more than just a simple Q&A AI assistant. Each tool, from risk assessments to ownership structures, had its own context and understanding. The system could explain, for instance, why a credit score was considered “good” or “bad,” based on real data and predefined scales. Now, customers no longer have to interpret complex datasets by themselves— ChatD&B does the heavy lifting, helping to explain the insights clearly and concisely.

[LangChain 的模块化架构](https://www.langchain.com/langchain?ref=blog.langchain.com) 还使该公司能够注入关键的上下文信息，从而使 ChatD&B 不再仅仅是一个简单的问答式 AI 助手。从风险评估到所有权结构，每个工具都拥有其专属的上下文与理解能力。例如，系统可基于真实数据和预定义评分标准，解释为何某信用分被判定为“良好”或“不佳”。如今，客户无需再自行解读复杂的数据集——ChatD&B 承担了繁重的分析工作，以清晰、简洁的方式帮助用户理解洞察结论。

## **Raising the bar with ChatD&B**

## **以 ChatD&B 重新定义行业标杆**

As ChatD&B expanded in complexity and adoption, the team at Dun & Bradstreet wanted to ensure the AI assistant consistently delivered accurate, grounded results. By integrating [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com), Dun & Bradstreet’s data science team could analyze how the AI was performing, step-by-step. LangSmith allows the team to see and monitor every decision made, compare new queries with historical data, and assess the overall quality of the responses.

随着 ChatD&B 在功能复杂度与用户采纳率上的持续提升，邓白氏（Dun & Bradstreet）团队希望确保该 AI 助手始终输出准确、有据可依的结果。通过集成 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)，邓白氏的数据科学团队得以逐环节分析 AI 的运行表现。LangSmith 使团队能够实时查看并监控每一个决策步骤，将新查询结果与历史数据进行比对，并全面评估响应的整体质量。

For instance, when a user asks for a company’s failure risk, LangSmith allows the Dun & Bradstreet team to trace every action the agent took, providing visibility into the reasoning. This observability is crucial, especially for customers using ChatD&B for high-stakes decisions.

例如，当用户询问某家企业的倒闭风险时，LangSmith 可帮助邓白氏团队完整追溯智能体执行的每一步操作，从而清晰呈现其推理逻辑。这种可观测性至关重要——尤其对于将 ChatD&B 应用于高风险商业决策的客户而言。

LangSmith’s testing features also empowers Dun & Bradstreet to run "what if" scenarios. The team can compare how the system responds to new queries against similar questions asked before, ensuring consistent, high-quality outputs. By building extensive ground-truth data and using LangSmith’s LLM-judge features, the company can continuously improve ChatD&B, refining it with every early adopter user interaction.

LangSmith 的测试功能还赋能邓白氏开展各类“假设性”场景推演。团队可将系统对新查询的响应，与过往相似问题的回答进行横向对比，从而保障输出结果的一致性与高质量。通过构建大规模真实基准数据（ground-truth data），并结合 LangSmith 的大语言模型评判（LLM-judge）功能，邓白氏得以持续优化 ChatD&B，每一次早期用户的交互都在为其精进提供宝贵反馈。

## **The Impact**

## **实际成效**

ChatD&B is enabling a broader range of customer users to access Dun & Bradstreet’s actionable insights through a streamlined, conversational “one-stop shop” interface. Early adopters are already seeing significant time savings and greater satisfaction, as they no longer need to manually sift through multiple products, datasets, or documents. Users are also discovering new capabilities, both immediate—such as quickly retrieving key insights on a supplier before a meeting—and more strategic, like identifying new growth opportunities in innovative ways.

ChatD&B 正通过一个简洁、自然的对话式“一站式”界面，让更广泛的客户群体便捷获取邓白氏所提供的可落地业务洞察。早期采用者已切实感受到显著的时间节省与更高的使用满意度：他们不再需要手动在多个产品、数据集或文档间反复查找与筛选。用户也在不断发掘新的功能价值——既有即时性的应用，例如在会前快速调取某供应商的关键洞察；也有更具战略意义的用途，例如以创新方式识别全新的增长机会。

## **The Road Ahead**

## **未来展望**

Dun & Bradstreet is dedicated to enhancing ChatD&B’s capabilities, continuously exploring new use cases to make it the ultimate conversational assistant for business data. The team will continue to roll out new functionalities to empower confident, data-driven decision-making.

邓白氏致力于持续增强 ChatD&B 的能力，不断探索全新应用场景，力求将其打造为面向企业数据的终极对话式助手。团队将持续推出新功能，助力用户更加自信、高效地开展数据驱动型决策。

The Dun & Bradstreet team is also excited about its ongoing collaboration with LangChain and the powerful advancements LangChain continues to introduce. For instance, [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) enhances the system’s ability to understand complex relationships within data, enabling deeper insights and more precise responses across diverse business contexts.

邓白氏团队亦对与 LangChain 持续深化的合作充满期待，也高度认可 LangChain 不断推出的强大技术进展。例如，[LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) 显著提升了系统对数据内部复杂关系的理解能力，使其可在多元化的商业场景中生成更深层次的洞察与更精准的响应。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_001.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_002.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + 沃达丰：借助 LangGraph 与 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何借助 LangSmith 实现对客户成功智能体的可观测性](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何借助 LangSmith 实现对客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：借助 LangGraph 与 LangSmith 构建数据 + AI 可观测性智能体](images/how-dun-bradstreet_s-chatd_b-uses-langchain-and-langsmith-to-deliver-trusted-dat/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：借助 LangGraph 与 LangSmith 构建数据 + AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟