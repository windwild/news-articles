---
title: "GPT 5.2 models now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-2-models-now-available-on-vercel-ai-gateway"
date: "2025-12-11"
scraped_at: "2026-03-02T09:24:01.395696003+00:00"
language: "en-zh"
translated: true
description: "You can now access the GPT 5.2 models on Vercel's AI Gateway with no other provider accounts required."
---
{% raw %}

Dec 11, 2025

2025 年 12 月 11 日

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 OpenAI 最新发布的 GPT-5.2 模型，无需注册其他服务商账号。

相较于 GPT-5.1 系列模型，GPT-5.2 在专业领域知识工作、编程能力及长上下文推理方面均有显著提升。其他亮点还包括：幻觉（hallucination）更少；视觉理解能力更强，可更准确地解析图表与数据可视化内容；前端开发等复杂任务处理能力突出；在处理长文档时信息保留能力更佳。

目前 AI Gateway 上共提供 3 款 GPT-5.2 模型：

- GPT-5.2 Chat（`openai/gpt-5.2-chat`）：即 ChatGPT 所采用的模型，最适合日常办公与学习场景。

- GPT-5.2（`openai/gpt-5.2`）：适用于深度工作及涉及编程或长文档处理的复杂任务。

- GPT-5.2 Pro（`openai/gpt-5.2-pro`）：专为最具挑战性的问题与任务设计，尤其擅长需大量逻辑推理的场景。

如需在 [AI SDK](https://ai-sdk.dev/) 中使用 GPT-5.2 系列模型，请将 `model` 参数设为对应模型的 slug（如上所列）：

```tsx
import { streamText } from 'ai';
```

```javascript
const result = streamText({

4  model: 'openai/gpt-5.2-pro',

4  模型：'openai/gpt-5.2-pro',

5  prompt:

5  提示词：

6    `Create a single-page aurora sky visualizer app in a single HTML file.

6    `创建一个单页极光天空可视化应用，全部代码包含在一个 HTML 文件中。

7     It should display a realistic animated aurora borealis night sky.

7     应呈现逼真的、动态的北极光夜空效果。

8     Change solar activity level, color palette (green/purple/mixed),

8     支持调节太阳活动强度、配色方案（绿色/紫色/混合色），

9     and sky clarity (haze, clear, light clouds).

9     以及天空通透度（薄雾、晴朗、薄云）。

10     The UI should feel tranquil, immersive, and visually realistic,

10     界面应营造宁静、沉浸且视觉逼真的体验，

11     with smooth transitions and subtle ambient motion.`

11     动画过渡需流畅，背景运动需细腻自然。`

12  providerOptions: {

12  供应商选项：{
```

13    openai: {

13    openai: {

14      reasoningSummary: 'detailed',

14      reasoningSummary: '详细',

15      reasoningEffort: 'high',

15      reasoningEffort: '高',

16    },

16    },

17  },

17  },

18});

18});

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于服务商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及支持自动重试的智能[服务商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.2-pro).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/gpt-5.2-pro) 中亲自体验。

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
{% endraw %}
