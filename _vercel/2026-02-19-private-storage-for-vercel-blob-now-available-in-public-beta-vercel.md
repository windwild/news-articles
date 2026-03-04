---
title: "Private storage for Vercel Blob, now available in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/private-storage-for-vercel-blob-now-available-in-public-beta"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:28.804141546+00:00"
language: "en-zh"
translated: true
description: "Vercel Blob now supports private storage for user content or sensitive files. Private blobs require authentication for all read operations, ensuring your data cannot be accessed via public URLs and is..."
---
{% raw %}

Feb 19, 2026

2026 年 2 月 19 日

Vercel Blob 现已支持私有存储，适用于合同、发票和内部报告等敏感文件。私有存储要求对所有操作进行身份验证，从而防止文件通过公开 URL 泄露。

公共存储允许媒体资源被公开读取，而私有存储则要求身份验证。

您可通过 [Storage 控制台](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fstores&title=Vercel+Storage) 或命令行工具（CLI）创建私有存储：

**CLI 命令**

```bash
vercel blob create-store [name] --access private
```

在已关联的 Vercel 项目内创建时，CLI 将提示您连接该存储，并自动添加环境变量 `BLOB_READ_WRITE_TOKEN`。SDK 将使用该变量在您的部署中对操作进行身份验证。

**SDK 安装**

```bash
pnpm add @vercel/blob@2.3
```

上传文件时，请使用 `put` 或 `upload` 方法，并传入 `access: 'private'` 选项。

**Upload example**

**上传示例**

upload.ts

upload.ts

```typescript
import { put } from '@vercel/blob';



export async function POST(request: Request) {

4  // Your auth goes here: await authRequest(req)



6  const filename = request.nextUrl.searchParams.get('filename');

7  const blob = await put(filename, request.body, {

8    access: 'private',
```

9  });



11  return Response.json(blob);

11  return Response.json(blob);

12}
```

12}
```

To download, use the `get` method to stream files.

要下载文件，请使用 `get` 方法来流式传输文件。

**Retrieval example**

**检索示例**

retrieve.ts

retrieve.ts

```typescript
import { get } from '@vercel/blob';



export async function GET(req: Request) {
```

4  // Your auth goes here: await authRequest(req)

4  // 此处添加您的认证逻辑：await authRequest(req)

6  const filename = request.nextUrl.searchParams.get('filename');

6  const filename = request.nextUrl.searchParams.get('filename');

7  const { stream, blob } = await get(filename, {

7  const { stream, blob } = await get(filename, {

8    access: "private",

8    access: "private",

9  });

9  });

11  return new Response(stream, {

11  return new Response(stream, {

12    headers: {

12    headers: {

13      "Content-Type": blob.contentType,

13      "Content-Type": blob.contentType,

14    },

15  });

16}
```

私有存储（Private storage）目前处于测试阶段，所有套餐均支持，按标准的 [Vercel Blob 定价](https://vercel.com/docs/storage/vercel-blob/usage-and-pricing) 收费。

[了解更多关于私有存储的信息](https://vercel.com/docs/storage/vercel-blob/private-storage)。
{% endraw %}
