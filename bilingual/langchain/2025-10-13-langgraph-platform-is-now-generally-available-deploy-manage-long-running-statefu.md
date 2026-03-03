---
title: "LangGraph Platform is now Generally Available: Deploy & manage long-running, stateful Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-platform-ga/"
date: "2025-10-13"
scraped_at: "2026-03-03T07:26:17.417825178+00:00"
language: "en-zh"
translated: true
description: "LangGraph Platform, our infrastructure for deploying and managing agents at scale, is now generally available. Learn how to deploy"
---

_Note: As of October 2025, LangGraph Platform has been re-named to "LangSmith Deployment"._

_注：截至 2025 年 10 月，LangGraph Platform 已正式更名为 “LangSmith Deployment”。_

Today we’re excited to announce the general availability of [**LangGraph Platform**](https://blog.langchain.com/langgraph-platform-ga/) — our purpose-built infrastructure and management layer for deploying and scaling long-running, stateful agents. Since our beta last June, nearly 400 companies have used LangGraph Platform to deploy their agents into production.

今天，我们非常高兴地宣布 [**LangGraph Platform**](https://blog.langchain.com/langgraph-platform-ga/) 正式发布（General Availability）—— 这是我们专为部署与扩展长期运行、有状态智能体（agents）而打造的基础设施与管理平台。自去年 6 月开启公测以来，已有近 400 家公司借助 LangGraph Platform 将其智能体投入生产环境。

Agent deployment is the next hard hurdle for shipping reliable agents, and LangGraph Platform dramatically lowers this barrier with:

智能体部署是构建可靠智能体应用过程中下一个关键难点；而 LangGraph Platform 通过以下能力大幅降低了这一门槛：

- **1-click deployment** to go live in minutes,  
- **一键部署**，数分钟内即可上线；

- **30 API endpoints** for designing custom user experiences that fit any interaction pattern  
- **30 个 API 接口**，支持按任意交互模式定制用户界面与体验；

- **Horizontal scaling** to handle bursty, long-running traffic  
- **横向扩展能力**，从容应对突发性、长时运行的流量压力；

- **A persistence layer** to support memory, conversational history, and async collaboration with human-in-the-loop or multi-agent workflows  
- **持久化层**，支持记忆存储、对话历史记录，以及“人在回路中”（human-in-the-loop）或多智能体协同等异步协作场景；

- **Native LangGraph Studio**, the agent IDE, for easy debugging, visibility, and iteration  
- **原生 LangGraph Studio**——智能体专属集成开发环境（IDE），提供便捷的调试、可观测性与快速迭代能力。

Read on to learn more about what LangGraph Platform offers and which deployment option is right for you. If you're more of a visual learner, you can check out our [video walkthrough here](https://youtu.be/YWVuBLSbNWE?ref=blog.langchain.com).

请继续阅读，深入了解 LangGraph Platform 的核心能力，并判断哪一种部署方案最适合您的需求。若您更倾向于直观学习，欢迎观看我们的 [视频演示](https://youtu.be/YWVuBLSbNWE?ref=blog.langchain.com)。

## **The challenges of agent infrastructure – and how LangGraph Platform can help**

## **智能体基础设施面临的挑战——以及 LangGraph Platform 如何应对**

Our team has the privilege of working with [many of the most exciting companies building agents](https://www.langchain.com/built-with-langgraph?ref=blog.langchain.com) –  such as Klarna, Lovable, Replit, Clay, LinkedIn. Through close collaboration, we’ve come to believe that the challenges of running agents, at scale, in production are often unique relative to traditional apps:

我们的团队有幸与 [众多前沿智能体构建企业](https://www.langchain.com/built-with-langgraph?ref=blog.langchain.com) 深度合作，其中包括 Klarna、Lovable、Replit、Clay 和 LinkedIn 等。通过紧密协作，我们愈发确信：在生产环境中大规模运行智能体所面临的挑战，往往与传统应用存在本质差异：

1. **Many agents are long running.** Like we’ve seen with deep research agents, agents that run in the background on a schedule or in response to [environment triggers](https://blog.langchain.com/introducing-ambient-agents/) can take a long time to return a final output. These workflows can be prone to failures mid-task, so they need durable infrastructure to ensure task completion.  
1. **许多智能体属于长期运行型任务。** 例如深度研究类智能体，或按计划后台运行、或响应[环境事件触发](https://blog.langchain.com/introducing-ambient-agents/)的智能体，其最终输出可能耗时极长。此类工作流极易在任务中途失败，因此亟需高可靠性的基础设施来保障任务顺利完成。

2. **Many agents rely on async collaboration.** Agents need to act on inputs from unpredictable events, whether collaborating with a human to steer / approve an action or waiting on another agent. For example – will the human reply immediately, tomorrow, or not at all? Good infrastructure accounts for this chaos and preserves state throughout.  
2. **许多智能体依赖异步协同机制。** 智能体需响应不可预测的输入事件，例如与人类协同以引导或审批某项操作，或等待另一智能体返回结果。举例而言：人类用户会立即回复？明天才回复？还是根本不会回复？优秀的基础设施必须能妥善应对这种不确定性，并全程保持状态一致性。

3. **Bursty.** While not totally unique to agents, horizontally scaling infra to handle traffic spikes is challenging –  especially for tasks that run daily or on schedules.  
3. **流量突发性强。** 尽管该特性并非智能体独有，但为应对流量高峰而实现基础设施的横向扩展仍极具挑战性——尤其对于每日定时执行或按计划调度的任务而言。

We want engineers to obsess over building the best agent architecture – not worry about infra. LangGraph Platform’s server suits these kinds of workloads at scale. Developers can just 1-click deploy their apps directly in the management console to get started.

我们希望工程师能专注于构建最卓越的智能体架构，而非为底层基础设施操心。LangGraph Platform 的服务端专为这类工作负载而设计，可实现规模化支撑。开发者只需在管理控制台中单击一次，即可完成应用部署，即刻启程。

![](images/langgraph-platform-is-now-generally-available-deploy-manage-long-running-statefu/img_001.jpg)1-click deploy with our native GitHub integration — just select a repo, and ship!

![](images/langgraph-platform-is-now-generally-available-deploy-manage-long-running-statefu/img_001.jpg)通过原生 GitHub 集成一键部署——仅需选择一个代码仓库，即可快速发布！

## **Accelerate agent development with visual workflows**

## **借助可视化工作流加速智能体开发**

Building great agents requires fast feedback loops. [**LangGraph Studio**](https://langchain-ai.github.io/langgraph/concepts/langgraph_studio/?ref=blog.langchain.com) (included as part of LangGraph Platform) helps developers visualize and debug agent workflows in real time, with detailed visibility into agent trajectories and support for branching logic and retries.

构建出色的智能体（agent）依赖于快速的反馈循环。[**LangGraph Studio**](https://langchain-ai.github.io/langgraph/concepts/langgraph_studio/?ref=blog.langchain.com)（作为 LangGraph Platform 的一部分提供）帮助开发者实时可视化并调试智能体工作流，提供对智能体执行轨迹的详细洞察，并原生支持分支逻辑与重试机制。

You can also test edge cases, inspect memory/state at each step, and quickly pinpoint where things go wrong. Instead of retrying things from scratch, built-in checkpointing and memory modules in LangGraph Platform make it easy to rewind, edit, and rerun failure points without frustration.

您还可针对边界场景进行测试，在每一步检查内存/状态，快速定位问题根源。LangGraph Platform 内置的检查点（checkpointing）与内存模块，让您无需从头再来——轻松回退、编辑并重新运行失败节点，彻底告别挫败感。

![](images/langgraph-platform-is-now-generally-available-deploy-manage-long-running-statefu/img_002.jpg)

![](images/langgraph-platform-is-now-generally-available-deploy-manage-long-running-statefu/img_002.jpg)

Whether you’re using our [pre-built agent templates](https://github.com/langchain-ai/open-agent-platform?ref=blog.langchain.com) for common agent workflows, or building from scratch, LangGraph Platform lets you scaffold your agentic apps quickly – going from an idea to production in hours.

无论您采用我们为常见智能体工作流提供的[预构建智能体模板](https://github.com/langchain-ai/open-agent-platform?ref=blog.langchain.com)，还是从零开始自主构建，LangGraph Platform 都能助您快速搭建智能体应用——数小时内即可完成从构想到上线的全过程。

## **Centralize agent management across your org**

## **在组织范围内统一管理智能体**

As agents get adopted across teams, managing them becomes a team sport. LangGraph Platform gives organizations a unified view of every agent in development or production — helping fellow team members iterate and scale across use cases. The enterprise tier also supports RBAC and workspaces, so that you can control access and sharing.

随着智能体在各团队间逐步落地，其管理也日益成为一项协同工作。LangGraph Platform 为组织提供统一视图，全面掌握所有处于开发或生产阶段的智能体，助力团队成员围绕不同应用场景高效迭代与规模化扩展。企业版还支持基于角色的访问控制（RBAC）与工作区（workspaces），便于您精细化管控访问权限与资源共享。

The LangGraph Platform management console makes it easier to enforce consistency, monitor behavior, and ship updates safely — all without needing to re-deploy or touch code every time. You can:

LangGraph Platform 管理控制台让一致性治理、行为监控与安全发布更新变得轻而易举——每次变更均无需重新部署，也无需修改代码。您可：

- Discover available agents in the agent registry  
- 在智能体注册中心发现可用的智能体  

- Create different versions of your agent (“assistants”) in LangGraph platform, allowing you to reuse common agent architectures  
- 在 LangGraph Platform 中创建智能体的不同版本（即“助手”），复用通用的智能体架构  

- Leverage other agents as “Remote Graphs”, allowing you to create multi agent architectures that run in a distributed manner  
- 将其他智能体作为“远程图（Remote Graphs）”调用，构建以分布式方式运行的多智能体架构  

For companies like Qualtrics, centralizing agent management with LangGraph Platform has been critical to driving efficiency:  

对于 Qualtrics 这样的公司而言，借助 LangGraph Platform 实现智能体管理的集中化，已成为提升运营效率的关键举措：

> _“Agentic AI 的未来是多供应商共存的，AI 智能体必须在生态系统中构建。通过使用 LangGraph Platform 构建和管理我们的 AI 智能体——Experience Agents，Qualtrics 能够高效、快速且规模化地设计、部署和管理复杂的生成式 AI 智能体工作流。”_  
> — Phil McKennan，Qualtrics 战略与合作伙伴关系高级副总裁

> _“Agentic AI 的未来是多供应商共存的，AI 智能体必须在生态系统中构建。通过使用 LangGraph Platform 构建和管理我们的 AI 智能体——Experience Agents，Qualtrics 能够高效、快速且规模化地设计、部署和管理复杂的生成式 AI 智能体工作流。”_  
> — Qualtrics 战略与合作伙伴关系高级副总裁 Phil McKennan

## **Try LangGraph Platform today**

## **立即试用 LangGraph Platform**

LangGraph Platform 缩短了生产上线时间，并借助适配工作负载的运行时环境，以及精心设计的 API、内置记忆机制和 Studio 开发环境，显著提升了开发者体验（DevEx），从而赋能更优质的应用体验。目前，LangGraph Platform 已全面开放（Generally Available）。

要开始使用，请根据团队需求选择合适的部署方式：

请根据团队需求选择合适的部署方式：

- **云端（SaaS）：** 入门最快的方式，完全托管，可直接在 LangSmith 内轻松部署。适用于 Plus 套餐和 Enterprise 套餐。  
  立即开始：[阅读文档](https://langchain-ai.github.io/langgraph/cloud/quick_start/?_gl=1*1b9m3eb*_ga*MTA0MzgxMzQ2OS4xNzM3MDUyNDkw*_ga_47WX3HKKY2*czE3NDcxMDY2MzYkbzQ4JGcxJHQxNzQ3MTA3Mzk4JGowJGwwJGgw&ref=blog.langchain.com)（Plus 套餐）或 [联系销售](https://www.langchain.com/contact-sales?ref=blog.langchain.com)（Enterprise 套餐）。  
- **混合部署（Hybrid）：** SaaS 控制平面 + 自托管数据平面——适合拥有敏感数据但仍希望获得更高程度托管服务的团队。仅限 Enterprise 套餐提供。  
  立即开始：[联系销售](https://www.langchain.com/contact-sales?ref=blog.langchain.com)。  
- **完全自托管（Fully Self-Hosted）：** 将整个平台部署于您自己的基础设施中，所有数据均保留在您的 VPC 内，不出域。仅限 Enterprise 套餐提供。  
  立即开始：[联系销售](https://www.langchain.com/contact-sales?ref=blog.langchain.com)。

- **云端（SaaS）：** 入门最快的方式，完全托管，可直接在 LangSmith 内轻松部署。适用于 Plus 套餐和 Enterprise 套餐。  
  立即开始：[阅读文档](https://langchain-ai.github.io/langgraph/cloud/quick_start/?_gl=1*1b9m3eb*_ga*MTA0MzgxMzQ2OS4xNzM3MDUyNDkw*_ga_47WX3HKKY2*czE3NDcxMDY2MzYkbzQ4JGcxJHQxNzQ3MTA3Mzk4JGowJGwwJGgw&ref=blog.langchain.com)（Plus 套餐）或 [联系销售](https://www.langchain.com/contact-sales?ref=blog.langchain.com)（Enterprise 套餐）。  
- **混合部署（Hybrid）：** SaaS 控制平面 + 自托管数据平面——适合拥有敏感数据但仍希望获得更高程度托管服务的团队。仅限 Enterprise 套餐提供。  
  立即开始：[联系销售](https://www.langchain.com/contact-sales?ref=blog.langchain.com)。  
- **完全自托管（Fully Self-Hosted）：** 将整个平台部署于您自己的基础设施中，所有数据均保留在您的 VPC 内，不出域。仅限 Enterprise 套餐提供。  
  立即开始：[联系销售](https://www.langchain.com/contact-sales?ref=blog.langchain.com)。

如果您希望在本地环境中试用基础版 LangGraph 服务器，还可选择 Developer 套餐进行自托管——每月免费执行最多 10 万个节点，非常适合初识 LangGraph Platform，或在自有基础设施上运行个人兴趣项目。如需开通 Developer 套餐，请[阅读文档](https://langchain-ai.github.io/langgraph/cloud/deployment/standalone_container/?ref=blog.langchain.com)。

如果您希望在本地环境中试用基础版 LangGraph 服务器，还可选择 Developer 套餐进行自托管——每月免费执行最多 10 万个节点，非常适合初识 LangGraph Platform，或在自有基础设施上运行个人兴趣项目。如需开通 Developer 套餐，请[阅读文档](https://langchain-ai.github.io/langgraph/cloud/deployment/standalone_container/?ref=blog.langchain.com)。

了解更多部署选项，请访问[此处](https://langchain-ai.github.io/langgraph/concepts/deployment_options/?ref=blog.langchain.com#related)；查看[定价详情](http://www.langchain.com/pricing-langgraph-platform?ref=blog.langchain.com)。

了解更多部署选项，请访问[此处](https://langchain-ai.github.io/langgraph/concepts/deployment_options/?ref=blog.langchain.com#related)；查看[定价详情](http://www.langchain.com/pricing-langgraph-platform?ref=blog.langchain.com)。

* * *

LangGraph Platform 是开发、部署和管理长期运行、有状态智能体最简单的方式。它可独立于 LangChain 其他产品使用——包括 [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com)（集成能力）、[LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com)（智能体编排）和 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)（评估与可观测性），也可与之组合使用，实现从构建阶段到生产环境的平滑过渡。

LangGraph Platform 是开发、部署和管理长期运行、有状态智能体最简单的方式。它可独立于 LangChain 其他产品使用——包括 [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com)（集成能力）、[LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com)（智能体编排）和 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)（评估与可观测性），也可与之组合使用，实现从构建阶段到生产环境的平滑过渡。

如需了解更多信息，请访问 [LangGraph Platform 官方网页](http://www.langchain.com/langgraph-platform?ref=blog.langchain.com)。我们热切期待看到您的智能体能跑得多远！  

如需了解更多信息，请访问 [LangGraph Platform 官方网页](http://www.langchain.com/langgraph-platform?ref=blog.langchain.com)。我们热切期待看到您的智能体能跑得多远！