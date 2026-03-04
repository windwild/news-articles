---
title: "AI Gateway is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-gateway-is-now-generally-available"
date: "2025-08-21"
scraped_at: "2026-03-02T09:29:31.510543116+00:00"
language: "en-zh"
translated: true
description: "AI Gateway is now generally available, providing a single interface to access hundreds of AI models with transparent pricing and built-in observability."
---
{% raw %}

Aug 21, 2025

2025年8月21日

![](images/ai-gateway-is-now-generally-available-vercel/img_001.jpg)![](images/ai-gateway-is-now-generally-available-vercel/img_002.jpg)

[AI Gateway](https://vercel.com/ai-gateway) 现已正式发布（General Availability），为您提供统一的单一 API 接口，以透明定价和内置可观测性，便捷访问数百种 AI 模型。

AI Gateway 支持跨多个推理服务提供商的亚 20 毫秒低延迟路由，具备以下核心能力：

- 透明计价：不加收任何 token 溢价（支持 BYOK —— Bring Your Own Keys）

- 自动故障转移：显著提升服务可用性

- 高频次调用配额（High rate limits）

- 细粒度的成本与用量分析（Detailed cost and usage analytics）


您可通过 [AI SDK](https://ai-sdk.dev/) 或 OpenAI 兼容接口接入 AI Gateway；使用 AI SDK 时，仅需简单切换模型字符串即可完成集成。

只需一次 API 调用，即刻开始使用：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'openai/gpt-5',

5  prompt: 'How can AI Gateway not have a markup on tokens?'

6})
```

了解更多关于该[公告](https://vercel.com/blog/ai-gateway-is-now-generally-available)的信息，深入学习[AI Gateway](https://vercel.com/ai-gateway)，或立即[开始使用](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fquick-start&title=Get+started+with+AI+Gateway)。
{% endraw %}
