---
title: "Pricing for on-demand concurrent builds reduced by over 50% - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/pricing-for-on-demand-concurrent-builds-reduced-by-over-50-percent"
date: "2025-04-25"
scraped_at: "2026-03-02T09:34:25.914607+00:00"
language: "en-zh"
translated: true
description: "Pricing for on-demand concurrent builds has been reduced by more than 50%. Billable intervals have also been lowered from 10 minutes to 1 minute."
---

Apr 25, 2025

2025 年 4 月 25 日

按需并发构建（on-demand concurrent builds）的定价已下调逾 50%。该服务允许部署任务绕过构建队列。同时，计费粒度也从原先的每 10 分钟一档，降低至每 1 分钟一档。

按需并发构建[面向 Pro 和 Enterprise 客户开放](https://vercel.com/changelog/pro-customers-can-now-deploy-faster-with-on-demand-concurrency-builds)，并可与现有的[构建插槽（build slots）](https://vercel.com/docs/builds/managing-builds#concurrent-builds)协同使用；我们建议如下：

- 对于突发性工作负载或高优先级部署，请使用**按需（on-demand）**模式；  
- 对于规模较大、频率较高且构建量可预测的场景，请使用**插槽（slots）**模式。

此项调整同样适用于所有正在使用“增强型按需构建（Enhanced On-demand builds）”的客户——该模式为构建计算分配更多内存，从而显著缩短部署耗时。

了解更多关于[按需并发构建](https://vercel.com/docs/builds/managing-builds#on-demand-concurrent-builds)的信息，并[在您的项目中启用该功能](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment&title=Enable%20on-demand%20concurrent%20builds)。