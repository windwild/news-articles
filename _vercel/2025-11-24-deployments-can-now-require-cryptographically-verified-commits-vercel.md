---
render_with_liquid: false
title: "Deployments can now require cryptographically-verified commits - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deployments-can-now-require-cryptographically-verified-commits"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:01.252179087+00:00"
language: "en-zh"
translated: true
description: "When enabled, Vercel will only create deployments for commits that have been verified by GitHub. For all other commits, the deployment will be automatically canceled."
---
render_with_liquid: false
render_with_liquid: false

Nov 24, 2025

2025 年 11 月 24 日

![](images/deployments-can-now-require-cryptographically-verified-commits-vercel/img_001.jpg)![](images/deployments-can-now-require-cryptographically-verified-commits-vercel/img_002.jpg)

Vercel now supports commit verification, letting you protect your deployments by requiring commits to be cryptographically verified before they’re deployed from GitHub.

Vercel 现已支持提交验证，您可通过要求所有从 GitHub 部署的提交均经过密码学验证，来保护您的部署安全。

Enable it for GitHub-connected projects in your [project settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fgit).

您可在项目设置中为已连接 GitHub 的项目启用该功能：[项目设置](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fgit)。

Learn more about commit signing and verification on [GitHub](https://docs.github.com/en/authentication/managing-commit-signature-verification) or read more about the setting in our [docs](https://vercel.com/docs/project-configuration/git-settings#verified-commits).

如需了解有关提交签名与验证的更多信息，请参阅 [GitHub 官方文档](https://docs.github.com/en/authentication/managing-commit-signature-verification)，或查阅我们的 [文档](https://vercel.com/docs/project-configuration/git-settings#verified-commits) 以深入了解该配置项。