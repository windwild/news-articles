---
title: "Install Marketplace Integrations from the Vercel CLI - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/install-marketplace-integrations-from-the-vercel-cli"
date: "2024-09-19"
scraped_at: "2026-03-02T09:41:13.475798825+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Sep 19, 2024

![](images/install-marketplace-integrations-from-the-vercel-cli-vercel/img_001.jpg)![](images/install-marketplace-integrations-from-the-vercel-cli-vercel/img_002.jpg)

You can now install integrations from the Vercel Marketplace directly through the Vercel CLI.

The [Vercel Marketplace](https://vercel.com/blog/introducing-the-vercel-marketplace) offers [native integrations](https://vercel.com/docs/integrations#native-integrations) that allow you to use provider products —currently Supabase, Redis, and EdgeDB—directly from the Vercel dashboard without leaving the platform or creating separate accounts.

Running the **`vc i`** command will:

- Install the integration (e.g. **`vc i supabase`** to install Supabase)

- Automatically provision resources as part of the integration installation, as required by the provider products

- Get enhanced error messages in the terminal for troubleshooting of any installation issues


Check out the [documentation](https://vercel.com/docs/cli/install) to learn more.