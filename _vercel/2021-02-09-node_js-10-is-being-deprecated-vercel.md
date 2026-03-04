---
render_with_liquid: false
title: "Node.js 10 is being deprecated - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-10-is-being-deprecated"
date: "2021-02-09"
scraped_at: "2026-03-02T10:05:42.676851256+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Feb 9, 2021

2021 年 2 月 9 日

![](images/node_js-10-is-being-deprecated-vercel/img_001.jpg)

继上周发布 [Node.js 14](https://vercel.com/changelog/node-js-14-lts-is-now-available) 之后，Vercel 宣布将弃用 Node.js 10。Node.js 10 的[官方生命周期终止日期（End of Life）](https://nodejs.org/en/about/releases/)为 2021 年 4 月 30 日。

自 **2021 年 4 月 20 日**起，Node.js 10 将在项目设置（Project Settings）中被禁用；对于已选择 Node.js 10 的现有项目，每次创建新部署（Deployment）时均会报错。若 Node.js 版本已在源代码中显式配置，同样会触发该错误。

所有当前使用 Node.js 10 的已有部署（Deployment）中的 Serverless Functions，将于上述日期自动迁移至 Node.js 12。

如果您的项目正在使用 Node.js 10（无论是在 `package.json` 的 `engines` 字段中指定，还是在项目设置的“通用”页面中手动选择），我们建议您将其升级至最新稳定版本——Node.js 14。

需要帮助迁移到 Node.js 14 吗？[请联系我们](https://vercel.com/support)，我们将为您提供支持。