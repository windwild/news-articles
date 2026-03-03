---
title: "Qwen3-Coder is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/qwen3-coder-is-now-supported-in-vercel-ai-gateway"
date: "2025-07-25"
scraped_at: "2026-03-02T09:30:48.693061052+00:00"
language: "en-zh"
translated: true
description: "You can now access Qwen3 Coder, a model from QwenLM, an Alibaba Cloud company, designed to handle complex, multi-step coding workflows, using Vercel's AI Gateway with no other provider accounts requir..."
---

Jul 25, 2025

2025 年 7 月 25 日

You can now access [Qwen3 Coder](https://github.com/QwenLM/Qwen3-Coder), a model from [QwenLM](https://qwenlm.github.io/), an Alibaba Cloud company, designed to handle complex, multi-step coding workflows, using Vercel's [AI Gateway](https://vercel.com/docs/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/docs/ai-gateway) 直接访问 [Qwen3 Coder](https://github.com/QwenLM/Qwen3-Coder) —— 这是由阿里云旗下 [QwenLM](https://qwenlm.github.io/) 团队研发的模型，专为处理复杂、多步骤的编程工作流而设计，无需额外注册其他服务商账号。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 提供统一、一致的 API 接口调用方式，仅需修改一个字符串即可切换模型；支持用量与费用追踪，并可配置性能优化、自动重试及故障转移策略，从而实现高于服务商平均水平的可用性。

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该模型，请先安装对应包：

```bash
pnpm i ai
```

```bash
pnpm i ai
```

Then set the model to `alibaba/qwen3-coder`:

随后将模型设置为 `alibaba/qwen3-coder`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "alibaba/qwen3-coder",
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "alibaba/qwen3-coder",
```

5  prompt: "What's your best argument for the health benefits of burritos?"

5  提示词：“你关于卷饼健康益处的最佳论点是什么？”

6})
```

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

To deliver high performance and reliability to Qwen3 Coder, AI Gateway leverages multiple model providers under the hood, including Cerebras, DeepInfra, and Parasail.

为向 Qwen3 Coder 提供高性能与高可靠性，AI Gateway 在底层集成了多个模型供应商，包括 Cerebras、DeepInfra 和 Parasail。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息。