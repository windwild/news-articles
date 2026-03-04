---
title: "Introducing Vercel KV - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-kv"
date: "2023-05-01"
scraped_at: "2026-03-02T09:53:11.571074880+00:00"
language: "en-zh"
translated: true
description: "Announcing Redis storage on Vercel. Connect your projects to native storage solutions. Works with any frontend framework."
---
&#123;% raw %}

May 1, 2023

2023 年 5 月 1 日

![](images/introducing-vercel-kv-vercel/img_001.jpg)![](images/introducing-vercel-kv-vercel/img_002.jpg)

The Vercel KV product has been sunset. You can now deploy alternative KV stores and other storage solutions through the [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage?category=storage&search=redis), with automatic account provisioning and unified billing. [Learn more](https://vercel.com/blog/introducing-the-vercel-marketplace).

Vercel KV 产品已停止服务。您现在可通过 [Vercel Marketplace 存储分类](https://vercel.com/marketplace/category/storage?category=storage&search=redis) 部署替代的键值存储（KV）及其他存储解决方案，享受自动账户开通与统一账单管理功能。[了解详情](https://vercel.com/blog/introducing-the-vercel-marketplace)。

[Vercel KV](https://vercel.com/storage/kv) is a serverless, durable Redis database, making it easy to implement features like rate limiting, session management, and also manage application state.

[Vercel KV](https://vercel.com/storage/kv) 是一款无服务器、高持久性的 Redis 数据库，可轻松实现限流（rate limiting）、会话管理（session management），以及应用状态管理等功能。

The Redis-compatible SDK works from Edge or Serverless Functions and scales with your traffic. KV stores are single [region](https://vercel.com/docs/storage/vercel-kv/limits#vercel-kv-region-list) by default, but can be replicated to multiple regions for distributed workloads.

该 Redis 兼容 SDK 可在边缘函数（Edge Functions）或无服务器函数（Serverless Functions）中运行，并随您的流量自动弹性伸缩。KV 存储默认部署于单一[区域](https://vercel.com/docs/storage/vercel-kv/limits#vercel-kv-region-list)，但也可复制到多个区域，以支持分布式工作负载。

user-prefs.ts

`user-prefs.ts`

```tsx
import kv from '@vercel/kv';



export async function getPrefs() {

4  const prefs = await kv.get('prefs');
```

```tsx
import kv from '@vercel/kv';

export async function getPrefs() {
  const prefs = await kv.get('prefs');
}
```

```markdown
5  return prefs || {};

6}



export async function updatePrefs(prefs: Record<string, string>) {

9 return kv.set('prefs', prefs);

10}
```

Vercel KV is available for Hobby and Pro users during the public beta.

Vercel KV 在公开测试期间面向 Hobby 和 Pro 用户开放。

[Check out our documentation](https://vercel.com/docs/redis) to learn more.

[查看我们的文档](https://vercel.com/docs/redis) 以了解更多信息。
```
&#123;% endraw %}
