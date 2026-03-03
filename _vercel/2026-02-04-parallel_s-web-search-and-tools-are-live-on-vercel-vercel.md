---
title: "Parallel's Web Search and tools are live on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/parallel-web-search-is-now-on-ai-gateway"
date: "2026-02-04"
scraped_at: "2026-03-02T09:21:37.003751655+00:00"
language: "en-zh"
translated: true
description: "Parallel's Web Search and other tools are now available on Vercel AI Gateway, AI SDK, and Marketplace. Add web search to any model with domain filtering, date constraints, and agentic mode support."
---

Feb 4, 2026

2026 年 2 月 4 日

You can now use [Parallel's](https://parallel.ai/) LLM-optimized web search and other tools all across Vercel.

您现在可以在整个 Vercel 平台上使用 [Parallel](https://parallel.ai/) 针对大语言模型（LLM）优化的网络搜索及其他工具。

## AI Gateway

## AI 网关

Unlike provider-specific web search tools that only work with certain models, Parallel's web search tool works universally across all providers. This means you can add web search capabilities to any model without changing your implementation.

与仅适配特定模型的、厂商专属的网络搜索工具不同，Parallel 的网络搜索工具可跨所有模型提供商通用。这意味着您无需修改现有实现，即可为任意模型添加网络搜索能力。

To use through AI SDK, set `parallel_search: gateway.tools.parallelSearch()` in `tools.`

若通过 AI SDK 使用，请在 `tools` 中设置 `parallel_search: gateway.tools.parallelSearch()`。

```tsx
import { gateway, streamText } from 'ai';



const result = streamText({

4  model: 'moonshotai/kimi-k2.5', // Works with any model

5  prompt: 'What are the best new restaurants in San Francisco?',
```

6  tools: {

6  工具：{

7    parallel_search: gateway.tools.parallelSearch(),

7    parallel_search: gateway.tools.parallelSearch(),

8  },

8  },

9});

9});

```

Parallel web search extracts relevant excerpts from web pages, making it ideal for agentic tasks and real-time information retrieval. For more control, you can also configure the tool to use specific parameters.

```

并行网页搜索（Parallel web search）从网页中提取相关片段，非常适合代理型任务（agentic tasks）和实时信息检索。如需更精细的控制，您还可以为该工具配置特定参数。

```tsx
import { gateway, streamText } from 'ai';



const result = streamText({

4  model: 'moonshotai/kimi-k2.5',

4  模型：'moonshotai/kimi-k2.5',

5  prompt: 'What new AI model releases have been announced this month?',

5  提示词（prompt）：'本月有哪些新的 AI 模型发布？',

6  tools: {

6  工具：{

7    parallel_search: gateway.tools.parallelSearch({

7    parallel_search: gateway.tools.parallelSearch({

8      mode: 'one-shot',

8      mode: '单次执行',

9      maxResults: 10,

9      maxResults: 10,

10      sourcePolicy: {

10      sourcePolicy: {

11        includeDomains: [\
\
11        includeDomains: [\
\
12          'openai.com',\
\
12          'openai.com',\
\
13          'anthropic.com',\
\
13          'anthropic.com',\
\
14          'deepseek.com',\
\
14          'deepseek.com',\
\
15          'moonshot.ai',\
\
15          'moonshot.ai',\
\
16          'deepmind.google',\
\
16          'deepmind.google',\
\
17        ],

17        ],

18        afterDate: '2026-01-01',

18        afterDate: '2026-01-01',

19      },

19      },

20    }),

20    }),

21  },

21  },

22});
```

对于智能体工作流（agentic workflows），请使用 `mode: 'agentic'` 参数，以获得简洁、令牌效率高（token-efficient）的搜索结果，该模式特别适用于多步推理场景。

对时效性要求较高的查询，可通过 `maxAgeSeconds` 参数控制缓存的新鲜度；而面向特定领域的搜索，则允许您将结果限定于可信信源，或排除噪声较大的域名。

并行网页搜索请求（Parallel web search requests）的计费标准与 Parallel API 完全一致：每 1,000 次请求收费 5 美元（每次请求最多返回 10 条结果）；超出 10 条后的每额外 1,000 条结果，加收 1 美元。更多详情及工具使用方法，请参阅 [文档](https://vercel.com/docs/ai-gateway/capabilities/web-search#using-parallel-search)。

## AI SDK

AI SDK 将 Parallel 支持为一项工具，可用于网页搜索（web search）和内容提取（extraction）。使用前，只需安装 `parallel-web` 工具包即可。

```tsx
pnpm install @parallel-web/ai-sdk-tools
```

有关如何使用这些工具的更多详细信息，请参阅 [文档](https://ai-sdk.dev/tools-registry/parallel)。

## Vercel Marketplace

您可在 [Vercel Agent Marketplace](https://vercel.com/marketplace/category/agents) 中一站式使用 Parallel 全系列产品：Search（搜索）、Extract（提取）、Task（任务）、Findall（全量查找）以及 Monitoring（监控），所有服务均通过 Vercel 统一计费，并仅需一个 API 密钥即可接入。  
快速入门：请前往 [Parallel 集成页面](https://vercel.com/marketplace/parallel)，连接您的账户；或直接部署 [Next.js 模板](https://vercel.com/templates/template/next-js-parallel-starter)，在 Vercel 环境中实战集成 Parallel 的网页研究（web research）API。

Get started with Parallel for your AI applications through AI Gateway, the AI SDK tool package, or Vercel Marketplace.

通过 AI Gateway、AI SDK 工具包或 Vercel Marketplace，开始在您的 AI 应用中使用 Parallel。