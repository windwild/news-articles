---
title: "Flags SDK 3.2 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/flags-sdk-3-2"
date: "2025-03-31"
scraped_at: "2026-03-02T09:35:14.354056061+00:00"
language: "en"
translated: false
description: "Flags SDK 3.2 now supports precomputing pattern in SvelteKit, making it possible to use feature flags on static pages without causing layout shift or jank."
---




Mar 31, 2025

![](images/flags-sdk-3_2-vercel/img_001.jpg)![](images/flags-sdk-3_2-vercel/img_002.jpg)

The [Flags SDK](https://flags-sdk.dev/) 3.2 release adds support for [precomputed feature flags](https://flags-sdk.dev/frameworks/sveltekit/precompute) in [SvelteKit](https://svelte.dev/docs/kit), making it easier to experiment on marketing pages while keeping them fast and avoiding layout shift.

![Edge Middleware decides which variant of a page to show](images/flags-sdk-3_2-vercel/img_003.jpg)![Edge Middleware decides which variant of a page to show](images/flags-sdk-3_2-vercel/img_004.jpg)Edge Middleware decides which variant of a page to show

Precomputed flags evaluate in Edge Middleware to decide which variant of a page to show. This keeps pages static, resulting in low global latency as static variants can be served through the Edge Network.

Precompute handles the combinatory explosion when using multiple feature flags statically. Generate different variants of a page at build time, rely on [Incremental Static Regeneration](https://vercel.com/docs/incremental-static-regeneration) to only build a specific combinations on demand, and more.

We also improved the [Flags SDK documentation](https://flags-sdk.dev/docs) by splitting it across different frameworks and explicitly listing all providers that have adapters for the Flags SDK.

Learn more about the [Flags SDK with SvelteKit](https://flags-sdk.dev/frameworks/sveltekit) and the [precompute pattern](https://flags-sdk.dev/principles/precompute).