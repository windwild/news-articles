---
title: "Introducing Active CPU pricing for Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:34.377264137+00:00"
language: "en-zh"
translated: true
description: "Fluid compute now uses Active CPU pricing. Only pay CPU rates when your function is actively computing. Building on existing Fluid gains, this brings additional savings of up to 90% for workloads like..."
---
&#123;% raw %}

Jun 25, 2025

2025 年 6 月 25 日

[Fluid compute](https://vercel.com/fluid) 面向一类新型工作负载而生。这类工作负载属于 I/O 密集型后端，例如 AI 推理、智能体（agents）、MCP 服务器，以及任何需要瞬时弹性伸缩、却常在操作间隙处于空闲状态的服务。它们并不遵循传统意义上快速完成的请求-响应模式；相反，其生命周期长、行为不可预测，并以全新的方式使用云资源。

[Fluid 迅速成为 Vercel 上默认的计算模型](https://vercel.com/changelog/fluid-compute-is-now-the-default-for-new-projects)，通过函数内并发（in-function concurrency）等优化手段，帮助团队最高降低 85% 的计算成本。

今天，我们进一步提升效率与成本效益，推出全新定价模式：**仅当您的代码实际占用 CPU 时，才按 CPU 使用量计费**。

## 从服务器到无服务器（Serverless）

在云计算发展初期，团队普遍运行长期存活的服务器。您必须自行管理资源配置、手动处理扩缩容，并决定如何应对流量激增。过度配置云资源十分常见，而服务器空闲时间则意味着资金浪费。

无服务器架构（Serverless）改变了这一现状：它将基础设施配置抽象化，并引入自动扩缩容能力；每次请求都会触发一个独立、隔离的实例。

但这种转变也带来了权衡取舍。这些实例功能单一、生命周期短暂——虽性能强大，却转瞬即逝。由此引发冷启动（cold starts）、重复开销（duplicated overhead）以及计算资源利用率低下等问题。团队再次为未被充分利用的资源支付了费用。

![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_001.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_002.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_003.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_004.jpg)

## 从无服务器（Serverless）到 Fluid 计算

Fluid compute breaks away from the traditional one-to-one serverless model. Instead of spinning up a separate instance for each invocation, Fluid compute intelligently orchestrates compute across invocations. Multiple concurrent requests can share the same underlying resources, eliminating cold starts and reusing idle time. This allows I/O bound workloads like AI to run more efficiently.

Fluid Compute 打破了传统的“一对一”无服务器模型。它不再为每次调用单独启动一个实例，而是智能地跨多次调用协调计算资源。多个并发请求可共享同一底层资源，从而消除冷启动，并复用空闲时间。这使得 AI 等 I/O 密集型工作负载能够更高效地运行。

The impact was visible immediately. Fluid became the default for AI on Vercel, powering [over one trillion invocations](https://x.com/rauchg/status/1936139463564181773). Teams saw up to 90% cost savings by sharing compute across workloads intelligently.

其影响立竿见影：Fluid 已成为 Vercel 平台上 AI 工作负载的默认计算方案，已支撑[超一万亿次调用](https://x.com/rauchg/status/1936139463564181773)。各团队通过在不同工作负载间智能共享计算资源，最高实现了 90% 的成本节约。

![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_005.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_006.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_007.jpg)![](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_008.jpg)

## Fluid with Active CPU

## 支持主动 CPU 计费的 Fluid

Fluid improved performance and cost, but there was still room to optimize. Even with high concurrency, there could still be moments where all invocations are waiting on external responses and no code is actively running. During these idle periods, functions stay in memory, doing no work, yet still incur CPU cost.

Fluid 在性能与成本方面均已取得显著提升，但仍存在进一步优化的空间。即使在高并发场景下，仍可能出现所有调用均在等待外部响应、而无任何代码正在执行的情况。在这些空闲时段内，函数虽驻留在内存中、未执行任何任务，却仍在持续产生 CPU 费用。

Active CPU pricing solves this. It's a new pricing model that charges for CPU only when your code is actively using the CPU. Building on existing Fluid gains, this brings additional cost savings of up to 90% for workloads with high idle time, like AI inference.

主动 CPU 计费（Active CPU Pricing）正是为此而生：这是一种全新的计价模式，仅当您的代码实际占用 CPU 执行运算时才计费。在现有 Fluid 优势基础上，该模式可为 AI 推理等空闲时间较长的工作负载，额外带来最高达 90% 的成本节约。

![Fluid compute bills by execution time, not wall time.](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_009.jpg)![Fluid compute bills by execution time, not wall time.](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_010.jpg)![Fluid compute bills by execution time, not wall time.](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_011.jpg)![Fluid compute bills by execution time, not wall time.](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_012.jpg)Fluid compute bills by execution time, not wall time.

![Fluid compute 按执行时间计费，而非挂钟时间（wall time）。](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_009.jpg)![Fluid compute 按执行时间计费，而非挂钟时间（wall time）。](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_010.jpg)![Fluid compute 按执行时间计费，而非挂钟时间（wall time）。](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_011.jpg)![Fluid compute 按执行时间计费，而非挂钟时间（wall time）。](images/introducing-active-cpu-pricing-for-fluid-compute-vercel/img_012.jpg)Fluid compute 按执行时间计费，而非挂钟时间（wall time）。

This aligns pricing with actual usage. Compute costs scale with real work, not just with the time a function is alive.

此举使计费方式与真实使用情况高度对齐：计算成本随实际完成的工作量线性增长，而不仅取决于函数进程存活的时间长度。

### The Active CPU pricing model

### 主动 CPU 计费模型

Fluid compute now charges based on three key metrics, each designed to reflect actual resource usage:

Fluid Compute 当前依据以下三项核心指标进行计费，每一项均旨在精准反映实际资源消耗：

1. **Active CPU** reflects the compute time your code is actively executing on a virtual CPU (vCPU). It’s measured in milliseconds, calculated as the number of vCPUs allocated multiplied by the time they’re actively used. Pricing starting at $0.128 per hour

1. **活跃 CPU（Active CPU）** 反映您的代码在虚拟 CPU（vCPU）上实际执行的计算时间。以毫秒为单位计量，计算方式为：分配的 vCPU 数量 × vCPU 实际活跃运行的时间。起始价格为每小时 $0.128。

2. **Provisioned Memory** covers the memory required to keep a function alive while it's running. It’s measured in GB-hours and billed at a much lower rate (less than 10% of Active CPU), thanks to Fluid’s ability to reuse memory across multiple concurrent invocations. Pricing starting at $0.0106 per GB-Hour

2. **预置内存（Provisioned Memory）** 指函数运行期间为保持其存活所必需的内存资源。以 GB·小时（GB-Hour）为单位计量，计费费率显著更低（不足活跃 CPU 费率的 10%），这得益于 Fluid 平台支持在多个并发调用间复用内存的能力。起始价格为每 GB·小时 $0.0106。

3. **Invocations** are counted per function call (just like in traditional serverless) and remain part of the overall pricing

3. **调用次数（Invocations）** 按函数每次调用单独计数（与传统无服务器架构一致），并计入整体计费。

This pricing model in action:

该定价模型的实际示例：

A function running on a Standard machine size at 100% active CPU would now cost ~$0.149 per hour (1 Active CPU GB-Hour + 2 GB of provisioned memory). Previously, this would have cost $0.31842 per hour (1.7 GB Memory × $0.18).

一个在“标准型”（Standard）机器规格上以 100% 活跃 CPU 运行的函数，当前每小时费用约为 $0.149（含 1 个 Active CPU·GB·Hour + 2 GB 预置内存）。此前，同等配置的费用为每小时 $0.31842（1.7 GB 内存 × $0.18）。

## Built for the way modern apps run

## 专为现代应用的运行方式而构建

Fluid is our proprietary compute platform, built for modern workloads.

Fluid 是我们自主研发的计算平台，专为现代工作负载而设计。

It simplifies cloud infrastructure while preserving flexibility and performance. Developers can use standard runtimes like Node.js and Python, making it easy to run existing code without changes.

它在简化云基础设施的同时，兼顾灵活性与性能。开发者可直接使用 Node.js、Python 等标准运行时环境，无需修改即可轻松运行现有代码。

Fluid powers core product experiences across our platform, including [Functions](https://vercel.com/docs/functions), and [recently announced Sandbox](https://vercel.com/changelog/run-untrusted-code-with-vercel-sandbox). All of them run on the same compute engine, optimized for concurrency, reuse, and efficiency, with unified billing across the stack.

Fluid 为平台上的核心产品功能提供算力支撑，包括 [Functions（函数服务）](https://vercel.com/docs/functions) 和 [近期发布的 Sandbox（沙箱）](https://vercel.com/changelog/run-untrusted-code-with-vercel-sandbox)。所有这些服务均运行于同一计算引擎之上——该引擎针对高并发、资源复用与能效比进行了深度优化，并在整个技术栈中实现统一计费。

## Available today

## 即日起正式上线

Active CPU pricing is now enabled by default for all Hobby, Pro, and new Enterprise teams. For existing Enterprise customers, availability depends on your current plan configuration. Most teams will have access right away. Reach out to your Vercel account representative to learn more and enable the new pricing model.

所有 Hobby、Pro 以及新创建的 Enterprise 团队现已默认启用 Active CPU 定价模式。对于现有 Enterprise 客户，该功能是否可用取决于您当前的套餐配置；大多数团队可立即启用。如需了解详情或启用此新定价模式，请联系您的 Vercel 账户代表。

With Active CPU, Fluid compute automatically optimizes your costs to match actual usage. It reduces waste, scales with real usage, and reflects the way modern apps actually run.

借助 Active CPU，Fluid Compute 可自动根据实际使用情况优化成本：减少资源浪费、随真实负载弹性伸缩，并精准反映现代应用的实际运行方式。

[**Deploy an AI-powered app with Fluid compute today**\\
\\
Optimize your AI applications with Fluid compute and maximize your compute. \\
\\
Get started](https://vercel.com/templates/ai)

[**今天即用 Fluid Compute 部署 AI 驱动的应用**\\
\\
利用 Fluid Compute 优化您的 AI 应用，充分释放计算性能。\\
\\
立即开始](https://vercel.com/templates/ai)
&#123;% endraw %}
