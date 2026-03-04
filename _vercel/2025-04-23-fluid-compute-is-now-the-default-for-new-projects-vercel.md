---
title: "Fluid compute is now the default for new projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/fluid-compute-is-now-the-default-for-new-projects"
date: "2025-04-23"
scraped_at: "2026-03-02T09:34:32.356312030+00:00"
language: "en-zh"
translated: true
description: "Fluid compute is now enabled by default for all new projects on Vercel, bringing improvements in efficiency, scalability, and cost effectiveness."
---
{% raw %}

Apr 23, 2025

2025 年 4 月 23 日

New Vercel projects now run on [Fluid compute](https://vercel.com/blog/introducing-fluid-compute) by default.

新创建的 Vercel 项目现默认运行在 [Fluid compute](https://vercel.com/blog/introducing-fluid-compute) 上。

This update follows [Fluid’s general availability](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute), its adoption across large-scale production apps, and all [v0.dev](https://v0.dev/) deployments [shipping with Fluid enabled](https://x.com/v0/status/1910732097792467373) by default.

此次更新紧随 [Fluid 正式发布](https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute) 之后，目前已广泛应用于大规模生产级应用，并且所有 [v0.dev](https://v0.dev/) 的部署均[默认启用 Fluid](https://x.com/v0/status/1910732097792467373)。

Fluid compute reuses existing instances before spawning new ones, cutting costs by up to 85% for high-concurrency workloads. It combines the efficiency of servers with the flexibility of serverless:

Fluid compute 在启动新实例前优先复用现有实例，可将高并发工作负载的成本最高降低 85%。它融合了传统服务器的高效性与无服务器架构（serverless）的灵活性：

- 每个函数支持并发请求  
- 从零自动扩展至无限规模  
- 冷启动时间极短  
- 按用量计费，即用即付  
- 全面支持 Node.js 和 Python  
- 无需管理底层基础设施

- Background tasks with `waitUntil`

- 使用 `waitUntil` 执行后台任务

[Enable Fluid](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)

[启用 Fluid](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)

for your existing projects, and learn more in our [blog](https://vercel.com/blog/introducing-fluid-compute) and [documentation](https://vercel.com/docs/functions/fluid-compute).

为您的现有项目启用 Fluid，并在我们的 [博客文章](https://vercel.com/blog/introducing-fluid-compute) 和 [文档](https://vercel.com/docs/functions/fluid-compute) 中了解更多信息。
{% endraw %}
