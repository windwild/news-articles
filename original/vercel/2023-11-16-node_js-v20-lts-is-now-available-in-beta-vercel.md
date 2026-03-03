---
title: "Node.js v20 LTS is now available in beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/nodejs-20"
date: "2023-11-16"
scraped_at: "2026-03-02T09:49:37.271882202+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 16, 2023

![](images/node_js-v20-lts-is-now-available-in-beta-vercel/img_001.jpg)![](images/node_js-v20-lts-is-now-available-in-beta-vercel/img_002.jpg)

As of today, Node.js version 20 can be used as the runtime for [Builds](https://vercel.com/docs/deployments/builds) and [Serverless Functions](https://vercel.com/docs/functions/serverless-functions). Select `20.x` in the Node.js Version section on the General page in the Project Settings. **The default version remains Node.js 18**.

Node.js 20 introduces several [new features](https://nodejs.org/en/blog/announcements/v20-release-announce/) including:

- New experimental permission model

- Synchronous `import.meta.resolve`

- Stable test runner

- Performance updates to V8 JavaScript Engine and Ada (URL Parser)


Node.js 20 is faster and introduces new core APIs eliminating the need for some third-party libraries in your project. Support for Node.js 20 on Vercel is currently in beta.

The exact version used by Vercel is [20.5.1](https://github.com/nodejs/node/releases/tag/v20.5.1) and will automatically update minor and patch releases. Therefore, only the major version (`20.x`) is guaranteed.

[Read the documentation](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/node-js) for more.