---
title: "OpenAI-compatible API endpoints now supported in AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openai-compatible-api-endpoints-now-supported-in-ai-gateway"
date: "2025-07-21"
scraped_at: "2026-03-02T09:30:54.414153777+00:00"
language: "en"
translated: false
description: "OpenAI-compatible API endpoints now supported in AI Gateway giving you access to 100s of models with no code rewrites required"
---




Jul 21, 2025

You can now use OpenAI-compatible client libraries and tools with AI Gateway through a simple URL change, allowing you to access 100s of models with no code rewrites required.

Here is a Python example with the OpenAI client library:

```python
from openai import OpenAI



client = OpenAI(

4    api_key='my-ai-gateway-key',

5    base_url='https://ai-gateway.vercel.sh/v1'

6)



stream = client.chat.completions.create(

9    model='anthropic/claude-4-sonnet',

10    messages=[\
\
11        {\
\
12            'role': 'user',\
\
13            'content': 'Write a one-sentence bedtime story about a unicorn.'\
\
14        }\
\
15    ],

16    stream=True,

17)



for chunk in stream:

20    content = chunk.choices[0].delta.content if chunk.choices[0].delta.content else None

21    if content:

22        print(content, end='', flush=True)

print()
```

This makes it easy to keep your current tools and workflows while improving uptime, tokens per minute, quotas, and reliability via provider failover and adding observability through the AI Gateway.

Learn more in the [AI Gateway docs](https://vercel.com/docs/ai-gateway/openai-compat) and see [more examples here](https://vercel.com/docs/ai-gateway/openai-compat#openai-client-libraries).