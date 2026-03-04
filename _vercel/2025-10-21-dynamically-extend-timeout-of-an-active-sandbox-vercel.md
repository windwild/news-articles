---
title: "Dynamically extend timeout of an active Sandbox - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/dynamically-extend-timeout-of-an-active-sandbox"
date: "2025-10-21"
scraped_at: "2026-03-02T09:26:51.156126873+00:00"
language: "en-zh"
translated: true
description: "You can now extend the duration of a running Vercel Sandbox using the new extendTimeout method. This lets you keep long-running sandboxes alive beyond their initial timeout. It is useful for workflows..."
---

render_with_liquid: false
Oct 21, 2025

2025 年 10 月 21 日

You can now extend the duration of a running Vercel Sandbox using the new `extendTimeout` method.

现在，您可使用新增的 `extendTimeout` 方法延长正在运行的 Vercel Sandbox 的持续时间。

This lets long-running sandboxes stay active beyond their initial timeout, making it easier to support workflows like chained agentic tasks or multi-step code generation that take longer than expected.

这使得长时间运行的 Sandbox 能够在初始超时之后继续保持活跃，从而更轻松地支持链式智能体任务（chained agentic tasks）或多步代码生成等耗时超出预期的工作流。

```javascript
const sandbox = await Sandbox.create({

2  // 15 minute timeout

3  timeout: 15 * 60 * 1000,

4});



6// Extend by 10 minutes

await sandbox.extendTimeout(10 * 60 * 1000);
```

```javascript
const sandbox = await Sandbox.create({

2  // 15 分钟超时

3  timeout: 15 * 60 * 1000,

4});



6// 延长 10 分钟

await sandbox.extendTimeout(10 * 60 * 1000);
```

You can extend the timeout multiple times until the [maximum runtime for your plan](https://vercel.com/docs/vercel-sandbox/pricing#maximum-runtime-duration) is reached.

您可以多次延长超时时间，直至达到您所选套餐的[最大运行时长](https://vercel.com/docs/vercel-sandbox/pricing#maximum-runtime-duration)。

Pro and Enterprise plans support up to 5 hours, with the Hobby plan supporting up to 45 minutes.

Pro 和 Enterprise 套餐支持最长 5 小时的运行时长，Hobby 套餐则支持最长 45 分钟。

[Get started with Sandbox now](https://vercel.com/docs/vercel-sandbox#getting-started) and [learn more in the docs](https://vercel.com/docs/vercel-sandbox/pricing).

[立即开始使用 Sandbox](https://vercel.com/docs/vercel-sandbox#getting-started)，并在[文档中了解更多信息](https://vercel.com/docs/vercel-sandbox/pricing)。