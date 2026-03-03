---
title: "LangSmith is Now Available in Google Cloud Marketplace"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-is-now-available-in-google-cloud-marketplace/"
date: "2026-02-10"
scraped_at: "2026-03-02T10:08:14.000357936+00:00"
language: "en-zh"
translated: true
description: "Today, we&apos;re thrilled to announce that LangSmith, the agent engineering platform from LangChain, is available in Google Cloud Marketplace. Google Cloud customers can now procure LangSmith through..."
---

Today, we're thrilled to announce that LangSmith, the agent engineering platform from LangChain, is available in Google Cloud Marketplace. Google Cloud customers can now procure LangSmith through their existing Google Cloud accounts, enabling seamless billing, simplified procurement, and the ability to draw down on existing Google Cloud commitments.

今天，我们非常激动地宣布：LangChain 推出的智能体（agent）工程平台 LangSmith 现已上线 Google Cloud Marketplace。Google Cloud 客户现在可通过其现有的 Google Cloud 账户直接采购 LangSmith，从而实现账单无缝集成、采购流程简化，并可动用已有的 Google Cloud 承诺消费额度（commitments）。

LangSmith is already trusted by leading engineering teams to bring reliability and visibility to complex agentic workflows. This marketplace availability deepens our longstanding collaboration with Google Cloud. LangSmith's SaaS runs on Google Cloud infrastructure, and LangChain has closely partnered with Google on initiatives like the [Gemini model](https://ai.google.dev/gemini-api/docs/models?ref=blog.langchain.com) integration, [Agent2Agent (A2A) Protocol](https://developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/?ref=blog.langchain.com) and [MCP Toolbox for Databases](https://github.com/googleapis/genai-toolbox?ref=blog.langchain.com). LangSmith available in Google Cloud Marketplace is a natural next step in helping our joint customers build, test, and deploy production-ready AI applications.

LangSmith 已被众多领先工程团队信赖，用于提升复杂智能体工作流的可靠性与可观测性。此次登陆 Google Cloud Marketplace，进一步深化了 LangChain 与 Google Cloud 长期以来的战略合作。LangSmith 的 SaaS 服务运行于 Google Cloud 基础设施之上；同时，LangChain 也与 Google 在多项关键倡议中紧密协作，包括 [Gemini 模型](https://ai.google.dev/gemini-api/docs/models?ref=blog.langchain.com) 集成、[智能体间协议（Agent2Agent, A2A）](https://developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/?ref=blog.langchain.com)，以及 [面向数据库的 MCP 工具箱（MCP Toolbox for Databases）](https://github.com/googleapis/genai-toolbox?ref=blog.langchain.com)。LangSmith 登陆 Google Cloud Marketplace，是我们携手客户共同构建、测试并部署生产就绪型 AI 应用的水到渠成之举。

## Benefits of LangSmith

## LangSmith 的核心优势

LangSmith provides enterprise teams with a unified platform to debug, test, deploy, and monitor AI applications. Its core capabilities span observability, evaluation, prompt engineering, and deployment:

LangSmith 为大型企业团队提供统一平台，支持 AI 应用的调试、测试、部署与监控。其核心能力覆盖可观测性（Observability）、评估（Evaluation）、提示词工程（Prompt Engineering）及部署（Deployment）四大领域：

### Observability

### 可观测性

![](images/langsmith-is-now-available-in-google-cloud-marketplace/img_001.png)

LangSmith offers deep visibility into application behavior with detailed tracing and real-time monitoring. Engineering teams can inspect and debug individual interactions, configure alerts on key metrics, and track trends over time. This observability layer helps enterprise teams maintain auditability and explainability for agent behavior.

LangSmith 通过详尽的链路追踪（tracing）与实时监控，为应用行为提供深度可见性。工程团队可逐条检查与调试单次交互，针对关键指标配置告警，并长期跟踪性能趋势。这一可观测性层助力企业团队确保智能体行为的可审计性（auditability）与可解释性（explainability）。

### Evaluation

### 评估

![](images/langsmith-is-now-available-in-google-cloud-marketplace/img_002.png)

LangSmith makes it easy to evaluate application performance with both pre-deployment testing and continuous feedback on production traffic. Teams can run experiments to compare prompt or model changes, collect human feedback through annotation queues, and organize reusable datasets to track performance over time. This helps teams catch regressions and iterate to continuously improve quality.

LangSmith 让应用性能评估变得轻而易举——既支持上线前测试，也支持对生产流量的持续反馈。团队可开展实验，对比不同提示词或模型变更的效果；通过标注队列（annotation queues）收集人工反馈；还可组织可复用的数据集，长期跟踪性能表现。这有助于团队及时发现性能退化（regressions），并通过快速迭代持续提升质量。

### Deployment

### 部署

![](images/langsmith-is-now-available-in-google-cloud-marketplace/img_003.png)

LangSmith Deployment (formerly LangGraph Platform) provides the infrastructure needed to deploy, scale, and manage stateful, long-running agents. Teams can deploy in minutes with one-click GitHub integration, expose agents via 30+ API endpoints, and choose from SaaS, hybrid, or fully self-hosted options to meet compliance requirements.

LangSmith 部署（原 LangGraph 平台）提供部署、扩展和管理有状态、长期运行的智能体所需的基础设施。团队可通过一键 GitHub 集成在数分钟内完成部署，通过 30 多个 API 端点对外暴露智能体，并可根据合规性要求，灵活选择 SaaS、混合部署或完全自托管方案。

### Agent Builder

### 智能体构建器

![](images/langsmith-is-now-available-in-google-cloud-marketplace/img_004.png)

Build powerful AI agents in minutes with LangSmith Agent Builder - no coding required. Start with a ready-made template, connect the apps you already use, and let your agent take care of routine tasks like drafting emails, summarizing updates, and organizing information. Work with your agent directly in chat or through tools like Slack, so help is always where you need it. And with built-in approval workflows, you stay in control of the actions that matter most. It's automation that works for you, on your terms.

使用 LangSmith Agent Builder，无需编写代码，即可在几分钟内构建功能强大的 AI 智能体。从即用型模板入手，连接您已在使用的各类应用，让智能体自动处理日常任务，例如撰写邮件、汇总更新内容、整理信息等。您可直接在聊天界面中与智能体交互，也可通过 Slack 等工具调用其能力，确保支持始终触手可及。内置审批工作流让您对最关键的操作始终保持掌控权。这是一种真正为您服务、按您需求定制的自动化体验。

### Seamless Google Cloud Integration

### 与 Google Cloud 的无缝集成

![](images/langsmith-is-now-available-in-google-cloud-marketplace/img_005.png)

LangChain offers a [rich ecosystem of integrations](https://docs.langchain.com/oss/python/integrations/providers/google?ref=blog.langchain.com) with Google Cloud services, making it easy for GCP customers to build AI applications entirely within their cloud environment:

LangChain 提供了[丰富的 Google Cloud 服务集成生态](https://docs.langchain.com/oss/python/integrations/providers/google?ref=blog.langchain.com)，使 GCP 客户能够完全在自有云环境中构建 AI 应用：

- **Vertex AI & Gemini**: First-class support for Gemini models using the latest Gemini 3 Pro and Flash, plus access to 200+ models in Vertex AI Model Garden including Claude, Llama, and Mistral  
- **Vertex AI 与 Gemini**：全面支持最新版 Gemini 3 Pro 和 Gemini Flash 模型，并可访问 Vertex AI Model Garden 中超 200 种模型，涵盖 Claude、Llama、Mistral 等主流大模型  

- **Databases**: Native integrations with AlloyDB for PostgreSQL, BigTable, BigQuery, Spanner, Firestore, and Memorystore for vector storage, document loading, and chat history  
- **数据库**：原生集成 AlloyDB（PostgreSQL）、BigTable、BigQuery、Spanner、Firestore 及 Memorystore，支持向量存储、文档加载与对话历史管理  

- **Compute**: Fully managed SaaS where LangChain hosts and operates all LangSmith infrastructure and services built with GCP services like Google Kubernetes Engine (GKE)  
- **计算资源**：全托管 SaaS 模式——LangChain 基于 Google Kubernetes Engine（GKE）等 GCP 服务，负责托管并运维全部 LangSmith 基础设施与服务  

- **Tools:** Query financial data from Google Finance, interact with documents from Google Drive, search for trends from Google Trends.  
- **工具集成**：从 Google Finance 查询金融数据、与 Google Drive 中的文档交互、借助 Google Trends 搜索趋势信息。

These integrations mean GCP customers can leverage their existing data and infrastructure investments while gaining full observability and control through LangSmith.

这些集成意味着 Google Cloud Platform（GCP）客户能够在充分利用现有数据与基础设施投资的同时，通过 LangSmith 实现全面的可观测性与控制能力。

### Why Procure LangSmith via Google Cloud Marketplace

### 为何通过 Google Cloud Marketplace 采购 LangSmith

Procuring LangSmith through Google Cloud Marketplace offers significant benefits for enterprise teams:

通过 Google Cloud Marketplace 采购 LangSmith，可为企业团队带来显著优势：

- **Consolidated billing**: All LangSmith charges appear on your existing Google Cloud invoice, simplifying vendor management and financial reporting.  
- **统一账单管理**：所有 LangSmith 费用均体现在您现有的 Google Cloud 账单中，简化供应商管理和财务报表工作。

- **Draw down on committed spend**: LangSmith purchases count toward your Google Cloud committed spend, helping you maximize the value of existing cloud investments.  
- **抵扣承诺消费额度**：LangSmith 的采购金额可计入您的 Google Cloud 承诺消费额度，助您最大化现有云投资的价值。

- **Simplified procurement**: With Google Cloud already an approved vendor, teams can accelerate procurement cycles and reduce administrative overhead.  
- **简化采购流程**：由于 Google Cloud 已是经批准的供应商，团队可加快采购周期，并降低行政管理负担。

LangSmith is available in multiple deployment configurations to meet your security and compliance requirements from fully-managed SaaS (already running on Google Cloud infrastructure) to hybrid deployments where data stays in your VPC, to fully self-hosted on GKE with our Helm charts and Terraform modules.

LangSmith 提供多种部署配置，以满足您的安全与合规要求：包括完全托管的 SaaS 模式（已运行在 Google Cloud 基础设施之上）、混合部署模式（数据保留在您的 VPC 内），以及基于 Google Kubernetes Engine（GKE）的全自主托管模式（支持我们提供的 Helm Charts 和 Terraform 模块）。

### Getting Started

### 快速开始

Ready to bring reliability, visibility, and control to your AI applications on Google Cloud?

是否已准备好为您的 Google Cloud AI 应用带来可靠性、可观测性与可控性？

- [Get LangSmith in Google Cloud Marketplace](https://console.cloud.google.com/marketplace/product/langchain-public/langsmith?ref=blog.langchain.com)  
- [在 Google Cloud Marketplace 获取 LangSmith](https://console.cloud.google.com/marketplace/product/langchain-public/langsmith?ref=blog.langchain.com)

- [Contact sales](https://www.langchain.com/contact-sales?ref=blog.langchain.com) to discuss enterprise requirements  
- [联系销售团队](https://www.langchain.com/contact-sales?ref=blog.langchain.com)，探讨企业级需求

### About LangChain

### 关于 LangChain

LangChain provides the agent engineering platform and open source frameworks developers need to ship reliable agents fast. Our open source frameworks, LangGraph and LangChain, help developers build agents with speed and granular control, while LangSmith offers observability, evaluation, and deployment for rapid iteration. Trusted by millions of developers worldwide and AI teams at Klarna, Clay, Cloudflare, and Cisco, LangChain provides an integrated toolset to transform LLM systems into dependable production experiences.

LangChain 提供了开发者快速构建可靠智能体（agent）所需的智能体工程平台与开源框架。我们的开源框架 LangGraph 和 LangChain，助力开发者高效构建具备精细控制能力的智能体；而 LangSmith 则提供可观测性、评估能力与部署支持，加速迭代进程。LangChain 已获得全球数百万开发者的信赖，并被 Klarna、Clay、Cloudflare 和 Cisco 等企业的 AI 团队广泛采用，提供一体化工具集，将大语言模型（LLM）系统转化为稳定可靠的生产级体验。