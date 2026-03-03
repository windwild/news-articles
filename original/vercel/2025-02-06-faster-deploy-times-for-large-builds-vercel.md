---
title: "Faster deploy times for large builds - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-deploy-times-for-large-builds"
date: "2025-02-06"
scraped_at: "2026-03-02T09:37:13.725657474+00:00"
language: "en"
translated: false
description: "Discover the upcoming update to Vercel Edge Functions with a new execution duration limit of 300 seconds, enhancing predictability and reliability in function management starting March 1st."
---




Feb 6, 2025

We optimized the deploy step of the [build process](https://vercel.com/docs/deployments/builds#build-process) to reduce build times by 2.8 seconds at P99, 760ms at P75, and 410ms on average.

For customers with a large number of Vercel Functions (100+), builds are more than 50 seconds faster. Several customers have time savings of over 2 minutes.

Check out [the documentation](https://vercel.com/docs/deployments/builds) to learn more about builds.