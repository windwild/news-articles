---
title: "Docs pages support Markdown responses - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/docs-pages-support-markdown-responses"
date: "2026-01-13"
scraped_at: "2026-03-02T09:22:50.926828878+00:00"
language: "en-zh"
translated: true
description: "Docs pages now accept `Accept: text/markdown` to return Markdown instead of HTML, and include a `sitemap.md` link at the end for programmatic discovery."
---
{% raw %}

Jan 13, 2026

2026 年 1 月 13 日

You can now request **Vercel documentation** as **Markdown** by sending the `Accept` header with the value `text/markdown`.

您现在可通过发送值为 `text/markdown` 的 `Accept` 请求头，以 **Markdown** 格式请求 **Vercel 文档**。

This makes it easier to use docs content in agentic and CLI workflows, indexing pipelines, and tooling that expects `text/markdown`.

这使得文档内容更易于集成至智能体（agentic）和命令行界面（CLI）工作流、索引流水线（indexing pipelines），以及期望输入格式为 `text/markdown` 的各类工具中。

Markdown responses include a `sitemap.md` link at the end. You and your agent can use it to discover additional docs pages programmatically.

Markdown 响应末尾包含一个 `sitemap.md` 链接。您和您的智能体均可通过该链接以编程方式发现更多文档页面。

docs-markdown.sh

`docs-markdown.sh`

```bash
curl -sL https://vercel.com/docs \

2  --header 'Accept: text/markdown' \

3  | tail -n 10
```

```bash
curl -sL https://vercel.com/docs \

2  --header 'Accept: text/markdown' \

3  | tail -n 10
```

Example request using the \`Accept: text/markdown\` header.

使用 \`Accept: text/markdown\` 请求头的示例请求。
{% endraw %}
