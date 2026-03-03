---
title: "Lower pricing with Active CPU pricing for Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute"
date: "2025-06-25"
scraped_at: "2026-03-02T09:32:00.821098960+00:00"
language: "en"
translated: false
description: "Pricing for Vercel Functions on Fluid compute has been reduced. All Fluid-based compute now uses an Active CPU pricing model, offering up to 90% savings in addition to the cost efficiency already deli..."
---




Jun 25, 2025

![](images/lower-pricing-with-active-cpu-pricing-for-fluid-compute-vercel/img_001.jpg)![](images/lower-pricing-with-active-cpu-pricing-for-fluid-compute-vercel/img_002.jpg)

Vercel Functions on Fluid Compute now use Active CPU pricing, which charges for CPU only while it is actively doing work. This eliminates costs during idle time and reduces spend for workloads like LLM inference, long-running AI agents, or any task with idle time.

Active CPU pricing is built on three core metrics:

- **Active CPU**: Time your code is actively executing in an instance. Priced at $0.128 per hour

- **Provisioned Memory:** Memory allocated to the instance, billed at a lower rate. Priced at $0.0106 per GB-Hour

- **Invocations**: One charge per function call


**An example of this in action:**

A function running Standardmachine size at 100% active CPU would now cost ~$0.149 per hour (1 Active CPU hour + 2 GB of provisioned memory). Previously this would have cost $0.31842 per hour (1.7 GB Memory × $0.18).

Active CPU pricing is now enabled by default for all Hobby, Pro, and new Enterprise teams. For existing Enterprise customers, availability depends on your current plan configuration.

This change takes effect after a redeploy.

Learn more about [Fluid compute with Active CPU pricing](https://vercel.com/docs/fluid-compute/pricing) and read the [announcement](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute).