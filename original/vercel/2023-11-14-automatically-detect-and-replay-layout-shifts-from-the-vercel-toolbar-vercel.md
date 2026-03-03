---
title: "Automatically detect and replay layout shifts from the Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatically-detect-and-replay-layout-shifts"
date: "2023-11-14"
scraped_at: "2026-03-02T09:49:39.396409795+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 14, 2023

![](images/automatically-detect-and-replay-layout-shifts-from-the-vercel-toolbar-vercel/img_001.jpg)![](images/automatically-detect-and-replay-layout-shifts-from-the-vercel-toolbar-vercel/img_002.jpg)

Vercel can now automatically detect and replay [layout shifts](https://vercel.com/docs/speed-insights#cumulative-layout-shift-cls) on your deployments from the Vercel Toolbar.

Layout shifts are reported and notified through the Toolbar. Each reported shift includes a summary of what caused the shift and how many elements it affected. Additionally, you replay and animate the shift to see it again.

The Toolbar is automatically added to all Preview Deployments, but can also be used in localhost and in production (likely behind your own staff authentication checks) when using the [@vercel/toolbar package](https://vercel.com/docs/workflow-collaboration/comments/in-production-and-localhost).

[Check out the documentation](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) to learn more.