---
title: "Split-tgz is now the default CLI archive deployment behavior - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/split-tgz-is-now-the-default-cli-archive-deployment-behavior"
date: "2025-02-11"
scraped_at: "2026-03-02T09:36:54.382279330+00:00"
language: "en-zh"
translated: true
description: "Split tgz deployments are now the default option for archive deployments. It should result in better equal or better performance while avoiding many unintuitive limits."
---
&#123;% raw %}

Feb 11, 2025

2025 年 2 月 11 日

Archive deployments are useful for deploying large projects with thousands of files from the CLI.

归档部署（archive deployments）适用于通过命令行界面（CLI）部署包含数千个文件的大型项目。

We [previously released the split-tgz archive deployment](https://vercel.com/changelog/cli-archive-deployments-are-now-up-to-30-faster-with-split-tgz-archive) as a new archive option: `vercel deploy --archive=split-tgz`. This new capability offered up to 30% faster uploads and avoided [file upload size limits](https://vercel.com/docs/limits/overview#static-file-uploads).

我们此前已[发布 split-tgz 归档部署功能](https://vercel.com/changelog/cli-archive-deployments-are-now-up-to-30-faster-with-split-tgz-archive)作为一项新的归档选项：`vercel deploy --archive=split-tgz`。该新功能可使上传速度最高提升 30%，并规避了[静态文件上传大小限制](https://vercel.com/docs/limits/overview#static-file-uploads)。

We’ve confirmed `split-tgz`’s stability and made it the default behavior for `tgz`. This means the separate **`split-tgz`** **option is now deprecated** as the `split-tgz` functionality and benefits power the default `tgz` option.

我们已确认 `split-tgz` 的稳定性，并将其设为 `tgz` 的默认行为。这意味着独立的 **`split-tgz`** **选项现已弃用**，因为 `split-tgz` 的全部功能与优势现已整合进默认的 `tgz` 选项中。

Learn more about [CLI archive deployments](https://vercel.com/docs/cli/deploy#archive).

了解更多关于[CLI 归档部署](https://vercel.com/docs/cli/deploy#archive)的信息。
&#123;% endraw %}
