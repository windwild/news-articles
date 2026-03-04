---
title: "Faster builds for monorepos - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-build-times-for-monorepos"
date: "2022-04-29"
scraped_at: "2026-03-02T10:02:38.947719202+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Apr 29, 2022

2022年4月29日

![](images/faster-builds-for-monorepos-vercel/img_001.jpg)![](images/faster-builds-for-monorepos-vercel/img_002.jpg)

部署到 Vercel 的新旧单体仓库（monorepo）项目将获得更快的构建速度。

Vercel 现在会在构建过程中自动递归缓存 `node_modules`。所有新建及现有的单体仓库项目，均默认启用环境变量 `ENABLE_ROOT_PATH_BUILD_CACHE=1`。对于大型单体仓库，此举可将构建时间缩短数分钟。

也请参阅[相关文档](https://vercel.com/docs/concepts/git/monorepos#step-4:-set-environment-variables)。