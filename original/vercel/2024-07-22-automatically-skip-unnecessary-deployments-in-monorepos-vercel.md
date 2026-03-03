---
title: "Automatically skip unnecessary deployments in monorepos - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/automatically-skip-unnecessary-deployments-in-monorepos"
date: "2024-07-22"
scraped_at: "2026-03-02T09:42:43.290547674+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 22, 2024

![Root Directory Settings](images/automatically-skip-unnecessary-deployments-in-monorepos-vercel/img_001.jpg)![Root Directory Settings](images/automatically-skip-unnecessary-deployments-in-monorepos-vercel/img_002.jpg)

Vercel now automatically skip builds for unchanged code in your monorepo.

Projects without changes in their source code (or the source code of internal dependencies) will be skipped, reducing build queuing and improving the time to deployment for affected projects.

This feature is powered by [Turborepo](https://turbo.build/repo/docs/core-concepts/package-and-task-graph#package-graph), and works with any [monorepo using workspaces](https://vercel.com/docs/monorepos#requirements). For more advanced customization, like canceling builds based on branches, you can configure an [Ignored Build Step](https://vercel.com/docs/projects/overview#ignore-build-step-on-redeploy).

Learn more about [skipping unaffected projects](https://vercel.com/docs/monorepos#skipping-unaffected-projects).