---
title: "Understand Interaction to Next Paint (INP) with the Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/interaction-timing-tool"
date: "2024-05-21"
scraped_at: "2026-03-02T09:45:04.435080768+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 21, 2024

![](images/understand-interaction-to-next-paint-inp-with-the-vercel-toolbar-vercel/img_001.jpg)![](images/understand-interaction-to-next-paint-inp-with-the-vercel-toolbar-vercel/img_002.jpg)

The Vercel Toolbar now helps you investigate your site's Interaction to Next Paint (INP).

This new Core Web Vital, which [impacts Google search ranking as of March 2024](https://vercel.com/blog/how-core-web-vitals-affect-seo), is now available in the toolbar menu under Interaction Timing. As you interact with your site, this tool measures input delay, processing times, and rendering delay and allows you to inspect in detail how these are affecting each interaction's latency.

This tool can also notify you as you navigate your site of any interactions that take more than 200ms, the upper limit for a good INP score. These toasts can be configured in Preferences under the toolbar menu.

Learn more about the [Vercel Toolbar](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) and [INP.](https://vercel.com/guides/first-input-delay-vs-interaction-to-next-paint#interaction-to-next-paint-(inp))