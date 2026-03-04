---
title: "Z.ai's GLM-4.5 and GLM-4.5 Air are now supported in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/z-ais-glm-4-5-and-glm-4-5-air-are-now-supported-in-vercel-ai-gateway"
date: "2025-07-29"
scraped_at: "2026-03-02T09:30:41.143520611+00:00"
language: "en-zh"
translated: true
description: "You can now access GLM-4.5 and GLM-4.5 Air, new flagship models from Z.ai designed to unify frontier reasoning, coding, and agentic capabilities, using Vercel's AI Gateway with no other provider accou..."
---
&#123;% raw %}

Jul 29, 2025

2025 年 7 月 29 日

You can now access [GLM-4.5 and GLM-4.5 Air](https://z.ai/blog/glm-4.5), new flagship models from [Z.ai](https://z.ai/) designed to unify frontier reasoning, coding, and agentic capabilities, using Vercel's [AI Gateway](https://vercel.com/docs/ai-gateway) with no other provider accounts required.

您现在可以访问 [Z.ai](https://z.ai/) 全新发布的旗舰模型 [GLM-4.5 和 GLM-4.5 Air](https://z.ai/blog/glm-4.5)，这些模型旨在统一前沿推理、编程与智能体（agentic）能力，并可通过 Vercel 的 [AI Gateway](https://vercel.com/docs/ai-gateway) 直接调用，无需额外注册其他服务商账号。

AI Gateway lets you call the model with a consistent unified API and just a single string update, track usage and cost, and configure performance optimizations, retries, and failover for higher than provider-average uptime.

AI Gateway 支持通过统一、一致的 API 调用模型，仅需修改一个字符串即可切换模型；同时支持用量与成本追踪，并可配置性能优化、重试机制及故障转移策略，从而实现高于服务商平均水平的系统可用性（uptime）。

To use it with the [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction), start by installing the package:

如需在 [AI SDK v5](https://v5.ai-sdk.dev/docs/introduction) 中使用该功能，请先安装对应包：

```bash
pnpm i ai
```

```bash
pnpm i ai
```

Then set the model to either `zai/glm-4.5` or `zai/glm-4.5-air`:

随后将模型设置为 `zai/glm-4.5` 或 `zai/glm-4.5-air`：

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "zai/glm-4.5", // or "zai/glm-4.5-air"
```

```tsx
import { streamText } from 'ai'



const result = streamText({

4  model: "zai/glm-4.5", // 或 "zai/glm-4.5-air"
```

5  prompt: "What is specifically notable about the style of Sonoran food?",

5  提示词：“索诺兰（Sonoran）美食的风格有何特别之处？”

6  providerOptions: {

6  提供商选项：{

7    zai: {

7    zai：{

8      thinking: {

8      思考模式：{

9        type: 'disabled',

9        类型：'已禁用',

10      },

10      },

11    },

11    },

12  }

12  }

13})

13})

```

Includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

内置 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key, BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，以及具备自动重试功能的智能 [提供商路由（Provider Routing）](https://vercel.com/docs/ai-gateway/provider-options)。

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway).

了解更多关于 [AI Gateway](https://vercel.com/docs/ai-gateway) 的信息。
&#123;% endraw %}
