---
render_with_liquid: false
title: "Node.js 16 is being deprecated on January 31, 2025 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-16-deprecation"
date: "2023-11-29"
scraped_at: "2026-03-02T09:49:16.186998634+00:00"
language: "en-zh"
translated: true
description: "Following the Node.js 16 end of life on September 11, 2023, we are deprecating Node.js 16 for Builds and Functions on January 31, 2025."
---
render_with_liquid: false
render_with_liquid: false

Nov 29, 2023

2023 年 11 月 29 日

Following the Node.js 16 end of life on September 11, 2023, we are deprecating Node.js 16 for Builds and Functions on January 31, 2025.

继 Node.js 16 于 2023 年 9 月 11 日正式结束生命周期（End of Life）后，Vercel 将于 2025 年 1 月 31 日起，在构建（Builds）和无服务器函数（Functions）中弃用 Node.js 16。

**Will my existing deployments be affected?**

**我的现有部署会受到影响吗？**

No, existing deployments with Serverless Functions **will not be affected.**

不会，使用无服务器函数（Serverless Functions）的现有部署**不受影响**。

**When will I no longer be able to use Node.js 16?**

**我何时将无法再使用 Node.js 16？**

On January 31, 2025, Node.js 16 will be disabled in [project settings](https://vercel.com/docs/functions/serverless-functions/runtimes/node-js#node.js-version). Existing projects using 16 as the version for Functions will display an error when a new deployment is created.

自 2025 年 1 月 31 日起，Node.js 16 将在[项目设置](https://vercel.com/docs/functions/serverless-functions/runtimes/node-js#node.js-version)中被禁用。对于当前将 Node.js 16 设为函数运行时版本的项目，创建新部署时将显示错误提示。

**How can I upgrade my Node.js version?**

**如何升级我的 Node.js 版本？**

You can configure your Node.js version in [project settings](https://vercel.com/docs/functions/serverless-functions/runtimes/node-js#node.js-version) or through the `engines` field in `package.json`.

您可通过[项目设置](https://vercel.com/docs/functions/serverless-functions/runtimes/node-js#node.js-version)进行配置，或在 `package.json` 文件中通过 `engines` 字段指定 Node.js 版本。

**How can I see which of my projects are affected?**

**如何查看我的哪些项目会受到此次弃用的影响？**

You can see which of your projects are affected by this deprecation with:

您可通过以下方式查看哪些项目会受此次弃用影响：

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