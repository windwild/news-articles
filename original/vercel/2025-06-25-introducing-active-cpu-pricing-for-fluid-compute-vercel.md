---
title: "Introducing Active CPU pricing for Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:34.377264137+00:00"
language: "en"
translated: false
description: "Fluid compute now uses Active CPU pricing. Only pay CPU rates when your function is actively computing. Building on existing Fluid gains, this brings additional savings of up to 90% for workloads like..."
---




Jun 25, 2025

[Fluid compute](https://vercel.com/fluid) exists for a new class of workloads. I/O bound backends like AI inference, agents, MCP servers, and anything that needs to scale instantly, but often remains idle between operations. These workloads do not follow traditional, quick request-response patterns. They’re long-running, unpredictable, and use cloud resources in new ways.

[Fluid quickly became the default compute model](https://vercel.com/changelog/fluid-compute-is-now-the-default-for-new-projects) on Vercel, helping teams cut costs by up to 85% through optimizations like in-function concurrency.

Today, we’re taking the efficiency and cost savings further with a new pricing model: you pay CPU rates only when your code is actively using CPU.

## From servers to serverless

In the early days of cloud computing, teams ran long-lived servers. You had to manage provisioning, handle scaling manually, and decide what happens during traffic spikes. Over-provisioning cloud resources was common, and idle time meant wasted money.

Serverless changed that. It abstracted away infrastructure configuration and introduced automatic scaling. Each request triggered its own isolated instance.

But this came with trade-offs. These instances were single-purpose and short-lived. Powerful, but ephemeral. That led to cold starts, duplicated overhead, and underutilized compute. Once again, teams were paying for resources they didn't fully use.

![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_001.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_002.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_003.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_004.jpg)

## From serverless to Fluid compute

Fluid compute breaks away from the traditional one-to-one serverless model. Instead of spinning up a separate instance for each invocation, Fluid compute intelligently orchestrates compute across invocations. Multiple concurrent requests can share the same underlying resources, eliminating cold starts and reusing idle time. This allows I/O bound workloads like AI to run more efficiently.

The impact was visible immediately. Fluid became the default for AI on Vercel, powering [over one trillion invocations](https://x.com/rauchg/status/1936139463564181773). Teams saw up to 90% cost savings by sharing compute across workloads intelligently.

![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_005.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_006.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_007.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_008.jpg)

## Fluid with Active CPU

Fluid improved performance and cost, but there was still room to optimize. Even with high concurrency, there could still be moments where all invocations are waiting on external responses and no code is actively running. During these idle periods, functions stay in memory, doing no work, yet still incur CPU cost.

Active CPU pricing solves this. It's a new pricing model that charges for CPU only when your code is actively using the CPU. Building on existing Fluid gains, this brings additional cost savings of up to 90% for workloads with high idle time, like AI inference.

![Fluid compute bills by execution time, not wall time.](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_009.jpg)![Fluid compute bills by execution time, not wall time.](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_010.jpg)![Fluid compute bills by execution time, not wall time.](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_011.jpg)![Fluid compute bills by execution time, not wall time.](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_012.jpg)Fluid compute bills by execution time, not wall time.

This aligns pricing with actual usage. Compute costs scale with real work, not just with the time a function is alive.

### The Active CPU pricing model

Fluid compute now charges based on three key metrics, each designed to reflect actual resource usage:

1. **Active CPU** reflects the compute time your code is actively executing on a virtual CPU (vCPU). It’s measured in milliseconds, calculated as the number of vCPUs allocated multiplied by the time they’re actively used. Pricing starting at at $0.128 per hour

2. **Provisioned Memory** covers the memory required to keep a function alive while it's running. It’s measured in GB-hours and billed at a much lower rate (less than 10% of Active CPU), thanks to Fluid’s ability to reuse memory across multiple concurrent invocations. Pricing starting at at $0.0106 per GB-Hour

3. **Invocations** are counted per function call (just like in traditional serverless) and remain part of the overall pricing


This pricing model in action:

A function running on a Standard machine size at 100% active CPU would now cost ~$0.149 per hour (1 Active CPU GB-Hour + 2 GB of provisioned memory). Previously, this would have cost $0.31842 per hour (1.7 GB Memory × $0.18).

## Built for the way modern apps run

Fluid is our proprietary compute platform, built for modern workloads.

It simplifies cloud infrastructure while preserving flexibility and performance. Developers can use standard runtimes like Node.js and Python, making it easy to run existing code without changes.

Fluid powers core product experiences across our platform, including [Functions](https://vercel.com/docs/functions), and [recently announced Sandbox](https://vercel.com/changelog/run-untrusted-code-with-vercel-sandbox). All of them run on the same compute engine, optimized for concurrency, reuse, and efficiency, with unified billing across the stack.

## Available today

Active CPU pricing is now enabled by default for all Hobby, Pro, and new Enterprise teams. For existing Enterprise customers, availability depends on your current plan configuration. Most teams will have access right away. Reach out to your Vercel account representative to learn more and enable the new pricing model.

With Active CPU, Fluid compute automatically optimizes your costs to match actual usage. It reduces waste, scales with real usage, and reflects the way modern apps actually run.

[**Deploy an AI-powered app with Fluid compute today**\\
\\
Optimize your AI applications with Fluid compute and maximize your compute. \\
\\
Get started](https://vercel.com/templates/ai)