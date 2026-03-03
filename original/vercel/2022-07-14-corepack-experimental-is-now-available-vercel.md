---
title: "Corepack (experimental) is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/corepack-experimental-is-now-available"
date: "2022-07-14"
scraped_at: "2026-03-02T10:01:21.244927114+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 14, 2022

![](images/corepack-experimental-is-now-available-vercel/img_001.jpg)![](images/corepack-experimental-is-now-available-vercel/img_002.jpg)

[Corepack](https://nodejs.org/docs/latest-v16.x/api/corepack.html) allows you to use a specific package manager version (pnpm, yarn, npm) in your Project. Starting today, you can enable experimental Corepack support.

Enable Corepack by adding [`packageManager`](https://nodejs.org/docs/latest-v16.x/api/packages.html#packagemanager) to your `package.json` file and `ENABLE_EXPERIMENTAL_COREPACK=1` as an Environment Variable in your Project. Corepack is experimental and not subject to semantic versioning rules. Breaking changes or removal may occur in any future release of Node.js.

[Check out the documentation](https://vercel.com/docs/concepts/deployments/configure-a-build#corepack) as well.