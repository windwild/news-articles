---
title: "What is Edge Runtime | Edge Runtime"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-edge-runtime"
date: "2022-06-21"
scraped_at: "2026-03-02T10:01:36.813027575+00:00"
language: "en-zh"
translated: true
description: "The Edge Runtime is a toolkit for developing, testing, and defining the runtime Web APIs for Edge infrastructure."
---

render_with_liquid: false
Introduction

简介

# The Edge Runtime

# 边缘运行时（Edge Runtime）

The Edge Runtime is designed to help framework authors adopt edge computing and provide open-source tooling built on Web standards. It’s designed to be integrated into frameworks (like Next.js) and not for usage in application code.

边缘运行时旨在帮助框架作者采用边缘计算，并提供基于 Web 标准的开源工具。它专为集成到各类框架（例如 Next.js）中而设计，**不适用于应用程序代码中直接使用**。

The Edge Runtime is a subset of Node.js APIs, giving you compatibility and interoperability between multiple web environments. The project is designed to be compliant with standards developed by [WinterCG (opens in a new tab)](https://wintercg.org/) \- a community group between Vercel, Cloudflare, Deno, Shopify, and more. The term “Edge” refers to the orientation toward instant serverless compute environments and not a specific set of locations.

边缘运行时是 Node.js API 的一个子集，可确保你在多种 Web 环境之间获得兼容性与互操作性。本项目遵循由 [WinterCG（在新标签页中打开）](https://wintercg.org/) 制定的标准——这是一个由 Vercel、Cloudflare、Deno、Shopify 等公司共同参与的社区组织。“边缘（Edge）”一词强调的是面向即时无服务器计算环境的架构取向，而非特指某类物理地理位置。

Web APIs

Web API 支持

Context isolation

上下文隔离

Easy to extend

易于扩展

Lightweight

轻量级

Written in TypeScript

使用 TypeScript 编写

Node.js v16 or higher

需 Node.js v16 或更高版本

## Using the Edge Runtime Locally [Permalink for this section](https://edge-runtime.vercel.app/\#using-the-edge-runtime-locally)

## 在本地使用 Edge Runtime [本节永久链接](https://edge-runtime.vercel.app/\#using-the-edge-runtime-locally)

When developing and testing locally, the Edge Runtime will polyfill Web APIs and ensure compatibility with the Node.js layer.

在本地开发和测试时，Edge Runtime 会为 Web API 提供 polyfill，并确保与 Node.js 层的兼容性。

In production, the Edge Runtime uses the [JavaScript V8 engine (opens in a new tab)](https://v8.dev/), **not** Node.js, so there is **no access** to Node.js APIs.

在生产环境中，Edge Runtime 使用的是 [JavaScript V8 引擎（在新标签页中打开）](https://v8.dev/)，**而非** Node.js，因此**无法访问** Node.js 的 API。

Get started using Edge Runtime:

开始使用 Edge Runtime：

- [Explore the available APIs](https://edge-runtime.vercel.app/features/available-apis)  
- [探索可用的 API](https://edge-runtime.vercel.app/features/available-apis)
- [Integrate it in your project](https://edge-runtime.vercel.app/packages/runtime)  
- [在您的项目中集成它](https://edge-runtime.vercel.app/packages/runtime)
- [Test your code with Jest](https://edge-runtime.vercel.app/packages/jest-environment) or [Vitest (opens in a new tab)](https://vitest.dev/config/#environment)  
- [使用 Jest 测试您的代码](https://edge-runtime.vercel.app/packages/jest-environment) 或 [Vitest（在新标签页中打开）](https://vitest.dev/config/#environment)

[Getting Started](https://edge-runtime.vercel.app/getting-started "Getting Started")  
[入门指南](https://edge-runtime.vercel.app/getting-started "入门指南")