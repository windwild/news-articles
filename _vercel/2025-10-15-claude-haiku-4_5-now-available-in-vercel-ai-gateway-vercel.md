---
title: "Claude Haiku 4.5 now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-haiku-4-5-now-available-in-vercel-ai-gateway"
date: "2025-10-15"
scraped_at: "2026-03-02T09:27:08.423277986+00:00"
language: "en-zh"
translated: true
description: "You can now access Claude Haiku 4.5 with Vercel's AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Oct 15, 2025

2025 年 10 月 15 日

You can now access Anthropic's latest model, Claude Haiku 4.5 using Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required. Haiku 4.5 matches Sonnet 4's performance on coding, computer use, and agent tasks at substantially lower cost and faster speeds.

您现在可通过 Vercel 的 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 直接调用 Anthropic 最新模型 Claude Haiku 4.5，无需另行注册其他服务商账号。Haiku 4.5 在编程、计算机操作和智能体（agent）任务等场景下的性能与 Sonnet 4 持平，但成本显著更低、响应速度更快。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI 网关为您提供统一、一致的 API 接口，仅需修改一个字符串即可完成模型切换；同时支持用量与费用追踪，并可配置性能优化策略、重试机制及故障转移方案，从而实现高于服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), set the model to `anthropic/claude-haiku-4.5`:

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该模型，请将 `model` 参数设为 `anthropic/claude-haiku-4.5`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "anthropic/claude-haiku-4.5",

5  prompt: "Write me a haiku about Claude Haiku 4.5."

6})
```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

To deliver high performance and reliability to Claude Haiku 4.5, AI Gateway leverages multiple model providers under the hood, including Anthropic, Bedrock and Vertex AI.

为向 Claude Haiku 4.5 提供高性能与高可靠性，AI Gateway 在底层集成了多个模型供应商，包括 Anthropic、Bedrock 和 Vertex AI。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway) or try it in our [model playground](https://vercel.com/ai-gateway/models/claude-haiku-4.5).

进一步了解 [AI Gateway](https://vercel.com/docs/ai-gateway)，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway)，或在我们的 [模型游乐场（Model Playground）](https://vercel.com/ai-gateway/models/claude-haiku-4.5) 中亲自体验。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶级 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
&#123;% endraw %}
