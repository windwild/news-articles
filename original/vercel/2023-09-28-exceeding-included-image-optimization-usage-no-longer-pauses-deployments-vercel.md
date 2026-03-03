---
title: "Exceeding included Image Optimization usage no longer pauses deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/exceeding-included-image-optimization-usage-no-longer-pauses-deployments"
date: "2023-09-28"
scraped_at: "2026-03-02T09:50:17.058025298+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Sep 28, 2023

![](images/exceeding-included-image-optimization-usage-no-longer-pauses-deployments-vercel/img_001.jpg)

Based on your feedback, rather than pausing a deployment when exceeding the included [Image Optimization usage](https://vercel.com/docs/image-optimization/limits-and-pricing), Vercel will now **only pause optimization for additional source images**.

- Your existing images and all traffic will not be affected

- Additional source images will throw a 402 status code when optimizing, triggering the [`onError`](https://nextjs.org/docs/app/api-reference/components/image#onerror) callback (if provided) and showing the [`alt`](https://nextjs.org/docs/app/api-reference/components/image#alt) text instead of the image


[Check out our documentation](https://vercel.com/docs/image-optimization/limits-and-pricing) to learn more.