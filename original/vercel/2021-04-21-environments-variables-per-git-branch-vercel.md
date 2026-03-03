---
title: "Environments Variables per Git branch - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/environments-variables-per-git-branch"
date: "2021-04-21"
scraped_at: "2026-03-02T10:05:23.854355685+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Apr 21, 2021

![](images/environments-variables-per-git-branch-vercel/img_001.jpg)

You can now add Environment Variables to a specific **Git branch** in the Preview Environment.

When you push to a branch, a combination of Preview Environment Variables and branch-specific variables will be used. Branch-specific variables will override other variables with the same name. This means you don't need to replicate all your existing Preview Environment Variables for each branch – you only need to add the values you wish to override.

Also, you no longer need to specify the type of Environment Variable ( _Plaintext_, _Secret_, _Provided by System_) because **all values are now encrypted**. The new design is optimized for both security and convenience, ensuring you can easily view the value later by editing in the UI or running `vercel env pull` to fetch Development Environment Variables locally.

We previously introduced the _Provided by System_ option as some frameworks need to map system variables like `VERCEL_URL` to framework prefixed variables like `NEXT_PUBLIC_VERCEL_URL`. You no longer need to configure this mapping because the **prefixed variables are added automatically** based on your Framework Preset.

Check out [the documentation](https://vercel.com/docs/environment-variables) as well.