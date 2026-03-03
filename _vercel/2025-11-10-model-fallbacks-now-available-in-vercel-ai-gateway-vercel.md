---
title: "Model fallbacks now available in Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/model-fallbacks-now-available-in-vercel-ai-gateway"
date: "2025-11-10"
scraped_at: "2026-03-02T09:25:40.124464861+00:00"
language: "en-zh"
translated: true
description: "Model fallbacks now supported in Vercel AI Gateway in addition to provider routing, giving you failover options when models fail or are unavailable."
---

Nov 10, 2025

2025 年 11 月 10 日

Vercel 的 [AI Gateway](https://vercel.com/ai-gateway) 现已支持 [后备模型（fallback models）](https://vercel.com/docs/ai-gateway/provider-options#model-fallbacks-with-the-models-option)，即当主模型调用失败或不可用时，自动切换至备用模型。除可防范服务商层面的故障外，模型后备机制还能有效应对各类模型错误及能力不匹配问题（例如多模态支持、工具调用等能力差异）。

后备模型将严格按指定顺序依次尝试，直至某次请求成功，或所有后备选项均已耗尽。任何错误（如上下文长度超限、输入格式不被支持、服务商服务中断等）均会触发后备机制。计费以最终成功完成请求的模型为准。

以下示例展示了一种典型场景：主模型不支持多模态能力，因此自动回退至支持多模态的后备模型。使用时，需在 `providerOptions` 的 `models` 字段中声明后备模型列表：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-oss-120b', // 主模型

5  prompt: 'Parse the attached PDF for tables and graphs, \

6  and return the highest performing categories this year',

7  providerOptions: {

8    gateway: {

9      models: [\
\
10        'google/gemini-2.5-pro',\
\
11        'anthropic/claude-sonnet-4.5',\
\
12        'meta/llama-3.1-8b'\
\
13      ], // 回退模型（Fallback models）

14    },

15  },

16})
```

若需在模型路由之外，额外配置预定义的提供商路由（provider routing），请在 `providerOptions` 中同时指定 `models` 和提供商配置（`order` 或 `only`）：

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5-nano', // 主模型

4  model: 'openai/gpt-5-nano', // Primary model

5  prompt: 'Parse the attached PDF for tables and graphs, \

5  prompt: 'Parse the attached PDF for tables and graphs, \

6  and return the highest performing categories this year',

6  and return the highest performing categories this year',

7  providerOptions: {

7  providerOptions: {

8    gateway: {

8    gateway: {

9      order: ['vertex', 'cerebras'], // 服务提供商路由顺序

9      order: ['vertex', 'cerebras'], // Provider routing order

10      models: [\
\
10      models: [\
\
11        'google/gemini-2.5-flash',\
\
11        'google/gemini-2.5-flash',\
\
12        'openai/gpt-oss-120b'\
\
12        'openai/gpt-oss-120b'\
\
13      ], // 备用模型

13      ], // Fallback models

14    },

14    },

15  },

15  },

16})

16})

AI Gateway also includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok), and supports [OpenAI-compatible API](https://vercel.com/docs/ai-gateway/openai-compat#model-fallbacks).

AI Gateway 还内置了 [可观测性（Observability）](https://vercel.com/docs/ai-gateway/observability)、[自带密钥（Bring Your Own Key，BYOK）支持](https://vercel.com/docs/ai-gateway#configuring-your-own-provider-keys-byok)，并支持 [OpenAI 兼容 API](https://vercel.com/docs/ai-gateway/openai-compat#model-fallbacks)。