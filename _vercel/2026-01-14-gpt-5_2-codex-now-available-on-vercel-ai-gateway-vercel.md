---
render_with_liquid: false
title: "GPT 5.2 Codex now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-2-codex-now-available-on-vercel-ai-gateway"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:46.964832117+00:00"
language: "en-zh"
translated: true
description: "You can now access the GPT 5.2 Codex model on Vercel's AI Gateway with no other provider accounts required."
---
render_with_liquid: false
render_with_liquid: false

Jan 14, 2026

2026 年 1 月 14 日

You can now access GPT 5.2 Codex with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required. GPT 5.2 Codex combines GPT 5.2's strength in professional knowledge work with GPT 5.1 Codex Max's agentic coding capabilities.

现在，您可通过 Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 直接访问 GPT 5.2 Codex，无需注册其他服务商账号。GPT 5.2 Codex 融合了 GPT 5.2 在专业知识工作方面的优势，以及 GPT 5.1 Codex Max 所具备的智能体式（agentic）编程能力。

GPT 5.2 Codex is better at working on long running coding tasks compared to predecessors and can handle more complex tasks like large refactors and migrations more reliably. The model has stronger vision performance for more accurate processing of screenshots and charts that are shared while coding. GPT 5.2 Codex also surpasses GPT 5.1 Codex Max in cyber capabilities and outperformed the previous model in OpenAI's Professional Capture-the-Flag (CTF) cybersecurity eval.

相较于前代模型，GPT 5.2 Codex 更擅长处理耗时较长的编程任务，能更可靠地完成大型代码重构与系统迁移等更复杂的任务。该模型在视觉理解方面性能更强，可更精准地解析编程过程中共享的截图与图表。此外，GPT 5.2 Codex 在网络安全能力上也超越了 GPT 5.1 Codex Max，并在 OpenAI 举办的“专业级夺旗赛”（Professional Capture-the-Flag, CTF）网络安全评测中表现优于前代模型。

To use the GPT 5.2 Codex, with the [AI SDK](https://ai-sdk.dev/), set the model to `openai/gpt-5.2-codex`:

如需使用 GPT 5.2 Codex，请配合 [AI SDK](https://ai-sdk.dev/)，将模型参数设为 `openai/gpt-5.2-codex`：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5.2-codex',

5  prompt:

6    `Take the attached prototypes, diagram, and reference screenshots
```

7     to build a production app for customer analytics dashboards.`

7     用于构建面向客户分析仪表板的生产级应用。`

8});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

AI Gateway 提供统一的 API，用于调用模型、追踪用量与成本，并配置重试、故障转移及性能优化策略，从而实现高于模型提供商自身水平的可用性。它内置了[可观测性](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（BYOK）支持](https://vercel.com/docs/ai-gateway/byok)，以及具备自动重试能力的智能[供应商路由](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.2-codex).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息，查看 [AI Gateway 模型排行榜](https://vercel.com/ai-gateway/leaderboards)，或在我们的 [模型游乐场](https://vercel.com/ai-gateway/models/gpt-5.2-codex) 中亲自体验。

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)

[**AI Gateway：按使用量追踪顶级 AI 模型**\\
\\
AI Gateway 模型排行榜依据所有经由网关的流量所产生的总 Token 量，对各模型的历史使用频次进行排序。榜单定期更新。\\
\\
查看排行榜](https://vercel.com/ai-gateway/leaderboards)