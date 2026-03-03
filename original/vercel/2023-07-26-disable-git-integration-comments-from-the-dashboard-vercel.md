---
title: "Disable Git Integration comments from the dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/disable-git-integration-comments"
date: "2023-07-26"
scraped_at: "2026-03-02T09:51:30.087199341+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 26, 2023

![](images/disable-git-integration-comments-from-the-dashboard-vercel/img_001.jpg)![](images/disable-git-integration-comments-from-the-dashboard-vercel/img_002.jpg)

We've added new options to the " [Connected Git Repository](https://vercel.com/docs/concepts/deployments/git/vercel-for-github#silence-github-comments)" settings in the [Vercel dashboard](https://vercel.com/docs/concepts/dashboard-features). It's now possible to configure whether the Vercel bot comments on:

- Pull Requests

- Production Commits


These settings are available for all connected repositories, not just GitHub repositories.

Previously, there was a `github.silent` setting available in `vercel.json` that didn't allow more granular control over disabling comments. **We will be deprecating that option on Monday, September 25, 2023.** There is no action required at this time to prepare for deprecation. Until that date, if you set that option in your `vercel.json` file we will continue to read it, and update the configuration in the dashboard accordingly.