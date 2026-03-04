---
title: "Manage multiple Vercel Function regions in the dashboard - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/manage-multiple-vercel-function-regions-in-the-dashboard"
date: "2025-02-12"
scraped_at: "2026-03-02T09:36:41.086514336+00:00"
language: "en-zh"
translated: true
description: "You can now select multiple regions for your Vercel Functions directly from the dashboard. This makes configuration easier by removing the need to define regions in vercel.json."
---

render_with_liquid: false
Feb 12, 2025

2025 年 2 月 12 日

![](images/manage-multiple-vercel-function-regions-in-the-dashboard-vercel/img_001.jpg)![](images/manage-multiple-vercel-function-regions-in-the-dashboard-vercel/img_002.jpg)

Pro 和 Enterprise 计划现在可直接在控制台中为 [Vercel Functions](https://vercel.com/docs/functions) 选择多个运行区域。此次更新简化了配置流程，不再需要在 `vercel.json` 文件中手动定义区域。

多区域支持适用于所有 Vercel Functions，并兼容 Vercel 的 [Fluid Compute（弹性计算）](https://vercel.com/blog/introducing-fluid-compute) 实现，该技术倡导一种 [高密度全球计算模型](https://vercel.com/blog/introducing-fluid-compute#dense-global-compute-and-multi-region-failover)，旨在将动态函数部署在更靠近您数据的位置。

请前往 [项目的 Settings（设置）标签页](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions&title=Go+to+functions+settings)，自定义您的函数运行区域；或进一步了解 [如何为 Vercel Functions 配置区域](https://vercel.com/docs/functions/configuring-functions/region#configuring-regions-for-vercel-functions)。