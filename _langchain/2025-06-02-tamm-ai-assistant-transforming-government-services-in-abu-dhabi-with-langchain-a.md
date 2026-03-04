---
render_with_liquid: false
title: "TAMM AI Assistant: Transforming Government Services in Abu Dhabi with LangChain and LangGraph\""
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-abu-dhabi-government/"
date: "2025-06-02"
scraped_at: "2026-03-03T07:31:42.783521421+00:00"
language: "en-zh"
translated: true
description: "See how the Abu Dhabi Government powers their government services platform with LangGraph and LangChain to achieve efficiency and precision."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

The TAMM platform, Abu Dhabi Government’s exclusive one-stop shop, offers more than 940 services to citizens, residents, visitors, and businesses in the emirate. Recognised globally for its cutting-edge technologies and innovation, TAMM enables users to access essential services such as applying for driving licenses, paying fines, and retrieving personal documents.

阿布扎比政府专属的一站式服务平台 TAMM，为该酋长国的公民、居民、访客及企业提供了逾 940 项服务。凭借其前沿技术与创新实践，TAMM 在全球范围内广受认可，使用户能够便捷获取各类核心政务服务，例如申领驾驶执照、缴纳罚款以及调取个人证件。

In October 2024, during GITEX Global, the Department of Government Enablement – Abu Dhabi (DGE) launched the third-generation evolution of the platform, TAMM 3.0, to its more than 2.8 million active users. This launch highlighted the growing role of artificial intelligence (AI) within the TAMM ecosystem, demonstrating that AI is now embedded in every aspect of TAMM – from service delivery to customer care, to day-to-day operations and decision-making. At the core of this transformation is the AI-powered TAMM Assistant, which has become a game-changer in service delivery.

2024 年 10 月，在 GITEX Global 展会期间，阿布扎比政府赋能部（DGE）面向其逾 280 万活跃用户正式推出平台第三代升级版本——TAMM 3.0。此次发布凸显了人工智能（AI）在 TAMM 生态系统中日益增强的核心作用：AI 已深度融入 TAMM 的方方面面——从政务服务交付、客户关怀，到日常运营与决策支持。驱动这一转型的核心，正是由 AI 赋能的 TAMM 助理，它已成为提升政务服务效能的颠覆性力量。

/1:52

1×

/1:52

1×

TAMM’s AI Assistant goes beyond answering questions – it proactively anticipates customer needs, performs personalised tasks, automates service execution, and generates actionable insights to create a seamless government experience. Built on LangChain and LangGraph, this advanced system is a major step forward in enhancing citizen engagement and optimising government services.

TAMM 的 AI 助理远不止于回答问题——它能主动预判用户需求、执行个性化任务、自动化办理政务服务，并生成可落地的洞察分析，从而打造无缝衔接的政府服务体验。该先进系统基于 LangChain 与 LangGraph 构建，标志着提升公众参与度、优化政府服务的重大进步。

## **Agentic Framework –** **Five Key Workflows for TAMM’s AI Assistant**

## **智能体框架——TAMM AI 助理的五大核心工作流**

The TAMM AI Assistant is powered by LangChain, a system chosen for its proven flexibility and robust capabilities in seamless handling of complex workflows. Guided by the DGE and TAMM leadership, TAMM’s AI engineering team prioritised creating an efficient and user-centric system, enabling seamless access to TAMM’s broad range of services. From personal document inquiries to support requests, every interaction reflects DGE’s commitment to innovation and operational excellence.

TAMM AI 助理依托 LangChain 构建；该框架因其在高效处理复杂工作流方面久经验证的灵活性与强大能力而被选定。在阿布扎比政府赋能部（DGE）与 TAMM 领导层的指导下，TAMM 的 AI 工程团队将构建高效、以用户为中心的系统作为首要目标，确保用户能够顺畅访问 TAMM 全系列广泛服务。无论是查询个人证件，还是提交支持请求，每一次交互都体现了 DGE 对创新精神与卓越运营的坚定承诺。

LangChain provided the necessary infrastructure to manage complex queries, retrieve relevant data, and facilitate seamless interactions across multiple systems. At the heart of TAMM’s AI Assistant are five critical workflows that ensure government services are accessible, personalised, and streamlined:

LangChain 提供了管理复杂查询、检索相关数据，并在多个系统间实现无缝交互所必需的技术基础设施。TAMM AI 助理的核心，是五大关键工作流——它们共同保障政府服务的可及性、个性化与高效化：

**1) Service inquiry and information retrieval**: This flow enables the assistant to efficiently address a wide variety of questions related to TAMM’s 940+ services. By utilising an advanced RAG pipeline, powered by LangChain, the assistant can connect to TAMM’s service databases to provide accurate and concise responses. It can answer questions such as:

**1) 服务咨询与信息检索**：该工作流使助理能够高效响应与 TAMM 超过 940 项服务相关的各类问题。借助 LangChain 驱动的先进 RAG（检索增强生成）流水线，助理可直连 TAMM 服务数据库，提供准确、简洁的答案。例如，它可解答以下问题：

- _“How do I renew my passport?”_  
- _“What documents are required for a driving license application?”_  
- _“What’s the weather today in Abu Dhabi?”_

- _“我该如何更新我的护照？”_  
- _“申领驾驶执照需要哪些材料？”_  
- _“今天阿布扎比的天气如何？”_

**2) User-specific data interaction**: Designed to provide personalised service, this flow tailors responses based on the user’s individual data and history. It allows the assistant to address user-specific queries such as:

- _“Show me my valid documents.”_  
- _“What payments do I owe?”_  
- _“What documents are about to expire?”_

**2) 用户专属数据交互**：该流程旨在提供个性化服务，根据用户的个人数据与历史记录动态定制响应内容，使助手能够精准回应用户专属问题，例如：

- _“请展示我当前有效的证件。”_  
- _“我还有哪些待缴款项？”_  
- _“哪些证件即将过期？”_

**3) Service execution**: This flow enables users to seamlessly execute commonly requested services directly through the AI Assistant. Rather than recreating services within the assistant, TAMM’s ecosystem is channel-agnostic, allowing users to access and complete services across any platform. Whether using the mobile app, web portal, or AI Assistant, users enjoy a consistent and unified experience.

**3) 服务执行**：该流程支持用户直接通过AI助手无缝办理高频政务服务。TAMM生态采用“渠道无关”（channel-agnostic）设计，无需在助手内部重复构建服务功能，用户可在移动应用、网页门户或AI助手等任一平台访问并完成服务，全程体验一致、统一。

**4) General knowledge and discussion**: This flow harnesses the broad capabilities of Large Language Models (LLMs), enabling users to expand their enquiries beyond specific topics. For instance, users can ask questions like, “What is the best place to go camping in Abu Dhabi?” and receive insightful, context-aware responses.

**4) 通用知识与对话交流**：该流程充分发挥大语言模型（LLMs）的广泛能力，支持用户就各类非政务专属主题展开延伸性提问。例如，用户可提出：“阿布扎比最适合露营的地方是哪里？”，并获得富有洞察力、上下文感知的智能回复。

**5) Support flow**: This flow is designed to direct users to the appropriate support channel based on their intent. A standout feature in TAMM 3.0 and the TAMM AI Assistant is "Take Photo and Report," which enhances the ability of the Abu Dhabi Government to assist users with their everyday needs. This feature allows users to capture a photo or video of any incident. The AI then extracts the relevant details, automatically submitting the report with time, date, and location stamps. The incident is then routed to the appropriate Abu Dhabi Government entity for resolution, ensuring a streamlined and efficient response process.

**5) 支持服务流程**：该流程依据用户意图，智能引导其至最匹配的支持渠道。TAMM 3.0 及 TAMM AI 助手的一大亮点功能是“拍照上报”（Take Photo and Report），显著提升了阿布扎比政府响应民众日常需求的能力。用户可通过该功能拍摄任意事件的照片或视频；AI将自动提取关键信息，并附带时间、日期及地理位置水印，一键提交报告；系统随即把事件分派至对应的阿布扎比政府职能部门处理，确保响应流程高效、顺畅。

Additionally, TAMM AI Assistant operates within strict guardrails to ensure that all responses adhere to the standards set by the Abu Dhabi Government.

此外，TAMM AI 助手严格遵循预设的安全护栏（guardrails），确保所有生成内容均符合阿布扎比政府制定的各项规范与标准。

Leveraging LangChain’s robust orchestration capabilities, the AI Assistant seamlessly integrates with TAMM’s unified backend, enabling real-time functionality for users without adding unnecessary complexity.

依托 LangChain 强大的编排（orchestration）能力，AI 助手与 TAMM 统一后端实现无缝集成，在不增加额外复杂性的前提下，为用户提供实时响应功能。

Together, these advanced workflows strengthen TAMM’s position as a global leader, offering a unified, intuitive super app experience across multiple channels. Whether for citizens, residents, visitors, or businesses, TAMM continues to lead the way in delivering a comprehensive, omnichannel service experience.

上述先进工作流协同发力，进一步巩固了 TAMM 作为全球领先数字政务平台的地位，为公民、居民、访客及企业用户打造跨渠道统一、直观易用的“超级应用”（super app）体验，持续引领全方位、全渠道政务服务新范式。

![](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_001.png)High Level TAMM AI Assistant Conceptual Architecture

![](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_001.png)TAMM AI 助手高层概念架构图

## **Why LangGraph? Elevating Flexibility and Standardisation**

## **为何选择 LangGraph？提升灵活性与标准化水平**

TAMM’s AI engineering team designed TAMM’s AI Assistant to scale with the growing needs of its users. Leveraging LangChain and LangGraph, the system transitioned to a multi-agent architecture that ensures agility, efficiency, and precision in managing user data including payments and document histories. This forward-thinking approach underscores TAMM’s role, under DGE, as a leader in digital government services.

TAMM 的 AI 工程团队设计了 TAMM AI 助手，以满足用户日益增长的需求。该系统依托 LangChain 和 LangGraph，转向多智能体（multi-agent）架构，从而在管理用户数据（包括支付记录和文档历史）时确保敏捷性、高效性与精准性。这一前瞻性的技术路径凸显了 TAMM 在迪拜政府实体（DGE）领导下作为数字政务服务领军者的地位。

## **What’s Next?**

## **下一步是什么？**

TAMM’s AI Assistant represents the future of citizen engagement, with advanced coordination among AI agents ensuring seamless and context-aware service delivery. This innovation reflects DGE’s unwavering commitment to setting global benchmarks in digital transformation.

TAMM AI 助手代表了未来公民参与服务的新范式——通过 AI 智能体之间的高级协同，实现无缝衔接、上下文感知的服务交付。这一创新彰显了迪拜政府实体（DGE）致力于在全球数字化转型领域树立标杆的坚定承诺。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_002.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成快速入驻](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 完成数千名客户的入职流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功智能体的可观测性](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/tamm-ai-assistant-transforming-government-services-in-abu-dhabi-with-langchain-a/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)