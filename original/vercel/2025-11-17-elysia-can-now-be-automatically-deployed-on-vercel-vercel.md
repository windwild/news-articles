---
title: "Elysia can now be automatically deployed on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/support-for-elysia"
date: "2025-11-17"
scraped_at: "2026-03-02T09:25:52.233502120+00:00"
language: "en"
translated: false
description: "Elysia, a popular ergonomic TypeScript framework with end-to-end type safety, can now be detected and deployed at Vercel."
---




Nov 17, 2025

![](images/elysia-can-now-be-automatically-deployed-on-vercel-vercel/img_001.jpg)![](images/elysia-can-now-be-automatically-deployed-on-vercel-vercel/img_002.jpg)

[Elysia](https://elysiajs.com/), a popular ergonomic TypeScript framework with end-to-end type safety, can now be deployed instantly on Vercel.

When deployed, Vercel will now automatically identify your app is running Elysia and provision the optimal resources to run it efficiently.

src/index.ts

```typescript
import { Elysia } from "elysia";



const app = new Elysia()

4  .get("/", () => `Hello from Elysia, running on Vercel!`);



export default app;


```

By default, Elysia will use Node. You can opt-in to the Bun runtime by adding the [bunVersion line](https://vercel.com/docs/functions/runtimes/bun#configuring-the-runtime) below to your `vercel.json`.

vercel.json

```json
1{

2  "$schema": "https://openapi.vercel.sh/vercel.json",

3  "bunVersion": "1.x"

4}
```

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default, so you only pay for time where your code is actively using CPU.

[Deploy Elysia on Vercel](https://vercel.com/templates/backend/elysia-on-vercel), or visit the documentation for [Elysia](https://vercel.com/docs/frameworks/backend/elysia) or [Bun Runtime](https://vercel.com/docs/functions/runtimes/bun#configuring-the-runtime) at Vercel.