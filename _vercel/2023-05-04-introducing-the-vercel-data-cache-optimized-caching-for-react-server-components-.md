---
title: "Introducing the Vercel Data Cache: Optimized caching for React Server Components - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-vercel-data-cache"
date: "2023-05-04"
scraped_at: "2026-03-02T09:52:50.412611216+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

May 4, 2023

2023 年 5 月 4 日

![](images/introducing-the-vercel-data-cache-optimized-caching-for-react-server-components-/img_001.jpg)![](images/introducing-the-vercel-data-cache-optimized-caching-for-react-server-components-/img_002.jpg)

Vercel Data Cache 现已正式推出，为您提供由框架定义的缓存与传播基础设施，以高效处理来自 [React Server Components](https://nextjs.org/docs/getting-started/react-essentials#server-components) 的响应。

Data Cache 是一个全球分布式、临时性的缓存系统，既可在无服务器（serverless）运行时中访问，也可在边缘（edge）运行时中访问。它支持按区域对数据进行细粒度缓存——即在函数实际执行的地理区域内缓存数据，并根据响应类型采用不同的缓存策略：

- 动态数据：每次执行时均重新获取  
- 静态数据：缓存后按时间周期自动重新验证，或按需手动触发重新验证  

目前，该功能仅支持 [Next.js App Router](https://nextjs.org/docs/getting-started/installation)，且面向 [所有付费计划](https://vercel.com/docs/infrastructure/data-cache/limits-and-pricing) 的用户开放。

[查阅我们的官方文档](https://vercel.com/docs/infrastructure/data-cache) 和 [使用限制说明](https://vercel.com/docs/infrastructure/data-cache/limits-and-pricing)，了解更多信息。
{% endraw %}
