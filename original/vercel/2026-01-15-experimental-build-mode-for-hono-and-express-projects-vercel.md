---
title: "Experimental build mode for Hono and Express projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/experimental-build-mode-hono-express"
date: "2026-01-15"
scraped_at: "2026-03-02T09:22:37.100704557+00:00"
language: "en"
translated: false
description: "Users can opt-in to an experimental build mode for backend frameworks like Hono or Express. The new behavior allows logs to be filtered by route, similar to Next.js and other frameworks. It also impro..."
---




Jan 15, 2026

Users can opt in to an experimental build mode for [Hono](https://vercel.com/docs/frameworks/backend/hono) and [Express](https://vercel.com/docs/frameworks/backend/express) projects, which lets you filter logs by route, similar to Next.js.

It also updates the build pipeline with better module resolution:

- Relative imports no longer require file extensions

- TypeScript path aliases are supported

- Improved ESM and CommonJS interoperability


To enable it, set `VERCEL_EXPERIMENTAL_BACKENDS=1` in your project's [environment variables](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fenvironment-variables&title=Open+environment+variables).