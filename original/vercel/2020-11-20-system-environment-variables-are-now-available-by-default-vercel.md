---
title: "System Environment Variables are now available by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/system-environment-variables-are-now-available-by-default"
date: "2020-11-20"
scraped_at: "2026-03-02T10:06:24.238392243+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 20, 2020

![](images/system-environment-variables-are-now-available-by-default-vercel/img_001.jpg)

Previously, consuming values provided by the Vercel platform in your Environment Variables (like the URL of your Deployment) required adding System Environment Variables using the "Environment Variables" page in the Project Settings.

All new Projects created as of today, however, will automatically receive all System Environment Variables by default – without you having to expose them explicitly.

This setting can also be controlled from existing Projects, which means that you can easily opt into the new behavior for those as well.

Furthermore, the available System Environment Variables were revamped to have much more straightforward names and don't differentiate between Git providers anymore. For example, you can now use `VERCEL_GIT_COMMIT_REF` to retrieve the Git commit SHA for GitHub, GitLab and Bitbucket instead of having to use several different System Environment Variables for that.

Check out [the documentation](https://vercel.com/docs/environment-variables#system-environment-variables) as well.