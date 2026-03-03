---
title: "Improvements to command line logs - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improvements-to-command-line-logs"
date: "2024-07-24"
scraped_at: "2026-03-02T09:43:33.439087308+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 24, 2024

![](images/improvements-to-command-line-logs-vercel/img_001.jpg)![](images/improvements-to-command-line-logs-vercel/img_002.jpg)

Vercel CLI v35 introduces new commands to access of deployment and runtime logs:

- `vercel deploy --logs` deploys and shows [build logs](https://vercel.com/docs/cli/deploy)

- `vercel inspect --logs` shows [build logs](https://vercel.com/docs/cli/inspect) for an existing deployment

- `vercel logs` now follows [runtime logs](https://vercel.com/docs/cli/logs) of an existing deployment


You can now use the `--json` option to stream logs as JSON. This makes it easier to parse and filter logs using tools like [jq](https://jqlang.github.io/jq/).

```bash
vercel logs --json | jq 'select(.level == "warning")'
```

Using the Vercel CLI with jq to filter for warning logs

To use these features, update to the latest version of the Vercel CLI:

```bash
pnpm add -g vercel
```

Install the Vercel CLI globally using the pnpm package manager.