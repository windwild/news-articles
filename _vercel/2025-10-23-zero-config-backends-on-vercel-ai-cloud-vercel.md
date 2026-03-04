---
render_with_liquid: false
title: "Zero-config backends on Vercel AI Cloud - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/zero-config-backends-on-vercel-ai-cloud"
date: "2025-10-23"
scraped_at: "2026-03-02T09:26:43.963255752+00:00"
language: "en-zh"
translated: true
description: "Build, scale, and orchestrate AI backends on Vercel. Deploy Python or Node frameworks with zero config and optimized compute for agents and workflows."
---
render_with_liquid: false
render_with_liquid: false

Oct 23, 2025

2025 年 10 月 23 日

You can just ship backends

你只需部署后端即可。

Vercel 原本广受赞誉的易用性，如今已全面延伸至你的后端服务。

自我们在 Vercel Ship 大会上[推出 AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads)以来，各团队正构建超越简单“提示—响应”模式的 AI 应用。这些应用编排多步骤工作流、动态生成子智能体（sub-agents），并运行耗时数小时乃至数天的长周期任务。它们需要能够处理数据、执行模型推理，并实时响应事件的后端服务。

现在，你可零配置部署当前最主流的 Python 和 TypeScript 后端框架。Vercel 将自动识别你所用的框架，并为你即时配置运行所需的基础设施。

## Why AI applications need powerful backends

## 为何 AI 应用需要强大的后端

后端负责数据处理与流转、模型推理执行，以及实时事件响应。它们涵盖从数据预处理与后处理，到文件上传管理、压缩、缓存及日志记录等全部环节。如今，后端更日益成为驱动智能体（agents）的核心：这些智能体需持续进行规划、推理，并随时间推移自主采取行动。

一年前，大多数 AI 应用仅是向模型发送一条提示词（prompt）并返回一个响应。而今天的后端已演变为复杂的编排层（orchestration layer），可动态创建多个子智能体，或执行跨越数分钟、数小时乃至数天的端到端工作流。这种不断增长的复杂性，使得系统可靠性与迭代速度比以往任何时候都更加关键。

在过去的四个月中，我们陆续推出一系列更新，旨在将 Vercel 打造成支持此类后端服务与后台智能体的一流平台。

### Framework-defined Infrastructure for backends

### 面向后端的框架定义型基础设施（Framework-defined Infrastructure）

# Framework Defined Infrastructure (FDI)

# 框架定义基础设施（FDI）

Framework Defined Infrastructure (FDI) means Vercel reads your backend framework and understands your intent. When you deploy Next.js, the platform automatically knows how to build, route, and optimize your app. That same model now extends to backends.

框架定义基础设施（FDI）意味着 Vercel 能够读取您的后端框架，并理解您的开发意图。当您部署 Next.js 应用时，平台会自动知晓如何构建、路由和优化您的应用；如今，这一模式已延伸至后端服务。

![Vercel automatically maps your framework to the right infrastructure.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_001.jpg)![Vercel automatically maps your framework to the right infrastructure.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_002.jpg)![Vercel automatically maps your framework to the right infrastructure.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_003.jpg)![Vercel automatically maps your framework to the right infrastructure.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_004.jpg)Vercel automatically maps your framework to the right infrastructure.

![Vercel 自动将您的框架映射到合适的基础设施。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_001.jpg)![Vercel 自动将您的框架映射到合适的基础设施。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_002.jpg)![Vercel 自动将您的框架映射到合适的基础设施。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_003.jpg)![Vercel 自动将您的框架映射到合适的基础设施。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_004.jpg) Vercel 自动将您的框架映射到合适的基础设施。

Vercel supports frameworks such as FastAPI and Flask for Python, or Express, Hono, NestJS, and Nitro for TypeScript. Each comes with conventions that describe routing, concurrency, and execution. Vercel uses that context to infer how your code should scale, how requests should be routed, and what compute model to use. Your framework defines the infrastructure.

Vercel 支持多种后端框架，例如 Python 生态中的 FastAPI 和 Flask，以及 TypeScript 生态中的 Express、Hono、NestJS 和 Nitro。这些框架各自遵循一套约定，用于描述路由规则、并发模型与执行方式。Vercel 借助这些上下文信息，推断出您的代码应如何伸缩、请求应如何路由，以及应采用何种计算模型——**您的框架即基础设施的定义者**。

You write your backend code and Vercel figures out how it should run. No configuration files, Docker images, or custom setup required.

您只需编写后端代码，Vercel 便会自动确定其运行方式。无需配置文件、Docker 镜像或任何自定义设置。

This means:

这意味着：

- You can deploy any supported backend framework with zero configuration  
  - 您可零配置部署任意受支持的后端框架

- Your backend automatically scales per endpoint, per function, and per request  
  - 您的后端将按端点（endpoint）、按函数（function）、按请求（request）自动伸缩

- Your observability, including logs, traces, and metrics, lives in the same dashboard as your frontend  
  - 您的可观测性能力（包括日志、链路追踪与指标）与前端共用同一控制台

- The platform continuously optimizes compute allocation to match your workload's behavior  
  - 平台持续优化计算资源分配，以精准匹配您工作负载的实际行为

FDI eliminates the gap between writing backend code and running it in production. Developers focus entirely on application logic while Vercel ensures it runs efficiently and reliably at scale.

FDI 消除了编写后端代码与将其投入生产环境之间的鸿沟。开发者可完全专注于应用逻辑本身，而 Vercel 则确保该逻辑在大规模场景下高效、稳定地运行。

## A better experience for backends

## 更优质的后端开发体验

We've improved the experience of building, testing, and serving backends on Vercel. These updates make backend development just as ergonomic and fast as frontend development.

我们已全面优化在 Vercel 上构建、测试和部署后端的体验。这些更新让后端开发与前端开发一样高效、顺手且迅捷。

### Zero configuration support for popular frameworks

### 对主流框架的零配置支持

Vercel now supports a growing library of Python and Node.js frameworks, including Express, Hono, FastAPI, and Flask. Deploy them without a single line of configuration. The platform automatically detects and optimizes your code at build time.

Vercel 现已原生支持日益丰富的 Python 和 Node.js 框架生态，包括 Express、Hono、FastAPI 与 Flask。无需编写任何配置代码即可一键部署——平台会在构建阶段自动识别并优化您的代码。

In addition to the zero-config, framework-defined experience, we’re introducing a native Vercel Python SDK.

除上述零配置、框架驱动的体验外，我们还正式推出原生 Vercel Python SDK。

Now available in beta via `pip install vercel`, the SDK provides natural API abstractions to access Vercel products and services, including Sandboxes to run untrusted code, a Runtime Cache to store and retrieve data across functions, and Blob storage for frequently read resources.

该 SDK 目前处于 Beta 阶段，可通过 `pip install vercel` 安装。它提供直观自然的 API 抽象层，助您便捷接入 Vercel 各项产品与服务，例如：用于运行不可信代码的 Sandboxes（沙箱）、支持跨函数存储与读取数据的 Runtime Cache（运行时缓存），以及专为高频读取资源设计的 Blob 存储。

[**Build a Python vibe coding IDE**\\  
\\  
Use this template to build an in-browser, AI-native IDE with Next.js, FastAPI, OpenAI Agents SDK, and the Vercel AI Cloud.\\  
\\  
Deploy now](https://vercel.com/templates/ai/python-vibe-coding-ide)

[**打造一款 Python 风格编程 IDE**\\  
\\  
使用此模板，基于 Next.js、FastAPI、OpenAI Agents SDK 及 Vercel AI Cloud，在浏览器中构建一款原生支持 AI 的集成开发环境。\\  
\\  
立即部署](https://vercel.com/templates/ai/python-vibe-coding-ide)

### Active CPU pricing and Fluid compute

### 主动 CPU 计费与弹性计算（Fluid Compute）

For workloads that run intermittently, like agents that pause for input or wait on external APIs, Fluid compute ensures you only pay for time when your code is actively running. Active CPU Pricing measures execution time precisely, not wall time. No cost for idle waiting.

针对间歇性运行的工作负载（例如需等待用户输入的智能体，或需调用外部 API 并暂停执行的场景），弹性计算（Fluid Compute）确保您仅需为代码实际运行的时间付费。“主动 CPU 计费”（Active CPU Pricing）精准计量 CPU 执行时间，而非挂钟时间（wall time）；空闲等待期间不产生任何费用。

![Fluid compute bills by execution time, not wall time.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_005.jpg)![Fluid compute bills by execution time, not wall time.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_006.jpg)![Fluid compute bills by execution time, not wall time.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_007.jpg)![Fluid compute bills by execution time, not wall time.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_008.jpg)Fluid compute bills by execution time, not wall time.

![弹性计算按执行时间计费，而非挂钟时间。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_005.jpg)![弹性计算按执行时间计费，而非挂钟时间。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_006.jpg)![弹性计算按执行时间计费，而非挂钟时间。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_007.jpg)![弹性计算按执行时间计费，而非挂钟时间。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_008.jpg)弹性计算按执行时间计费，而非挂钟时间。

AI workloads on Fluid compute are optimized for on-demand scalability with efficiency gains and a pricing model that reduces costs for long-running LLM calls.

Fluid compute 上的 AI 工作负载针对按需扩展进行了优化，兼具性能提升与成本优势——其定价模式可显著降低长时间运行的大语言模型（LLM）调用费用。

[**See how Fluid compute works on Vercel**  
**了解 Fluid compute 在 Vercel 上的工作原理**  
\\  
Fluid compute boosts serverless performance by reusing idle compute during LLM calls, keeping functions active and scaling dynamically.  
Fluid compute 通过在 LLM 调用期间复用空闲计算资源，显著提升无服务器性能：保持函数持续活跃，并实现动态扩缩容。  
\\  
Learn more  
了解更多](https://vercel.com/blog/how-fluid-compute-works-on-vercel)

### Durable orchestration for long-running backends

### 面向长期运行后端的持久化编排

For backends that need persistence or reliability over time, the Workflow Development Kit (WDK) brings durability and observability into your code. It works for orchestrating multi-step processes like AI agent loops, data pipelines, or scheduled automations.

对于需要长期持久性或高可靠性的后端服务，工作流开发工具包（Workflow Development Kit, WDK）将持久化能力与可观测性直接融入您的代码中。它适用于编排多步骤流程，例如 AI 智能体循环、数据流水线或定时自动化任务。

![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_009.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_010.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_011.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_012.jpg)Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.

![Vercel 自动识别函数是否具备持久化特性，并实时动态配置最适配的基础架构以支持该函数。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_009.jpg)![Vercel 自动识别函数是否具备持久化特性，并实时动态配置最适配的基础架构以支持该函数。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_010.jpg)![Vercel 自动识别函数是否具备持久化特性，并实时动态配置最适配的基础架构以支持该函数。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_011.jpg)![Vercel 自动识别函数是否具备持久化特性，并实时动态配置最适配的基础架构以支持该函数。](images/zero-config-backends-on-vercel-ai-cloud-vercel/img_012.jpg)Vercel 自动识别函数是否具备持久化特性，并实时动态配置最适配的基础架构以支持该函数。

### Get started with new backend AI templates

### 借助全新后端 AI 模板快速上手

We're releasing a library of backend templates that demonstrate production-ready AI patterns, including:

我们正发布一套后端模板库，展示面向生产环境的 AI 实践模式，包括：

- [**Chatbot systems**](https://vercel.com/templates/ai/ai-sdk-python-streaming) with multi-turn memory and streaming responses  
- [**聊天机器人系统**](https://vercel.com/templates/ai/ai-sdk-python-streaming)，支持多轮对话记忆与响应流式输出  

- [**Coding assistants**](https://vercel.com/templates/ai/python-vibe-coding-ide) that reason across repositories and suggest changes  
- [**编程助手**](https://vercel.com/templates/ai/python-vibe-coding-ide)，可在多个代码仓库间进行推理分析，并智能建议修改方案  

- [**RAG pipelines**](https://vercel.com/templates/ai/ai-sdk-rag) that handle ingestion, embedding, and retrieval at scale  
- [**RAG 流水线**](https://vercel.com/templates/ai/ai-sdk-rag)，可大规模处理数据接入、向量嵌入与语义检索

Each template demonstrates the full power of the AI Cloud, from orchestration to inference.

每个模板均展示了 AI Cloud 的全部能力，涵盖编排（orchestration）到推理（inference）的完整流程。

## One platform for the entire stack

## 全栈统一平台

Every backend deployed on Vercel runs on the same orchestration, compute, and storage layers that power the AI Cloud. Together, these systems provide the foundation for fast, reliable, and cost-efficient backend development.

所有部署在 Vercel 上的后端，均运行于支撑 AI Cloud 的同一套编排、计算与存储层之上。这些系统协同工作，为快速、可靠且高性价比的后端开发提供了坚实基础。

From real-time APIs to long-running background agents, you can build, test, and deploy every part of your application on Vercel.

无论是实时 API 还是长期运行的后台智能体（background agents），您均可在 Vercel 上完成应用各部分的构建、测试与部署。