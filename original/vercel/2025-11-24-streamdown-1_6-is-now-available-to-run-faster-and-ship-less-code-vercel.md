---
title: "Streamdown 1.6 is now available to run faster and ship less code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/streamdown-1-6-is-now-available-to-run-faster-and-ship-less-code"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:14.022724732+00:00"
language: "en"
translated: false
description: "Streamdown 1.6 is out, which features some incredible updates and amazing community contributions. Read more below."
---




Nov 24, 2025

Vercel Streamdown 1.6 is now available with major improvements to performance, bundle size, and the authoring experience.

Streamdown now runs faster and ships less code thanks to memoization, LRU caching, optimized string operations, and the removal of regexes.

Several product enhancements include:

- **Code Blocks, Mermaid, and Math components are now lazy-loaded** with `React.lazy()` and `Suspense`, only loading when used.

- **The code highlighting system has been rebuilt** with a new tokenization approach that’s simpler, more efficient, and includes line numbers.

- **A custom markdown renderer replaces React Markdown**, giving Streamdown a lighter core and more room for future optimizations.

- **Static Mode adds support for rendering markdown without streaming,** ideal for blogs and other static use cases as it reduces streaming overhead.

- **Mermaid blocks now support custom error components** for handling parsing issues.

- **Diagrams can be exported** as SVG, PNG, or source code, and the fullscreen view includes zoom and pan controls (thanks to zhdzb).


Update to Vercel Streamdown 1.6 today with `npm i streamdown@latest` or read more about Streamdown [here](https://streamdown.ai/docs).