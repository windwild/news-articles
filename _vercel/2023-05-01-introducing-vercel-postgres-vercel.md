---
render_with_liquid: false
title: "Introducing Vercel Postgres - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-postgres"
date: "2023-05-01"
scraped_at: "2026-03-02T09:52:57.373331673+00:00"
language: "en-zh"
translated: true
description: "Announcing Postgres storage on Vercel. Connect your projects to native storage solutions. Works with any frontend framework."
---
render_with_liquid: false
render_with_liquid: false

May 1, 2023

2023年5月1日

![](images/introducing-vercel-postgres-vercel/img_001.jpg)![](images/introducing-vercel-postgres-vercel/img_002.jpg)

![](images/introducing-vercel-postgres-vercel/img_001.jpg)![](images/introducing-vercel-postgres-vercel/img_002.jpg)

Update: As of June 9, 2025 Vercel Postgres was replaced with [Vercel Marketplace Storage integrations](https://vercel.com/marketplace/category/storage), featuring automatic account provisioning and unified billing. [Learn more](https://vercel.com/blog/introducing-the-vercel-marketplace).

更新：自2025年6月9日起，Vercel Postgres 已被 [Vercel Marketplace 存储集成](https://vercel.com/marketplace/category/storage) 取代，新方案支持自动账户开通与统一账单管理。[了解详情](https://vercel.com/blog/introducing-the-vercel-marketplace)。

[Vercel Postgres](https://vercel.com/storage/postgres) is a serverless PostgresSQL database, designed to integrate with Vercel Functions and any frontend framework.

[Vercel Postgres](https://vercel.com/storage/postgres) 是一款无服务器（serverless）PostgreSQL 数据库，专为与 Vercel Functions 及任意前端框架无缝集成而设计。

app/page.tsx

app/page.tsx

```tsx
import { sql } from '@vercel/postgres';

import { redirect } from 'next/navigation';



async function create(formData: FormData) {

5  'use server';
```

6  const { rows } = await sql`

7    INSERT INTO products (name)

8    VALUES (${formData.get('name')})

9  `;

6  const { rows } = await sql`

7    INSERT INTO products (name)

8    VALUES (${formData.get('name')})

9  `;

10  redirect(`/product/${rows[0].slug}`);

10  redirect(`/product/${rows[0].slug}`);

11}

11}

export default function Page() {

export default function Page() {

15  return (  

15  return (

16    <form action={create}>

16    `<form action={create}>`

17      <input type="text" name="name" />

17      `<input type="text" name="name" />`

18      <button type="submit">Submit</button>

18      `<button type="submit">提交</button>`

19    </form>

19    `</form>`

20  );

20  );`

21}`

21}`

Use Vercel Postgres with Next.js Server Actions (to be announced Thursday)

在 Next.js Server Actions 中使用 Vercel Postgres（将于周四发布）

Vercel Postgres is available for Hobby and Pro users during the public beta.

在公开测试阶段，Vercel Postgres 面向 Hobby 和 Pro 计划用户开放。

[Check out our documentation](https://vercel.com/docs/postgres) or get started with a template:

[查看我们的文档](https://vercel.com/docs/postgres)，或通过以下模板快速开始：

- [Next.js](https://vercel.com/templates/next.js/postgres-starter)

- [Next.js](https://vercel.com/templates/next.js/postgres-starter)

- [Kysely](https://vercel.com/templates/next.js/postgres-kysely)

- [Kysely](https://vercel.com/templates/next.js/postgres-kysely)

- [Prisma](https://vercel.com/templates/next.js/prisma-postgres)

- [Prisma](https://vercel.com/templates/next.js/prisma-postgres)