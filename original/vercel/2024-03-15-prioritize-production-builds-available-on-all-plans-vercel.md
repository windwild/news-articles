---
title: "Prioritize production builds available on all plans - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/prioritize-production-deployments-to-build-before-queued-preview"
date: "2024-03-15"
scraped_at: "2026-03-02T09:46:36.219896144+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Mar 15, 2024

![](images/prioritize-production-builds-available-on-all-plans-vercel/img_001.jpg)![](images/prioritize-production-builds-available-on-all-plans-vercel/img_002.jpg)

To accelerate the production release process, [customers on all plans](https://vercel.com/docs/accounts/plans) can now prioritize changes to the [Production Environment](https://vercel.com/docs/deployments/environments#production) over [Preview Deployments](https://vercel.com/docs/deployments/preview-deployments).

With this setting configured, any Production Deployment changes will [skip the line of queued Preview Deployments](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds) and go to the front of the queue.

You can also increase your [build concurrency limits](https://vercel.com/docs/concepts/deployments/concurrent-builds) to give you the ability to start multiple builds at once. Additionally, [Enterprise customers](https://vercel.com/docs/accounts/plans#enterprise) can also [contact sales](https://vercel.com/contact/sales) to purchase enhanced build machines with larger memory and storage.

Check out [our documentation](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds) to learn more.