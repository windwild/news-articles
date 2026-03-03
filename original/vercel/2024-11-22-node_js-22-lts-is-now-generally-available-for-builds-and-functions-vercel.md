---
title: "Node.js 22 LTS is now generally available for builds and functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/node-js-22-lts-is-now-available"
date: "2024-11-22"
scraped_at: "2026-03-02T09:39:04.871524066+00:00"
language: "en"
translated: false
description: "Node.js version 22 is available as the runtime on Vercel for your builds and functions leveraging Node. Node 22 brings improved Stream performance, improved AbortSignal performance, improved Buffer pe..."
---




Nov 22, 2024

![](images/node_js-22-lts-is-now-generally-available-for-builds-and-functions-vercel/img_001.jpg)![](images/node_js-22-lts-is-now-generally-available-for-builds-and-functions-vercel/img_002.jpg)

Starting today, Node.js version 22 is available as the runtime for your [builds](https://vercel.com/docs/deployments/builds) and [functions](https://vercel.com/docs/functions/serverless-functions) leveraging Node. To use version 22, go to [**Project Settings** \> **General** \> **Node.js Version**](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fgeneral&title=Enable+Node.js+22.x) and select `22.x`. This is also the default version for new projects.

Node.js 22 highlights:

- [Improved Stream performance](https://nodejs.org/en/blog/announcements/v22-release-announce#stream-default-high-water-mark): higher default water mark provides performance boosts across the board at the cost of slightly higher memory usage

- [Improved AbortSignal performance](https://nodejs.org/en/blog/announcements/v22-release-announce#improve-performance-of-abortsignal-creation): optimized AbortSignal creation improves performance in fetch and the test runner

- [Improved Buffer performance](https://github.com/nodejs/node/releases/tag/v22.7.0): significant improvements to the `Buffer.copy` and `Buffer.write` methods lead to overall performance boost

- [Improved CJS interop with ESM](https://nodejs.org/en/blog/announcements/v22-release-announce#support-requireing-synchronous-esm-graphs): added support for `require()`ing synchronous ESM module graphs


The current version used by Vercel is [22.11.0](https://github.com/nodejs/node/releases/tag/v22.11.0) and will automatically update minor and patch releases. Therefore, only the major version (`22.x`) is guaranteed.

Read our [Node.js runtime documentation](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js) to learn more.