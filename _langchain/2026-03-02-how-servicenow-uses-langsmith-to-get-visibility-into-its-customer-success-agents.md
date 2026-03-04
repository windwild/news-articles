---
title: "How ServiceNow uses LangSmith to get visibility into its customer success agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-servicenow/"
date: "2026-03-02"
scraped_at: "2026-03-03T07:14:12.814984430+00:00"
language: "en-zh"
translated: true
tags: ["Case Studies"]
---
&#123;% raw %}

**Authors:** _Ganesh Srinivasan (ServiceNow), Linda Ye (LangChain), and Jake Broekhuizen (LangChain)_

**作者：** _甘内什·斯里尼瓦桑（ServiceNow）、琳达·叶（LangChain）和杰克·布鲁克胡伊曾（LangChain）_

ServiceNow is a leading digital workflow platform that helps enterprises transform service management across IT, customer service, and other departments. To improve their internal sales and customer success operations, ServiceNow's AI team is using LangSmith and LangGraph to develop an intelligent multi-agent system that orchestrates the entire customer journey— from lead identification through post-sales adoption and expansion.

ServiceNow 是一家领先的数字化工作流平台，助力企业重塑 IT、客户服务及其他部门的服务管理。为提升其内部销售与客户成功运营效能，ServiceNow 的 AI 团队正借助 LangSmith 和 LangGraph，构建一套智能多智能体系统，全面编排客户全旅程——从线索识别，到售中转化，再到售后采用与业务拓展。

## **Tackling agent fragmentation**

## **应对智能体碎片化问题**

At ServiceNow, agents were deployed across multiple parts of the platform without a single source of truth or unified orchestration layer. This fragmentation made it difficult to coordinate complex workflows that spanned the entire customer lifecycle.

在 ServiceNow，各类智能体被分散部署于平台多个模块中，既缺乏统一的“事实源”（single source of truth），也缺少集中的编排层。这种碎片化状态使得跨客户全生命周期的复杂工作流难以协同。

To transform the sales and customer success operations, ServiceNow decided to build a comprehensive multi-agent system that could handle everything from lead qualification, closing deals through post-sales adoption, renewal, and customer advocacy. This ambitious project required both a robust orchestration framework and deep observability into agent behavior. ServiceNow needed a comprehensive framework to evaluate tool completion, accuracy, and path optimization, along with granular step-by-step tracing for agent debugging.

为彻底变革销售与客户成功运营，ServiceNow 决定构建一套端到端的多智能体系统，覆盖从线索甄别、交易闭环，到售后采用、合同续签及客户倡导等全部环节。这一雄心勃勃的项目亟需一个稳健的编排框架，以及对智能体行为的深度可观测性。ServiceNow 需要一套完整的评估体系，用以衡量工具调用完成度、响应准确性与路径优化效果；同时，还需支持细粒度、逐步骤的执行追踪，以便高效调试智能体。

## **A multi-agent system for customer success workflows**

## **面向客户成功工作流的多智能体系统**

ServiceNow is developing an intelligent agent system that covers both pre-sales and post-sales workflows. In this case study, we’ll cover the pre and post-sales journey, which includes multiple critical stages:

ServiceNow 正在开发一套智能代理系统，全面覆盖售前与售后工作流。本案例研究将聚焦客户售前至售后的完整旅程，涵盖以下多个关键阶段：

- **Lead qualification:** Identify right leads and assist with email and meeting preparations  
- **线索甄别：** 精准识别高潜力线索，并协助准备邮件与会议材料  

- **Opportunity discovery:** To identify cross-sell / up-sell opportunity  
- **商机挖掘：** 识别交叉销售与向上销售机会  

- **Economic Buyer Identification:** Identify the champion economic buyer  
- **经济决策者识别：** 定位具有影响力的核心经济决策者  

- **Onboarding and implementation**: Helping customers deploy ServiceNow platform applications  
- **上线与实施：** 协助客户部署 ServiceNow 平台应用  

- **Adoption tracking**: Monitoring which licensed applications customers are actually using  
- **采用情况追踪：** 监测客户实际启用的已授权应用  

- **Usage and value realization**: Ensuring customers extract real value from the platform  
- **使用与价值实现：** 确保客户切实从平台中获得真实业务价值  

- **Renewal and expansion**: Identifying opportunities for contract renewals or additional licenses  
- **续约与拓展：** 识别合同续签或增购许可的机会  

- **Customer satisfaction and advocacy**: Tracking CSAT scores and developing customer champions  
- **客户满意度与倡导：** 追踪客户满意度（CSAT）评分，并培育客户拥护者  

At each stage, specialized agents determine what actions an Account Executive (AE), seller, or Customer Success Manager (CSM) should take to meet customer requirements. For example, in the adoption stage, agents track application usage and proactively identify opportunities. If a customer isn't realizing expected value, the system pushes the CSM to suggest additional applications that could increase ROI, automatically drafts personalized emails with relevant information, and schedules meetings between the CSM and customer.

在每个阶段，专业化智能体均会判断账户经理（AE）、销售代表或客户成功经理（CSM）应采取哪些具体行动，以满足客户需求。例如，在“采用”阶段，智能体持续追踪应用使用情况，并主动识别潜在机会。若客户未能达成预期价值，系统将主动提示 CSM 推荐可提升投资回报率（ROI）的其他应用，自动生成包含相关信息的个性化邮件，并自动为 CSM 与客户安排会议。

The architecture uses a supervisor agent for orchestration, with multiple specialized subagents handling specific tasks. Different triggers activate the appropriate agents based on customer signals and lifecycle stage, enabling intelligent workflow automation across the customer journey.

该架构采用一个“主管智能体”（supervisor agent）负责整体编排，下设多个承担特定任务的专业化子智能体。系统依据客户信号与所处生命周期阶段，通过不同触发机制动态激活相应智能体，从而实现客户全旅程的智能化工作流自动化。

## **Complex agent orchestration with LangGraph**

## **基于 LangGraph 的复杂智能体编排**

LangGraph 提供了 ServiceNow 所需的底层工具与抽象技术，以实现高度复杂的多智能体协同。ServiceNow 团队在其系统中广泛采用了类似 Map-Reduce 风格的图结构，并全程结合使用 Send API 与子图调用（subgraph calling）。这些功能支持了一种模块化开发方法：团队首先利用 LangGraph 的底层技术构建多个小型子图，再将这些子图作为可复用模块，组合成更大型、功能更完整的图结构。

人机协同（human-in-the-loop）能力在开发阶段尤为宝贵。工程师可在任意节点暂停执行以进行测试，手动批准或回退智能体操作，并针对特定步骤重新输入不同参数启动执行——无需等待整条流程重新运行。这极大降低了开发摩擦，尤其在测试阶段需反复等待大模型响应、延迟显著的情况下，该能力的价值尤为突出。

ServiceNow 已将自身知识图谱（knowledge graph）与模型上下文协议（Model Context Protocol, MCP）深度集成至 LangGraph，从而构建起一套覆盖其全平台的、端到端的智能体编排技术栈。

## **LangSmith tracing: The standout feature for agent development**

## **LangSmith 追踪功能：智能体开发中最亮眼的特性**

LangSmith 提供详尽的追踪能力，可记录智能体编排过程中每一步的输入、输出、所用上下文、延迟及 token 消耗量，帮助用户持续优化智能体性能。其将追踪数据按节点直观划分为“输入”与“输出”，使调试工作远比解析原始日志更加高效便捷。

![](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_001.png)_线索评分系统：邮件草稿生成（注：上方追踪示例不含真实数据）_

ServiceNow 利用 LangSmith 的追踪能力实现以下目标：

- **逐节点调试智能体行为**：精准理解智能体决策逻辑及问题发生的具体位置  
- **全程观测各阶段的输入与输出**：实时查看每个步骤所依赖的上下文、执行延迟及 token 生成情况  
- **构建全面的基准数据集**：从成功运行的智能体实例中提取高质量样本，形成“黄金数据集”（golden datasets），有效防范性能退化（regression）

## **Rigorous evaluation strategy with custom metrics**

## **采用自定义指标的严格评估策略**

ServiceNow implemented a sophisticated evaluation framework in LangSmith tailored to their multi-agent system. Rather than one-size-fits-all metrics, they define custom scorers based on each agent's specific task. Furthermore, they leverage LLM-as-a-judge evaluators to judge the agent responses.

ServiceNow 在 LangSmith 中构建了一套高度精细化的评估框架，专为其实现的多智能体系统（multi-agent system）量身定制。该框架摒弃了“一刀切”的通用评估指标，而是针对每个智能体的具体任务定义定制化评分器（custom scorers）。此外，他们还利用大语言模型（LLM）作为裁判（LLM-as-a-judge）来评估各智能体的响应质量。

For example, an agent that generates automated emails is evaluated on accuracy and content relevance. RAG-specific agents use chunk relevancy and groundedness as primary measures. Each metric has different thresholds to evaluate agent output. The LangSmith UI provides input, output and LLM generated score along with latency and token counts. The UI also helped ServiceNow to see the scores across different experiments.

例如，负责自动生成邮件的智能体，其评估维度聚焦于**准确性**（accuracy）与**内容相关性**（content relevance）；而面向检索增强生成（RAG）场景的智能体，则主要采用**分块相关性**（chunk relevancy）和**事实依据性**（groundedness）作为核心评估指标。每项指标均设有差异化阈值，用于综合判定智能体输出质量。LangSmith 的用户界面（UI）可直观呈现输入、输出、LLM 生成的评分，以及延迟（latency）和 Token 数量等关键性能数据；同时，该界面也助力 ServiceNow 实现跨实验的评分横向对比与趋势分析。

The evaluation workflow includes:

评估工作流程包括：

- **Automated golden dataset creation**: When prompts meet score thresholds for specific agentic tasks, they're automatically added to the golden dataset  
- **自动化黄金数据集构建**：当提示词（prompt）在特定智能体任务中达到预设评分阈值时，系统将自动将其纳入黄金数据集（golden dataset）

- **Human feedback integration**: Leveraging LangSmith's flexibility to collect human feedback and compare prompt versions  
- **人工反馈整合**：依托 LangSmith 的高灵活性，高效收集人工反馈，并支持不同提示词版本间的对比分析

- **Regression prevention**: Using datasets to ensure new updates don't degrade performance on previously successful scenarios  
- **回归问题预防**：通过已有数据集持续验证，确保新版本更新不会导致先前已成功运行场景的性能下降

- **Multiple comparison modes**: Comparing prompts across different versions to identify and leverage the best prompting strategies  
- **多模式对比机制**：支持跨版本提示词的多维比对，从而识别并复用最优的提示工程（prompting）策略

![](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_002.png)_Lifecycle from traces to evaluation for an agent_

![](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_002.png)_智能体从调用追踪（traces）到评估的全生命周期_

## **Testing and production roadmap**

## **测试与生产落地路线图**

ServiceNow is currently in the testing phase with QA engineers evaluating agent performance. They're using this controlled environment as the ground source for building their datasets and evaluation framework. ServiceNow will continuously collect real user data and continue using LangSmith to monitor live agent performance. When production runs pass their thresholds, those prompts will automatically become part of the golden dataset for ongoing quality assurance. As a next step, ServiceNow will use the multi-turn evaluation, which was recently launched as a new feature in LangSmith, to evaluate the agent performance across an end-to-end user interaction. We will use the context of the entire thread for the evaluator instead of single conversation.

目前，ServiceNow 正处于测试阶段，由 QA 工程师主导对各智能体性能进行系统性评估。该受控测试环境已成为其构建数据集与评估框架的核心基础。后续，ServiceNow 将持续采集真实用户交互数据，并继续借助 LangSmith 对线上智能体的实际运行表现进行实时监控。一旦生产环境中的运行结果稳定通过各项预设阈值，对应提示词将自动加入黄金数据集，以支撑长期的质量保障闭环。下一步，ServiceNow 将启用 LangSmith 最近推出的全新功能——**多轮对话评估**（multi-turn evaluation），对智能体在端到端用户交互全流程中的表现展开综合评估。届时，评估器将基于**完整对话线程的上下文**（the context of the entire thread），而非孤立的单轮对话，进行更精准、更贴近真实场景的判断。

## **Conclusion**

## **总结**

ServiceNow is successfully addressing the challenges of agent orchestration and observability using LangChain's platform. By leveraging LangGraph for multi-agent coordination and LangSmith for granular visibility into agent behavior, ServiceNow has built the foundation for intelligent customer success operations that span the entire customer journey.

ServiceNow 借助 LangChain 平台，成功应对了智能体编排（agent orchestration）与可观测性（observability）两大核心挑战。通过运用 LangGraph 实现多智能体协同调度，并依托 LangSmith 实现对智能体行为的细粒度可观测能力，ServiceNow 已构建起覆盖客户全旅程的智能化客户成功运营体系之坚实基础。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_003.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：利用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：利用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How Bertelsmann Built a Multi-Agent System to Empower Creatives](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_008.png)](https://blog.langchain.com/customer-bertelsmann/)

[![贝塔斯曼如何构建多智能体系统以赋能创意人员](images/how-servicenow-uses-langsmith-to-get-visibility-into-its-customer-success-agents/img_008.png)](https://blog.langchain.com/customer-bertelsmann/)

[**How Bertelsmann Built a Multi-Agent System to Empower Creatives**](https://blog.langchain.com/customer-bertelsmann/)

[**贝塔斯曼如何构建多智能体系统以赋能创意人员**](https://blog.langchain.com/customer-bertelsmann/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 6 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 6 分钟阅读
&#123;% endraw %}
