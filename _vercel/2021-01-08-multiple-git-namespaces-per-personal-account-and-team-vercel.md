---
title: "Multiple Git namespaces per Personal Account and Team - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/multiple-git-namespaces-per-personal-account-and-team"
date: "2021-01-08"
scraped_at: "2026-03-02T10:06:13.825348603+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jan 8, 2021

2021 年 1 月 8 日

![](images/multiple-git-namespaces-per-personal-account-and-team-vercel/img_001.jpg)

在 Vercel 上将一个 Project 连接到 Git 仓库时，该 Git 仓库此前必须与同一个人账户（Personal Account）或团队（Team）内所有其他 Project 所关联的 Git 仓库处于相同的 Git 命名空间（Git scope）下。

如今，该连接关系已改为在 Project 级别定义（见上图），而非在个人账户或团队级别配置，因此上述限制已被取消。此外，若连接出现异常，相关问题也会直接在 Project 级别呈现。

现在，每个个人账户或团队均可包含多个 Vercel Project，且这些 Project 可分别连接至位于不同 Git 命名空间下的 Git 仓库。这也意味着：在导入 Project 时，Vercel 不再强制指定某个特定的目标个人账户或团队。

也可参阅[相关文档](https://vercel.com/docs/platform/projects#git)。