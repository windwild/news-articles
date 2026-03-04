---
render_with_liquid: false
title: "Improved support for Gatsby sites - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-support-for-gatsby-sites"
date: "2023-01-23"
scraped_at: "2026-03-02T09:56:41.932284742+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Jan 23, 2023

2023 年 1 月 23 日

![](images/improved-support-for-gatsby-sites-vercel/img_001.jpg)![](images/improved-support-for-gatsby-sites-vercel/img_002.jpg)

部署在 Vercel 上的 Gatsby 网站现在可充分利用一系列强大新功能，包括：

- **服务端渲染（SSR）：** 按需动态渲染内容。

- **延迟静态生成（DSG）：** 利用与 [增量静态再生（ISR）](https://vercel.com/docs/build-output-api/v3#vercel-primitives/prerender-functions) 相同的基础设施，在收到新请求时于后台生成静态页面。

- **原生 API 路由：** 在 `api` 目录中创建函数，快速搭建新的 API 路由。

部署至 Vercel 的 Gatsby `v4+` 网站将自动检测 Gatsby 的使用情况，并安装全新的 `@vercel/gatsby-plugin-vercel-builder` 插件。而 Gatsby `v5` 网站则需使用 [Node.js 18](https://vercel.com/changelog/node-js-18-lts-is-now-available)，该版本目前是新建项目的默认 Node.js 版本。

立即通过我们的 [更新版模板](https://vercel.com/templates/gatsby/gatsbyjs-boilerplate) 开始使用 Gatsby。