---
title: "Vercel Cron Jobs are now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-cron-jobs-are-now-generally-available"
date: "2023-11-15"
scraped_at: "2026-03-02T09:49:36.275175030+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 15, 2023

![](images/vercel-cron-jobs-are-now-generally-available-vercel/img_001.jpg)![](images/vercel-cron-jobs-are-now-generally-available-vercel/img_002.jpg)

Vercel Cron Jobs let you to run scheduled jobs for things like data backups or archives, triggering updates to third-party APIs, sending email and Slack notifications, or any task you need to run on a schedule.

By using a specific syntax called a [cron expression](https://vercel.com/docs/cron-jobs#cron-expressions), you can define the frequency and timing of each task. Cron Jobs work with any frontend framework and can be defined in `vercel.json`. You can use them to run your [Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions) and [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions).

During the beta, we made Cron Jobs more secure by providing an environment variable with the name [`CRON_SECRET`](https://vercel.com/docs/cron-jobs/manage-cron-jobs#securing-cron-jobs). We also added support for [Deployment Protection](https://vercel.com/docs/security/deployment-protection) and [Instant Rollback](https://vercel.com/docs/deployments/instant-rollback).

Cron Jobs are now **included for customers on all plans**. Per account, users on the Hobby plan will have access to 2 Cron Jobs, users on the Pro plan will have access to 40 Cron Jobs, and users on the Enterprise plan will have access to 100 Cron Jobs.

Check out our [documentation](https://vercel.com/docs/cron-jobs) or [deploy an example with Cron Jobs](https://vercel.com/templates/next.js/vercel-cron).