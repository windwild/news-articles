---
title: "Use AI Gateway with Clawdbot - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/use-ai-gateway-with-clawdbot"
date: "2026-01-24"
scraped_at: "2026-03-02T09:22:11.153669724+00:00"
language: "en-zh"
translated: true
description: "You can use Vercel AI Gateway with Clawdbot and access hundreds of models with no additional API keys required."
---

Jan 24, 2026

2026 年 1 月 24 日

Clawdbot is a personal AI assistant powered by Claude with persistent memory. It can browse the web, run shell commands, and manage files across any operating system.

Clawdbot 是一款由 Claude 驱动的个人 AI 助手，具备持久化记忆能力。它可在任意操作系统上浏览网页、执行 Shell 命令以及管理文件。

You can use Clawdbot with Vercel AI Gateway to access hundreds of models from multiple providers through a single endpoint. AI Gateway provides unified API access across models without managing separate API keys.

您可通过 Vercel AI Gateway 与 Clawdbot 配合使用，仅需一个统一端点，即可访问来自多家供应商的数百种大模型。AI Gateway 提供跨模型的统一 API 接入能力，无需分别管理多个 API 密钥。

Create an API key in the AI Gateway dashboard, then install Clawdbot:

在 AI Gateway 控制台中创建一个 API 密钥，然后安装 Clawdbot：

```bash
curl -fsSL https://install.clawdbot.com

2# or

npm install -g clawdbot
```

```bash
curl -fsSL https://install.clawdbot.com

2# 或者

npm install -g clawdbot
```

Run the onboarding wizard:

运行入门向导：

```bash
clawdbot onboard --install-daemon
```

```bash
clawdbot onboard --install-daemon
```

Select Vercel AI Gateway as your provider and enter your AI Gateway API key.

在向导中选择 Vercel AI Gateway 作为您的模型提供商，并输入您的 AI Gateway API 密钥。

You can then choose from hundreds of available models. Your AI assistant is now running and ready to help with tasks across your system.

然后，您可以从数百种可用模型中进行选择。您的 AI 助手现已启动并准备就绪，可协助您完成系统中的各项任务。

See the [AI Gateway docs](https://vercel.com/docs/ai-gateway/chat-platforms/clawd-bot) for more details on Clawdbot and more integrations.

请参阅 [AI Gateway 文档](https://vercel.com/docs/ai-gateway/chat-platforms/clawd-bot)，了解有关 Clawdbot 及更多集成的详细信息。