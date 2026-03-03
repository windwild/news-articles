---
title: "GPT-5, GPT-5-mini, and GPT-5-nano are now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-gpt-5-mini-and-gpt-5-nano-are-now-available-in-vercel-ai-gateway"
date: "2025-08-07"
scraped_at: "2026-03-02T09:30:11.125294911+00:00"
language: "en-zh"
translated: true
description: "You can now access the gpt-5 models by OpenAI, their most advanced models pushing the frontier of reasoning and domain expertise, using Vercel's AI Gateway with no other provider accounts required."
---

Aug 7, 2025

2025 年 8 月 7 日

You can now access GPT-5, GPT-5-mini, and GPT-5-nano by [OpenAI](https://openai.com/), models designed to push the frontier of reasoning and domain expertise, using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 直接访问由 [OpenAI](https://openai.com/) 推出的 GPT-5、GPT-5-mini 和 GPT-5-nano 模型——这些模型专为突破推理能力与领域专业知识的边界而设计，且无需另行注册其他服务商账号。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI 网关支持您通过统一、一致的 API 调用模型，仅需修改一个字符串即可完成模型切换；同时提供用量与费用追踪功能，并支持配置性能优化、自动重试及故障转移机制，从而实现高于服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该功能，请首先安装对应包：

```bash
pnpm i ai
```

```bash
pnpm i ai
```

Then set the model to either `openai/gpt-5` or `openai/gpt-5-mini` or `openai/gpt-5-nano`:

接着将模型设置为 `openai/gpt-5`、`openai/gpt-5-mini` 或 `openai/gpt-5-nano` 之一：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-5", // or openai/gpt-5-mini or openai/gpt-5-nano
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-5", // 或 openai/gpt-5-mini 或 openai/gpt-5-nano
```

5  prompt: "Generate an ansi animation of sutro tower"

5  提示词：“生成一幅苏特罗塔的 ANSI 动画”

6})
```

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥支持（Bring Your Own Key, BYOK）](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway) and view the [new AI Gateway model leaderboard](https://vercel.com/ai-gateway).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，并查看 [全新的 AI Gateway 模型排行榜](https://vercel.com/ai-gateway)。

Vercel is a launch partner for the release of gpt-5 models, and thank OpenAI for their collaboration in ensuring day 1 readiness for AI Gateway and its customers.

Vercel 是 GPT-5 模型发布的首发合作伙伴；感谢 OpenAI 的通力协作，确保 AI Gateway 及其客户在发布首日即具备完备可用性。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶尖 AI 模型**  
\\  
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)