---
title: "Deployment integration actions for Marketplace integrations - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deployment-integration-actions-for-marketplace-integrations"
date: "2025-02-19"
scraped_at: "2026-03-02T09:36:38.771247883+00:00"
language: "en"
translated: false
description: "Deployment integration actions are now available for Marketplace integrations giving providers more control over deployment workflows. "
---




Feb 19, 2025

![](images/deployment-integration-actions-for-marketplace-integrations-vercel/img_001.jpg)![](images/deployment-integration-actions-for-marketplace-integrations-vercel/img_002.jpg)

[Marketplace](https://vercel.com/marketplace) integration providers can now register integration actions for deployments, allowing for automated resource-side tasks such as database branching, environment variable overrides, and readiness checks.

When a user deploys a project that has connected Marketplace integration with configured actions, the deployment will pause and wait for all integration actions to complete successfully. This ensures that the deployed resources are properly set up before the deployment proceeds. Users will also receive helpful suggestions within the integration about which actions are available and should be executed.

Learn more about [integration actions](https://vercel.com/docs/integrations/create-integration/deployment-integration-action).