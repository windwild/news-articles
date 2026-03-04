---
title: "Claude Sonnet 4 now supports 1M token context in Vercel AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-sonnet-4-now-supports-1m-token-context-in-vercel-ai-gateway"
date: "2025-08-12"
scraped_at: "2026-03-02T09:29:49.091442947+00:00"
language: "en-zh"
translated: true
description: "You can now leverage Claude Sonnet 4's updated token context window with Vercel's AI Gateway with no other provider accounts required."
---

render_with_liquid: false
Aug 12, 2025

2025 年 8 月 12 日

您现在可通过 Vercel 的 [AI Gateway](https://vercel.com/docs/ai-gateway)，直接使用 [Claude Sonnet 4 更新后的 100 万 Token 上下文窗口](https://www.anthropic.com/news/1m-context)，无需另行注册其他服务商账户。Anthropic 此次发布显著扩展了模型可处理的输入规模，例如完整代码库（约 75,000 行以上）或大型文档集合。

AI Gateway 提供统一、一致的 API 接口，仅需一次字符串配置即可调用模型；同时支持用量与成本追踪，并可灵活配置性能优化策略、重试机制及故障转移方案，从而实现高于服务商平均水平的系统可用性（uptime）。

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该功能，请先安装对应包：

```bash
pnpm i ai
```

然后将模型设置为 `anthropic/claude-4-sonnet`：

```tsx
import { streamText } from 'ai';

import { largePrompt } from './largePrompt.ts';



const result = streamText({

5  headers: {

5  请求头：{

6    'anthropic-beta': 'context-1m-2025-08-07',

6    'anthropic-beta': 'context-1m-2025-08-07',

7  },

7  },

8  model: 'anthropic/claude-4-sonnet',

8  模型：'anthropic/claude-4-sonnet',

9  prompt: `You have a big brain. Summarize into 3 sentences: ${largePrompt}`,

9  提示词：`你非常聪明。请将以下内容总结为 3 句话：${largePrompt}`,

10  providerOptions: {

10  服务提供商选项：{

11    gateway: { only: ['anthropic'] },

11    网关：{ only: ['anthropic'] },

12  },

12  },

13});


13});

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能 [提供商路由](https://vercel.com/docs/ai-gateway/provider-options)。

To deliver high performance and reliability to Claude Sonnet 4, AI Gateway leverages multiple model providers under the hood, including Anthropic and Bedrock.

为向 Claude Sonnet 4 提供高性能与高可靠性，AI Gateway 在底层集成了多个模型提供商，包括 Anthropic 和 Bedrock。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway) and view the [new AI Gateway model leaderboard](https://vercel.com/ai-gateway).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，并查看 [全新的 AI Gateway 模型排行榜](https://vercel.com/ai-gateway)。

[**AI Gateway: Track top AI models by usage**\\  
\\  
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\  
\\  
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶尖 AI 模型**\\  
\\  
AI Gateway 模型排行榜根据通过网关的所有流量所产生的总 Token 量，对各模型的历史使用量进行排序。榜单定期更新。\\  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)