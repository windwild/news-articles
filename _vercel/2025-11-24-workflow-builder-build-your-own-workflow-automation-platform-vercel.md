---
render_with_liquid: false
title: "Workflow Builder: Build your own workflow automation platform - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/workflow-builder-build-your-own-workflow-automation-platform"
date: "2025-11-24"
scraped_at: "2026-03-02T09:24:51.826179425+00:00"
language: "en-zh"
translated: true
description: "Workflow Builder is a free, open-source template, powered by Next.js and the Workflow DevKit, that helps you build workflow builder applications and agents."
---
render_with_liquid: false
render_with_liquid: false

Nov 24, 2025

2025 年 11 月 24 日

Workflow Builder 是一个用于构建工作流自动化平台的开源 Next.js 模板。

今天我们正式开源 [Workflow Builder](https://workflow-builder.dev/) —— 一个由 [工作流开发工具包](https://useworkflow.dev/)（WDK）驱动的完整可视化自动化平台。

该项目包含可视化编辑器、执行引擎和基础设施，为你提供构建自有工作流自动化工具与智能体所需的一切。你可一键将其部署至 Vercel，并根据自身业务场景进行定制。

[**部署 Workflow Builder**\\
\\
一键部署属于你自己的 Workflow Builder。\\
\\
立即部署](https://vercel.com/templates/ai/workflow-builder)

## Workflow Builder 包含哪些功能？

Workflow Builder 是一个开箱即用、面向生产的 Next.js 应用，具备完全交互式的工作流编辑器、AI 辅助工作流生成能力、六个预置集成模块，以及端到端可观测性。

### 可视化工作流编辑器

可视化工作流编辑器支持通过拖放操作来构建、连接和执行工作流步骤。你无需编写任何代码，即可获得实时校验、撤销/重做、自动保存及状态持久化等功能。

预置集成模块包括：

- Resend (emails)  
- Resend（电子邮件）

- Linear (issues)  
- Linear（问题跟踪）

- Slack (notifications)  
- Slack（通知）

- PostgreSQL (database)  
- PostgreSQL（数据库）

- HTTP requests (API calls)  
- HTTP 请求（API 调用）

- [Vercel AI Gateway](https://vercel.com/ai-gateway) (AI models)  
- [Vercel AI 网关](https://vercel.com/ai-gateway)（AI 模型）

### AI-powered text-to-workflow generation  
### AI 驱动的文本到工作流生成

The AI-powered text-to-workflow feature converts natural language prompts into executable workflows. Type a description of your automation, and the system generates structured step definitions and connections.  
AI 驱动的文本到工作流功能可将自然语言提示转换为可执行的工作流。只需输入您自动化任务的描述，系统便会自动生成结构化的步骤定义及各步骤间的连接关系。

### Webhook triggers  
### Webhook 触发器

Webhook triggers connect your workflows to external apps and APIs. External events, services, or data sources can trigger workflow execution in real time.  
Webhook 触发器可将您的工作流与外部应用和 API 相连。外部事件、服务或数据源均可实时触发工作流的执行。

### Referencing outputs from previous steps

### 引用前序步骤的输出

Each workflow step can access and reference outputs from previous steps. This creates dynamic, data-driven processes and enables agentic workflows where later steps depend on earlier results.

每个工作流步骤均可访问并引用前序步骤的输出。这使得流程具备动态性与数据驱动特性，从而支持“智能体式”（agentic）工作流——即后续步骤的执行依赖于先前步骤的结果。

### Workflow code generation

### 工作流代码生成

Every visual workflow compiles into executable TypeScript via the Workflow Development Kit (WDK). The `"use workflow"` and `"use step"` directives transform your functions into a runtime execution graph that handles state management, error handling, and step coordination.

每个可视化工作流均通过工作流开发工具包（Workflow Development Kit, WDK）编译为可执行的 TypeScript 代码。“`use workflow`” 和 “`use step`” 指令将您的函数转换为一个运行时执行图，该图负责状态管理、错误处理以及步骤协调。

![](images/workflow-builder-build-your-own-workflow-automation-platform-vercel/img_001.jpg)![](images/workflow-builder-build-your-own-workflow-automation-platform-vercel/img_002.jpg)

## Use cases for Workflow Builder

## Workflow Builder 的典型应用场景

With Workflow Builder, you have the foundation to build your own workflow automation platform for internal tools or customer-facing products:

借助 Workflow Builder，您已具备构建专属工作流自动化平台的基础能力，适用于内部工具或面向客户的产品：

- **Agents:** Execute multi-step, cross-system workflows powered by AI

- **智能体（Agents）：** 执行由 AI 驱动的多步骤、跨系统工作流

- **Internal tools**: Custom automation systems tailored to your organization’s processes and systems

- **内部工具：** 面向组织自身业务流程与系统量身定制的自动化系统

- **Customer-facing workflow tools**: Offer domain-specific workflow builders like Zapier or n8n

- **面向客户的流程工具：** 提供领域专用的工作流构建器（如 Zapier 或 n8n）

- **Integration platforms**: Add drag-and-drop workflow capabilities to your product

- **集成平台**：为您的产品添加拖放式工作流功能

- **Data pipelines**: Design ETL or data processing pipelines with visual monitoring and execution tracking

- **数据管道**：使用可视化监控与执行追踪功能，设计 ETL 或数据处理流水线