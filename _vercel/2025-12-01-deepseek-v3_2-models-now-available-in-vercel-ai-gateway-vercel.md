---
title: "DeepSeek V3.2 models now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deepseek-v3-2-now-in-vercel-ai-gateway"
date: "2025-12-01"
scraped_at: "2026-03-02T09:25:02.441224546+00:00"
language: "en-zh"
translated: true
description: "You can now access the newest DeepSeek V3.2 models, V3.2 and V3.2 Speciale in Vercel AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Dec 1, 2025

2025 年 12 月 1 日

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 DeepSeek 最新模型 —— DeepSeek V3.2 和 DeepSeek V3.2 Speciale，无需另行注册其他服务商账号。

DeepSeek V3.2 支持“推理（thinking）”与“工具调用（tool use）”的协同工作，可在推理模式与非推理模式下均执行类智能体（agent-style）操作（即工具调用）。DeepSeek V3.2 Speciale 则专为极致推理性能而优化，适用于复杂任务场景，但其 token 消耗更高，且不支持工具调用。

如需使用 DeepSeek V3.2 系列模型，请在 [AI SDK](https://ai-sdk.dev/) 中将 `model` 参数设置为以下值：

- 非推理模式：`deepseek/deepseek-v3.2`  
- 推理模式：`deepseek/deepseek-v3.2-thinking`  
- Speciale 版本：`deepseek/deepseek-v3.2-speciale`

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'deepseek/deepseek-v3.2-speciale',

4  模型：'deepseek/deepseek-v3.2-speciale',

5  prompt:

5  提示词：

6  `Design a self-contained, step-by-step solution to a novel math–algorithm

6  `设计一个自包含、分步式的解决方案，用于解决一道新颖的“数学–算法”交叉问题：证明其正确性、推导其时间/空间复杂度，并为一般情形构建最优实现。`,

7   hybrid problem: prove correctness, derive complexity, and construct

7   混合问题：证明其正确性、推导其复杂度，并构建

8   an optimal implementation for the general case.`,

8   适用于一般情形的最优实现。`,

9});

9});

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于模型提供商自身可用性的服务稳定性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试能力的智能[提供商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use DeepSeek V3.2 models directly in our [model playground](https://vercel.com/ai-gateway/models/deepseek-v3.2-speciale).

请查阅[文档](https://vercel.com/docs/ai-gateway)，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或直接在我们的[模型体验平台](https://vercel.com/ai-gateway/models/deepseek-v3.2-speciale)中使用 DeepSeek V3.2 系列模型。

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
