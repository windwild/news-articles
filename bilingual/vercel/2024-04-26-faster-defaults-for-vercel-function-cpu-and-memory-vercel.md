---
title: "Faster defaults for Vercel Function CPU and memory - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-defaults-for-vercel-function-cpu-and-memory"
date: "2024-04-26"
scraped_at: "2026-03-02T09:45:27.494532464+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Apr 26, 2024

2024 年 4 月 26 日

![](images/faster-defaults-for-vercel-function-cpu-and-memory-vercel/img_001.jpg)![](images/faster-defaults-for-vercel-function-cpu-and-memory-vercel/img_002.jpg)

自 **2024 年 5 月 6 日起**，所有**新创建的项目**中，Vercel Functions 的默认 CPU 配置将从 **`Basic`**（0.6 vCPU / 1 GB 内存）升级为 **`Standard`**（1 vCPU / 1.7 GB 内存）。**现有项目将保持不变**，除非您手动进行更新。

此项变更有助于保障函数性能的一致性，并显著缩短启动时间。根据您的函数代码体积不同，冷启动时间最多可减少数百毫秒。

虽然提升函数 CPU 配置 *可能* 在相同执行时长下增加费用，但它也能加快函数执行速度；而执行越快，整体函数运行时长（duration）消耗就越低。这一点在您的函数需执行 CPU 密集型任务时尤为关键。

该变更将自动应用于所有付费计划客户（Pro 与 Enterprise），**无需任何操作**。

请查阅我们的 [文档](https://vercel.com/docs/functions/configuring-functions/memory)，了解更多信息。