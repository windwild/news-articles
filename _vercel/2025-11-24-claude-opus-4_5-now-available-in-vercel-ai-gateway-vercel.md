---
title: "Claude Opus 4.5 now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-opus-4-5-now-available-in-vercel-ai-gateway"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:22.866353805+00:00"
language: "en-zh"
translated: true
description: "You can now access Anthropic's latest model Claude Opus 4.5 in Vercel AI Gateway with no other provider accounts required."
---
{% raw %}

Nov 24, 2025

2025 年 11 月 24 日

You can now access Anthropic's latest model, Claude Opus 4.5, via Vercel's [AI Gateway](https://vercel.com/ai-gateway) with no other provider accounts required.

您现在可通过 Vercel 的 [AI 网关（AI Gateway）](https://vercel.com/ai-gateway) 直接访问 Anthropic 最新模型 Claude Opus 4.5，无需另行注册其他服务商账号。

Claude Opus 4.5 is suited for demanding reasoning tasks and complex problem solving. This model has improvements in general intelligence and vision compared to previous iterations. It excels at difficult coding tasks and agentic workflows, especially those with computer use and tool use, and can effectively handle context usage and external memory files. Frontend coding and design are established strengths, particularly for developing real-world web applications.

Claude Opus 4.5 专为高要求的推理任务与复杂问题求解而设计。相较于此前版本，该模型在通用智能（general intelligence）与视觉理解能力方面均有显著提升。它在高难度编程任务及智能体（agentic）工作流方面表现尤为出色——尤其是涉及计算机操作与工具调用的场景；同时能高效处理上下文使用及外部记忆文件。前端开发与界面设计是其公认强项，特别适用于构建真实世界中的 SaaS 类 Web 应用。

To use Claude Opus 4.5, set `model` to `anthropic/claude-opus-4.5` in the [AI SDK](https://ai-sdk.dev/). There is a new `effort` parameter for this model. This parameter affects all types of tokens and controls the level of token usage when responding to a request. By default, `effort` is set to high and is independent of the thinking budget. To use it in AI Gateway with the AI SDK, set `effort` for the provider in `providerOptions`, as seen below in the example.

如需使用 Claude Opus 4.5，请在 [AI SDK](https://ai-sdk.dev/) 中将 `model` 参数设为 `anthropic/claude-opus-4.5`。该模型新增了一个 `effort` 参数：它影响所有类型的 token，并控制模型响应请求时的 token 使用强度。默认情况下，`effort` 设为 `high`，且该设置独立于“思考预算（thinking budget）”。若要在 AI 网关中配合 AI SDK 使用该参数，需在 `providerOptions` 中为对应 provider 显式指定 `effort`，具体用法参见下方示例。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'anthropic/claude-opus-4.5',

5  prompt:

6  `Design and build a production-ready SaaS web app with
```

7   real-time analytics, feature flags, dashboards, alerts, RBAC,

7   实时分析、功能开关、仪表板、告警、基于角色的访问控制（RBAC），

8   integrations, accessibility, and performance optimization.`,

8   集成能力、可访问性支持以及性能优化。`,

9  providerOptions: {

9  providerOptions: {

10    anthropic: {

10    anthropic: {

11      effort: 'high',

11      effort: 'high',

12  },

12  },

13});

13});

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于单个供应商的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试能力的智能[供应商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Read the [docs](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards), or use Claude Opus 4.5 directly in our [model playground](https://vercel.com/ai-gateway/models/claude-opus-4.5).

请查阅[文档](https://vercel.com/docs/ai-gateway)，查看[AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或直接在我们的[模型体验平台](https://vercel.com/ai-gateway/models/claude-opus-4.5)中使用 Claude Opus 4.5。

[**AI Gateway: Track top AI models by usage**\\  
\\  
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\  
\\  
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪主流 AI 模型**\\  
\\  
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\  
\\  
查看排行榜](https://vercel.com/ai-gateway/leaderboards)
{% endraw %}
