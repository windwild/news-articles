---
title: "Access Perplexity Web Search on Vercel AI Gateway with any model - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/access-perplexity-web-search-on-vercel-ai-gateway-with-any-model"
date: "2026-01-14"
scraped_at: "2026-03-02T09:23:00.316598907+00:00"
language: "en-zh"
translated: true
description: "You can use Perplexity web search with any model and any provider on Vercel AI Gateway to access real-time results and up-to-date information."
---
&#123;% raw %}

Jan 14, 2026

2026 年 1 月 14 日

您现在可通过 Vercel 的 AI Gateway，为任意模型赋予使用 Perplexity 进行网页搜索的能力。

AI Gateway 将 Perplexity Search 支持为一种通用网页搜索工具，可与所有模型（无论其提供商）无缝协作。与仅限特定提供商原生集成的搜索工具不同，Perplexity Search 可被添加至任意模型。

如需在 AI SDK 中使用 Perplexity Search，请从 `@ai-sdk/gateway` 导入 `gateway.tools.perplexitySearch()`，并将其作为名为 `perplexity_search` 的工具传入模型的 `tools` 参数中。

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

一些典型使用场景包括：

• **不原生支持搜索功能的模型：** 为 `zai/glm-4.7` 等模型，或任何其他未内置搜索工具的第三方模型启用网络搜索功能。

```typescript
import { streamText } from "ai"

import { gateway } from "@ai-sdk/gateway"

```javascript
const result = await streamText({

5  model: "zai/glm-4.7",

6  prompt:

7    "What are the latest AI safety guidelines " +

8    "published by major tech companies?",

9  tools: {

10    perplexity_search: gateway.tools.perplexitySearch({

11      maxResults: 5,

12      searchRecencyFilter: "month",
```

```javascript
const result = await streamText({

5  model: "zai/glm-4.7",

6  prompt:

7    “各大科技公司最新发布的 AI 安全指南有哪些？”,

9  tools: {

10    perplexity_search: gateway.tools.perplexitySearch({

11      maxResults: 5,

12      searchRecencyFilter: "month",
```

13      searchLanguageFilter: ["en"],

13      搜索语言筛选器：["en"]，

14    }),

14    }),

15  },

15  },

16})
```

16})
```

• **Developer tooling and CI assistants:** Get current package versions, recently merged PRs, release notes, or docs updates.

• **开发者工具与 CI 助手：** 获取当前软件包版本、最近合并的 PR、发布说明或文档更新。

```typescript
import { generateText } from "ai"

import { gateway } from "@ai-sdk/gateway"



const { text } = await generateText({

5  model: "minimax/minimax-m2.1",
```

```typescript
import { generateText } from "ai"

import { gateway } from "@ai-sdk/gateway"



const { text } = await generateText({

5  model: "minimax/minimax-m2.1",
```

6  prompt:

6  提示词：

7    "What breaking changes were introduced in " +

7    “Next.js 16.1 中引入了哪些破坏性变更？请查阅最新发布说明” +

8    "Next.js 16.1? Check the latest release notes " +

8    “和迁移指南。”,

9    "and migration guide.",

10  tools: {

10  工具：{

11    perplexity_search: gateway.tools.perplexitySearch({

11    perplexity_search: gateway.tools.perplexitySearch({

12      maxResults: 5,

12      maxResults: 5,

13      searchDomainFilter: [\
\
13      searchDomainFilter: [\
\
14        "github.com",\
\
14        "github.com",\
\
15        "nextjs.org",\
\
15        "nextjs.org",\
\
16        "vercel.com",\
\
16        "vercel.com",\
\
17      ],

17      ],

18      searchRecencyFilter: "month",

18      searchRecencyFilter: "month",

19    }),

20  },

21})
```

20  },

21})
```

• **Consistency with fallbacks:** Maintain search behavior across multiple providers without rewriting search logic.

• **具备回退机制的一致性：** 在多个提供商之间保持搜索行为一致，无需重写搜索逻辑。

```typescript
import { streamText } from "ai"

import { gateway } from "@ai-sdk/gateway"



const result = await streamText({

5  model: "meta/llama-3.3-70b",

6  prompt:

7    "What are the latest critical CVEs disclosed " +
```

8    "for Node.js in the past week?",

8    “过去一周关于 Node.js 的情况？”

9  tools: {

9  工具：{

10    perplexity_search: gateway.tools.perplexitySearch({

10    perplexity_search: gateway.tools.perplexitySearch({

11      maxResults: 5,

11      maxResults: 5,

12      searchDomainFilter: [\
\
12      searchDomainFilter: [\
\
13        "nodejs.org",\
\
13        "nodejs.org",\
\
14        "cve.mitre.org",\
\
14        "cve.mitre.org",\
\
15        "github.com",\
\
15        "github.com",\
\
16      ],

16      ],

17    }),

17    }),

18  },

18  },

19  providerOptions: {

19  提供商选项：{

20    order: ["cerebras", "togetherai"],

20    order: ["cerebras", "togetherai"],

21  },

22})
```

For more information, see the [AI Gateway Perplexity Web Search docs](https://vercel.com/docs/ai-gateway/web-search#using-perplexity-search).

有关更多信息，请参阅 [AI Gateway Perplexity 网络搜索文档](https://vercel.com/docs/ai-gateway/web-search#using-perplexity-search)。
&#123;% endraw %}
