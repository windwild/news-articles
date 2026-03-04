---
title: "Vercel Functions can now run on Fluid compute - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-functions-can-now-run-on-fluid-compute"
date: "2025-02-04"
scraped_at: "2026-03-02T09:38:10.158540974+00:00"
language: "en-zh"
translated: true
description: "Vercel Functions can now run on Fluid compute, a next-generation execution model that improves efficiency and reduces costs. It brings scalable, cost-effective compute without infrastructure complexit..."
---
&#123;% raw %}

Feb 4, 2025

2025 年 2 月 4 日

![](images/vercel-functions-can-now-run-on-fluid-compute-vercel/img_001.jpg)![](images/vercel-functions-can-now-run-on-fluid-compute-vercel/img_002.jpg)

Vercel Functions 现在可在 [Fluid compute](https://vercel.com/fluid) 上运行，显著提升了效率、可扩展性与成本效益。[Fluid 现已面向所有订阅计划开放](https://vercel.com/blog/introducing-fluid-compute)。

### **新增功能**

### **新增功能**

- **优化的并发处理能力：** 函数实例可同时处理多个请求，减少空闲时间，针对高并发工作负载最多可降低 **85%** 的计算成本  

- **冷启动防护机制：** 借助更智能的自动扩缩容策略与预热实例，大幅减少冷启动次数  

- **优化的扩缩容机制：** 函数层面先于实例进行扩缩容，突破传统“一次调用对应一个实例”的 1:1 模型  

- **延长的函数生命周期：** 可使用 `waitUntil` 在向客户端返回响应后继续执行后台任务  

- **失控成本防护：** 自动检测并终止无限循环及过度调用行为  

- **多区域执行支持：** 请求将被自动路由至您所选计算区域中地理位置最近的一个，从而提升性能

- **Node.js and Python support:** No restrictions on native modules or standard libraries

- **支持 Node.js 和 Python：** 对原生模块和标准库没有任何限制

[Enable Fluid today](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)

[立即启用 Fluid](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Ffunctions%23fluid-compute&title=Go+to+Function+Settings)

or learn more in our [blog](https://vercel.com/blog/introducing-fluid-compute) and [documentation](https://vercel.com/docs/functions/fluid-compute).

或在我们的 [博客文章](https://vercel.com/blog/introducing-fluid-compute) 和 [文档](https://vercel.com/docs/functions/fluid-compute) 中了解更多信息。
&#123;% endraw %}
