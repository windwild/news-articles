---
title: "Split-tgz is now the default CLI archive deployment behavior - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/split-tgz-is-now-the-default-cli-archive-deployment-behavior"
date: "2025-02-11"
scraped_at: "2026-03-02T09:36:54.382279330+00:00"
language: "en"
translated: false
description: "Split tgz deployments are now the default option for archive deployments. It should result in better equal or better performance while avoiding many unintuitive limits."
---




Feb 11, 2025

Archive deployments are useful for deploying large projects with thousands of files from the CLI.

We [previously released the split-tgz archive deployment](https://vercel.com/changelog/cli-archive-deployments-are-now-up-to-30-faster-with-split-tgz-archive) as a new archive option: `vercel deploy --archive=split-tgz`. This new capability offered up to 30% faster uploads and avoided [file upload size limits](https://vercel.com/docs/limits/overview#static-file-uploads).

We’ve confirmed `split-tgz`’s stability and made it the default behavior for `tgz`. This means the separate **`split-tgz`** **option is now deprecated** as the `split-tgz` functionality and benefits power the default `tgz` option.

Learn more about [CLI archive deployments](https://vercel.com/docs/cli/deploy#archive).