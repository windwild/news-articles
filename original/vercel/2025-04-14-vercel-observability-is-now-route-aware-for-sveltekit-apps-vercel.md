---
title: "Vercel Observability is now route-aware for SvelteKit apps - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-observability-is-now-route-aware-for-sveltekit-apps"
date: "2025-04-14"
scraped_at: "2026-03-02T09:34:43.439993379+00:00"
language: "en"
translated: false
description: "Improved route-level visibility to Vercel Observability for SvelteKit projects using @sveltejs/adapter-vercel v5.7.0. Dynamic segments like /blog/[slug] now appear as individual routes."
---




Apr 14, 2025

![](images/vercel-observability-is-now-route-aware-for-sveltekit-apps-vercel/img_001.jpg)![](images/vercel-observability-is-now-route-aware-for-sveltekit-apps-vercel/img_002.jpg)

SvelteKit routes with dynamic segments—like `/blog/[slug]`—are now individually recognized and surfaced by Vercel Observability. This replaces the previous behavior where all dynamic routes appeared under a single `/fn` entry.

This is available with version 5.7.0 of `@sveltejs/adapter-vercel`. Upgrade to unlock improved observability for your SvelteKit projects.

If you're using the Vercel adapter via `@sveltejs/adapter-auto`, we recommend switching to using `@sveltejs/adapter-vercel` directly.

Learn more about [Vercel Observability](https://vercel.com/docs/observability).