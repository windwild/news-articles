---
title: "Introducing Streamdown: Open source Markdown for AI streaming - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-streamdown"
date: "2025-08-21"
scraped_at: "2026-03-02T09:29:38.405364354+00:00"
language: "en-zh"
translated: true
description: "Streamdown is a new open source, drop-in Markdown renderer built for AI streaming. It powers the AI Elements Response component, but can also be used standalone."
---
&#123;% raw %}

Aug 21, 2025

2025 年 8 月 21 日

![](images/introducing-streamdown-open-source-markdown-for-ai-streaming-vercel/img_001.jpg)![](images/introducing-streamdown-open-source-markdown-for-ai-streaming-vercel/img_002.jpg)

Streamdown is a new open source, drop-in Markdown renderer built for AI streaming. It powers the [AI Elements](https://ai-sdk.dev/elements) [Response](https://ai-sdk.dev/elements/components/response) component, but can also be used standalone to give developers a fully composable, independently managed option with `npm i streamdown`.

Streamdown 是一款全新开源、即插即用的 Markdown 渲染器，专为 AI 流式响应（AI streaming）场景而构建。它为 [AI Elements](https://ai-sdk.dev/elements) 中的 [Response](https://ai-sdk.dev/elements/components/response) 组件提供底层支持；同时亦可独立使用，通过执行 `npm i streamdown`，为开发者提供完全可组合、独立可控的渲染方案。

Streamdown is designed to handle unterminated chunks, interactive code blocks, math, and other cases that are unreliable with existing Markdown packages.

Streamdown 专为应对现有 Markdown 库难以可靠处理的各类边缘场景而设计，包括：未终止的流式数据块（unterminated chunks）、交互式代码块、数学公式渲染等。

It's available now, and ships with:

它现已正式发布，并内置以下特性：

- **Tailwind typography styles:** Preconfigured classes for headings, lists, and code blocks

- **Tailwind 排版样式：** 预配置的标题、列表与代码块样式类

- **GitHub Flavored Markdown:** Tables, task lists, and other GFM features

- **GitHub 风格 Markdown（GFM）：** 支持表格、任务列表等 GFM 特性

- **Interactive code blocks:** Shiki highlighting with built-in copy button

- **交互式代码块：** 基于 Shiki 的语法高亮，并内置一键复制按钮

- **Math support:** LaTeX expressions via `remark-math` and KaTeX

- **数学公式支持：** 通过 `remark-math` 与 KaTeX 渲染 LaTeX 数学表达式

- **Graceful chunk handling:** Proper formatting for unterminated Markdown chunks

- **优雅的分块处理：** 对未终止的 Markdown 数据块进行正确格式化

- **Security hardening:** Safe handling of untrusted content with restricted images and links

- **安全加固：** 通过限制图片和链接，安全地处理不可信内容。

You can get started with start with AI Elements:

你可以通过 AI Elements 快速开始：

```bash
npx ai-elements@latest add message
```

```bash
npx ai-elements@latest add message
```

Or as a standalone package:

或者作为独立包安装：

```bash
npm i streamdown
```

```bash
npm i streamdown
```

[Read the docs](https://streamdown.ai/) and upgrade your AI-powered streaming.

[阅读文档](https://streamdown.ai/)，升级你的 AI 驱动流式传输体验。
&#123;% endraw %}
