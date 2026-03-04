---
render_with_liquid: false
title: "Claude Sonnet 4.6 is live on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-sonnet-4-6-is-live-on-ai-gateway"
date: "2026-02-17"
scraped_at: "2026-03-02T09:21:31.654868961+00:00"
language: "en-zh"
translated: true
description: "You can now access Anthropic's newest model Claude Sonnet 4.6 via Vercel's AI Gateway with no other provider accounts required."
---
render_with_liquid: false
render_with_liquid: false

Feb 17, 2026

2026年2月17日

Claude Sonnet 4.6 from Anthropic is now available on AI Gateway with the 1M token context window.

Anthropic 公司推出的 Claude Sonnet 4.6 现已上线 AI Gateway，支持高达 100 万 token 的上下文窗口。

Sonnet 4.6 approaches Opus-level intelligence with strong improvements in agentic coding, code review, frontend UI quality, and computer use accuracy. The model proactively executes tasks, delegates to subagents, and parallelizes tool calls, with MCP support for scaled tool use. As a hybrid reasoning model, Sonnet 4.6 delivers both near-instant responses and extended thinking within the same model.

Sonnet 4.6 在智能水平上已接近 Opus 级别，在智能体编程（agentic coding）、代码审查、前端 UI 质量以及计算机操作准确性等方面均有显著提升。该模型可主动执行任务、将子任务委派给子智能体（subagents），并并行调用工具，同时通过 MCP（Model Control Protocol）支持规模化工具调用。作为一款混合推理模型，Sonnet 4.6 能在同一模型内兼顾即时响应与深度思考。

To use this model, set model to `anthropic/claude-sonnet-4.6` in the AI SDK. This model supports `effort` and thinking type `adaptive`:

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `anthropic/claude-sonnet-4.6`。此模型支持 `effort` 参数及自适应（`adaptive`）推理模式：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'anthropic/claude-sonnet-4.6',

5  prompt:

6    `Build a dashboard component from this spec with
```

7     responsive layout, dark mode support, and accessibility.`,

7     响应式布局、暗色模式支持以及无障碍访问功能。`,

8  providerOptions: {

8  providerOptions: {

9    anthropic: {

9    anthropic: {

10      effort: 'medium',

10      effort: 'medium',

11      thinking: { type: 'adaptive' },

11      thinking: { type: 'adaptive' },

12    },

12    },

13  },

13  },

14});

14});

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪使用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于单个服务商自身可用性的服务稳定性。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)能力、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试功能的智能服务商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/claude-sonnet-4.6).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型体验平台](https://vercel.com/ai-gateway/models/claude-sonnet-4.6) 中亲自试用。