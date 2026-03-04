---
title: "Improved support for Nuxt on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/nuxt-on-vercel"
date: "2023-05-05"
scraped_at: "2026-03-02T09:52:43.170266288+00:00"
language: "en-zh"
translated: true
description: "Nuxt on Vercel now supports KV for Redis, Incremental Static Regeneration, and more."
---

render_with_liquid: false
May 5, 2023

2023 年 5 月 5 日

Nuxt 应用现在可以充分利用 Vercel KV、增量静态再生（ISR）等能力。

我们一直与 Nuxt 团队合作，进一步深化该框架与 Vercel 的集成，并全面支持所有 Vercel 产品。目前，Nuxt 在 Vercel 上已支持以下功能：

- [Vercel KV 与 Nitro Storage 的集成](https://vercel.com/blog/nuxt-on-vercel#vercel-kv-integration-with-nitro-storage)

- [完整的静态生成支持](https://vercel.com/blog/nuxt-on-vercel#static-and-isr-support-for-nuxt)

- [增量静态再生（ISR）支持](https://vercel.com/blog/nuxt-on-vercel#static-and-isr-support-for-nuxt)

这一进展延续了 Nuxt 与 Vercel 其他产品的深度集成，例如 [Functions（函数）](https://vercel.com/docs/frameworks/nuxt#edge-functions)、[Middleware（中间件）](https://vercel.com/docs/frameworks/nuxt#middleware)、[图像优化（Image Optimization）](https://vercel.com/docs/frameworks/nuxt#image-optimization) 等。

## Vercel KV 集成 Nitro Storage

## Vercel KV 与 Nitro Storage 的集成

Vercel [近期正式推出 Vercel KV](https://vercel.com/blog/vercel-storage#vercel-kv-a-durable-redis-database) —— 一款无服务器、持久化的 Redis 数据库。我们与 Nuxt 团队携手合作，在 Nitro 中原生支持 Vercel KV，从而为您的 Nuxt 应用提供高性能的键值存储能力。

仅需数行配置代码，您即可为 Nuxt 应用快速搭建具备持久化存储能力的缓存系统：

`nuxt.config.ts`

`nuxt.config.ts`

```tsx
export default defineNuxtConfig({

2  nitro: {

3    storage: {

4      data: { driver: 'vercelKV' }

5    }

6  }

7})
```

```tsx
export default defineNuxtConfig({

2  nitro: {

3    storage: {

4      data: { driver: 'vercelKV' }

5    }

6  }

7})
```

Nuxt automatically reads the `KV_REST_API_URL` and `KV_REST_API_TOKEN` environment variables for your KV database. Then, you can easily store data in any event handler:

Nuxt 会自动读取您 KV 数据库所需的环境变量 `KV_REST_API_URL` 和 `KV_REST_API_TOKEN`。随后，您即可在任意事件处理器中轻松存储数据：

```javascript
export default eventHandler(async (event) => {
```

```javascript
export default eventHandler(async (event) => {
```

2  const storage = useStorage('data');

2  const storage = useStorage('data');

3  await storage.setItem('userId', 'id');

3  await storage.setItem('userId', 'id');



5  return {

5  return {

6    id: await dataStorage.getItem('userId'),

6    id: await dataStorage.getItem('userId'),

7  };

7  };

8});
```

8});
```

View a demo of [Vercel KV with Nuxt](https://github.com/danielroe/vercel-kv) or see the [Nitro docs](https://nitro.unjs.io/deploy/providers/vercel#vercel-kv-storage).

查看 [Vercel KV 与 Nuxt 的演示示例](https://github.com/danielroe/vercel-kv)，或参阅 [Nitro 文档](https://nitro.unjs.io/deploy/providers/vercel#vercel-kv-storage)。

## Static and ISR support for Nuxt

## Nuxt 的静态生成与增量静态再生（ISR）支持

Nuxt developers want to choose the best rendering strategy for a given page. With the [Nitro 2.4 release](https://github.com/unjs/nitro/releases/tag/v2.4.0), they can now pick between fully static, fully dynamic, or incrementally updated routes with powerful route rules.

Nuxt 开发者希望为特定页面选择最合适的渲染策略。借助 [Nitro 2.4 版本发布](https://github.com/unjs/nitro/releases/tag/v2.4.0)，开发者现在可在完全静态、完全动态，或支持增量更新的路由之间灵活选择，并通过强大的路由规则（route rules）进行精细控制。

`nuxt.config.js`

`nuxt.config.js`

```javascript
export default defineNuxtConfig({

2  routeRules: {

3    // all routes will be background revalidated (ISR) at most every 60 seconds

4    '/**': { isr: 60 },

5    // this page will be generated on demand and cached permanently

6    '/static': { isr: true }

7  },

8});
```

```javascript
export default defineNuxtConfig({

2  routeRules: {

3    // 所有路由将最多每隔 60 秒在后台重新验证（ISR）

4    '/**': { isr: 60 },

5    // 此页面将按需生成，并永久缓存

6    '/static': { isr: true }

7  },

8});
```

Nuxt's route rules enable you to opt different routes into the optimal rendering strategy.

Nuxt 的路由规则允许你为不同路由选择最合适的渲染策略。

View a demo of [ISR with Nuxt](https://github.com/danielroe/nuxt-vercel-isr) to try out route rules.

查看 [Nuxt 的 ISR 演示](https://github.com/danielroe/nuxt-vercel-isr)，亲身体验路由规则功能。

## Partnering with Nuxt

## 与 Nuxt 携手合作

We're thrilled the Nuxt team has chosen to build [nuxt.com](https://nuxt.com/), [nuxtlabs.com](https://nuxtlabs.com/), [nuxt.studio](https://nuxt.studio/), [volta.net](https://volta.net/), and more with Vercel.

我们非常欣喜地看到，Nuxt 团队选择使用 Vercel 构建 [nuxt.com](https://nuxt.com/)、[nuxtlabs.com](https://nuxtlabs.com/)、[nuxt.studio](https://nuxt.studio/)、[volta.net](https://volta.net/) 等多个重要站点。

> “We love working with Vercel. They share our values of great DX, zero-configuration and best practices built-in. I'm also really pleased to see the new offerings Vercel have been launching this week. I'm confident they will make Nuxt users' lives easier and better.We love working with Vercel. They share our values of great DX, zero-configuration and best practices built-in. I'm also really pleased to see the new offerings Vercel have been launching this week. I'm confident they will make Nuxt users' lives easier and better.”
>
> “我们非常喜爱与 Vercel 合作。他们在卓越的开发者体验（DX）、零配置以及开箱即用的最佳实践等方面，与我们的价值观高度一致。我也非常高兴看到 Vercel 本周推出的全新产品与服务。我坚信，这些新能力将让 Nuxt 用户的开发体验更轻松、更高效。”

> ![](images/improved-support-for-nuxt-on-vercel-vercel/img_001.jpg)
>
> ![](images/improved-support-for-nuxt-on-vercel-vercel/img_001.jpg)

> **Daniel Roe**

> **Daniel Roe**

We're excited about our continued sponsorship of the framework and investment into supporting the latest Nuxt features on Vercel.

我们非常期待持续赞助 Nuxt 框架，并进一步投入资源，以在 Vercel 平台上全面支持 Nuxt 的最新特性。

With Vercel's powerful tools and performance enhancements, Nuxt continues to be a leading choice for web developers looking to build modern, serverless applications.

凭借 Vercel 强大的工具链与性能优化能力，Nuxt 已成为 Web 开发者构建现代化无服务器应用的首选框架之一。

## Try Nuxt on Vercel

## 在 Vercel 上试用 Nuxt

See how to seamlessly integrate Vercel KV, a serverless Redis solution, with Nuxt.js using Nitro storage.

了解如何通过 Nitro 存储层，无缝集成 Vercel KV（一种无服务器 Redis 解决方案）与 Nuxt.js。

Vercel supports all features of Nuxt out of the box, now including support for Vercel KV as a durable storage layer.

Vercel 开箱即用地全面支持 Nuxt 的所有特性，现已包含对 Vercel KV 作为持久化存储层的支持。

To leverage Vercel KV storage and ISR features for Nuxt, upgrade your Nuxt project to Nitro >= 2.4.0 with `npx nuxi@latest upgrade --force`.

如需在 Nuxt 中启用 Vercel KV 存储与增量静态再生（ISR）功能，请运行 `npx nuxi@latest upgrade --force` 将您的 Nuxt 项目升级至 Nitro 2.4.0 或更高版本。

Learn more about [Nuxt on Vercel](https://vercel.com/docs/frameworks/nuxt) or [deploy a Nuxt template](https://vercel.com/templates/nuxt).

了解更多关于 [Vercel 上的 Nuxt](https://vercel.com/docs/frameworks/nuxt)，或 [部署一个 Nuxt 模板](https://vercel.com/templates/nuxt)。