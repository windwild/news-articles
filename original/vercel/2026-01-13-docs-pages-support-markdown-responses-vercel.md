---
title: "Docs pages support Markdown responses - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/docs-pages-support-markdown-responses"
date: "2026-01-13"
scraped_at: "2026-03-02T09:22:50.926828878+00:00"
language: "en"
translated: false
description: "Docs pages now accept `Accept: text/markdown` to return Markdown instead of HTML, and include a `sitemap.md` link at the end for programmatic discovery."
---




Jan 13, 2026

You can now request **Vercel documentation** as **Markdown** by sending the `Accept` header with the value `text/markdown`.

This makes it easier to use docs content in agentic and CLI workflows, indexing pipelines, and tooling that expects `text/markdown`.

Markdown responses include a `sitemap.md` link at the end. You and your agent can use it to discover additional docs pages programmatically.

docs-markdown.sh

```bash
curl -sL https://vercel.com/docs \

2  --header 'Accept: text/markdown' \

3  | tail -n 10
```

Example request using the \`Accept: text/markdown\` header.