---
title: "Prioritize production builds available on all plans - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/prioritize-production-deployments-to-build-before-queued-preview"
date: "2024-03-15"
scraped_at: "2026-03-02T09:46:36.219896144+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Mar 15, 2024

2024年3月15日

![](images/prioritize-production-builds-available-on-all-plans-vercel/img_001.jpg)![](images/prioritize-production-builds-available-on-all-plans-vercel/img_002.jpg)

To accelerate the production release process, [customers on all plans](https://vercel.com/docs/accounts/plans) can now prioritize changes to the [Production Environment](https://vercel.com/docs/deployments/environments#production) over [Preview Deployments](https://vercel.com/docs/deployments/preview-deployments).

为加速生产环境发布流程，[所有套餐的客户](https://vercel.com/docs/accounts/plans) 现在均可优先处理针对 [生产环境（Production Environment）](https://vercel.com/docs/deployments/environments#production) 的变更，而非 [预览部署（Preview Deployments）](https://vercel.com/docs/deployments/preview-deployments)。

With this setting configured, any Production Deployment changes will [skip the line of queued Preview Deployments](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds) and go to the front of the queue.

启用该设置后，所有生产环境部署（Production Deployment）的变更将 [跳过排队中的预览部署队列](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds)，直接进入构建队列最前端。

You can also increase your [build concurrency limits](https://vercel.com/docs/concepts/deployments/concurrent-builds) to give you the ability to start multiple builds at once. Additionally, [Enterprise customers](https://vercel.com/docs/accounts/plans#enterprise) can also [contact sales](https://vercel.com/contact/sales) to purchase enhanced build machines with larger memory and storage.

您还可提升 [构建并发数限制（build concurrency limits）](https://vercel.com/docs/concepts/deployments/concurrent-builds)，从而支持同时启动多个构建任务。此外，[企业版客户（Enterprise customers）](https://vercel.com/docs/accounts/plans#enterprise) 还可 [联系销售团队（contact sales）](https://vercel.com/contact/sales)，购买配备更大内存与存储空间的增强型构建机器。

Check out [our documentation](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds) to learn more.

请查阅 [我们的文档](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds) 了解更多信息。