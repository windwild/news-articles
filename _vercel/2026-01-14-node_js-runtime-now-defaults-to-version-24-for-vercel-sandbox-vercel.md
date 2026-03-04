---
title: "Node.js runtime now defaults to version 24 for Vercel Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-runtime-now-defaults-to-version-24-for-vercel-sandbox"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:59.416337190+00:00"
language: "en-zh"
translated: true
description: "Node.js runtime in Vercel Sandbox now defaults to Node.js 24 for newer features and performance improvements."
---
{% raw %}

Jan 14, 2026

2026 年 1 月 14 日

Vercel Sandbox for Node.js 现在默认使用 Node.js 24。此举使 Node.js 运行时与最新的 Node.js 特性和性能改进保持同步。

如果您未显式配置运行时，Sandbox 将默认使用 Node.js 24（如下所示）。

main.ts

```typescript
import { Sandbox } from "@vercel/sandbox";

async function main() {
  const sandbox = await Sandbox.create();
  const version = await sandbox.runCommand("node", ["-v"]);
  console.log(`Node.js version: ${await version.stdout()}`);
}
```

7}



main().catch(console.error);
```

阅读 [Sandbox 文档](https://vercel.com/docs/vercel-sandbox) 以了解更多信息。
{% endraw %}
