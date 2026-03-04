---
render_with_liquid: false
title: "Environments Variables per Git branch - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/environments-variables-per-git-branch"
date: "2021-04-21"
scraped_at: "2026-03-02T10:05:23.854355685+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Apr 21, 2021

2021 年 4 月 21 日

![](images/environments-variables-per-git-branch-vercel/img_001.jpg)

![](images/environments-variables-per-git-branch-vercel/img_001.jpg)

您现在可以在预览环境（Preview Environment）中为特定的 **Git 分支** 添加环境变量（Environment Variables）。

当您向某个分支推送代码时，系统将同时使用预览环境变量与该分支专属的变量。若分支专属变量与预览环境变量同名，则前者将覆盖后者。这意味着您无需为每个分支重复配置全部现有的预览环境变量——只需添加您希望覆盖的变量值即可。

此外，您不再需要手动指定环境变量的类型（如 _明文（Plaintext）_、_密钥（Secret）_ 或 _由系统提供（Provided by System）_），因为 **所有变量值现在均自动加密**。这一全新设计在保障安全性的同时兼顾便捷性：您后续既可通过 UI 编辑界面轻松查看变量值，也可运行 `vercel env pull` 命令将开发环境（Development Environment）变量本地拉取。

此前我们引入了 _由系统提供（Provided by System）_ 这一选项，是因为某些框架（如 Next.js）需将系统变量（例如 `VERCEL_URL`）映射为带框架前缀的变量（例如 `NEXT_PUBLIC_VERCEL_URL`）。如今您无需再手动配置此类映射，因为 **系统会根据您所选的框架预设（Framework Preset）自动添加带前缀的变量**。

请参阅 [相关文档](https://vercel.com/docs/environment-variables) 以了解更多信息。