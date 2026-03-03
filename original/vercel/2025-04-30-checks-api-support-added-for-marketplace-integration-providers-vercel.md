---
title: "Checks API support added for Marketplace integration providers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/checks-api-support-added-for-marketplace-integration-providers"
date: "2025-04-30"
scraped_at: "2026-03-02T09:34:06.876589077+00:00"
language: "en"
translated: false
description: "Vercel Marketplace now supports the Checks API, enabling providers to deliver automated post-deployment tests and surface results directly in the dashboard. Improve developer experience with seamless ..."
---




Apr 30, 2025

![](images/checks-api-support-added-for-marketplace-integration-providers-vercel/img_001.jpg)![](images/checks-api-support-added-for-marketplace-integration-providers-vercel/img_002.jpg)

Providers building native integrations for the [Vercel Marketplace](https://vercel.com/marketplace) can now use the [Checks API](https://vercel.com/docs/checks) to deliver deeper functionality for their users.

With Vercel's Checks API, you can define and run custom tests and assertions after every deployment, then surface actionable results directly in the Vercel dashboard.

As a testing provider, you can implement checks such as reliability tests (e.g. API availability, runtime errors), performance tests (e.g. response time thresholds, load simulation), or Web Vitals (e.g. layout shift). This helps developers catch real-world issues earlier in their workflow, powered by your integration.

When building your integration, keep these best practices in mind:

- Offer minimal or no-configuration solutions so developers can easily run checks

- Provide a guided onboarding experience from installation to first results

- Display clear, actionable outcomes directly in the Vercel dashboard

- Document ways to extend or customize checks for advanced users


Learn more in the [Checks API documentation](https://vercel.com/docs/checks).