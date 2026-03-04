---
title: "Bun runtime now in Public Beta for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bun-runtime-now-in-public-beta-for-vercel-functions"
date: "2025-10-28"
scraped_at: "2026-03-02T09:26:39.154086929+00:00"
language: "en-zh"
translated: true
description: "The Bun runtime is now available in Public Beta for Vercel Functions. Benchmarks show Bun reduced average latency by 28% for CPU-bound Next.js rendering compared to Node.js."
---
{% raw %}

Oct 28, 2025

2025 年 10 月 28 日

Bun 运行时现已在 Vercel Functions 中开放公共测试版（Public Beta）。

您可以在项目中选择 Node.js 或 Bun 作为运行时，根据您的工作负载需求选用最合适的选项。

[基准测试显示，相较于 Node.js，Bun 在 CPU 密集型 Next.js 渲染场景下平均延迟降低了 28%](https://vercel.com/blog/bun-runtime-on-vercel-functions#benchmark-results)。

要在 Vercel Functions 中使用 Bun，请在项目的 `vercel.json` 文件中全局设置运行时：

vercel.json

```json
1{
2  "bunVersion": "1.x"
3}
```

通过在 `vercel.json` 中添加 `bunVersion` 字段，为您的应用启用 Bun 运行时支持。

We currently support the following frameworks, with more on the way:

我们目前支持以下框架，更多框架正在陆续添加中：

- `Next.js`

- `Next.js`

- `Hono`

- `Hono`

- `Express`

- `Express`

- `Nitro`

- `Nitro`


Bun supports TypeScript with zero configuration. Here's an example with Hono:

Bun 支持零配置 TypeScript。以下是使用 Hono 的示例：

src/index.ts

src/index.ts

```typescript
import { Hono } from 'hono';



const app = new Hono();
```

```javascript
app.get('/', (c) => {

6  return c.text(`Hello from Hono on Bun ${process.versions.bun}!`);

7});



export default app;
```

```javascript
app.get('/', (c) => {

6  return c.text(`Hello from Hono on Bun ${process.versions.bun}!`);

7});



export default app;
```

Hello World endpoint in Hono with the Bun runtime on Vercel

在 Vercel 上使用 Bun 运行时的 Hono “Hello World” 端点

Or get started with one of our starter templates:

或者从以下任一入门模板开始：

- [Express on Bun](https://vercel.com/templates/backend/express-on-bun)

- [Express on Bun](https://vercel.com/templates/backend/express-on-bun)

- [Hono on Bun](https://vercel.com/templates/backend/hono-on-bun)

- [Hono on Bun](https://vercel.com/templates/backend/hono-on-bun)

Bun deployments automatically integrate with Vercel's existing logging, observability, and monitoring systems.

Bun 部署自动与 Vercel 现有的日志记录、可观测性和监控系统集成。

See [benchmarks in our blog post](https://vercel.com/blog/bun-runtime-on-vercel-functions), or [read the docs to learn more](https://vercel.com/docs/functions/runtimes/bun).

请参阅[我们博客文章中的性能基准测试](https://vercel.com/blog/bun-runtime-on-vercel-functions)，或[阅读文档以了解更多信息](https://vercel.com/docs/functions/runtimes/bun)。
{% endraw %}
