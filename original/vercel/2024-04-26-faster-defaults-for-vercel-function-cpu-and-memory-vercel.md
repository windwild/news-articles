---
title: "Faster defaults for Vercel Function CPU and memory - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-defaults-for-vercel-function-cpu-and-memory"
date: "2024-04-26"
scraped_at: "2026-03-02T09:45:27.494532464+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Apr 26, 2024

![](images/faster-defaults-for-vercel-function-cpu-and-memory-vercel/img_001.jpg)![](images/faster-defaults-for-vercel-function-cpu-and-memory-vercel/img_002.jpg)

The default CPU for Vercel Functions will change from **`Basic`** (0.6 vCPU/1GB Memory) to **`Standard`** (1 vCPU/1.7GB Memory) for **new projects** created after **May 6th, 2024**. **Existing projects will remain unchanged** unless manually updated.

This change helps ensure consistent function performance and faster startup times. Depending on your function code size, this may reduce cold starts by a few hundred milliseconds.

While increasing the function CPU _can_ increase costs for the same duration, it can also make functions execute faster. If functions execute faster, you incur less overall function duration usage. This is especially important if your function runs CPU-intensive tasks.

This change will be applied to all paid plan customers (Pro and Enterprise), no action required.

Check out our [documentation](https://vercel.com/docs/functions/configuring-functions/memory) to learn more.