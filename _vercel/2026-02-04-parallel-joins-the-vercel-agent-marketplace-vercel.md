---
title: "Parallel joins the Vercel Agent Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/parallel-joins-the-vercel-agent-marketplace"
date: "2026-02-04"
scraped_at: "2026-03-02T09:21:37.254084488+00:00"
language: "en-zh"
translated: true
description: "Parallel is now available on the Vercel Marketplace with a native integration for Vercel projects. Developers can add Parallel’s web tools and AI agents to their apps in minutes, including Search, E..."
---
{% raw %}

Feb 4, 2026

2026 年 2 月 4 日

[Parallel](https://vercel.com/marketplace/parallel) 现已上线 [Vercel Agent Marketplace](https://vercel.com/marketplace/category/agents)，并提供原生集成支持。

Parallel 提供面向大语言模型（LLM）应用的网页工具与智能体（agents），功能涵盖搜索（Search）、信息抽取（Extract）、任务编排（Tasks）、批量查找（FindAll）以及监控（Monitoring）。通过 Vercel 集成，开发者可使用一个统一的 API 密钥访问所有 Parallel 产品，账单则直接由您的 Vercel 账户统一管理。

对于在 Vercel 上构建 AI 功能的开发者而言，Parallel 使智能体能够直接访问开放网络，从而高效完成问答、变更监控及结构化数据抽取等任务。由于 Parallel 返回的结果专为 LLM 消费而优化，您的智能体可减少调用轮次，显著降低延迟与成本。

```typescript
import Parallel from "parallel-web";

const client = new Parallel({ apiKey: process.env.PARALLEL_API_KEY });

async function main() {
    const search = await client.beta.search({
```

7        objective: "When was the United Nations established? Prefer UN's websites.",

7        目标： “联合国是何时成立的？优先选用联合国官网信息。”

8        search_queries: [\
\
8        搜索关键词： [\
\
9            "Founding year UN",\
\
9            “联合国成立年份”，\
\
10            "Year of founding United Nations"\
\
10            “联合国成立年份”\
\
11        ],

11        ],

12        max_results: 10,

12        最大返回结果数： 10,

13        excerpts: { max_chars_per_result: 10000 },

13        摘要：{ 每条结果最大字符数： 10000 },

14    });



14    });



16    console.log(search.results);

16    console.log(search.results);

17}



17}



main().catch(console.error);
```

Execute your first API call in minutes

几分钟内执行您的首个 API 调用

Install Parallel from the [Marketplace](https://vercel.com/marketplace/parallel) or deploy the [Next.js template](https://vercel.com/templates/template/next-js-parallel-starter) to see Parallel's web research APIs integrated with Vercel in action.

从 [Marketplace](https://vercel.com/marketplace/parallel) 安装 Parallel，或部署 [Next.js 模板](https://vercel.com/templates/template/next-js-parallel-starter)，即可亲眼见证 Parallel 的网络研究 API 与 Vercel 的实际集成效果。
{% endraw %}
