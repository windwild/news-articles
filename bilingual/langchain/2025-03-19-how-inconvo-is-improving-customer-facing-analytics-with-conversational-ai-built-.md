---
title: "How Inconvo is improving customer-facing analytics with conversational AI built on LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-inconvo/"
date: "2025-03-19"
scraped_at: "2026-03-03T07:37:05.341803058+00:00"
language: "en-zh"
translated: true
description: "See how Inconvo leverages LangGraph to empower non-technical users to conduct data analysis seamlessly through natural language queries."
tags: ["Case Studies"]
---

[Inconvo](https://inconvo.ai/?ref=blog.langchain.com) 是一家 YC S23 期初创公司，致力于为非技术用户简化数据分析流程。本案例研究将重点介绍 Inconvo 如何利用 [LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) 和 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 来优化其数据查询流程。

## **问题：突破数据分析的使用门槛**

Inconvo 致力于解决一个普遍存在的难题——许多非技术用户在使用传统商业智能（BI）工作流时，难以从数据中提取简单洞察。例如，某 SaaS 应用的用户可能仅为了回答“过去两周我卖出了多少产品？”这样直白的问题，就不得不费力地操作复杂的 BI 工具。这种低效不仅浪费时间，更严重限制了用户基于数据做出决策的能力。

随着 Inconvo 希望赋能用户以自然语言提问、彻底摆脱对数据分析专业技术依赖的目标日益明确，一种更直观的解决方案变得尤为迫切。通过提供简洁易用的 API，Inconvo 致力于帮助开发者轻松为其应用集成对话式分析能力。

## **智能体用户体验：面向对话式数据分析的 API**

Inconvo 的智能体接口为用户提供多种数据可视化与交互方式。当用户提交自然语言查询时，API 将以如下 JSON 格式返回结果：

- 柱状图：用于对比分类数据  
- 折线图：用于时间序列分析  
- 表格：用于详细数据查看  
- 纯文本：用于简明直接的答案  

![](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_001.jpg)

该 API 支持用户以对话方式迭代优化查询。例如，在查看初始结果后，用户可进一步要求更换图表类型，或提出更精细的数据筛选条件。这种交互式体验让复杂的数据分析对非技术用户触手可及，无需学习 SQL 或掌握专用 BI 工具。

## **借助 LangGraph 构建强大的查询处理系统**

[LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) plays a key role in Inconvo's architecture and has enabled a multi-step workflow that efficiently processes user queries. When a user submits a question, LangGraph orchestrates the entire data retrieval process, starting with an introspection of the database to understand its schema. This allows Inconvo to configure which data is accessible and how it can be queried.

[LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) 在 Inconvo 的架构中扮演着关键角色，赋能其构建多步骤工作流，从而高效处理用户查询。当用户提交问题时，LangGraph 全程编排数据检索流程——首先对数据库进行内省（introspection），以理解其结构（schema）。这使得 Inconvo 能够灵活配置哪些数据可被访问，以及如何对其进行查询。

Inconvo’s architecture utilizes LangGraph to manage conditional workflows, where different operations can be executed based on the user's input. This includes selecting tables, executing SQL queries, and returning structured outputs in various formats. By integrating with LangGraph, Inconvo can handle complex queries with multiple steps, ensuring that users receive accurate and relevant results quickly.

Inconvo 的架构借助 LangGraph 管理条件式工作流（conditional workflows），即根据用户输入动态执行不同操作，包括：选择数据库表、执行 SQL 查询，以及以多种格式返回结构化输出。通过与 LangGraph 深度集成，Inconvo 能够高效处理包含多个步骤的复杂查询，确保用户快速获得准确且相关的结果。

The cognitive architecture follows a deliberate reasoning pattern:

认知架构遵循一种审慎、分步的推理模式：

1. Parse the user's natural language query  
   1. 解析用户的自然语言查询  
2. Map the query to relevant database tables and fields  
   2. 将查询映射至相关的数据库表与字段  
3. Generate appropriate SQL queries  
   3. 生成恰当的 SQL 查询语句  

## **Conclusion**

## **结语**

Inconvo's use of LangGraph has transformed how non-technical users interact with their data, breaking down barriers to data analysis through natural language processing. By eliminating the need for specialized technical skills, Inconvo has democratized access to data insights, enabling users across various industries to make informed decisions quickly and efficiently. This case study demonstrates how innovative AI solutions can solve real-world problems and create more intuitive user experiences in the data analytics space.

Inconvo 对 LangGraph 的应用，彻底改变了非技术人员与其数据交互的方式——依托自然语言处理（NLP）技术，消除了数据分析的门槛。通过摒弃对专业技能的依赖，Inconvo 实现了数据洞察的“大众化”（democratization），使各行各业的用户都能快速、高效地做出明智决策。本案例研究印证了创新性 AI 解决方案如何切实解决现实问题，并在数据分析领域打造更直观、更人性化的用户体验。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies（案例研究）](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[Case Studies（案例研究）](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-inconvo-is-improving-customer-facing-analytics-with-conversational-ai-built-/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[Case Studies（案例研究）](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读