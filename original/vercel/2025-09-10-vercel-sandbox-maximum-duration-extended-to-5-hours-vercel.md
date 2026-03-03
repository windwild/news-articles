---
title: "Vercel Sandbox maximum duration extended to 5 hours - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-sandbox-maximum-duration-extended-to-5-hours"
date: "2025-09-10"
scraped_at: "2026-03-02T09:28:41.545622630+00:00"
language: "en"
translated: false
description: "Pro and Enterprise teams can now run Vercel Sandboxes for up to 5 hours (up from 45 minutes).  This extension unlocks new possibilities for workloads that require longer runtimes"
---




Sep 10, 2025

[Pro and Enterprise teams](https://vercel.com/docs/plans) can now run Vercel Sandboxes for up to 5 hours (up from 45 minutes).

This new max duration unlocks workloads that require longer runtimes, such as large-scale data processing, end-to-end testing pipelines, and long-lived agentic workflows.

```javascript
const sandbox = await Sandbox.create({

2  // 5 hours timeout

3  timeout: 5 * 60 * 60 * 1000,

4});
```

[Get started with Sandbox](https://vercel.com/docs/vercel-sandbox#getting-started) now and learn more in the [docs](https://vercel.com/docs/vercel-sandbox).