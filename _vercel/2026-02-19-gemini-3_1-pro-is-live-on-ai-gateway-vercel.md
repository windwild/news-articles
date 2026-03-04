---
render_with_liquid: false
title: "Gemini 3.1 Pro is live on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gemini-3-1-pro-is-live-on-ai-gateway"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:28.501290730+00:00"
language: "en-zh"
translated: true
description: "You can now access Google's newest model, Gemini 3.1 Pro Preview via Vercel's AI Gateway with no other provider accounts required."
---
render_with_liquid: false
render_with_liquid: false

Feb 19, 2026

2026 年 2 月 19 日

Gemini 3.1 Pro Preview from Google is now available on AI Gateway.

Google 推出的 Gemini 3.1 Pro Preview 现已上线 AI Gateway。

This model release brings quality improvements across software engineering and agentic workflows, with enhanced usability for real-world tasks in finance and spreadsheet applications. Gemini 3.1 Pro Preview introduces more efficient thinking across use cases, reducing token consumption while maintaining performance.

本次模型发布在软件工程和智能体（agentic）工作流方面均带来了质量提升，并显著增强了其在金融及电子表格等实际应用场景中的可用性。Gemini 3.1 Pro Preview 引入了更高效的任务推理能力，在各类使用场景中降低了 token 消耗，同时保持了原有性能水平。

To use this model, set model to `google/gemini-3.1-pro-preview` in the AI SDK. This model supports the `medium` thinking level for finer control over the trade-offs between cost, performance, and speed.

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `google/gemini-3.1-pro-preview`。该模型支持 `medium` 推理级别，使您能更精细地权衡成本、性能与响应速度之间的关系。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3.1-pro-preview',

5  prompt:

6    `Review this pull request for security vulnerabilities,

7     suggest fixes, and update the test suite to cover edge cases.`,

7     提出修复建议，并更新测试套件以覆盖边界情况。`,

8  providerOptions: {

8  providerOptions: {

9    google: {

9    google: {

10      thinking_level: 'medium',

10      thinking_level: 'medium',

11    },

11    },

12  },

12  },

13});
```

13});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化，从而实现高于单个服务商的可用性。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)功能、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能服务商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gemini-3.1-pro-preview).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/gemini-3.1-pro-preview) 中亲自体验。