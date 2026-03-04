---
title: "Vercel Observability is now route-aware for SvelteKit apps - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-observability-is-now-route-aware-for-sveltekit-apps"
date: "2025-04-14"
scraped_at: "2026-03-02T09:34:43.439993379+00:00"
language: "en-zh"
translated: true
description: "Improved route-level visibility to Vercel Observability for SvelteKit projects using @sveltejs/adapter-vercel v5.7.0. Dynamic segments like /blog/[slug] now appear as individual routes."
---

render_with_liquid: false
Apr 14, 2025

2025年4月14日

![](images/vercel-observability-is-now-route-aware-for-sveltekit-apps-vercel/img_001.jpg)![](images/vercel-observability-is-now-route-aware-for-sveltekit-apps-vercel/img_002.jpg)

SvelteKit routes with dynamic segments—like `/blog/[slug]`—are now individually recognized and surfaced by Vercel Observability. This replaces the previous behavior where all dynamic routes appeared under a single `/fn` entry.

SvelteKit 中带有动态片段的路由（例如 `/blog/[slug]`）现已由 Vercel Observability 单独识别并分别展示。此前，所有动态路由均统一归类在单一的 `/fn` 条目下，此更新已取代该旧有行为。

This is available with version 5.7.0 of `@sveltejs/adapter-vercel`. Upgrade to unlock improved observability for your SvelteKit projects.

该功能随 `@sveltejs/adapter-vercel` 版本 5.7.0 起正式提供。请升级以解锁 SvelteKit 项目的增强可观测性能力。

If you're using the Vercel adapter via `@sveltejs/adapter-auto`, we recommend switching to using `@sveltejs/adapter-vercel` directly.

若您正通过 `@sveltejs/adapter-auto` 使用 Vercel 适配器，我们建议您直接切换为使用 `@sveltejs/adapter-vercel`。

Learn more about [Vercel Observability](https://vercel.com/docs/observability).

了解更多关于 [Vercel Observability](https://vercel.com/docs/observability) 的信息。