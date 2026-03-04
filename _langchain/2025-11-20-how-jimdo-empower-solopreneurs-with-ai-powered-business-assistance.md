---
title: "How Jimdo empower solopreneurs with AI-powered business assistance"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-jimdo/"
date: "2025-11-20"
scraped_at: "2026-03-03T07:17:52.634498842+00:00"
language: "en-zh"
translated: true
description: "See how Jimdo uses LangChain.js, LangGraph.js, and LangSmith to deliver personalized business insights that drive 50% more first customer contacts and 40% more overall customer activity."
tags: ["Case Studies"]
---
{% raw %}

## **About Jimdo**

## **关于 Jimdo**

For 18 years, Jimdo, one of Europe's leading website builders, has been building tools for self-employed entrepreneurs across 190 countries, with over 35 million websites created on their platform. Based in Germany, Jimdo serves yoga studios, photography businesses, bakeries, consulting practices, and thousands of other solopreneurs. Their core offering has expanded beyond website hosting to include features that help solopreneurs with bookings, analytics, transactions, and marketing campaigns.

十八年来，Jimdo 作为欧洲领先的网站建设平台之一，已为遍布 190 个国家的自由职业创业者开发了各类工具，其平台上已建成超过 3,500 万个网站。总部位于德国的 Jimdo，服务对象涵盖瑜伽工作室、摄影工作室、面包店、咨询公司，以及成千上万的其他独立创业者（solopreneur）。其核心产品已不再局限于网站托管，更延伸至帮助独立创业者完成预约管理、数据分析、交易处理及营销活动等功能。

**The challenge: Lack of domain expertise across critical business functions**

**挑战：关键业务职能领域普遍缺乏专业能力**

Solopreneurs often need to handle marketing, sales, finance, operations, and strategy without the dedicated teams that larger companies rely on. Jimdo observed that many of their customers were able to build solid websites, but some faced issues with driving more traffic and conversion to their sites and spent valuable time guessing at what might move the needle.

独立创业者通常需独自承担市场营销、销售、财务、运营与战略规划等职责，而无法像大企业那样依赖专业团队支持。Jimdo 观察到，许多客户虽能搭建出功能完备的网站，却在提升网站流量与转化率方面遇到困难，且往往耗费大量时间反复试错，难以判断哪些举措真正有效。

Jimdo needed to build an AI-powered business advisor that could analyze each customer’s unique situation and provide personalized, actionable guidance — essentially giving solopreneurs the same strategic insights that enterprise companies get from their analytics and consulting teams to help the users grow their own business.

Jimdo 需要构建一个由 AI 驱动的商业顾问系统，能够分析每位客户的独特经营状况，并提供个性化、可落地的指导建议——本质上，是将大型企业通过数据分析与咨询团队所获得的战略洞察力，平等地赋予每一位独立创业者，助力其业务成长。

**Solution: Building Jimdo Companion with the LangChain ecosystem**

**解决方案：基于 LangChain 生态构建 Jimdo Companion**

To deliver on this vision, Jimdo's AI engineering team turned to the LangChain ecosystem, using LangChain.js and LangGraph.js for orchestration, with LangSmith providing comprehensive observability and evaluation capabilities, building their own AI Platform, a shared core that every product team contributes to. On this foundation, Jimdo’s Companion has two main AI agent systems:

为实现这一愿景，Jimdo 的 AI 工程团队选择了 LangChain 生态系统：使用 LangChain.js 和 LangGraph.js 进行流程编排，借助 LangSmith 实现全面的可观测性与评估能力，并由此构建起 Jimdo 自有的 AI 平台——一个由各产品团队共同参与建设、共享复用的核心基础设施。在此基础之上，Jimdo Companion 主要包含两大 AI 智能体系统：

**Companion Assistant: AI that speaks your language -** Jimdo also released Companion Assistant, a ChatGPT-like interface embedded throughout their product suite. A key innovation is its agent analyzes the customers business, their created content, extracting their tone of voice so results speak their language. At launch, Companion Assistant helps customers deeply understand and complete tasks for their business including integrating with specialized agents for SEO optimization, listings management, bookings, smart forms, and the website editor - providing contextual help wherever users need it.

**Companion 助理：会说“你的语言”的 AI**  
Jimdo 还推出了 Companion 助理（Companion Assistant）——一款类 ChatGPT 的对话式界面，深度集成于其全套产品中。其关键创新在于：该智能体可分析客户的业务特征及其自主创建的内容，精准提取其品牌语调与表达风格，从而确保所有输出内容都“说客户的语言”。上线初期，Companion 助理即可帮助客户深入理解并高效完成各项业务任务，例如联动多个专业化智能体，分别支持搜索引擎优化（SEO）、商家信息列表管理、预约预订、智能表单及网站编辑器等功能，在用户所需之处即时提供上下文相关的操作指引。

**Companion Dashboard: An agentic business advisor -** Jimdo Companion is the first thing customers see when they log in - a comprehensive synthesis of where their business currently stands. The system queries 10+ data sources to deliver real-time performance summaries and context-aware next steps tailored to each business's specific challenges. Unlike generic tools, Companion differentiates Jimdo from competitors by delivering analytical insights based on actual product behavior and business data.

**Companion 仪表盘：具备自主决策能力的商业顾问**  
Jimdo Companion 是用户登录后首先看到的界面——一份全面呈现其当前业务状况的整合视图。该系统对接 10 余个数据源，实时生成业绩概览，并基于每家企业的具体挑战，智能推荐具有上下文感知能力的下一步行动建议。与通用型工具不同，Companion 凭借对真实产品行为与业务数据的深度分析，输出切实可用的洞察，从而显著强化 Jimdo 相较于竞品的差异化优势。

![](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_001.png)Jimdo Companion Dashboard

![](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_001.png)Jimdo Companion 仪表盘

### [**LangGraph.js**](http://langgraph.js/?ref=blog.langchain.com) **and LangChain.js for workflow orchestration**

### [**LangGraph.js**](http://langgraph.js/?ref=blog.langchain.com) **与 LangChain.js 用于工作流编排**

LangChain.js 提供了互操作性层，使 Jimdo 多功能 AI 平台的构建成为可能，从而实现了多个数据源与 AI 能力的无缝集成。该框架对 TypeScript 的原生支持，与 Jimdo 现有的技术栈高度契合；同时，它还具备足够的灵活性，可适配不同大语言模型（LLM）提供商，并在不重写代码的前提下自由切换模型。

LangChain.js 提供了实现互操作性的底层能力，使得 Jimdo 构建其多功能 AI 平台成为可能，从而无缝整合多个数据源与 AI 能力。该框架对 TypeScript 的原生支持，与 Jimdo 现有技术栈天然契合；同时，它还具备高度灵活性，可对接不同 LLM 服务商，并在无需重构代码的前提下轻松切换模型。

Jimdo Companion 的真正威力，在于其能动态分析一家企业状况，并智能识别出最具业务影响的下一步行动。这依赖于 LangGraph.js 所赋能的高级工作流编排能力——包括基于 ReAct（推理 + 行动）范式的智能体，以及图结构化架构：

Jimdo Companion 的核心优势在于其动态分析企业状况、并精准识别最具业务价值的下一步行动的能力。这一能力依托于 LangGraph.js 所提供的先进工作流编排机制，包括基于 ReAct（推理 + 行动）范式的智能体，以及图结构化系统架构：

- **上下文感知的决策树**：当网站流量下降时，Companion 自动触发本地 SEO 分析工作流；当转化率滞后时，则启动转化优化评估流程。一位面临定价问题的婚礼摄影师所经历的评估路径，与一家苦于本地曝光度不足的面包店截然不同。
- **并行执行路径**：系统同步评估多个业务维度——包括流量来源、转化漏斗、竞品定位、定价策略等，在显著降低响应延迟的同时，综合整合来自 10+ 数据源的全面洞察。
- **状态管理**：LangGraph.js 强大的状态管理能力，使 Companion 能够在多次交互中持续维护上下文，记住过往对话内容，并追踪用户已查看过的各项建议动作。

- **上下文感知的决策树**：当网站流量下降时，Companion 自动激活本地 SEO 分析工作流；当转化率偏低时，则触发转化优化评估流程。例如，一位面临定价问题的婚礼摄影师所遵循的评估流程，与一家因本地可见性不足而陷入困境的面包店完全不同。
- **并行执行路径**：系统可同时评估多个业务维度——如流量来源、转化漏斗、竞争格局、定价策略等，在大幅降低响应延迟的同时，提供覆盖 10+ 数据源的综合性洞察。
- **状态管理**：LangGraph.js 的状态管理能力使 Companion 能在多次交互中持续维持上下文，准确记忆历史对话，并实时追踪用户已浏览过的各项操作建议。

LangGraph.js 所倡导的模块化设计思路，助力 Jimdo 团队构建出更小、更聚焦的子图（subgraphs），这些子图可灵活组合成更大、更复杂的工作流，从而为 Jimdo 日益丰富的 AI 能力矩阵打造了一套可扩展的系统架构。

LangGraph.js 所倡导的模块化开发理念，助力 Jimdo 团队构建出体积更小、职责更聚焦的子图（subgraphs）；这些子图可按需组合，形成规模更大、逻辑更复杂的工作流，最终构建起一套面向其不断扩展的 AI 能力体系的可伸缩架构。

### **LangSmith for monitoring and quality assurance**

### **LangSmith：用于监控与质量保障**

面对数千名依赖 Companion 做出关键商业决策的客户，确保系统输出的准确性与可靠性是不可妥协的前提。Jimdo 将 LangSmith 作为其核心监控工具，重点追踪以下指标：

面对数千名依赖 Companion 做出关键商业决策的客户，确保系统输出的准确性与可靠性是不可妥协的前提。Jimdo 将 LangSmith 作为其核心监控平台，重点追踪以下几类指标：

- **质量评分**：基于“LLM 作为裁判”（LLM-as-judge）机制评估的响应延迟与输出质量；
- **图结构质量输出**：LangGraph 工作流的各项性能指标；
- **工具调用质量输出**：各类工具调用的准确性与有效性；
- **用户满意度**：这是 Jimdo 当前评估策略中正在积极拓展的下一前沿方向。

- **质量评分**：基于“LLM 作为裁判”（LLM-as-judge）机制评估的响应延迟与输出质量；
- **图结构质量输出**：LangGraph 工作流的各项性能指标；
- **工具调用质量输出**：各类工具调用的准确性与有效性；
- **用户满意度**：这是 Jimdo 当前评估策略中正积极拓展的下一前沿方向。

LangSmith 全面详尽的链路追踪（tracing）能力，使团队能够清晰还原系统生成某项具体建议的完整推理路径，从而持续优化提示词（prompts）与工作流逻辑。追踪数据直观、结构化的组织方式，极大简化了调试过程，显著缩短了开发周期，加快了缺陷修复速度。

LangSmith 提供全面、细致的链路追踪（tracing）能力，使团队得以精准还原系统生成某项具体建议的完整推理路径，从而持续迭代优化提示词（prompts）与工作流逻辑。其追踪数据采用直观、结构化的组织方式，极大降低了调试难度，显著缩短了开发周期，加速了缺陷修复进程。

## **Impact: Measurable success for self-employed entrepreneurs**

## **成效：为个体创业者带来可衡量的成功**

The results speak to the transformative power of personalized, AI-driven business guidance:

这些成果彰显了个性化、AI 驱动商业指导所蕴含的变革性力量：

### **50% More First Customer Contacts**

### **首单客户联系量提升 50%**

Jimdo users with access to Companion receive their first customer contact or order within 30 days at a 50% higher rate than users without the AI assistant. By identifying and addressing the specific blockers each business faces - whether traffic, conversion, or positioning - Companion accelerates the path to that critical first success.

启用 Jimdo Companion 的用户，其在 30 天内获得首个客户联系或订单的概率，比未使用 AI 助理的用户高出 50%。Companion 通过精准识别并解决每家企业的具体瓶颈——无论是流量不足、转化率低，还是市场定位不清——显著加快了通往这一关键“首次成功”的进程。

### **40% Increase in Customer Activity**

### **客户活跃度提升 40%**

Across the board, Companion users see 40% more inquiries and orders compared to users without access. This isn't just about more traffic; it's about smarter positioning, clearer value propositions, better-optimized conversion paths, and pricing that reflects true market value.

整体而言，启用 Companion 的用户所收到的咨询与订单数量，比未启用用户高出 40%。这不仅意味着更多流量，更代表着更精准的市场定位、更清晰的价值主张、更优化的转化路径，以及更能反映真实市场价值的定价策略。

## **What's next**

## **下一步是什么**

Jimdo Companion already delivers measurable impact through personalized business assistance - the next evolution shifts to execution: Every product experience, progressively automating the journey from "what to do next" to "it’s already done." This evolution moves beyond a set of agents to a comprehensive ecosystem where specialized agents autonomously handle configuration, background optimization, and multi-step workflows across Jimdo and external tools, empowering customers to confidently partner with the AI and maintain ultimate control.

Jimdo Companion 已凭借个性化商业支持带来可衡量的实际成效；下一阶段的演进将聚焦于“执行”：在每一处产品体验中，逐步实现从“下一步该做什么”到“它已完成”的自动化跃迁。这一演进将超越单一智能体集合，迈向一个完整生态体系——其中各类专业化智能体可自主完成配置、后台优化，以及横跨 Jimdo 平台与外部工具的多步骤工作流，赋能用户自信地与 AI 协同合作，同时始终保有最终控制权。

Using LangSmith's evaluation framework, these agents will continuously improve through millions of interactions, while enhanced LangGraph orchestration will handle increasingly sophisticated multi-agent coordination.

借助 LangSmith 的评估框架，这些智能体将在数百万次交互中持续优化；而升级后的 LangGraph 编排能力，则将支撑日益复杂的多智能体协同任务。

The goal: transform every login into concrete business value with dramatically less effort, positioning Jimdo not as a website builder with AI features, but as an AI-powered business platform for solopreneurs.

目标是：让每一次登录都转化为切实可感的商业价值，且所需投入大幅降低；由此，Jimdo 将不再仅是一个“带 AI 功能的建站工具”，而是一个专为个体创业者（solopreneurs）打造的、以 AI 为引擎的商业平台。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_002.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 完成数千名客户的入驻流程](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 完成数千名客户的入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How Bertelsmann Built a Multi-Agent System to Empower Creatives](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_007.png)](https://blog.langchain.com/customer-bertelsmann/)

[![贝塔斯曼如何构建多智能体系统以赋能创意人员](images/how-jimdo-empower-solopreneurs-with-ai-powered-business-assistance/img_007.png)](https://blog.langchain.com/customer-bertelsmann/)

[**How Bertelsmann Built a Multi-Agent System to Empower Creatives**](https://blog.langchain.com/customer-bertelsmann/)

[**贝塔斯曼如何构建多智能体系统以赋能创意人员**](https://blog.langchain.com/customer-bertelsmann/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 6 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 6 分钟阅读
{% endraw %}
