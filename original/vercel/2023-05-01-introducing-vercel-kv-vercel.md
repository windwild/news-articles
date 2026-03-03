---
title: "Introducing Vercel KV - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-kv"
date: "2023-05-01"
scraped_at: "2026-03-02T09:53:11.571074880+00:00"
language: "en"
translated: false
description: "Announcing Redis storage on Vercel. Connect your projects to native storage solutions. Works with any frontend framework."
---




May 1, 2023

![](images/introducing-vercel-kv-vercel/img_001.jpg)![](images/introducing-vercel-kv-vercel/img_002.jpg)

The Vercel KV product has been sunset. You can now deploy alternative KV stores and other storage solutions through the [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage?category=storage&search=redis), with automatic account provisioning and unified billing. [Learn more](https://vercel.com/blog/introducing-the-vercel-marketplace).

[Vercel KV](https://vercel.com/storage/kv) is a serverless, durable Redis database, making it easy to implement features like rate limiting, session management, and also manage application state.

The Redis-compatible SDK works from Edge or Serverless Functions and scales with your traffic. KV stores are single [region](https://vercel.com/docs/storage/vercel-kv/limits#vercel-kv-region-list) by default, but can be replicated to multiple regions for distributed workloads.

user-prefs.ts

```tsx
import kv from '@vercel/kv';



export async function getPrefs() {

4  const prefs = await kv.get('prefs');

5  return prefs || {};

6}



export async function updatePrefs(prefs: Record<string, string>) {

9 return kv.set('prefs', prefs);

10}
```

Vercel KV is available for Hobby and Pro users during the public beta.

[Check out our documentation](https://vercel.com/docs/redis) to learn more.