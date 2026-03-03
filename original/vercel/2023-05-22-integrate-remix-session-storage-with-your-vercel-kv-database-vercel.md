---
title: "Integrate Remix session storage with your Vercel KV database - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/integrate-remix-session-storage-with-your-vercel-kv-database"
date: "2023-05-22"
scraped_at: "2026-03-02T09:52:31.970750341+00:00"
language: "en"
translated: false
description: "Introducing createKvSessionStorage function within @vercel/remix which allows remix session storage with Vercel KV database0"
---




May 22, 2023

![](images/integrate-remix-session-storage-with-your-vercel-kv-database-vercel/img_001.jpg)![](images/integrate-remix-session-storage-with-your-vercel-kv-database-vercel/img_002.jpg)

The Vercel KV product has been sunset. You can now deploy alternative KV stores and other storage solutions through the [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage?category=storage&search=redis), with automatic account provisioning and unified billing. [Learn more](https://vercel.com/blog/introducing-the-vercel-marketplace).

The release of `@vercel/remix` v1.16.0 introduces a new function, `createKvSessionStorage()`, which allows you to integrate your [Remix](https://vercel.com/templates/remix/remix-boilerplate) session storage with your Vercel KV database in a few lines of code.

Upgrade to `@vercel/remix` v1.16.0 to get started.

[Check out the documentation](https://vercel.com/docs/storage/vercel-kv) to learn more about storage with Vercel KV.