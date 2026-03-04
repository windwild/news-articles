---
title: "Use Claude Opus 4.6 on AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-opus-4.6-on-ai-gateway"
date: "2026-02-05"
scraped_at: "2026-03-02T09:21:36.710877962+00:00"
language: "en-zh"
translated: true
description: "You can now access Anthropic's latest model, Claude Opus 4.6, via Vercel's AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Feb 5, 2026

2026 年 2 月 5 日

Anthropic 最新旗舰模型 Claude Opus 4.6 现已上线 AI Gateway。该模型专为驱动处理真实世界任务的智能体（agents）而构建，在整个软件开发生命周期中均表现出色。Opus 4.6 同时也是首款支持扩展至 100 万 token 上下文窗口的 Opus 系列模型。

该模型引入了“自适应推理”（adaptive thinking）这一全新参数，使模型能够自主决定何时以及以多大程度进行推理。该机制在保障编程、分析与创意等各类任务输出质量的同时，显著提升了响应效率，性能达到甚至超越传统“扩展推理”（extended thinking）方式。Opus 4.6 还支持在同一响应中交错执行推理步骤与工具调用（tool calls）。

如需使用该模型，请将 `model` 参数设为 `anthropic/claude-opus-4.6`。以下示例同时启用了自适应推理及 `effort` 参数。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'anthropic/claude-opus-4.6',

5  prompt:

6    `Trace this race condition through the event loop, identify all

7     affected code paths, and implement a fix with proper test coverage.`,

7     受影响的代码路径，并使用适当的测试覆盖来实现修复。`,

8  providerOptions: {

8  providerOptions: {

9    anthropic: {

9    anthropic: {

10      thinking: { type: 'adaptive' },

10      thinking: { type: 'adaptive' },

11      effort: 'max',

11      effort: 'max',

12    },

12    },

13  },

13  },

14});

14});

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于单个服务商的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及支持自动重试的智能[服务商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/claude-sonnet-4.5).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/claude-sonnet-4.5) 中亲自体验。

[**AI Gateway: Track top AI models by usage**  
**AI Gateway：按使用量追踪顶级 AI 模型**

The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.  
AI Gateway 模型排行榜根据通过该网关的所有流量所产生的总 Token 数量，对各时段内使用最频繁的模型进行排序。榜单定期更新。

[View the leaderboard](https://vercel.com/ai-gateway/leaderboards)  
[查看排行榜](https://vercel.com/ai-gateway/leaderboards)