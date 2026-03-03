---
title: "Flags SDK 3.2 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/flags-sdk-3-2"
date: "2025-03-31"
scraped_at: "2026-03-02T09:35:14.354056061+00:00"
language: "en-zh"
translated: true
description: "Flags SDK 3.2 now supports precomputing pattern in SvelteKit, making it possible to use feature flags on static pages without causing layout shift or jank."
---

Mar 31, 2025

2025年3月31日

![](images/flags-sdk-3_2-vercel/img_001.jpg)![](images/flags-sdk-3_2-vercel/img_002.jpg)

[Flags SDK](https://flags-sdk.dev/) 3.2 版本新增了对 [SvelteKit](https://svelte.dev/docs/kit) 中 [预计算功能标志（precomputed feature flags）](https://flags-sdk.dev/frameworks/sveltekit/precompute) 的支持，使营销页面的 A/B 测试更轻松，同时保障页面加载速度并避免布局偏移（layout shift）。

![边缘中间件（Edge Middleware）决定展示页面的哪个变体](images/flags-sdk-3_2-vercel/img_003.jpg)![边缘中间件（Edge Middleware）决定展示页面的哪个变体](images/flags-sdk-3_2-vercel/img_004.jpg)边缘中间件（Edge Middleware）决定展示页面的哪个变体

预计算标志在边缘中间件中完成求值，从而决定向用户呈现页面的哪一个变体。这使得页面保持静态化，静态变体可通过边缘网络（Edge Network）分发，从而实现全球范围内的低延迟响应。

预计算机制可有效应对多个功能标志静态组合时产生的“组合爆炸”问题：可在构建时生成页面的不同变体；也可借助 [增量静态再生（Incremental Static Regeneration）](https://vercel.com/docs/incremental-static-regeneration) 技术，按需仅构建特定的组合变体；此外还支持更多高级用法。

我们还全面优化了 [Flags SDK 文档](https://flags-sdk.dev/docs)，按不同前端框架进行结构化拆分，并明确列出所有已为 Flags SDK 提供适配器（adapter）的第三方服务提供商。

深入了解 [Flags SDK 与 SvelteKit 的集成](https://flags-sdk.dev/frameworks/sveltekit) 以及 [预计算模式（precompute pattern）](https://flags-sdk.dev/principles/precompute)。