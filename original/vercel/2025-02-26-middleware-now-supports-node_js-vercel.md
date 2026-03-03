---
title: "Middleware now supports Node.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/middleware-now-supports-node-js"
date: "2025-02-26"
scraped_at: "2026-03-02T09:35:51.113889216+00:00"
language: "en"
translated: false
description: "Next.js 15.2 introduces experimental Node.js Middleware, now available at Vercel—giving you full Node.js runtime support for your Middleware. Run authentication, logging, request handling, and more ..."
---




Feb 26, 2025

Middleware support for the Node.js runtime is now available, providing full Node.js support for authentication, personalization, and more—using familiar APIs.

Middleware continues to be deployed globally on Vercel, regardless of the runtime used. We are first releasing support for Node.js Middleware in [Next.js 15.2](https://nextjs.org/blog/next-15-2).

This experimental feature requires the Next.js canary channel. Upgrade to `next@canary` and enable the `nodejs` experimental flag in your config to use it:

next.config.ts

```jsx
import type { NextConfig } from "next";



const nextConfig: NextConfig = {

4  experimental: {

5    nodeMiddleware: true, // Enable Node.js middleware

6  },

7};



export default nextConfig;
```

You must also specify the Node.js runtime in your middleware file:

middleware.ts

```tsx
import type { NextRequest } from "next/server";



export function middleware(request: NextRequest) {

4  // Your middleware logic here

5}



export const config = {

8  runtime: "nodejs", // Specify the runtime environment as Node.js

9};
```

[Deploy now](https://vercel.com/templates/next.js/nextjs-boilerplate) with Next.js 15.2.