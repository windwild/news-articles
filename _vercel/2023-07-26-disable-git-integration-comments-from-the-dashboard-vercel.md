---
title: "Disable Git Integration comments from the dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/disable-git-integration-comments"
date: "2023-07-26"
scraped_at: "2026-03-02T09:51:30.087199341+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Jul 26, 2023

2023 年 7 月 26 日

![](images/disable-git-integration-comments-from-the-dashboard-vercel/img_001.jpg)![](images/disable-git-integration-comments-from-the-dashboard-vercel/img_002.jpg)

我们已在 [Vercel 控制台](https://vercel.com/docs/concepts/dashboard-features) 的“[已连接的 Git 仓库](https://vercel.com/docs/concepts/deployments/git/vercel-for-github#silence-github-comments)”设置中新增了若干选项。现在，您可以分别配置 Vercel 机器人是否在以下场景中发表评论：

- 拉取请求（Pull Requests）

- 生产环境提交（Production Commits）

这些设置适用于所有已连接的仓库，而不仅限于 GitHub 仓库。

此前，`vercel.json` 文件中提供了一个 `github.silent` 配置项，但该配置项无法实现更精细的评论禁用控制。**我们将于 2023 年 9 月 25 日（星期一）起弃用该配置项。** 当前无需采取任何操作以应对弃用。在该日期之前，若您已在 `vercel.json` 文件中设置了该选项，我们将继续读取该配置，并相应地同步更新控制台中的配置。
&#123;% endraw %}
