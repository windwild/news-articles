---
title: "Use AI Gateway with Clawdbot - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/use-ai-gateway-with-clawdbot"
date: "2026-01-24"
scraped_at: "2026-03-02T09:22:11.153669724+00:00"
language: "en"
translated: false
description: "You can use Vercel AI Gateway with Clawdbot and access hundreds of models with no additional API keys required."
---




Jan 24, 2026

Clawdbot is a personal AI assistant powered by Claude with persistent memory. It can browse the web, run shell commands, and manage files across any operating system.

You can use Clawdbot with Vercel AI Gateway to access hundreds of models from multiple providers through a single endpoint. AI Gateway provides unified API access across models without managing separate API keys.

Create an API key in the AI Gateway dashboard, then install Clawdbot:

```bash
curl -fsSL https://install.clawdbot.com

2# or

npm install -g clawdbot
```

Run the onboarding wizard:

```bash
clawdbot onboard --install-daemon
```

Select Vercel AI Gateway as your provider and enter your AI Gateway API key.

You can then choose from hundreds of available models. Your AI assistant is now running and ready to help with tasks across your system.

See the [AI Gateway docs](https://vercel.com/docs/ai-gateway/chat-platforms/clawd-bot) for more details on Clawdbot and more integrations.