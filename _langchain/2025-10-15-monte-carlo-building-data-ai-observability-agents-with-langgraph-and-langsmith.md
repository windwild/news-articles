---
render_with_liquid: false
title: "Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-monte-carlo/"
date: "2025-10-15"
scraped_at: "2026-03-03T07:23:52.425815519+00:00"
language: "en-zh"
translated: true
description: "See how Monte Carlo built its AI Troubleshooting Agent on LangGraph and debugged with LangSmith to help data teams resolve issues faster"
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

![](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_001.png)  
蒙特卡洛（Monte Carlo）[故障排查智能体（Troubleshooting Agent）](https://www.montecarlodata.com/platform/observability-agents?ref=blog.langchain.com) 架构的高层概览

[**Monte Carlo**](https://www.montecarlodata.com/?ref=blog.langchain.com) 是面向企业级客户的领先数据与 AI 可观测性平台，助力组织监控数据与 AI 的可靠性问题，并追溯至其根本原因。在多年构建复杂的数据监控与故障排查工具过程中，Monte Carlo 意识到：他们实际上已在不知不觉中，为后来成为其旗舰 AI 智能体的系统打下了坚实基础——该系统可同时启动数百个子智能体，对数据问题展开多线程调查，并以直观、可操作的方式显著加速根因分析。

## **在企业级规模上实现数据流水线故障排查自动化**

大型企业的数据工程师需耗费大量时间手动处理数据告警——检查失败的作业、追踪代码变更、判断问题是否需立即修复或可暂缓处理。这种人工排查方式迫使工程师只能按单一路径顺序推进调查，往往遗漏并行存在的其他问题，或在高度耦合、错综复杂的分布式数据系统中耗时过久才能定位根本原因。

Monte Carlo 的客户主要为大型企业，其业务收入高度依赖数据驱动。对这些客户而言，**持续存在错误或不可用的数据，可能直接影响数百万美元的业务收益**。尽管 Monte Carlo 已构建了全面的故障排查工具，但他们发现了一个进一步缩短“数据停机时间（data downtime）”的关键机会：借助 AI 智能体，同步处理并推理数百种假设，从而大幅提升数据与 AI 团队快速识别并修复特定数据质量事件根本原因的能力。

![](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_002.png)

## **借助 LangGraph 实现多路径故障排查**

Monte Carlo 选择 **LangGraph** 作为其 AI 故障排查智能体（AI Troubleshooting Agent）的基础框架，因为其实际排查流程天然契合图结构化的决策流。当告警触发时，其系统遵循一套结构化的问题排查方法论——该方法论复刻了资深数据工程师解决问题的思路，但可规模化执行。

告警 → 检查代码变更 → 分析时间线 → 调查依赖关系 → 输出调查结果

其 LangGraph 实现始于一条告警，并据此动态构建一张由多个调查节点组成的图。每个节点均可依据当前发现结果生成新的子节点，从而使智能体能够：

- Check for code changes in the past 7 days  
- 检查过去 7 天内的代码变更  

- Narrow down to changes affecting the specific data pipeline  
- 聚焦于影响特定数据管道的变更  

- Look at events occurring hours before the issue  
- 查看问题发生前数小时内的事件  

- Investigate multiple potential root causes simultaneously  
- 同时调查多个潜在的根本原因  

**The key advantage**: While human troubleshooters follow one path at a time, Monte Carlo's agent can explore multiple investigation branches in parallel, checking significantly more scenarios than any individual data engineer could handle manually.  

**关键优势**：人类排查人员一次只能沿一条路径推进，而 Monte Carlo 的智能体可并行探索多条调查分支，验证的场景数量远超任何一名数据工程师手动所能完成的工作量。

Monte Carlo's Product Manager, Bryce Heltzel, notes that LangGraph's value was in achieving speed to market. With a tight 4-week deadline ahead of major industry summits, the team felt confident demonstrating their agent to customers— something that wouldn't have been possible with a custom-built solution.  

Monte Carlo 产品总监 Bryce Heltzel 指出，LangGraph 的核心价值在于显著加快了上市速度。面对大型行业峰会前仅剩的 4 周紧张工期，团队已信心十足地向客户演示其智能体——若采用自研方案，则根本无法实现这一目标。

## **Debugging with LangSmith**  

## **使用 LangSmith 进行调试**

Monte Carlo started debugging using LangSmith on day one of development. As Heltzel explains, "LangSmith was a natural choice as we started building our agent in LangGraph. We wanted LangSmith to visualize what we were developing for our graph-based workflows."  

Monte Carlo 在开发第一天起便开始使用 LangSmith 进行调试。Heltzel 解释道：“当我们着手基于 LangGraph 构建智能体时，LangSmith 成为了顺理成章的选择。我们希望借助 LangSmith 可视化呈现图结构工作流的开发过程。”

As a product manager, Heltzel is very involved in the process of prompt engineering for their agents. With his deep context about customer use cases, he can now iterate quickly on prompts directly rather than going through engineering cycles.  

作为产品经理，Heltzel 深度参与其智能体的提示词工程（prompt engineering）工作。凭借对客户实际用例的深刻理解，他如今可直接快速迭代优化提示词，无需再反复经过工程开发周期。

The Monte Carlo team has been able to focus on agent logic and solving data issues for customers rather than tooling setup due to the minimal configuration LangSmith required to get up and running.  

得益于 LangSmith 极简的配置要求，Monte Carlo 团队得以将精力集中于智能体逻辑设计与客户数据问题的解决，而非耗费时间在工具链搭建上。

## **Monte Carlo's architecture**  

## **Monte Carlo 的系统架构**

This architecture leverages several AWS services to build a scalable, secure, and decoupled system that connects Monte Carlo’s existing monolithic platform with its new AI Agent stack. We use **Amazon Bedrock** to empower our agents with the latest foundational models without the need to manage any infrastructure. The **Auth Gateway Lambda** handles authentication as a lightweight, serverless entry point, ensuring secure access without maintaining dedicated servers. The **Monolith Service** continues to serve core APIs (GraphQL and REST) and persists application data in **Amazon RDS**, a managed relational database that provides reliability and automated maintenance.  

该架构整合多项 AWS 服务，构建出一个具备高可扩展性、高安全性与松耦合特性的系统，成功连接 Monte Carlo 现有的单体式平台与其全新的 AI 智能体技术栈。我们采用 **Amazon Bedrock**，使智能体能够直接调用业界最新的基础大模型，且完全无需自行管理底层基础设施。**认证网关 Lambda（Auth Gateway Lambda）** 作为轻量级、无服务器的入口点，负责处理身份认证，确保访问安全，同时避免维护专用服务器。**单体服务（Monolith Service）** 则持续提供核心 API（包括 GraphQL 和 REST 接口），并将应用数据持久化存储于 **Amazon RDS** —— 一款托管式关系型数据库，具备高可靠性与自动化运维能力。

On the AI side, the **AI Agent Service** runs on **Amazon ECS Fargate**, which enables containerized microservices to scale automatically without managing underlying infrastructure. Incoming traffic to the AI Agent Service is distributed through a network load balancer (NLB), providing high-performance, low-latency routing across Fargate tasks. Together, these AWS components create a robust system where the legacy monolith and modern AI microservices interoperate efficiently, with secure authentication, resilient data storage, and elastic compute scaling.  

在 AI 侧，**AI 智能体服务（AI Agent Service）** 运行于 **Amazon ECS Fargate** 之上，支持容器化微服务自动弹性伸缩，且无需管理底层基础设施。进入 AI 智能体服务的流量由网络负载均衡器（NLB）统一分发，为各 Fargate 任务提供高性能、低延迟的路由能力。上述 AWS 组件协同工作，构建出一套稳健可靠的系统：传统单体架构与现代 AI 微服务高效协同，兼具安全认证、高韧性数据存储与弹性计算能力。

![](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_003.png)

## **What's next**

## **下一步计划**

Monte Carlo is currently focused on visibility and validation — understanding where bugs occur in their traces and building robust feedback mechanisms to ensure their agent consistently delivers value to customers. They're working on validation scenarios to measure whether the agent successfully identifies root causes in each investigation.

蒙特卡洛公司当前的重点是提升可观测性与验证能力——即深入理解其追踪（traces）中缺陷发生的位置，并构建稳健的反馈机制，以确保其智能体（agent）持续为客户提供实际价值。他们正在设计一系列验证场景，用于评估该智能体是否能在每一次故障调查中成功识别根本原因。

Looking ahead, Monte Carlo plans to expand their agent's capabilities while maintaining the core value proposition: **enabling data teams to resolve issues faster and more comprehensively than ever before**. Their head start in building data + AI observability tools, combined with LangGraph's flexible architecture and LangSmith's debugging capabilities, positions them to continue leading the data + AI observability space.

展望未来，蒙特卡洛公司计划在坚守其核心价值主张的前提下，进一步拓展该智能体的功能：**赋能数据团队以前所未有的速度与全面性解决各类问题**。凭借其在数据 + AI 可观测性工具领域的先发优势，叠加 LangGraph 的灵活架构与 LangSmith 强大的调试能力，该公司已确立并有望持续引领数据 + AI 可观测性这一前沿领域。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_004.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_005.png)](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_006.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![ServiceNow 如何利用 LangSmith 实现对其客户成功智能体的可观测性](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How Bertelsmann Built a Multi-Agent System to Empower Creatives](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_009.png)](https://blog.langchain.com/customer-bertelsmann/)

[![贝塔斯曼如何构建多智能体系统以赋能创意人员](images/monte-carlo-building-data-ai-observability-agents-with-langgraph-and-langsmith/img_009.png)](https://blog.langchain.com/customer-bertelsmann/)

[**How Bertelsmann Built a Multi-Agent System to Empower Creatives**](https://blog.langchain.com/customer-bertelsmann/)

[**贝塔斯曼如何构建多智能体系统以赋能创意人员**](https://blog.langchain.com/customer-bertelsmann/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 6 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：6 分钟