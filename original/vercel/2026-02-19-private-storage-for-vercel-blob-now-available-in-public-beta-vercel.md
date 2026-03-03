---
title: "Private storage for Vercel Blob, now available in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/private-storage-for-vercel-blob-now-available-in-public-beta"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:28.804141546+00:00"
language: "en"
translated: false
description: "Vercel Blob now supports private storage for user content or sensitive files. Private blobs require authentication for all read operations, ensuring your data cannot be accessed via public URLs and is..."
---




Feb 19, 2026

Vercel Blob now supports private storage for sensitive files like contracts, invoices, and internal reports. Private storage requires authentication for all operations, preventing exposure via public URLs.

Public storage allows public reads for media assets, while private storage requires authentication.

Create a private store via the [Storage dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fstores&title=Vercel+Storage) or with the CLI:

**CLI command**

```bash
vercel blob create-store [name] --access private
```

When created inside a linked Vercel project, the CLI prompts you to connect the store, automatically adding the `BLOB_READ_WRITE_TOKEN` environment variable. The SDK uses this variable to authenticate operations in your deployments.

**SDK installation**

```bash
pnpm add @vercel/blob@2.3
```

To upload, use `put` or `upload` with the `access: 'private'` option.

**Upload example**

upload.ts

```typescript
import { put } from '@vercel/blob';



export async function POST(request: Request) {

4  // Your auth goes here: await authRequest(req)



6  const filename = request.nextUrl.searchParams.get('filename');

7  const blob = await put(filename, request.body, {

8    access: 'private',

9  });



11  return Response.json(blob);

12}
```

To download, use the `get` method to stream files.

**Retrieval example**

retrieve.ts

```typescript
import { get } from '@vercel/blob';



export async function GET(req: Request) {

4  // Your auth goes here: await authRequest(req)



6  const filename = request.nextUrl.searchParams.get('filename');

7  const { stream, blob } = await get(filename, {

8    access: "private",

9  });



11  return new Response(stream, {

12    headers: {

13      "Content-Type": blob.contentType,

14    },

15  });

16}
```

Private storage is in beta on all plans with standard [Vercel Blob pricing](https://vercel.com/docs/storage/vercel-blob/usage-and-pricing).

[Learn more about private storage](https://vercel.com/docs/storage/vercel-blob/private-storage).