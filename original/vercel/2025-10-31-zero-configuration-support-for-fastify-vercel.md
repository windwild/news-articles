---
title: "Zero-configuration support for Fastify - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-support-for-fastify"
date: "2025-10-31"
scraped_at: "2026-03-02T09:26:19.189888124+00:00"
language: "en"
translated: false
description: "Vercel now detects and deploys Fastify, a fast and low overhead web framework, with zero configuration."
---




Oct 31, 2025

![](images/zero-configuration-support-for-fastify-vercel/img_001.jpg)![](images/zero-configuration-support-for-fastify-vercel/img_002.jpg)

Vercel now supports [Fastify](https://fastify.dev/) applications, a web framework highly focused on providing the best developer experience with the least overhead and a powerful plugin architecture, with zero-configuration.

src/server.ts

```typescript
import Fastify from 'fastify'



const fastify = Fastify({ logger: true })



fastify.get('/', async (request, reply) => {  return { hello: 'world' }})



fastify.listen({ port: 3000 })
```

A "Hello World" Fastify app on Vercel

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your Fastify app will automatically scale up and down based on traffic, and you only pay for what you use.

[Deploy Fastify on Vercel](https://vercel.com/templates/backend/fastify-on-vercel) or visit the [Fastify on Vercel documentation](https://vercel.com/docs/frameworks/backend/fastify)