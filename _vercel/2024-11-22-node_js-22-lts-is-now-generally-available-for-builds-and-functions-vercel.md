---
title: "Node.js 22 LTS is now generally available for builds and functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-22-lts-is-now-available"
date: "2024-11-22"
scraped_at: "2026-03-02T09:39:04.871524066+00:00"
language: "en-zh"
translated: true
description: "Node.js version 22 is available as the runtime on Vercel for your builds and functions leveraging Node. Node 22 brings improved Stream performance, improved AbortSignal performance, improved Buffer pe..."
---
{% raw %}

Nov 22, 2024

2024 年 11 月 22 日

![](images/node_js-22-lts-is-now-generally-available-for-builds-and-functions-vercel/img_001.jpg)![](images/node_js-22-lts-is-now-generally-available-for-builds-and-functions-vercel/img_002.jpg)

Starting today, Node.js version 22 is available as the runtime for your [builds](https://vercel.com/docs/deployments/builds) and [functions](https://vercel.com/docs/functions/serverless-functions) leveraging Node. To use version 22, go to [**Project Settings** \> **General** \> **Node.js Version**](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fgeneral&title=Enable+Node.js+22.x) and select `22.x`. This is also the default version for new projects.

从今天起，Node.js 22 版本已作为运行时正式支持您的 [构建（builds）](https://vercel.com/docs/deployments/builds) 和基于 Node 的 [函数（functions）](https://vercel.com/docs/functions/serverless-functions)。如需使用 Node.js 22，请前往 [**项目设置（Project Settings）** > **常规（General）** > **Node.js 版本（Node.js Version）**](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fgeneral&title=Enable+Node.js+22.x)，并选择 `22.x`。该版本亦为新建项目的默认 Node.js 版本。

Node.js 22 主要特性亮点：

- [流（Stream）性能提升](https://nodejs.org/en/blog/announcements/v22-release-announce#stream-default-high-water-mark)：更高的默认水位线（high water mark）在整体上带来性能提升，代价是内存占用略有增加

- [AbortSignal 性能提升](https://nodejs.org/en/blog/announcements/v22-release-announce#improve-performance-of-abortsignal-creation)：优化了 AbortSignal 的创建过程，从而提升了 `fetch` 和测试运行器（test runner）的性能

- [Buffer 性能提升](https://github.com/nodejs/node/releases/tag/v22.7.0)：`Buffer.copy` 和 `Buffer.write` 方法得到显著优化，带来整体性能提升

- [CommonJS（CJS）与 ES 模块（ESM）互操作性增强](https://nodejs.org/en/blog/announcements/v22-release-announce#support-requireing-synchronous-esm-graphs)：新增对通过 `require()` 同步加载 ESM 模块图（synchronous ESM graphs）的支持

The current version used by Vercel is [22.11.0](https://github.com/nodejs/node/releases/tag/v22.11.0) and will automatically update minor and patch releases. Therefore, only the major version (`22.x`) is guaranteed.

Vercel 当前使用的版本为 [22.11.0](https://github.com/nodejs/node/releases/tag/v22.11.0)，并将自动更新次要版本（minor）和补丁版本（patch）。因此，仅保证主版本号（major version，即 `22.x`）的兼容性。

Read our [Node.js runtime documentation](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js) to learn more.

欲了解更多信息，请参阅我们的 [Node.js 运行时文档（Node.js runtime documentation）](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js)。
{% endraw %}
