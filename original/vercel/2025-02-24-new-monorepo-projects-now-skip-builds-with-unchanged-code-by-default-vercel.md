---
title: "New monorepo projects now skip builds with unchanged code by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-monorepo-projects-now-skip-builds-with-unchanged-code-by-default"
date: "2025-02-24"
scraped_at: "2026-03-02T09:36:07.726788054+00:00"
language: "en"
translated: false
description: "Vercel now defaults to skipping builds for unchanged code in monorepos, reducing queue times and improving efficiency. Additionally, the setting for this behavior has been added to the Vercel Terrafor..."
---




Feb 24, 2025

![Skip deployments when there are no changes to the root directory and its dependencies](images/new-monorepo-projects-now-skip-builds-with-unchanged-code-by-default-vercel/img_001.jpg)![Skip deployments when there are no changes to the root directory and its dependencies](images/new-monorepo-projects-now-skip-builds-with-unchanged-code-by-default-vercel/img_002.jpg)

Previously, we added [opt-in support for skipping builds with unchanged code in monorepos](https://vercel.com/changelog/automatically-skip-unnecessary-deployments-in-monorepos) to reduce build queueing.

This behavior is now the default for new projects. To [enable deployment skipping](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment%23root-directory&title=Disable+unaffected+project+skipping) in an existing project, visit the **Build and Deployment** settings for the project.

Additionally, this setting has been added to the [Vercel provider for Terraform](https://registry.terraform.io/providers/vercel/vercel/latest) in 2.10.0.

Learn more about [skipping deployments](https://vercel.com/docs/monorepos#skipping-unaffected-projects).