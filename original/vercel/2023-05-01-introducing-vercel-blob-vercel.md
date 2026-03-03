---
title: "Introducing Vercel Blob - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-blob"
date: "2023-05-01"
scraped_at: "2026-03-02T09:52:59.376465018+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 1, 2023

![](images/introducing-vercel-blob-vercel/img_001.jpg)![](images/introducing-vercel-blob-vercel/img_002.jpg)

[Vercel Blob](https://vercel.com/storage/blob) is a fast, easy, and efficient solution for storing files in the cloud.

The Vercel Blob API works with any framework. It can be securely called from Edge and Serverless Functions and returns an immutable URL that can be exposed to visitors or put into storage.

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

Vercel Blob is in private beta. Join the [waitlist](https://vercel.com/login?next=%2Fstorage%2Fblob-register) to get early access in the coming weeks.

[Check out our documentation](https://vercel.com/docs/storage/vercel-blob) to learn more.