---
title: "Qwen 3 Max Thinking now available on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/qwen-3-max-thinking-now-available-on-ai-gateway"
date: "2026-01-26"
scraped_at: "2026-03-02T09:22:14.171553882+00:00"
language: "en-zh"
translated: true
description: "You can now access Qwen 3 Max Thinking via Vercel's AI Gateway with no other provider accounts required."
---
{% raw %}

Jan 26, 2026

2026 年 1 月 26 日

You can now access Qwen 3 Max Thinking via [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 Qwen 3 Max Thinking，无需注册其他服务商账号。

Qwen 3 Max Thinking integrates thinking and non-thinking modes for improved performance on complex reasoning tasks. The model autonomously selects and uses its built-in search, memory, and code interpreter tools during conversations without requiring manual tool selection. The tools reduce hallucinations and provide real-time information.

Qwen 3 Max Thinking 融合了“思考模式”与“非思考模式”，在复杂推理任务中表现更优。该模型可在对话过程中自主选择并调用其内置的搜索、记忆及代码解释器等工具，无需用户手动指定工具。这些工具有助于降低幻觉（hallucination）风险，并提供实时信息。

To use this model, set model to `alibaba/qwen3-max-thinking` in the AI SDK:

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `alibaba/qwen3-max-thinking`：

```tsx
import { streamText } from 'ai'



const { textStream } = await streamText({

4  model: 'alibaba/qwen3-max-thinking',

5  prompt:

6   `Research a current topic, verify facts, remember a user preference,
```

7    and include a short code snippet to support the explanation.`,

8})
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于服务商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)功能、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能服务商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/qwen-3-max-thinking).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型 Playground](https://vercel.com/ai-gateway/qwen-3-max-thinking) 中亲自体验。
{% endraw %}
