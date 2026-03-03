---
title: "Exceeding included Image Optimization usage no longer pauses deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/exceeding-included-image-optimization-usage-no-longer-pauses-deployments"
date: "2023-09-28"
scraped_at: "2026-03-02T09:50:17.058025298+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Sep 28, 2023

2023 年 9 月 28 日

![](images/exceeding-included-image-optimization-usage-no-longer-pauses-deployments-vercel/img_001.jpg)

Based on your feedback, rather than pausing a deployment when exceeding the included [Image Optimization usage](https://vercel.com/docs/image-optimization/limits-and-pricing), Vercel will now **only pause optimization for additional source images**.

根据您的反馈，Vercel 不再因超出包含的 [图像优化用量](https://vercel.com/docs/image-optimization/limits-and-pricing) 而暂停整个部署，而是**仅暂停对额外源图像的优化**。

- Your existing images and all traffic will not be affected  
- 您现有的图像及所有流量均不受影响  

- Additional source images will throw a 402 status code when optimizing, triggering the [`onError`](https://nextjs.org/docs/app/api-reference/components/image#onerror) callback (if provided) and showing the [`alt`](https://nextjs.org/docs/app/api-reference/components/image#alt) text instead of the image  
- 对额外源图像执行优化时，将返回 `402` 状态码，从而触发 [`onError`](https://nextjs.org/docs/app/api-reference/components/image#onerror) 回调函数（如已提供），并显示 [`alt`](https://nextjs.org/docs/app/api-reference/components/image#alt) 文本而非图像  

[Check out our documentation](https://vercel.com/docs/image-optimization/limits-and-pricing) to learn more.  

[查阅我们的文档](https://vercel.com/docs/image-optimization/limits-and-pricing)，了解更多信息。