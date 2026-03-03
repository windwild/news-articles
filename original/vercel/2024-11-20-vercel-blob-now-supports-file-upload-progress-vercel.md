---
title: "Vercel Blob now supports file upload progress - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-blob-now-supports-file-upload-progress"
date: "2024-11-20"
scraped_at: "2026-03-02T09:39:12.252147732+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 20, 2024

![](images/vercel-blob-now-supports-file-upload-progress-vercel/img_001.jpg)![](images/vercel-blob-now-supports-file-upload-progress-vercel/img_002.jpg)

Vercel Blob can now track file upload progress, enabling for a better user experience when uploading files.

With the latest [`@vercel/blob`](https://vercel.com/docs/storage/vercel-blob/using-blob-sdk) package, you can use the new `onUploadProgress` callback to display progress during file uploads. In the Dashboard, you'll also see the upload progress for your files.

```jsx
1"use client";

import { upload } from '@vercel/blob/client';

import { useState } from 'react';



export function Uploader() {

6  const [progress, setProgress] = useState(0);



8  return  (

9    <form onSubmit={(e) => {

10      e.preventDefault();

11      const file = e.currentTarget.files[0];

12      await upload(file.name, file, {

13        access: 'public',

14        handleUploadUrl: '/api/upload',

15        onUploadProgress(e) {

16          setProgress(e.percentage);

17        }

18      });

19    }}>

20      <input type="file" required />

21      Upload progress: <progress value={progress} max={100} />

22    </form>

23  );

24}
```

[Try it out](https://vercel.com/dashboard/stores) or [learn more about Vercel Blob](https://vercel.com/docs/storage/vercel-blob).