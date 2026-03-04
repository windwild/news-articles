---
title: "Trinity Large Preview is on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/trinity-large-preview-is-on-ai-gateway"
date: "2026-01-26"
scraped_at: "2026-03-03T07:10:29.924617476+00:00"
language: "en-zh"
translated: true
description: "You can now access Arcee AI's Trinity Large Preview model via AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Jan 26, 2026

2026 年 1 月 26 日

You can now access Trinity Large Preview via [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 Trinity Large Preview，无需额外注册其他服务商账号。

Trinity Large Preview is optimized for reasoning-intensive workloads, including math, coding tasks, and complex multi-step agent workflows. It is designed to handle extended multi-turn interactions efficiently while maintaining high inference throughput.

Trinity Large Preview 针对高推理强度的工作负载进行了优化，适用于数学推演、编程任务以及复杂的多步骤智能体（agent）工作流。该模型专为高效处理长周期、多轮次交互而设计，同时保持高推理吞吐量。

To use this model, set model to `arcee-ai/trinity-large-preview` in the AI SDK:

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `arcee-ai/trinity-large-preview`：

```tsx
import { streamText } from 'ai'​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍‌‍‍​‌﻿‌​‌﻿‌​‌﻿​​‌﻿​﻿​﻿‍‍​‍﻿﻿​‍﻿﻿‌‍​‌‌﻿​​‌﻿​​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍﻿﻿‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌‌﻿​﻿​‍﻿﻿‌‍‌‌​﻿‌‌​﻿​﻿​﻿‍​​﻿​‍‌‍‍​‌‍​﻿‌﻿‌​​﻿‌﻿​﻿‌​‌﻿​﻿‌‍‍‌​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌‍‌‍‍‌‌﻿​‍‌‍﻿﻿‌‍﻿‍‌‍﻿‌‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​﻿​‍﻿﻿‌‍﻿‌‌‍​‌‌﻿​﻿‌﻿‌​‌‍‌‌‌﻿​‍​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​‍‌‍‍‌‌‍‌‌‌﻿​﻿​‍﻿﻿​﻿‌‌‌﻿​‍‌‌‌‌‌‌​‍‌​​‍‌​‌‍‌‌‍​‌‌‌﻿‌​‍‍‌﻿‌‌‌‌‌‍‌‌‍‌‌‍﻿‍​﻿​﻿‌﻿‌​‌‍‍​‌​﻿﻿‌​‌‍‌‌‍‍‌‍‌﻿‌﻿​‍‌​‌‌​‍﻿﻿​﻿﻿﻿‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​​﻿﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍‌‍‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​﻿​‌‍﻿﻿‌‍​﻿‌‍​‌‌‍﻿​‌‍‌‌​﻿﻿‌‌‍‌‌‌‍﻿‍​‍﻿‌‌‌‌‌‌‌​﻿​‍‌‍‌﻿​﻿‌‍﻿﻿‌﻿‌‌‌﻿​‍‌‍​﻿‌‍‌‌​﻿﻿‌‌﻿‌‍‌‍‌‌‌﻿​‍‌‍​﻿‌‍‌‌‌‍﻿​​‍﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍﻿‌‌‍﻿​‌‍‍‌‌‍﻿‍‌‍‍﻿​‍​‍​‍﻿​​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍‌​‍‌‌‍﻿‍‌﻿‌​‌‍‌‌‌﻿​‍‌‍‌‍‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​‍‌‌‍‌​​‍​‍​﻿‍‍​‍​‍‌﻿​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​‌​‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍​‍​‍​‍﻿​​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​﻿‍‌‍​‌‌‍﻿‌‌‍‌‌‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‍​‍‌﻿‌‌‌‍‍‌‌‍﻿​‌﻿‌​‌‍‍‌‌‍﻿‍​‍​‍‌﻿﻿‌​‍﻿​​‍​‍‌‍‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​‌‌‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‌​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍‌﻿﻿‌‌﻿﻿‌



const result = streamText({

4  model: 'arcee-ai/trinity-large-preview',

5  prompt:

6   `Implement a long-context reasoning benchmark with ingested documents,

7    multi-step analysis, and generate conclusions.`

7    多步骤分析，并生成结论。`

8})​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍‌‍‍​‌﻿‌​‌﻿‌​‌﻿​​‌﻿​﻿​﻿‍‍​‍﻿﻿​‍﻿﻿‌‍​‌‌﻿​​‌﻿​​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍﻿﻿‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌‌﻿​﻿​‍﻿﻿‌‍‌‌​﻿‌‌​﻿​﻿​﻿‍​​﻿​‍‌‍‍​‌‍​﻿‌﻿‌​​﻿‌﻿​﻿‌​‌﻿​﻿‌‍‍‌​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌‍‌‍‍‌‌﻿​‍‌‍﻿﻿‌‍﻿‍‌‍﻿‌‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​﻿​‍﻿﻿‌‍﻿‌‌‍​‌‌﻿​﻿‌﻿‌​‌‍‌‌‌﻿​‍​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​‍‌‍‍‌‌‍‌‌‌﻿​﻿​‍﻿﻿​﻿‌‌‌﻿​‍‌‌‌‌‌‌​‍‌​​‍‌​‌‍‌‌‍​‌‌‌﻿‌​‍‍‌﻿‌‌‌‌‌‍‌‌‍‌‌‍﻿‍​﻿​﻿‌﻿‌​‌‍‍​‌​﻿﻿‌​‌‍‌‌‍‍‌‍‌﻿‌﻿​‍‌​‌‌​‍﻿﻿​﻿﻿﻿‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​​﻿﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍‌‍‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​﻿​‌‍﻿﻿‌‍​﻿‌‍​‌‌‍﻿​‌‍‌‌​﻿﻿‌‌‍‌‌‌‍﻿‍​‍﻿‌‌‌‌‌‌‌​﻿​‍‌‍‌﻿​﻿‌‍﻿﻿‌﻿‌‌‌﻿​‍‌‍​﻿‌‍‌‌​﻿﻿‌‌﻿‌‍‌‍‌‌‌﻿​‍‌‍​﻿‌‍‌‌‌‍﻿​​‍﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍﻿‌‌‍﻿​‌‍‍‌‌‍﻿‍‌‍‍﻿​‍​‍​‍﻿​​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍‌​‍‌‌‍﻿‍‌﻿‌​‌‍‌‌‌﻿​‍‌‍‌‍‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​‍‌‌‍‌​​‍​‍​﻿‍‍​‍​‍‌﻿​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​‌​‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍​‍​‍​‍﻿​​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​﻿‍‌‍​‌‌‍﻿‌‌‍‌‌‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‍​‍‌﻿‌‌‌‍‍‌‌‍﻿​‌﻿‌​‌‍‍‌‌‍﻿‍​‍​‍‌﻿﻿‌​‍﻿​​‍​‍‌‍‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​‌‌‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‌​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍‌﻿﻿‌‌﻿﻿‌

```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于模型提供商自身水平的服务可用性。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)功能、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能服务商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/trinity-large-preview).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型体验平台（Model Playground）](https://vercel.com/ai-gateway/models/trinity-large-preview) 中亲自试用。
&#123;% endraw %}
