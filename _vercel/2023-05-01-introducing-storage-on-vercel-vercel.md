---
title: "Introducing storage on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-storage"
date: "2023-05-01"
scraped_at: "2026-03-02T09:52:58.480867689+00:00"
language: "en-zh"
translated: true
description: "New to the Vercel dashboard: Vercel KV, Vercel Postgres, and Vercel Blob. Announcing serverless storage solutions available on Vercel."
---

May 1, 2023

2023 年 5 月 1 日

Vercel KV、Vercel Postgres、Vercel Blob 和 Vercel Edge Config 现已正式上线。

Data is an integral part of the web. As JavaScript and TypeScript frameworks make it easier than ever to server-render just-in-time data, it's time to make databases a first-class part of Vercel's frontend cloud.

数据是 Web 不可或缺的组成部分。随着 JavaScript 和 TypeScript 框架让“按需服务端渲染（just-in-time server rendering）”变得前所未有的简单，现在正是将数据库作为 Vercel 前端云的一等公民加以支持的时刻。

The Vercel KV and Vercel Postgres products have been sunset. You can now deploy alternative storage solutions for [KV](https://vercel.com/marketplace?search=kv) and [Postgres](https://vercel.com/marketplace?search=postgres) through the [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage), with automatic account provisioning and unified billing.

Vercel KV 和 Vercel Postgres 产品现已停止维护（sunset）。您现在可通过 [Vercel Marketplace 存储分类页](https://vercel.com/marketplace/category/storage) 部署其他 KV 和 Postgres 存储方案（[KV 方案](https://vercel.com/marketplace?search=kv)、[Postgres 方案](https://vercel.com/marketplace?search=postgres)），享受自动账户开通与统一账单管理。

Today, we’re excited to announce a suite of serverless [storage](https://vercel.com/storage) solutions now available on Vercel, powered by some of the best infrastructure providers in the industry.

今天，我们很高兴地宣布：一套由业内顶尖基础设施提供商赋能的无服务器 [存储](https://vercel.com/storage) 解决方案，现已在 Vercel 平台全面上线。

- [Vercel KV](https://vercel.com/blog/vercel-storage#vercel-kv-a-durable-redis-database): A serverless Redis solution that's easy and durable, powered by Upstash  
- [Vercel KV](https://vercel.com/blog/vercel-storage#vercel-kv-a-durable-redis-database)：一款易用且高可靠的无服务器 Redis 解决方案，由 Upstash 提供技术支持  

- [Vercel Postgres](https://vercel.com/blog/vercel-storage#vercel-postgres-complex-data-made-easy): A serverless SQL database built for the frontend, powered by Neon  
- [Vercel Postgres](https://vercel.com/blog/vercel-storage#vercel-postgres-complex-data-made-easy)：一款专为前端打造的无服务器 SQL 数据库，由 Neon 提供技术支持  

- [Vercel Blob](https://vercel.com/blog/vercel-storage#vercel-blob-easy-file-storage-at-the-edge): A solution to upload and serve files at the edge  
- [Vercel Blob](https://vercel.com/blog/vercel-storage#vercel-blob-easy-file-storage-at-the-edge)：一种可在边缘节点上传与分发文件的解决方案  

![](images/introducing-storage-on-vercel-vercel/img_001.jpg)![](images/introducing-storage-on-vercel-vercel/img_002.jpg)

### Why now?

### 为何此时推出？

Driven by the need for both performance and personalization, frameworks are becoming server-first and edge-first. This shift is exemplified by React Server Components and the introduction of streaming infrastructure into our runtimes. These capabilities make it easier than ever to fetch data from a database or other data sources, within the server component itself.

在性能与个性化需求的共同驱动下，框架正日益转向以服务器为先、以边缘为先的设计范式。React Server Components（React 服务端组件）的兴起，以及流式处理（streaming）基础设施被逐步集成至我们的运行时环境，正是这一转变的典型体现。这些能力前所未有地简化了在服务端组件内部直接从数据库或其他数据源获取数据的过程。

Simultaneously, as the world moves away from monolithic architectures to composable ones, there's [no shortage of options](https://vercel.com/integrations#databases) for backends and databases. But for new projects, the choice can still be paralyzing.

与此同时，随着业界整体从单体架构转向可组合架构，后端与数据库的可选方案可谓层出不穷——[可供选择的集成方案数量庞大](https://vercel.com/integrations#databases)。但对于新项目而言，面对如此丰富的选项，开发者仍可能陷入“选择困难”。

In the spirit of being the end-to-end solution for building on the web, we are introducing solutions that are open, easy to use, and scale as efficiently as our frontends.

秉承打造面向 Web 开发的端到端解决方案之初心，我们现推出一系列开源、易用、且能像前端一样高效伸缩的新工具与服务。

## Vercel KV: A durable Redis database

## Vercel KV：一款高持久性的 Redis 兼容数据库

A key-value store like Redis is one of the most common tools developers reach for when managing things like rate-limiting, session management, or application state.

键值存储（如 Redis）是开发者在实现限流（rate-limiting）、会话管理（session management）或应用状态维护等场景时最常选用的工具之一。

Today, we're introducing Vercel KV, a serverless, Redis-compatible, easy-to-use, and highly _durable_ database. Vercel KV enables you to create Redis-compatible databases that can be written to and read from Vercel's Edge Network in regions you specify, with little configuration needed.

今天，我们正式推出 Vercel KV —— 一款无服务器（serverless）、兼容 Redis 协议、开箱即用、且具备极高**持久性**（durability）的数据库。借助 Vercel KV，您可快速创建兼容 Redis 的数据库，并在您指定的地理区域中，通过 Vercel 边缘网络（Edge Network）对其进行读写操作，几乎无需额外配置。

user-prefs.ts

```tsx
import kv from '@vercel/kv';



export async function getPrefs() {

```markdown
4  const prefs = await kv.get('prefs');

4  const prefs = await kv.get('prefs');

5  return prefs || {};

5  返回 prefs || {};

6}

6}

export async function updatePrefs(prefs: Record<string, string>) {

export async function updatePrefs(prefs: Record<string, string>) {

9 return kv.set('prefs', prefs);

9  return kv.set('prefs', prefs);

10}
```

10}
```

We’ve partnered with [Upstash](https://upstash.com/) to deliver tooling designed to **embrace** serverless, that persists in memory _and_ on disk by default. This means it can be used to persist state, without risk of losing your data when a server crashes.

我们已与 [Upstash](https://upstash.com/) 展开合作，提供专为拥抱无服务器（serverless）架构而设计的工具；该工具默认同时在内存和磁盘中持久化数据。这意味着它可用于持久化应用状态，即使服务器发生崩溃，您的数据也不会丢失。

## Vercel Postgres: Complex data made easy

## Vercel Postgres：让复杂数据处理变得轻松简单

PostgreSQL is the preferred way of handling relational data for many developers. We’ve partnered with [Neon](https://neon.tech/) to introduce Vercel Postgres, the first serverless SQL database built for the frontend cloud.

PostgreSQL 是众多开发者处理关系型数据的首选方案。我们已与 [Neon](https://neon.tech/) 合作推出 Vercel Postgres —— 这是首个专为前端云环境构建的无服务器 SQL 数据库。
```

`app/page.tsx`

`app/page.tsx`

```tsx
import { sql } from '@vercel/postgres';

import { redirect } from 'next/navigation';



async function create(formData: FormData) {

5  'use server';

6  const { rows } = await sql`

7    INSERT INTO products (name)

8    VALUES (${formData.get('name')})

9  `;
```

```tsx
import { sql } from '@vercel/postgres';

import { redirect } from 'next/navigation';



async function create(formData: FormData) {

5  'use server';

6  const { rows } = await sql`

7    INSERT INTO products (name)

8    VALUES (${formData.get('name')})

9  `;
```

10  redirect(`/product/${rows[0].slug}`);

10  重定向至 `/product/${rows[0].slug}`；

11}

11}

export default function Page() {

export default function Page() {

15  return (

15  return (

16    <form action={create}>

16    <form action={create}>

17      <input type="text" name="name" />

17      <input type="text" name="name" />

18      <button type="submit">Submit</button>

18      <button type="submit">提交</button>

19    </form>

19    </form>

20  );

21}
```

使用 Vercel Postgres 与 Next.js 服务端操作（将于周四发布）

With Vercel Postgres, you get a fully managed, highly scalable, fault-tolerant database that delivers high performance and low latency for your web applications.  
借助 Vercel Postgres，您将获得一个完全托管、高度可扩展且具备容错能力的数据库，为您的 Web 应用提供高性能与低延迟。

Vercel Postgres is designed to work seamlessly with the Next.js App Router and Server Components and other frameworks like Nuxt and SvelteKit, making it easy to fetch data from your Postgres database to render dynamic content on the server at the speed of static.  
Vercel Postgres 专为无缝集成 Next.js App Router 和服务端组件（Server Components）而设计，同时也支持 Nuxt 和 SvelteKit 等其他框架，让您能轻松从 Postgres 数据库中获取数据，并以接近静态页面的速度在服务端渲染动态内容。

You can use Vercel Postgres to query, insert, update, or delete data directly inside your React Server Components, providing you with powerful server-first data mutations and less client-side JavaScript.  
您可在 React 服务端组件（React Server Components）中直接使用 Vercel Postgres 执行查询、插入、更新或删除操作，从而实现强大的“服务端优先”数据变更能力，并显著减少客户端 JavaScript 的使用量。

## Vercel Blob: Easy file storage at the edge

## Vercel Blob：边缘端的简易文件存储

Vercel Blob is a fast, easy, and efficient solution for storing files in the cloud. It provides an effortless yet powerful storage API built entirely on top of web standards without the need to configure buckets or implement heavy SDKs.  
Vercel Blob 是一种快速、简单且高效的云文件存储方案。它基于 Web 标准构建，提供轻量易用却功能强大的存储 API，无需配置存储桶（buckets），也无需引入繁重的 SDK。

app/profile/route.ts

```tsx
import { put } from '@vercel/blob';
```

```typescript
export async function PUT(request: Request) {

export async function PUT(request: Request) {

4  const form = await request.formData();

4  const form = await request.formData();

5  const file = form.get('file') as File;

5  const file = form.get('file') as File;

6  const blob = await put('avatars/user-42.png', file, { access: 'public' });

6  const blob = await put('avatars/user-42.png', file, { access: 'public' });

8  return Response.json(blob);

8  return Response.json(blob);

9}
```

9}
```

Vercel Blob can store files like images, PDFs, CSVs, or other unstructured data. Use Vercel Blob for:

Vercel Blob 可用于存储图像、PDF、CSV 或其他非结构化数据文件。建议在以下场景中使用 Vercel Blob：

- Files you normally store in an external file storage solution like Amazon S3. With your project hosted on Vercel, you can readily access and manage these files via Vercel Blob

- 通常存放在外部文件存储服务（例如 Amazon S3）中的文件。当您的项目部署在 Vercel 上时，可直接通过 Vercel Blob 访问和管理这些文件。

- Files that are programmatically uploaded or generated at build time, for display and download such as avatars, screenshots, cover images and videos

- 在运行时通过程序上传、或在构建时自动生成的文件，用于展示或下载，例如头像、截图、封面图和视频。

- Large files such as videos and audio to take advantage of the global network

- 大型文件（例如视频和音频），以充分利用全球网络。

## Getting started

## 入门指南

This builds on our existing integrations with database partners like [Supabase](https://vercel.com/integrations/supabase), [PlanetScale](https://vercel.com/integrations/planetscale), and [MongoDB.](https://vercel.com/integrations/mongodbatlas)

该功能建立在我们与数据库合作伙伴（如 [Supabase](https://vercel.com/integrations/supabase)、[PlanetScale](https://vercel.com/integrations/planetscale) 和 [MongoDB](https://vercel.com/integrations/mongodbatlas)）现有的集成基础之上。

Vercel's first-party storage makes it easy for developers to manage their frontend storage needs, without worrying about infrastructure. Hobby and Pro users can [get started](https://vercel.com/docs/storage) with Vercel KV and Vercel Postgres today.

Vercel 自研存储服务让开发者能够轻松管理前端存储需求，无需操心底层基础设施。Hobby 和 Pro 计划用户今日即可 [开始使用](https://vercel.com/docs/storage) Vercel KV 和 Vercel Postgres。

[**Get started with KV**\\
\\
Try Vercel KV with our Next.js starter template.\\
\\
Open template](https://vercel.com/templates/next.js/kv-redis-starter) [**Get started with Postgres**\\
\\
Try Vercel Postgres with our Next.js starter template.\\
\\
Open template](https://vercel.com/templates/next.js/postgres-starter)

[**开始使用 KV**\\
\\
使用我们的 Next.js 入门模板试用 Vercel KV。\\
\\
打开模板](https://vercel.com/templates/next.js/kv-redis-starter) [**开始使用 Postgres**\\
\\
使用我们的 Next.js 入门模板试用 Vercel Postgres。\\
\\
打开模板](https://vercel.com/templates/next.js/postgres-starter)

Vercel Blob is currently in Private Beta and will be rolling out soon, [sign up](https://www.vercel.com/storage/blob) to get early access. Learn more about pricing, limits, and usage in [the documentation](https://www.vercel.com/docs/storage).

Vercel Blob 目前处于私测阶段，即将正式发布，[立即报名](https://www.vercel.com/storage/blob) 获取早期访问权限。有关定价、用量限制及使用详情，请参阅 [官方文档](https://www.vercel.com/docs/storage)。