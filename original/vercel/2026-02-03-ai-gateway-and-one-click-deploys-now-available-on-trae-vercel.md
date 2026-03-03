---
title: "AI Gateway and one-click deploys now available on TRAE - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-gateway-and-one-click-deploys-now-available-on-trae"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:38.014357181+00:00"
language: "en"
translated: false
description: "TRAE now integrates with Vercel for one-click deployments and access to hundreds of AI models through a single API key. Available in both SOLO and IDE modes."
---




Feb 3, 2026

ByteDance's coding agent [TRAE](https://www.trae.ai/) now integrates both [AI Gateway](https://vercel.com/ai-gateway) and direct Vercel deployments, bringing unified AI access and instant production shipping to over 1.6 million monthly active developers. Teams can now access hundreds of models through a single API key and deploy applications directly to Vercel from the TRAE interface.

AI Gateway provides unified access to models from Anthropic, OpenAI, Google, xAI, DeepSeek, Z.AI, MiniMax, Moonshot AI, and more without managing multiple provider accounts.

The integration includes automatic failover that routes around provider outages, zero markup on AI tokens, and unified observability to monitor both deployments and AI usage. Meanwhile, the Vercel deployment integration handles authorization automatically and returns live URLs immediately after clicking Deploy.

## SOLO Mode

**Setting up Vercel deployment**

In SOLO mode, click the **+** tab and choose **Integrations** to connect your Vercel account. When your project is ready, click **Deploy** in the chat panel to ship directly to production.

Once linked, all projects can immediately deploy to Vercel and are also visible in your Vercel dashboard.

**Setting up AI Gateway**

In **Integrations**, choose Vercel AI Gateway as your AI Service and add your API key from the Vercel AI Gateway dashboard. Select any model and start coding with automatic failover, low latency, and full observability.

![](images/ai-gateway-and-one-click-deploys-now-available-on-trae-vercel/img_001.jpg)![](images/ai-gateway-and-one-click-deploys-now-available-on-trae-vercel/img_002.jpg)

## IDE Mode

TRAE's IDE mode supports AI Gateway as a model provider with access to the full range of available models alongside direct deployment capabilities.

**Configuration**

```tsx
1// Click the model list dropdown in Builder chat and select Add Model

2// Choose Vercel AI Gateway for Provider

3// Select your model or choose Other Models and enter the creator/model slug

4// Add your API key
```

![](images/ai-gateway-and-one-click-deploys-now-available-on-trae-vercel/img_003.jpg)![](images/ai-gateway-and-one-click-deploys-now-available-on-trae-vercel/img_004.jpg)

You can switch models with a single configuration change while maintaining unified billing through Vercel. This creates a complete development experience where teams write code with any AI model, then ship to production with one click from the same interface.

Get started with [AI Gateway](https://vercel.com/ai-gateway) or explore the [documentation](https://vercel.com/docs/ai-gateway) to learn more.