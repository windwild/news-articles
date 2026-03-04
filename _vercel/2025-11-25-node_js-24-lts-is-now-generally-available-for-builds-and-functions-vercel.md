---
render_with_liquid: false
title: "Node.js 24 LTS is now generally available for builds and functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-24-lts-is-now-generally-available-for-builds-and-functions"
date: "2025-11-25"
scraped_at: "2026-03-02T09:24:49.041507407+00:00"
language: "en-zh"
translated: true
description: "Vercel now supports Node.js 24 for builds and functions, featuring a V8 13.6 upgrade, the global URLPattern API, Undici v7 for faster fetch(), and npm v11 for modern package compatibility."
---
render_with_liquid: false
render_with_liquid: false

Nov 25, 2025

2025 年 11 月 25 日

Node.js 版本 24 现已作为 [构建（builds）](https://vercel.com/docs/builds) 和基于 Node 的 [函数（functions）](https://vercel.com/docs/functions) 的运行时环境提供。

如需使用版本 24，请前往 **项目设置（Project Settings）→ 构建与部署（Build and Deployment）→ Node.js 版本（Node.js Version）**，并选择 `24.x`。该版本亦为新建项目的默认 Node.js 版本。

Node.js 24 的主要更新亮点如下：

- [**V8 引擎升级**](https://nodejs.org/en/blog/release/v24.0.0#v8-136) **：** Node.js 24 集成了 V8 JavaScript 引擎 13.6 版本，带来性能提升及多项新 JavaScript 特性，例如 `Float16Array` 和 `Error.isError`

- [**全局 URLPattern API**](https://nodejs.org/en/blog/release/v24.0.0#urlpattern-as-a-global) **：** 提供更简洁的 URL 路由与匹配能力，无需依赖外部库或编写复杂的正则表达式

- [**Undici v7**](https://nodejs.org/en/blog/release/v24.0.0#undici-7) **：** 内置 `fetch` API 得益于更快的 HTTP 性能、增强的 HTTP/2 与 HTTP/3 支持，以及更高效的连接管理

- [**npm v11**](https://nodejs.org/en/blog/release/v24.0.0#npm-11) **：** 随附新版 npm，显著提升了对现代 JavaScript 包的兼容性

当前使用的具体版本为 [24.11.0](https://github.com/nodejs/node/releases/tag/v24.11.0)，系统将自动更新补丁版本；仅保证主版本号（即 `24.x`）保持稳定。

欲了解更多信息，请参阅我们的 [Node.js 运行时文档](https://vercel.com/docs/functions/runtimes/node-js)。