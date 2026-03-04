---
title: "MiniMax M2.1 now live on Vercel AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/minimax-m2-1-now-live-on-vercel-ai-gateway"
date: "2025-12-22"
scraped_at: "2026-03-02T09:23:36.521516939+00:00"
language: "en-zh"
translated: true
description: "You can now access the MiniMax M2.1 model on Vercel's AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Dec 22, 2025

2025 年 12 月 22 日

You can now access MiniMax's latest model, M2.1, with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required.

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接调用 MiniMax 最新大模型 M2.1，无需另行注册其他服务商账号。

MiniMax M2.1 is faster than its predecessor M2, with clear improvements specifically in coding use cases and complicated multi-step tasks with tool calls. M2.1 writes higher quality code, is better at following instructions for difficult tasks, and has a cleaner reasoning process. The model has breadth in addition to depth, with improved performance across multiple coding languages (Go, C++, JS, C#, TS, etc.) and refactoring, feature adds, bug fixes, and code review.

MiniMax M2.1 相较其前代模型 M2 运行速度更快，在编程类任务及需多次调用工具的复杂多步任务中表现尤为突出。M2.1 生成的代码质量更高，更擅长准确理解并执行高难度任务指令，推理过程也更为清晰简洁。该模型不仅在深度上有所提升，广度亦显著增强：在多种编程语言（如 Go、C++、JavaScript、C#、TypeScript 等）上的综合性能全面提升，并在代码重构、功能开发、缺陷修复及代码审查等场景中均展现出更强能力。

To start building with MiniMax M2.1 via [AI SDK](https://ai-sdk.dev/), set the model to `minimax/minimax-m2.1`:

如需通过 [AI SDK](https://ai-sdk.dev/) 开始基于 MiniMax M2.1 构建应用，请将模型参数设为 `minimax/minimax-m2.1`：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'minimax/minimax-m2.1',

5  prompt:

6    `Initialize a React + TypeScript project of a sunrise.
```

7     Generate assets with an image tool, compute sun position

7     使用图像工具生成资源，使用时间工具计算太阳位置

8     with a time tool, animate it, run tests, and produce a build.`

8     利用时间工具为其制作动画、运行测试并生成构建产物。`

9});
```

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于模型提供商自身水平的服务可用性（uptime）。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试能力的智能[提供商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/minimax-m2.1).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型 Playground](https://vercel.com/ai-gateway/models/minimax-m2.1) 中亲自体验。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪主流 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由 Gateway 流转的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)