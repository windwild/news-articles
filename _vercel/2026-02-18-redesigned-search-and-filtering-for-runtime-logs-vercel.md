---
title: "Redesigned search and filtering for runtime logs - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/redesigned-search-and-filtering-for-runtime-logs"
date: "2026-02-18"
scraped_at: "2026-03-02T09:21:29.612086611+00:00"
language: "en-zh"
translated: true
description: "The Logs search bar has been redesigned with visual filter pills, smarter suggestions from your log data, and instant query validation."
---
&#123;% raw %}

Feb 18, 2026

2026 年 2 月 18 日

您项目仪表板中的“运行时日志”（Runtime Logs）搜索栏已重新设计，使日志筛选与浏览更加快速、直观。

- **结构化筛选器。** 当您输入类似 `level:error` 或 `status:500` 的筛选条件时，搜索栏会将其解析为一个可视化标签（pill），您可一目了然地阅读该标签，并通过单击轻松移除。包含多个筛选条件的复杂查询也变得易于快速浏览和编辑，无需重新键入任何内容。

- **更智能的建议。** 在您输入过程中，搜索栏会基于您实际的日志数据，实时推荐可用的筛选值。每个项目的近期查询会被自动保存，并始终显示在建议列表顶部，让您无需重复输入即可一键重跑常用查询。

- **更优的输入处理。** 搜索栏会在您键入时实时校验筛选条件，并通过工具提示（tooltip）标出错误，助您在执行搜索前及时修正拼写错误。粘贴 Vercel 请求 ID（Request ID）将自动转换为对应筛选条件。

以上改进现已在您的项目仪表板中上线。了解更多关于[运行时日志](https://vercel.com/docs/observability/runtime-logs)的信息。
&#123;% endraw %}
