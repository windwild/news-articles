---
title: "Introducing Vercel Postgres - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-postgres"
date: "2023-05-01"
scraped_at: "2026-03-02T09:52:57.373331673+00:00"
language: "en"
translated: false
description: "Announcing Postgres storage on Vercel. Connect your projects to native storage solutions. Works with any frontend framework."
---




May 1, 2023

![](images/introducing-vercel-postgres-vercel/img_001.jpg)![](images/introducing-vercel-postgres-vercel/img_002.jpg)

Update: As of June 9, 2025 Vercel Postgres was replaced with [Vercel Marketplace Storage integrations](https://vercel.com/marketplace/category/storage), featuring automatic account provisioning and unified billing. [Learn more](https://vercel.com/blog/introducing-the-vercel-marketplace).

[Vercel Postgres](https://vercel.com/storage/postgres) is a serverless PostgresSQL database, designed to integrate with Vercel Functions and any frontend framework.

app/page.tsx

```tsx
import { sql } from '@vercel/postgres';

import { redirect } from 'next/navigation';



async function create(formData: FormData) {

5  'use server';

6  const { rows } = await sql`

7    INSERT INTO products (name)

8    VALUES (${formData.get('name')})

9  `;

10  redirect(`/product/${rows[0].slug}`);

11}





export default function Page() {

15  return (

16    <form action={create}>

17      <input type="text" name="name" />

18      <button type="submit">Submit</button>

19    </form>

20  );

21}
```

Use Vercel Postgres with Next.js Server Actions (to be announced Thursday)

Vercel Postgres is available for Hobby and Pro users during the public beta.

[Check out our documentation](https://vercel.com/docs/postgres) or get started with a template:

- [Next.js](https://vercel.com/templates/next.js/postgres-starter)

- [Kysely](https://vercel.com/templates/next.js/postgres-kysely)

- [Prisma](https://vercel.com/templates/next.js/prisma-postgres)