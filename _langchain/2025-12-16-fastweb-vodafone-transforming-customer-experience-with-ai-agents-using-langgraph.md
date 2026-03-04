---
title: "Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-vodafone-italy/"
date: "2025-12-16"
scraped_at: "2026-03-03T07:15:42.125555622+00:00"
language: "en-zh"
translated: true
description: "See how Fastweb + Vodafone revolutionized customer service and call center operations with their agents, Super TOBi and Super Agent."
tags: ["Case Studies"]
---
&#123;% raw %}

Fastweb + Vodafone, part of the Swisscom Group, is one of Europe's leading telecommunications providers serving millions of customers across Italy. Recognizing that traditional customer service approaches could be improved to meet their growing demands, Fastweb + Vodafone embarked on an AI transformation to revolutionize how it delivers customer support.

Fastweb + Vodafone（隶属瑞士电信集团 Swisscom Group）是欧洲领先的电信服务提供商之一，为意大利数百万用户提供服务。鉴于传统客户服务模式已难以满足日益增长的用户需求，Fastweb + Vodafone 启动了人工智能转型，以彻底革新其客户支持服务的交付方式。

Customer service in telecommunications operates at a massive scale with complex, interconnected challenges. Customers require immediate assistance with billing inquiries, service activations, roaming questions, and technical support, often expecting resolution within a single interaction. Traditional TOBi struggles with nuanced requests that require contextual understanding, multiple system access, and end-to-end resolution.

电信行业的客户服务规模庞大，且面临复杂、相互关联的多重挑战。客户亟需即时响应——无论是账单查询、业务开通、漫游咨询，还是技术故障支持——往往期望在一次交互内即获解决。而传统的 TOBi（智能客服机器人）在处理需要上下文理解、跨多个系统调用及端到端闭环解决的精细化请求时，表现乏力。

For Fastweb + Vodafone's call center consultants, the challenge was equally complex. Agents needed to access customer data quickly, understand service history, and determine appropriate resolutions while maintaining high service standards. The manual process of consulting multiple systems and knowledge bases, while effective, could benefit from intelligent support to further enhance the speed and consistency of the customer experience. Fastweb + Vodafone thus needed an AI solution that could handle both customer-facing interactions and empower call center agents to deliver exceptional service consistently.

对 Fastweb + Vodafone 的呼叫中心顾问而言，挑战同样严峻：坐席人员需快速调取客户数据、准确理解服务历史，并据此制定恰当解决方案，同时始终维持高标准的服务质量。尽管当前依赖人工查阅多个系统与知识库的方式行之有效，但若能引入智能化辅助，将进一步提升客户体验的速度与一致性。因此，Fastweb + Vodafone 急需一套人工智能解决方案——既能高效处理面向客户的交互任务，又能切实赋能一线坐席，持续交付卓越服务。

## **Building intelligent customer interactions with LangChain and LangGraph**

## **基于 LangChain 与 LangGraph 构建智能客户交互体系**

Fastweb + Vodafone chose LangChain and LangGraph as the foundation for their AI transformation because their customer service process naturally mapped to a graph-based decision-making flow. Their implementation centers around two flagship projects: **Super TOBi and Super Agent**.

Fastweb + Vodafone 选择 LangChain 与 LangGraph 作为其人工智能转型的技术基石，原因在于其客户服务流程天然契合图结构化的决策逻辑。该实践围绕两大标杆项目展开：**Super TOBi（超级 TOBi）与 Super Agent（超级坐席助手）**。

### **Super TOBi: AI-powered customer service at enterprise scale**

### **Super TOBi：面向企业级规模的 AI 驱动型客户服务**

Super TOBi builds upon Fastweb + Vodafone's existing ChatBot (TOBi), transforming it into an agentic system that can handle complex customer interactions across multiple channels. The system follows a structured approach that mirrors how experienced customer service representatives handle inquiries.

Super TOBi 在 Fastweb + Vodafone 现有聊天机器人（TOBi）基础上构建，将其升级为具备自主能力（agentic）的智能系统，可跨多渠道应对复杂的客户交互场景。该系统采用结构化工作流，高度复现资深客服代表处理咨询的实际方式。

![](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_001.png)

![](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_001.png)

The system’s architecture is organized around two main agents, both implemented as LangGraph graphs: the **Supervisor** and the **Use Cases**.

该系统的整体架构围绕两大核心智能体（Agent）构建，二者均以 LangGraph 图结构实现：**主管智能体（Supervisor）** 与 **场景智能体（Use Cases）**。

The Supervisor acts as the central entry point for all user queries. Its first responsibility is to apply guardrails, filtering, and shaping inputs to ensure they are valid and safe. Beyond this, it manages special scenarios such as the end of a conversation, operator handovers, simple interactions (like greetings), and others. Once the input has been processed, the Supervisor either routes the query directly to the most appropriate Use Case or, in cases of uncertainty, **asks clarification questions** to identify the right path forward. In this way, it orchestrates the entire dialogue flow, ensuring each query is handled consistently and efficiently.

主管智能体（Supervisor）作为所有用户查询的统一入口点。其首要职责是对输入内容施加安全护栏（guardrails），执行过滤与规范化处理，确保输入合法、安全。此外，它还负责管理各类特殊场景，例如对话结束、转接人工坐席、简单交互（如问候语）等。当输入完成预处理后，主管智能体将直接把查询路由至最匹配的“场景智能体”；若存在不确定性，则主动**发起澄清式提问**，以精准识别后续最优路径。由此，它全面统筹整段对话流程，保障每一次查询均得到一致、高效的响应。

The **Use Cases** represent specialized agents, each designed to resolve a particular category of customer need.  
**用例（Use Cases）** 代表一系列专业化智能体，每个智能体均针对解决某一特定类别的客户需求而设计。

They operate with access to a well-defined subset of customer APIs and follow the **LLM Compiler pattern**.  
它们可访问一组明确定义的客户 API，并遵循 **LLM 编译器模式（LLM Compiler pattern）**。

This approach allows them to reason about which APIs should be invoked, to coordinate multiple steps where required, and to generate final responses that are tailored to the customer’s context.  
该模式使智能体能够自主推理应调用哪些 API，在需要时协调多个执行步骤，并生成贴合客户上下文的最终响应。

Importantly, some Use Cases are not limited to natural language responses: they can also emit **structured action** tags.  
尤为重要的是，部分用例不仅限于自然语言响应，还可输出 **结构化操作（structured action）** 标签。

These tags enable the system to execute transactional flows directly within the conversation.  
这些标签使系统能够在对话过程中直接执行事务性流程。

For example, an action tag might initiate an offer activation, disable an ongoing service, or trigger a payment method update.  
例如，一个操作标签可触发优惠激活、停用正在进行的服务，或更新支付方式。

When such action tags are returned, the **ChatBot** automatically executes them in the conversation interface.  
当返回此类操作标签时，**聊天机器人（ChatBot）** 将在对话界面中自动执行对应操作。

This integration creates a seamless blend of dialogue and action, allowing customers to move effortlessly from asking a question to completing a transaction, all within the same conversational experience.  
这一集成实现了对话与操作的无缝融合，让客户能在一个连贯的对话体验中，从提出问题自然过渡到完成交易，全程无需切换场景。

Fastweb + Vodafone's implementation of the LLM Compiler pattern within LangGraph enables the system to generate comprehensive plans for each customer request, seamlessly executing API calls, data retrieval, and multi-step problem resolution.  
Fastweb 与 Vodafone 在 LangGraph 框架内实现的 LLM 编译器模式，使系统能够为每一项客户请求生成完整执行计划，并无缝完成 API 调用、数据获取及多步骤问题求解。

![](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_002.png)

Currently serving nearly **9.5 million customers** through the Customer Companion App and voice channels, Super TOBi handles use cases including cost control, active offers, roaming, sales, and billing with impressive business metrics: **90% correctness rate, 82% resolution rate, and a Customer Effort Score (CES) of 5.2 out of 7**, translating into faster response times, fewer human-operator transfers, and higher customer satisfaction.  
目前，Super TOBi 已通过“客户伴侣应用（Customer Companion App）”及语音渠道，服务近 **950 万客户**，覆盖成本管控、在享优惠、漫游服务、销售支持及账单查询等用例，业务指标表现优异：**准确率达 90%，问题解决率达 82%，客户费力度评分（Customer Effort Score, CES）达 7 分制中的 5.2 分**——这意味着响应更迅速、转人工更少、客户满意度更高。

### **Super Agent: Empowering call center excellence with LangGraph**  
### **超级智能体（Super Agent）：以 LangGraph 赋能呼叫中心卓越运营**

Super Agent is Fastweb + Vodafone’s internally facing AI project that augments every consultant with instant diagnostics, compliant guidance, and source-backed explanations.  
Super Agent 是 Fastweb 与 Vodafone 面向内部推出的 AI 项目，旨在为每位客服顾问提供即时诊断能力、符合规范的操作指引，以及基于权威信源的解释说明。

Unlike the consumer bot Super TOBi, Super Agent never speaks directly to customers; instead, it equips the human consultant with the exact next step.  
与面向消费者的聊天机器人 Super TOBi 不同，Super Agent 从不直接面向客户发言；其核心作用是为人工顾问精准提供“下一步该做什么”。

Thanks to this approach, the use of generative AI has driven **One-Call Resolution (OCR) rates above 86%**.  
得益于这一设计，生成式 AI 的应用已将 **一次通话解决率（One-Call Resolution, OCR）提升至 86% 以上**。

The solution blends LangChain’s composable tools with LangGraph’s controllable orchestration and stores all operational knowledge as a living graph inside Neo4j.  
该方案融合了 LangChain 的可组合工具与 LangGraph 的可控编排能力，并将全部运营知识以“活图谱（living graph）”形式持久化存储于 Neo4j 图数据库中。

#### **From business template to graph in one automated ETL flow**  
#### **从业务模板到图谱：一键式自动化 ETL 流程**

Business specialists write troubleshooting and informational procedures using structured templates with defined steps, conditions, and actions.  
业务专家使用结构化模板编写故障排查与信息查询流程，模板中明确定义了步骤、条件与操作。

Once submitted, an automated ETL pipeline—powered by LangGraph and task-specific LLM Agents (including ReAct Agents)—parses the document into JSON, extracts verification APIs, performs consistency checks, and refines step definitions.  
提交后，一条由 LangGraph 及任务专属大语言模型智能体（含 ReAct 智能体）驱动的自动化 ETL 流程即刻启动：将文档解析为 JSON 格式、提取校验类 API、执行一致性校验，并优化各步骤定义。

The content is decomposed into nodes and relationships and stored in Neo4j as part of a knowledge graph: Steps link to Conditions, Actions, and related API nodes. A CI/CD pipeline then automates build, validation, and deployment, promoting the updated graph to production within hours and without downtime.

内容被分解为节点和关系，并作为知识图谱的一部分存储在 Neo4j 中：步骤（Steps）与条件（Conditions）、操作（Actions）以及相关 API 节点相互关联。随后，CI/CD 流水线自动执行构建、验证与部署，可在数小时内将更新后的图谱推送到生产环境，且全程无需停机。

![](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_003.png)

#### **Intent router and execution flows**

#### **意图路由与执行流程**

Incoming requests from consultants, whether troubleshooting support requests on user issues or general knowledge base questions, are first processed by a LangGraph Supervisor who determines whether the request matches a **graph-based procedure** or an **open-ended question**. In the case of a troubleshooting request, the corresponding procedure authored by the business and stored in Neo4j as a knowledge graph is identified. CRM data is automatically injected at this stage to reliably identify the user, ensuring each request is linked to the correct user and responses are tailored to the appropriate customer context.

来自客服顾问的请求——无论是针对用户问题的故障排查支持请求，还是关于知识库的一般性提问——首先由 LangGraph Supervisor 进行处理，以判断该请求属于 **基于图谱的流程（graph-based procedure）** 还是 **开放式问题（open-ended question）**。若为故障排查类请求，则识别出由业务部门编写并以知识图谱形式存储于 Neo4j 中的对应流程；此阶段会自动注入 CRM 数据，从而可靠地识别用户身份，确保每个请求均与正确用户关联，且生成的响应能精准适配相应客户的上下文。

#### **Graph-based procedure execution**

#### **基于图谱的流程执行**

For structured troubleshooting and fault-isolation scenarios, the Supervisor activates a procedural sub-graph executor. Using LangChain and LangGraph, the system retrieves the first _Step_ node of the procedure from Neo4j along with its associated _Condition_, _Action_, and _API_ nodes. For each step, the required APIs are executed to validate the step’s conditions. If a condition is satisfied, the procedure concludes: the user’s issue is identified, and a response is generated by combining the corresponding Action with the contextual information gathered from the APIs. If none of the conditions are met, the process moves to the next Step node in the procedure and repeats iteratively until the problem and its solution are found.

在结构化故障排查与故障隔离场景中，Supervisor 启用一个流程化子图执行器（procedural sub-graph executor）。系统借助 LangChain 和 LangGraph，从 Neo4j 中检索该流程的第一个 _Step_（步骤）节点，及其关联的 _Condition_（条件）、_Action_（操作）和 _API_ 节点。对每个步骤，系统调用所需 API 来验证其前提条件：若某条件满足，则流程终止——用户问题即被定位，系统将结合对应的操作（Action）与从 API 获取的上下文信息生成响应；若所有条件均未满足，则流程进入该流程中的下一个 Step 节点，并持续迭代，直至定位问题并找到解决方案。

#### **Graph RAG for open-ended questions**

#### **面向开放式问题的图谱增强型 RAG（Graph RAG）**

Generic or unstructured questions about the company knowledge base are routed to a hybrid Retrieval-Augmented Generation (RAG) chain that combines a **vector store** with the **Neo4j knowledge graph**. The vector store finds a broad set of potentially relevant passages, and the knowledge graph then anchors the answer with the right context, adding source citations and making sure it follows company policy.

针对企业知识库的通用性或非结构化问题，系统将其路由至一种混合式检索增强生成（Retrieval-Augmented Generation, RAG）链路，该链路融合了 **向量数据库（vector store）** 与 **Neo4j 知识图谱**。向量数据库负责检索出一批潜在相关度较高的文本片段；而知识图谱则进一步为答案锚定准确的上下文，补充来源引用，并确保回答严格遵循公司政策。

![](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_004.png)

### **Technology highlights**

### **技术亮点**

• Supervisor pattern keeps intent routing deterministic while allowing specialised sub-graphs to evolve independently.  

• Supervisor 模式确保意图路由的确定性，同时允许专业化子图独立演进。

• Customized LLMCompiler design adds telecom-specific LangGraph nodes for API orchestration, rule checking, and exception handling.  

• 定制化的 LLMCompiler 设计新增了面向电信领域的 LangGraph 节点，用于 API 编排、规则校验与异常处理。

• Neo4j houses every artefact—procedural steps, validation rules, APIs, documents, solutions—making relationships first-class citizens and enabling lightning-fast graph traversals.  

• Neo4j 存储所有工件——包括操作步骤、校验规则、API、文档及解决方案——使“关系”成为头等公民，并支持毫秒级图遍历。

• LangSmith streams chain traces, latency metrics, and evaluation scores to Fastweb + Vodafone’s internal dashboards for continuous optimisation.  

• LangSmith 将链路追踪（chain traces）、延迟指标（latency metrics）和评估得分实时推送至 Fastweb + Vodafone 内部仪表盘，支撑持续优化。

• Governance by design: every recommendation is validated against Rule nodes that encode Fastweb + Vodafone policy.  

• 以治理为设计前提：每项推荐均需通过承载 Fastweb + Vodafone 政策的 Rule 节点进行校验。

• Deployment agility: the architectural design enables seamless integration of new capabilities without re-engineering, dramatically reducing time to market.  

• 部署敏捷性：该架构设计支持新能力的无缝集成，无需重构系统，从而大幅缩短上市周期。

## **Continuous improvement through LangSmith monitoring**  

## **通过 LangSmith 监控实现持续改进**

Fastweb + Vodafone implemented LangSmith from day one of development, recognizing the critical importance of monitoring and evaluation in production AI systems.  

Fastweb + Vodafone 自开发首日即引入 LangSmith，深刻认识到监控与评估对生产环境中 AI 系统的关键意义。

> “You can’t run agentic systems in production without deep observability. LangSmith gave us end-to-end visibility into how our LangGraph workflows reason, route, and act, turning what would otherwise be a black box into an operational system we can continuously improve.” — Pietro Capra, Chat Engineering Chapter Lead, Fastweb + Vodafone  

> “若缺乏深度可观测性，便无法在生产环境中运行智能体（agentic）系统。LangSmith 赋予我们端到端的可见性，清晰呈现 LangGraph 工作流如何推理、路由与执行，将原本的‘黑盒’转化为一个可被持续优化的可运营系统。”——Pietro Capra，Fastweb + Vodafone 聊天工程团队负责人

The team has developed sophisticated evaluation processes that run daily, automatically classifying chatbot responses and providing structured feedback for continuous improvement:  

该团队已构建起一套成熟的自动化评估流程，每日定时运行，自动对聊天机器人响应进行分类，并提供结构化反馈，以驱动持续改进：

**Daily Evaluation Process:**

**每日评估流程：**

- Collect traces in LangSmith datasets from daily interactions  
- 从日常交互中收集 LangSmith 数据集中的 trace（调用轨迹）

- Perform automated evaluation using LangSmith Evaluators SDK during overnight processing  
- 在夜间批处理期间，使用 LangSmith Evaluators SDK 执行自动化评估

- Analyze user queries, chatbot responses, context, and grading guidelines  
- 分析用户查询、聊天机器人回复、上下文及评分准则

- Generate structured output including scores (1-5), explanations, and violated guidelines  
- 生成结构化输出，包括评分（1–5 分）、评分依据说明以及违反的准则条款

This automated evaluation system enables business stakeholders to review daily performance metrics, provide strategic input, and communicate with the technical team to make prompt adjustments to maintain the 90% correctness rate target. The combination of automated monitoring and human oversight ensures Super TOBi consistently delivers value to customers while identifying areas for improvement.

该自动化评估系统使业务相关方能够审阅每日性能指标、提供战略性反馈，并与技术团队高效沟通，及时调整优化策略，以持续达成 90% 的准确率目标。自动化监控与人工监督相结合，既保障了 Super TOBi 持续为客户创造价值，又能精准识别待提升环节。

> _As Lucia Barbieri, Fastweb + Vodafone AI Customer Channels Lead, explains, “Automated evaluation has been crucial to scaling effectively, enabling us to quickly identify improvement areas and enhance experience, driving continuous growth and refinement.”_

> _正如 Fastweb + Vodafone AI 客户渠道负责人 Lucia Barbieri 所言：“自动化评估对规模化落地至关重要——它帮助我们快速定位改进点、优化用户体验，从而推动持续增长与精进。”_

## **What's next**

## **下一步计划**

Fastweb + Vodafone continues expanding both Super TOBi and Super Agent capabilities while maintaining its core value proposition: delivering exceptional customer experiences through intelligent automation. Looking ahead, Fastweb + Vodafone plans to leverage its early success with LangGraph and LangSmith to explore building additional AI applications across its telecommunications operations.

Fastweb + Vodafone 持续拓展 Super TOBi 与 Super Agent 的功能边界，同时坚守其核心价值主张：依托智能自动化，交付卓越的客户体验。展望未来，Fastweb + Vodafone 将基于 LangGraph 与 LangSmith 已取得的早期成功，进一步探索在电信运营全场景中构建更多 AI 应用。

With their foundation built on LangGraph's flexible architecture and LangSmith's monitoring capabilities, Fastweb + Vodafone is well-positioned to continue innovating in the telecommunications AI space while maintaining the reliability and performance their customers expect.

依托 LangGraph 灵活的架构设计与 LangSmith 强大的监控能力所构筑的技术底座，Fastweb + Vodafone 已具备在电信 AI 领域持续创新的能力，同时确保其产品始终满足客户对可靠性与性能的严苛期待。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)  
[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_005.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_005.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_006.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_006.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功代理的可观测性](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_009.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_009.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How Bertelsmann Built a Multi-Agent System to Empower Creatives](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_010.png)](https://blog.langchain.com/customer-bertelsmann/)

[![贝塔斯曼如何构建多智能体系统以赋能创意人员](images/fastweb-vodafone-transforming-customer-experience-with-ai-agents-using-langgraph/img_010.png)](https://blog.langchain.com/customer-bertelsmann/)

[**How Bertelsmann Built a Multi-Agent System to Empower Creatives**](https://blog.langchain.com/customer-bertelsmann/)

[**贝塔斯曼如何构建多智能体系统以赋能创意人员**](https://blog.langchain.com/customer-bertelsmann/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 6 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：6 分钟
&#123;% endraw %}
