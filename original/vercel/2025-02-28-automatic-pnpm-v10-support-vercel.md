---
title: "Automatic pnpm v10 support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatic-pnpm-v10-support"
date: "2025-02-28"
scraped_at: "2026-03-02T09:35:33.983185988+00:00"
language: "en"
translated: false
description: "New projects will detect and use pnpm@10, based on the project lockfile. Old projects can opt-in to pnpm@10 using Corepack."
---




Feb 28, 2025

![](images/automatic-pnpm-v10-support-vercel/img_001.jpg)![](images/automatic-pnpm-v10-support-vercel/img_002.jpg)

Vercel now supports pnpm v10.

New projects with a `pnpm-lock.yaml` file with `lockfileVersion: '9.0'` will automatically use pnpm v10 for Install and Build Commands. Existing projects will continue to use pnpm v9 for backwards compatibility, since pnpm v9 also uses `lockfileVersion: '9.0'`.

Check your [build logs](https://vercel.com/docs/deployments/logs) to see which version a deployment uses. If you'd like to manually upgrade or downgrade your version, [use Corepack](https://vercel.com/docs/deployments/configure-a-build#corepack).

Visit the [package managers documentation](https://vercel.com/docs/deployments/builds/package-managers#supported-package-managers) to learn more.