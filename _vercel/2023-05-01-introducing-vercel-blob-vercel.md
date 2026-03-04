---
title: "Introducing Vercel Blob - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-blob"
date: "2023-05-01"
scraped_at: "2026-03-02T09:52:59.376465018+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
May 1, 2023

2023年5月1日

![](images/introducing-vercel-blob-vercel/img_001.jpg)![](images/introducing-vercel-blob-vercel/img_002.jpg)

[Vercel Blob](https://vercel.com/storage/blob) 是一种快速、简单且高效的云文件存储解决方案。

Vercel Blob API 可与任意框架配合使用。它可安全地从边缘函数（Edge Functions）和无服务器函数（Serverless Functions）调用，并返回一个不可变的 URL，该 URL 可直接向访客公开，也可存入其他存储系统中。

app/profile/route.ts

```tsx
import { put } from '@vercel/blob';



export async function PUT(request: Request) {

4  const form = await request.formData();

5  const file = form.get('file') as File;
```

6  const blob = await put('avatars/user-42.png', file, { access: 'public' });



8  return Response.json(blob);

9}
```

Vercel Blob 目前处于私测阶段。请加入[等候名单](https://vercel.com/login?next=%2Fstorage%2Fblob-register)，在未来几周内获得早期访问权限。

[查看我们的文档](https://vercel.com/docs/storage/vercel-blob)以了解更多信息。