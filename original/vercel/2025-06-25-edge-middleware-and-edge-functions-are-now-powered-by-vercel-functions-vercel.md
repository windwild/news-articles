---
title: "Edge Middleware and Edge Functions are now powered by Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/edge-middleware-and-edge-functions-are-now-powered-by-vercel-functions"
date: "2025-06-25"
scraped_at: "2026-03-02T09:32:09.911773741+00:00"
language: "en"
translated: false
description: "The Edge runtime now runs on Vercel Functions, unifying pricing across all compute, and available before and after cache. Edge Middleware and Edge Functions are now deprecated."
---




Jun 25, 2025

Functions using the Edge runtime now run on the unified Vercel Functions infrastructure.

This applies to both before and after the cache:

- Edge Middleware is now Vercel Routing Middleware, a new infrastructure primitive that runs full Vercel Functions with [Fluid compute](https://vercel.com/fluid) before the cache

- Edge Functions are now Vercel Functions using the Edge Runtime after the cache


Edge Middleware and Edge Functions are deprecated. They have been replaced by Vercel Routing Middleware and Vercel Functions, respectively. Both support the Edge runtime, Node.js, and more.

With these changes, all functions including those running the Edge runtime are:

- **Fluid compute-ready**: Runs on [Fluid compute](https://vercel.com/docs/functions/fluid-compute) for better performance and cost efficiency

- **Multi-runtime**: Supports Node.js and Edge runtimes

- **Framework-driven**: Deployed automatically from supported framework code

- **Consistent pricing**: Uses unified Vercel Functions pricing [based on Active CPU time](https://vercel.com/changelog/lower-pricing-with-active-cpu-pricing-for-fluid-compute) across all compute types


Vercel Routing Middleware is now generally available to all users.

Learn more about [Routing Middleware](https://vercel.com/docs/routing-middleware).