---
title: "Node.js v20 LTS is now available in beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/nodejs-20"
date: "2023-11-16"
scraped_at: "2026-03-02T09:49:37.271882202+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Nov 16, 2023

2023 年 11 月 16 日

![](images/node_js-v20-lts-is-now-available-in-beta-vercel/img_001.jpg)![](images/node_js-v20-lts-is-now-available-in-beta-vercel/img_002.jpg)

![](images/node_js-v20-lts-is-now-available-in-beta-vercel/img_001.jpg)![](images/node_js-v20-lts-is-now-available-in-beta-vercel/img_002.jpg)

As of today, Node.js version 20 can be used as the runtime for [Builds](https://vercel.com/docs/deployments/builds) and [Serverless Functions](https://vercel.com/docs/functions/serverless-functions). Select `20.x` in the Node.js Version section on the General page in the Project Settings. **The default version remains Node.js 18**.

自今日起，Node.js 20 可作为 [构建（Builds）](https://vercel.com/docs/deployments/builds) 和 [无服务器函数（Serverless Functions）](https://vercel.com/docs/functions/serverless-functions) 的运行时环境使用。请在项目设置（Project Settings）的“通用（General）”页面中，于“Node.js 版本（Node.js Version）”选项下选择 `20.x`。**默认版本仍为 Node.js 18**。

Node.js 20 introduces several [new features](https://nodejs.org/en/blog/announcements/v20-release-announce/) including:

Node.js 20 引入了多项 [新特性](https://nodejs.org/en/blog/announcements/v20-release-announce/)，包括：

- 新的实验性权限模型（New experimental permission model）

- 同步版 `import.meta.resolve`

- 稳定版测试运行器（Stable test runner）

- V8 JavaScript 引擎与 Ada（URL 解析器）的性能优化

Node.js 20 is faster and introduces new core APIs eliminating the need for some third-party libraries in your project. Support for Node.js 20 on Vercel is currently in beta.

Node.js 20 运行速度更快，并引入了若干新的核心 API，可减少项目中对部分第三方库的依赖。Vercel 对 Node.js 20 的支持目前处于 Beta 阶段。

The exact version used by Vercel is [20.5.1](https://github.com/nodejs/node/releases/tag/v20.5.1) and will automatically update minor and patch releases. Therefore, only the major version (`20.x`) is guaranteed.

Vercel 当前实际使用的具体版本为 [20.5.1](https://github.com/nodejs/node/releases/tag/v20.5.1)，并将自动更新次要版本（minor）和补丁版本（patch）。因此，仅保证主版本号（`20.x`）的兼容性。

[Read the documentation](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js) for more.

更多详情，请参阅[文档](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js)。