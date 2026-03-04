---
title: "How Outshift by Cisco achieved a 10x productivity boost with their Agentic AI Platform Engineer"
source: "LangChain Blog"
url: "https://blog.langchain.com/cisco-outshift/"
date: "2025-05-04"
scraped_at: "2026-03-03T07:32:34.208043801+00:00"
language: "en-zh"
translated: true
description: "See how Cisco Outshift built an AI Platform Engineer to boost productivity 10x, taking tasks like setting up CI/CD pipelines from a week to under an hour."
tags: ["Case Studies"]
---
{% raw %}

[Outshift](https://outshift.cisco.com/?ref=blog.langchain.com) 是思科（Cisco）旗下的孵化引擎，致力于推动物联网智能体（Internet of Agents）、量子计算及下一代基础设施等新兴技术领域的创新。Outshift 的平台工程团队（Platform Engineering team）提供基础性平台服务，以加速各类孵化项目的落地。

[Outshift](https://outshift.cisco.com/?ref=blog.langchain.com) 是思科（Cisco）旗下的孵化引擎，致力于推动物联网智能体（Internet of Agents）、量子计算及下一代基础设施等新兴技术领域的创新。Outshift 的平台工程团队（Platform Engineering team）提供基础性平台服务，以加速各类孵化项目的落地。

平台工程师负责管理复杂、分布式的云原生 SaaS 环境，这些环境通常涉及多个异构系统。在这些系统中进行监控与问题诊断，往往需要快速跨越运行时环境、遥测系统（telemetry systems）以及文档站点，定位相关信息。

平台工程师负责管理复杂、分布式的云原生 SaaS 环境，这些环境通常涉及多个异构系统。在这些系统中进行监控与问题诊断，往往需要快速跨越运行时环境、遥测系统（telemetry systems）以及文档站点，定位相关信息。

Outshift 的平台工程师团队虽小却精干，在开发新功能以推动平台演进的同时，还需频繁切换上下文、响应开发者提出的各类请求——从权限访问管理到基础设施资源供给。这导致了以下问题：

Outshift 的平台工程师团队虽小却精干，在开发新功能以推动平台演进的同时，还需频繁切换上下文、响应开发者提出的各类请求——从权限访问管理到基础设施资源供给。这导致了以下问题：

- **请求响应周期长**：对于简单且高频的请求，完成时间常需数天；
- **认知负荷加重**：因需在不同工具与工作流之间持续切换上下文；
- **运维效率低下**：高价值的工程任务被边缘化，日常平台维护工作反而占据优先级。

- **请求响应周期长**：对于简单且高频的请求，完成时间常需数天；
- **认知负荷加重**：因需在不同工具与工作流之间持续切换上下文；
- **运维效率低下**：高价值的工程任务被边缘化，日常平台维护工作反而占据优先级。

# JARVIS：AI 平台工程师

# JARVIS：AI 平台工程师

为实现 **10 倍生产力提升**，思科 Outshift 平台工程团队自主研发了 [JARVIS](https://outshift.cisco.com/blog/jarvis-agentic-platform-engineering-outshift?ref=blog.langchain.com) —— 一款面向平台工程场景的 AI 工程师，其架构本质是一个**分布式多智能体系统（Multi-Agent System, MAS）**。

为实现 **10 倍生产力提升**，思科 Outshift 平台工程团队自主研发了 [JARVIS](https://outshift.cisco.com/blog/jarvis-agentic-platform-engineering-outshift?ref=blog.langchain.com) —— 一款面向平台工程场景的 AI 工程师，其架构本质是一个**分布式多智能体系统（Multi-Agent System, MAS）**。

JARVIS 基于 [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) 进行编排，以支持可扩展、确定性的智能体工作流；同时通过开源标准协议 [AGNTCY Agent Connect Protocol（ACP）](https://docs.agntcy.org/pages/syntactic_sdk/connect.html?ref=blog.langchain.com)，实现跨系统、跨智能体的无缝协作。

JARVIS 基于 [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) 进行编排，以支持可扩展、确定性的智能体工作流；同时通过开源标准协议 [AGNTCY Agent Connect Protocol（ACP）](https://docs.agntcy.org/pages/syntactic_sdk/connect.html?ref=blog.langchain.com)，实现跨系统、跨智能体的无缝协作。

### JARVIS 的核心能力

### JARVIS 的核心能力

**知识管理（Knowledge Management）**

**知识管理（Knowledge Management）**

JARVIS 深度集成平台知识库——包括技术文档、合规策略、Jira 工单系统及代码仓库——并采用 **检索增强生成（Retrieval-Augmented Generation, RAG）** 处理非结构化数据，结合 **图增强生成（GraphRAG）** 处理结构化数据，从而从海量平台信息中精准提取可执行的洞察。

JARVIS 深度集成平台知识库——包括技术文档、合规策略、Jira 工单系统及代码仓库——并采用 **检索增强生成（Retrieval-Augmented Generation, RAG）** 处理非结构化数据，结合 **图增强生成（GraphRAG）** 处理结构化数据，从而从海量平台信息中精准提取可执行的洞察。

**Self-Service Capabilities**

**自助服务能力**

JARVIS automates many commonly requested developer tasks such as CI/CD onboarding, cloud resource provisioning, and developer sandbox environment setup — dramatically reducing turnaround times.

JARVIS 自动化执行大量开发者高频请求的任务，例如 CI/CD 接入、云资源供给以及开发者沙箱环境搭建——显著缩短任务交付周期。

**Code Generation**

**代码生成**

JARVIS simplifies Kubernetes deployments by translating natural language inputs into K8s manifests and infrastructure templates through a hybrid machine learning approach.

JARVIS 采用混合机器学习方法，将自然语言输入自动转化为 Kubernetes 清单（K8s manifests）与基础设施模板，从而简化 Kubernetes 部署流程。

**Seamless UX Integration**

**无缝用户体验集成**

JARVIS surfaces agentic AI capabilities directly into familiar developer interfaces — including Jira, Backstage, Webex, and CLI — allowing developers to interact with autonomous workflows without changing their existing tools or habits.

JARVIS 将智能体（agentic）AI 能力直接嵌入开发者熟悉的界面中——包括 Jira、Backstage、Webex 和命令行工具（CLI）——使开发者无需更换现有工具或改变使用习惯，即可与自主工作流交互。

## Agentic Blueprint Behind JARVIS

## JARVIS 背后的智能体架构蓝图

The development of JARVIS was grounded in [AGNTCY’s Four-Phase approach](https://outshift.cisco.com/blog/four-phases-for-development-of-multi-agent-apps?ref=blog.langchain.com) to building resilient multi-agent systems on the Internet of Agents, an open, interoperable platform for agent-to-agent collaboration:

JARVIS 的开发基于 [AGNTCY 的四阶段方法论](https://outshift.cisco.com/blog/four-phases-for-development-of-multi-agent-apps?ref=blog.langchain.com)，该方法论面向“智能体互联网”（Internet of Agents）——一个开放、可互操作的智能体间协作平台——构建具备韧性的多智能体系统：

**1\. Discover**

**1. 发现阶段**

We mapped critical platform workflows with specialized first- and third-party agents, laying the foundation for multi-agentic system.

我们借助专业化的第一方与第三方智能体，对平台关键工作流进行了建模与映射，为构建多智能体系统奠定基础。

**2\. Compose**

**2. 编排**

Using LangGraph and the AGNTCY Agent Connect Protocol, we designed flexible, modular workflows where agents collaborate seamlessly across distributed environments.

我们利用 LangGraph 和 AGNTCY Agent Connect 协议，设计出灵活、模块化的编排流程，使智能体能够在分布式环境中无缝协作。

**3\. Deploy**

**3. 部署**

JARVIS was operationalized across our cloud-native ecosystem, powered by the AGNTCY Workflow Server for scalable execution and coordination.

JARVIS 已在我们的云原生生态系统中全面投入运行，依托 AGNTCY Workflow Server 实现可扩展的执行与协同调度。

**4\. Evaluate**

**4. 评估**

Through continuous tracing, benchmarking, and feedback loops with LangSmith and agentevals, we refined agent behavior to drive consistent improvements over time.

通过 LangSmith 和 agentevals 实现的持续追踪、基准测试及反馈闭环，我们不断优化智能体行为，从而推动其性能随时间推移实现稳定提升。

This approach made JARVIS modular, scalable, and ready to evolve with our growing platform needs.

这一方法使 JARVIS 具备模块化、可扩展性，并能随平台需求的持续增长而不断演进。

![A diagram of a multi-agent system  AI-generated content may be incorrect.](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_001.jpg)

![多智能体系统示意图（AI 生成内容可能存在错误）](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_001.jpg)

# How Developers Use JARVIS: Real Interfaces in Action

# 开发者如何使用 JARVIS：真实接口实战应用

To maximize accessibility and adoption, JARVIS was integrated across multiple developer interfaces:

为最大限度提升易用性与采用率，JARVIS 已集成至多个开发者接口：

- **Jira**: 开发人员可通过 Jira 工单直接将任务分配给 JARVIS AI 平台工程师。JARVIS 将自主执行该请求；如需额外信息，会主动联系相关人员。
- **Backstage**: 一款嵌入我们内部开发者门户的基于聊天的助手，使开发人员能够无缝触发工作流并获取平台服务。
- **Webex**: 一个安全、支持对话的界面，可实时推送通知、任务更新，并支持与 JARVIS 的直接消息交互。
- **CLI**: 开发人员可通过命令行与 JARVIS 交互，轻松完成沙盒应用的创建、基础设施部署以及重复性任务的自动化。

通过在开发人员原本就已使用的工具环境中提供支持，JARVIS 不仅提升了平台采用率，还显著增强了平台的易用性与响应能力。

以下是 JARVIS 实际应用的部分示例：

### _将 Jira 任务分配给 JARVIS AI 工程师_

### _向 JARVIS AI 工程师分配 Jira 任务_

![](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_002.jpg)

#### _内部开发者门户聊天界面：用户使用 JARVIS 申请 LLM 密钥_

#### _内部开发者门户聊天界面：用户通过 JARVIS 申请大语言模型（LLM）密钥_

![](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_003.jpg)

#### _LangGraph Studio 演示：多智能体（multi-agent）工具调用_

#### _LangGraph Studio 演示：多智能体协同调用工具_

![](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_004.jpg)

## JARVIS 在 Outshift 的实际成效

## JARVIS 在 Outshift 所产生的影响

JARVIS 正在为 Outshift 的平台工程（Platform Engineering）带来显著的生产力提升：

- 过去需要一周时间才能完成的任务（例如搭建 CI/CD 流水线），如今**可在一小时内完成**。  
- **资源供给（Provisioning resources）**（例如 S3 存储桶、EC2 实例、大语言模型访问密钥）现已实现**即时化**，将原本耗时半天的任务缩短至仅需**数秒**。  
- 借助 JARVIS 自主引导开发者并自动获取所需信息的能力，开发者与平台工程团队之间围绕常规任务的反复沟通已**彻底消除**。  
- **组织在团队规模不变的前提下，可处理显著增加的请求数量**，同时降低了工程师倦怠感，整体效率也得到提升。

## 构建 JARVIS AI 平台工程师的关键经验

1. [智能体互联网（Internet of Agents, IoA）](https://outshift.cisco.com/the-internet-of-agents?ref=blog.langchain.com) 释放了多智能体系统（Multi-Agent Systems）的真正潜力：平台工程的未来在于多智能体系统——通过无缝集成第一方与第三方分布式智能体，自动化复杂的平台工作流。  
2. 开放标准（如 [AGNTCY 智能体连接协议（Agent Connect Protocol, ACP）](https://docs.agntcy.org/pages/syntactic_sdk/connect.html?ref=blog.langchain.com)）支持异构系统间可靠、稳定的智能体到智能体通信；而 **LangGraph** 等框架则提供了可扩展、确定性的流程编排能力。  
3. 围绕 [四大阶段（Four Phases）](https://outshift.cisco.com/blog/four-phases-for-development-of-multi-agent-apps?ref=blog.langchain.com) —— 发现（Discover）、编排（Compose）、部署（Deploy）与评估（Evaluate）——构建多智能体系统，有助于提升智能体的可发现性、促进智能体间的协作、推动智能体复用，并简化复杂、确定性多智能体系统的开发。  
4. **无缝的用户体验（UX）集成对智能体工作流至关重要。** 将智能体能力直接嵌入现有开发者工具（如 Jira、命令行界面 CLI、开发者门户）是提升采用率的关键。将生成式 AI 驱动的智能体输出与传统界面相结合，可确保用户无需改变日常习惯，即可直观、自然地操作复杂工作流。  
5. **持续评估与基准测试是保障系统可靠性的基石。** 要交付值得信赖的智能体系统，必须持续进行链路追踪（tracing）、运行监控与性能评估。借助 **LangSmith** 等追踪工具和 **agentevals** 等评估框架，团队可深入分析智能体的推理模式、识别不一致行为，并不断优化系统性能，从而在大规模应用中确保高准确率。

* * *

## 智能体 AI 在平台工程中的未来

Outshift 正在引领智能体 AI 与平台工程的深度融合——构建一个由 AI 智能体赋能的人机协同生态系统：在这里，AI 不仅放大人类潜能，更增强协作效率、加速技术创新。他们基于 **JARVIS** 的实践，仅仅是一个开端；他们正不断突破 AI 驱动型平台的能力边界，为“智能体互联网（Internet of Agents）”奠定全新基础。

欲了解更广阔的生态演进图景，请访问 [**agntcy.org**](https://agntcy.org/?ref=blog.langchain.com) —— Outshift 团队正积极参与该协作层的共建，致力于让 AI 智能体之间实现真正无缝的协同工作。

[_探索 Outshift 如何引领平台工程中 AI 的未来发展_](https://outshift.cisco.com/blog/topic/platform-engineering?ref=blog.langchain.com)

[_进一步了解 Outshift 孵化项目（Outshift Incubations）_](https://outshift.cisco.com/?ref=blog.langchain.com)

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_005.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_005.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_006.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何借助 LangChain 和 LangGraph，利用 AI 为数千名客户完成自动化入驻流程](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_006.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何借助 LangChain 和 LangGraph，利用 AI 为数千名客户完成自动化入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_007.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_007.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 与 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_008.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何通过 AI 驱动的商业助手赋能独立创业者](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_008.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何通过 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_009.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功智能体的可观测性](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_009.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_010.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：借助 LangGraph 与 LangSmith 构建数据 + AI 可观测性智能体](images/how-outshift-by-cisco-achieved-a-10x-productivity-boost-with-their-agentic-ai-pl/img_010.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：借助 LangGraph 与 LangSmith 构建数据 + AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟
{% endraw %}
