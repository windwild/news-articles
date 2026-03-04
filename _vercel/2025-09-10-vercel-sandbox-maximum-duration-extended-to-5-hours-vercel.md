---
title: "Vercel Sandbox maximum duration extended to 5 hours - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-sandbox-maximum-duration-extended-to-5-hours"
date: "2025-09-10"
scraped_at: "2026-03-02T09:28:41.545622630+00:00"
language: "en-zh"
translated: true
description: "Pro and Enterprise teams can now run Vercel Sandboxes for up to 5 hours (up from 45 minutes).  This extension unlocks new possibilities for workloads that require longer runtimes"
---
&#123;% raw %}

Sep 10, 2025

2025 年 9 月 10 日

[Pro 和 Enterprise 团队](https://vercel.com/docs/plans) 现在可将 Vercel Sandbox 运行时长延长至最多 5 小时（此前为 45 分钟）。

这一新的最长运行时长支持需要更长时间执行的工作负载，例如大规模数据处理、端到端测试流水线，以及长期运行的智能体（agentic）工作流。

```javascript
const sandbox = await Sandbox.create({

2  // 5 小时超时

3  timeout: 5 * 60 * 60 * 1000,

4});
```

[立即开始使用 Sandbox](https://vercel.com/docs/vercel-sandbox#getting-started)，并在 [文档](https://vercel.com/docs/vercel-sandbox) 中了解更多信息。
&#123;% endraw %}
