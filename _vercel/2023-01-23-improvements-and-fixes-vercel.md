---
title: "Improvements and fixes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/january-2023"
date: "2023-01-23"
scraped_at: "2026-03-02T09:56:00.066313790+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jan 23, 2023

2023 年 1 月 23 日

![](images/improvements-and-fixes-vercel/img_001.jpg)

- **图像优化（Image Optimization）：** Vercel 图像优化所使用的源图像现在可在 [用量标签页（Usage tab）](https://vercel.com/docs/concepts/limits/usage) 中查看。

- **Vercel CLI：** 发布了 [v28.12.7 版本](https://github.com/vercel/vercel/releases/tag/vercel%4028.12.7)，增强了对 [Gatsby 的支持](https://vercel.com/changelog/improved-support-for-gatsby-sites)。

- **Vercel 函数的 Python 运行时（Python Runtime for Vercel Functions）：** 改进了使用 Python 运行时开发 Vercel 无服务器函数（Serverless Functions）的文档和[示例](https://vercel.com/templates/python)。

- **边缘函数（Edge Functions）：** 改进了源映射（source map）的解析与过滤功能，使错误信息更易读、更具可操作性。

- **文档搜索（Docs search）：** 优化了文档搜索体验——将 `CMD+K` 设为默认快捷键，提升了搜索结果的准确性和相关性，并新增基于路径的推荐功能。

- **关于 `.vercelignore` 文件的变更：** 在“根目录（root directory）”中创建了 `.vercelignore` 文件，以修复一个 Bug：当已设置“根目录”时，从 Git 触发的部署无法正确识别 `.vercelignore` 文件。