---
title: "Improvements and fixes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/november-2022"
date: "2022-11-14"
scraped_at: "2026-03-02T09:59:50.840111853+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 14, 2022

![](images/improvements-and-fixes-vercel/img_001.jpg)![](images/improvements-and-fixes-vercel/img_002.jpg)

With your feedback, we've shipped dozens of bug fixes and small feature requests to improve your product experience.

- **Vercel CLI:** [**28.5.0**](https://github.com/vercel/vercel/releases/tag/vercel%4028.5.0) was released with improved `vc build` monorepo support.

- **Build without cache via env:** It's now possible to force a build through Git that skips the build cache by setting the `VERCEL_FORCE_NO_BUILD_CACHE` [environment variable](https://vercel.com/docs/concepts/deployments/troubleshoot-a-build#managing-build-cache) in your project settings.

- **Environment variables:** Each deployment on Vercel can now support up to 1000 environment variables instead of only 100.

- **Vercel dashboard UI:** The primary and secondary navigation bars are now full width so that each page UI has the option to maintain a max-width or take advantage of the whole viewport.

- **Vercel menu component:** The menu dropdown in your dashboard is now slightly more compact on desktop with an improved animation, which increases contrast and gives you higher information density.

- **Improved code in Vercel docs:** Code blocks now include file location as a header.

- **Improved visuals in Vercel docs:** We now support dynamic dark and light mode screenshots.