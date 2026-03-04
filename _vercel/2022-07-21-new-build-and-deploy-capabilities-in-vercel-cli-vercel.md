---
render_with_liquid: false
title: "New build and deploy capabilities in Vercel CLI - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-build-and-deploy-capabilities-in-vercel-cli"
date: "2022-07-21"
scraped_at: "2026-03-02T10:01:15.582617639+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Jul 21, 2022

2022年7月21日

![](images/new-build-and-deploy-capabilities-in-vercel-cli-vercel/img_001.jpg)![](images/new-build-and-deploy-capabilities-in-vercel-cli-vercel/img_002.jpg)

Vercel 的 [Build Output API](https://vercel.com/docs/build-output-api/v3) 现已正式发布（General Availability）。该 API 使**任何框架**（包括您自行构建的定制化解决方案）均可利用 Vercel 基础设施的核心能力，例如 Edge Middleware、Edge Functions、增量静态再生（Incremental Static Regeneration）、图片优化（Image Optimization）等。

该规范还使我们得以在 Vercel CLI 中引入两条新命令：

- `vercel build`：在本地或您自己的 CI 环境中构建项目

- `vercel deploy --prebuilt`：将预构建的产物（build output）直接部署至 Vercel，无需将源代码经由 Vercel 的构建系统进行处理

更多详情，请参阅博客上的 [Build Output API 发布公告](https://vercel.com/blog/build-output-api)。框架开发者可参考 [Build Output API 示例代码库](https://github.com/vercel/examples/tree/main/build-output-api)。