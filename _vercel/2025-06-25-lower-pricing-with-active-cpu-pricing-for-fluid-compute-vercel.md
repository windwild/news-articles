---
title: "Lower pricing with Active CPU pricing for Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute"
date: "2025-06-25"
scraped_at: "2026-03-02T09:32:00.821098960+00:00"
language: "en-zh"
translated: true
description: "Pricing for Vercel Functions on Fluid compute has been reduced. All Fluid-based compute now uses an Active CPU pricing model, offering up to 90% savings in addition to the cost efficiency already deli..."
---
&#123;% raw %}

Jun 25, 2025

2025 年 6 月 25 日

![](images/lower-pricing-with-active-cpu-pricing-for-fluid-compute-vercel/img_001.jpg)![](images/lower-pricing-with-active-cpu-pricing-for-fluid-compute-vercel/img_002.jpg)

Vercel Functions on Fluid Compute now use Active CPU pricing, which charges for CPU only while it is actively doing work. This eliminates costs during idle time and reduces spend for workloads like LLM inference, long-running AI agents, or any task with idle time.

Fluid Compute 上的 Vercel Functions 现已采用“活跃 CPU 定价”（Active CPU Pricing）模式，即仅在 CPU 实际执行计算任务时计费。该模式消除了空闲时段的费用，显著降低了大语言模型（LLM）推理、长期运行的 AI 智能体，或任何存在空闲时间的任务的总体开销。

Active CPU pricing is built on three core metrics:

“活跃 CPU 定价”基于以下三项核心指标：

- **Active CPU**: Time your code is actively executing in an instance. Priced at $0.128 per hour  
- **活跃 CPU**：代码在实例中实际执行的时间，单价为每小时 $0.128  

- **Provisioned Memory:** Memory allocated to the instance, billed at a lower rate. Priced at $0.0106 per GB-Hour  
- **预置内存**：为实例分配的内存容量，按更低费率计费，单价为每 GB·小时 $0.0106  

- **Invocations**: One charge per function call  
- **调用次数**：每次函数调用收取一次费用  

**An example of this in action:**

**实际计费示例：**

A function running Standardmachine size at 100% active CPU would now cost ~$0.149 per hour (1 Active CPU hour + 2 GB of provisioned memory). Previously this would have cost $0.31842 per hour (1.7 GB Memory × $0.18).

一个以 Standardmachine 规格运行、CPU 利用率持续达 100% 的函数，当前每小时成本约为 $0.149（含 1 小时活跃 CPU + 2 GB 预置内存）；此前同等配置的每小时成本为 $0.31842（1.7 GB 内存 × $0.18）。

Active CPU pricing is now enabled by default for all Hobby, Pro, and new Enterprise teams. For existing Enterprise customers, availability depends on your current plan configuration.

“活跃 CPU 定价”目前已对所有 Hobby、Pro 计划用户，以及新注册的 Enterprise 团队默认启用。对于现有 Enterprise 客户，是否可用取决于您当前的套餐配置。

This change takes effect after a redeploy.

此更改将在重新部署后生效。

Learn more about [Fluid compute with Active CPU pricing](https://vercel.com/docs/fluid-compute/pricing) and read the [announcement](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute).

了解更多关于[采用 Active CPU 定价的 Fluid 计算](https://vercel.com/docs/fluid-compute/pricing)，并阅读[公告](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)。
&#123;% endraw %}
