---
title: "Streamdown 2.3 — Refreshed design and interactive playground - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/streamdown-2-3"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:28.275150412+00:00"
language: "en"
translated: false
description: "Streamdown 2.3 focuses on design polish and developer experience. Tables, code blocks, and Mermaid diagrams have been redesigned."
---




Feb 19, 2026

Streamdown 2.3 enhances design consistency by applying a unified nested-card design to tables, code blocks, and Mermaid diagrams. Action buttons now remain sticky during scroll, and code blocks render plain text immediately to reduce perceived latency before syntax highlighting loads.

To accelerate testing, the new interactive playground supports real-time execution with custom markdown and editable props. This enables faster experimentation with configuration changes without spinning up a local project.

![](images/streamdown-2_3-refreshed-design-and-interactive-playground-vercel/img_001.jpg)

New hooks and utilities provide improved control over rendering. The `useIsCodeFenceIncomplete` hook detects in-progress fenced code blocks during streaming. Tables now support copying as Markdown, and a new HTML indentation normalization property handles inconsistent whitespace in raw input. Image rendering also includes improved error handling with custom messaging.

Documentation has been reorganized for easier reference. Plugin documentation for CJK, Math, and Mermaid is now consolidated into dedicated pages, and the redesigned homepage links directly to templates for faster onboarding.

![](images/streamdown-2_3-refreshed-design-and-interactive-playground-vercel/img_002.jpg)

This release also resolves issues with nested HTML block parsing, custom tag handling, Mermaid diagram artifacts, and Shiki syntax engine inconsistencies. Streamdown 2.3 ships with a fully cleared bug backlog.

[Read the documentation](https://streamdown.ai/docs) for more information.