---
title: "Deployment-level configuration for Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deployment-level-configuration-for-fluid-compute"
date: "2025-10-02"
scraped_at: "2026-03-02T09:27:39.201505782+00:00"
language: "en-zh"
translated: true
description: "You can now enable Fluid Compute on a per-deployment basis. By setting \"fluid\": true in your vercel.json"
---

Oct 2, 2025

2025 年 10 月 2 日

You can now configure [Fluid compute](https://vercel.com/docs/fluid-compute) on a per-deployment basis.

您现在可以针对每次部署单独配置 [Fluid compute](https://vercel.com/docs/fluid-compute)。

By setting `"fluid": true` in your `vercel.json`, Fluid compute will be activated for that specific deployment. You can also enable or disable Fluid regardless of project level settings.

在 `vercel.json` 文件中设置 `"fluid": true`，即可为该次特定部署启用 Fluid compute。您还可无视项目级设置，独立启用或禁用 Fluid。

This allows teams to selectively test and adopt Fluid compute without changing the global project settings.

这使得团队能够在不更改全局项目设置的前提下，有选择性地测试和采用 Fluid compute。

vercel.json

vercel.json

```json
1{

2 "$schema": "https://openapi.vercel.sh/vercel.json",

3  "fluid": true

4}
```

Read more in [our documentation](https://vercel.com/docs/fluid-compute#enable-for-specific-environments-and-deployments).

更多详情，请参阅[我们的文档](https://vercel.com/docs/fluid-compute#enable-for-specific-environments-and-deployments)。