---
title: "Node.js 24 LTS is now available on Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-24-lts-is-now-available-on-sandbox"
date: "2025-12-10"
scraped_at: "2026-03-02T09:24:11.449623861+00:00"
language: "en"
translated: false
description: "Vercel Sandbox now supports running sandboxes with the Node.js 24 LTS runtime. This is supported in @vercel/sandbox versions 1.1.0 and later."
---




Dec 10, 2025

Vercel Sandbox now supports Node.js version 24.

To run a Sandbox with Node.js 24, upgrade`@vercel/sandbox` to version `1.1.0` or above and set the `runtime` property to `node24`:

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

Read our [Sandbox documentation](https://vercel.com/docs/vercel-sandbox) to learn more.