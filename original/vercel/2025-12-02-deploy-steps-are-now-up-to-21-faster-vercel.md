---
title: "Deploy steps are now up to 21% faster - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deploy-steps-are-now-up-to-21-faster"
date: "2025-12-02"
scraped_at: "2026-03-02T09:24:35.631048935+00:00"
language: "en"
translated: false
description: "Deploy steps for projects with Functions are now up to 21% faster—nearly 2 seconds faster on average. No changes required."
---




Dec 2, 2025

On average, the deploy step is now 17% faster, reducing total time to go live by 1.67 seconds. Projects with a large number of functions will see even greater improvements, with up to 2.8 seconds saved on average.

During the deploy step, Vercel uploads static assets, provisions and uploads like Vercel Functions, processes routing metadata, and prepares the deployment to receive traffic. This phase is now faster due to reduced idle time and increased concurrency across these operations.

Check out [the documentation](https://vercel.com/docs/builds) to learn more about builds.