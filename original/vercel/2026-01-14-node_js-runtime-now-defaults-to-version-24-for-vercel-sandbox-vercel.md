---
title: "Node.js runtime now defaults to version 24 for Vercel Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-runtime-now-defaults-to-version-24-for-vercel-sandbox"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:59.416337190+00:00"
language: "en"
translated: false
description: "Node.js runtime in Vercel Sandbox now defaults to Node.js 24 for newer features and performance improvements."
---




Jan 14, 2026

Vercel Sandbox for Node.js now uses Node.js 24 by default. This keeps the Node.js runtime aligned with the latest Node.js features and performance improvements.

If you don’t explicitly configure a runtime, Sandbox will use Node.js 24 (as shown below).

main.ts

```typescript
import { Sandbox } from "@vercel/sandbox";



async function main() {

4  const sandbox = await Sandbox.create();

5  const version = await sandbox.runCommand("node", ["-v"]);

6  console.log(`Node.js version: ${await version.stdout()}`);

7}



main().catch(console.error);
```

Read the [Sandbox documentation](https://vercel.com/docs/vercel-sandbox) to learn more.