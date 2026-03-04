---
render_with_liquid: false
title: "Improved performance for Vercel Postgres from Edge Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-performance-for-vercel-postgres-from-edge-functions"
date: "2023-07-27"
scraped_at: "2026-03-02T09:51:34.074504915+00:00"
language: "en-zh"
translated: true
description: "The @vercel/postgres package has been updated to use the latest version of Neon’s Serverless driver which adds support for SQL-over-HTTP"
---
render_with_liquid: false
render_with_liquid: false

Jul 27, 2023

2023年7月27日

![](images/improved-performance-for-vercel-postgres-from-edge-functions-vercel/img_001.jpg)![](images/improved-performance-for-vercel-postgres-from-edge-functions-vercel/img_002.jpg)

Update: As of June 9, 2025 Vercel Postgres was replaced with [Vercel Marketplace Storage integrations](https://vercel.com/marketplace/category/storage), featuring automatic account provisioning and unified billing. [Learn more](https://vercel.com/blog/introducing-the-vercel-marketplace).

更新：自2025年6月9日起，Vercel Postgres 已被 [Vercel Marketplace 存储集成](https://vercel.com/marketplace/category/storage) 取代，新方案支持自动账户开通与统一账单管理。[了解详情](https://vercel.com/blog/introducing-the-vercel-marketplace)。

The [Vercel Postgres SDK](https://vercel.com/docs/storage/vercel-postgres/sdk) has significantly improved performance for Postgres queries from Vercel Edge Functions.

[Vercel Postgres SDK](https://vercel.com/docs/storage/vercel-postgres/sdk) 大幅提升了从 Vercel Edge Functions 发起的 PostgreSQL 查询性能。

The `@vercel/postgres` package has been updated to use the latest version of Neon’s Serverless driver which adds support for SQL-over-HTTP when you use the [`sql` template literal tag](https://vercel.com/docs/storage/vercel-postgres/sdk#sql). Simple queries that do not require transactions now complete in **~10ms**—up to **a 40% speed increase**.

`@vercel/postgres` 包已升级至 Neon 最新版本的无服务器驱动（Serverless driver），当您使用 [`sql` 模板字面量标签](https://vercel.com/docs/storage/vercel-postgres/sdk#sql) 时，该驱动新增了对 SQL-over-HTTP 协议的支持。无需事务的简单查询现在仅需 **约 10 毫秒** 即可完成——性能最高提升 **40%**。

You do not need to make any changes to your queries to see these improvements, you only need to update to [the latest version of `@vercel/postgres`](https://www.npmjs.com/package/@vercel/postgres/v/0.4.0) to take advantage of these improvements.

您无需修改现有查询代码即可享受上述性能提升；只需将依赖升级至 [`@vercel/postgres`](https://www.npmjs.com/package/@vercel/postgres/v/0.4.0) 的最新版本，即可启用这些优化。