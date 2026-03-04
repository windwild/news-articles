---
title: "How MUFG Bank increased sales efficiency by 10x with LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-mufgbank/"
date: "2025-02-28"
scraped_at: "2026-03-03T07:38:33.178896815+00:00"
language: "en-zh"
translated: true
description: "See how MUFG Bank used LangChain to streamline corporate sales research, cutting data analysis time from hours to minutes and boosting efficiency 10x."
tags: ["Case Studies"]
---
{% raw %}

MUFG Bank is Japan’s largest bank and one of the world's leading financial institutions. They provide capital market solutions to major corporate clients and promote economic growth around the world.

三菱日联银行（MUFG Bank）是日本最大的银行，也是全球领先的金融机构之一。该行为大型企业客户提供资本市场解决方案，并推动全球经济增长。

## **Problem: Solving data overload for corporate sales**

## **问题：解决企业销售中的数据过载难题**

In MUFG Bank's Global Capital Markets Division, the FX & Derivative Sales team faced a key challenge. FX & Derivative Sales team members needed to gather and analyze vast amounts of corporate data in order to create compelling client presentations – from 10k reports, to market data, to financial disclosures. This was a time-consuming process and skill-dependent (with junior members often needing additional guidance and assistance), which limited efficiency.

在三菱日联银行全球资本市场部（Global Capital Markets Division），外汇与衍生品销售团队（FX & Derivative Sales team）面临一项关键挑战：为制作富有说服力的客户演示材料，团队成员需收集并分析海量企业数据——包括10-K报告、市场数据及财务披露文件等。这一过程耗时长、高度依赖人员经验（初级员工往往需要额外指导与支持），严重制约了工作效率。

To address these challenges, MUFG’s AI/ML team leveraged Generative AI (GenAI) to streamline data digestion and automate the creation of presentation materials. Their goal was to empower sales teams with rapid insights, reducing manual burden and ensuring more effective client interactions.

为应对上述挑战，三菱日联银行AI/机器学习（AI/ML）团队引入生成式人工智能（GenAI），以简化数据处理流程，并自动化演示材料的生成。其目标是为销售团队提供即时洞察，减轻人工负担，从而确保更高效、更有成效的客户互动。

## **Solution: Using LangChain for retrieval and summarization**

## **解决方案：利用 LangChain 实现信息检索与内容摘要**

To improve the FX & Derivative Sales team’s client research process, the MUFG AI/ML team implemented two key steps:

为提升外汇与衍生品销售团队的客户研究效率，三菱日联银行AI/ML团队实施了两大关键步骤：

### **1) Data extraction & summarization**

### **1）数据提取与摘要生成**

Annual reports often spanned 100-200 pages, with only a fraction containing relevant insights for the sales teams. Using LangChain, MUFG developed a system to extract critical financial data efficiently – and they implemented fine-tuned prompt engineering and retrieval-augmented generation (RAG) to surface the most relevant sections for sales teams.

年度报告通常长达100–200页，其中仅一小部分包含对销售团队真正有价值的洞察。借助 LangChain，三菱日联银行开发了一套高效提取关键财务数据的系统——并通过精细化的提示词工程（prompt engineering）与检索增强生成（Retrieval-Augmented Generation, RAG）技术，精准定位并呈现最相关的内容章节供销售团队使用。

### **2) Automatically generate presentations**

### **2）自动生成演示文稿**

The FX & Derivative Sales teams required tailored presentations based on the extracted insights. To ensure the insights were actionable, the AI/ML team implemented few-shot prompting techniques and step-by-step guidance that helped FX & Derivative Sales professionals – even those with limited experience – quickly analyze financial opportunities and provide structured recommendations.

外汇与衍生品销售团队需要基于所提取的洞察，定制化生成演示文稿。为确保这些洞察具备可操作性，AI/ML团队采用了小样本提示（few-shot prompting）技术，并辅以分步式引导（step-by-step guidance），帮助外汇与衍生品销售人员——即便是经验尚浅者——快速分析金融机会，并输出结构清晰、切实可行的建议。

This enabled sales teams to assess interest rate risks, identify potential FX derivative purchases, and suggest regional currency positioning strategies.

这使得销售团队能够评估利率风险、识别潜在的外汇衍生品采购机会，并提出区域货币头寸配置策略。

The production RAG application now serves as a knowledge-sharing tool for corporate sales teams, simplifying the search for internal documents and deal-making ideas.

当前投入生产的 RAG 应用已成为企业销售团队的知识共享工具，大幅简化了内部文档检索和交易创意发掘流程。

## **Impact: Improving efficiency 10x in sales processes**

## **成效：销售流程效率提升 10 倍**

The adoption of LangChain-powered GenAI has yielded substantial improvements for MUFG’s corporate sales team. Specifically, the process of analyzing corporate client data and generating presentation materials has been **reduced** from several hours to just **3–5 minutes**.

MUFG 企业销售团队采用基于 LangChain 的生成式 AI 后，取得了显著成效。具体而言，分析企业客户数据并生成演示材料的整个流程已从原先的数小时缩短至仅需 **3–5 分钟**。

Previously, only limited experienced sales personnel could manually generate insightful presentations. With the new system, hundreds of sales professionals can now access the same level of intelligence, leading to a **10x increase** in the number of corporate clients receiving tailored financial recommendations.

过去，仅有少数经验丰富的销售人员能够手动制作富有洞察力的演示材料；而借助新系统，数百名销售专业人员如今均可获得同等水平的智能支持，从而使获得定制化财务建议的企业客户数量实现了 **10 倍增长**。

These efficiency gains have also begun converting into tangible business outcomes, with deal execution timelines shortening over the past six months.

这些效率提升正逐步转化为切实的业务成果——过去六个月中，交易执行周期已明显缩短。

## **Behind the scenes: How LangChain enabled MUFG’s success**

## **幕后揭秘：LangChain 如何助力 MUFG 取得成功**

The MUFG AI/ML team benefited from the LangChain programming library in the following two phases:

MUFG 的人工智能与机器学习（AI/ML）团队在以下两个阶段充分受益于 LangChain 编程库：

**R&D / PoC phase**

**研发与概念验证（PoC）阶段**

The MUFG AI/ML team chose the Python version of LangChain and built a simple chat and RAG app. LangChain is well integrated with Streamlit, allowing them to easily manage conversation history and implement interactive apps. This enabled them to quickly start experiments, gather feedback from the sales, and iterate on improvements. Furthermore, thanks to the Retriever interface, they were able to switch between several specific vector databases and search engines, allowing them to compare and validate the accuracy at a low implementation cost.

MUFG AI/ML 团队选用了 LangChain 的 Python 版本，构建了一个简易的聊天与 RAG 应用。LangChain 与 Streamlit 高度集成，使其能轻松管理对话历史并开发交互式应用。这帮助团队快速启动实验、收集销售团队的反馈，并持续迭代优化。此外，得益于 LangChain 提供的 Retriever（检索器）接口，团队可在多种特定向量数据库与搜索引擎之间灵活切换，从而以较低的开发成本完成效果对比与准确性验证。

**Development / Production phase**

**开发/生产阶段**

The MUFG team switched to the TypeScript version of LangChain for a more sustainable and secure application via Next.js. The interface was nearly identical to the Python version, ensuring a smooth transition. In addition, Runnable Lambda allowed them to dynamically change the content filter and target index on demand and enabled them to invoke it in their custom RAG chain.

MUFG 团队转向使用 LangChain 的 TypeScript 版本，以通过 Next.js 构建更可持续、更安全的应用程序。其接口与 Python 版本几乎完全一致，确保了平滑过渡。此外，Runnable Lambda 使团队能够按需动态调整内容过滤器和目标索引，并支持将其集成至自定义的 RAG 链中。

## **What’s Next**

## **下一步计划**

MUFG Bank plans to refine its GenAI applications by enhancing its evaluation metrics, exploring graph-based AI architectures or AI agents for complex reasoning tasks, and expanding its RAG-driven retrieval system to incorporate broader financial data sources.

三菱日联银行（MUFG Bank）计划通过以下方式进一步优化其生成式 AI（GenAI）应用：提升评估指标体系；探索基于图结构的 AI 架构或面向复杂推理任务的 AI Agent；并扩展其 RAG 驱动的检索系统，以纳入更广泛的金融数据源。

By leveraging LangChain, MUFG continues to advance AI-driven sales intelligence, improving efficiency, scalability, and strategic decision-making for its global clientele.

依托 LangChain，MUFG 持续推进 AI 驱动的销售智能建设，从而提升运营效率、系统可扩展性以及面向全球客户的战略决策能力。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_001.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_002.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-mufg-bank-increased-sales-efficiency-by-10x-with-langchain/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
{% endraw %}
