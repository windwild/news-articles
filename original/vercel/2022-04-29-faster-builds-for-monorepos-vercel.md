---
title: "Faster builds for monorepos - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-build-times-for-monorepos"
date: "2022-04-29"
scraped_at: "2026-03-02T10:02:38.947719202+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Apr 29, 2022

![](images/faster-builds-for-monorepos-vercel/img_001.jpg)![](images/faster-builds-for-monorepos-vercel/img_002.jpg)

New and existing monorepos deployed to Vercel will experience faster builds.

Vercel now automatically caches `node_modules` recursively when installing dependencies during the build process. `ENABLE_ROOT_PATH_BUILD_CACHE=1` will be set as a default environment variable on all new and existing monorepo projects. For large monorepos, this can decrease build times by minutes.

[Check out the docs](https://vercel.com/docs/concepts/git/monorepos#step-4:-set-environment-variables) as well.