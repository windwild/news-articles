---
title: "Integrate Remix session storage with your Vercel KV database - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/integrate-remix-session-storage-with-your-vercel-kv-database"
date: "2023-05-22"
scraped_at: "2026-03-02T09:52:31.970750341+00:00"
language: "en-zh"
translated: true
description: "Introducing createKvSessionStorage function within @vercel/remix which allows remix session storage with Vercel KV database0"
---
{% raw %}

May 22, 2023

2023年5月22日

![](images/integrate-remix-session-storage-with-your-vercel-kv-database-vercel/img_001.jpg)![](images/integrate-remix-session-storage-with-your-vercel-kv-database-vercel/img_002.jpg)

The Vercel KV product has been sunset. You can now deploy alternative KV stores and other storage solutions through the [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage?category=storage&search=redis), with automatic account provisioning and unified billing. [Learn more](https://vercel.com/blog/introducing-the-vercel-marketplace).

Vercel KV 产品已停止服务。您现在可通过 [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage?category=storage&search=redis) 部署替代的键值（KV）存储及其他存储解决方案，享受自动账户开通与统一账单管理功能。[了解详情](https://vercel.com/blog/introducing-the-vercel-marketplace)。

The release of `@vercel/remix` v1.16.0 introduces a new function, `createKvSessionStorage()`, which allows you to integrate your [Remix](https://vercel.com/templates/remix/remix-boilerplate) session storage with your Vercel KV database in a few lines of code.

`@vercel/remix` v1.16.0 版本新增了一个函数 `createKvSessionStorage()`，仅需数行代码，即可将您的 [Remix](https://vercel.com/templates/remix/remix-boilerplate) 应用会话存储与 Vercel KV 数据库集成。

Upgrade to `@vercel/remix` v1.16.0 to get started.

请升级至 `@vercel/remix` v1.16.0 版本以开始使用。

[Check out the documentation](https://vercel.com/docs/storage/vercel-kv) to learn more about storage with Vercel KV.

[查阅文档](https://vercel.com/docs/storage/vercel-kv)，深入了解 Vercel KV 的存储功能。
{% endraw %}
