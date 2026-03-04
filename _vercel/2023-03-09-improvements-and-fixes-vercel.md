---
title: "Improvements and Fixes - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/march-2023"
date: "2023-03-09"
scraped_at: "2026-03-02T09:53:57.648759792+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Mar 9, 2023

2023年3月9日

![](images/improvements-and-fixes-vercel/img_001.jpg)![](images/improvements-and-fixes-vercel/img_002.jpg)

![](images/improvements-and-fixes-vercel/img_001.jpg)![](images/improvements-and-fixes-vercel/img_002.jpg)

- **Serverless 函数中的 AWS 凭据：** 现在可通过控制台（dashboard）添加以 `AWS_` 开头的环境变量，例如 `AWS_ACCESS_KEY_ID` 或 `AWS_REGION`。

- **框架专属文档：** Vercel 官方文档新增了一个专门介绍各类前端框架的章节，涵盖 [Next](https://vercel.com/docs/frameworks/nextjs)、[SvelteKit](https://vercel.com/docs/frameworks/sveltekit)、[Astro](https://vercel.com/docs/frameworks/astro)、[Create React App](https://vercel.com/docs/frameworks/create-react-app) 和 [Gatsby](https://vercel.com/docs/frameworks/gatsby) 等。

- **Vercel CLI：** [v28.16.13](https://github.com/vercel/vercel/releases/tag/vercel%4028.16.13) 版本已发布，此次更新包括将 Turbo 升级至 1.8.3 版本、增强对 Remix 的支持（升级 `@remix-run/dev` 至 1.14.0）、新增对 Astro V2 的支持等。

- **改进的日期选择器：** 使用量（Usage）标签页中新增的 [日期选择器](https://vercel.com/changelog/activity-date-filtering-now-available) 支持自然语言解析、预设时间范围及快捷操作。

- **Vercel 定时任务（Cron Jobs）：** 我们现已支持框架作者通过构建输出 API（Build Output API）配置中的 `crons` 属性来创建 [定时任务](https://vercel.com/blog/cron-jobs)；终端用户也可通过 `vercel.json` 文件中的 `crons` 属性来定义定时任务。