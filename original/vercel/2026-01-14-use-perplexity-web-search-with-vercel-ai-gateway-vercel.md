---
title: "Use Perplexity Web Search with Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/use-perplexity-web-search-with-vercel-ai-gateway"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:48.515554117+00:00"
language: "en"
translated: false
description: "Vercel AI Gateway now supports Perplexity Web Search as a model-agnostic tool that works for all models and providers. Use the tool to get access to the most recent information to supplement your AI q..."
---




Jan 14, 2026

Models are powerful, but they're limited to their training data and knowledge cutoff date. When users ask about today's news, current prices, or the latest API changes, models can offer outdated information or admit they don't know.

Provider-agnostic web search on AI Gateway changes this. With a single line of code, you can give any model the ability to search the web in real-time. It works with OpenAI, Anthropic, Google, and every other provider available through AI Gateway.

## How it works

To use provider-agnostic search with the AI SDK, import `gateway.tools.perplexitySearch()` from `@ai-sdk/gateway` and pass it in the tools parameter as `perplexity_search` to any model. When the model determines it needs current information, it automatically searches the web and incorporates the results into its response.

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';



const result = streamText({

5  model: 'minimax/minimax-m2.1',

6  prompt: 'What were the major tech announcements this week?',

7  tools: {

8    perplexity_search: gateway.tools.perplexitySearch(),

9  },

10});
```

## Use cases

### Models without native search

Many capable models don't include built-in web search. Perplexity search adds this capability to any model available through AI Gateway.

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';



const result = streamText({

5  model: 'zai/glm-4.7', // No native search, but Perplexity works

6  prompt: 'What new features were added in React 19.2?',

7  tools: {

8    perplexity_search: gateway.tools.perplexitySearch(),

9  },

10});
```

### Developer tooling and CI assistants

Code assistants are more useful when they know about current package versions, recently merged PRs, release notes, and documentation updates. Stale information leads to broken builds and security issues.

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';



const result = streamText({

5  model: 'anthropic/claude-sonnet-4.5',

6  prompt: 'What is the latest stable version of Next.js and what breaking changes should I know about?',

7  tools: {

8    perplexity_search: gateway.tools.perplexitySearch(),

9  },

10});
```

### Provider-agnostic chatbot

Production chatbots often need to work across multiple models for cost optimization, failover, or A/B testing. Native search tools differ between providers, but Perplexity search works identically regardless of which model you use.

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';



const models = ['openai/gpt-5.2', 'anthropic/claude-sonnet-4.5', 'zai/glm-4.7'];



const result = streamText({

7  model: models[selectedIndex], // Same search logic works across any model

8  prompt: 'What is the current status of the OpenAI API?',

9  tools: {

10    perplexity_search: gateway.tools.perplexitySearch({

11      searchDomainFilter: ['status.openai.com', 'openai.com'],

12      searchRecencyFilter: 'day',

13    }),

14  },

15});
```

### Operational and market-aware agents

Agents that monitor pricing changes, service outages, job postings, or social announcements need near real-time information to be useful. Web search keeps them current without manual data pipelines.

```typescript
import { streamText } from 'ai';

import { gateway } from '@ai-sdk/gateway';



const result = streamText({

5  model: 'openai/gpt-5.2',

6  prompt: 'Are there any ongoing incidents affecting Vercel or AWS us-east-1?',

7  tools: {

8    perplexity_search: gateway.tools.perplexitySearch({

9      searchDomainFilter: ['status.vercel.com', 'health.aws.amazon.com'],

10      searchRecencyFilter: 'day',

11    }),

12  },

13});
```

## Provider-specific tools

AI Gateway also supports native web search from Anthropic, OpenAI, and Google. These provider-specific tools are optimized for their respective models and may offer additional features.

Use Perplexity when you want consistent search behavior across different models, or when your model's provider doesn't offer native web search.

See the [web search docs](https://vercel.com/docs/ai-gateway/web-search) for details on all available options.

## Pricing

Perplexity web search requests are charged at $5 per 1,000 requests in AI Gateway. There is no markup on these requests. See [Perplexity's pricing](https://docs.perplexity.ai/getting-started/pricing) for more details.

## Get started

Add real-time web search to your AI application today:

- [Web search documentation](https://vercel.com/docs/ai-gateway/web-search)

- [AI Gateway](https://vercel.com/ai-gateway)