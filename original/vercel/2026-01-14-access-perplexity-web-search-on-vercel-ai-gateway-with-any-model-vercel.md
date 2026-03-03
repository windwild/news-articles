---
title: "Access Perplexity Web Search on Vercel AI Gateway with any model - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/access-perplexity-web-search-on-vercel-ai-gateway-with-any-model"
date: "2026-01-14"
scraped_at: "2026-03-02T09:23:00.316598907+00:00"
language: "en"
translated: false
description: "You can use Perplexity web search with any model and any provider on Vercel AI Gateway to access real-time results and up-to-date information."
---




Jan 14, 2026

You can now give any model the ability to search the web using Perplexity through Vercel's AI Gateway.

AI Gateway supports Perplexity Search as a universal web search tool that works with all models, regardless of provider. Unlike native search tools that are exclusive to specific providers, Perplexity Search can be added to all models.

To use Perplexity Search with the AI SDK, import `gateway.tools.perplexitySearch()` from `@ai-sdk/gateway` and pass it in the tools parameter as `perplexity_search` to any model.

```typescript
import { generateText } from "ai"

import { gateway } from "@ai-sdk/gateway"



const result = await generateText({

5  model: "openai/gpt-5.2",

6  tools: {

7    perplexity_search: gateway.tools.perplexitySearch(),

8  },

9  prompt: "What changed in Next.js this week?",

10})



console.log(result.text)
```

Some example use cases include:

• **Models without native search:** Enable web search on models like `zai/glm-4.7` or any from any other providers that don't expose a built-in search tool.

```typescript
import { streamText } from "ai"

import { gateway } from "@ai-sdk/gateway"



const result = await streamText({

5  model: "zai/glm-4.7",

6  prompt:

7    "What are the latest AI safety guidelines " +

8    "published by major tech companies?",

9  tools: {

10    perplexity_search: gateway.tools.perplexitySearch({

11      maxResults: 5,

12      searchRecencyFilter: "month",

13      searchLanguageFilter: ["en"],

14    }),

15  },

16})
```

• **Developer tooling and CI assistants:** Get current package versions, recently merged PRs, release notes, or docs updates.

```typescript
import { generateText } from "ai"

import { gateway } from "@ai-sdk/gateway"



const { text } = await generateText({

5  model: "minimax/minimax-m2.1",

6  prompt:

7    "What breaking changes were introduced in " +

8    "Next.js 16.1? Check the latest release notes " +

9    "and migration guide.",

10  tools: {

11    perplexity_search: gateway.tools.perplexitySearch({

12      maxResults: 5,

13      searchDomainFilter: [\
\
14        "github.com",\
\
15        "nextjs.org",\
\
16        "vercel.com",\
\
17      ],

18      searchRecencyFilter: "month",

19    }),

20  },

21})
```

• **Consistency with fallbacks:** Maintain search behavior across multiple providers without rewriting search logic.

```typescript
import { streamText } from "ai"

import { gateway } from "@ai-sdk/gateway"



const result = await streamText({

5  model: "meta/llama-3.3-70b",

6  prompt:

7    "What are the latest critical CVEs disclosed " +

8    "for Node.js in the past week?",

9  tools: {

10    perplexity_search: gateway.tools.perplexitySearch({

11      maxResults: 5,

12      searchDomainFilter: [\
\
13        "nodejs.org",\
\
14        "cve.mitre.org",\
\
15        "github.com",\
\
16      ],

17    }),

18  },

19  providerOptions: {

20    order: ["cerebras", "togetherai"],

21  },

22})
```

For more information, see the [AI Gateway Perplexity Web Search docs](https://vercel.com/docs/ai-gateway/web-search#using-perplexity-search).