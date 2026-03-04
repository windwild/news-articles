---
title: "Faster builds with per-branch caching - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-builds-with-per-branch-caching"
date: "2021-03-16"
scraped_at: "2026-03-02T10:05:01.020674965+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Mar 16, 2021

2021 年 3 月 16 日

![](images/faster-builds-with-per-branch-caching-vercel/img_001.jpg)

构建步骤（Build Step）现在在读取和写入缓存时，会考虑当前的 Git 分支。

由于首次向某一分支推送代码时会创建一个部署，但此时尚无该分支专属的缓存，因此将从 Production（生产）分支的缓存中读取。此后对该分支的后续推送，则会从其自身的分支专属缓存中读取。

这意味着预览分支（Preview branches）将不再向 Production 分支的缓存中写入内容。由此带来更快的构建速度，因为在一个分支中更改依赖项，不会影响其他分支的缓存。

此外，当构建失败时，我们不再自动删除构建缓存。相反，您可通过控制台（Dashboard）上的“重新部署”（Redeploy）按钮，手动触发一次不使用缓存的构建。

我们在一个大型 Next.js 应用上的测试表明，增量构建时间从 **13 分钟** 缩短至 **4 分钟**。

也欢迎查阅 [相关文档](https://vercel.com/docs/build-step#caching)。