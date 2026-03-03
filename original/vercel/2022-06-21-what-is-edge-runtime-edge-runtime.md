---
title: "What is Edge Runtime | Edge Runtime"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-edge-runtime"
date: "2022-06-21"
scraped_at: "2026-03-02T10:01:36.813027575+00:00"
language: "en"
translated: false
description: "The Edge Runtime is a toolkit for developing, testing, and defining the runtime Web APIs for Edge infrastructure."
---

Introduction

# The Edge Runtime

The Edge Runtime is designed to help framework authors adopt edge computing and provide open-source tooling built on Web standards. It’s designed to be integrated into frameworks (like Next.js) and not for usage in application code.

The Edge Runtime is a subset of Node.js APIs, giving you compatibility and interoperability between multiple web environments. The project is designed to be compliant with standards developed by [WinterCG (opens in a new tab)](https://wintercg.org/) \- a community group between Vercel, Cloudflare, Deno, Shopify, and more. The term “Edge” refers to the orientation toward instant serverless compute environments and not a specific set of locations.

Web APIs

Context isolation

Easy to extend

Lightweight

Written in TypeScript

Node.js v16 or higher

## Using the Edge Runtime Locally [Permalink for this section](https://edge-runtime.vercel.app/\#using-the-edge-runtime-locally)

When developing and testing locally, the Edge Runtime will polyfill Web APIs and ensure compatibility with the Node.js layer.

In production, the Edge Runtime uses the [JavaScript V8 engine (opens in a new tab)](https://v8.dev/), **not** Node.js, so there is **no access** to Node.js APIs.

Get started using Edge Runtime:

- [Explore the available APIs](https://edge-runtime.vercel.app/features/available-apis)
- [Integrate it in your project](https://edge-runtime.vercel.app/packages/runtime)
- [Test your code with Jest](https://edge-runtime.vercel.app/packages/jest-environment) or [Vitest (opens in a new tab)](https://vitest.dev/config/#environment)

[Getting Started](https://edge-runtime.vercel.app/getting-started "Getting Started")