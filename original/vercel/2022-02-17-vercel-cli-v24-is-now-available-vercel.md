---
title: "Vercel CLI v24 is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-cli-v24"
date: "2022-02-17"
scraped_at: "2026-03-02T10:03:07.727373399+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Feb 17, 2022

![](images/vercel-cli-v24-is-now-available-vercel/img_001.jpg)

Version 24 of the Vercel CLI has been released, including many improvements and bug fixes, as well as the new `vercel bisect` command:

- Added new command `vercel bisect`: Inspired by the `git bisect` command, [this new command](https://vercel.com/docs/cli#commands/bisect) helps identify in which Deployment a bug was introduced.

- Added support for the `--project` flag in `vercel link`.

- Removed support for single file deployments.

- `vercel dev` is now stable (no longer in beta).

- Refactored most of the CLI source code to TypeScript.


**This is a major version bump and includes some breaking changes**, most of which are the final removal of features that have been deprecated for years. [Read the full changelog](https://github.com/vercel/vercel/releases/tag/vercel%4024.0.0) carefully before updating.