---
title: "Use MiniMax M2.5 on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/use-minimax-m2-5-on-ai-gateway"
date: "2026-02-12"
scraped_at: "2026-03-02T09:21:32.536081625+00:00"
language: "en-zh"
translated: true
description: "You can now access MiniMax M2.5 through Vercel's AI Gateway with no other provider accounts required."
---
&#123;% raw %}

Feb 12, 2026

2026 年 2 月 12 日

MiniMax M2.5 is now available on AI Gateway.

MiniMax M2.5 现已在 AI Gateway 上线。

M2.5 plans before it builds, breaking down functions, structure, and UI design before writing code. It handles full-stack projects across Web, Android, iOS, Windows, and Mac, covering the entire development lifecycle from initial system design through code review. Compared to M2.1, it adapts better to unfamiliar codebases and uses fewer search rounds to solve problems.

M2.5 在编码前即进行规划，先对功能、系统结构和 UI 设计进行拆解。它支持涵盖 Web、Android、iOS、Windows 和 Mac 的全栈项目，覆盖从初始系统设计到代码审查的完整开发生命周期。相比 M2.1，M2.5 能更高效地适应陌生代码库，并以更少的搜索轮次解决问题。

To use this model, set model to `minimax/minimax-m2.5` in the AI SDK:

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `minimax/minimax-m2.5`：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'minimax/minimax-m2.5',

5  prompt:

6    `Design and implement a multi-tenant SaaS authentication system
```

7     with role-based access control, supporting OAuth providers

7     具有基于角色的访问控制（RBAC），支持 OAuth 提供商

8     and API key management.`,

8     以及 API 密钥管理。`,

9});
```

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于各模型提供商自身水平的服务可用性。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)功能、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试能力的智能提供商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/minimax-m2.5).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/minimax-m2.5) 中亲自体验。
&#123;% endraw %}
