---
title: "SSH into running Vercel Sandboxes with the CLI - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ssh-into-running-sandboxes-with-the-sandbox-cli"
date: "2026-01-15"
scraped_at: "2026-03-02T09:22:41.712047142+00:00"
language: "en"
translated: false
description: "SSH into running Sandboxes using the Vercel Sandbox CLI. Open secure, interactive shell sessions, with timeouts automatically extended in 5-minute increments for up to 5 hours."
---




Jan 15, 2026

You can now open secure, interactive shell sessions to running Sandboxes with the [Vercel Sandbox CLI](https://vercel.com/docs/vercel-sandbox/cli-reference).

```bash
pnpm i -g sandbox

sandbox login

sandbox create # If you don't have a running Sandbox to SSH into

sandbox ssh <sandbox-id>
```

Note: While you’re connected, the Sandbox timeout is automatically extended in 5-minute increments to help avoid unexpected disconnections, for [up to 5 hours](https://vercel.com/docs/vercel-sandbox/pricing#maximum-runtime-duration).

Learn more in the [Sandbox CLI docs](https://vercel.com/docs/vercel-sandbox/cli-reference#sandbox-ssh).