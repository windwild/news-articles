---
title: "Vercel Secure Compute now supports multiple environments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-secure-compute-now-supports-multiple-environments"
date: "2025-04-03"
scraped_at: "2026-03-02T09:35:01.410348537+00:00"
language: "en"
translated: false
description: "Users can now associate each project environment—Production, Preview, and custom—with a distinct Secure Compute network directly from the project settings"
---




Apr 3, 2025

![](images/vercel-secure-compute-now-supports-multiple-environments-vercel/img_001.jpg)![](images/vercel-secure-compute-now-supports-multiple-environments-vercel/img_002.jpg)

Teams using [Vercel Secure Compute](https://vercel.com/docs/secure-compute) can now associate each [project environment](https://vercel.com/docs/deployments/environments)—Production, Preview, and custom—with a distinct Secure Compute network, directly from the project settings. This simplifies environment-specific network isolation within a single project.

To connect your project's environments to Secure Compute:

1. Navigate to [your project's **Secure Compute** settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fsecure-compute&title=Open+Secure+Compute+settings)

2. For every environment you want to connect to Secure Compute:

   - Select an **active** network

   - Optionally, select a **passive** network to enable failover

   - Optionally, enable **builds** to include the project's build container in the network
3. Click **Save** to persist your changes


Learn more about [Secure Compute](https://vercel.com/docs/secure-compute).