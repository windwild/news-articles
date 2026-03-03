---
title: "Improvements and Fixes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/march-2023"
date: "2023-03-09"
scraped_at: "2026-03-02T09:53:57.648759792+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Mar 9, 2023

![](images/improvements-and-fixes-vercel/img_001.jpg)![](images/improvements-and-fixes-vercel/img_002.jpg)

- **AWS credentials in Serverless functions:** You can now add environment variables with the `AWS_` prefix like `AWS_ACCESS_KEY_ID` or `AWS_REGION` via the dashboard.

- **Framework specific documentation:** There is a new Vercel docs section dedicated to frameworks such as, [Next](https://vercel.com/docs/frameworks/nextjs), [SvelteKit](https://vercel.com/docs/frameworks/sveltekit), [Astro](https://vercel.com/docs/frameworks/astro), [Create React App](https://vercel.com/docs/frameworks/create-react-app), and [Gatsby](https://vercel.com/docs/frameworks/gatsby).

- **Vercel CLI:** [v28.16.13](https://github.com/vercel/vercel/releases/tag/vercel%4028.16.13) was released with an upgrade to Turbo version 1.8.3, improved Remix support with an upgrade to `@remix-run/dev` version 1.14.0, support for Astro V2, and more.

- **Improved date picker:** The new [date picker](https://vercel.com/changelog/activity-date-filtering-now-available) in the Usage tab includes natural language parsing, presets, and shortcuts.

- **Vercel Cron Jobs:** We now allow framework authors to create [Cron Jobs](https://vercel.com/blog/cron-jobs) via the `crons` property of the Build Output API configuration and creating Cron Jobs via the `crons` property of `vercel.json` for end users.