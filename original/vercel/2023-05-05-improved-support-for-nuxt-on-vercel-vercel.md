---
title: "Improved support for Nuxt on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/nuxt-on-vercel"
date: "2023-05-05"
scraped_at: "2026-03-02T09:52:43.170266288+00:00"
language: "en"
translated: false
description: "Nuxt on Vercel now supports KV for Redis, Incremental Static Regeneration, and more."
---




May 5, 2023

Nuxt applications can now take advantage of Vercel KV, ISR, and more.

We've been partnering with Nuxt to further integrate the framework with Vercel and support all Vercel products. Nuxt on Vercel now supports:

- [Vercel KV integration with Nitro Storage](https://vercel.com/blog/nuxt-on-vercel#vercel-kv-integration-with-nitro-storage)

- [Full static support](https://vercel.com/blog/nuxt-on-vercel#static-and-isr-support-for-nuxt)

- [Incremental Static Revalidation support](https://vercel.com/blog/nuxt-on-vercel#static-and-isr-support-for-nuxt)


This builds on the integration with other Vercel products like [Functions](https://vercel.com/docs/frameworks/nuxt#edge-functions), [Middleware](https://vercel.com/docs/frameworks/nuxt#middleware), [Image Optimization](https://vercel.com/docs/frameworks/nuxt#image-optimization), and more.

## Vercel KV integration with Nitro Storage

Vercel [recently launched Vercel KV](https://vercel.com/blog/vercel-storage#vercel-kv-a-durable-redis-database), a serverless durable Redis store. We've partnered with the Nuxt team to add support for integrating Vercel KV into Nitro, making fast key-value storage available for your Nuxt apps.

In a few lines of configuration, you can now set up a cache with durable storage for your Nuxt application:

nuxt.config.ts

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

```javascript
export default eventHandler(async (event) => {

2  const storage = useStorage('data');

3  await storage.setItem('userId', 'id');



5  return {

6    id: await dataStorage.getItem('userId'),

7  };

8});
```

View a demo of [Vercel KV with Nuxt](https://github.com/danielroe/vercel-kv) or see the [Nitro docs](https://nitro.unjs.io/deploy/providers/vercel#vercel-kv-storage).

## Static and ISR support for Nuxt

Nuxt developers want to choose the best rendering strategy for a given page. With the [Nitro 2.4 release](https://github.com/unjs/nitro/releases/tag/v2.4.0), they can now pick between fully static, fully dynamic, or incrementally updated routes with powerful route rules.

nuxt.config.js

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

Nuxt's route rules enable you to opt different routes into the optimal rendering strategy.

View a demo of [ISR with Nuxt](https://github.com/danielroe/nuxt-vercel-isr) to try out route rules.

## Partnering with Nuxt

We're thrilled the Nuxt team has chosen to build [nuxt.com](https://nuxt.com/), [nuxtlabs.com](https://nuxtlabs.com/), [nuxt.studio](https://nuxt.studio/), [volta.net](https://volta.net/), and more with Vercel.

> “We love working with Vercel. They share our values of great DX, zero-configuration and best practices built-in. I'm also really pleased to see the new offerings Vercel have been launching this week. I'm confident they will make Nuxt users' lives easier and better.We love working with Vercel. They share our values of great DX, zero-configuration and best practices built-in. I'm also really pleased to see the new offerings Vercel have been launching this week. I'm confident they will make Nuxt users' lives easier and better.”
>
> ![](images/improved-support-for-nuxt-on-vercel-vercel/img_001.jpg)
>
> **Daniel Roe**

We're excited about our continued sponsorship of the framework and investment into supporting the latest Nuxt features on Vercel.

﻿With Vercel's powerful tools and performance enhancements, Nuxt continues to be a leading choice for web developers looking to build modern, serverless applications.

## Try Nuxt on Vercel

See how to seamlessly integrate Vercel KV, a serverless Redis solution, with Nuxt.js using Nitro storage.

Vercel supports all features of Nuxt out of the box, now including support for Vercel KV as a durable storage layer.

To leverage Vercel KV storage and ISR features for Nuxt, upgrade your Nuxt project to Nitro >= 2.4.0 with `npx nuxi@latest upgrade --force`.

Learn more about [Nuxt on Vercel](https://vercel.com/docs/frameworks/nuxt) or [deploy a Nuxt template](https://vercel.com/templates/nuxt).