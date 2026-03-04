---
render_with_liquid: false
title: "Jekyll deployments are now 15x faster - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/jekyll-deployments-are-now-15x-faster"
date: "2021-02-25"
scraped_at: "2026-03-02T10:05:40.459440570+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Feb 25, 2021

2021 年 2 月 25 日

![](images/jekyll-deployments-are-now-15x-faster-vercel/img_001.jpg)

![](images/jekyll-deployments-are-now-15x-faster-vercel/img_001.jpg)

Starting today, Jekyll dependencies from `bundle install` will be cached and used for subsequent Deployments. A "hello world" Jekyll application now builds **15x faster** – down from 3 minutes to 11 seconds with cache.

从今天开始，`bundle install` 安装的 Jekyll 依赖项将被缓存，并在后续部署（Deployments）中复用。一个“Hello World”级别的 Jekyll 应用构建速度现在提升了 **15 倍**——启用缓存后，构建时间从原来的 3 分钟缩短至仅需 11 秒。

You can verify that the build cache was used by viewing your Deployment's build logs.

您可通过查看部署（Deployment）的构建日志，确认构建缓存是否已被成功使用。