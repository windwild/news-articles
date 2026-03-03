---
title: "Simplified file retrieval from Vercel Sandbox environments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/simplified-file-retrieval-from-vercel-sandbox-environments"
date: "2026-02-06"
scraped_at: "2026-03-02T09:21:35.754950192+00:00"
language: "en"
translated: false
description: "Easier file downloads from the Vercel sandbox with new download and read methods added to the sandbox sdk"
---




Feb 6, 2026

The [Vercel Sandbox SDK](https://www.npmjs.com/package/@vercel/sandbox) now includes two new methods that make file retrieval simple.

When you run code in a [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox), that code can generate files like a CSV report, a processed image, or a PDF invoice. These files are created inside isolated VMs, so they need to be retrieved across a network boundary. Until now, this required manual stream handling with custom piping.

### Download a file

If you want to download a generated report from your sandbox to your local machine, you can use `downloadFile()` to seamlessly stream the contents.

```typescript
const dstPath = await sandbox.downloadFile(

2  { path: 'generated-file.csv', cwd: '/vercel/sandbox' },

3  { path: 'generated-file.csv', cwd: '/tmp' }

4);
```

### Read file contents to buffer

Both methods handle the underlying stream operations automatically. For example, if your sandbox runs a script that generates a chart as a PNG, you can pull it out with a single call to `readFileToBuffer()`, no manual stream wiring needed.

```typescript
1​const buffer = await sandbox.readFileToBuffer({ path: 'chart.png' });​
```

Learn more about the [Sandbox SDK](https://www.npmjs.com/package/@vercel/sandbox) or explore the updated [documentation](https://vercel.com/docs/vercel-sandbox/sdk-reference#sandbox.downloadfile).