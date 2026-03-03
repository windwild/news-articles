---
title: "LangSmith and LangGraph Platform are now available in AWS Marketplace"
source: "LangChain Blog"
url: "https://blog.langchain.com/aws-marketplace-july-2025-announce/"
date: "2025-10-13"
scraped_at: "2026-03-03T07:25:43.628255704+00:00"
language: "en-zh"
translated: true
description: "LangSmith and LangGraph Platform (self-hosted deployments) are now available in AWS Marketplace."
---

_Note: As of October 2025, LangGraph Platform has been re-named to "LangSmith Deployment"._

_注：截至 2025 年 10 月，LangGraph Platform 已正式更名为 “LangSmith Deployment”。_

Today, we’re excited to announce that LangSmith and LangGraph Platform are available in the new [AI Agents and Tools category of AWS Marketplace](https://aws.amazon.com/marketplace/pp/prodview-vmzygmggk4gms?sr=0-1&ref_=beagle&applicationId=AWSMPContessa&ref=blog.langchain.com).

今天，我们很高兴地宣布：LangSmith 与 LangGraph Platform 已上线全新 [AWS Marketplace “AI Agents and Tools”（AI 智能体与工具）分类](https://aws.amazon.com/marketplace/pp/prodview-vmzygmggk4gms?sr=0-1&ref_=beagle&applicationId=AWSMPContessa&ref=blog.langchain.com)。

Customers can now use AWS Marketplace to easily discover, buy, and deploy LangSmith and LangGraph Platform using their AWS accounts, accelerating agent and agentic workflow development.

客户现可通过 AWS Marketplace，使用其 AWS 账户轻松发现、购买并部署 LangSmith 与 LangGraph Platform，从而加速智能体（agent）及自主式工作流（agentic workflow）的开发进程。

LangSmith and LangGraph Platform are already trusted by leading engineering teams to bring reliability, visibility, and control to complex agentic workflows. As Nicholas Larus-Stone, Software Engineer at Benchling, puts it:

LangSmith 与 LangGraph Platform 已获得众多领先工程团队的信任，为复杂智能体工作流提供可靠性、可观测性与可控性。Benchling 公司软件工程师 Nicholas Larus-Stone 表示：

> _“LangSmith gives us full visibility into our LLM workflows – without compromising on data privacy or control.”_

> _“LangSmith 让我们对大语言模型（LLM）工作流实现端到端可观测——且丝毫不牺牲数据隐私与控制权。”_

With this Marketplace availability, teams can now run LangChain’s commercial offerings entirely within their AWS VPCs via Helm charts— while benefiting from centralized purchasing, security assurance, and seamless integration with their Amazon EKS clusters.

借助此次 Marketplace 上线，团队现可通过 Helm Chart 将 LangChain 商业版产品完全部署于自有 AWS 虚拟私有云（VPC）内，同时享受集中化采购、安全合规保障，以及与 Amazon EKS 集群的无缝集成。

## **Benefits of LangSmith**

## **LangSmith 的核心优势**

LangSmith provides enterprise teams with a unified platform to debug, test, and monitor AI app performance. Its core capabilities span prompt engineering, evaluation, and observability:

LangSmith 为企业团队提供统一平台，用于调试、测试与监控 AI 应用性能。其核心能力覆盖提示词工程（Prompt Engineering）、评估（Evaluation）与可观测性（Observability）三大领域：

**Prompt Engineering**

**提示词工程**

LangSmith enables structured, collaborative prompt development. The Prompt Hub allows users to version, manage, and share prompts across teams, while the Prompt Playground allows for rapid testing and comparison of different models before deployment. These tools help engineering and domain experts iterate quickly together and ensure consistency across use cases.

LangSmith 支持结构化、协作式的提示词开发：Prompt Hub（提示词中心）支持用户对提示词进行版本管理、统一维护与跨团队共享；Prompt Playground（提示词沙盒）则支持在部署前快速测试并横向对比不同模型的效果。这些工具助力工程师与领域专家高效协同迭代，并确保各类应用场景下提示词行为的一致性。

**Evals**

**评估（Evals）**

LangSmith 使应用性能评估变得简单，既支持上线前的测试，也支持对生产流量的持续反馈。团队可以运行实验来对比提示词（prompt）或模型的变更效果，通过标注队列收集人工反馈，并组织可复用的数据集以长期追踪性能表现。这有助于团队及时发现性能退化、量化质量指标，并更有信心地发布新版本。

**Observability**

**可观测性（Observability）**

LangSmith 提供深度的应用行为可见性，支持细粒度的链路追踪（tracing）与实时监控。工程团队可逐条检查和调试具体交互实例，针对关键指标配置告警，并随时间推移追踪性能趋势。这一可观测性能力，助力企业级团队保障服务质量、满足审计要求，并提升智能体（agent）行为的可解释性。

## **Benefits of LangGraph Platform**

## **LangGraph 平台的优势**

LangGraph Platform 提供了部署、扩展和管理有状态、长时间运行的智能体（agent）所需的基础设施。它支持团队实现以下目标：

**Deploy agents with ease**

**轻松部署智能体**

LangGraph Platform 专为长时间运行的智能体工作负载而设计，开箱即支持突发流量处理、持久化状态管理以及异步协同。团队可通过一键式 GitHub 集成在数分钟内完成部署，并根据合规性要求，灵活选择 SaaS、混合部署或完全自托管方案。

**Accelerate agent development with visual workflows**

**借助可视化工作流加速智能体开发**

构建优秀的智能体需要快速的反馈闭环。LangGraph Studio —— LangGraph Platform 内置的智能体集成开发环境（IDE）—— 使开发者能够实时可视化、调试和测试智能体工作流。无需从头反复尝试，LangGraph Platform 内置的检查点（checkpointing）机制与记忆模块（memory modules），让开发者可以轻松回溯、编辑并重新运行失败节点，显著降低开发挫败感。

**Centralize agent management across the organization**  
**集中化管理组织内所有智能体**

As agent adoption grows across teams, LangGraph Platform gives organizations a unified way to manage every agent. The agent registry lets users discover available agents in the organization, and common agent architectures can be reused with “assistants” in LangGraph Platform.  
随着各团队对智能体（agent）的采用不断增长，LangGraph Platform 为组织提供了一种统一的方式来管理全部智能体。智能体注册中心（agent registry）使用户能够发现组织内已有的智能体；同时，LangGraph Platform 中的“助手”（assistants）支持复用通用的智能体架构。

## **Why procure LangSmith and LangGraph Platform via AWS Marketplace**  
## **为何通过 AWS Marketplace 采购 LangSmith 和 LangGraph Platform**

With the availability of AI Agents and Tools in AWS Marketplace, customers can significantly accelerate their procurement process to drive AI innovation, reducing the time needed for vendor evaluations and complex negotiations. With centralized purchasing using AWS accounts, customers maintain visibility and control over licensing, payments, and access through AWS.  
随着 AI 智能体与工具（AI Agents and Tools）在 AWS Marketplace 上线，客户可大幅加速采购流程，从而更快推动 AI 创新，显著缩短供应商评估与复杂商务谈判所需时间。借助基于 AWS 账户的集中式采购，客户可通过 AWS 全面掌握并管控许可证、付款及访问权限。

LangSmith and LangGraph Platform are available as self-hosted deployments via Helm charts, enabling you to run both platforms entirely within your AWS VPC on Amazon EKS. No data is shared with third-party services, ensuring strong security, data privacy, and compliance with internal governance standards.  
LangSmith 和 LangGraph Platform 均支持通过 Helm Chart 进行自托管部署，使您可在 Amazon EKS 上完全运行于自有 AWS VPC 内。所有数据均不与任何第三方服务共享，从而保障强大的安全性、数据隐私性，并满足企业内部治理规范要求。

To learn more about LangSmith and LangGraph Platform in AWS Marketplace, visit [this page.](https://aws.amazon.com/marketplace/pp/prodview-vmzygmggk4gms?sr=0-1&ref_=beagle&applicationId=AWSMPContessa&ref=blog.langchain.com) You can also learn more about the new Agents and Tools category in AWS Marketplace [here](http://aws.amazon.com/marketplace/solutions/ai-agents-and-tools/?ref=blog.langchain.com).  
如需进一步了解 AWS Marketplace 中的 LangSmith 和 LangGraph Platform，请访问[此页面](https://aws.amazon.com/marketplace/pp/prodview-vmzygmggk4gms?sr=0-1&ref_=beagle&applicationId=AWSMPContessa&ref=blog.langchain.com)。您也可点击[此处](http://aws.amazon.com/marketplace/solutions/ai-agents-and-tools/?ref=blog.langchain.com)，了解 AWS Marketplace 全新推出的“智能体与工具”（Agents and Tools）类别。

## **About LangChain**  
## **关于 LangChain**

LangChain helps developers build mission-critical AI applications. Its open-source frameworks – LangChain and LangGraph – see over 70 million downloads per month, and its commercial platform – consisting of LangSmith and LangGraph Platform – enables teams to build, test, run, and manage agents at scale across their organizations. Founded in 2023, LangChain powers top engineering teams at companies like Replit, Lovable, Clay, Klarna, LinkedIn, and more.  
LangChain 协助开发者构建关键任务型 AI 应用。其开源框架——LangChain 和 LangGraph——每月下载量超 7000 万次；其商业化平台——由 LangSmith 和 LangGraph Platform 组成——则赋能团队在组织范围内规模化地构建、测试、运行与管理智能体。LangChain 成立于 2023 年，目前已为 Replit、Lovable、Clay、Klarna、LinkedIn 等多家公司的顶尖工程团队提供技术支持。