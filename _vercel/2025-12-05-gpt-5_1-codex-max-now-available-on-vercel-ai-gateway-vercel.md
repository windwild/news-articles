---
render_with_liquid: false
title: "GPT 5.1 Codex Max now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-1-codex-max-now-available-on-vercel-ai-gateway"
date: "2025-12-05"
scraped_at: "2026-03-02T09:24:42.573236464+00:00"
language: "en-zh"
translated: true
description: "You can now access the GPT 5.1 Codex Max model with Vercel's AI Gateway with no other provider accounts required."
---
render_with_liquid: false
render_with_liquid: false

Dec 5, 2025

2025 年 12 月 5 日

You can now access OpenAI's latest Codex models, GPT-5.1 Codex Max with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required.

您现在可通过 Vercel 的 [AI 网关](https://vercel.com/ai-gateway) 直接访问 OpenAI 最新的 Codex 模型——GPT-5.1 Codex Max，无需另行注册其他服务商账号。

Using a process called compaction, GPT-5.1 Codex Max has been trained to operate across multiple context windows and on real-world software engineering tasks. GPT-5.1 Codex Max is faster and more token efficient compared to previous Codex models, optimized for long-running coding tasks, and can maintain context and reasoning over long periods without needing to start new sessions.

GPT-5.1 Codex Max 采用一种名为“压缩”（compaction）的训练方法，使其能够跨多个上下文窗口运行，并胜任真实世界的软件工程任务。相比此前的 Codex 系列模型，GPT-5.1 Codex Max 运行速度更快、Token 利用效率更高；专为长时间运行的编程任务优化，可在不启动新会话的前提下，长期保持上下文连贯性与逻辑推理能力。

To use GPT-5.1 Codex Max with the [AI SDK](https://ai-sdk.dev/), set the model to `openai/gpt-5.1-codex-max`.

如需在 [AI SDK](https://ai-sdk.dev/) 中使用 GPT-5.1 Codex Max，请将 `model` 参数设为 `openai/gpt-5.1-codex-max`。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5.1-codex-max',

5  prompt:

6    `Write a CLI tool that scans web server logs, counts 5xx errors per endpoint,
```

7     并仅使用标准库打印出错误数最多的十个端点。`

8  providerOptions: {

9    openai: {

10      reasoningSummary: "auto",

11      reasoningEffort: "low"

12    },

13  },

14});
```

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化，从而实现高于各模型提供商自身水平的正常运行时间（uptime）。它内置了[可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及智能的[提供商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)，并支持自动重试。

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场（Model Playground）](https://vercel.com/ai-gateway/models/gpt-5.1-codex-max) 中亲自体验。

[**AI Gateway: Track top AI models by usage**  
**AI Gateway：按使用量追踪顶级 AI 模型**

The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.  
AI Gateway 模型排行榜根据通过该网关的所有流量所产生的总 Token 量，对各时段内使用最频繁的模型进行排序。榜单定期更新。

[View the leaderboard](https://vercel.com/ai-gateway/leaderboards)  
[查看排行榜](https://vercel.com/ai-gateway/leaderboards)