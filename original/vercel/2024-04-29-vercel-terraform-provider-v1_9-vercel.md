---
title: "Vercel Terraform Provider v1.9 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-terraform-provider-v1-9"
date: "2024-04-29"
scraped_at: "2026-03-02T09:45:28.563071617+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Apr 29, 2024

The [Vercel Terraform Provider](https://registry.terraform.io/providers/vercel/vercel/latest/docs) allows you to create, manage and update your Vercel projects, configuration, and settings through infrastructure-as-code.

You can now control significantly more Vercel resources through Terraform:

- Control whether custom production domains are automatically assigned

- Enable and disable [Git LFS](https://vercel.com/changelog/git-lfs-support) on a project

- Configure [Automatic Function Failover](https://vercel.com/changelog/improved-resiliency-for-vercel-functions-with-failover-support)

- Allow the [prioritization of production builds](https://vercel.com/docs/deployments/concurrent-builds#prioritize-production-builds) over preview builds

- Configure [Skew Protection](https://vercel.com/docs/deployments/skew-protection)

- Create and manage [Deploy Hooks](https://vercel.com/docs/deployments/deploy-hooks)

- Enable and disable [Comments](https://vercel.com/docs/workflow-collaboration/comments) on preview deployments

- Enable and disable [Git Comments](https://vercel.com/guides/how-to-prevent-vercel-github-comments) for a project

- Set up and manage [Configurable Log Drains](https://vercel.com/guides/how-to-prevent-vercel-github-comments)

- Create and manage [Account Webhooks](https://vercel.com/docs/observability/webhooks-overview#account-webhooks)

- Configure [Edge Config](https://vercel.com/docs/storage/edge-config) stores, schemas and access tokens.


Learn how to get started with the [Terraform provider for Vercel](https://vercel.com/guides/integrating-terraform-with-vercel). If you already have Terraform set up, upgrade by running:

Bash

```bash
terraform init -upgrade
```