---
title: "Node.js 24 LTS is now available on Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-24-lts-is-now-available-on-sandbox"
date: "2025-12-10"
scraped_at: "2026-03-02T09:24:11.449623861+00:00"
language: "en-zh"
translated: true
description: "Vercel Sandbox now supports running sandboxes with the Node.js 24 LTS runtime. This is supported in @vercel/sandbox versions 1.1.0 and later."
---
{% raw %}

Dec 10, 2025

2025 年 12 月 10 日

Vercel Sandbox now supports Node.js version 24.

Vercel Sandbox 现已支持 Node.js 24 版本。

To run a Sandbox with Node.js 24, upgrade `@vercel/sandbox` to version `1.1.0` or above and set the `runtime` property to `node24`:

如需使用 Node.js 24 运行 Sandbox，请将 `@vercel/sandbox` 升级至 `1.1.0` 或更高版本，并将 `runtime` 属性设为 `node24`：

main.ts

main.ts

```typescript
import { Sandbox } from "@vercel/sandbox";



async function main() {

4  const sandbox = await Sandbox.create();

5  const version = await sandbox.runCommand("node", ["-v"]);

6  console.log(`Node.js version: ${await version.stdout()}`);
```

7}



main().catch(console.error);
```

Read our [Sandbox documentation](https://vercel.com/docs/vercel-sandbox) to learn more.

请阅读我们的 [Sandbox 文档](https://vercel.com/docs/vercel-sandbox) 以了解更多信息。
{% endraw %}
