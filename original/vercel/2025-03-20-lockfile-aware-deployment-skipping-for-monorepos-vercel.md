---
title: "Lockfile-aware deployment skipping for monorepos - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/lockfile-aware-deployment-skipping-for-monorepos"
date: "2025-03-20"
scraped_at: "2026-03-02T09:35:23.249814810+00:00"
language: "en"
translated: false
description: "Vercel now maps dependencies in your package manager’s lockfile to applications in your monorepo, skipping unaffected projects for monorepos."
---




Mar 20, 2025

![Skip deployments when there are no changes to the root directory and its dependencies](images/lockfile-aware-deployment-skipping-for-monorepos-vercel/img_001.jpg)![Skip deployments when there are no changes to the root directory and its dependencies](images/lockfile-aware-deployment-skipping-for-monorepos-vercel/img_002.jpg)

Vercel now maps dependencies in your package manager’s lockfile to applications in your monorepo. Deployments only occur for applications using updated dependencies.

This feature is based on Turborepo's lockfile analysis, supporting the package managers listed as stable in [Turborepo's Support Policy](https://turbo.build/repo/docs/getting-started/support-policy#package-managers).

Previously, any change to the lockfile would redeploy all applications in the monorepo since it was treated as a shared input. Now, Vercel inspects the lockfile’s contents to determine which applications have dependency changes, further reducing potential queue times.

Learn more about [skipping unaffected projects in monorepos](https://vercel.com/docs/monorepos#skipping-unaffected-projects).