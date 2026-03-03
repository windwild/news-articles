---
title: "Introducing Streamdown: Open source Markdown for AI streaming - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-streamdown"
date: "2025-08-21"
scraped_at: "2026-03-02T09:29:38.405364354+00:00"
language: "en"
translated: false
description: "Streamdown is a new open source, drop-in Markdown renderer built for AI streaming. It powers the AI Elements Response component, but can also be used standalone."
---




Aug 21, 2025

![](images/introducing-streamdown-open-source-markdown-for-ai-streaming-vercel/img_001.jpg)![](images/introducing-streamdown-open-source-markdown-for-ai-streaming-vercel/img_002.jpg)

Streamdown is a new open source, drop-in Markdown renderer built for AI streaming. It powers the [AI Elements](https://ai-sdk.dev/elements) [Response](https://ai-sdk.dev/elements/components/response) component, but can also be used standalone to give developers a fully composable, independently managed option with `npm i streamdown`.

Streamdown is designed to handle unterminated chunks, interactive code blocks, math, and other cases that are unreliable with existing Markdown packages.

It's available now, and ships with:

- **Tailwind typography styles:** Preconfigured classes for headings, lists, and code blocks

- **GitHub Flavored Markdown:** Tables, task lists, and other GFM features

- **Interactive code blocks:** Shiki highlighting with built-in copy button

- **Math support:** LaTeX expressions via `remark-math` and KaTeX

- **Graceful chunk handling:** Proper formatting for unterminated Markdown chunks

- **Security hardening:** Safe handling of untrusted content with restricted images and links


You can get started with start with AI Elements:

```bash
npx ai-elements@latest add message
```

Or as a standalone package:

```bash
npm i streamdown
```

[Read the docs](https://streamdown.ai/) and upgrade your AI-powered streaming.