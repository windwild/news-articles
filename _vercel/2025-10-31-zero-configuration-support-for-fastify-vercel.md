---
title: "Zero-configuration support for Fastify - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-support-for-fastify"
date: "2025-10-31"
scraped_at: "2026-03-02T09:26:19.189888124+00:00"
language: "en-zh"
translated: true
description: "Vercel now detects and deploys Fastify, a fast and low overhead web framework, with zero configuration."
---

render_with_liquid: false
Oct 31, 2025

2025 年 10 月 31 日

![](images/zero-configuration-support-for-fastify-vercel/img_001.jpg)![](images/zero-configuration-support-for-fastify-vercel/img_002.jpg)

Vercel now supports [Fastify](https://fastify.dev/) applications, a web framework highly focused on providing the best developer experience with the least overhead and a powerful plugin architecture, with zero-configuration.

Vercel 现已支持 [Fastify](https://fastify.dev/) 应用——这是一款高度专注于以最低开销提供最佳开发者体验、并具备强大插件架构的 Web 框架，且完全无需配置。

src/server.ts

```typescript
import Fastify from 'fastify'



const fastify = Fastify({ logger: true })



fastify.get('/', async (request, reply) => {  return { hello: 'world' }})
```

fastify.listen({ port: 3000 })
```

A "Hello World" Fastify app on Vercel

在 Vercel 上运行的 “Hello World” Fastify 应用

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your Fastify app will automatically scale up and down based on traffic, and you only pay for what you use.

Vercel 上的后端默认使用 [Fluid compute（流式计算）](https://vercel.com/fluid) 和 [Active CPU pricing（按活跃 CPU 计费）](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)。这意味着您的 Fastify 应用将根据流量自动扩缩容，您只需为实际使用的资源付费。

[Deploy Fastify on Vercel](https://vercel.com/templates/backend/fastify-on-vercel) or visit the [Fastify on Vercel documentation](https://vercel.com/docs/frameworks/backend/fastify)

[在 Vercel 上部署 Fastify](https://vercel.com/templates/backend/fastify-on-vercel)，或查阅 [Vercel 上的 Fastify 文档](https://vercel.com/docs/frameworks/backend/fastify)