---
title: "Automatic pnpm v7 Support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-pnpm-v7-support"
date: "2022-05-12"
scraped_at: "2026-03-02T10:02:05.265294233+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 12, 2022

![](images/automatic-pnpm-v7-support-vercel/img_001.jpg)![](images/automatic-pnpm-v7-support-vercel/img_002.jpg)

Vercel now supports pnpm v7. For deployments with a `pnpm-lock.yaml` file with `version: 5.4`, Vercel will automatically use pnpm v7 for install and build commands.

To upgrade your project to pnpm v7, run `pnpm install -g pnpm@7` locally and then re-run `pnpm install.`After updating, create a new deployment!

[Check out the documentation](https://vercel.com/docs/concepts/deployments/build-step#install-command) as well.