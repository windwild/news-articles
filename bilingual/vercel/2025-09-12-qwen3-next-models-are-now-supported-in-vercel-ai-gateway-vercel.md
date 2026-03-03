---
title: "Qwen3-Next models are now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/qwen3-next-models-are-now-supported-in-vercel-ai-gateway"
date: "2025-09-12"
scraped_at: "2026-03-02T09:28:39.340940888+00:00"
language: "en-zh"
translated: true
description: "You can now access Qwen3 Next, two models from QwenLM, designed to be ultra-efficient, using Vercel's AI Gateway with no other provider accounts required."
---

Sep 12, 2025

2025 年 9 月 12 日

You can now access [Qwen3 Next](https://github.com/QwenLM/Qwen3), two ultra-efficient models from [QwenLM](https://qwenlm.github.io/), designed to activate only 3B parameters, using Vercel's [AI Gateway](https://vercel.com/docs/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/docs/ai-gateway) 直接访问 [Qwen3 Next](https://github.com/QwenLM/Qwen3) —— 由 [QwenLM](https://qwenlm.github.io/) 推出的两款超高效模型，专为仅激活 30 亿（3B）参数而设计，无需额外注册其他服务商账号。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 提供统一、一致的 API 接口调用模型，仅需修改一个字符串即可切换模型；支持用量与费用追踪，并可配置性能优化、自动重试及故障转移策略，从而实现高于服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该模型，请先安装对应包：

```bash
pnpm i ai
```

```bash
pnpm i ai
```

Then set the model to `alibaba/qwen3-next-80b-a3b-thinking`:

然后将模型设置为 `alibaba/qwen3-next-80b-a3b-thinking`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "alibaba/qwen3-next-80b-a3b-thinking",
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "alibaba/qwen3-next-80b-a3b-thinking",
```

5  prompt: "What's your best argument for the health benefits of burritos?"

5  提示词：“你认为卷饼对健康最有力的益处是什么？”

6})
6})

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥支持（Bring Your Own Key, BYOK）](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/ai-gateway) and access the model [here](https://vercel.com/ai-gateway/models/qwen3-next-80b-a3b-thinking).

了解更多关于 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 的信息，并在此处访问该模型：[链接](https://vercel.com/ai-gateway/models/qwen3-next-80b-a3b-thinking)。