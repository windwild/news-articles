---
title: "Automatic build fix suggestions with Vercel Agent - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-build-fix-suggestions-with-vercel-agent"
date: "2026-02-17"
scraped_at: "2026-03-02T09:21:30.246683124+00:00"
language: "en-zh"
translated: true
description: "Get automatic code fix suggestions from Vercel Agent when builds fail—directly in GitHub Pull Request reviews or the Vercel Dashboard, based on your code and build logs."
---

render_with_liquid: false
Feb 17, 2026

2026 年 2 月 17 日

您现在可以在 GitHub 拉取请求（Pull Request）评审中，或在 Vercel 控制台（Dashboard）中，直接通过 Vercel Agent 获取针对构建失败的自动代码修复建议。

当 Vercel Agent 评审您的拉取请求时，它会扫描您的部署以识别构建错误；一旦检测到失败，便会基于您的代码和构建日志，自动生成相应的代码修复建议。

![Vercel Agent - Automatic code suggestion on GitHub pull request](images/automatic-build-fix-suggestions-with-vercel-agent-vercel/img_001.jpg)![Vercel Agent - Automatic code suggestion on GitHub pull request](images/automatic-build-fix-suggestions-with-vercel-agent-vercel/img_002.jpg)Vercel Agent — GitHub 拉取请求中的自动代码建议

此外，每当 Vercel 控制台检测到构建错误时，Vercel Agent 也会在控制台内自动提供代码修复建议，并为您生成一个 GitHub 拉取请求，供团队评审后再合并至主代码库。

![Vercel Agent - Build fix suggestions on the Vercel Dashboard](images/automatic-build-fix-suggestions-with-vercel-agent-vercel/img_003.jpg)![Vercel Agent - Build fix suggestions on the Vercel Dashboard](images/automatic-build-fix-suggestions-with-vercel-agent-vercel/img_004.jpg)Vercel Agent — Vercel 控制台中的构建修复建议

立即前往 [Agent 控制台](https://vercel.com/~/agent) 开始使用 Vercel Agent 进行代码评审，或查阅 [文档](https://vercel.com/docs/agent) 了解更多信息。