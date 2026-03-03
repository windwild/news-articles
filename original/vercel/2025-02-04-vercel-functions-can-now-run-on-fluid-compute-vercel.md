---
title: "Vercel Functions can now run on Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute"
date: "2025-02-04"
scraped_at: "2026-03-02T09:38:10.158540974+00:00"
language: "en"
translated: false
description: "Vercel Functions can now run on Fluid compute, a next-generation execution model that improves efficiency and reduces costs. It brings scalable, cost-effective compute without infrastructure complexit..."
---




Feb 4, 2025

![](images/vercel-functions-can-now-run-on-fluid-compute-vercel/img_001.jpg)![](images/vercel-functions-can-now-run-on-fluid-compute-vercel/img_002.jpg)

Vercel Functions can now run on [Fluid compute](https://vercel.com/fluid), bringing improvements in efficiency, scalability, and cost effectiveness. [Fluid is now available for all plans](https://vercel.com/blog/introducing-fluid-compute).

### **What’s New**

- **Optimized concurrency:** Functions can handle multiple requests per instance, reducing idle time and lowering compute costs by **up to 85%** for high-concurrency workloads

- **Cold start protection:** Fewer cold starts with smarter scaling and pre-warmed instances

- **Optimized scaling:** Functions scale before instances, moving beyond the traditional 1:1 invocation-to-instance model

- **Extended function lifecycle:** Use `waitUntil` to run background tasks after responding to the client

- **Runaway cost protection:** Detects and stops infinite loops and excessive invocations

- **Multi-region execution:** Requests are routed to the nearest of your selected compute region for better performance

- **Node.js and Python support:** No restrictions on native modules or standard libraries


[Enable Fluid today](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings) or learn more in our [blog](https://vercel.com/blog/introducing-fluid-compute) and [documentation](https://vercel.com/docs/functions/fluid-compute).