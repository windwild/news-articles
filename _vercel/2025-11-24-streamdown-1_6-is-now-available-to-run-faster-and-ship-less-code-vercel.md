---
title: "Streamdown 1.6 is now available to run faster and ship less code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/streamdown-1-6-is-now-available-to-run-faster-and-ship-less-code"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:14.022724732+00:00"
language: "en-zh"
translated: true
description: "Streamdown 1.6 is out, which features some incredible updates and amazing community contributions. Read more below."
---
{% raw %}

Nov 24, 2025

2025 年 11 月 24 日

Vercel Streamdown 1.6 现已发布，性能、包体积及创作体验均迎来重大改进。

得益于记忆化（memoization）、LRU 缓存、优化的字符串操作以及正则表达式（regexes）的移除，Streamdown 现在运行更快，交付的代码更少。

本次更新包含多项产品增强功能：

- **代码块（Code Blocks）、Mermaid 图表与数学公式（Math）组件现已支持懒加载**，采用 `React.lazy()` 与 `Suspense` 实现，仅在实际使用时才加载。

- **代码高亮系统已全面重构**，采用全新、更简洁高效的词法分析（tokenization）方案，并原生支持行号显示。

- **自定义 Markdown 渲染器取代了 React Markdown**，使 Streamdown 核心更轻量，也为未来进一步优化预留了更大空间。

- **静态模式（Static Mode）新增对非流式（non-streaming）Markdown 渲染的支持**，特别适用于博客等静态场景，可显著降低流式传输开销。

- **Mermaid 代码块现支持自定义错误组件**，便于更优雅地处理解析异常。

- **图表现支持导出为 SVG、PNG 或源代码格式**；全屏视图中亦新增缩放（zoom）与平移（pan）控制功能（感谢 zhdzb 的贡献）。

Update to Vercel Streamdown 1.6 today with `npm i streamdown@latest` or read more about Streamdown [here](https://streamdown.ai/docs).

今天即可通过 `npm i streamdown@latest` 升级至 Vercel Streamdown 1.6，或点击[此处](https://streamdown.ai/docs)了解 Streamdown 的更多信息。
{% endraw %}
