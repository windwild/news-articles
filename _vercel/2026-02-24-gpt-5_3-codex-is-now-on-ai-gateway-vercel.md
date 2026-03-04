---
title: "GPT 5.3 Codex is now on AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-3-codex-is-now-on-ai-gateway"
date: "2026-02-24"
scraped_at: "2026-03-02T09:21:24.487692064+00:00"
language: "en-zh"
translated: true
description: "You can now access OpenAI's newest model GPT 5.3 Codex via Vercel's AI Gateway with no other provider accounts required."
---
{% raw %}

Feb 24, 2026

2026 年 2 月 24 日

GPT 5.3 Codex is now available on AI Gateway. GPT 5.3 Codex brings together the coding strengths of GPT-5.2-Codex and the reasoning depth of GPT-5.2 in a single model that's 25% faster and more token-efficient.

GPT 5.3 Codex 现已上线 AI Gateway。该模型融合了 GPT-5.2-Codex 的编程能力与 GPT-5.2 的深度推理能力，单模型性能提升 25%，响应速度更快，且 Token 利用效率更高。

Built for long-running agentic work, the model handles research, tool use, and multi-step execution across the full software lifecycle, from debugging and deployment to product documents and data analysis. Additionally, you can steer it mid-task without losing context. For web development, it better understands underspecified prompts and defaults to more functional, production-ready output.

该模型专为长时间运行的智能体（agentic）任务而设计，可覆盖完整软件生命周期中的各类工作——从调试、部署，到产品文档编写与数据分析；支持研究探索、工具调用及多步骤执行。此外，您可在任务执行中途动态调整指令，而不会丢失上下文。在网页开发场景中，它对描述模糊（underspecified）的提示理解更准确，并默认生成更实用、更符合生产环境要求的输出。

To use this model, set model to `openai/gpt-5.3-codex` in the AI SDK.

如需使用该模型，请在 AI SDK 中将 `model` 参数设为 `openai/gpt-5.3-codex`。

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5.3-codex',

5  prompt:

6    `Research our current API architecture, identify performance
```

7     bottlenecks, refactor the slow endpoints, add monitoring,

7     瓶颈，重构响应缓慢的端点，添加监控，

8     and deploy the changes to staging.`,

8     并将这些变更部署到预发布环境。`,

9});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/observability/ai-sdk-observability), [Bring Your Own Key](https://vercel.com/docs/ai-gateway#bring-your-own-key) support, and intelligent provider routing with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于服务商自身可用性的运行时长。它内置了[可观测性](https://vercel.com/docs/observability/ai-sdk-observability)能力、[自带密钥（Bring Your Own Key）](https://vercel.com/docs/ai-gateway#bring-your-own-key)支持，以及具备自动重试功能的智能服务商路由。

Learn more about [AI Gateway](https://vercel.com/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.3-codex).

了解更多关于 [AI Gateway](https://vercel.com/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/gpt-5.3-codex) 中亲自体验。
{% endraw %}
