---
title: "LangGraph Platform in beta: New deployment options for scalable agent infrastructure"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-platform-announce/"
date: "2025-10-13"
scraped_at: "2026-03-03T07:25:49.229298306+00:00"
language: "en-zh"
translated: true
description: "We've rebranded our service for deploying and scaling LangGraph apps as LangGraph Platform. Learn about the multiple deployment options and what LangGraph Platform entails."
tags: ["By LangChain"]
---
{% raw %}

_Note: As of October 2025, LangGraph Platform has been re-named to "LangSmith Deployment"._

_注：截至 2025 年 10 月，LangGraph Platform 已正式更名为 “LangSmith Deployment”。_

A few months ago, we [launched LangGraph Cloud](https://blog.langchain.com/langgraph-cloud/), our infrastructure purpose-built for deploying agents at scale. Today, we are enhancing that original value proposition by expanding our LangGraph deployment options and rebranding our service as LangGraph Platform.

几个月前，我们推出了 [LangGraph Cloud](https://blog.langchain.com/langgraph-cloud/) —— 一款专为大规模部署智能体（agents）而构建的基础设施。今天，我们通过拓展 LangGraph 的部署选项，并将该服务重新命名为 LangGraph Platform，进一步强化了其最初的核心价值主张。

[LangGraph Platform](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com#overview) is our service for deploying and scaling LangGraph applications, with an opinionated way to build agent UXs, plus an integrated developer studio. We now offer [multiple deployment options](https://langchain-ai.github.io/langgraph/concepts/deployment_options/?ref=blog.langchain.com) in beta:

[LangGraph Platform](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com#overview) 是我们提供的用于部署与扩展 LangGraph 应用的服务，它提供了一套经过实践验证的、构建智能体用户界面（agent UX）的方法，并集成了开发者工作室（developer studio）。目前，我们已在测试阶段推出 [多种部署选项](https://langchain-ai.github.io/langgraph/concepts/deployment_options/?ref=blog.langchain.com)：

- **Self-Hosted Lite**: Access a free (up to 1 million nodes executed), limited version of LangGraph Platform that you can run locally or in a self-hosted manner.  
- **Self-Hosted Lite（轻量自托管版）**：可免费使用（最多执行 100 万个节点）的 LangGraph Platform 限定功能版本，支持在本地或您自己的服务器上运行。

- **Cloud SaaS**: Fully managed and hosted as part of LangSmith, our Cloud offering lets teams deploy quickly, with automatic updates and zero maintenance. While it is in beta, anyone with a LangSmith Plus or Enterprise plan can try the Cloud SaaS version for free.  
- **Cloud SaaS（云端 SaaS 版）**：作为 LangSmith 云服务的一部分，由我们全托管并部署；团队可快速上线，享受自动更新与零运维负担。在当前测试阶段，所有拥有 LangSmith Plus 或 Enterprise 订阅计划的用户均可免费试用该 Cloud SaaS 版本。

- **Bring Your Own Cloud (BYOC)**: Run LangGraph Platform in your VPC with our managed service, so you can keep data in your environment while we handle provisioning and maintenance. Currently only for AWS.  
- **Bring Your Own Cloud（BYOC，自带云环境）**：借助我们的托管服务，在您自己的虚拟私有云（VPC）中运行 LangGraph Platform，确保数据始终保留在您的环境中，同时由我们负责资源供应与日常运维。当前仅支持 AWS。

- **Self-Hosted Enterprise**: Deploy LangGraph applications entirely on your own infrastructure.  
- **Self-Hosted Enterprise（企业级自托管版）**：将 LangGraph 应用完全部署于您自有基础设施之上。

Below, we’ll dive into how we’ve arrived at LangGraph Platform and what it provides for developers today.

下文我们将深入探讨 LangGraph Platform 的演进历程，以及它如今为开发者所提供的核心能力。

## How we arrived at LangGraph Platform

## LangGraph Platform 的演进之路

When we first launched LangGraph Cloud back in June, it included a few components:

今年 6 月，LangGraph Cloud 首次发布时，主要包含以下几大组件：

- **LangGraph Studio**: A developer studio for visualizing, interacting with, and debugging agentic apps  
- **LangGraph Studio（LangGraph 开发者工作室）**：一款面向智能体应用的可视化、交互与调试工具。

- **LangGraph Server**: A server providing an opinionated way to deploy and interact with agents (e.g. endpoints for streaming, human-in-the-loop, etc) as well as manage agents (e.g. create assistants, version assistants, etc).  
- **LangGraph Server（LangGraph 服务端）**：一个服务端系统，提供一套经过实践验证的智能体部署与交互方式（例如：流式响应接口、人工介入接口等），同时也支持智能体生命周期管理（例如：创建助手、版本化助手等）。

- Hosting of LangGraph Server on our cloud platform  
- 在我们云平台上的 LangGraph Server 托管服务  

![](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_001.png)

![](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_001.png)

As feedback came in, the first thing that we noticed was that **people really liked** [**LangGraph Studio**](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/). In fact, they liked it so much that they were deploying their graphs on LangGraph Cloud - just so they could debug with LangGraph Studio! From this learning, we released a desktop version of LangGraph Studio so that developers could debug on it locally.

随着用户反馈陆续汇集，我们最先注意到的是：**大家非常喜爱** [**LangGraph Studio**](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/)。事实上，这种喜爱程度之高，以至于许多用户特意将他们的图结构（graphs）部署到 LangGraph Cloud 上——只为能使用 LangGraph Studio 进行调试！基于这一洞察，我们随即发布了 LangGraph Studio 的桌面版，使开发者得以在本地环境直接开展调试工作。

The next thing we realized is that **people were finding a lot of value in LangGraph Server**.

我们接下来意识到的一点是：**用户普遍认为 LangGraph Server 具有很高的实用价值**。

Deploying long-running, stateful agents is difficult due to the complexity of managing state and context. We heard consistently from developers that prior to using LangGraph Server, they had to rewrite much of the core infrastructure that we had built-in to support these agents effectively.

部署长期运行、有状态的智能体（agents）十分困难，原因在于管理状态与上下文的复杂性。我们持续从开发者那里听到：在使用 LangGraph Server 之前，他们不得不重写大量我们已内置的核心基础设施，才能有效支持这类智能体。

Finally, we discovered that some users preferred to host their agents on a cloud service — but others did not. Our service required significant infrastructure, and for most teams it was easier for us to manage running that infrastructure. However, some developers needed to meet **strict data privacy requirements** or to connect to internal APIs — and so running in our cloud was not an option.

最后，我们发现：部分用户倾向于将智能体托管于云服务上，而另一些用户则不然。我们的服务需要大量基础设施支撑；对大多数团队而言，由我们来统一运维这些基础设施反而更便捷。然而，也有部分开发者必须满足**严格的数据隐私合规要求**，或需连接内部 API——因此，将其智能体运行于我们的云环境中并不可行。

With these learnings under our belt, we decided to couple some of our latest offerings under LangGraph Platform. **LangGraph Platform today includes LangGraph Server, LangGraph Studio, plus the CLI and SDK.**

在充分汲取上述经验后，我们决定将部分最新产品整合进 LangGraph Platform。**当前，LangGraph Platform 包含 LangGraph Server、LangGraph Studio，以及命令行工具（CLI）和 Python/JS SDK。**

## What’s in LangGraph Platform?

## LangGraph Platform 包含哪些组件？

We’re now provide several flexible deployment options under LangGraph Platform — with LangGraph Studio and LangGraph Server as essential components of the platform to deliver a complete infrastructure solution for deploying agents at scale.

目前，LangGraph Platform 提供多种灵活的部署选项——其中 LangGraph Studio 和 LangGraph Server 是平台的核心组件，共同构成一套完整的基础设施解决方案，以支持大规模智能体的部署。

LangGraph Platform consists of the following:

LangGraph Platform 包含以下组件：

- LangGraph Server  
- LangGraph Studio  
- LangGraph CLI and the Python/JS SDK  
- LangGraph 命令行工具（CLI）及 Python/JS SDK  

As we’ve worked with companies to deploy their LangGraph apps, we’ve seen nearly all of their teams build the same deployment infrastructure — and to address their needs, we added features in LangGraph Server to deliver on a few key value areas. Below, we’ll focus on these aspects of LangGraph Platform.

在协助各公司部署其 LangGraph 应用的过程中，我们发现几乎所有团队都重复构建了高度相似的部署基础设施。为切实满足用户需求，我们在 LangGraph Server 中新增了多项功能，重点覆盖若干关键价值领域。下文将聚焦于 LangGraph Platform 的这些核心特性。

First, LangGraph Server is designed for handling large workloads gracefully. To do so, it has:

首先，LangGraph Server 专为从容应对大规模工作负载而设计。为此，它具备以下能力：

- **Horizontally scalable infrastructure and task queues** to handle high volume or bursts of incoming requests  
- **水平可扩展的基础设施与任务队列**，可高效处理高并发请求或突发流量  

- **Support for long-running agents** that can handle continuous, stateful tasks (unlike most web infrastructure, which is aimed at running short jobs)  
- **对长期运行智能体的支持**，使其能够持续执行有状态任务（这与多数面向短时任务的 Web 基础设施截然不同）  

- **Ability to persist data** within and across conversation threads  
- **跨会话线程及线程内部的数据持久化能力**

In addition, LangGraph Platform’s APIs allow users to create interactive, context-aware agent experiences. With the following LangGraph Platform features, humans can more easily steer their agent and interact with it to accomplish their goals:

此外，LangGraph Platform 的 API 使用户能够创建交互式、上下文感知的智能体（agent）体验。借助以下 LangGraph Platform 功能，人类用户可以更轻松地引导其智能体，并与之交互以达成目标：

- **Streaming runs** for interactive UX and real-time outputs seen by users  
- **流式执行（Streaming runs）**：支持交互式用户体验，并向用户实时呈现输出结果  

- **Background runs** for batch processing to support research-style or time-intensive tasks  
- **后台执行（Background runs）**：支持批量处理，适用于研究型任务或耗时较长的任务  

- **Interactive state tracking** for humans to interact with the persistence layers and update it, rollback, etc.  
- **交互式状态追踪（Interactive state tracking）**：允许人类用户与持久化层交互，执行状态更新、回滚等操作  

- **Concurrency control,** including ways to deal with multiple incoming user messages before the agent can respond to the first  
- **并发控制（Concurrency control）**：包括在智能体响应第一条用户消息前，妥善处理多条并发用户消息的机制  

- **Cron jobs and webhooks** to support multi-step workflows  
- **定时任务（Cron jobs）与 Webhook**：支持多步骤工作流  

We’re planning on adding even more features (authentication/authorization to call the LangGraph APIs, intelligent caching, etc.) shortly.

我们计划很快推出更多功能（例如调用 LangGraph API 的身份认证与授权机制、智能缓存等）。

We’ve seen that building all of this infrastructure is non-trivial, and we imagine it will become even more complicated as agents get more complex. As a result, we’re investing heavily in not only helping developers in building agents, but deploying them as well.

我们发现，构建上述全部基础设施绝非易事；而随着智能体日趋复杂，其基础设施的建设难度预计将进一步提升。因此，我们正大力投入资源，不仅助力开发者构建智能体，也全力支持其部署落地。

## How to get started

## 如何开始使用

There are several different ways to get started on LangGraph Platform (now in beta).

LangGraph Platform 目前处于 Beta 阶段，您可通过多种方式开始使用：

If you’d like to host the infrastructure yourself, you can [try out LangGraph Platform for free](https://langchain-ai.github.io/langgraph/how-tos/deploy-self-hosted/?ref=blog.langchain.com) (for up to 1 million nodes executed). Once you grow beyond 1 million nodes, you can easily upgrade to the Self-Hosted Enterprise version with no migration needed.

若您希望自行托管基础设施，可[免费试用 LangGraph Platform](https://langchain-ai.github.io/langgraph/how-tos/deploy-self-hosted/?ref=blog.langchain.com)（最多支持执行 100 万个节点）。当您的使用规模超过 100 万个节点后，您可无缝升级至“自托管企业版（Self-Hosted Enterprise）”，无需任何迁移工作。

To host and deploy agentic applications accessible from anywhere, [get started on the Cloud SaaS version](https://langchain-ai.github.io/langgraph/cloud/quick_start/?ref=blog.langchain.com).

如需托管并部署可从任意位置访问的智能体应用，请[立即开始使用云端 SaaS 版本](https://langchain-ai.github.io/langgraph/cloud/quick_start/?ref=blog.langchain.com)。

If your deployment requires greater security or support needs, please [contact us here](https://www.langchain.com/contact-sales?ref=blog.langchain.com) to learn more about our Bring Your Own Cloud (BYOC) or Self-Hosted Enterprise options.

若您对部署的安全性或技术支持有更高要求，请[在此联系我们](https://www.langchain.com/contact-sales?ref=blog.langchain.com)，进一步了解我们的“自带云（Bring Your Own Cloud, BYOC）”或“自托管企业版”方案。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中正式推出端到端 OpenTelemetry 支持](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中正式推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 人工智能现状》报告](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 简化评估流程**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Few-shot prompting to improve tool-calling performance](images/langgraph-platform-in-beta-new-deployment-options-for-scalable-agent-infrastruct/img_007.png)](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**Few-shot prompting to improve tool-calling performance**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**利用少样本提示（few-shot prompting）提升工具调用性能**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 8 分钟阅读
{% endraw %}
