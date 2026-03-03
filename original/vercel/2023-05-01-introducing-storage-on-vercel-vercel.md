---
title: "Introducing storage on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-storage"
date: "2023-05-01"
scraped_at: "2026-03-02T09:52:58.480867689+00:00"
language: "en"
translated: false
description: "New to the Vercel dashboard: Vercel KV, Vercel Postgres, and Vercel Blob. Announcing serverless storage solutions available on Vercel."
---




May 1, 2023

Vercel KV, Vercel Postgres, Vercel Blob, and Vercel Edge Config are now available.

Data is an integral part of the web. As JavaScript and TypeScript frameworks make it easier than ever to server-render just-in-time data, it's time to make databases a first-class part of Vercel's frontend cloud.

The Vercel KV and Vercel Postgres products have been sunset. You can now deploy alternative storage solutions for [KV](https://vercel.com/marketplace?search=kv) and [Postgres](https://vercel.com/marketplace?search=postgres) through the [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage), with automatic account provisioning and unified billing.

Today, we’re excited to announce a suite of serverless [storage](https://vercel.com/storage) solutions now available on Vercel, powered by some of the best infrastructure providers in the industry.

- [Vercel KV](https://vercel.com/blog/vercel-storage#vercel-kv-a-durable-redis-database): A serverless Redis solution that's easy and durable, powered by Upstash

- [Vercel Postgres](https://vercel.com/blog/vercel-storage#vercel-postgres-complex-data-made-easy): A serverless SQL database built for the frontend, powered by Neon

- [Vercel Blob](https://vercel.com/blog/vercel-storage#vercel-blob-easy-file-storage-at-the-edge): A solution to upload and serve files at the edge


![](images/introducing-storage-on-vercel-vercel/img_001.jpg)![](images/introducing-storage-on-vercel-vercel/img_002.jpg)

### Why now?

Driven by the need for both performance and personalization, frameworks are becoming server-first and edge-first. This shift is exemplified by React Server Components and the introduction of streaming infrastructure into our runtimes. These capabilities make it easier than ever to fetch data from a database or other data sources, within the server component itself.

Simultaneously, as the world moves away from monolithic architectures to composable ones, there's [no shortage of options](https://vercel.com/integrations#databases) for backends and databases. But for new projects, the choice can still be paralyzing.

In the spirit of being the end-to-end solution for building on the web, we are introducing solutions that are open, easy to use, and scale as efficiently as our frontends.

## Vercel KV: A durable Redis database

A key-value store like Redis is one of the most common tools developers reach for when managing things like rate-limiting, session management, or application state.

Today, we're introducing Vercel KV, a serverless, Redis-compatible, easy-to-use, and highly _durable_ database. Vercel KV enables you to create Redis-compatible databases that can be written to and read from Vercel's Edge Network in regions you specify, with little configuration needed.

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

We’ve partnered with [Upstash](https://upstash.com/) to deliver tooling designed to **embrace** serverless, that persists in memory _and_ on disk by default. This means it can be used to persist state, without risk of losing your data when a server crashes.

## Vercel Postgres: Complex data made easy

PostgreSQL is the preferred way of handling relational data for many developers. We’ve partnered with [Neon](https://neon.tech/) to introduce Vercel Postgres, the first serverless SQL database built for the frontend cloud.

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

With Vercel Postgres, you get a fully managed, highly scalable, fault-tolerant database that delivers high performance and low latency for your web applications. Vercel Postgres is designed to work seamlessly with the Next.js App Router and Server Components and other frameworks like Nuxt and SvelteKit, making it easy to fetch data from your Postgres database to render dynamic content on the server at the speed of static.

You can use Vercel Postgres to query, insert, update, or delete data directly inside your React Server Components, providing you with powerful server-first data mutations and less client-side JavaScript.

## Vercel Blob: Easy file storage at the edge

Vercel Blob is a fast, easy, and efficient solution for storing files in the cloud. It provides an effortless yet powerful storage API built entirely on top of web standards without the need to configure buckets or implement heavy SDKs.

app/profile/route.ts

```tsx
import { put } from '@vercel/blob';



export async function PUT(request: Request) {

4  const form = await request.formData();

5  const file = form.get('file') as File;

6  const blob = await put('avatars/user-42.png', file, { access: 'public' });



8  return Response.json(blob);

9}
```

Vercel Blob can store files like images, PDFs, CSVs,or other unstructured data. Use Vercel Blob for:

- Files you normally store in an external file storage solution like Amazon S3. With your project hosted on Vercel, you can readily access and manage these files via Vercel Blob

- Files that are programmatically uploaded or generated at build time, for display and download such as avatars, screenshots, cover images and videos

- Large files such as videos and audio to take advantage of the global network


## Getting started

This builds on our existing integrations with database partners like [Supabase](https://vercel.com/integrations/supabase), [PlanetScale](https://vercel.com/integrations/planetscale), and [MongoDB.](https://vercel.com/integrations/mongodbatlas)

Vercel's first-party storage makes it easy for developers to manage their frontend storage needs, without worrying about infrastructure. Hobby and Pro users can [get started](https://vercel.com/docs/storage) with Vercel KV and Vercel Postgres today.

[**Get started with KV**\\
\\
Try Vercel KV with our Next.js starter template.\\
\\
Open template](https://vercel.com/templates/next.js/kv-redis-starter) [**Get started with Postgres**\\
\\
Try Vercel Postgres with our Next.js starter template.\\
\\
Open template](https://vercel.com/templates/next.js/postgres-starter)

Vercel Blob is currently in Private Beta and will be rolling out soon, [sign up](https://www.vercel.com/storage/blob) to get early access. Learn more about pricing, limits, and usage in [the documentation](https://www.vercel.com/docs/storage).