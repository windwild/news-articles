---
title: "Optionally disable deployment_status webhook events for GitHub Actions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/optionally-disable-deployment_status-webhook-events-for-github-actions"
date: "2025-05-01"
scraped_at: "2026-03-02T09:34:15.946674721+00:00"
language: "en"
translated: false
description: "You can now disable webhook events that Vercel sends to GitHub Actions that create many notifications on GitHub pull requests."
---




May 1, 2025

![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_001.jpg)![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_002.jpg)

You can now disable the [`deployment_status` webhook event](https://docs.github.com/en/webhooks/webhook-events-and-payloads#deployment_status) that Vercel sends to GitHub when Vercel is connected to your GitHub repository.

When `deployment_status` events are enabled, GitHub's pull request activity will create a log with a status event for every deployment. While this can keep your team better informed, it can also create noisy event logs for repositories with many deployment events, especially in monorepos with many projects.

![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_003.jpg)![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_004.jpg)

Disabling these events prevents repeated messages from cluttering your GitHub PR's event history, giving you a cleaner, more focused view of your pull request activity. The Vercel Github comment containing links to your preview deployments will continue to be posted as before.

![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_005.jpg)![](images/optionally-disable-deployment_status-webhook-events-for-github-actions-vercel/img_006.jpg)

The [`deployment_status` event](https://docs.github.com/en/rest/deployments/deployments?apiVersion=2022-11-28) is most often used as a trigger for GitHub Actions. We recommend [migrating to `repository_dispatch` events](https://vercel.com/docs/git/vercel-for-github#migrating-from-deployment_status) to simply workflows with richer Vercel deployment information.

[Learn more in the documentation](https://vercel.com/docs/git/vercel-for-github#silence-deployment-notifications-on-pull-requests).