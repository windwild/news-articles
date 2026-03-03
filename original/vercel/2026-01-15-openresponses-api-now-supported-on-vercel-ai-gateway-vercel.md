---
title: "OpenResponses API now supported on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openresponses-api-now-supported-on-vercel-ai-gateway"
date: "2026-01-15"
scraped_at: "2026-03-02T09:22:44.104868753+00:00"
language: "en"
translated: false
description: "Use the OpenResponses API on Vercel AI Gateway with no other API keys required and support for multiple providers."
---




Jan 15, 2026

Vercel AI Gateway is a day 0 launch partner for the OpenResponses API, an open-source specification from OpenAI for multi-provider AI interactions.

OpenResponses provides a unified interface for text generation, streaming, tool calling, image input, and reasoning across providers.

**AI Gateway supports OpenResponses for:**

- **Text generation:** Send messages and receive responses from any supported model.

- **Streaming:** Receive tokens as they're generated via server-sent events.

- **Tool calling:** Define functions that models can invoke with structured arguments.

- **Image input:** Send images alongside text for vision-capable models.

- **Reasoning:** Enable extended thinking with configurable effort levels.

- **Provider fallbacks:** Configure automatic fallback chains across models and providers.


Use OpenResponses with your AI Gateway key, and switch models across providers by changing the model string.

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

You can also use OpenResponses for more complex cases, like tool calling.

```typescript
const response = await fetch('https://ai-gateway.vercel.sh/v1/responses', {

2  method: 'POST',

3  headers: {

4    'Content-Type': 'application/json',

5    Authorization: `Bearer ${process.env.VERCEL_AI_GATEWAY_KEY}`,

6  },

7  body: JSON.stringify({

8    model: 'zai/glm-4.7',

9    input: [{ type: 'message', role: 'user', content: 'What is the weather in SF?' }],

10    tools: [{\
\
11      type: 'function',\
\
12      name: 'get_weather',\
\
13      description: 'Get current weather for a location',\
\
14      parameters: {\
\
15        type: 'object',\
\
16        properties: { location: { type: 'string' } },\
\
17        required: ['location'],\
\
18      },\
\
19    }],

20  }),

21});
```

Read the [OpenResponses API documentation](https://vercel.com/docs/ai-gateway/openresponses) or [view the specification](https://www.openresponses.org/specification).