---
title: "In-function concurrency now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/in-function-concurrency-now-in-public-beta"
date: "2024-10-03"
scraped_at: "2026-03-02T09:40:38.914418423+00:00"
language: "en"
translated: false
description: "In-function concurrency is now in public beta, and allows a single function instance to handle multiple invocations concurrently, improving resource utilization by taking advantage of idle time in exi..."
---




Oct 3, 2024

![](images/in-function-concurrency-now-in-public-beta-vercel/img_001.jpg)![](images/in-function-concurrency-now-in-public-beta-vercel/img_002.jpg)

[**In-function concurrency is now part of Fluid compute**\\
\\
Fluid compute combines the efficiency of servers and the fleixbility of serverless, enabling real-time, dynamic workloads like APIs, streaming, and AI.\\
\\
Learn about Fluid](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute)

In-function concurrency is now in [public beta](https://vercel.com/docs/release-phases#public-beta), and allows a single function instance to handle multiple invocations concurrently, improving resource utilization by taking advantage of idle time in existing function instances.

Traditionally, serverless architecture maps one function instance to a single invocation. With in-function concurrency, overlapping invocations can increase efficiency by 20%-50%, reducing gigabyte-hours and lowering costs.

​As part of the beta, we’re limiting the number of concurrent invocations per instance, and will be gradually increasing the limit based on feedback. Note, this capability may increase latency for purely CPU-bound workloads.

In-function concurrency public beta is available for all [Pro and Enterprise](https://vercel.com/docs/accounts/plans#account-plans-on-vercel) customers using [Standard or Performance Function CPU](https://vercel.com/docs/functions/configuring-functions/memory#setting-your-default-function-memory-/-cpu-size), you can [enable it through your dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23in-function-concurrency&title=Go+to+Function+Settings) and track resource savings in real time.

Read our [blog post](https://vercel.com/blog/serverless-servers-introducing-in-function-concurrency-for-vercel-functions-2MoEVmoCwraZoZC9t5HI59) and [documentation](https://vercel.com/docs/functions/runtimes/node-js#in-function-concurrency) for more information.