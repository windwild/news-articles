---
title: "Introducing the Vercel Data Cache: Optimized caching for React Server Components - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-vercel-data-cache"
date: "2023-05-04"
scraped_at: "2026-03-02T09:52:50.412611216+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 4, 2023

![](images/introducing-the-vercel-data-cache-optimized-caching-for-react-server-components-/img_001.jpg)![](images/introducing-the-vercel-data-cache-optimized-caching-for-react-server-components-/img_002.jpg)

Vercel Data Cache is now available to give you framework-defined caching and propagation infrastructure to handle responses from [React Server Components](https://nextjs.org/docs/getting-started/react-essentials#server-components).

Data Cache is a globally distributed, ephemeral cache accessible from both serverless and edge runtimes, allowing you to cache data granularly in the region in which your function executes, with different treatments depending on the type of response:

- Dynamic data is re-fetched with every execution

- Static data is cached and revalidated either by time-based or on-demand revalidation


This feature is currently supported for the [Next.js App Router](https://nextjs.org/docs/getting-started/installation) and is available for users on [all plans](https://vercel.com/docs/infrastructure/data-cache/limits-and-pricing).

[Check out our documentation](https://vercel.com/docs/infrastructure/data-cache) and [usage limits](https://vercel.com/docs/infrastructure/data-cache/limits-and-pricing) to learn more.