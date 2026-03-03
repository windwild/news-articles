---
title: "Bun install is now supported with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bun-install-is-now-supported-with-zero-configuration"
date: "2023-09-11"
scraped_at: "2026-03-02T09:51:04.207006798+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Sep 11, 2023

![Vercel + Bun logo in dark theme](images/bun-install-is-now-supported-with-zero-configuration-vercel/img_001.jpg)![Vercel + Bun logo in dark theme](images/bun-install-is-now-supported-with-zero-configuration-vercel/img_002.jpg)

Projects using [Bun as a package manager](https://bun.sh/docs/cli/install) can now be deployed to Vercel with zero configuration.

Like yarn, npm, and pnpm, Bun acts as a package manager focused on saving disk space and boosting installation speed. Starting today, Projects that contain a `bun.lockb` file will automatically run `bun install` as the default [Install Command](https://vercel.com/docs/concepts/deployments/build-step#install-command) using `bun@1`.

This change impacts the build phase but not runtime. Therefore, Serverless Functions will not use the Bun runtime yet.

[Check out the documentation](https://vercel.com/docs/concepts/deployments/build-step#install-command) to learn more.