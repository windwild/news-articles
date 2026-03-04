---
render_with_liquid: false
title: "AI Gateway and one-click deploys now available on TRAE - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-gateway-and-one-click-deploys-now-available-on-trae"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:38.014357181+00:00"
language: "en-zh"
translated: true
description: "TRAE now integrates with Vercel for one-click deployments and access to hundreds of AI models through a single API key. Available in both SOLO and IDE modes."
---
render_with_liquid: false
render_with_liquid: false

Feb 3, 2026

2026年2月3日

ByteDance's coding agent [TRAE](https://www.trae.ai/) now integrates both [AI Gateway](https://vercel.com/ai-gateway) and direct Vercel deployments, bringing unified AI access and instant production shipping to over 1.6 million monthly active developers. Teams can now access hundreds of models through a single API key and deploy applications directly to Vercel from the TRAE interface.

字节跳动的编程智能体 [TRAE](https://www.trae.ai/) 现已同时集成 [AI Gateway](https://vercel.com/ai-gateway) 和直接 Vercel 部署能力，为超 160 万月活跃开发者提供统一的 AI 接入体验与即时生产发布能力。团队现可通过单个 API 密钥访问数百种模型，并直接从 TRAE 界面将应用部署至 Vercel。

AI Gateway provides unified access to models from Anthropic, OpenAI, Google, xAI, DeepSeek, Z.AI, MiniMax, Moonshot AI, and more without managing multiple provider accounts.

AI Gateway 支持统一接入 Anthropic、OpenAI、Google、xAI、DeepSeek、Z.AI、MiniMax、Moonshot AI 等多家厂商的模型，无需分别管理多个服务商账户。

The integration includes automatic failover that routes around provider outages, zero markup on AI tokens, and unified observability to monitor both deployments and AI usage. Meanwhile, the Vercel deployment integration handles authorization automatically and returns live URLs immediately after clicking Deploy.

该集成支持自动故障转移（绕过服务商宕机）、AI Token 零加价，以及统一可观测性，可同时监控应用部署状态与 AI 调用情况。与此同时，Vercel 部署集成自动处理授权流程，点击“Deploy”后立即返回可用的实时 URL。

## SOLO Mode

## SOLO 模式

**Setting up Vercel deployment**

**配置 Vercel 部署**

In SOLO mode, click the **+** tab and choose **Integrations** to connect your Vercel account. When your project is ready, click **Deploy** in the chat panel to ship directly to production.

在 SOLO 模式下，点击 **+** 标签页并选择 **Integrations（集成）**，连接您的 Vercel 账户。当项目准备就绪后，在聊天面板中点击 **Deploy（部署）**，即可直接发布至生产环境。

Once linked, all projects can immediately deploy to Vercel and are also visible in your Vercel dashboard.

完成绑定后，所有项目均可立即部署至 Vercel，并同步显示在您的 Vercel 控制台中。

**Setting up AI Gateway**

**配置 AI Gateway**

In **Integrations**, choose Vercel AI Gateway as your AI Service and add your API key from the Vercel AI Gateway dashboard. Select any model and start coding with automatic failover, low latency, and full observability.

在 **Integrations（集成）** 中，将 Vercel AI Gateway 设为您的 AI 服务，并从 Vercel AI Gateway 控制台添加您的 API 密钥。任选一种模型，即可开始编码——享受自动故障转移、低延迟响应与完整的可观测性支持。

![](images/ai-gateway-and-one-click-deploys-now-available-on-trae-vercel/img_001.jpg)![](images/ai-gateway-and-one-click-deploys-now-available-on-trae-vercel/img_002.jpg)

## IDE Mode

## IDE 模式

TRAE's IDE mode supports AI Gateway as a model provider with access to the full range of available models alongside direct deployment capabilities.

TRAE 的 IDE 模式支持将 AI Gateway 作为模型提供商，可访问全部可用模型，并具备直接部署能力。

**Configuration**

**配置**

```tsx
1// Click the model list dropdown in Builder chat and select Add Model

1// 在 Builder 聊天界面中点击模型列表下拉框，选择“添加模型”

2// Choose Vercel AI Gateway for Provider

2// 在“提供商”选项中选择 Vercel AI Gateway

3// Select your model or choose Other Models and enter the creator/model slug

3// 选择您的模型；或选择“其他模型”，然后输入创建者/模型的 slug（标识符）

4// Add your API key

4// 添加您的 API 密钥
```

![](images/ai-gateway-and-one-click-deploys-now-available-on-trae-vercel/img_003.jpg)![](images/ai-gateway-and-one-click-deploys-now-available-on-trae-vercel/img_004.jpg)

You can switch models with a single configuration change while maintaining unified billing through Vercel. This creates a complete development experience where teams write code with any AI model, then ship to production with one click from the same interface.

您只需修改一处配置即可切换模型，同时通过 Vercel 实现统一计费。这构建了一套完整的开发体验：团队可使用任意 AI 模型编写代码，并通过同一界面一键部署至生产环境。

Get started with [AI Gateway](https://vercel.com/ai-gateway) or explore the [documentation](https://vercel.com/docs/ai-gateway) to learn more.

请开始使用 [AI Gateway](https://vercel.com/ai-gateway)，或查阅 [文档](https://vercel.com/docs/ai-gateway) 以了解更多信息。