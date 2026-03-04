---
title: "Moonshot AI's Kimi K2 model is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/moonshot-ai-kimi-k2-model-is-now-supported-in-vercel-ai-gateway"
date: "2025-07-15"
scraped_at: "2026-03-02T09:30:59.018139894+00:00"
language: "en-zh"
translated: true
description: "You can now access Kimi K2 from Moonshot AI using Vercel's AI Gateway, with no Moonshot AI account required."
---
{% raw %}

Jul 15, 2025

2025 年 7 月 15 日

You can now access [Kimi K2](https://github.com/MoonshotAI/Kimi-K2), a new mixture-of-experts (MoE) language model from [Moonshot AI](https://www.moonshot.ai/), using Vercel's [AI Gateway](https://vercel.com/docs/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/docs/ai-gateway)，无需注册其他服务商账号，即可直接调用 [Moonshot AI](https://www.moonshot.ai/) 推出的全新混合专家（Mixture-of-Experts, MoE）语言模型 [Kimi K2](https://github.com/MoonshotAI/Kimi-K2)。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 提供统一、一致的 API 接口，仅需一次字符串配置更新即可调用模型；同时支持用量与费用追踪，并可灵活配置性能优化策略、重试机制及故障转移方案，从而实现高于服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该模型，请先安装对应包：

```bash
pnpm i ai
```

```bash
pnpm i ai
```

Then set the model to `moonshotai/kimi-k2`:

随后将模型标识设为 `moonshotai/kimi-k2`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'moonshotai/kimi-k2',
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'moonshotai/kimi-k2',
```

5  prompt: 'What is the history of the San Francisco Mission-style burrito?'

5  提示词：“旧金山米慎区风格卷饼的历史是怎样的？”

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及具备自动重试机制的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

To deliver high performance and reliability to Kimi K2, AI Gateway leverages multiple model providers under the hood, including direct to Moonshot AI, Groq, DeepInfra, Fireworks AI, and Parasail.

为向 Kimi K2 提供高性能与高可靠性，AI Gateway 在底层集成了多家模型服务商，包括直连 Moonshot AI、Groq、DeepInfra、Fireworks AI 和 Parasail。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway).

进一步了解 [AI Gateway](https://vercel.com/docs/ai-gateway)。
{% endraw %}
