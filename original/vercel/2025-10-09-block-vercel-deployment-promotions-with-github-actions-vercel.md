---
title: "Block Vercel deployment promotions with GitHub Actions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/block-vercel-deployment-promotions-with-github-actions"
date: "2025-10-09"
scraped_at: "2026-03-02T09:27:35.076441864+00:00"
language: "en"
translated: false
description: "You can now automatically block a deployment from releasing to production until selected GitHub Actions complete successfully."
---




Oct 9, 2025

![](images/block-vercel-deployment-promotions-with-github-actions-vercel/img_001.jpg)![](images/block-vercel-deployment-promotions-with-github-actions-vercel/img_002.jpg)

You can now block a deployment from being promoted to production until selected GitHub Actions complete successfully.

On Vercel, every deployment starts in a preview environment, this feature ensures that only verified builds that pass tests or other automated checks are released to production.

Deployment Checks are available for all projects connected to GitHub repositories.

Configure them in your [project settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment) or learn more in [the docs](https://vercel.com/docs/deployment-checks).