---
title: "Up to 5 TB file transfers with Blob multipart uploads - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/5tb-file-transfers-with-vercel-blob-multipart-uploads"
date: "2024-01-17"
scraped_at: "2026-03-02T09:48:29.117605007+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 17, 2024

Vercel Blob now supports **storing files up to 5 TB** with multipart uploads.

When using `multipart: true`,`put()`and `upload()` will progressively read and chunk data, upload it in parts, and retry if there are issues.

upload.js

```javascript
import { upload } from '@vercel/blob/client';



const blob = await upload('big-file.mp4', file, {

4  access: 'public',

5  handleUploadUrl: '/api/upload',

6  multipart: true // 🚀

7});
```

Uploading a big video file to Vercel Blob

Network output is maximized without consuming too much memory. Multipart uploads support retrying streams (Node.js streams and the Web Streams API), a unique feature amongst file upload APIs.

[Check out the documentation](https://vercel.com/docs/storage/vercel-blob/using-blob-sdk#upload) to learn more.