---
render_with_liquid: false
title: "URLs are becoming consistent - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/urls-are-becoming-consistent"
date: "2021-01-20"
scraped_at: "2026-03-02T10:06:05.243220173+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Jan 20, 2021

2021 年 1 月 20 日

![](images/urls-are-becoming-consistent-vercel/img_001.jpg)

我们收集到的大量用户反馈表明，Vercel 当前提供的 URL 过于复杂。作为简化 URL 策略的一部分，我们将于 **2021 年 2 月 20 日**起，开始统一采用一致的格式：

- 原以 `now.sh` 结尾的 **自定义域名（Custom Domains）** 和 **自动 URL（Automatic URLs）**，将改为以 `vercel.app` 结尾。

- 类似 `project-d418mhwf5.vercel.app` 的 **自动部署 URL（Automatic Deployment URLs）**，将增加所属 Vercel 团队范围（scope）的 slug，使其与自动分支 URL 格式保持一致：`project-d418mhwf5-team.vercel.app`。

- 类似 `project-git-update.team.vercel.app` 的 **自动分支 URL（Automatic Branch URLs）**，将移除第二级子域名，改用短横线（dash）连接：`project-git-update-team.vercel.app`。

- 类似 `project.team.vercel.app` 的 **自动项目 URL（Automatic Project URLs）**，以及类似 `project-user.team.vercel.app` 的 **自动团队成员 URL（Automatic Team Member URLs）**，其调整方式将与自动分支 URL 一致。

我们建议：**切勿在生产环境（Production）中依赖任何自动 URL**，而应改用 [自定义域名（Custom Domains）](https://vercel.com/docs/custom-domains)。若无法使用自定义域名，请确保所有向这些 URL 发起请求的程序均支持 HTTP 308 重定向（如同现代浏览器那样）。