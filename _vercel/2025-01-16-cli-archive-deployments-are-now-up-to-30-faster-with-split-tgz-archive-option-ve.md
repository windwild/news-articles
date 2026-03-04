---
title: "CLI archive deployments are now up to 30% faster with split-tgz archive option - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/cli-archive-deployments-are-now-up-to-30-faster-with-split-tgz-archive"
date: "2025-01-16"
scraped_at: "2026-03-02T09:37:49.525589080+00:00"
language: "en-zh"
translated: true
description: "Archive CLI uploads now support larger projects with faster upload speeds. Instead of using the old tgz archive option, use the beta split-tgz option."
---
&#123;% raw %}

Jan 16, 2025

2025 年 1 月 16 日

[归档选项（archive option）](https://vercel.com/docs/cli/deploy#archive) 已引入 CLI 部署流程，以应对各类速率限制问题，例如 [单次部署最大文件数量限制](https://vercel.com/docs/limits/overview#files)。[预构建部署（prebuilt deployments）](https://vercel.com/docs/cli/deploy#prebuilt) 通常采用归档上传方式，因其在构建阶段会生成数千个文件。

此前，归档部署始终被压缩为一个大型归档文件，且唯一可用的 `--archive` 选项仅为 `tgz` 格式。使用 `tgz` 的部署可能触及 [静态文件上传大小限制](https://vercel.com/docs/limits/overview#static-file-uploads)；此外，上传单个大型归档文件的速度，也慢于并行上传多个文件分片。

全新的 **Beta 版 `split-tgz` 格式** 通过将大型归档文件拆分为多个较小分片，有效解决了上述问题。**`split-tgz`** 不仅可规避静态文件上传大小限制，还能使大型预构建项目的上传速度**最高提升 30%**。

**使用示例：** **`vercel deploy --archive=split-tgz`**

了解更多关于 [CLI 部署](https://vercel.com/docs/cli/deploy#vercel-deploy) 的信息。
&#123;% endraw %}
