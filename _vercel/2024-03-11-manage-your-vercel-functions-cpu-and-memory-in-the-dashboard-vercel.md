---
title: "Manage your Vercel Functions CPU and memory in the dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/manage-your-vercel-functions-cpu-and-memory-in-the-dashboard"
date: "2024-03-11"
scraped_at: "2026-03-02T09:46:26.093035184+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Mar 11, 2024

2024 年 3 月 11 日

![](images/manage-your-vercel-functions-cpu-and-memory-in-the-dashboard-vercel/img_001.jpg)![](images/manage-your-vercel-functions-cpu-and-memory-in-the-dashboard-vercel/img_002.jpg)

您现在可以在项目设置页面中配置函数的 CPU，通过调整项目的默认内存（进而影响 CPU）。此前，该配置仅能通过 `vercel.json` 文件修改。

函数的内存配置决定了其执行过程中可使用的内存与 CPU 资源量。这一全新 UI 界面更清晰地表明：提升内存配额将同步提升虚拟 CPU（vCPU）性能，从而在不同工作负载类型下带来更优的执行性能。

当前已部署的工作负载（未修改过 `vercel.json`）默认采用高性价比的基础配置。提高函数 CPU 配额会在相同执行时长下增加费用，但可能显著缩短函数执行时间。这种执行加速效果，可能使总体成本保持不变（甚至在某些情况下降低费用）。

[查阅文档](https://vercel.com/docs/functions/configuring-functions/memory) 了解更多信息。
&#123;% endraw %}
