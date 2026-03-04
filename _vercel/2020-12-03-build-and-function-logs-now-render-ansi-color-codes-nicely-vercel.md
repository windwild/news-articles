---
title: "Build and Function Logs now render ANSI color codes nicely - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/build-and-function-logs-now-render-ansi-color-codes-nicely"
date: "2020-12-03"
scraped_at: "2026-03-02T10:06:19.164389212+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Dec 3, 2020

2020 年 12 月 3 日

![](images/build-and-function-logs-now-render-ansi-color-codes-nicely-vercel/img_001.jpg)

如果您的源代码或所用框架在构建步骤（Build Step）或无服务器函数（Serverless Functions）中输出的日志包含 ANSI 颜色代码，以提升可读性，Vercel 此前会直接在控制台（Dashboard）对应视图中原样打印这些代码。

然而，自今日起，所有此类 ANSI 代码均会在“部署详情页”（Deployment View）中被自动解析。该页面主界面显示构建日志（Build Logs），同时在“函数”（Functions）标签页中也展示各无服务器函数的日志。

在上方示例中，您可以看到 ANSI 颜色代码现已自动渲染为它们本应代表的实际颜色，从而显著提升了日志文本的可读性。