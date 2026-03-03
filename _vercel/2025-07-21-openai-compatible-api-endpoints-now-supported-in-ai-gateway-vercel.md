---
title: "OpenAI-compatible API endpoints now supported in AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openai-compatible-api-endpoints-now-supported-in-ai-gateway"
date: "2025-07-21"
scraped_at: "2026-03-02T09:30:54.414153777+00:00"
language: "en-zh"
translated: true
description: "OpenAI-compatible API endpoints now supported in AI Gateway giving you access to 100s of models with no code rewrites required"
---

Jul 21, 2025

2025 年 7 月 21 日

You can now use OpenAI-compatible client libraries and tools with AI Gateway through a simple URL change, allowing you to access 100s of models with no code rewrites required.

您现在只需修改一个 URL，即可通过 AI Gateway 使用与 OpenAI 兼容的客户端库和工具，无需重写任何代码，即可访问数百种模型。

Here is a Python example with the OpenAI client library:

以下是使用 OpenAI 客户端库的 Python 示例：

```python
from openai import OpenAI



client = OpenAI(

4    api_key='my-ai-gateway-key',

5    base_url='https://ai-gateway.vercel.sh/v1'

6)
```

```python
stream = client.chat.completions.create(
    model='anthropic/claude-4-sonnet',
    messages=[
        {
            'role': 'user',
            'content': 'Write a one-sentence bedtime story about a unicorn.'
        }
    ],
    stream=True,
)
```

```python
流式响应初始化：
stream = client.chat.completions.create(
    model='anthropic/claude-4-sonnet',
    messages=[
        {
            'role': 'user',
            'content': '写一个关于独角兽的、仅含一句话的睡前故事。'
        }
    ],
    stream=True,
)
```

```python
for chunk in stream:
    content = chunk.choices[0].delta.content if chunk.choices[0].delta.content else None
    if content:
        print(content, end='', flush=True)
```

```python
遍历流式响应数据块：
for chunk in stream:
    content = chunk.choices[0].delta.content if chunk.choices[0].delta.content else None
    if content:
        print(content, end='', flush=True)
```

print()  
```  

This makes it easy to keep your current tools and workflows while improving uptime, tokens per minute, quotas, and reliability via provider failover and adding observability through the AI Gateway.  

这使得您能够轻松保留当前的工具和工作流，同时借助提供商故障转移（provider failover）提升正常运行时间、每分钟 Token 数、配额及可靠性，并通过 AI 网关增强可观测性（observability）。  

Learn more in the [AI Gateway docs](https://vercel.com/docs/ai-gateway/openai-compat) and see [more examples here](https://vercel.com/docs/ai-gateway/openai-compat#openai-client-libraries).  

更多详情，请参阅 [AI 网关文档](https://vercel.com/docs/ai-gateway/openai-compat)，并在此处查看 [更多示例](https://vercel.com/docs/ai-gateway/openai-compat#openai-client-libraries)。