---
title: "AI Gateway is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-gateway-is-now-generally-available"
date: "2025-08-21"
scraped_at: "2026-03-02T09:29:31.510543116+00:00"
language: "en"
translated: false
description: "AI Gateway is now generally available, providing a single interface to access hundreds of AI models with transparent pricing and built-in observability."
---




Aug 21, 2025

![](images/ai-gateway-is-now-generally-available-vercel/img_001.jpg)![](images/ai-gateway-is-now-generally-available-vercel/img_002.jpg)

[AI Gateway](https://vercel.com/ai-gateway) is now generally available, providing a single unified API to access hundreds of AI models with transparent pricing and built-in observability.

With sub-20ms latency routing across multiple inference providers, AI Gateway delivers:

- Transparent pricing with no markup on tokens (including Bring Your Own Keys)

- Automatic failover for higher availability

- High rate limits

- Detailed cost and usage analytics


You can use AI Gateway with the [AI SDK](https://ai-sdk.dev/) or through the OpenAI-compatible endpoint. With the AI SDK, it’s just a simple model string switch.

Get started with a single API call:

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: 'openai/gpt-5',

5  prompt: 'How can AI Gateway not have a markup on tokens?'

6})
```

Read more about the [announcement](https://vercel.com/blog/ai-gateway-is-now-generally-available), learn more about [AI Gateway](https://vercel.com/ai-gateway), or [get started now](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fquick-start&title=Get+started+with+AI+Gateway).