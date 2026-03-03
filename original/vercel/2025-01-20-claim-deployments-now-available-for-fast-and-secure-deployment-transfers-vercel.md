---
title: "Claim Deployments now available for fast and secure deployment transfers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claim-deployments"
date: "2025-01-20"
scraped_at: "2026-03-02T09:37:37.323824046+00:00"
language: "en"
translated: false
description: "With Claim Deployments, third-party platforms, including AI agents and visual builder applications, can now hand off deployment ownership."
---




Jan 20, 2025

![Claim Deployment - Dark](images/claim-deployments-now-available-for-fast-and-secure-deployment-transfers-vercel/img_001.jpg)![Claim Deployment - Dark](images/claim-deployments-now-available-for-fast-and-secure-deployment-transfers-vercel/img_002.jpg)

[Multi-tenant platforms](https://vercel.com/solutions/multi-tenant-saas), like AI agents and visual building apps, can now easily transfer deployment ownership directly to users or teams.

**How it works:**

- **Deployment creation:** Any third-party can create a new deployment [using the Vercel CLI](https://vercel.com/docs/cli/deploying-from-cli) or using the Vercel API: [POST /files](https://vercel.com/docs/rest-api/endpoints/deployments#upload-deployment-files) and [POST /deployments](https://vercel.com/docs/rest-api/endpoints/deployments#create-a-new-deployment)

- **Initiate transfer:** The Vercel API endpoint is then used to generate a `claim-deployment` URL for that deployment.

- **User confirms their team:** The user selects their Vercel team and completes the transfer.


[Check out our documentation](https://vercel.com/docs/deployments/claim-deployments) to learn more.