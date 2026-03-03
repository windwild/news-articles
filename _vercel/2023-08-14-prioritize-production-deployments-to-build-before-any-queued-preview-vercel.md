---
title: "Prioritize Production deployments to build before any queued Preview - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/prioritize-production-deployments-to-build-before-any-queued-preview"
date: "2023-08-14"
scraped_at: "2026-03-02T09:51:52.011301851+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Aug 14, 2023

2023年8月14日

![](images/prioritize-production-deployments-to-build-before-any-queued-preview-vercel/img_001.jpg)![](images/prioritize-production-deployments-to-build-before-any-queued-preview-vercel/img_002.jpg)

[Enterprise](https://vercel.com/docs/accounts/plans/enterprise) customers are now able to configure builds of their Production deployments to begin before any builds of their Preview deployments.  

企业版（[Enterprise](https://vercel.com/docs/accounts/plans/enterprise)）客户现在可配置其生产环境（Production）部署的构建任务，使其优先于所有排队中的预览环境（Preview）部署构建任务启动。

With this setting configured, any Production Deployment changes will [skip the line of queued Preview Deployments](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds), so they're ready as soon as possible.

启用该设置后，任何生产环境部署的变更都将[跳过排队中的预览环境部署构建队列](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds)，从而尽可能快地完成构建并就绪。

You can also increase your [build concurrency limits](https://vercel.com/docs/concepts/deployments/concurrent-builds) to give you the ability to kick off multiple builds at once.

您还可提升您的[构建并发限制](https://vercel.com/docs/concepts/deployments/concurrent-builds)，以支持同时启动多个构建任务。

Read more in [our documentation](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds).

详情请参阅[我们的文档](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds)。