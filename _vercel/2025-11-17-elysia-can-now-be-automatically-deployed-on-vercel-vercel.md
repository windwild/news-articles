---
title: "Elysia can now be automatically deployed on Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/support-for-elysia"
date: "2025-11-17"
scraped_at: "2026-03-02T09:25:52.233502120+00:00"
language: "en-zh"
translated: true
description: "Elysia, a popular ergonomic TypeScript framework with end-to-end type safety, can now be detected and deployed at Vercel."
---

render_with_liquid: false
Nov 17, 2025

2025年11月17日

![](images/elysia-can-now-be-automatically-deployed-on-vercel-vercel/img_001.jpg)![](images/elysia-can-now-be-automatically-deployed-on-vercel-vercel/img_002.jpg)

[Elysia](https://elysiajs.com/)，一款广受欢迎的、具备端到端类型安全性的符合人体工学的 TypeScript 框架，现已支持在 Vercel 上一键部署。

部署时，Vercel 将自动识别您的应用基于 Elysia 构建，并为其配置最优资源，以实现高效运行。

src/index.ts

```typescript
import { Elysia } from "elysia";



const app = new Elysia()

4  .get("/", () => `Hello from Elysia, running on Vercel!`);
```

```ts
export default app;
```


默认情况下，Elysia 将使用 Node.js 运行时。您可以通过在 `vercel.json` 文件中添加以下 [`bunVersion`](https://vercel.com/docs/functions/runtimes/bun#configuring-the-runtime) 配置行，选择启用 Bun 运行时。

`vercel.json`

```json
1{
2  "$schema": "https://openapi.vercel.sh/vercel.json",
3  "bunVersion": "1.x"
4}
```

Vercel 上的后端服务默认采用 [Fluid Compute（流式计算）](https://vercel.com/fluid)，并按 [Active CPU 定价模式](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) 计费，因此您仅需为代码实际占用 CPU 的时间付费。

[在 Vercel 上部署 Elysia](https://vercel.com/templates/backend/elysia-on-vercel)，或访问 Vercel 官方文档了解 [Elysia 框架支持](https://vercel.com/docs/frameworks/backend/elysia) 或 [Bun 运行时配置](https://vercel.com/docs/functions/runtimes/bun#configuring-the-runtime)。