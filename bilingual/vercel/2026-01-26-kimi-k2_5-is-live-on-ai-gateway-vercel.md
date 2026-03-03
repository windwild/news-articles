---
title: "Kimi K2.5 is live on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/kimi-k2-5-on-ai-gateway"
date: "2026-01-26"
scraped_at: "2026-03-02T09:22:09.137829871+00:00"
language: "en-zh"
translated: true
description: "You can now access Moonshot AI's Kimi K2.5 model via Vercel's AI Gateway with no other provider accounts required."
---

Jan 26, 2026

2026年1月26日

You can now access Kimi K2.5 via [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 Kimi K2.5，无需注册其他服务商账号。

Kimi K2.5 is Moonshot AI's most intelligent and versatile model yet, achieving open-source state-of-the-art performance across agent tasks, coding, visual understanding, and general intelligence. It has more advanced coding abilities compared to previous iterations, especially with frontend code quality and design expressiveness. This enables the creation of fully functional interactive user interfaces with dynamic layouts and animations.

Kimi K2.5 是月之暗面（Moonshot AI）迄今最智能、最全能的大模型，在智能体（agent）任务、编程、视觉理解及通用智能等多方面均达到开源领域的顶尖水平。相较于此前版本，其编程能力显著增强，尤其在前端代码质量与设计表现力方面更为突出，从而支持构建具备动态布局与动画效果的完整可交互用户界面。

To use this model, set model to `moonshotai/kimi-k2.5` in the AI SDK:

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `moonshotai/kimi-k2.5`：

```tsx
import { streamText } from 'ai'​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍‌‍‍​‌﻿‌​‌﻿‌​‌﻿​​‌﻿​﻿​﻿‍‍​‍﻿﻿​‍﻿﻿‌‍​‌‌﻿​​‌﻿​​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍﻿﻿‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌‌﻿​﻿​‍﻿﻿‌‍‌‌​﻿‌‌​﻿​﻿​﻿‍​​﻿​‍‌‍‍​‌‍​﻿‌﻿‌​​﻿‌﻿​﻿‌​‌﻿​﻿‌‍‍‌​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌‍‌‍‍‌‌﻿​‍‌‍﻿﻿‌‍﻿‍‌‍﻿‌‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​﻿​‍﻿﻿‌‍﻿‌‌‍​‌‌﻿​﻿‌﻿‌​‌‍‌‌‌﻿​‍​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​‍‌‍‍‌‌‍‌‌‌﻿​﻿​‍﻿﻿​﻿‌‌‌﻿​‍‌‌‌‌‌‌​‍‌​​‍‌​‌‍‌‌‍​‌‌‌﻿‌​‍‍‌﻿‌‌‌‌‌‍‌‌‍‌‌‍﻿‍​﻿​﻿‌﻿‌​‌‍‍​‌​﻿﻿‌​‌‍‌‌‍‍‌‍‌﻿‌﻿​‍‌​‌‌​‍﻿﻿​﻿﻿﻿‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​​﻿﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍‌‍‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​﻿​‌‍﻿﻿‌‍​﻿‌‍​‌‌‍﻿​‌‍‌‌​﻿﻿‌‌‍‌‌‌‍﻿‍​‍﻿‌‌‌‌‌‌‌​﻿​‍‌‍‌﻿​﻿‌‍﻿﻿‌﻿‌‌‌﻿​‍‌‍​﻿‌‍‌‌​﻿﻿‌‌﻿‌‍‌‍‌‌‌﻿​‍‌‍​﻿‌‍‌‌‌‍﻿​​‍﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍﻿‌‌‍﻿​‌‍‍‌‌‍﻿‍‌‍‍﻿​‍​‍​‍﻿​​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍‌​‍‌‌‍﻿‍‌﻿‌​‌‍‌‌‌﻿​‍‌‍‌‍‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​‍‌‌‍‌​​‍​‍​﻿‍‍​‍​‍‌﻿​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​‌​‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍​‍​‍​‍﻿​​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​﻿‍‌‍​‌‌‍﻿‌‌‍‌‌‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‍​‍‌﻿‌‌‌‍‍‌‌‍﻿​‌﻿‌​‌‍‍‌‌‍﻿‍​‍​‍‌﻿﻿‌​‍﻿​​‍​‍‌‍‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​‌‌‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‌​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍‌﻿﻿‌‌﻿﻿‌



const result = streamText({

4  model: "moonshotai/kimi-k2.5",

5  prompt:

6   `Build a playful task dashboard with animations, drag-and-drop chaos,

7    infinite scroll, theme toggles, and production-ready frontend code.`

7    无限滚动、主题切换以及可用于生产环境的前端代码。`

8})​​​​‌﻿‍﻿​‍​‍‌‍﻿﻿‌﻿​‍‌‍‍‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍​‍​‍﻿​​‍​‍‌‍‍​‌﻿​‍‌‍‌‌‌‍‌‍​‍​‍​﻿‍‍​‍​‍‌‍‍​‌﻿‌​‌﻿‌​‌﻿​​‌﻿​﻿​﻿‍‍​‍﻿﻿​‍﻿﻿‌‍​‌‌﻿​​‌﻿​​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍﻿‍‌‍​﻿‌‍﻿﻿‌‍﻿‌​‍﻿﻿‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌‌﻿​﻿​‍﻿﻿‌‍‌‌​﻿‌‌​﻿​﻿​﻿‍​​﻿​‍‌‍‍​‌‍​﻿‌﻿‌​​﻿‌﻿​﻿‌​‌﻿​﻿‌‍‍‌​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌‍‌‍‍‌‌﻿​‍‌‍﻿﻿‌‍﻿‍‌‍﻿‌‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​﻿​‍﻿﻿‌‍﻿‌‌‍​‌‌﻿​﻿‌﻿‌​‌‍‌‌‌﻿​‍​‍﻿﻿‌‍‌‌‌‍﻿‍‌﻿‌​‌﻿​‍‌‍‍‌‌‍‌‌‌﻿​﻿​‍﻿﻿​﻿‌‌‌﻿​‍‌‌‌‌‌‌​‍‌​​‍‌​‌‍‌‌‍​‌‌‌﻿‌​‍‍‌﻿‌‌‌‌‌‍‌‌‍‌‌‍﻿‍​﻿​﻿‌﻿‌​‌‍‍​‌​﻿﻿‌​‌‍‌‌‍‍‌‍‌﻿‌﻿​‍‌​‌‌​‍﻿﻿​﻿﻿﻿‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​​﻿﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍‌‍‌‍‌‍‌‍﻿﻿‌‍​﻿‌﻿‌‌‌﻿​﻿‌‍‌‌‌‍‌​‌​﻿​‌‍﻿﻿‌‍​﻿‌‍​‌‌‍﻿​‌‍‌‌​﻿﻿‌‌‍‌‌‌‍﻿‍​‍﻿‌‌‌‌‌‌‌​﻿​‍‌‍‌﻿​﻿‌‍﻿﻿‌﻿‌‌‌﻿​‍‌‍​﻿‌‍‌‌​﻿﻿‌‌﻿‌‍‌‍‌‌‌﻿​‍‌‍​﻿‌‍‌‌‌‍﻿​​‍﻿‌‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​​‍﻿‌‌‍﻿​‌‍‍‌‌‍﻿‍‌‍‍﻿​‍​‍​‍﻿​​‍​‍‌‍​﻿‌‍﻿﻿‌‍﻿‍‌﻿‌​‌‍‌‌‌‍﻿‍‌﻿‌​‌‍‌‍‌﻿‌‌‌‍﻿​​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌‍‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍‌​‍‌‌‍﻿‍‌﻿‌​‌‍‌‌‌﻿​‍‌‍‌‍‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍‌﻿‍﻿​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​‍‌‌‍‌​​‍​‍​﻿‍‍​‍​‍‌﻿​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​‌​‌‌‌‍‌​‌‍‍‌‌﻿‌​‌‍﻿﻿‌﻿​‍​‍​‍​‍﻿​​‍​‍‌﻿‌﻿‌‍‍‌‌‍‌​‌‍‌﻿‌‍‌‌‌﻿‌​‌​﻿‍‌‍​‌‌‍﻿‌‌‍‌‌‌﻿​﻿‌﻿​​‌‍​‌‌‍​﻿‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‍​‍‌﻿‌‌‌‍‍‌‌‍﻿​‌﻿‌​‌‍‍‌‌‍﻿‍​‍​‍‌﻿﻿‌​‍﻿​​‍​‍‌‍‌‍‌‍‍‌‌‍‌‌‌‍﻿​‌‍‌​‌‌‌​‌﻿‍‌‌﻿​​‌‍‌‌​‍​‍​﻿‍‍​‍​‍‌‌​‍‌‍‍‌‌‍​﻿‌‍‍​‌‌‌​‌‍‌‌‌﻿‍​‌﻿‌​​‍​‍‌﻿﻿‌‌﻿﻿‌

```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

```

AI 网关（AI Gateway）提供统一的 API，用于调用模型、追踪用量与成本，并配置重试机制、故障转移及性能优化策略，从而实现高于模型提供商自身可用性的服务稳定性。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)功能、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能服务商路由功能。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/kimi-k2.5).

了解更多关于 [AI 网关](https://vercel.com/ai-gateway) 的信息，查看 [AI 网关模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型体验平台](https://vercel.com/ai-gateway/models/kimi-k2.5) 中亲自试用。