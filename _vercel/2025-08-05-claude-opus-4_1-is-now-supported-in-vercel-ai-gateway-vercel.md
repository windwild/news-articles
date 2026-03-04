---
render_with_liquid: false
title: "Claude Opus 4.1 is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-4-1-opus-is-now-supported-in-vercel-ai-gateway"
date: "2025-08-05"
scraped_at: "2026-03-02T09:30:28.656991391+00:00"
language: "en-zh"
translated: true
description: "You can now access Claude Opus 4.1, a new model released by Anthropic today, using Vercel's AI Gateway with no other provider accounts required."
---
render_with_liquid: false
render_with_liquid: false

Aug 5, 2025

2025 年 8 月 5 日

You can now access [Claude Opus 4.1](https://www.anthropic.com/news/claude-opus-4-1), a new model released today, using Vercel's [AI Gateway](https://vercel.com/docs/ai-gateway) with no other provider accounts required. This release from Anthropic improves agentic task execution, real-world coding, and reasoning over the previous Opus 4 model.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/docs/ai-gateway) 直接调用今日发布的全新模型 [Claude Opus 4.1](https://www.anthropic.com/news/claude-opus-4-1)，无需另行注册其他服务商账号。Anthropic 此次发布的版本在智能体（agentic）任务执行、真实场景编程以及推理能力方面，相较上一代 Opus 4 模型均有显著提升。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 提供统一、一致的 API 接口，仅需修改一个字符串即可切换模型；支持用量与成本追踪，并可灵活配置性能优化策略、重试机制及故障转移方案，从而实现高于服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该模型，请先安装对应包：

```bash
pnpm i ai
```

```bash
pnpm i ai
```

Then set the model to `anthropic/claude-4.1-opus`:

随后将模型设置为 `anthropic/claude-4.1-opus`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "anthropic/claude-4.1-opus",
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "anthropic/claude-4.1-opus",
```

5  prompt: "what's the history of Taqueria La Cumbre in San Francisco?"

5  提示词：“旧金山的塔克里亚·拉·昆布雷餐厅（Taqueria La Cumbre）有着怎样的历史？”

6})
```

6}
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

To deliver high performance and reliability to Claude Opus 4.1, AI Gateway leverages multiple model providers under the hood, including Anthropic and Bedrock.

为向 Claude Opus 4.1 提供高性能与高可靠性，AI 网关（AI Gateway）在底层集成了多个模型供应商，包括 Anthropic 和 Amazon Bedrock。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway) and view the [new AI Gateway model leaderboard](https://vercel.com/ai-gateway).

进一步了解 [AI 网关（AI Gateway）](https://vercel.com/docs/ai-gateway)，并查看全新的 [AI 网关模型排行榜（AI Gateway Model Leaderboard）](https://vercel.com/ai-gateway)。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI 网关：按使用量追踪顶尖 AI 模型**  
\\  
AI 网关模型排行榜依据通过网关的所有流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)