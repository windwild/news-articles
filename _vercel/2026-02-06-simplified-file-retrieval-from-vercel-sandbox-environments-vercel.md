---
title: "Simplified file retrieval from Vercel Sandbox environments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/simplified-file-retrieval-from-vercel-sandbox-environments"
date: "2026-02-06"
scraped_at: "2026-03-02T09:21:35.754950192+00:00"
language: "en-zh"
translated: true
description: "Easier file downloads from the Vercel sandbox with new download and read methods added to the sandbox sdk"
---
{% raw %}

Feb 6, 2026

2026 年 2 月 6 日

The [Vercel Sandbox SDK](https://www.npmjs.com/package/@vercel/sandbox) now includes two new methods that make file retrieval simple.

[Vercel Sandbox SDK](https://www.npmjs.com/package/@vercel/sandbox) 现已新增两个方法，让文件获取变得轻而易举。

When you run code in a [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox), that code can generate files like a CSV report, a processed image, or a PDF invoice. These files are created inside isolated VMs, so they need to be retrieved across a network boundary. Until now, this required manual stream handling with custom piping.

当你在 [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 中运行代码时，该代码可生成诸如 CSV 报表、处理后的图像或 PDF 发票等文件。这些文件创建于相互隔离的虚拟机（VM）中，因此需跨越网络边界将其取回。此前，这需要手动处理流并借助自定义管道（piping）实现。

### Download a file

### 下载文件

If you want to download a generated report from your sandbox to your local machine, you can use `downloadFile()` to seamlessly stream the contents.

若要将沙盒中生成的报表下载至本地计算机，可使用 `downloadFile()` 方法无缝流式传输其内容。

```typescript
const dstPath = await sandbox.downloadFile(

2  { path: 'generated-file.csv', cwd: '/vercel/sandbox' },

3  { path: 'generated-file.csv', cwd: '/tmp' }

4);
```

### Read file contents to buffer

### 将文件内容读取为缓冲区（Buffer）

Both methods handle the underlying stream operations automatically. For example, if your sandbox runs a script that generates a chart as a PNG, you can pull it out with a single call to `readFileToBuffer()`, no manual stream wiring needed.

两种方法均会自动处理底层的流操作。例如，如果您的沙箱运行一个脚本并生成一张 PNG 格式的图表，您只需调用一次 `readFileToBuffer()` 即可将其读取出来，无需手动配置流。

```typescript
1​const buffer = await sandbox.readFileToBuffer({ path: 'chart.png' });​
```

```typescript
1​const buffer = await sandbox.readFileToBuffer({ path: 'chart.png' });​
```

Learn more about the [Sandbox SDK](https://www.npmjs.com/package/@vercel/sandbox) or explore the updated [documentation](https://vercel.com/docs/vercel-sandbox/sdk-reference#sandbox.downloadfile).

了解更多关于 [Sandbox SDK](https://www.npmjs.com/package/@vercel/sandbox) 的信息，或查阅更新后的 [文档](https://vercel.com/docs/vercel-sandbox/sdk-reference#sandbox.downloadfile)。
{% endraw %}
