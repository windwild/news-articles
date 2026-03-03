---
title: "Support for TanStack Start - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/support-for-tanstack-start"
date: "2025-11-10"
scraped_at: "2026-03-02T09:25:56.686001844+00:00"
language: "en"
translated: false
description: "Vercel now detects and deploys TanStack Start, a full-stack framework powered by TanStack Router for React and Solid."
---




Nov 10, 2025

![](images/support-for-tanstack-start-vercel/img_001.jpg)![](images/support-for-tanstack-start-vercel/img_002.jpg)

Vercel detects and supports TanStack Start applications, a full-stack framework powered by TanStack Router for React and Solid.

[Create a new TanStack Start app](https://vercel.com/templates/starter/tanstack-start-on-vercel) or add nitro() to vite.config.ts in your existing application to easily deploy your projects:

vite.config.ts

```typescript
import { tanstackStart } from '@tanstack/react-start/plugin/vite'

import { defineConfig } from 'vite'

import viteReact from '@vitejs/plugin-react'

import { nitro } from 'nitro/vite'



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

Visit the [TanStack Start on Vercel documentation](https://vercel.com/docs/frameworks/full-stack/tanstack-start) to learn more