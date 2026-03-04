---
title: "Vercel Blob now supports file upload progress - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-blob-now-supports-file-upload-progress"
date: "2024-11-20"
scraped_at: "2026-03-02T09:39:12.252147732+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Nov 20, 2024

2024 年 11 月 20 日

![](images/vercel-blob-now-supports-file-upload-progress-vercel/img_001.jpg)![](images/vercel-blob-now-supports-file-upload-progress-vercel/img_002.jpg)

Vercel Blob 现在支持跟踪文件上传进度，从而在用户上传文件时提供更佳的体验。

借助最新版 [`@vercel/blob`](https://vercel.com/docs/storage/vercel-blob/using-blob-sdk) 包，您可使用新增的 `onUploadProgress` 回调函数，在文件上传过程中实时显示进度。此外，在 Vercel 控制台（Dashboard）中，您也能直观查看各文件的上传进度。

```jsx
1"use client";

import { upload } from '@vercel/blob/client';

import { useState } from 'react';



export function Uploader() {

6  const [progress, setProgress] = useState(0);
```

8  return  (

8  返回  (

9    <form onSubmit={(e) => {

9    <form onSubmit={(e) => {

10      e.preventDefault();

10      e.preventDefault();

11      const file = e.currentTarget.files[0];

11      const file = e.currentTarget.files[0];

12      await upload(file.name, file, {

12      await upload(file.name, file, {

13        access: 'public',

13        access: 'public',

14        handleUploadUrl: '/api/upload',

14        handleUploadUrl: '/api/upload',

15        onUploadProgress(e) {

15        onUploadProgress(e) {

16          setProgress(e.percentage);

16          setProgress(e.percentage);

17        }

18      });

19    }}>

19    }}>

20      <input type="file" required />

20      <input type="file" required />

21      Upload progress: <progress value={progress} max={100} />

21      上传进度：<progress value={progress} max={100} />

22    </form>

22    </form>

23  );

23  );

24}
```

24}
```

[Try it out](https://vercel.com/dashboard/stores) or [learn more about Vercel Blob](https://vercel.com/docs/storage/vercel-blob).

[立即试用](https://vercel.com/dashboard/stores)，或[了解有关 Vercel Blob 的更多信息](https://vercel.com/docs/storage/vercel-blob)。