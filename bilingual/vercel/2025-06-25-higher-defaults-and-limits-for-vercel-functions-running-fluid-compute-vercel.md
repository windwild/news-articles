---
title: "Higher defaults and limits for Vercel Functions running Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/higher-defaults-and-limits-for-vercel-functions-running-fluid-compute"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:57.539203909+00:00"
language: "en-zh"
translated: true
description: "Vercel Functions using Fluid compute now have longer execution times, more memory, and more CPU. The default execution time, for all projects on all plans, is now 300 seconds."
---

Jun 25, 2025

2025 年 6 月 25 日

使用 [Fluid compute](https://vercel.com/fluid) 的 Vercel Functions 默认限制已提升，包括更长的执行时间、更大的内存容量以及更强的 CPU 性能。

所有计划下的所有项目，默认执行时间现已统一提升至 300 秒（即 5 分钟）：

| 计划 | 默认值 | 最大值 |
| --- | --- | --- |
| Hobby | 300 秒（此前为 60 秒） | 300 秒（此前为 60 秒） |
| Pro | 300 秒（此前为 90 秒） | 800 秒 |
| Enterprise | 300 秒（此前为 90 秒） | 800 秒 |

内存与 CPU 实例规格也同步更新：

- **Standard**（默认规格）现为 1 vCPU / 2 GB（此前为 1 vCPU / 1.7 GB）

- **Performance** 现为 2 vCPU / 4 GB（此前为 1.7 vCPU / 3 GB）

基础版 CPU 实例（Basic CPU）已被移除。Hobby 项目现默认使用 Standard CPU。

此次实例规格提升依托于 [Active CPU 定价模型](https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute)，该模型按实际计算耗时计费；仅占用内存而无 CPU 计算的时段，将以显著更低的费率计费，从而让长时间执行更具成本效益。

您可通过查看日志，判断函数是否触及执行时限限制，并据此调整最大执行时长或升级所选套餐。

Learn more about [Vercel Function limits](https://vercel.com/docs/functions/limitations).

了解更多关于 [Vercel 函数限制](https://vercel.com/docs/functions/limitations) 的信息。