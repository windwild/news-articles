---
title: "gpt-oss-20b and gpt-oss-120b are now supported in Vercel AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-oss-20b-and-gpt-oss-120b-are-now-supported-in-vercel-ai-gateway"
date: "2025-08-05"
scraped_at: "2026-03-02T09:30:17.283758236+00:00"
language: "en-zh"
translated: true
description: "You can now access gpt-oss by OpenAI, an open-weight reasoning model designed to push the open model frontier, using Vercel's AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Aug 5, 2025

2025 年 8 月 5 日

You can now access gpt-oss-20b and gpt-oss-120b by [OpenAI](https://openai.com/), open-weight reasoning models designed to push the open model frontier, using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接访问由 [OpenAI](https://openai.com/) 发布的开源权重推理模型 gpt-oss-20b 和 gpt-oss-120b——这些模型旨在推动开源大模型的边界，且无需注册其他服务商账号。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 提供统一、一致的 API 接口，仅需修改一个字符串即可调用模型；同时支持用量与费用追踪，并可配置性能优化、自动重试及故障转移机制，从而实现高于服务商平均水平的可用性。

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该功能，请先安装对应包：

```bash
pnpm i ai
```

```bash
pnpm i ai
```

Then set the model to either `openai/gpt-oss-20b` or `openai/gpt-oss-120b`:

随后将模型设置为 `openai/gpt-oss-20b` 或 `openai/gpt-oss-120b`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-oss-120b", // or openai/gpt-oss-20b
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "openai/gpt-oss-120b", // 或 openai/gpt-oss-20b
```

5  prompt: "Generate an ansi animation of sutro tower"

5  提示词：“生成一幅苏特罗塔的 ANSI 动画”

6})
```

6}
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥支持（Bring Your Own Key, BYOK）](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

To deliver high performance and reliability to gpt-oss, AI Gateway leverages multiple model providers under the hood, including Groq, Baseten, Cerebras, and Huggingface.

为向 gpt-oss 提供高性能与高可靠性，AI Gateway 在底层集成了多个模型供应商，包括 Groq、Baseten、Cerebras 和 Hugging Face。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway) and view the [new AI Gateway model leaderboard](https://vercel.com/ai-gateway).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，并查看全新的 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway)。

Vercel is a launch partner for the release of gpt-oss, and thank OpenAI for their collaboration in ensuring day 1 readiness for AI Gateway and its customers.

Vercel 是 gpt-oss 发布的首发合作伙伴；衷心感谢 OpenAI 的通力协作，确保 AI Gateway 及其客户在上线首日即具备完备就绪能力。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶级 AI 模型**  
\\  
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)