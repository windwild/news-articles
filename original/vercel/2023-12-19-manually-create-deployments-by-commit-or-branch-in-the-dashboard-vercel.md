---
title: "Manually create deployments by commit or branch in the dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/manually-create-deployments-by-commit-or-branch-in-the-dashboard"
date: "2023-12-19"
scraped_at: "2026-03-02T09:49:00.349191814+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Dec 19, 2023

![](images/manually-create-deployments-by-commit-or-branch-in-the-dashboard-vercel/img_001.jpg)![](images/manually-create-deployments-by-commit-or-branch-in-the-dashboard-vercel/img_002.jpg)

You can now initiate new deployments directly from the dashboard using a git reference. This approach is helpful when git providers have service interruptions with webhook delivery.

To create a deployment from a git branch or SHA:

1. From the dashboard, select the project you'd like to create a deployment for.

2. Select the **Deployments** tab. Once on the Deployments page, select the **Create Deployment** button in the three dots to the right of the **Deployments** header.


Depending on how you would like to deploy, enter the following:

1. **Targeted Deployments:** Provide the unique ID (SHA) of a commit to build a deployment based on that specific commit.

2. **Branch-Based Deployments:** Provide the full name of a branch when you want to build the most recent changes from that specific branch.


Finally, select **Create Deployment** and Vercel will build and deploy your commit or branch.

When the same commit appears in multiple branches, Vercel will prompt you to choose the appropriate branch configuration. This choice is crucial as it affects settings like environment variables linked to each branch.

[Learn more](https://vercel.com/docs/deployments/git#creating-a-deployment-from-a-git-reference) in our documentation.