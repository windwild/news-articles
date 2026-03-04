---
title: "Vercel collaborates with Google for Gemini 3 Pro Preview launch - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-collaborates-with-google-for-gemini-3-pro-launch"
date: "2025-11-18"
scraped_at: "2026-03-02T09:25:36.728660676+00:00"
language: "en-zh"
translated: true
description: "The Gemini 3 Pro Preview model, released today, is now available through AI Gateway and in production on v0.app."
---
{% raw %}

Nov 18, 2025

2025 年 11 月 18 日

The Gemini 3 Pro Preview model, released today, is now available through the [Vercel AI Gateway](https://vercel.com/ai-gateway) and on [v0.app](https://v0.dev/). Thanks to Google, Vercel has been testing Gemini 3 Pro Preview across v0, Next.js, AI SDK, and Vercel Sandbox over the past several weeks.

今日发布的 Gemini 3 Pro Preview 模型现已可通过 [Vercel AI 网关](https://vercel.com/ai-gateway) 及 [v0.app](https://v0.dev/) 使用。感谢 Google 的支持，Vercel 过去数周已在 v0、Next.js、AI SDK 和 Vercel Sandbox 等多个平台对 Gemini 3 Pro Preview 进行了全面测试。

We've noticed the model has an increased focus on coding, multimodal reasoning, and tool use, though it's seen improvements across the board.

我们观察到，该模型在编程能力、多模态推理及工具调用方面显著增强；同时，其整体性能亦获得全面提升。

From our testing, Gemini 3 Pro Preview delivers substantial improvements in instruction following and response consistency. It shows almost a 17% increase in correctness over its predecessor on our [Next.js evals](https://nextjs.org/evals), putting in the top 2 models on the leaderboard.

根据我们的测试，Gemini 3 Pro Preview 在指令遵循能力与响应一致性方面实现了显著提升。在我们的 [Next.js 评测基准](https://nextjs.org/evals) 中，其正确率相较前代模型提升了近 17%，稳居评测排行榜前两名。

### How we're using Gemini 3 Pro Preview at Vercel

### Vercel 如何使用 Gemini 3 Pro Preview

In Vercel’s Next.js evals, Gemini 3 Pro Preview, tied with `openai/gpt-5-codex` at a 42% success rate, surpassing `anthropic/claude-opus-4.1`, `zai/glm-4.6`, `moonshotai/kimi-k2-turbo`, and others in consistency and reasoning quality.

在 Vercel 的 Next.js 评测中，Gemini 3 Pro Preview 以 42% 的成功率与 `openai/gpt-5-codex` 并列第一，在响应一致性与推理质量方面超越了 `anthropic/claude-opus-4.1`、`zai/glm-4.6`、`moonshotai/kimi-k2-turbo` 等其他模型。

|     |     |     |     |     |
| --- | --- | --- | --- | --- |
| Model | Total Evals | Success Rate | Avg Duration | Total Tokens |
| `openai/gpt-5-codex` | 50 | 42% | 42.80s | 186,082 |
| `google/gemini-3-pro-preview` | 50 | **42%** | **44.85s** | **309,263** |
| `zai/glm-4.6` | 50 | 40% | 20.36s | 106,177 |
| `anthropic/claude-opus-4.1` | 50 | 40% | 29.47s | 165,810 |
| `moonshotai/kimi-k2-turbo` | 50 | 38% | 4.13s | 82,567 |

| 模型 | 总评测次数 | 成功率 | 平均耗时 | 总 Token 数 |
| --- | --- | --- | --- | --- |
| `openai/gpt-5-codex` | 50 | 42% | 42.80 秒 | 186,082 |
| `google/gemini-3-pro-preview` | 50 | **42%** | **44.85 秒** | **309,263** |
| `zai/glm-4.6` | 50 | 40% | 20.36 秒 | 106,177 |
| `anthropic/claude-opus-4.1` | 50 | 40% | 29.47 秒 | 165,810 |
| `moonshotai/kimi-k2-turbo` | 50 | 38% | 4.13 秒 | 82,567 |

Gemini 3 Pro Preview stands out in frontend generation and multi-turn agent flows. It follows developer-level prompts with high precision, producing stable, well-structured UI components. The 1M context window helped it maintain fidelity across long generation chains. In our tests with v0, we’ve seen improved generation speed and quality.

Gemini 3 Pro Preview 在前端代码生成与多轮对话智能体（multi-turn agent）流程中表现尤为突出。它能高精度地理解并执行面向开发者的复杂提示词，稳定输出结构良好、可直接使用的 UI 组件。其高达 100 万 Token 的上下文窗口，有效保障了长链生成任务中的语义连贯性与内容保真度。在 v0 的实际测试中，我们已观察到其生成速度与输出质量均有明显提升。

### See for yourself

### 亲身体验

You can now try Gemini 3 Pro Preview in several places, instantly:

您现在即可在多个平台即时体验 Gemini 3 Pro Preview：

Try Gemini 3 Pro Preview on [AI Gateway Playground](https://vercel.com/ai-gateway/models/gemini-3-pro-preview) instantly, no setup required. This model, and every model available through Gateway, can be tested instantly with a simple chat interface.

立即在 [AI Gateway Playground](https://vercel.com/ai-gateway/models/gemini-3-pro-preview) 中试用 Gemini 3 Pro Preview，无需任何配置。该模型以及所有通过 AI Gateway 提供的模型，均可通过一个简洁的聊天界面即时体验。

From there, copy the model string, paste it into AI SDK, and start building with the same high-performance infrastructure that powers production apps like v0.

随后，复制模型字符串，将其粘贴至 AI SDK 中，即可开始构建应用——所用基础设施与 v0 等生产级应用完全相同，具备高性能保障。

You can also try it out in the [AI SDK playground](https://ai-sdk.dev/playground) to compare outputs against other models.

您还可前往 [AI SDK Playground](https://ai-sdk.dev/playground) 试用该模型，并与其他模型的输出结果进行对比。

Gemini 3 Pro Preview is available today on [AI Gateway](https://vercel.com/ai-gateway), with support for both Google AI Studio and Google Vertex AI. Developers can compare it alongside other models on Gateway with no code changes.

Gemini 3 Pro Preview 即日起已在 [AI Gateway](https://vercel.com/ai-gateway) 上线，全面支持 Google AI Studio 与 Google Vertex AI。开发者可在 Gateway 平台上直接将该模型与其他模型并列对比，全程无需修改任何代码。

```typescript
import { streamText } from 'ai'



const result = streamText({

4  model: "google/gemini-3-pro-preview",

5  prompt: "Create a neural fluid engine simulation in a self-contained HTML"

6});
```

Gemini 3 Pro Preview is also available in [v0’s model selector](https://v0.app/). It’s noticeably faster and more detail-oriented than the original models, making it ideal for frontend and multi-step AI agents.

Gemini 3 Pro 预览版也已在 [v0 的模型选择器](https://v0.app/) 中上线。相比原始模型，其响应速度明显更快、细节处理更精细，非常适用于前端开发及多步骤 AI 智能体。

### Use AI SDK and AI Gateway to build your own

### 使用 AI SDK 和 AI Gateway 构建您自己的应用

You can also build your own custom interface using your framework of choice, [AI SDK](https://ai-sdk.dev/), and [AI Gateway](https://vercel.com/ai-gateway) with the same deployment-aware infrastructure and security stack that powers apps running on Vercel today.

您还可以基于自己偏好的框架，结合 [AI SDK](https://ai-sdk.dev/) 和 [AI Gateway](https://vercel.com/ai-gateway)，构建专属的定制化界面——所用基础设施具备部署感知能力，安全体系也与当前运行在 Vercel 上的应用完全一致。

[Vercel AI Cloud](https://vercel.com/ai) is built for developers shaping how software is created, including building with the technology that's at the forefront of AI like the latest models.

[Vercel AI Cloud](https://vercel.com/ai) 专为塑造软件开发方式的开发者而打造，涵盖使用处于 AI 前沿的最新技术（例如最新大模型）进行构建的各类场景。
{% endraw %}
