---
title: "Streamdown 2.3 — Refreshed design and interactive playground - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/streamdown-2-3"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:28.275150412+00:00"
language: "en-zh"
translated: true
description: "Streamdown 2.3 focuses on design polish and developer experience. Tables, code blocks, and Mermaid diagrams have been redesigned."
---
&#123;% raw %}

Feb 19, 2026

2026 年 2 月 19 日

Streamdown 2.3 enhances design consistency by applying a unified nested-card design to tables, code blocks, and Mermaid diagrams. Action buttons now remain sticky during scroll, and code blocks render plain text immediately to reduce perceived latency before syntax highlighting loads.

Streamdown 2.3 通过为表格、代码块和 Mermaid 图表统一应用嵌套卡片（nested-card）设计，提升了整体设计一致性。操作按钮在滚动过程中保持固定（sticky）；代码块则优先渲染纯文本内容，以缩短语法高亮加载前的感知延迟。

To accelerate testing, the new interactive playground supports real-time execution with custom markdown and editable props. This enables faster experimentation with configuration changes without spinning up a local project.

为加速测试流程，全新交互式 Playground 支持基于自定义 Markdown 和可编辑属性的实时执行。开发者无需启动本地项目，即可快速验证各类配置变更效果。

![](images/streamdown-2_3-refreshed-design-and-interactive-playground-vercel/img_001.jpg)

![](images/streamdown-2_3-refreshed-design-and-interactive-playground-vercel/img_001.jpg)

New hooks and utilities provide improved control over rendering. The `useIsCodeFenceIncomplete` hook detects in-progress fenced code blocks during streaming. Tables now support copying as Markdown, and a new HTML indentation normalization property handles inconsistent whitespace in raw input. Image rendering also includes improved error handling with custom messaging.

新增的 Hook 与工具函数增强了对渲染过程的控制能力。`useIsCodeFenceIncomplete` Hook 可在流式传输过程中检测尚未完成的围栏式代码块（fenced code block）。表格现已支持以 Markdown 格式一键复制；新增的 HTML 缩进标准化（indentation normalization）属性可自动处理原始输入中不一致的空白字符。图片渲染也升级了错误处理机制，并支持自定义错误提示信息。

Documentation has been reorganized for easier reference. Plugin documentation for CJK, Math, and Mermaid is now consolidated into dedicated pages, and the redesigned homepage links directly to templates for faster onboarding.

文档结构已全面重构，便于查阅。CJK、Math 和 Mermaid 插件的说明文档现已分别整合至独立页面；重新设计的首页则直接链接至各类模板，助力用户更快上手。

![](images/streamdown-2_3-refreshed-design-and-interactive-playground-vercel/img_002.jpg)

![](images/streamdown-2_3-refreshed-design-and-interactive-playground-vercel/img_002.jpg)

This release also resolves issues with nested HTML block parsing, custom tag handling, Mermaid diagram artifacts, and Shiki syntax engine inconsistencies. Streamdown 2.3 ships with a fully cleared bug backlog.

本次发布还修复了嵌套 HTML 块解析、自定义标签处理、Mermaid 图表渲染异常以及 Shiki 语法引擎不一致等多项问题。Streamdown 2.3 发布时已彻底清空全部已知 Bug 待办清单（bug backlog）。

[Read the documentation](https://streamdown.ai/docs) for more information.

[查阅文档](https://streamdown.ai/docs) 了解更多信息。
&#123;% endraw %}
