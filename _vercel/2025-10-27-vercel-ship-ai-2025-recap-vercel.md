---
title: "Vercel Ship AI 2025 recap - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/ship-ai-2025-recap"
date: "2025-10-27"
scraped_at: "2026-03-02T09:26:46.891536195+00:00"
language: "en-zh"
translated: true
description: "Earlier this year we introduced the foundations of the AI Cloud: a platform for building intelligent systems that think, plan, and act. At Ship AI, we showed what comes next. What and how to build wit..."
---

render_with_liquid: false
Oct 27, 2025

2025 年 10 月 27 日

Earlier this year we introduced the foundations of the [AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads): a platform for building intelligent systems that think, plan, and act. [Last week at Ship AI](https://vercel.com/ship/ai), we showed what comes next.

今年早些时候，我们推出了 [AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads) 的基础架构：一个用于构建具备思考、规划与行动能力的智能系统的平台。[上周在 Ship AI 大会期间](https://vercel.com/ship/ai)，我们展示了其后续演进方向。

We launched new SDKs, infrastructure, and open source templates that make building production-ready agents as intuitive as building a standard feature. You can now define, deploy, and operate intelligent workflows on the same platform that powers your apps.

我们发布了全新的 SDK、基础设施及开源模板，让构建可用于生产的智能体（agent）变得如同开发标准功能一样直观。如今，您可在支撑您应用运行的同一平台上，定义、部署并运维智能工作流。

Whether you're building your first agent or delivering it to millions of users, these releases make AI development as accessible and scalable as web development.

无论您正在开发首个智能体，还是面向数百万用户交付智能体，本次发布都让 AI 开发像 Web 开发一样易于上手且高度可扩展。

## AI SDK 6 adds agent-first architecture

## AI SDK 6 引入以智能体为中心的架构

Define an agent once and reuse it across any app or workflow. Instead of wiring together prompts and APIs for each use case, [AI SDK 6](https://ai-sdk.dev/docs/introduction/announcing-ai-sdk-6-beta) introduces an agent abstraction that works everywhere.

只需定义一次智能体，即可在任意应用或工作流中复用。无需为每个使用场景手动拼接提示词（prompt）与 API 调用，[AI SDK 6](https://ai-sdk.dev/docs/introduction/announcing-ai-sdk-6-beta) 引入了一种普适的智能体抽象层。

Now in beta, AI SDK 6 includes:

目前处于 Beta 阶段的 AI SDK 6 包含以下特性：

- **Agent abstraction:** Define once, deploy everywhere  
- **智能体抽象层**：一次定义，随处部署  

- **Tool execution approval:** Built-in human-in-the-loop review  
- **工具执行审批**：内置人工审核（人在环路）机制  

- **Type-safe by design:** End-to-end type safety across models and UI  
- **开箱即用的类型安全**：模型与用户界面之间端到端的类型安全保障

The new tool approval system lets you gate any action that needs human review.  
新的工具审批系统允许您对任何需要人工审核的操作设置审批关卡。

Define a tool with `needsApproval: true` and the agent will pause until someone confirms:  
只需将工具的 `needsApproval` 属性设为 `true`，代理（agent）便会暂停执行，直至有人确认：

```typescript
const weather = tool({

2  description: 'Get the weather in a city',

3  inputSchema: z.object({ city: z.string() }),

4  needsApproval: true, // approval gate

5  execute: async ({ city }) => {

6    const weather = await fetchWeather(city);

7    return weather;

8  },

9});
```

11// 可在循环中调用已批准工具的智能体（Agent）

export const agent = new ToolLoopAgent({

13  model: "openai/gpt-5",

14  instructions: '你是一个简洁高效的天气助手。',

15  tools: { weather },

16});
```

一个针对天气查询支持“人在环中”（human-in-the-loop）审批机制的智能体。

你可以通过运行 `npm i ai@beta` 安装该 Beta 版本，立即开始使用。

[**开始使用 AI SDK 6**  
\\  
探索关于智能体抽象、工具审批模式及迁移指南的完整文档。  
\\  
阅读文档](https://v6.ai-sdk.dev/docs/introduction/announcing-ai-sdk-6-beta)

## Marketplace for Agents and AI tools

## 代理与 AI 工具市场

The [Vercel Marketplace](https://vercel.com/marketplace/category/agents) now lets you discover, install, and connect production-ready agents and AI services directly to your projects.

[Vercl 市场](https://vercel.com/marketplace/category/agents) 现已支持您直接在项目中发现、安装并接入各类生产就绪的智能代理（Agents）和 AI 服务。

Agents like CodeRabbit, Corridor, and Sourcery automate development workflows, while integrations with Autonoma, Braintrust, Browser Use, Chatbase, Descope, Kernel, Kubiks, and Mixedbread bring model access, analytics, and observability into one place.

诸如 CodeRabbit、Corridor 和 Sourcery 等智能代理可自动化开发工作流；而与 Autonoma、Braintrust、Browser Use、Chatbase、Descope、Kernel、Kubiks 及 Mixedbread 的集成，则将模型调用、分析能力与可观测性统一整合至一处。

![Explore AI Agents and services in the Vercel Marketplace.](images/vercel-ship-ai-2025-recap-vercel/img_001.jpg)![Explore AI Agents and services in the Vercel Marketplace.](images/vercel-ship-ai-2025-recap-vercel/img_002.jpg)Explore AI Agents and services in the Vercel Marketplace.

![探索 Vercel 市场中的 AI 代理与服务。](images/vercel-ship-ai-2025-recap-vercel/img_001.jpg)![探索 Vercel 市场中的 AI 代理与服务。](images/vercel-ship-ai-2025-recap-vercel/img_002.jpg)在 Vercel 市场中探索 AI 代理与服务。

Each integration includes unified billing, native observability, and secure credentials management to improve the experience in building on a network of AI-powered tools.

每一项集成均提供统一计费、原生可观测性及安全的凭据管理，从而显著提升基于 AI 工具网络进行开发的体验。

[**AI agents and services on the Vercel Marketplace**\\
\\
Learn how agents and services work together, and see the full launch cohort.\\
\\
Read the announcement](https://vercel.com/blog/ai-agents-and-services-on-the-vercel-marketplace)

[**Vercel 市场中的 AI 代理与服务**\\
\\
了解代理与服务如何协同工作，并查看完整首发阵容。\\
\\
阅读官方公告](https://vercel.com/blog/ai-agents-and-services-on-the-vercel-marketplace)

## Workflow Development Kit brings reliability-as-code

## 工作流开发套件（Workflow Development Kit）实现“可靠性即代码”

Long-running work needs retries, background steps, and stateful checkpoints. Traditionally, that means wiring together message queues, schedulers, and state storage. `use workflow` turns reliability into code.

长时间运行的任务需要重试机制、后台执行步骤以及有状态的检查点（stateful checkpoints）。传统方案往往需手动编排消息队列、调度器与状态存储系统。而 `use workflow` 则将可靠性本身转化为可编写、可版本化、可测试的代码。

Add `use workflow` to any TypeScript function to make it durable:

只需在任意 TypeScript 函数中添加 `use workflow`，即可使其具备持久化能力：

- Automatically retries failed steps  
- 自动重试失败的步骤

- Persists progress between executions  
- 在多次执行之间持续保存进度

- Adds built-in observability for every run  
- 为每次运行提供内置可观测性  

It's open source and runs on any platform, making async work reliable and observable. Works for AI agent loops, data pipelines, commerce workflows, or any process that needs to survive crashes and resume exactly where it stopped.  
它开源且可跨任意平台运行，让异步任务变得可靠且可观测。适用于 AI 智能体循环、数据流水线、电商工作流，或任何需要在崩溃后精准恢复至中断点的流程。

Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.  
Vercel 能自动识别具备持久化能力（durable）的函数，并实时动态配置最适宜的基础设施来支持其运行。

![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/vercel-ship-ai-2025-recap-vercel/img_003.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/vercel-ship-ai-2025-recap-vercel/img_004.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/vercel-ship-ai-2025-recap-vercel/img_005.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/vercel-ship-ai-2025-recap-vercel/img_006.jpg)Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.  
![Vercel 能自动识别具备持久化能力的函数，并实时动态配置最适宜的基础设施来支持其运行。](images/vercel-ship-ai-2025-recap-vercel/img_003.jpg)![Vercel 能自动识别具备持久化能力的函数，并实时动态配置最适宜的基础设施来支持其运行。](images/vercel-ship-ai-2025-recap-vercel/img_004.jpg)![Vercel 能自动识别具备持久化能力的函数，并实时动态配置最适宜的基础设施来支持其运行。](images/vercel-ship-ai-2025-recap-vercel/img_005.jpg)![Vercel 能自动识别具备持久化能力的函数，并实时动态配置最适宜的基础设施来支持其运行。](images/vercel-ship-ai-2025-recap-vercel/img_006.jpg)Vercel 能自动识别具备持久化能力的函数，并实时动态配置最适宜的基础设施来支持其运行。

Read more about built-in durability with [Workflow Development Kit](https://vercel.com/blog/introducing-workflow).  
了解更多关于内置持久化能力的信息，请参阅 [Workflow Development Kit（工作流开发工具包）](https://vercel.com/blog/introducing-workflow)。

[**Build durable workflows**\\  
\\  
Get started with the Workflow Development Kit documentation, examples, and quickstart guides.\\  
\\  
Get started](https://useworkflow.dev/)  
[**构建持久化工作流**\\  
\\  
通过 Workflow Development Kit 的文档、示例和快速入门指南开始上手。\\  
\\  
立即开始](https://useworkflow.dev/)

## Vercel Agent joins your team  

## Vercel Agent 加入您的团队  

Vercel Agent is your intelligent assistant for shipping on Vercel.  
Vercel Agent 是您在 Vercel 上部署应用时的智能助手。

The Agent reviews code, proposes validated patches, and investigates anomalies using real production data. When it detects performance or error spikes, it automatically opens an AI investigation and summarizes the cause and actionable next steps.  
该 Agent 可审查代码、提出经验证的补丁建议，并利用真实生产数据调查异常情况。当检测到性能下降或错误率激增时，它会自动发起 AI 调查，并汇总根本原因及切实可行的后续操作步骤。

Now in beta, Vercel Agent includes:

Vercel Agent 目前处于 Beta 测试阶段，包含以下功能：

- AI code reviews with validated suggestions

- 经过验证建议的 AI 代码审查

- Anomaly alerts that trigger automated investigations

- 异常警报，可自动触发调查流程

- $100 promo credit to get started

- 首次使用可获 $100 促销额度

[**Try Vercel Agent**\\
\\
Join the beta and get $100 credit to start using AI code reviews and automated investigations.\\
\\
Get started](https://vercel.com/agent)

[**试用 Vercel Agent**\\
\\
加入 Beta 测试计划，立即获得 $100 额度，开始体验 AI 代码审查与自动化调查功能。\\
\\
立即开始](https://vercel.com/agent)

## Python support with zero configuration

## 零配置 Python 支持

Python developers can now deploy on the AI Cloud with zero configuration.

Python 开发者现在可在 AI Cloud 上实现零配置部署。

Now in beta, the Vercel Python SDK runs frameworks like FastAPI and Flask natively on Vercel, while interacting with platform primitives such as Sandboxes, Blob storage, and Runtime Cache.

目前处于 Beta 测试阶段的 Vercel Python SDK 可在 Vercel 平台上原生运行 FastAPI、Flask 等框架，并与平台原语（如 Sandboxes、Blob 存储和 Runtime Cache）无缝集成。

You can install the beta with `pip install vercel` to get started.

您可通过执行 `pip install vercel` 命令安装该 Beta 版本，立即开始使用。

[**Zero-config Python backends on Vercel**\\
\\
Learn how to deploy FastAPI, Flask, and other Python frameworks with zero configuration.\\
\\
Learn more](https://vercel.com/changelog/vercel-python-sdk-in-beta)

[**Vercel 上的零配置 Python 后端**\\
\\
了解如何零配置部署 FastAPI、Flask 及其他 Python 框架。\\
\\
了解更多](https://vercel.com/changelog/vercel-python-sdk-in-beta)

## An Agent on every desk

## 每张办公桌都配一位智能代理

We believe every company will run its own agents. Purpose-built assistants that accelerate real work. Our new program, An Agent on Every Desk, helps teams ship their first one.

我们相信，每一家公司都将运行属于自己的智能代理——专为加速真实业务而打造的定制化助手。我们的全新计划“每张办公桌都配一位智能代理”（An Agent on Every Desk），助力团队快速交付首个生产级代理。

We'll guide you from idea to production: identifying high-value workflows, providing starter templates, and getting an agent live fast.

我们将全程陪伴您从构想到上线：识别高价值业务流程、提供开箱即用的模板，并助您快速将代理部署上线。

[**Join the program**\\
\\
Work with our team to build and deploy your first production agent.\\
\\
Express interest](https://vercel.com/go/an-agent-on-every-desk)

[**加入该计划**\\
\\
与我们的团队协作，构建并部署您的首个生产级智能代理。\\
\\
提交意向](https://vercel.com/go/an-agent-on-every-desk)

### Open source lead agent

### 开源线索代理

The new OSS lead agent helps go-to-market teams research and qualify inbound leads automatically.

这款全新的开源线索代理（OSS Lead Agent）可帮助市场与销售协同（Go-to-Market）团队自动开展线索调研与资质评估。

Built with [Next.js](https://nextjs.org/), [AI SDK](https://ai-sdk.dev/), [Workflow DevKit](https://useworkflow.dev/), and the [Vercel Slack Adapter](https://vercel.com/marketplace/slack), it demonstrates how teams can combine open source components to automate daily work.

它基于 [Next.js](https://nextjs.org/)、[AI SDK](https://ai-sdk.dev/)、[Workflow DevKit](https://useworkflow.dev/) 及 [Vercel Slack Adapter](https://vercel.com/marketplace/slack) 构建，展示了团队如何整合开源组件，实现日常工作的自动化。

[**Deploy the lead agent**\\
\\
Clone the template and customize it for your go-to-market workflows.\\
\\
View template](https://vercel.com/oss-lead-agent)

[**部署线索代理**\\
\\
克隆该模板，并根据您的市场与销售协同工作流进行定制。\\
\\
查看模板](https://vercel.com/oss-lead-agent)

## Open source data analyst agent

## 开源数据分析师代理

The OSS Data Analyst Agent brings natural language analytics to your team.

开源数据分析师代理（OSS Data Analyst Agent）为您的团队带来自然语言数据分析能力。

It connects Slack and SQL so anyone can ask questions about their data and get instant, query-driven answers. It's a reference architecture for building your own text-to-SQL agents with the AI SDK.

它将 Slack 与 SQL 连接起来，使任何人都能就其数据提出问题，并即时获得由查询驱动的答案。这是使用 AI SDK 构建您自有文本到 SQL（text-to-SQL）智能体的参考架构。

[**Deploy the data analyst agent**\\
\\
Get the template and connect it to your database and Slack workspace.\\
\\
View template](https://vercel.com/oss-data-analyst)

[**部署数据分析师智能体**\\
\\
获取模板，并将其连接至您的数据库和 Slack 工作区。\\
\\
查看模板](https://vercel.com/oss-data-analyst)

### The future of the AI Cloud

### AI 云的未来

Ship AI brought the tools for moving from calling models to building agents that actually work in production. The SDK handles the abstraction. Workflows make things durable. The marketplace gives you ready-made agents or the services to build your own. Python support means your backend frameworks run here too.

Ship AI 提供了从调用大模型迈向构建真正可在生产环境中运行的智能体所需的工具。SDK 负责处理抽象层；工作流（Workflows）确保系统稳定可靠；市场（Marketplace）则为您提供开箱即用的智能体，或用于自主构建智能体的服务。对 Python 的支持意味着您的后端框架也可在此运行。

The pieces fit together because they solve the same problem: making agent development feel like web development. Define your logic, deploy it, let the platform handle the rest.

这些组件能够无缝协同，是因为它们共同解决同一个问题：让智能体开发体验如同 Web 开发一般自然流畅——定义逻辑、一键部署，其余交由平台自动处理。

You can just ship agents.

您只需专注于交付智能体。