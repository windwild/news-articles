---
title: "Stage and manually promote deployments to production - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/stage-and-manually-promote-deployments-to-production"
date: "2023-12-19"
scraped_at: "2026-03-02T09:48:58.114677360+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Dec 19, 2023

![](images/stage-and-manually-promote-deployments-to-production-vercel/img_001.jpg)![](images/stage-and-manually-promote-deployments-to-production-vercel/img_002.jpg)

You can now control when domains are assigned to deployments, enabling the manual promotion of production deployments to serve traffic.

When a new deployment is created (with our [Git Integrations](https://vercel.com/docs/deployments/git), CLI, or [REST API](https://vercel.com/docs/rest-api)), Vercel will automatically apply any custom domains configured for the project.

You can now create staged deployments that do not assign domains, which can later be promoted to production and serve traffic. This is helpful for custom workflows and having multiple production environments for QA or testing.

**From the dashboard**

- Disable the assignment of domains for your production branch in your Git project settings.

- Find your deployment from the list of all deployments and use the right menu to select **Promote to Production**.


**From the CLI**

- `vercel --prod --skip-domain`

- `vercel promote [deployment-id or url]`


[Learn more](https://vercel.com/docs/deployments/managing-deployments#manually-promoting-to-production) in our documentation.