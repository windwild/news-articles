---
title: "Experimental build mode for Hono and Express projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/experimental-build-mode-hono-express"
date: "2026-01-15"
scraped_at: "2026-03-02T09:22:37.100704557+00:00"
language: "en-zh"
translated: true
description: "Users can opt-in to an experimental build mode for backend frameworks like Hono or Express. The new behavior allows logs to be filtered by route, similar to Next.js and other frameworks. It also impro..."
---
&#123;% raw %}

Jan 15, 2026

2026 年 1 月 15 日

Users can opt in to an experimental build mode for [Hono](https://vercel.com/docs/frameworks/backend/hono) and [Express](https://vercel.com/docs/frameworks/backend/express) projects, which lets you filter logs by route, similar to Next.js.

用户可为 [Hono](https://vercel.com/docs/frameworks/backend/hono) 和 [Express](https://vercel.com/docs/frameworks/backend/express) 项目启用实验性构建模式，该模式支持按路由筛选日志，功能类似于 Next.js。

It also updates the build pipeline with better module resolution:

该模式还通过改进模块解析能力更新了构建流程：

- Relative imports no longer require file extensions

- 相对路径导入不再需要指定文件扩展名

- TypeScript path aliases are supported

- 支持 TypeScript 的路径别名（path aliases）

- Improved ESM and CommonJS interoperability

- 增强了 ESM 与 CommonJS 的互操作性

To enable it, set `VERCEL_EXPERIMENTAL_BACKENDS=1` in your project's [environment variables](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fenvironment-variables&title=Open+environment+variables).

如需启用该功能，请在项目的 [环境变量](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fenvironment-variables&title=Open+environment+variables) 中设置 `VERCEL_EXPERIMENTAL_BACKENDS=1`。
&#123;% endraw %}
