---
title: "Zero-configuration support for Koa - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-support-for-koa"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:38.785532190+00:00"
language: "en-zh"
translated: true
description: "Vercel now detects and deploys Koa, an expressive HTTP middleware framework to make web applications and APIs more enjoyable to write."
---
{% raw %}

Feb 3, 2026

2026 年 2 月 3 日

Vercel 现已支持 [Koa](https://koajs.com/) 应用程序——一个富有表现力的 HTTP 中间件框架，可让 Web 应用和 API 的开发过程更加轻松愉悦，且无需任何配置。

server.ts

```typescript
import Koa from 'koa'

import { Router } from '@koa/router'



const app = new Koa()

const router = new Router()



router.get('/', (ctx) => {

8  ctx.body = { message: 'Hello from Koa!' }

9})



app.use(router.routes())

app.use(router.allowedMethods())



app.listen(3000)
```

A "Hello World" Koa app on Vercel

在 Vercel 上运行的“Hello World”Koa 应用

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your Koa app will automatically scale up and down based on traffic, and you only pay for what you use.

Vercel 上的后端默认使用 [Fluid compute（流式计算）](https://vercel.com/fluid) 和 [Active CPU pricing（按活跃 CPU 计费）](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)。这意味着您的 Koa 应用将根据流量自动扩缩容，您只需为实际使用的资源付费。

Visit the [Koa on Vercel documentation](https://vercel.com/docs/frameworks/backend/koa) for more details.

更多详情，请参阅 [Vercel 上的 Koa 文档](https://vercel.com/docs/frameworks/backend/koa)。
{% endraw %}
