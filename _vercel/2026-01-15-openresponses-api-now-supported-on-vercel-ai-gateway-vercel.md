---
title: "OpenResponses API now supported on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openresponses-api-now-supported-on-vercel-ai-gateway"
date: "2026-01-15"
scraped_at: "2026-03-02T09:22:44.104868753+00:00"
language: "en-zh"
translated: true
description: "Use the OpenResponses API on Vercel AI Gateway with no other API keys required and support for multiple providers."
---
{% raw %}

Jan 15, 2026

2026 年 1 月 15 日

Vercel AI Gateway 是 OpenResponses API 的首发日（Day 0）上线合作伙伴。OpenResponses API 是 OpenAI 推出的开源规范，旨在支持跨多个 AI 服务提供商的统一交互。

OpenResponses 为文本生成、流式响应、工具调用、图像输入以及推理能力等场景，提供了面向不同服务商的统一接口。

**AI Gateway 已支持 OpenResponses 的以下功能：**

**文本生成：** 向任意受支持的模型发送消息并接收响应。

- **Text generation:** Send messages and receive responses from any supported model.

**流式响应：** 通过服务器发送事件（Server-Sent Events, SSE）实时接收逐个生成的 token。

- **Streaming:** Receive tokens as they're generated via server-sent events.

**工具调用：** 定义函数供模型以结构化参数调用。

- **Tool calling:** Define functions that models can invoke with structured arguments.

**图像输入：** 将图像与文本一同发送，供具备视觉能力的模型处理。

- **Image input:** Send images alongside text for vision-capable models.

**推理能力：** 支持可配置努力程度（effort level）的扩展式推理。

- **Reasoning:** Enable extended thinking with configurable effort levels.

**服务商回退机制：** 配置跨模型与跨服务商的自动回退链路。

- **Provider fallbacks:** Configure automatic fallback chains across models and providers.

Use OpenResponses with your AI Gateway key, and switch models across providers by changing the model string.

使用您的 AI Gateway 密钥调用 OpenResponses，并通过修改模型字符串在不同提供商之间切换模型。

```typescript
const response = await fetch('https://ai-gateway.vercel.sh/v1/responses', {

2  method: 'POST',

3  headers: {

4    'Content-Type': 'application/json',

5    Authorization: `Bearer ${process.env.VERCEL_AI_GATEWAY_KEY}`,

6  },

7  body: JSON.stringify({

8    model: 'anthropic/claude-sonnet-4.5',

9    input: [\
\
10      {\
\
11        type: 'message',\
\
12        role: 'user',\
\
13        content: 'Explain quantum computing in one sentence.',\
\
14      }\
\
15    ],

16  }),

17});
```

16  }),

17});
```

You can also use OpenResponses for more complex cases, like tool calling.

您也可以在更复杂的场景（例如工具调用）中使用 OpenResponses。

```typescript
const response = await fetch('https://ai-gateway.vercel.sh/v1/responses', {

2  method: 'POST',

3  headers: {

4    'Content-Type': 'application/json',

5    Authorization: `Bearer ${process.env.VERCEL_AI_GATEWAY_KEY}`,

6  },

7  body: JSON.stringify({

8    model: 'zai/glm-4.7',

8    模型：'zai/glm-4.7',

9    input: [{ type: 'message', role: 'user', content: 'What is the weather in SF?' }],

9    输入：[{ type: 'message', role: 'user', content: '旧金山的天气如何？' }],

10    tools: [{\
\
10    工具：[{\
\
11      type: 'function',\
\
11      类型：'function',\
\
12      name: 'get_weather',\
\
12      名称：'get_weather',\
\
13      description: 'Get current weather for a location',\
\
13      描述：'获取指定地点的当前天气',\
\
14      parameters: {\
\
14      参数：{\
\
15        type: 'object',\
\
15        类型：'object',\
\
16        properties: { location: { type: 'string' } },\
\
16        属性：{ location: { 类型：'string' } },\
\
17        required: ['location'],\
\
17        必填项：['location'],\
\
18      },\
\
18      },\
\
19    }],

19    }],

20  }),

20  }),

21});

21});

Read the [OpenResponses API documentation](https://vercel.com/docs/ai-gateway/openresponses) or [view the specification](https://www.openresponses.org/specification).

请阅读 [OpenResponses API 文档](https://vercel.com/docs/ai-gateway/openresponses)，或 [查看规范说明](https://www.openresponses.org/specification)。
{% endraw %}
