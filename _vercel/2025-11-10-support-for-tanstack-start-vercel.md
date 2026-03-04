---
title: "Support for TanStack Start - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/support-for-tanstack-start"
date: "2025-11-10"
scraped_at: "2026-03-02T09:25:56.686001844+00:00"
language: "en-zh"
translated: true
description: "Vercel now detects and deploys TanStack Start, a full-stack framework powered by TanStack Router for React and Solid."
---

render_with_liquid: false
Nov 10, 2025

2025年11月10日

![](images/support-for-tanstack-start-vercel/img_001.jpg)![](images/support-for-tanstack-start-vercel/img_002.jpg)

Vercel detects and supports TanStack Start applications, a full-stack framework powered by TanStack Router for React and Solid.

Vercel 可自动识别并支持 TanStack Start 应用——这是一个基于 TanStack Router 构建的全栈框架，适用于 React 和 Solid。

[Create a new TanStack Start app](https://vercel.com/templates/starter/tanstack-start-on-vercel) or add nitro() to vite.config.ts in your existing application to easily deploy your projects:

[创建一个新的 TanStack Start 应用](https://vercel.com/templates/starter/tanstack-start-on-vercel)，或在您现有的应用中向 `vite.config.ts` 文件添加 `nitro()`，即可轻松部署项目：

vite.config.ts

`vite.config.ts`

```typescript
import { tanstackStart } from '@tanstack/react-start/plugin/vite'

import { defineConfig } from 'vite'

import viteReact from '@vitejs/plugin-react'

import { nitro } from 'nitro/vite'
```

```js
export default defineConfig({

7  plugins: [\
\
8    tanstackStart(),\
\
9    nitro(),\
\
10    viteReact(),\
\
11  ],

12})
```

```js
export default defineConfig({

7  plugins: [\
\
8    tanstackStart(),\
\
9    nitro(),\
\
10    viteReact(),\
\
11  ],

12})
```

TanStack Start apps on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your TanStack Start app will automatically scale up and down based on traffic, and you only pay for what you use, not for idle function time.

在 Vercel 上部署的 TanStack Start 应用默认使用 [Fluid compute（流体计算）](https://vercel.com/fluid) 及其 [Active CPU pricing（按活跃 CPU 使用计费）](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) 模式。这意味着您的 TanStack Start 应用将根据实际流量自动扩缩容，您仅需为实际使用的计算资源付费，而无需为函数空闲时间付费。

Visit the [TanStack Start on Vercel documentation](https://vercel.com/docs/frameworks/full-stack/tanstack-start) to learn more

请访问 [Vercel 上的 TanStack Start 文档](https://vercel.com/docs/frameworks/full-stack/tanstack-start) 了解更多信息