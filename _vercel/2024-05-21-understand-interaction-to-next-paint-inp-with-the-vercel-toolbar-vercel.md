---
render_with_liquid: false
title: "Understand Interaction to Next Paint (INP) with the Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/interaction-timing-tool"
date: "2024-05-21"
scraped_at: "2026-03-02T09:45:04.435080768+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

May 21, 2024

2024 年 5 月 21 日

![](images/understand-interaction-to-next-paint-inp-with-the-vercel-toolbar-vercel/img_001.jpg)![](images/understand-interaction-to-next-paint-inp-with-the-vercel-toolbar-vercel/img_002.jpg)

The Vercel Toolbar now helps you investigate your site's Interaction to Next Paint (INP).

Vercel 工具栏现已支持帮助您分析网站的“交互到下一次绘制”（Interaction to Next Paint，简称 INP）指标。

This new Core Web Vital, which [impacts Google search ranking as of March 2024](https://vercel.com/blog/how-core-web-vitals-affect-seo), is now available in the toolbar menu under Interaction Timing. As you interact with your site, this tool measures input delay, processing times, and rendering delay and allows you to inspect in detail how these are affecting each interaction's latency.

这一新增的核心网页指标（Core Web Vital）自 2024 年 3 月起已影响 Google 搜索排名（[详见博客](https://vercel.com/blog/how-core-web-vitals-affect-seo)），现已在工具栏菜单中“交互时序”（Interaction Timing）项下提供。当您与网站进行交互时，该工具将测量输入延迟、处理耗时和渲染延迟，并支持您深入检查这些因素如何影响每次交互的端到端延迟。

This tool can also notify you as you navigate your site of any interactions that take more than 200ms, the upper limit for a good INP score. These toasts can be configured in Preferences under the toolbar menu.

该工具还可实时向您提示：在浏览网站过程中，任何耗时超过 200 毫秒的交互（即超出良好 INP 得分上限的交互）。此类通知气泡（toasts）可在工具栏菜单的“偏好设置”（Preferences）中进行配置。

Learn more about the [Vercel Toolbar](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) and [INP.](https://vercel.com/guides/first-input-delay-vs-interaction-to-next-paint#interaction-to-next-paint-(inp))

了解更多关于 [Vercel 工具栏](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) 和 [INP（交互到下一次绘制）](https://vercel.com/guides/first-input-delay-vs-interaction-to-next-paint#interaction-to-next-paint-(inp)) 的信息。