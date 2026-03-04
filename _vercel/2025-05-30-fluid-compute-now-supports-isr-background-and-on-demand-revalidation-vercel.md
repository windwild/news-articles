---
title: "Fluid compute now supports ISR background and on-demand revalidation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/fluid-compute-now-supports-isr-background-and-on-demand-revalidation"
date: "2025-05-30"
scraped_at: "2026-03-02T09:33:07.358686969+00:00"
language: "en-zh"
translated: true
description: "Fluid compute now supports both background and on-demand revalidations across all Vercel projects. This update brings the same performance and efficiency improvements to on-demand cache updates, with ..."
---
{% raw %}

May 30, 2025

2025 年 5 月 30 日

[Fluid compute](https://vercel.com/docs/functions/fluid-compute) now supports both background and on-demand [Incremental Static Regeneration (ISR)](https://vercel.com/docs/incremental-static-regeneration) across all Vercel projects.

[Fluid compute](https://vercel.com/docs/functions/fluid-compute) 现已支持在所有 Vercel 项目中运行后台模式和按需模式的 [增量静态再生（ISR）](https://vercel.com/docs/incremental-static-regeneration)。

This means ISR functions now benefit from Fluid's [performance and concurrency efficiency](https://vercel.com/docs/functions/fluid-compute#optimized-concurrency) with no config changes needed. If you’ve redeployed recently, you’re already using it.

这意味着，ISR 函数现在可直接享受 Fluid 的 [性能与并发效率优势](https://vercel.com/docs/functions/fluid-compute#optimized-concurrency)，且无需任何配置变更。若您近期已重新部署，那么您实际上已在使用该功能。

Fluid compute reuses existing resources before creating new ones, reducing costs by up to 85% for high-concurrency workloads. It delivers server-like efficiency with serverless flexibility with:

Fluid compute 在创建新资源前优先复用现有资源，可将高并发工作负载的成本最高降低 85%。它兼具服务器级的执行效率与无服务器架构的灵活性，具体特性包括：

- Optimized concurrency  
- Scale from zero to infinity  
- Minimal cold starts  
- Usage-based pricing  
- Full Node.js and Python support  
- No infrastructure management  

- 优化的并发处理能力  
- 从零到无限弹性伸缩  
- 极低的冷启动延迟  
- 按用量计费  
- 完整支持 Node.js 和 Python  
- 无需基础设施管理

- Background tasks with `waitUntil`

- 使用 `waitUntil` 执行后台任务

[Enable Fluid](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)

[启用 Fluid](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)

for your existing projects, and learn more in our [blog](https://vercel.com/blog/introducing-fluid-compute) and [documentation](https://vercel.com/docs/functions/fluid-compute).

为您的现有项目启用 Fluid，并在我们的 [博客文章](https://vercel.com/blog/introducing-fluid-compute) 和 [文档](https://vercel.com/docs/functions/fluid-compute) 中了解更多信息。
{% endraw %}
