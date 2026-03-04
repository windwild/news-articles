---
title: "Qwen 3.5 Plus is on AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/qwen-3-5-plus-is-on-ai-gateway"
date: "2026-02-16"
scraped_at: "2026-03-02T09:21:31.828813843+00:00"
language: "en-zh"
translated: true
description: "You can now access Alibaba's latest model, Qwen 3.5 Plus, via Vercel's AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Feb 16, 2026

2026 年 2 月 16 日

Qwen 3.5 Plus is now available on AI Gateway.

Qwen 3.5 Plus 现已在 AI Gateway 上线。

The model comes with a 1M context window and built-in adaptive tool use. Qwen 3.5 Plus excels at agentic workflows, thinking, searching, and using tools across multimodal contexts, making it well-suited for web development, frontend tasks, and turning instructions into working code. Compared to Qwen 3 VL, it delivers stronger performance in scientific problem solving and visual reasoning tasks.

该模型具备 100 万 token 的上下文窗口，并原生支持自适应工具调用。Qwen 3.5 Plus 在智能体（agentic）工作流、推理、搜索以及跨多模态场景的工具调用方面表现卓越，特别适用于网页开发、前端任务，以及将自然语言指令直接转化为可运行代码。相较于 Qwen 3 VL，它在科学问题求解与视觉推理任务中展现出更强的性能。

To use this model, set model to `alibaba/qwen3.5-plus` in the AI SDK:

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `alibaba/qwen3.5-plus`：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'alibaba/qwen3.5-plus',

5  prompt:

6    `Analyze this UI mockup, extract the design system,
```

7     and generate a production-ready React component

7     并生成一个可用于生产的 React 组件

8     with responsive breakpoints and theme support.`,

8     支持响应式断点和主题定制。`,

9});
```

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于模型提供商自身可用性的服务稳定性。它内置了[可观测性（Observability）](https://vercel.com/docs/observability/ai-sdk-observability)、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能服务商路由功能。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/qwen3.5-plus).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型 Playground](https://vercel.com/ai-gateway/models/qwen3.5-plus) 中亲自体验。