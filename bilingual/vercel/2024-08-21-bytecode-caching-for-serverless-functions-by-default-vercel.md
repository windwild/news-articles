---
title: "Bytecode caching for Serverless Functions by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bytecode-caching-for-serverless-functions-by-default"
date: "2024-08-21"
scraped_at: "2026-03-02T09:41:48.864915271+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Aug 21, 2024

2024 年 8 月 21 日

![](images/bytecode-caching-for-serverless-functions-by-default-vercel/img_001.jpg)![](images/bytecode-caching-for-serverless-functions-by-default-vercel/img_002.jpg)

We recently [introduced bytecode caching](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions)—an experimental feature built on our new Rust-based core for Vercel Functions—designed to drastically reduce start times during [increasingly rare](https://vercel.com/changelog/vercel-functions-now-have-faster-and-fewer-cold-starts) cold starts. Even when cold starts do occur, their impact is now minimal and barely noticeable.

我们近期[推出了字节码缓存（bytecode caching）](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions)——这是一项基于 Vercel Functions 全新 Rust 构建核心的实验性功能，旨在大幅缩短[日益罕见的](https://vercel.com/changelog/vercel-functions-now-have-faster-and-fewer-cold-starts)冷启动（cold start）过程中的启动时间。即便发生冷启动，其影响如今也已微乎其微，几乎无法察觉。

After validating the stability and performance improvements of bytecode caching, the feature is now **stable and the default** for all [Node.js 20+ Vercel Functions](https://vercel.com/docs/functions/runtimes/node-js#using-the-node.js-runtime-with-serverless-functions).

在充分验证字节码缓存的稳定性与性能提升效果后，该功能现已**正式稳定，并成为所有 [Node.js 20+ Vercel Functions](https://vercel.com/docs/functions/runtimes/node-js#using-the-node.js-runtime-with-serverless-functions) 的默认配置**。

This change **reduces global cold start times by up to 60%,** exceeding our initial benchmarks and observations. The improvement is particularly significant for functions that load a large amount of JavaScript, with smaller functions experiencing less impact.

此项变更可将**全球范围内的冷启动耗时最多降低 60%**，远超我们最初的基准测试与实际观测结果。对于加载大量 JavaScript 代码的函数，性能提升尤为显著；而小型函数所受的改善则相对有限。

Bytecode caching is automatically enabled for all functions running on [Node.js 20 and using CommonJS](https://vercel.com/docs/functions/runtimes/node-js#bytecode-caching) (e.g., Next.js). Additionally, we're working to extend this support to include ESM for broader compatibility. Learn more in [our blog post](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions).

所有运行于 [Node.js 20 且采用 CommonJS 模块系统](https://vercel.com/docs/functions/runtimes/node-js#bytecode-caching)（例如 Next.js）的函数，均会**自动启用字节码缓存**。此外，我们正在积极拓展对该功能的支持，以兼容 ES 模块（ESM），从而实现更广泛的适用性。详情请参阅[我们的博客文章](https://vercel.com/blog/introducing-bytecode-caching-for-vercel-functions)。