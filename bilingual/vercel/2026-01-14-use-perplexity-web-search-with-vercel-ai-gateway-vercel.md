---
title: "Use Perplexity Web Search with Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/use-perplexity-web-search-with-vercel-ai-gateway"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:48.515554117+00:00"
language: "en-zh"
translated: true
description: "Vercel AI Gateway now supports Perplexity Web Search as a model-agnostic tool that works for all models and providers. Use the tool to get access to the most recent information to supplement your AI q..."
---

Jan 14, 2026

2026 年 1 月 14 日

模型功能强大，但受限于其训练数据和知识截止日期。当用户询问今日新闻、当前价格或最新 API 变更时，模型可能提供过时信息，或直接承认自己“不知道”。

AI Gateway 上的**与供应商无关的网页搜索（provider-agnostic web search）** 改变了这一现状。只需一行代码，您即可赋予任意模型实时联网搜索的能力。该功能兼容 OpenAI、Anthropic、Google，以及 AI Gateway 支持的所有其他服务商。

## 工作原理

## 实现原理

要通过 AI SDK 使用与供应商无关的搜索功能，请从 `@ai-sdk/gateway` 导入 `gateway.tools.perplexitySearch()`，并将其作为名为 `perplexity_search` 的工具传入模型的 `tools` 参数中。当模型判断需要获取最新信息时，便会自动执行网络搜索，并将检索结果整合进最终响应。

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';



const result = streamText({

5  model: 'minimax/minimax-m2.1',

6  prompt: 'What were the major tech announcements this week?',

6  提示词：“本周有哪些重大的科技发布？”

7  tools: {

7  工具：{

8    perplexity_search: gateway.tools.perplexitySearch(),

8    perplexity_search: gateway.tools.perplexitySearch(),

9  },

9  },

10});

10});

## Use cases

## 使用场景

### Models without native search

### 不具备原生搜索能力的模型

Many capable models don't include built-in web search. Perplexity search adds this capability to any model available through AI Gateway.

许多功能强大的模型并未内置网页搜索能力。Perplexity 搜索可为 AI Gateway 所支持的任意模型增添这一能力。

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';
```

```javascript
const result = streamText({

5  model: 'zai/glm-4.7', // 无原生搜索功能，但可使用 Perplexity

6  prompt: 'React 19.2 版本新增了哪些功能？',

7  tools: {

8    perplexity_search: gateway.tools.perplexitySearch(),

9  },

10});
```

### 开发者工具与 CI 助手

当代码助手了解当前的软件包版本、最近合并的 PR、发布说明以及文档更新时，其作用将显著提升。过时的信息会导致构建失败和安全问题。

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';



const result = streamText({

5  model: 'anthropic/claude-sonnet-4.5',

5  模型：'anthropic/claude-sonnet-4.5',

6  prompt: 'What is the latest stable version of Next.js and what breaking changes should I know about?',

6  提示词：'Next.js 最新的稳定版本是什么？有哪些需要注意的破坏性变更？',

7  tools: {

7  工具：{

8    perplexity_search: gateway.tools.perplexitySearch(),

8    perplexity_search: gateway.tools.perplexitySearch(),

9  },

9  },

10});
```

### Provider-agnostic chatbot

### 与供应商无关的聊天机器人

Production chatbots often need to work across multiple models for cost optimization, failover, or A/B testing. Native search tools differ between providers, but Perplexity search works identically regardless of which model you use.

生产环境中的聊天机器人通常需要在多个模型之间切换，以实现成本优化、故障转移或 A/B 测试。不同供应商提供的原生搜索工具各不相同，但 Perplexity 搜索无论搭配哪个模型，其行为都完全一致。

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';



const models = ['openai/gpt-5.2', 'anthropic/claude-sonnet-4.5', 'zai/glm-4.7'];



const result = streamText({

7  model: models[selectedIndex], // Same search logic works across any model

8  prompt: 'What is the current status of the OpenAI API?',
```

9  tools: {

10    perplexity_search: gateway.tools.perplexitySearch({

11      searchDomainFilter: ['status.openai.com', 'openai.com'],

12      searchRecencyFilter: 'day',

13    }),

14  },

15});
```

### Operational and market-aware agents

### 面向运维与市场感知的智能体

Agents that monitor pricing changes, service outages, job postings, or social announcements need near real-time information to be useful. Web search keeps them current without manual data pipelines.

需要监控价格变动、服务中断、职位发布或社交媒体公告的智能体，必须依赖近实时信息才能发挥实际效用。网络搜索使它们始终保持最新状态，而无需依赖人工构建的数据管道。

```typescript
import { streamText } from 'ai';

```typescript
import { gateway } from '@ai-sdk/gateway';



const result = streamText({

5  model: 'openai/gpt-5.2',

5  模型：'openai/gpt-5.2',

6  prompt: 'Are there any ongoing incidents affecting Vercel or AWS us-east-1?',

6  提示词：'当前是否有影响 Vercel 或 AWS us-east-1 区域的进行中事件？',

7  tools: {

7  工具：{

8    perplexity_search: gateway.tools.perplexitySearch({

8    perplexity_search: gateway.tools.perplexitySearch({

9      searchDomainFilter: ['status.vercel.com', 'health.aws.amazon.com'],

9      searchDomainFilter: ['status.vercel.com', 'health.aws.amazon.com'],

10      searchRecencyFilter: 'day',

10      searchRecencyFilter: 'day',

11    }),

11    }),
```

12  },

13});
```

## Provider-specific tools

## 供应商专属工具

AI Gateway 还支持 Anthropic、OpenAI 和 Google 提供的原生网页搜索功能。这些针对特定供应商的工具专为其各自模型优化，可能提供额外功能。

当您希望在不同模型间保持一致的搜索行为，或所用模型的供应商未提供原生网页搜索功能时，请使用 Perplexity。

有关所有可用选项的详细信息，请参阅 [网页搜索文档](https://vercel.com/docs/ai-gateway/web-search)。

## Pricing

## 定价

在 AI Gateway 中，Perplexity 网页搜索请求按每 1,000 次请求 $5 收费。此类请求不加收任何附加费用。更多详情请参阅 [Perplexity 官方定价页面](https://docs.perplexity.ai/getting-started/pricing)。

## Get started

## 开始使用

立即为您的 AI 应用添加实时网页搜索功能：

- [Web search documentation](https://vercel.com/docs/ai-gateway/web-search)

- [Web 搜索文档](https://vercel.com/docs/ai-gateway/web-search)

- [AI Gateway](https://vercel.com/ai-gateway)

- [AI 网关](https://vercel.com/ai-gateway)