---
title: "Edge Functions are now available in Public Beta - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/edge-functions-are-now-available-in-public-beta"
date: "2021-10-26"
scraped_at: "2026-03-02T10:04:03.793665532+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Oct 26, 2021

2021 年 10 月 26 日

![](images/edge-functions-are-now-available-in-public-beta-vercel/img_001.jpg)

[Edge Functions](https://vercel.com/features/edge-functions) 现已开放公开测试（Public Beta）。

[Edge Functions](https://vercel.com/features/edge-functions) 现已开放公开测试（Public Beta）。它们使开发者能够以极快速度和高度个性化的方式向您的网站交付内容，从而确保每次都能精准呈现开发者所构想的最终用户体验。Edge Functions 具备毫秒级冷启动能力，支持流式响应，并默认在全球范围内部署。

要开始使用 Edge Functions，请在 [Next.js 12+](https://nextjs.org/12) 项目的 `pages/` 目录下，或任意 Vercel 项目的根目录中，创建一个 `_middleware.js` 文件。中间件（Middleware）支持边缘端身份验证（Edge authentication）、机器人防护（bot protection）、功能开关（feature flags）、A/B 测试、服务端分析（server-side analytics）、日志记录（logging）等众多功能。

请参阅[官方文档](https://vercel.com/docs/concepts/functions/edge-functions)，了解 Edge Functions 的部署方法；并查看[示例代码](https://vercel.com/features/edge-functions#examples)。