---
title: "Automatically detect and replay layout shifts from the Vercel Toolbar - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatically-detect-and-replay-layout-shifts"
date: "2023-11-14"
scraped_at: "2026-03-02T09:49:39.396409795+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Nov 14, 2023

2023 年 11 月 14 日

![](images/automatically-detect-and-replay-layout-shifts-from-the-vercel-toolbar-vercel/img_001.jpg)![](images/automatically-detect-and-replay-layout-shifts-from-the-vercel-toolbar-vercel/img_002.jpg)

Vercel 现在可通过 Vercel Toolbar 自动检测并重放您各次部署中的[布局偏移（layout shifts）](https://vercel.com/docs/speed-insights#cumulative-layout-shift-cls)。

布局偏移将通过 Toolbar 进行报告并发出通知。每次报告的偏移均包含导致该偏移的原因摘要，以及受其影响的元素数量。此外，您还可重放并动画化该偏移，以便再次直观查看。

Toolbar 会自动添加至所有预览部署（Preview Deployments）中；同时，您也可在本地开发环境（localhost）及生产环境中使用它（通常需配合您自身的员工身份认证机制），只需安装并使用 [@vercel/toolbar 包](https://vercel.com/docs/workflow-collaboration/comments/in-production-and-localhost) 即可。

[查阅相关文档](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) 以了解更多信息。