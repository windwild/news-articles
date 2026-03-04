---
render_with_liquid: false
title: "GLM-5 is live on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/glm-5-is-live-on-ai-gateway"
date: "2026-02-11"
scraped_at: "2026-03-02T09:21:33.128389995+00:00"
language: "en-zh"
translated: true
description: "You can now access Z.AI's latest model, GLM 5, via Vercel's AI Gateway with no other provider accounts required."
---
render_with_liquid: false
render_with_liquid: false

Feb 11, 2026

2026 年 2 月 11 日

You can now access GLM-5 via [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 GLM-5，无需另行注册其他服务商账号。

GLM-5 from Z.AI is now available on AI Gateway. Compared to GLM-4.7, GLM-5 adds multiple thinking modes, improved long-range planning and memory, and better handling of complex multi-step agent tasks. It's particularly strong at agentic coding, autonomous tool use, and extracting structured data from documents like contracts and financial reports.

Z.AI 推出的 GLM-5 现已上线 AI Gateway。相较于 GLM-4.7，GLM-5 新增多种推理模式，显著提升了长程规划与记忆能力，并更出色地支持复杂多步骤智能体（agent）任务。该模型在智能体式编程（agentic coding）、自主工具调用，以及从合同、财务报告等文档中提取结构化数据等方面表现尤为突出。

To use this model, set model to `zai/glm-5` in the AI SDK:

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `zai/glm-5`：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'zai/glm-5',

5  prompt:

6    `Generate a complete REST API with authentication,

7     database models, and test coverage for a task management app.`,

7     任务管理应用的数据库模型和测试覆盖率。`,

8});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于模型提供商自身可用性的服务等级。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)功能、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能服务商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/glm-5).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/glm-5) 中亲自体验。