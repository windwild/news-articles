---
title: "LongCat-Flash Chat model is now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/longcat-flash-chat-model-is-now-supported-in-vercel-ai-gateway"
date: "2025-09-11"
scraped_at: "2026-03-02T09:28:37.034198409+00:00"
language: "en-zh"
translated: true
description: "You can now access LongCat-Flash Chat from Meituan using Vercel AI Gateway, with no Meituan account required."
---
{% raw %}

Sep 11, 2025

2025 年 9 月 11 日

您现在可通过 Vercel [AI Gateway](https://vercel.com/ai-gateway) 直接调用美团全新推出的模型 LongCat Flash Chat——一款专注于智能体（agentic）工具调用的模型，无需额外注册其他服务商账号。该模型能够根据上下文需求动态激活相应参数。

AI Gateway 允许您通过统一、一致的 API 调用模型，仅需修改一个字符串即可完成配置；同时支持用量与成本追踪，并可灵活配置性能优化策略、重试机制及故障转移方案，从而实现高于服务商平均水平的系统可用性（uptime）。

如需在 [AI SDK v5](https://ai-sdk.dev/docs/introduction) 中使用该模型，请先安装对应包：

```bash
pnpm i ai
```

随后将模型设置为 `meituan/longcat-flash-chat`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'meituan/longcat-flash-chat',

5  prompt: 'How does dynamic parameter activation work for AI models?'

5  提示词：“AI 模型中的动态参数激活机制是如何工作的？”

6})
6})

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及支持自动重试的智能 [供应商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/ai-gateway) and access the model [here](https://vercel.com/ai-gateway/models/longcat-flash-chat).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，并在此处访问该模型：[链接](https://vercel.com/ai-gateway/models/longcat-flash-chat)。
{% endraw %}
