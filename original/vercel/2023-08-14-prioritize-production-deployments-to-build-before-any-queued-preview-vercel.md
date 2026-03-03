---
title: "Prioritize Production deployments to build before any queued Preview - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/prioritize-production-deployments-to-build-before-any-queued-preview"
date: "2023-08-14"
scraped_at: "2026-03-02T09:51:52.011301851+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Aug 14, 2023

![](images/prioritize-production-deployments-to-build-before-any-queued-preview-vercel/img_001.jpg)![](images/prioritize-production-deployments-to-build-before-any-queued-preview-vercel/img_002.jpg)

[Enterprise](https://vercel.com/docs/accounts/plans/enterprise) customers are now able to configure builds of their Production deployments to begin before any builds of their Preview deployments.﻿

With this setting configured, any Production Deployment changes will [skip the line of queued Preview Deployments](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds), so they're ready as soon as possible.

You can also increase your [build concurrency limits](https://vercel.com/docs/concepts/deployments/concurrent-builds) to give you the ability to kick off multiple builds at once.

Read more in [our documentation](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds).