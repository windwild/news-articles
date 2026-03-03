---
title: "Deployment-level configuration for Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deployment-level-configuration-for-fluid-compute"
date: "2025-10-02"
scraped_at: "2026-03-02T09:27:39.201505782+00:00"
language: "en"
translated: false
description: "You can now enable Fluid Compute on a per-deployment basis. By setting \"fluid\": true in your vercel.json"
---




Oct 2, 2025

You can now configure [Fluid compute](https://vercel.com/docs/fluid-compute) on a per-deployment basis.

By setting `"fluid": true` in your `vercel.json`, Fluid compute will be activated for that specific deployment. You can also enable or disable Fluid regardless of project level settings.

This allows teams to selectively test and adopt Fluid compute without changing the global project settings.

vercel.json

```json
1{

2 "$schema": "https://openapi.vercel.sh/vercel.json",

3  "fluid": true

4}
```

Read more in [our documentation](https://vercel.com/docs/fluid-compute#enable-for-specific-environments-and-deployments).