---
title: "New npm package for automatic recovery of broken streaming markdown - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-npm-package-for-automatic-recovery-of-broken-streaming-markdown"
date: "2025-12-03"
scraped_at: "2026-03-02T09:24:33.617829352+00:00"
language: "en"
translated: false
description: "A new standalone package that brings Streamdown's intelligent incomplete Markdown handling to any application. "
---




Dec 3, 2025

[Remend](https://www.npmjs.com/package/remend) is a new standalone package that brings intelligent incomplete Markdown handling to any application.

Previously part of [Streamdown](https://streamdown.ai/)'s Markdown termination logic, Remend is now a standalone library (`npm i remend`) you can use in any application.

### Why it matters

AI models stream Markdown token-by-token, which often produces incomplete syntax that breaks rendering. For example:

- Unclosed fences

- Half-finished bold/italic markers

- Unterminated links or lists


Without correction, these patterns fail to render, leak raw Markdown, or disrupt layout:

```markdown
1**This is bold text

2[Click here](https://exampl

3`const foo = "bar
```

Remend automatically detects and completes unterminated Markdown blocks, ensuring clean, stable output during streaming.

```typescript
import remend from "remend";



const partialMarkdown = "This is **bold text";

const completed = remend(partialMarkdown);



6// Result: "This is **bold text**"
```

As the stream continues and the actual closing markers arrive, the content seamlessly updates, giving users a polished experience even mid-stream.

It works with any Markdown renderer as a pre-processor. For example:

```typescript
import remend from "remend";

import { unified } from "unified";

import remarkParse from "remark-parse";

import remarkRehype from "remark-rehype";

import rehypeStringify from "rehype-stringify";



const streamedMarkdown = "This is **incomplete bold";



9// Run Remend first to complete incomplete syntax

const completedMarkdown = remend(streamedMarkdown);



12// Then process with unified

const file = await unified()

14  .use(remarkParse)

15  .use(remarkRehype)

16  .use(rehypeStringify)

17  .process(completedMarkdown);



console.log(String(file));
```

Remend powers the markdown rendering in Streamdown and has been battle-tested in production AI applications. It includes intelligent rules to avoid false positives and handles complex edge cases like:

- Mathematical expressions with underscores in LaTeX blocks

- Product codes and variable names with asterisks/underscores

- List items with formatting markers

- Nested brackets in links


To get started, either use it through [Streamdown](https://www.npmjs.com/package/streamdown) or install it standalone with:

```bash
npm i remend
```