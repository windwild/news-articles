---
title: "AI agents and services on the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ai-agents-and-services-on-the-vercel-marketplace"
date: "2025-10-23"
scraped_at: "2026-03-02T09:26:39.266324490+00:00"
language: "en-zh"
translated: true
description: "Agents and Tools are available in the Vercel Marketplace, enabling AI-powered workflows in your projects with native integrations, unified billing, and built-in observability."
---
&#123;% raw %}

Oct 23, 2025

2025 年 10 月 23 日

Agents and agentic AI give developers new ways to move faster and build better. They create connected, autonomous systems that continuously improve applications and raise the bar for speed and quality.

智能体（Agents）与具身智能（agentic AI）为开发者提供了加速开发、提升质量的全新途径。它们构建起相互连接、自主运行的系统，持续优化应用程序，并不断刷新开发速度与产品质量的新标准。

But typically, integrating AI services means managing separate dashboards, billing systems, and authentication flows for each tool. A team using three different AI services might waste hours wiring up each integration before writing a single line of application code.

但通常，集成各类 AI 服务意味着需分别管理彼此独立的控制台、计费系统和身份认证流程。一个团队若使用三种不同的 AI 服务，可能在编写第一行应用代码之前，就已耗费数小时用于手动配置各项集成。

Today, we're introducing the AI agents and services category to the Vercel marketplace. You can now add AI-powered workflows to your projects through native Vercel integrations with unified billing, observability, and installation flows built into the platform.

今天，我们正式在 Vercel Marketplace 中推出“AI 智能体与服务”（AI Agents and Services）类别。您现在可通过原生 Vercel 集成，将 AI 驱动的工作流快速添加至项目中——所有集成均内置统一计费、可观测性及安装流程，开箱即用。

![Explore AI Agents and services in the Vercel Marketplace.](images/ai-agents-and-services-on-the-vercel-marketplace-vercel/img_001.jpg)![Explore AI Agents and services in the Vercel Marketplace.](images/ai-agents-and-services-on-the-vercel-marketplace-vercel/img_002.jpg)Explore AI Agents and services in the Vercel Marketplace.

![探索 Vercel Marketplace 中的 AI 智能体与服务。](images/ai-agents-and-services-on-the-vercel-marketplace-vercel/img_001.jpg)![探索 Vercel Marketplace 中的 AI 智能体与服务。](images/ai-agents-and-services-on-the-vercel-marketplace-vercel/img_002.jpg)在 Vercel Marketplace 中探索 AI 智能体与服务。

## What agents and services do

## 智能体与服务的功能

The Marketplace offers two types of AI building blocks:

Vercel Marketplace 提供两类 AI 构建模块：

- **Agents** handle specialized work on your behalf  
- **Services** provide the infrastructure to build and run your own agents  

- **智能体（Agents）**：代表您执行特定领域的专业化任务  
- **服务（Services）**：为您提供构建和运行自有智能体所需的底层基础设施  

Together, they let you start with purpose-built agents to accelerate workflows, then build custom agents when you need them.

二者协同配合：您可先选用专为特定场景设计的智能体，快速加速工作流；待需求进阶时，再灵活构建专属定制智能体。

## AI agents run specialized workflows

## AI 智能体运行专业化工作流

Agents are pre-built systems that reason, act, and adapt inside your existing workflows. Instead of building code review automation from scratch or managing another dashboard, you can install an agent that operates where your applications already run.

智能体是预构建的系统，可在您现有的工作流中进行推理、执行操作并动态适应。您无需从零开始构建代码审查自动化流程，也无需额外维护一个管理看板——只需安装一个智能体，即可在您的应用已部署的环境中直接运行。

Our agent launch cohort includes:

我们的首批上线智能体包括：

- **CodeRabbit** collaborates on code changes with automated reviews. CodeRabbit is the AI code review platform built for modern engineering teams. It analyzes pull requests and provides feedback on code quality, security, and best practices.

- **CodeRabbit** 通过自动化审查与开发人员协同处理代码变更。CodeRabbit 是专为现代工程团队打造的 AI 代码审查平台，可分析 Pull Request，并就代码质量、安全性及最佳实践提供即时反馈。

- **Corridor** is the security layer for AI coding. Corridor provides instant code security reviews and enforces guardrails to secure your AI-generated code in realtime.

- **Corridor** 是面向 AI 编程的安全防护层。Corridor 提供实时代码安全审查，并强制执行各类防护机制（guardrails），以保障您生成的 AI 代码在运行时的安全性。

- **Sourcery** reviews and generates code to move from idea to production faster. Sourcery provides instant code reviews for every change made to your project to cut down on bugs and security risks.

- **Sourcery** 可审查并生成代码，加速从创意构想到生产落地的全过程。Sourcery 为项目中的每一次代码变更提供即时审查，从而显著减少缺陷与安全风险。

Each agent integrates with GitHub through a single onboarding flow. Once installed, the agent begins monitoring your repositories and acting on changes according to its specialization.

每个智能体均通过统一的接入流程与 GitHub 集成。安装完成后，智能体即开始监控您的代码仓库，并依据其专业定位对代码变更自动响应。

## Services provide infrastructure for custom agents

## 服务提供自定义智能体所需的基础设施

Services give you the foundation to create, customize, monitor, and scale your own agents. These are the primitives that turn ideas into reliable production workflows.

服务为您提供构建、定制、监控和规模化部署自有智能体的基础能力。这些基础组件（primitives）可将创意高效转化为稳定可靠的生产级工作流。

Our AI Services launch cohort includes:  

我们首批上线的 AI 服务包括：

- **Autonoma** automates regression testing with an AI-powered platform that catches bugs before production. Autonoma requires zero lines of code to set up complete test coverage.  
- **Autonoma** 是一个由 AI 驱动的自动化回归测试平台，可在生产环境上线前捕捉缺陷。Autonoma 无需编写任何代码，即可实现完整的测试覆盖。

- **Braintrust** trains, tests, and manages custom agents with evaluation frameworks. Braintrust is the agent observability platform that helps teams build quality AI products through systematic testing and monitoring.  
- **Braintrust** 借助评估框架对自定义智能体进行训练、测试与管理。Braintrust 是一款智能体可观测性平台，通过系统化的测试与监控，助力团队构建高质量 AI 产品。

- **Browser Use** lets AI agents control real browsers to automate web tasks with natural-language commands. BrowserUse turns browser interactions into programmable actions.  
- **Browser Use** 使 AI 智能体能够操控真实浏览器，通过自然语言指令自动化网页任务。BrowserUse 将浏览器交互转化为可编程操作。

- **Chatbase** builds, analyzes, and optimizes customer-facing agents. Chatbase provides analytics and tuning tools for conversational AI.  
- **Chatbase** 用于构建、分析和优化面向客户的智能体。Chatbase 提供面向对话式 AI 的分析与调优工具。

- **Descope** is a no-code/low-code external identity platform that enables organizations to build, manage and secure authentication and identity journeys for customers, partners, AI agents and more, using visual workflows, SDKs and APIs.  
- **Descope** 是一个无代码/低代码的外部身份认证平台，支持企业借助可视化工作流、SDK 和 API，为用户、合作伙伴、AI 智能体等构建、管理和保障身份认证与身份旅程的安全。

- **Kernel** hosts and scales browser automation infrastructure in the cloud. Kernel is a developer platform providing browsers-as-a-service for AI agents to use the internet.  
- **Kernel** 在云端托管并扩展浏览器自动化基础设施。Kernel 是一个面向开发者的平台，为 AI 智能体提供“浏览器即服务”（Browsers-as-a-Service），使其能够接入互联网。

- **Kubiks** orchestrates multi-step AI workflows and fixes issues before users see them. Kubiks goes beyond observability to provide automated remediation.  
- **Kubiks** 编排多步骤 AI 工作流，并在用户察觉之前修复问题。Kubiks 不止于可观测性，更提供自动化修复能力。

- **Mixedbread** is an AI search engine platform offering an API that converts all kinds of data (documents, images, code, audio/video) into searchable knowledge stores, enabling AI systems to use rich context and retrieve accurate information across multiple formats and languages.  
- **Mixedbread** 是一个 AI 搜索引擎平台，提供一套 API，可将各类数据（文档、图像、代码、音视频）转换为可搜索的知识库，使 AI 系统能够利用丰富上下文，在多种格式与语言间精准检索信息。

These services plug into your Vercel workflows so you can build agents specific to your company, products, and customers. They integrate with your CI/CD, observability, or automation workflows on Vercel.  
这些服务可无缝接入您的 Vercel 工作流，助您构建专属于贵公司、产品及客户的智能体。它们可与您在 Vercel 上的 CI/CD、可观测性或自动化工作流集成。

## The agent ecosystem, built on Vercel  
## 基于 Vercel 构建的智能体生态系统

Installing an agent or service takes just a few clicks. Some run directly on AI Cloud, others connect through Marketplace integration. All share unified billing through your Vercel account and appear in your project's observability dashboard.

安装一个智能体（Agent）或服务只需几次点击。部分智能体或服务直接运行在 AI Cloud 上，其余则通过 Marketplace 集成方式接入。所有服务均通过您的 Vercel 账户统一计费，并显示在您项目的可观测性（Observability）仪表板中。

Each listing meets Vercel's integration standards for quality and developer experience. This means consistent authentication flows, standard logging formats, and predictable configuration patterns.

每个上架项目均符合 Vercel 制定的集成质量标准与开发者体验标准。这意味着认证流程一致、日志格式标准化，且配置模式可预期。

## Get started

## 快速入门

**For developers**: Explore the [Vercel Marketplace](https://vercel.com/marketplace) to discover [Agents and Services](https://vercel.com/docs/agent-integrations) from our partners. Add them to your projects today.

**面向开发者**：访问 [Vercel Marketplace](https://vercel.com/marketplace)，探索我们合作伙伴提供的 [Agents 和 Services](https://vercel.com/docs/agent-integrations)。立即将其添加到您的项目中。

**For companies building agents**: If you're building agents or AI infrastructure, [join the Marketplace](https://vercel.com/marketplace-providers#become-a-provider) and reach thousands of teams building on Vercel.

**面向构建智能体的企业**：如果您正在开发智能体或 AI 基础设施，欢迎 [加入 Marketplace](https://vercel.com/marketplace-providers#become-a-provider)，触达数千个正在 Vercel 上构建应用的团队。
&#123;% endraw %}
