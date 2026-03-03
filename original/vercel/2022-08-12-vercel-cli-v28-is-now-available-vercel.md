---
title: "Vercel CLI v28 is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-cli-v28"
date: "2022-08-12"
scraped_at: "2026-03-02T10:01:02.946915519+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Aug 12, 2022

![](images/vercel-cli-v28-is-now-available-vercel/img_001.jpg)

Version 28.0.0 of Vercel CLI is now available. Here are some of the key improvements made within the last couple of months:

-  If you have a Git provider repository configured, Vercel CLI will now ask if you want to connect it to your Project during `vercel link` setup. \[ [28.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0)\] ( **Note**: This functionality was reverted in \[ [28.1.4](https://github.com/vercel/vercel/releases/tag/vercel%4028.1.4)\])

- A new command `vercel git` allows you to set up deployments via Git from Vercel CLI. Get started by running `vercel git connect` in a directory with a Git repository. \[ [27.1.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.1.0)\]

- Previously, Vercel CLI deployments did not include Git metadata, even if you had a Git repository set up. Now, Git metadata is sent in deployments created via Vercel CLI. \[ [25.2.0](https://github.com/vercel/vercel/releases/tag/vercel%4025.2.0)\]

- Now, when you run `vercel env pull`, if changes were made to an existing `.env*` file, Vercel CLI will list the variables that were added, changed, and removed. \[ [27.3.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.3.0)\]

- `vercel ls` and `vercel project ls` were visually overhauled, and `vc ls` is now scoped to the currently-linked Project. \[ [28.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0)\]


### Notable changes

- Dropped support for Node.js 12 \[ [25.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4025.0.0)\]

- Removed `vercel billing` command \[ [28.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0)\]

- Removed auto clipboard copying in `vercel deploy` \[ [27.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.0.0)\]

- Deprecated `--confirm` in favor of `--yes` to skip prompts throughout Vercel CLI \[ [27.4.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.4.0)\]

- Added support for Edge Functions in `vercel dev` \[ [25.2.0](https://github.com/vercel/vercel/releases/tag/vercel%4025.2.0)\]

- Added support for importing `.wasm` in `vercel dev` \[ [27.3.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.3.0)\]


Note this batch of updates includes breaking changes. Check out the [full release notes](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0) to learn more.