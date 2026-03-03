---
title: "Moonshot AI's Kimi K2 0905 model is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/moonshot-ais-kimi-k2-0905-model-is-now-supported-in-vercel-ai-gateway"
date: "2025-09-04"
scraped_at: "2026-03-02T09:29:40.127027898+00:00"
language: "en-zh"
translated: true
description: "You can now access Kimi K2 0905 from Moonshot AI using Vercel AI Gateway, with no Moonshot AI account required."
---

Sep 4, 2025

2025 年 9 月 4 日

You can now access [Kimi K2 0905](https://github.com/MoonshotAI/Kimi-K2), a new model from [Moonshot AI](https://www.moonshot.ai/) focused on agentic coding with a 256K context window, using Vercel [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel [AI Gateway](https://vercel.com/ai-gateway) 直接调用 [Moonshot AI](https://www.moonshot.ai/) 全新发布的模型 [Kimi K2 0905](https://github.com/MoonshotAI/Kimi-K2)——这是一款专为智能体（agentic）编程场景优化的大模型，支持高达 256K 的上下文窗口，且无需另行注册其他服务商账号。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 提供统一、一致的 API 接口，仅需一个字符串配置即可调用模型；同时支持用量与费用追踪，并可灵活配置性能优化策略、重试机制及故障转移方案，从而实现高于服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK v5](https://ai-sdk.dev/docs/introduction), start by installing the package:

如需在 [AI SDK v5](https://ai-sdk.dev/docs/introduction) 中使用该模型，请先安装对应包：

```bash
pnpm i ai
```

```bash
pnpm i ai
```

Then set the model to `moonshotai/kimi-k2-0905`:

随后将模型标识设为 `moonshotai/kimi-k2-0905`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'moonshotai/kimi-k2-0905',
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'moonshotai/kimi-k2-0905',
```

5  prompt: 'How is a trillion parameter oss model possible?'

5  提示词：“一个拥有万亿参数的开源模型是如何实现的？”

6})
6})

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及具备自动重试机制的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

To deliver high performance to Kimi K2, AI Gateway leverages multiple model providers under the hood, including direct to Moonshot AI, Groq, and Fireworks AI.

为向 Kimi K2 提供高性能服务，AI Gateway 在底层集成了多家模型服务商，包括直连 Moonshot AI、Groq 和 Fireworks AI。

Learn more about [AI Gateway](https://vercel.com/ai-gateway).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息。