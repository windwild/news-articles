---
title: "Gemini 3 Pro now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gemini-3-pro-now-available-in-vercel-ai-gateway"
date: "2025-11-18"
scraped_at: "2026-03-02T09:25:32.333075286+00:00"
language: "en-zh"
translated: true
description: "You can now access Google's latest model Gemini 3 Pro in Vercel AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Nov 18, 2025

2025 年 11 月 18 日

You can now access Google's latest model, Gemini 3 Pro, via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 直接访问 Google 最新模型 Gemini 3 Pro，无需另行注册其他服务商账号。

Gemini 3 Pro excels at challenging tasks involving reasoning or agentic workflows. In particular, the model improves on Gemini 2.5 Pro's performance in multi-step function calling, planning, reasoning over complex images/long documents, and instruction following.

Gemini 3 Pro 在涉及推理或智能体（agentic）工作流的复杂任务中表现卓越。尤其在多步函数调用、规划、对复杂图像/长文档进行推理，以及指令遵循等方面，其性能相较 Gemini 2.5 Pro 进一步提升。

To use Gemini 3 Pro in AI Gateway with the [AI SDK](https://ai-sdk.dev/), set `model` to `google/gemini-3.0-pro-preview`. Gemini 3 Pro is a reasoning model, and you can specify the level of thinking. Include the `providerOptions` configuration with `includeThoughts` like the example below to enable reasoning text.

如需在 AI 网关（AI Gateway）中配合 [AI SDK](https://ai-sdk.dev/) 使用 Gemini 3 Pro，请将 `model` 参数设为 `google/gemini-3.0-pro-preview`。Gemini 3 Pro 是一款推理型模型，支持指定推理深度。请参考下方示例，在 `providerOptions` 配置中加入 `includeThoughts` 字段，以启用推理过程文本输出。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'google/gemini-3-pro-preview',

5  prompt:

6  `Analyze the attached technical report and all included diagrams.
```

7   Identify the main objective, extract data into a table, summarize each  

7   明确主要目标，将数据提取为表格，逐一总结各部分内容。

8   diagram, and list inconsistencies between text and visuals.

8   绘制示意图，并列出文字描述与视觉图表之间的不一致之处。

9   Cite all supporting page and figure references.`

9   引用所有支持性页面及图表编号。

10  providerOptions: {

10  providerOptions: {

11    google: {

11    google: {

12      thinkingConfig: {

12      thinkingConfig: {

13        includeThoughts: true,

13        includeThoughts: true,

14      }

14      }

15    }

15    }

16  },

16  },

17});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于服务商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试功能的智能[服务商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gemini-3-pro-preview).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型体验平台](https://vercel.com/ai-gateway/models/gemini-3-pro-preview) 中亲自尝试。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶尖 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由 Gateway 的流量所产生的总 Token 量，对各模型在一段时间内的使用热度进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
&#123;% endraw %}
