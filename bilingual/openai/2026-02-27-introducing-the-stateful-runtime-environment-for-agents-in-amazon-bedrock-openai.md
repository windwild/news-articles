---
title: "Introducing the Stateful Runtime Environment for Agents in Amazon Bedrock | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-the-stateful-runtime-environment-for-agents-in-amazon-bedrock"
date: "2026-02-27"
scraped_at: "2026-03-02T10:08:17.048291201+00:00"
language: "en-US"
translated: true
description: "Stateful Runtime for Agents in Amazon Bedrock brings persistent orchestration, memory, and secure execution to multi-step AI workflows powered by OpenAI."
tags: ["Company"]
---

February 27, 2026

2026 年 2 月 27 日


# Introducing the Stateful Runtime Environment for Agents in Amazon Bedrock

# 在 Amazon Bedrock 中推出面向智能体的有状态运行时环境


AI agents excel at reasoning. The harder part is operational: running multi-step work reliably over time, across real tools and real systems, with the right controls.

AI 智能体在推理方面表现出色。更具挑战性的是工程落地层面：如何在真实工具与真实系统之间，长期、可靠地执行多步骤任务，并施加恰当的管控。

Today, we’re making this easier for customers through a partnership and joint collaboration with Amazon to deliver the new **Stateful Runtime Environment that runs natively in Amazon Bedrock.** AWS customers will have access to the Runtime Environment, powered by OpenAI models, optimized for AWS infrastructure and tailored for agentic workflows, with the state, reliability, and governance needed for production work.

今天，我们携手亚马逊，通过战略合作与联合开发，正式推出全新 **原生集成于 Amazon Bedrock 的有状态运行时环境（Stateful Runtime Environment）**。AWS 客户将可直接使用该运行时环境——它由 OpenAI 模型驱动，针对 AWS 基础设施深度优化，专为智能体（agentic）工作流设计，并具备生产级所需的有状态性、高可靠性与治理能力。


##### Simplify getting agents into production

##### 简化智能体迈向生产的路径


A lot of agent prototypes based on stateless APIs tackle simple use cases: one prompt, one answer, maybe one tool call. Production work is different. Real workflows unfold across many steps, require context from previous actions, depend on multiple tool outputs, approvals, and system state, and need trusted guardrails in secure environments.

当前大量基于无状态 API 构建的智能体原型仅适用于简单场景：一次提示（prompt）、一次响应（answer），最多调用一次工具。而实际生产环境则截然不同：真实工作流往往跨越多个步骤，需依赖先前操作的历史上下文，综合多个工具输出、人工审批及系统状态，并在安全环境中部署可信的防护机制（guardrails）。

Stateless APIs require building the supporting orchestration layer for agents. The burden is on development teams to figure out how state is stored, how tools are invoked, how errors are handled, and how long-running tasks resume safely.

无状态 API 要求开发者自行构建支撑智能体运行的编排层（orchestration layer）。开发团队不得不独自承担以下重任：设计状态存储方案、定义工具调用机制、实现错误处理逻辑，以及保障长时任务的安全恢复。

The Stateful Runtime Environment is jointly designed to reduce that load. It runs **inside your AWS environment** and is optimized to work with AWS services. Now, instead of manually stitching together disconnected requests to make things work, your agents automatically execute complex steps with “working context” that carries forward memory/history, tool and workflow state, environment use, and identity/permission boundaries.

有状态运行时环境由双方联合设计，旨在显著降低上述负担。它**原生运行于您的 AWS 环境之中**，并针对 AWS 各类服务深度优化。从此，您无需再手动拼接彼此割裂的请求来勉强实现功能；您的智能体将自动执行复杂步骤，并持续维护一个“工作上下文（working context）”，其中包含记忆/历史记录、工具与工作流状态、环境资源使用情况，以及身份与权限边界。

##### What this unlocks

##### 这一能力将释放哪些价值

It’s now easier than ever to deliver solutions like multi-system customer support, sales operations workflows, internal IT automation, and finance processes with approvals and audits.

如今，交付多系统客户服务、销售运营工作流、内部 IT 自动化以及带审批与审计环节的财务流程等解决方案，比以往任何时候都更加轻松。

##### Faster time to production for multi-step workflows

##### 多步骤工作流更快上线投产

When the runtime handles persistent orchestration and state across steps, teams can focus on the workflow and the business logic instead of scaffolding.

当运行时在各步骤间自动处理持久化的编排与状态管理时，团队便可专注于工作流设计和业务逻辑本身，而无需耗费精力搭建基础框架。

##### A better fit for long-horizon work

##### 更适用于长期运行的任务

Stateful tasks are designed to run reliably over time, carrying forward the context and control boundaries needed for multi-step execution.

有状态任务专为长期稳定运行而设计，能够持续保留执行多步骤任务所需的上下文信息与控制边界。

##### AWS-native deployment and governance

##### 原生集成 AWS 的部署与治理能力

The runtime is designed to operate within customers’ AWS environment to easily comply with the existing security posture, tooling integrations, and governance rules.

该运行时专为在客户自有 AWS 环境中运行而设计，可无缝契合现有安全基线、工具链集成及治理规范。

**Getting started**

**快速入门**

The Stateful Runtime in Amazon Bedrock will be available soon. If you want to explore how this will benefit your AI journey, reach out to your OpenAI team or request to be contacted.

Amazon Bedrock 中的 Stateful Runtime 即将上线。如希望了解其如何助力您的 AI 发展进程，请联系您的 OpenAI 团队，或提交联络申请。

- [Enterprise](https://openai.com/news/?tags=enterprise)  
- [企业版](https://openai.com/news/?tags=enterprise)

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)