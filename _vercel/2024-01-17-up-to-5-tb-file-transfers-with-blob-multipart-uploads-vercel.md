---
title: "Up to 5 TB file transfers with Blob multipart uploads - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/5tb-file-transfers-with-vercel-blob-multipart-uploads"
date: "2024-01-17"
scraped_at: "2026-03-02T09:48:29.117605007+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Jan 17, 2024

2024 年 1 月 17 日

Vercel Blob 现在支持通过分段上传（multipart uploads）**存储最大达 5 TB 的文件**。

启用 `multipart: true` 后，`put()` 和 `upload()` 方法将逐步读取并分块处理数据，以多个部分分别上传，并在网络异常等问题发生时自动重试。

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

将大型视频文件上传到 Vercel Blob

Network output is maximized without consuming too much memory. Multipart uploads support retrying streams (Node.js streams and the Web Streams API), a unique feature amongst file upload APIs.

网络输出被最大化，同时不会占用过多内存。分段上传支持流式重试（包括 Node.js 流和 Web Streams API），这是当前各类文件上传 API 中独有的功能。

[Check out the documentation](https://vercel.com/docs/storage/vercel-blob/using-blob-sdk#upload) to learn more.

[查看文档](https://vercel.com/docs/storage/vercel-blob/using-blob-sdk#upload) 以了解更多信息。
{% endraw %}
