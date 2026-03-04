---
title: "Node.js 18 is being deprecated on September 1, 2025 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-18-is-being-deprecated"
date: "2025-01-16"
scraped_at: "2026-03-02T09:37:53.140101714+00:00"
language: "en-zh"
translated: true
description: "Following the Node.js 18 end of life on April 30, 2025, we are deprecating Node.js 18 for Builds and Functions on September 1, 2025."
---

render_with_liquid: false
Jan 16, 2025

2025 年 1 月 16 日

继 Node.js 18 于 2025 年 4 月 30 日终止支持（End of Life）之后，Vercel 将于 2025 年 9 月 1 日起，在构建（Builds）和函数（Functions）中**弃用 Node.js 18**。

**我的现有部署会受到影响吗？**

不会，使用无服务器函数（Serverless Functions）的现有部署**将不受影响**。

**我何时将无法再使用 Node.js 18？**

自 2025 年 9 月 1 日起，Node.js 18 将在[项目设置](https://vercel.com/docs/functions/serverless-functions/runtimes/node-js#node.js-version)中被禁用。对于当前将 Node.js 版本设为 18 的函数项目，创建新部署时将显示错误提示。

**如何升级我的 Node.js 版本？**

您可通过[项目设置](https://vercel.com/docs/functions/serverless-functions/runtimes/node-js#node.js-version)配置 Node.js 版本，或在 `package.json` 文件中通过 `engines` 字段进行配置。

**如何查看哪些项目会受到此次弃用的影响？**

您可通过以下方式查看哪些项目会受本次弃用影响：

Terminal

终端

```bash
npm i -g vercel@latest

vercel project ls --update-required
```

```bash
npm i -g vercel@latest

vercel project ls --update-required
```

View projects that require updating.

查看需要更新的项目。