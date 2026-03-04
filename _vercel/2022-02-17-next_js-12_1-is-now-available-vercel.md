---
title: "Next.js 12.1 is now available - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/next-js-12-1"
date: "2022-02-17"
scraped_at: "2026-03-02T10:02:59.903967388+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Feb 17, 2022

2022 年 2 月 17 日

![](images/next_js-12_1-is-now-available-vercel/img_001.jpg)

我们很高兴随 Next.js 12.1 发布最受社区期待的功能之一：

- **按需 ISR（Beta 版）：** 使用 `getStaticProps` 即时重新验证静态页面。

- **SWC 支持范围进一步扩展：** 新增对 `styled-components`、Relay 等框架的支持。

- **`next/jest` 插件：** 基于 SWC 的零配置 Jest 测试支持。

- **SWC 加速代码压缩（Release Candidate）：** 压缩速度比 Terser 快约 7 倍。

- **自托管体验优化：** Docker 镜像体积减小约 80%。

- **React 18 与服务端组件（Alpha 版）：** 稳定性与兼容性进一步提升。

- **开发者调研：** 欢迎通过您的反馈帮助我们持续改进 Next.js。

Starting today when deployed to Vercel, on-demand revalidation propagates globally in ~300ms when pushing pages to the edge. [Read the 12.1 blog post](https://nextjs.org/blog/next-12-1) to learn more.

从今天起，当部署到 Vercel 时，按需重新验证（on-demand revalidation）在将页面推送至边缘节点时，可在约 300 毫秒内全局生效。[阅读 12.1 版本博客文章](https://nextjs.org/blog/next-12-1) 了解详情。