---
title: "Dynamically extend timeout of an active Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/dynamically-extend-timeout-of-an-active-sandbox"
date: "2025-10-21"
scraped_at: "2026-03-02T09:26:51.156126873+00:00"
language: "en"
translated: false
description: "You can now extend the duration of a running Vercel Sandbox using the new extendTimeout method. This lets you keep long-running sandboxes alive beyond their initial timeout. It is useful for workflows..."
---




Oct 21, 2025

You can now extend the duration of a running Vercel Sandbox using the new `extendTimeout` method.

This lets long-running sandboxes stay active beyond their initial timeout, making it easier to support workflows like chained agentic tasks or multi-step code generation that take longer than expected.

```javascript
const sandbox = await Sandbox.create({

2  // 15 minute timeout

3  timeout: 15 * 60 * 1000,

4});



6// Extend by 10 minutes

await sandbox.extendTimeout(10 * 60 * 1000);
```

You can extend the timeout multiple times until the [maximum runtime for your plan](https://vercel.com/docs/vercel-sandbox/pricing#maximum-runtime-duration) is reached.

Pro and Enterprise plans support up to 5 hours, with the Hobby plan supporting up to 45 minutes.

[Get started with Sandbox now](https://vercel.com/docs/vercel-sandbox#getting-started) and [learn more in the docs](https://vercel.com/docs/vercel-sandbox/pricing).