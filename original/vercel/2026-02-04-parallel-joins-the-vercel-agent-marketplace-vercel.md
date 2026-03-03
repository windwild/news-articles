---
title: "Parallel joins the Vercel Agent Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/parallel-joins-the-vercel-agent-marketplace"
date: "2026-02-04"
scraped_at: "2026-03-02T09:21:37.254084488+00:00"
language: "en"
translated: false
description: "Parallel is now available on the Vercel Marketplace with a native integration for Vercel projects. Developers can add Parallel’s web tools and AI agents to their apps in minutes, including Search, E..."
---




Feb 4, 2026

[Parallel](https://vercel.com/marketplace/parallel) is now available on the [Vercel Agent Marketplace](https://vercel.com/marketplace/category/agents) with native integration support.

Parallel provides web tools and agents designed for LLM-powered applications, including Search, Extract, Tasks, FindAll, and Monitoring capabilities. The Vercel integration provides a single API key that works across all Parallel products, with billing handled directly through your Vercel account.

For developers building AI features on Vercel, Parallel enables agents to access the open web for tasks like answering questions, monitoring changes, and extracting structured data. Since Parallel returns results optimized for LLM consumption, your agents can resolve tasks with fewer round trips and reduced cost and latency.

```typescript
import Parallel from "parallel-web";



const client = new Parallel({ apiKey: process.env.PARALLEL_API_KEY });



async function main() {

6    const search = await client.beta.search({

7        objective: "When was the United Nations established? Prefer UN's websites.",

8        search_queries: [\
\
9            "Founding year UN",\
\
10            "Year of founding United Nations"\
\
11        ],

12        max_results: 10,

13        excerpts: { max_chars_per_result: 10000 },

14    });



16    console.log(search.results);

17}



main().catch(console.error);
```

Execute your first API call in minutes

Install Parallel from the [Marketplace](https://vercel.com/marketplace/parallel) or deploy the [Next.js template](https://vercel.com/templates/template/next-js-parallel-starter) to see Parallel's web research APIs integrated with Vercel in action.