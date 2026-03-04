---
title: "Middleware now supports Node.js - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/middleware-now-supports-node-js"
date: "2025-02-26"
scraped_at: "2026-03-02T09:35:51.113889216+00:00"
language: "en-zh"
translated: true
description: "Next.js 15.2 introduces experimental Node.js Middleware, now available at Vercel—giving you full Node.js runtime support for your Middleware. Run authentication, logging, request handling, and more ..."
---

render_with_liquid: false
Feb 26, 2025

2025 年 2 月 26 日

Node.js 运行时的中间件支持现已上线，借助熟悉的 API，全面支持身份验证、个性化等功能。

无论使用何种运行时，中间件均持续在全球范围内的 Vercel 平台上部署。我们率先在 [Next.js 15.2](https://nextjs.org/blog/next-15-2) 中推出对 Node.js 中间件的支持。

该实验性功能需通过 Next.js 的 Canary 渠道启用。请升级至 `next@canary`，并在配置文件中启用 `nodejs` 实验性标志以使用此功能：

next.config.ts

```jsx
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  experimental: {
    nodeMiddleware: true, // 启用 Node.js 中间件
```

6  },

7};



export default nextConfig;
```

您还必须在中间件文件中指定 Node.js 运行时：

middleware.ts

```tsx
import type { NextRequest } from "next/server";



export function middleware(request: NextRequest) {

4  // 您的中间件逻辑在此处

5}



export const config = {

8  runtime: "nodejs", // Specify the runtime environment as Node.js

8  runtime: "nodejs", // 将运行时环境指定为 Node.js

9};
```

[Deploy now](https://vercel.com/templates/next.js/nextjs-boilerplate) with Next.js 15.2.

使用 Next.js 15.2 立即部署：[立即部署](https://vercel.com/templates/next.js/nextjs-boilerplate)