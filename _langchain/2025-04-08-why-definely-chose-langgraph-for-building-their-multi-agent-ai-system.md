---
title: "Why Definely chose LangGraph for building their multi-agent AI system"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-definely/"
date: "2025-04-08"
scraped_at: "2026-03-03T07:35:37.843885053+00:00"
language: "en-zh"
translated: true
description: "See how Definely used LangGraph to design a multi-agent system to help lawyers speed up their workflows."
tags: ["Case Studies"]
---
&#123;% raw %}

[Definely](https://www.definely.com/?ref=blog.langchain.com) is revolutionizing the legal industry by integrating AI-driven solutions into lawyers' daily workflows. Focused on enhancing efficiency and accuracy, Definely is building specialized agents that operate within Microsoft Word, allowing lawyers to streamline contract drafting, negotiating and review. With a goal of building the most effective infrastructure for legal workflows, Definely chose LangGraph to flexibly design a multi-agent system that could help lawyers solve complex legal tasks.

[Definely](https://www.definely.com/?ref=blog.langchain.com) 正通过将 AI 驱动的解决方案深度融入律师的日常办公流程，彻底变革法律行业。Definely 致力于提升工作效率与准确性，正在构建一系列专用于 Microsoft Word 的智能代理（agents），助力律师高效完成合同起草、谈判与审阅等核心工作。为打造最高效的法律业务流程基础设施，Definely 选择 LangGraph，以灵活设计一套多智能体系统，切实赋能律师应对复杂的法律任务。

### **Key Problem: Time-consuming workflows for lawyers**

### **核心挑战：律师工作流程耗时低效**

Legal professionals often deal with high volumes of contracts, legal research, and document organization — tasks that are time-consuming and prone to human error. Previously, Definely utilized a retrieval-augmented generation (RAG) chatbot built on LangChain, a solution that primarily answered questions about contract content and was limited in the range of tasks it could solve.

法律从业者常需处理海量合同、开展法律研究、组织整理文档——这些任务不仅耗时漫长，且极易因人为因素出错。此前，Definely 基于 LangChain 构建了一个检索增强生成（RAG）型聊天机器人，该方案主要面向合同内容问答，功能覆盖范围有限，难以支撑更广泛的法律实务需求。

To address challenges in contract drafting, review and negotiation workflows, Definely is building an advanced agentic system composed of multiple specialised agents. Engineered to tackle a broader range of complex legal tasks that lawyers need to complete, this architecture is designed to:

为应对合同起草、审阅与谈判等环节中的现实挑战，Definely 正在构建一套先进的智能体系统，由多个高度专业化的智能体协同组成。该架构专为覆盖律师日常所需执行的更广泛、更复杂的法律任务而设计，具备以下核心能力：

- **Plan:** Break down intricate legal challenges into smaller, manageable subtasks.  
- **规划（Plan）**：将复杂的法律问题拆解为更小、更易处理的子任务。

- **Solve:** Deploy dedicated agents that work together to complete each subtask.  
- **解决（Solve）**：调用专属智能体协同协作，逐一完成各项子任务。

- **Adapt:** Dynamically revise the approach as tasks evolve.  
- **自适应（Adapt）**：根据任务进展动态调整策略与方法。

- **Interact:** Incorporate human input and approval at key moments to guide decisions.  
- **人机交互（Interact）**：在关键节点引入律师的人工输入与审批，确保决策方向正确可控。

![](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_001.png)

![](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_001.png)

### **Using LangGraph to build a customized multi-agent system**

### **借助 LangGraph 构建定制化多智能体系统**

Definely adopted LangGraph to build a sophisticated multi-agent system that enables lawyers to collaborate seamlessly with AI agents for various legal tasks. Definely’s decision to adopt LangGraph was driven by its graph-based architecture, which enabled the creation of an adaptable, highly customizable multi-agent framework that mirrors the way lawyers handle daily tasks. Its non-opinionated and flexible design makes it especially effective for complex fields like law, where integrating extensive domain knowledge and bespoke information is crucial. This approach empowers legal professionals to delegate specialized tasks to AI agents while retaining full oversight and control over the final outputs.

Definely 采用 LangGraph 构建了一套高度成熟的多智能体系统，使律师能够与 AI 智能体在各类法律任务中实现无缝协作。Definely 选择 LangGraph 的关键原因在于其图结构（graph-based）架构——该架构支持构建一个高度可适配、高度可定制的多智能体框架，精准复现律师日常处理事务的逻辑与流程。LangGraph “不预设范式”（non-opinionated）、高度灵活的设计理念，尤其契合法律这类高度复杂的专业领域：在该领域中，深度融合海量专业知识与机构特有信息至关重要。这一方法使法律专业人士得以将专业化任务放心交由 AI 智能体执行，同时始终保有对最终成果的全程监督权与最终控制权。

With LangGraph, Definely’s AI system can:

借助 LangGraph，Definely 的 AI 系统可实现以下能力：

- **Extract key contract information**: Automatically pull relevant details from contracts, including definitions, clauses and other kinds of contract data, accurately and reliably. This allows the lawyer to better understand the terms, obligations and commitments in a contract.  
- **提取关键合同信息**：自动、准确、可靠地从合同中抽取关键要素，包括定义条款、具体条文及其他各类合同数据，帮助律师全面把握合同中的权利义务与承诺事项。

- **Analyse consequence of changes to contract**: Analyse the consequence of each change made to a contract. This allows the lawyer to understand whether any changes to a contract have flow-on implications for other parts of the agreement.  
- **分析合同修改的影响**：逐项分析每一处合同修改可能引发的连锁影响。帮助律师判断某项修改是否会对协议其他部分产生实质性关联效应。

- **Answer complex legal queries**: Answer questions a user has across multiple contracts, ensuring that every pertinent aspect is considered. This allows the lawyer to better understand their contracts across multiple documents.  
- **解答复杂法律问题**：跨多份合同回答用户提出的综合性法律问题，确保所有相关维度均被纳入考量。帮助律师在多文档语境下形成对自身合同组合的整体性理解。

- **Draft and enhance contract language**: Assist in drafting, reviewing, summarizing, modifying and enhancing contract language without losing context - including drafting new clauses tailored to your needs and based on the lawyer’s prior work. This allows the lawyer to draft and review their contracts with speed, accuracy and high quality.  
- **起草与优化合同文本**：在不丢失上下文的前提下，辅助完成合同文本的起草、审阅、摘要、修订与优化——包括基于律师过往工作成果，量身定制符合其特定需求的新条款。助力律师以更高效率、更高精度、更高品质完成合同起草与审阅。

- **Seamless system integration & document management**: Integrate with your law firm’s document management system to access gold standard clauses, unique precedents, deal data, and historical knowledge enhancing decision-making, clause drafting, and responses to legal queries. This allows the lawyer to draft and review contracts in line with the firm’s practices and prior deals, and maintain the firm’s high quality standard.  
- **无缝系统集成与文档管理**：与律所现有文档管理系统深度集成，便捷调取“黄金标准”条款、独家判例模板、交易数据及历史知识库，从而提升决策质量、条款起草水平与法律咨询响应能力。助力律师严格遵循本所惯例与既往交易范式开展合同起草与审阅，持续维系律所一贯的高水准专业标准。

- **Contract mark-up**: Automatically mark-up legal teams’ contracts according to their guidelines, preferences, and prior deals. This allows the lawyer to draft and review contracts with high consistency, efficiency, and the relevant context.  
- **合同批注（Mark-up）**：依据法律团队内部指南、偏好设置及历史交易惯例，自动完成合同批注。助力律师在起草与审阅过程中，实现高度一致性、高效率与强上下文关联性。

![](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_002.jpg)

> _“LangGraph 的灵活性使我们能够构建出模拟法律专业人士工作方式的 AI 智能体。这对律师及整个行业而言，堪称一次范式变革。”_ — **Sigurjon Isaksson，Definely 公司 AI 负责人**

### **结论**

### **结论**

Definely 正蓄势待发，重新定义法律专业人士如何借助 AI 增强关键业务流程——在这些流程中，准确性至关重要。下一阶段的开发重点将放在拓展系统功能、优化智能体性能，以及确保与更多法律数据库和工具实现无缝集成。

随着 Definely 持续推进创新，公司始终致力于打造以 AI 驱动的法律基础设施，在显著提升工作效率的同时，坚守高精度这一核心标准。

随着 Definely 持续推进创新，公司始终致力于打造以 AI 驱动的法律基础设施，在显著提升工作效率的同时，坚守高精度这一核心标准。

### 标签

### Tags

[案例研究](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功代理的可观测性](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功代理的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/why-definely-chose-langgraph-for-building-their-multi-agent-ai-system/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
