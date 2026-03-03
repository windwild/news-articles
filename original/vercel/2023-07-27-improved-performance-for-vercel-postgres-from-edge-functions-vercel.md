---
title: "Improved performance for Vercel Postgres from Edge Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-performance-for-vercel-postgres-from-edge-functions"
date: "2023-07-27"
scraped_at: "2026-03-02T09:51:34.074504915+00:00"
language: "en"
translated: false
description: "The @vercel/postgres package has been updated to use the latest version of Neon’s Serverless driver which adds support for SQL-over-HTTP"
---




Jul 27, 2023

![](images/improved-performance-for-vercel-postgres-from-edge-functions-vercel/img_001.jpg)![](images/improved-performance-for-vercel-postgres-from-edge-functions-vercel/img_002.jpg)

Update: As of June 9, 2025 Vercel Postgres was replaced with [Vercel Marketplace Storage integrations](https://vercel.com/marketplace/category/storage), featuring automatic account provisioning and unified billing. [Learn more](https://vercel.com/blog/introducing-the-vercel-marketplace).

The [Vercel Postgres SDK](https://vercel.com/docs/storage/vercel-postgres/sdk) has significantly improved performance for Postgres queries from Vercel Edge Functions.

The `@vercel/postgres` package has been updated to use the latest version of Neon’s Serverless driver which adds support for SQL-over-HTTP when you use the [`sql` template literal tag](https://vercel.com/docs/storage/vercel-postgres/sdk#sql). Simple queries that do not require transactions now complete in **~10ms**—up to **a 40% speed increase**.

You do not need to make any changes to your queries to see these improvements, you only need to update to [the latest version of `@vercel/postgres`](https://www.npmjs.com/package/@vercel/postgres/v/0.4.0) to take advantage of these improvements.